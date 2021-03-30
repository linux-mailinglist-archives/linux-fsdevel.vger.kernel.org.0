Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF03C34E0D8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Mar 2021 07:48:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230501AbhC3FsP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Mar 2021 01:48:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:40044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229667AbhC3Fry (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Mar 2021 01:47:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3348A60C3E;
        Tue, 30 Mar 2021 05:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617083274;
        bh=sLNj16jz+MQWRyeegTuCAOgGNtHJE4k6qlmBk/8uBWI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D5D0VXYmafeEBMtG4ve4wxOPt1WgZvZxYhS5O2cOf3CDcG5u8Mhb4E0WwnxKqerBi
         0maG55PE9DYmIqSZnROblCGPgINK+wAy4saOuDtDFYPeNYucHsnzUBblvdVMUYa0V7
         WgI08qZovt3PTgc30I9paP4w65zc62b75G9GZ3++Cm/HsHYbesw9TUIUSrBWq3GnXz
         xoAneUB4YUsjj6/sDklBkYhXUaWtU+mt/hvkcsYVgWPU58VqPPhPpNB5XFJ+UvHxWx
         tqR88XVAfDb9fT9RTNeEdkJX9qknZGctXrGhnF2fmt8QuLFCgpVnjj+v2Ou5ghI8hg
         CQZA8PJ5oNpYQ==
Date:   Mon, 29 Mar 2021 22:47:52 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     Shreeya Patel <shreeya.patel@collabora.com>, tytso@mit.edu,
        adilger.kernel@dilger.ca, jaegeuk@kernel.org, chao@kernel.org,
        drosen@google.com, yuchao0@huawei.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, kernel@collabora.com,
        andre.almeida@collabora.com
Subject: Re: [PATCH v5 4/4] fs: unicode: Add utf8 module and a unicode layer
Message-ID: <YGK7iNRXcMr/ahsL@sol.localdomain>
References: <20210329204240.359184-1-shreeya.patel@collabora.com>
 <20210329204240.359184-5-shreeya.patel@collabora.com>
 <YGKGhxaozX3ND6iB@gmail.com>
 <87v999pequ.fsf@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v999pequ.fsf@collabora.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 29, 2021 at 10:16:57PM -0400, Gabriel Krisman Bertazi wrote:
> Eric Biggers <ebiggers@kernel.org> writes:
> 
> > On Tue, Mar 30, 2021 at 02:12:40AM +0530, Shreeya Patel wrote:
> >> diff --git a/fs/unicode/Kconfig b/fs/unicode/Kconfig
> >> index 2c27b9a5cd6c..ad4b837f2eb2 100644
> >> --- a/fs/unicode/Kconfig
> >> +++ b/fs/unicode/Kconfig
> >> @@ -2,13 +2,26 @@
> >>  #
> >>  # UTF-8 normalization
> >>  #
> >> +# CONFIG_UNICODE will be automatically enabled if CONFIG_UNICODE_UTF8
> >> +# is enabled. This config option adds the unicode subsystem layer which loads
> >> +# the UTF-8 module whenever any filesystem needs it.
> >>  config UNICODE
> >> -	bool "UTF-8 normalization and casefolding support"
> >> +	bool
> >> +
> >> +# utf8data.h_shipped has a large database table which is an auto-generated
> >> +# decodification trie for the unicode normalization functions and it is not
> >> +# necessary to carry this large table in the kernel.
> >> +# Enabling UNICODE_UTF8 option will allow UTF-8 encoding to be built as a
> >> +# module and this module will be loaded by the unicode subsystem layer only
> >> +# when any filesystem needs it.
> >> +config UNICODE_UTF8
> >> +	tristate "UTF-8 module"
> >>  	help
> >>  	  Say Y here to enable UTF-8 NFD normalization and NFD+CF casefolding
> >>  	  support.
> >> +	select UNICODE
> >
> > This seems problematic; it allows users to set CONFIG_EXT4_FS=y (or
> > CONFIG_F2FS_FS=y) but then CONFIG_UNICODE_UTF8=m.  Then the filesystem won't
> > work if the modules are located on the filesystem itself.
> 
> Hi Eric,
> 
> Isn't this a user problem?  If the modules required to boot are on the
> filesystem itself, you are in trouble.  But, if that is the case, your
> rootfs is case-insensitive and you gotta have utf8 as built-in or have
> it in an early userspace.
> 

We could make it the user's problem, but that seems rather unfriendly.
Especially because the utf8 module would be needed if the filesystem has the
casefold feature at all, regardless of whether any casefolded directories are
needed at boot time or not.  (Unless there is a plan to change that?)

- Eric
