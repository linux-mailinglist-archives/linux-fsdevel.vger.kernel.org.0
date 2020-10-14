Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0705228EA3C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Oct 2020 03:35:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732273AbgJOBfK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Oct 2020 21:35:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728839AbgJOBeh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Oct 2020 21:34:37 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBDB5C05112D;
        Wed, 14 Oct 2020 16:08:16 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kSpsS-000OAs-QS; Wed, 14 Oct 2020 23:08:12 +0000
Date:   Thu, 15 Oct 2020 00:08:12 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org,
        kernel-team@fb.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs: fix NULL dereference due to data race in
 prepend_path()
Message-ID: <20201014230812.GK3576660@ZenIV.linux.org.uk>
References: <20201014204529.934574-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201014204529.934574-1-andrii@kernel.org>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 14, 2020 at 01:45:28PM -0700, Andrii Nakryiko wrote:
> Fix data race in prepend_path() with re-reading mnt->mnt_ns twice without
> holding the lock. is_mounted() does check for NULL, but is_anon_ns(mnt->mnt_ns)
> might re-read the pointer again which could be NULL already, if in between
> reads one of kern_unmount()/kern_unmount_array()/umount_tree() sets mnt->mnt_ns
> to NULL.

Cute...  What config/compiler has resulted in that?  I agree with the analysis, but
I really hate the open-coded (and completely unexplained) use of IS_ERR_OR_NULL()
there.

> -			if (is_mounted(vfsmnt) && !is_anon_ns(mnt->mnt_ns))
> +			mnt_ns = READ_ONCE(mnt->mnt_ns);
> +			/* open-coded is_mounted() to use local mnt_ns */
> +			if (!IS_ERR_OR_NULL(mnt_ns) && !is_anon_ns(mnt_ns))
>  				error = 1;	// absolute root
>  			else
>  				error = 2;	// detached or not attached yet

Better turn that into an inlined helper in fs/mount.h, next to is_mounted(), IMO,
and kill that IS_ERR_OR_NULL garbage there.  What that thing does is
	if (ns == NULL || ns == MNT_NS_INTERNAL)
and it's *not* on any kind of hot path to warrant that kind of microoptimizations.

So let's make that

static inline bool is_real_ns(struct mnt_namespace *mnt_ns)
{
	return mnt_ns && mnt_ns != MNT_NS_INTERNAL;
}

turn is_mounted(m) into is_real_ns(m->mnt_ns) and replace that line in your fix
with
			if (is_real_ns(mnt_ns) && !is_anon_ns(mnt_ns))

Objections?
