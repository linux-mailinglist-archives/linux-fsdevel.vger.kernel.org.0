Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2F141FFA26
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jun 2020 19:27:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732113AbgFRR1M (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Jun 2020 13:27:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:45190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732048AbgFRR1L (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Jun 2020 13:27:11 -0400
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1E40920890;
        Thu, 18 Jun 2020 17:27:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592501231;
        bh=TjmLKSO1Nhc9L5WT6Ph5Sftq66DD91glxmgDoaZe2V4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PV1iFkiuyMiFLgJcbVe34Dxn0Lkw+nIq+CFntgs3Fcb6w9OHUzPGaZw7NBu9hYGcV
         pAgyRbAqaANA+PQv0sDqz5p5ny107XWdY0G1bCAtAdkYgKHsXrWpB7tMlHWF9dDhAL
         n4vfoLPY2D89AQJgkxgqnnOOUXeY8urS/s3azF0U=
Date:   Thu, 18 Jun 2020 10:27:09 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Satya Tangirala <satyat@google.com>
Cc:     linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org
Subject: Re: [PATCH 0/4] Inline Encryption Support for fscrypt
Message-ID: <20200618172709.GA2957@sol.localdomain>
References: <20200617075732.213198-1-satyat@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200617075732.213198-1-satyat@google.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 17, 2020 at 07:57:28AM +0000, Satya Tangirala wrote:
> This patch series adds support for Inline Encryption to fscrypt, f2fs
> and ext4. It builds on the inline encryption support now present in
> the block layer, and has been rebased on v5.8-rc1.
> 
> Patch 1 introduces the SB_INLINECRYPT sb options, which filesystems
> should set if they want to use blk-crypto for file content en/decryption.
> 
> Patch 2 adds inline encryption support to fscrypt. To use inline
> encryption with fscrypt, the filesystem must set the above mentioned
> SB_INLINECRYPT sb option. When this option is set, the contents of
> encrypted files will be en/decrypted using blk-crypto.
> 
> Patches 3 and 4 wire up f2fs and ext4 respectively to fscrypt support for
> inline encryption, and e.g ensure that bios are submitted with blocks
> that not only are contiguous, but also have contiguous DUNs.
> 
> Eric Biggers (1):
>   ext4: add inline encryption support
> 
> Satya Tangirala (3):
>   fs: introduce SB_INLINECRYPT
>   fscrypt: add inline encryption support
>   f2fs: add inline encryption support
> 

Like I said on the UFS patchset: as this previously went through a number of
iterations as part of the "Inline Encryption Support" patchset (latest v13:
https://lkml.kernel.org/r/20200514003727.69001-1-satyat@google.com), it would be
helpful to list the changelog from v13 (though I can see that not too much
changed).  And I probably would have called it v14, but it doesn't matter much.

Explicit mentioning how this was tested would also be helpful.  And for that
matter, we should update the "Tests" section of the fscrypt documentation file
to mention also using the inlinecrypt mount option, e.g.:

diff --git a/Documentation/filesystems/fscrypt.rst b/Documentation/filesystems/fscrypt.rst
index f517af8ec11c..f5d8b0303ddf 100644
--- a/Documentation/filesystems/fscrypt.rst
+++ b/Documentation/filesystems/fscrypt.rst
@@ -1255,6 +1255,7 @@ f2fs encryption using `kvm-xfstests
 <https://github.com/tytso/xfstests-bld/blob/master/Documentation/kvm-quickstart.md>`_::
 
     kvm-xfstests -c ext4,f2fs -g encrypt
+    kvm-xfstests -c ext4,f2fs -g encrypt -m inlinecrypt
 
 UBIFS encryption can also be tested this way, but it should be done in
 a separate command, and it takes some time for kvm-xfstests to set up
@@ -1276,6 +1277,7 @@ This tests the encrypted I/O paths more thoroughly.  To do this with
 kvm-xfstests, use the "encrypt" filesystem configuration::
 
     kvm-xfstests -c ext4/encrypt,f2fs/encrypt -g auto
+    kvm-xfstests -c ext4/encrypt,f2fs/encrypt -g auto -m inlinecrypt
 
 Because this runs many more tests than "-g encrypt" does, it takes
 much longer to run; so also consider using `gce-xfstests
@@ -1283,3 +1285,4 @@ much longer to run; so also consider using `gce-xfstests
 instead of kvm-xfstests::
 
     gce-xfstests -c ext4/encrypt,f2fs/encrypt -g auto
+    gce-xfstests -c ext4/encrypt,f2fs/encrypt -g auto -m inlinecrypt
