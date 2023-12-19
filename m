Return-Path: <linux-fsdevel+bounces-6533-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 88E0D819463
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Dec 2023 00:12:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F5161F25CED
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Dec 2023 23:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2808B3D0C6;
	Tue, 19 Dec 2023 23:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BgASHxRM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB2F3FB11;
	Tue, 19 Dec 2023 23:12:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 448B3C433C8;
	Tue, 19 Dec 2023 23:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703027550;
	bh=Wg2vV1WjPN26p90HjDONXgzV+zjLmWbmNTPH4yZdHu0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BgASHxRMht1yVdThzcVChIXyhaA0hmjnv6wBuco/tp02f4A+1KJQ7m9qv4WW6S8qz
	 MS1OawxaMbqCJm1+0nEWo7J3eoYYRdVF0Cdh5rD1LzMvmB15dKWMEKq/zzBPSbdH63
	 vsJnEa9ugDB3eNEqw1+sJjRtHCP5UNDcG7rP0TLCyzXlrjwC6X6fMcEHARf5H9RXGb
	 x1iGrGdRYpd2VRJx1t1pyHCD+uvvi5nwt9PfKdwKITPs2jwq+OFlYhue7mjynz3X6I
	 /icTDMy/kSXz3RVIAukQEYJMBiRj5Q59aF78KDwHhlaBlg6KbHTQDWjp/V4Z3TMFbT
	 wfsDDmO/jBCcw==
Date: Tue, 19 Dec 2023 16:12:22 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Gabriel Krisman Bertazi <krisman@suse.de>
Cc: viro@zeniv.linux.org.uk, jaegeuk@kernel.org, tytso@mit.edu,
	linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 0/8] Revert setting casefolding dentry operations
 through s_d_op
Message-ID: <20231219231222.GI38652@quark.localdomain>
References: <20231215211608.6449-1-krisman@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231215211608.6449-1-krisman@suse.de>

On Fri, Dec 15, 2023 at 04:16:00PM -0500, Gabriel Krisman Bertazi wrote:
> [Apologies for the quick spin of a v2.  The only difference are a couple
> fixes to the build when CONFIG_UNICODE=n caught by LKP and detailed in
> each patch changelog.]
> 
> When case-insensitive and fscrypt were adapted to work together, we moved the
> code that sets the dentry operations for case-insensitive dentries(d_hash and
> d_compare) to happen from a helper inside ->lookup.  This is because fscrypt
> wants to set d_revalidate only on some dentries, so it does it only for them in
> d_revalidate.
> 
> But, case-insensitive hooks are actually set on all dentries in the filesystem,
> so the natural place to do it is through s_d_op and let d_alloc handle it [1].
> In addition, doing it inside the ->lookup is a problem for case-insensitive
> dentries that are not created through ->lookup, like those coming
> open-by-fhandle[2], which will not see the required d_ops.
> 
> This patchset therefore reverts to using sb->s_d_op to set the dentry operations
> for case-insensitive filesystems.  In order to set case-insensitive hooks early
> and not require every dentry to have d_revalidate in case-insensitive
> filesystems, it introduces a patch suggested by Al Viro to disable d_revalidate
> on some dentries on the fly.
> 
> It survives fstests encrypt and quick groups without regressions.  Based on
> v6.7-rc1.
> 
> [1] https://lore.kernel.org/linux-fsdevel/20231123195327.GP38156@ZenIV/
> [2] https://lore.kernel.org/linux-fsdevel/20231123171255.GN38156@ZenIV/
> 
> Gabriel Krisman Bertazi (8):
>   dcache: Add helper to disable d_revalidate for a specific dentry
>   fscrypt: Drop d_revalidate if key is available
>   libfs: Merge encrypted_ci_dentry_ops and ci_dentry_ops
>   libfs: Expose generic_ci_dentry_ops outside of libfs
>   ext4: Set the case-insensitive dentry operations through ->s_d_op
>   f2fs: Set the case-insensitive dentry operations through ->s_d_op
>   libfs: Don't support setting casefold operations during lookup
>   fscrypt: Move d_revalidate configuration back into fscrypt

Thanks Gabriel, this series looks good.  Sorry that we missed this when adding
the support for encrypt+casefold.

It's slightly awkward that some lines of code added by patches 5-6 are removed
in patch 8.  These changes look very hard to split up, though, so you've
probably done about the best that can be done.

One question/request: besides performance, the other reason we're so careful
about minimizing when ->d_revalidate is set for fscrypt is so that overlayfs
works on encrypted directories.  This is because overlayfs is not compatible
with ->d_revalidate.  I think your solution still works for that, since
DCACHE_OP_REVALIDATE will be cleared after the first call to
fscrypt_d_revalidate(), and when checking for usupported dentries overlayfs does
indeed check for DCACHE_OP_REVALIDATE instead of ->d_revalidate directly.
However, that does rely on that very first call to ->d_revalidate actually
happening before the check is done.  It would be nice to verify that
overlayfs+fscrypt indeed continues to work, and explicitly mention this
somewhere (I don't see any mention of overlayfs+fscrypt in the series).

- Eric

