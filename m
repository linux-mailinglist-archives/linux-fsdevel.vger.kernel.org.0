Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA355E0927
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Oct 2019 18:37:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732697AbfJVQho (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Oct 2019 12:37:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:35428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731727AbfJVQho (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Oct 2019 12:37:44 -0400
Received: from gmail.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 014C3205ED;
        Tue, 22 Oct 2019 16:37:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571762263;
        bh=rRDMmhyKltaJwbJcMHjqQIWtz5N0p4ykMspDlHgBfG4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ODNY+wMbg88YmanqkVZLBtuavnkLUkjsmJUtn8FO1Rjf7VFtwmPfwchNEZZKtdgDl
         9oGjh8/B9bitqrWNu0dG8Z9Fk2UXRx0IpTecz6ujj+X7nx/pSMcU5KuqiGWG+WDyro
         GJym/m6ptl9aVfv6fiJ8eucArGyNGtBt9c59ed6U=
Date:   Tue, 22 Oct 2019 09:37:41 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     linux-fscrypt@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, Satya Tangirala <satyat@google.com>,
        Paul Crowley <paulcrowley@google.com>,
        Paul Lawrence <paullawrence@google.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 2/3] ext4: add support for INLINE_CRYPT_OPTIMIZED
 encryption policies
Message-ID: <20191022163740.GB229362@gmail.com>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        linux-fscrypt@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, Satya Tangirala <satyat@google.com>,
        Paul Crowley <paulcrowley@google.com>,
        Paul Lawrence <paullawrence@google.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>
References: <20191021230355.23136-1-ebiggers@kernel.org>
 <20191021230355.23136-3-ebiggers@kernel.org>
 <20191022133716.GB23268@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191022133716.GB23268@mit.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 22, 2019 at 09:37:16AM -0400, Theodore Y. Ts'o wrote:
> On Mon, Oct 21, 2019 at 04:03:54PM -0700, Eric Biggers wrote:
> > From: Eric Biggers <ebiggers@google.com>
> > 
> > INLINE_CRYPT_OPTIMIZED encryption policies have special requirements
> > from the filesystem:
> > 
> > - Inode numbers must never change, even if the filesystem is resized
> > - Inode numbers must be <= 32 bits
> > - File logical block numbers must be <= 32 bits
> 
> You need to guarantee more than this; you also need to guarantee that
> the logical block number may not change.  Fortunately, because the
> original per-file key scheme used a logical block tweak, we've
> prohibited this already, and we didn't relax this restriction for
> files encrpyted using DIRECT_KEY.  So it's a requirement which we
> already meet, but we should document this requirement explicitly ---
> both here and also in Documentations/filesystems/fscrypt.rst.
> 
> Otherwise, looks good.  Feel free to add:
> 
> Reviewed-by: Theodore Ts'o <tytso@mit.edu>
> 

This is meant to list the requirements over the current policies.  If we wanted
to list all requirements on filesystems to support any fscrypt policy at all,
we'd also have to list a lot of other things like that the filesystem must
implement all the fscrypt_operations, must call all the needed hooks, must
support encrypted filenames and symlinks, etc...

I'll change the beginning of this commit message to
"INLINE_CRYPT_OPTIMIZED encryption policies have special requirements
from the filesystem, in comparison to the current encryption policies:"

... and in the previous patch I'll add a note in the "Contents encryption"
section of Documentation/filesystems/fscrypt.rst that the use of the file
logical block number means that filesystems must not allow operations that would
change it.

- Eric
