Return-Path: <linux-fsdevel+bounces-48808-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34896AB4CB6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 09:30:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC0C119E6EC0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 07:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E42EC1C84B9;
	Tue, 13 May 2025 07:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nViPHHmF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49EFD2A1BB;
	Tue, 13 May 2025 07:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747121443; cv=none; b=k+3kHKMOUlQFlyHMw4Bb/cUz6hxjFMcwZrYZa4OUeIfMei6L5eRFy2n25jz1AwGhNM7cQAswVZcc/DJmq2dc43Xq3T45coKo260VbXHX93ARKR4KBXqQjZQDOFMG68+ZrA1KxCD6SQdPASKtOp947sEq8xZReS01U+pJFKBkueM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747121443; c=relaxed/simple;
	bh=e0W5zD3Z/rUIBfKIvoR8sZZ93vdqxvih8z26GrLG1eA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UQjq4eKQMiN6rE2MW8ZeVdaZy5/9C9z3FpK1ITuqp78aez2Ho0zJ5H2xcJzuwZeZa+xzRa98r0K4UVIRlCr1DxLoKnbEKjEYN/8AHvc1FGoW/PM/oJ4JCEDII1AQTgXpuQBSQP3VfKXMstgXrVq7y3xfSic3p1Mp3xAylLWbUnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nViPHHmF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 783A9C4CEE4;
	Tue, 13 May 2025 07:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747121442;
	bh=e0W5zD3Z/rUIBfKIvoR8sZZ93vdqxvih8z26GrLG1eA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nViPHHmFsRL5pagwe7eX8bDvNlcezCXzc5ulm9DKz1yZAjGk+Ryq2pjrI3MaTcA05
	 ZfSpArxDwO3GlT3vF866LhzBQjqR1xUX1yZ9ywOdblU1nMY+LwMiAKrU5g0psDnemw
	 AybwtVGmgz8i7Wp/fwsoFJ0UJf4Kj8icjUPSjEH+ce2n3DtlSbMpTh3VLtkys0vy6p
	 HeL3njbnpPdthwqHdlqkfntFx0ijOY6viAoq1X0QrmHlpduoXAQx/Zsn4Q0+Udn98e
	 LBlMR3+WcK1iQ1MmlDH/D/a3uvU2qeJIq/N+CAw8QtReOZ4HR1dfC4+qB663BT7NcS
	 l8oQgHBNn8qPA==
Date: Tue, 13 May 2025 09:30:39 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Max Kellermann <max.kellermann@ionos.com>, viro@zeniv.linux.org.uk, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] fs: make several inode lock operations killable
Message-ID: <20250513-gebilde-beglichen-e60708a46caf@brauner>
References: <20250429094644.3501450-1-max.kellermann@ionos.com>
 <20250429094644.3501450-2-max.kellermann@ionos.com>
 <20250429-anpassen-exkremente-98686d53a021@brauner>
 <CAKPOu+8H11mcMEn5gQYcJs5BhTt8J8Cypz73Vdp_tTHZRXgOKg@mail.gmail.com>
 <20250512-unrat-kapital-2122d3777c5d@brauner>
 <hzrj5b7x3rvtxt4qgjxdihhi5vjoc5gw3i35pbyopa7ccucizo@q5c42kjlkly3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <hzrj5b7x3rvtxt4qgjxdihhi5vjoc5gw3i35pbyopa7ccucizo@q5c42kjlkly3>

On Mon, May 12, 2025 at 07:33:13PM +0200, Jan Kara wrote:
> On Mon 12-05-25 11:52:14, Christian Brauner wrote:
> > On Tue, Apr 29, 2025 at 01:28:49PM +0200, Max Kellermann wrote:
> > > On Tue, Apr 29, 2025 at 1:12 PM Christian Brauner <brauner@kernel.org> wrote:
> > > > > --- a/fs/read_write.c
> > > > > +++ b/fs/read_write.c
> > > > > @@ -332,7 +332,9 @@ loff_t default_llseek(struct file *file, loff_t offset, int whence)
> > > > >       struct inode *inode = file_inode(file);
> > > > >       loff_t retval;
> > > > >
> > > > > -     inode_lock(inode);
> > > > > +     retval = inode_lock_killable(inode);
> > > >
> > > > That change doesn't seem so obviously fine to me.
> > > 
> > > Why do you think so? And how is this different than the other two.
> > 
> > chown_common() and chmod_common() are very close to the syscall boundary
> > so it's very unlikely that we run into weird issues apart from userspace
> > regression when they suddenly fail a change for new unexpected reasons.
> > 
> > But just look at default_llseek():
> > 
> >     > git grep default_llseek | wc -l
> >     461
> > 
> > That is a lot of stuff and it's not immediately clear how deeply or
> > nested they are called. For example from overlayfs in stacked
> > callchains. Who knows what strange assumptions some of the callers have
> > including the possible return values from that helper.
> > 
> > > 
> > > > Either way I'd like to see this split in three patches and some
> > > > reasoning why it's safe and some justification why it's wanted...
> > > 
> > > Sure I can split this patch, but before I spend the time, I'd like us
> > > first to agree that the patch is useful.
> > 
> > This is difficult to answer. Yes, on the face of it it seems useful to
> > be able to kill various operations that sleep on inode lock but who
> > knows what implicit guarantees/expectations we're going to break if we
> > do it. Maybe @Jan has some thoughts here as well.
> 
> So I think having lock killable is useful and generally this should be safe
> wrt userspace (the process will get killed before it can notice the
> difference anyway). The concern about guarantees / expectations is still
> valid for the *kernel* code (which is I think what you meant above). So I
> guess some audit of kernel paths that can end up calling ->llseek handler
> and whether they are OK with the handler returning EINTR is needed. I
> expect this will be fine but I would not bet too much on it :)

Great. @Max you want to send an updated version where split into
separate patches?

