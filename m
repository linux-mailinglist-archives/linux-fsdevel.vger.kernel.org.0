Return-Path: <linux-fsdevel+bounces-8841-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0B9B83BA3A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 07:43:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7790E1F21D31
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 06:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83C921119F;
	Thu, 25 Jan 2024 06:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p44FD82g"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFDBE1118A;
	Thu, 25 Jan 2024 06:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706164981; cv=none; b=dGQLOhtOviG3X+Sp/TIB5NmdX2DIbHC5o51jLYb6YoPqY8qGIa5HcU2TobC9tncet7Zpz/A2fup462aHBG8N8e9QV3J4rvPyK85vLnrXbfMUyZoeD/tEFOpf9tcbiYYVrcLyJa3w2PWFmhZEkYU/myfabiEUa/CqQFI0+tISE1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706164981; c=relaxed/simple;
	bh=ihIGw4o7YWYxIieHRpZA40B+FJgvKpxV2EFUVJrgC/4=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=g5ivCgS5TMyWawiZbSztmVaZUBGZPOSmyzL7UfN9JZk9htnsEahH+KQMHPw+4D1TD0Y+mNf+bY85MtgCcahQvuGbRCevrdgEmZR+wH47PFkYmPqs4FNGU2cN6WTIC7QL1F3eRzHy0hvHZL6zkhFgA347ad+4r0F9DZ0b18NI4pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p44FD82g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECA00C433F1;
	Thu, 25 Jan 2024 06:42:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706164980;
	bh=ihIGw4o7YWYxIieHRpZA40B+FJgvKpxV2EFUVJrgC/4=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:From;
	b=p44FD82gby7tav9jHKjvQhqWPyhz0rnbAY8IBDRlhyRpSnubA6+yj7N6X4PcVpyq4
	 InTbbPMgkSmu4K/THLHNjiv0mg19YW1jj3k0FXrwD+P3tRy6vN6XpBXq69LZ+xr8HX
	 a5+Ua/5RyAZEBKUjrXMcDZUrGXOp79kHLZwpwo7zRG5OJc1/j/M1PMkM79ON97/Ou3
	 QMeC4zaM6CeE+5BrF4fnAsQJqdQNXTLEN2wMhGTlsMa0dSVJ+lGWUQyo6A/c6IGFc9
	 j6864hcmFx2ACaWbjgGCLDiipR+q28XSfHQjhILuxkLPcAHCOMdKjWzmuLeiHC7WY1
	 I78mQuljFixfA==
References: <87le96lorq.fsf@debian-BULLSEYE-live-builder-AMD64>
 <20240104043420.GT361584@frogsfrogsfrogs>
 <87sf3d8c0u.fsf@debian-BULLSEYE-live-builder-AMD64>
 <874jfbjimn.fsf@debian-BULLSEYE-live-builder-AMD64>
 <20240118063930.GP1674809@ZenIV>
 <87ede8787u.fsf@debian-BULLSEYE-live-builder-AMD64>
 <20240123114043.GC2087318@ZenIV>
User-agent: mu4e 1.10.8; emacs 27.1
From: Chandan Babu R <chandanbabu@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: "Darrick J. Wong" <djwong@kernel.org>, linux-fsdevel
 <linux-fsdevel@vger.kernel.org>, linux-xfs@vger.kernel.org,
 brauner@kernel.org, jack@suse.cz
Subject: Re: [BUG REPORT] shrink_dcache_parent() loops indefinitely on a
 next-20240102 kernel
