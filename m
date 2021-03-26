Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96DE934AEAB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Mar 2021 19:38:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbhCZSiM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Mar 2021 14:38:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:39036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229969AbhCZSiM (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Mar 2021 14:38:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A620961A13;
        Fri, 26 Mar 2021 18:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616783892;
        bh=tl2BnRgFFmTrCujm04id4QN8NI6kqyDBnURR8pQv+I4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=HoLyiBkFPEI4CqtsPen93c8RmJpJ/0JCOnWBSwUGyhGsx4A5CQZuJ5ojDdDY3cQ3K
         wPWeHORzlLzSBikwxghrbrHr85pytU3bEl0I0XRE3lBI6LEqyPSPZ5jv4PNgRlr49Z
         /r+z/WgATkpXcRIJf9FRHXw0FU2pyzcmifFj40kfpTZNbEwLFlrYV7JS7tuFaJsEXQ
         10V8w4yUf1TBJBvjm1ZTMF7QvxqH29/BeNnPpvK8e8iTahIOTiGRrBMFrk3yYDiY/4
         uFHGTYSsJV/IQM8gLkOaIcl01OHmBZp6NFiG4N74pSluiFUQ6kn8Vibf3oYkpkWJyW
         Jk2uGqV5zIp7w==
Message-ID: <f7e34bd93f8e774cf11ff059d040a7ec19ef0b19.camel@kernel.org>
Subject: Re: [RFC PATCH v5 00/19] ceph+fscrypt: context, filename and
 symlink support
From:   Jeff Layton <jlayton@kernel.org>
To:     ceph-devel@vger.kernel.org
Cc:     linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org
Date:   Fri, 26 Mar 2021 14:38:10 -0400
In-Reply-To: <20210326173227.96363-1-jlayton@kernel.org>
References: <20210326173227.96363-1-jlayton@kernel.org>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 2021-03-26 at 13:32 -0400, Jeff Layton wrote:
> I haven't posted this in a while and there were some bugs shaken out of
> the last posting. This adds (partial) support for fscrypt to kcephfs,
> including crypto contexts, filenames and encrypted symlink targets. At
> this point, the xfstests quick tests that generally pass without fscrypt
> also pass with test_dummy_encryption enabled.
> 
> There is one lingering bug that I'm having trouble tracking down: xfstest
> generic/477 (an open_by_handle_at test) sometimes throws a "Busy inodes
> after umount" warning. I'm narrowed down the issue a bit, but there is
> some raciness involved so I haven't quite nailed it down yet.
> 
> This set is quite invasive. There is probably some further work to be
> done to add common code helpers and the like, but the final diffstat
> probably won't look too different.
> 
> This set does not include encryption of file contents. That is turning
> out to be a bit trickier than first expected owing to the fact that the
> MDS is usually what handles truncation, and the i_size no longer
> represents the amount of data stored in the backing store. That will
> probably require an MDS change to fix, and we're still sorting out the
> details.
> 
> Jeff Layton (19):
>   vfs: export new_inode_pseudo
>   fscrypt: export fscrypt_base64_encode and fscrypt_base64_decode
>   fscrypt: export fscrypt_fname_encrypt and fscrypt_fname_encrypted_size
>   fscrypt: add fscrypt_context_for_new_inode
>   ceph: crypto context handling for ceph
>   ceph: implement -o test_dummy_encryption mount option
>   ceph: preallocate inode for ops that may create one
>   ceph: add routine to create fscrypt context prior to RPC
>   ceph: make ceph_msdc_build_path use ref-walk
>   ceph: add encrypted fname handling to ceph_mdsc_build_path
>   ceph: decode alternate_name in lease info
>   ceph: send altname in MClientRequest
>   ceph: properly set DCACHE_NOKEY_NAME flag in lookup
>   ceph: make d_revalidate call fscrypt revalidator for encrypted
>     dentries
>   ceph: add helpers for converting names for userland presentation
>   ceph: add fscrypt support to ceph_fill_trace
>   ceph: add support to readdir for encrypted filenames
>   ceph: create symlinks with encrypted and base64-encoded targets
>   ceph: add fscrypt ioctls
> 
>  fs/ceph/Makefile            |   1 +
>  fs/ceph/crypto.c            | 185 +++++++++++++++++++++++
>  fs/ceph/crypto.h            | 101 +++++++++++++
>  fs/ceph/dir.c               | 178 ++++++++++++++++++-----
>  fs/ceph/file.c              |  56 ++++---
>  fs/ceph/inode.c             | 255 +++++++++++++++++++++++++++++---
>  fs/ceph/ioctl.c             |  94 ++++++++++++
>  fs/ceph/mds_client.c        | 283 ++++++++++++++++++++++++++++++------
>  fs/ceph/mds_client.h        |  14 +-
>  fs/ceph/super.c             |  80 +++++++++-
>  fs/ceph/super.h             |  16 +-
>  fs/ceph/xattr.c             |  32 ++++
>  fs/crypto/fname.c           |  53 +++++--
>  fs/crypto/fscrypt_private.h |   9 +-
>  fs/crypto/hooks.c           |   6 +-
>  fs/crypto/policy.c          |  34 ++++-
>  fs/inode.c                  |   1 +
>  include/linux/fscrypt.h     |  10 ++
>  18 files changed, 1246 insertions(+), 162 deletions(-)
>  create mode 100644 fs/ceph/crypto.c
>  create mode 100644 fs/ceph/crypto.h
> 

Oh, I should mention that this is all in my ceph-fscrypt-fnames branch:

    https://git.kernel.org/pub/scm/linux/kernel/git/jlayton/linux.git/

This all still under heavy development, so I'm open to suggestions and
review. If you're daring and want to test with it, please do.

I do think this has the potential to be a "killer feature" for ceph (and
maybe other network filesystems). Being able to store data securely on
an otherwise "public" cluster seems like a very nice thing to have.

Cheers,
-- 
Jeff Layton <jlayton@kernel.org>

