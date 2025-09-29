Return-Path: <linux-fsdevel+bounces-63002-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0155DBA89C3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Sep 2025 11:28:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F4B33C41E9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Sep 2025 09:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EB8A2D7398;
	Mon, 29 Sep 2025 09:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UX6hMhM1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E8D2C11CA;
	Mon, 29 Sep 2025 09:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759137794; cv=none; b=cMkBAsXoipLR0dfKMyrZl840GmW/a07PkZejU88nVPjpAkOs+2bVAYevn8rnRbnSIhTw3vfyPhpQtZ6S8OBXmetP06yHy3rCypIaHJCV94rdQxGpVbqb3Ctd670j/P41BRt8R50ZY8wPRyL6s4itIrCAk5GkRMnje+A5My7tI98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759137794; c=relaxed/simple;
	bh=Tuu6YujwqGd+Sgul2oqXSTLeZUDyik4tXs8KykJ+Czs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZRoxb/lyIvxjZX32+vuFg1UZfASavMPrKUTjQAa4PS08gEyxI3wUIJ1ETPcw7TX9PlGhYIeBSinngBabEdJBMLFUFHqSLNF5abHBpcrItZx5u75g3TC0/4HeDgMDmCmtIaWmDJbNZf/U4U2+0hnjnG4rKQa+gkX8gBNb9B1VnQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UX6hMhM1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27C89C4CEF5;
	Mon, 29 Sep 2025 09:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759137793;
	bh=Tuu6YujwqGd+Sgul2oqXSTLeZUDyik4tXs8KykJ+Czs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UX6hMhM15BJ/u4Wv37AsrwghQ7aRV2g/g6DIUoYDxt8o87olcbocHeb3XNsFvOiwr
	 qR35/cU7aLa84UmqqB3+GbqkN7LCb2Fs1xpHTzwutDUJD3SFLlBxwm0uVQ67FrRv+B
	 PQkcj2gW/f86EdZxQv1iybW9ejZHLVWzdF6IRimhROjLCl+cC6fhMM+bQUY5w1fK2r
	 kM2eAUp7DTBHTujdKmKZUvyUX2uV1zPtkqZSzGbhmMW6851bY6D89eyP0jPpheEcY8
	 xZ7q8zoL7m9hlWQCVpGBW7mnm0o4gaUcVSvEUKAAnS9eSf7rYhBzPcnfuJ1XUP1HKq
	 gtv+qZkU8jr0A==
Date: Mon, 29 Sep 2025 11:23:09 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Jan Kara <jack@suse.cz>, Edward Adam Davis <eadavis@qq.com>, 
	syzbot+0d671007a95cd2835e05@syzkaller.appspotmail.com, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH Next] copy_mnt_ns(): Remove unnecessary unlock
Message-ID: <20250929-wettmachen-gitarre-c5c25dcfd3bf@brauner>
References: <68d3a9d3.a70a0220.4f78.0017.GAE@google.com>
 <tencent_2396E4374C4AA47497768767963CAD360E09@qq.com>
 <mb2bpbjtvci4tywtg5brdjkfl3ylopde3j2ymppvmlapzwnwij@wykkbxztyw2f>
 <20250924175641.GT39973@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250924175641.GT39973@ZenIV>

On Wed, Sep 24, 2025 at 06:56:41PM +0100, Al Viro wrote:
> On Wed, Sep 24, 2025 at 02:03:56PM +0200, Jan Kara wrote:
> > On Wed 24-09-25 18:29:04, Edward Adam Davis wrote:
> > > This code segment is already protected by guards, namespace_unlock()
> > > should not appear here.
> > > 
> > > Reported-by: syzbot+0d671007a95cd2835e05@syzkaller.appspotmail.com
> > > Closes: https://syzkaller.appspot.com/bug?extid=0d671007a95cd2835e05
> > > Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> > 
> > Indeed. Feel free to add:
> > 
> > Reviewed-by: Jan Kara <jack@suse.cz>
> 
> I wonder where does that line come from, though.  Mismerge somewhere?
> d7b7253a0adc "copy_mnt_ns(): use guards" includes this:
> 
> @@ -4185,13 +4186,11 @@ struct mnt_namespace *copy_mnt_ns(unsigned long flags, struct mnt_namespace *ns,
>  	new = copy_tree(old, old->mnt.mnt_root, copy_flags);
>  	if (IS_ERR(new)) {
>  		emptied_ns = new_ns;
> -		namespace_unlock();
>  		return ERR_CAST(new);
>  	}
>  	if (user_ns != ns->user_ns) {
> -		lock_mount_hash();
> +		guard(mount_writer)();
>  		lock_mnt_tree(new);
> -		unlock_mount_hash();
>  	}
>  	new_ns->root = new;
>  

Fwiw, I just pulled next-20250926 and I don't see this bug. So I'm not
sure it's even a merge conflict or it was in an earlier -next version.

