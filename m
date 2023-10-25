Return-Path: <linux-fsdevel+bounces-1189-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D58437D70A6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Oct 2023 17:19:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 399E4B211EC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Oct 2023 15:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13EE72AB4C;
	Wed, 25 Oct 2023 15:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ZuUVTMSG";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="cjhZlYDY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27C61DA5B
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Oct 2023 15:19:13 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27046129;
	Wed, 25 Oct 2023 08:19:11 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 93B471FF79;
	Wed, 25 Oct 2023 15:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1698247150; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=44S3QBGX+n9gobdLgmc7FmUctQwHLf+32LFQcUsZ8hs=;
	b=ZuUVTMSGCJV3/GjgIHBAWf/Wn+ejp6Qv9xr/USGSYEgpSurICPnUuHeQxgsmqNhp1me2Gk
	xKukBly7nlvuilbb+9FdptbW/aJiHOl7LjCGCeEH28BzfzGq2dcZTODLUFoCV5VZ7Gy5Xj
	l3xJyuldDfYBmQ1U+MhV9vzA9Aa6lPw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1698247150;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=44S3QBGX+n9gobdLgmc7FmUctQwHLf+32LFQcUsZ8hs=;
	b=cjhZlYDYIlya0fQ102Sh8CVhReRGICuKHsHkxeFbQi0AkT34Exg25H9DyKhExGILgmBAz+
	mg5KmCzXK8kVmjBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5B082138E9;
	Wed, 25 Oct 2023 15:19:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id bB1IEO4xOWVtNAAAMHmgww
	(envelope-from <krisman@suse.de>); Wed, 25 Oct 2023 15:19:10 +0000
From: Gabriel Krisman Bertazi <krisman@suse.de>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org,  linux-ext4@vger.kernel.org,
  linux-f2fs-devel@lists.sourceforge.net,  viro@zeniv.linux.org.uk,
  tytso@mit.edu,  ebiggers@kernel.org,  jaegeuk@kernel.org
Subject: Re: [PATCH v6 0/9] Support negative dentries on case-insensitive
 ext4 and f2fs
In-Reply-To: <20231025-selektiert-leibarzt-5d0070d85d93@brauner> (Christian
	Brauner's message of "Wed, 25 Oct 2023 15:32:02 +0200")
Organization: SUSE
References: <20230816050803.15660-1-krisman@suse.de>
	<20231025-selektiert-leibarzt-5d0070d85d93@brauner>
Date: Wed, 25 Oct 2023 11:19:09 -0400
Message-ID: <87lebq91ci.fsf@>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Christian Brauner <brauner@kernel.org> writes:

> On Wed, 16 Aug 2023 01:07:54 -0400, Gabriel Krisman Bertazi wrote:
>> This is v6 of the negative dentry on case-insensitive directories.
>> Thanks Eric for the review of the last iteration.  This version
>> drops the patch to expose the helper to check casefolding directories,
>> since it is not necessary in ecryptfs and it might be going away.  It
>> also addresses some documentation details, fix a build bot error and
>> simplifies the commit messages.  See the changelog in each patch for
>> more details.
>> 
>> [...]
>
> Ok, let's put it into -next so it sees some testing.
> So it's too late for v6.7. Seems we forgot about this series.
> Sorry about that.

Ah, that's a bummer :(. I wanted to ping earlier but stupidly assumed it
was intentional for any reason.

Considering this has been on the list since 2022 and only slightly
changed, mostly touches case-insensitive enabled filesystems, and that
we still didn't enter the merge window (let the alone the -rc stabilization
period), would you consider queueing it on Linux-next today and, provided
there are no merge conflicts, include it in the 6.7 pull request?  I'd
rather not have it sit for another 3 months before inclusion.

>
> ---
>
> Applied to the vfs.casefold branch of the vfs/vfs.git tree.
> Patches in the vfs.casefold branch should appear in linux-next soon.
>
> Please report any outstanding bugs that were missed during review in a
> new review to the original patch series allowing us to drop it.
>
> It's encouraged to provide Acked-bys and Reviewed-bys even though the
> patch has now been applied. If possible patch trailers will be updated.
>
> Note that commit hashes shown below are subject to change due to rebase,
> trailer updates or similar. If in doubt, please check the listed branch.
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
> branch: vfs.casefold
>
> [1/9] ecryptfs: Reject casefold directory inodes
>       https://git.kernel.org/vfs/vfs/c/8512e7c7e665
> [2/9] 9p: Split ->weak_revalidate from ->revalidate
>       https://git.kernel.org/vfs/vfs/c/17f4423cb24a
> [3/9] fs: Expose name under lookup to d_revalidate hooks
>       https://git.kernel.org/vfs/vfs/c/24084e50e579
> [4/9] fs: Add DCACHE_CASEFOLDED_NAME flag
>       https://git.kernel.org/vfs/vfs/c/2daa2df800f8
> [5/9] libfs: Validate negative dentries in case-insensitive directories
>       https://git.kernel.org/vfs/vfs/c/8d879ccaf0f7
> [6/9] libfs: Chain encryption checks after case-insensitive revalidation
>       https://git.kernel.org/vfs/vfs/c/314e925d5a2c
> [7/9] libfs: Merge encrypted_ci_dentry_ops and ci_dentry_ops
>       https://git.kernel.org/vfs/vfs/c/07f820b77c58
> [8/9] ext4: Enable negative dentries on case-insensitive lookup
>       https://git.kernel.org/vfs/vfs/c/2562ec77f11e
> [9/9] f2fs: Enable negative dentries on case-insensitive lookup
>       https://git.kernel.org/vfs/vfs/c/39d2dd36a065

Thanks,

-- 
Gabriel Krisman Bertazi