Date: Thu, 25 Jan 2024 12:01:01 +0530
In-reply-to: <20240123114043.GC2087318@ZenIV>
Message-ID: <8734ulsykv.fsf@debian-BULLSEYE-live-builder-AMD64>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Jan 23, 2024 at 11:40:43 AM +0000, Al Viro wrote:
> On Tue, Jan 23, 2024 at 11:31:00AM +0530, Chandan Babu R wrote:
>> 
>> The result of the above suggested bisect operation is,
>> 
>> # git bisect log
>> # bad: [0695819b3988e7e4d8099f8388244c1549d230cc] __d_unalias() doesn't use inode argument
>> # good: [b85ea95d086471afb4ad062012a4d73cd328fa86] Linux 6.7-rc1
>> git bisect start 'HEAD' 'v6.7-rc1' 'fs/'
>> # good: [b33c14c8618edfc00bf8963e3b0c8a2b19c9eaa4] Merge branch 'no-rebase-overlayfs' into work.dcache-misc
>> git bisect good b33c14c8618edfc00bf8963e3b0c8a2b19c9eaa4
>> # good: [ef8a633ee84d8b57eba1f5b2908a3e0bf61837aa] Merge branch 'merged-selinux' into work.dcache-misc
>> git bisect good ef8a633ee84d8b57eba1f5b2908a3e0bf61837aa
>> # good: [53f99622a2b24704766469af23360836432eb88a] d_genocide(): move the extern into fs/internal.h
>> git bisect good 53f99622a2b24704766469af23360836432eb88a
>> # bad: [ce54c803d57ab6e872b670f0b46fc65840c8d7ca] d_alloc_parallel(): in-lookup hash insertion doesn't need an RCU variant
>> git bisect bad ce54c803d57ab6e872b670f0b46fc65840c8d7ca
>> # bad: [f7aff128d8c70493d614786ba7ec5f743feafe51] get rid of DCACHE_GENOCIDE
>> git bisect bad f7aff128d8c70493d614786ba7ec5f743feafe51
>> # first bad commit: [f7aff128d8c70493d614786ba7ec5f743feafe51] get rid of DCACHE_GENOCIDE
>> 
>> 
>> commit f7aff128d8c70493d614786ba7ec5f743feafe51
>> Author: Al Viro <viro@zeniv.linux.org.uk>
>> Date:   Sun Nov 12 21:38:48 2023 -0500
>> 
>>     get rid of DCACHE_GENOCIDE
>> 
>>     ... now that we never call d_genocide() other than from kill_litter_super()
>
> Huh?  So you are seeing that on merge of f7aff128d8c70493d614786ba7ec5f743feafe51 +
> 6367b491c17a34b28aece294bddfda1a36ec0377, but not on
> f7aff128d8c70493d614786ba7ec5f743feafe51^ + 6367b491c17a34b28aece294bddfda1a36ec0377?
>

The above bad commit was identified with
f7aff128d8c70493d614786ba7ec5f743feafe51 + 4931c524ee8bbdf890972b14d6fcd9e2c72602d9

4931c524ee8bbdf890972b14d6fcd9e2c72602d9 was obtained from work.dcache2 branch at
https://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git.

However the diff between those commits suggest that they should not impact the
bisect results,

# git diff --stat 4931c524ee8bbdf890972b14d6fcd9e2c72602d9..6367b491c17a34b28aece294bddfda1a36ec0377
 Documentation/filesystems/porting.rst | 8 ++++----
 fs/coda/cache.c                       | 3 ---
 2 files changed, 4 insertions(+), 7 deletions(-)

> Wait a minute...  That smells like a d_walk() seeing rename_lock touched when it's
> ascending from a subtree (for the reasons that have nothing to do with any changes of
> the tree we are walking) and deciding to take another pass through the damn thing.
> Argh...
>
> But that should've been a problem for that commit on its own, regardless of the
> merge with work.dcache2...  OTOH, it probably ended up as quiet memory leak without
> that merge...
>
> OK, could you verify that revert of that commit is enough to recover?  Short-term
> that would be the obvious solution, assuming this is all that happens there.
> Longer term I'd probably prefer to avoid using d_walk() there, but that's
> a separate story.

I executed generic/388 for about 22 times without including
f7aff128d8c70493d614786ba7ec5f743feafe51 commit. The first few commits on
the git tree were,

9cae6cd3e74a (HEAD -> without-dcache-genocide) Merge remote-tracking branch 'alviro/work.dcache2' into without-dcache-genocide
53f99622a2b2 d_genocide(): move the extern into fs/internal.h
4931c524ee8b (alviro/work.dcache2) retain_dentry(): introduce a trimmed-down lockless variant
1b738f196eac __dentry_kill(): new locking scheme
e3640d37d056 d_prune_aliases(): use a shrink list

The indefinite loop bug could not be recreated with the above kernel.

-- 
Chandan

