Return-Path: <linux-fsdevel+bounces-8514-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 62C8083894B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 09:41:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 959E31C21FA2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 08:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4168856B8F;
	Tue, 23 Jan 2024 08:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c1RodUQZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B7ED56B79;
	Tue, 23 Jan 2024 08:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705999272; cv=none; b=QC+H/3a0LGtvG7xH5fSQPBsrFmPrOM4WzhlvvfE7RT+yVJGM/7zgOLzNZu32xciBAq//9M4iW4rYc+v3/RHyVQep9LWQAbPzjNvVnYSoqmnKstWN/3G2dLf7PKDdHIdBvE6ru9r0g3iW8GHggyqpk+8qrZkiLiQTCS8xWWfb+20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705999272; c=relaxed/simple;
	bh=HhePdDiV1RoPyzweu+6A0rKcyr2VkNNep3AQr53Isxo=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=IW87s+ngSJ4sa6iKosmywMSPbHJkcDTCPNtMpc3Xbm8/M5YBMJvvGZqeIdoI3mfb7gej0yJiYdYmtDNGLzXJhsUN8zEkRi/BlYSOOQYtiMZC8kMBwzWuNW2cPeVjnJz0j/DpdP3f9ue1YQQSLl7Xu7qZfgm9//Mx/D9XVxEzycM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c1RodUQZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82C2DC433F1;
	Tue, 23 Jan 2024 08:41:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705999272;
	bh=HhePdDiV1RoPyzweu+6A0rKcyr2VkNNep3AQr53Isxo=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:From;
	b=c1RodUQZMUmnQwcz7E/TARb86KVq+PnQhc4ODnUT4ZmHAqZdWDgwpOtL+cVKlzsm6
	 j4tJsds3RQmDafmrYgsQPoOYdAVRiukdPryTc6EVzrp3zkPJjYPDGTQ361Db6YooX9
	 DcHVqsrj38wCIPmVC33UqaOhbIkUWDUv9VE7u6uxfiIacbig6GS+zVQMRVgpcowSsd
	 Za+xbMiTU02Qy9SJ8MEUqFAdGGnDX6A9/PDYM+AsC2THbghsI/x/uHu/MW+O9IuLL/
	 a73+UAuRbTdDPKfxiMYxFAm/sWe6on0g/jMkPontiHJMDSwckBNES7dYDnpjgz5VC3
	 msg+ZBq8BIMbQ==
References: <87le96lorq.fsf@debian-BULLSEYE-live-builder-AMD64>
 <20240104043420.GT361584@frogsfrogsfrogs>
 <87sf3d8c0u.fsf@debian-BULLSEYE-live-builder-AMD64>
 <874jfbjimn.fsf@debian-BULLSEYE-live-builder-AMD64>
 <20240118063930.GP1674809@ZenIV>
User-agent: mu4e 1.10.8; emacs 27.1
From: Chandan Babu R <chandanbabu@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: "Darrick J. Wong" <djwong@kernel.org>, linux-fsdevel
 <linux-fsdevel@vger.kernel.org>, linux-xfs@vger.kernel.org,
 brauner@kernel.org, jack@suse.cz
Subject: Re: [BUG REPORT] shrink_dcache_parent() loops indefinitely on a
 next-20240102 kernel
Date: Tue, 23 Jan 2024 11:31:00 +0530
In-reply-to: <20240118063930.GP1674809@ZenIV>
Message-ID: <87ede8787u.fsf@debian-BULLSEYE-live-builder-AMD64>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Jan 18, 2024 at 06:39:30 AM +0000, Al Viro wrote:
> On Thu, Jan 18, 2024 at 10:59:06AM +0530, Chandan Babu R wrote:
>> On Thu, Jan 04, 2024 at 06:40:43 PM +0530, Chandan Babu R wrote:
>> > On Wed, Jan 03, 2024 at 08:34:20 PM -0800, Darrick J. Wong wrote:
>> >> On Wed, Jan 03, 2024 at 12:12:12PM +0530, Chandan Babu R wrote:
>> >>> Hi,
>> >>> 
>> >>> Executing fstests' recoveryloop test group on XFS on a next-20240102 kernel
>> >>> sometimes causes the following hung task report to be printed on the console,
>> >>> 
>> 
>> Meanwhile, I have executed some more experiments.
>> 
>> The bug can be recreated on a next-20240102 kernel by executing either
>> generic/388 or generic/475 for a maximum of 10 iterations. I tried to do a git
>> bisect based on this observation i.e. I would mark a commit as 'good' if the
>> bug does not get recreated within 10 iterations. This led to the following git
>> bisect log,
>
>> # bad: [119dcc73a9c2df0da002054cdb2296cb32b7cb93] Merge branches 'work.dcache-misc' and 'work.dcache2' into work.dcache
>> git bisect bad 119dcc73a9c2df0da002054cdb2296cb32b7cb93
>> # good: [6367b491c17a34b28aece294bddfda1a36ec0377] retain_dentry(): introduce a trimmed-down lockless variant
>> git bisect good 57851607326a2beef21e67f83f4f53a90df8445a
>> # good: [ef69f0506d8f3a250ac5baa96746e17ae22c67b5] __d_unalias() doesn't use inode argument
>
> Lovely...  Could you try to do the following:
>
> bisect from 6.7-rc1 to work.dcache-misc; for each of those revisions
> 	git worktree add ../test HEAD
> 	cd ../test
> 	git merge work.dcache2
> 	build
> 	test the result
> 	cd -
> 	git worktree remove -f ../test
> 	git bisect {good,bad} accordingly

The result of the above suggested bisect operation is,

# git bisect log
# bad: [0695819b3988e7e4d8099f8388244c1549d230cc] __d_unalias() doesn't use inode argument
# good: [b85ea95d086471afb4ad062012a4d73cd328fa86] Linux 6.7-rc1
git bisect start 'HEAD' 'v6.7-rc1' 'fs/'
# good: [b33c14c8618edfc00bf8963e3b0c8a2b19c9eaa4] Merge branch 'no-rebase-overlayfs' into work.dcache-misc
git bisect good b33c14c8618edfc00bf8963e3b0c8a2b19c9eaa4
# good: [ef8a633ee84d8b57eba1f5b2908a3e0bf61837aa] Merge branch 'merged-selinux' into work.dcache-misc
git bisect good ef8a633ee84d8b57eba1f5b2908a3e0bf61837aa
# good: [53f99622a2b24704766469af23360836432eb88a] d_genocide(): move the extern into fs/internal.h
git bisect good 53f99622a2b24704766469af23360836432eb88a
# bad: [ce54c803d57ab6e872b670f0b46fc65840c8d7ca] d_alloc_parallel(): in-lookup hash insertion doesn't need an RCU variant
git bisect bad ce54c803d57ab6e872b670f0b46fc65840c8d7ca
# bad: [f7aff128d8c70493d614786ba7ec5f743feafe51] get rid of DCACHE_GENOCIDE
git bisect bad f7aff128d8c70493d614786ba7ec5f743feafe51
# first bad commit: [f7aff128d8c70493d614786ba7ec5f743feafe51] get rid of DCACHE_GENOCIDE


commit f7aff128d8c70493d614786ba7ec5f743feafe51
Author: Al Viro <viro@zeniv.linux.org.uk>
Date:   Sun Nov 12 21:38:48 2023 -0500

    get rid of DCACHE_GENOCIDE

    ... now that we never call d_genocide() other than from kill_litter_super()

    Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

 fs/dcache.c            | 5 +----
 include/linux/dcache.h | 1 -
 2 files changed, 1 insertion(+), 5 deletions(-)

-- 
Chandan

