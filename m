Return-Path: <linux-fsdevel+bounces-59045-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0312B34011
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 14:51:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D6101A84867
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 12:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF73D1D5178;
	Mon, 25 Aug 2025 12:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JZTY7WYG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195041E520C
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 Aug 2025 12:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756126276; cv=none; b=rKpTw8CO6g4q/oj3AakrXuN6CZ2roj1FWb62gS2GzoBU4W759SJRsTmRanar+i7aQvjrWEIEP7RxupnzMsVuvLc+zJ69LmeXCfAygMR/oCX2KSIodpcoubjKuM182sQwstcloazAHFvSIE4acSF1fNUveAyzx4+tR5JQ/r5mMGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756126276; c=relaxed/simple;
	bh=2pOKCwAFCf1fAti4QRuD8Fn22MfW2hB2NRSjaxo/pGc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LBwzV1KZAutNKZi+VtjH/I5NJ71uC95Z1ATfF5+yd9hIMUNSfbkTempAaWIkR15eHREqKZjh211tQqrR5rLdRUzLqZvLTK5bqzRnC5u+gx2PGZTNzApSJMoW1FS+8QoMWjxUqEbJVvaJBfGe5TCaByfdFIW0mITmwnrIxnmzoh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JZTY7WYG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E3A6C4CEED;
	Mon, 25 Aug 2025 12:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756126275;
	bh=2pOKCwAFCf1fAti4QRuD8Fn22MfW2hB2NRSjaxo/pGc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JZTY7WYGe4inpWykYp7L7qbH/Wzjc97HyosXl0bFj3oRCOuLut8sPvffUpTDYIdSe
	 JhF0QoNBLeHX/m44UEdNFZrtSW5Zqf3kijxbAuFATh4njNBEMN75uCVJDuh4uo6r9V
	 khdiqP84lXVR333Ft00Wps0wDFkVdouDMj8pkbpLkbaOltoUrXRpg1luddvShjwyFN
	 CYOYa8KGY0wVtlgTGVd/z/axB9/hVQHj/5euGp7I29UcEsgnQPcGHu8AChndMzsCww
	 2sdRMI9cv83+m6QLMPtiSaaVSa3JabtfRUS2i4utsLjhBx4+Axcsz4al/2GAoIi026
	 HmM15XTzwhJhg==
Date: Mon, 25 Aug 2025 14:51:12 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, jack@suse.cz, 
	torvalds@linux-foundation.org
Subject: Re: [PATCH 14/52] mnt_set_expiry(): use guards
Message-ID: <20250825-rekonstruieren-zutiefst-5ba7952fa518@brauner>
References: <20250825044046.GI39973@ZenIV>
 <20250825044355.1541941-1-viro@zeniv.linux.org.uk>
 <20250825044355.1541941-14-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250825044355.1541941-14-viro@zeniv.linux.org.uk>

On Mon, Aug 25, 2025 at 05:43:17AM +0100, Al Viro wrote:
> The reason why it needs only mount_locked_reader is that there's no lockless
> accesses of expiry lists.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>  fs/namespace.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/namespace.c b/fs/namespace.c
> index eabb0d996c6a..acacfe767a7c 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -3858,9 +3858,8 @@ int finish_automount(struct vfsmount *m, const struct path *path)
>   */
>  void mnt_set_expiry(struct vfsmount *mnt, struct list_head *expiry_list)
>  {
> -	read_seqlock_excl(&mount_lock);
> -	list_add_tail(&real_mount(mnt)->mnt_expire, expiry_list);
> -	read_sequnlock_excl(&mount_lock);
> +	scoped_guard(mount_locked_reader)
> +		list_add_tail(&real_mount(mnt)->mnt_expire, expiry_list);

Should also just use a guard(). I don't think religiously sticking to
scoped_guard() out of conceptual aversion to guard() buys us anything.
It's cleaner to read in such short functions very clearly.

