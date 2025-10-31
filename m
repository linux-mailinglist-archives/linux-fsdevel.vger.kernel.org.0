Return-Path: <linux-fsdevel+bounces-66586-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6133EC251D6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Oct 2025 13:56:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8C4174F4F49
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Oct 2025 12:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E446E342CA5;
	Fri, 31 Oct 2025 12:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QC191b6n"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4421D12DDA1;
	Fri, 31 Oct 2025 12:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761915272; cv=none; b=uodX637aXgOcwVAPAztaadgYAHWqHuZFbo4MLfTTLPtuR30fWdgCQq7fgFBaLwxHYwtptOB1pb44B+l8iOmYSxlQfxM3Jt/iF9b1Mp+hnliiMLBHNUjt9tuyFjUEzckQt+FDx8IrDLAcSILbwIJGkF+J6DfRbRSiYXc0ljZGa0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761915272; c=relaxed/simple;
	bh=s7+79ffWDBP2O1Ekl9g4IEvYubPlK22MnD2z/5IWwuQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G+rV6w73reVrq8gYR0I9n2PF7Yc0qDycknQYqpf0NG5HfmbXNQigGII2c4osZo0lZN/LTht+l/7P+zugXU8v7ApemWaO+sUheEf/zUsCTSeADNtB5exo/KQ2moWu+5nPSpWOLzy01rogNiIr860DRh+RiAf62M+mvjONnjWztv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QC191b6n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43BF9C4CEE7;
	Fri, 31 Oct 2025 12:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761915271;
	bh=s7+79ffWDBP2O1Ekl9g4IEvYubPlK22MnD2z/5IWwuQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QC191b6nXeKNfrKaDWuh6Obxm3u6z+iDiTufflV+Zh0uh6axmtDbWxI7uJquyShSn
	 0o8ImSxq5LDVqFDp4s89/oQqcI12apfQ2+rDs2M83fAn8AAMXIdsBp8rxGuXaU16cP
	 kvrWh8cQa1nf1UBWYdEM/1BDXm/PjownVbyYGWhAW/n8uc24JUfsffTw8QsiqMJp58
	 jFUYGbysqbEFzms3+yGdlpx4+PeK/W5KNifYI22F/Ah2dWS8kDVCkkyDkfjsbgO3dF
	 0De0hwb4cxy4ffNZ3q+mERMLt8FvWxD1A412Ec5s/qQxyjUjh+HfLvXBeZ6loHKo9S
	 nyToa8upovziw==
Date: Fri, 31 Oct 2025 13:54:27 +0100
From: Christian Brauner <brauner@kernel.org>
To: GuangFei Luo <luogf2025@163.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] mount: fix duplicate mounts using the new mount API
Message-ID: <20251031-gerufen-rotkohl-7d86b0c3dfe2@brauner>
References: <20251025024934.1350492-1-luogf2025@163.com>
 <20251025033601.GJ2441659@ZenIV>
 <788d8763-0c2c-458a-9b0b-a5634e50c029@163.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <788d8763-0c2c-458a-9b0b-a5634e50c029@163.com>

On Sat, Oct 25, 2025 at 02:02:51PM +0800, GuangFei Luo wrote:
> 
> 
> On 10/25/2025 11:36 AM, Al Viro wrote:
> > On Sat, Oct 25, 2025 at 10:49:34AM +0800, GuangFei Luo wrote:
> > 
> > > @@ -4427,6 +4427,7 @@ SYSCALL_DEFINE5(move_mount,
> > >   {
> > >   	struct path to_path __free(path_put) = {};
> > >   	struct path from_path __free(path_put) = {};
> > > +	struct path path __free(path_put) = {};
> > >   	struct filename *to_name __free(putname) = NULL;
> > >   	struct filename *from_name __free(putname) = NULL;
> > >   	unsigned int lflags, uflags;
> > > @@ -4472,6 +4473,14 @@ SYSCALL_DEFINE5(move_mount,
> > >   			return ret;
> > >   	}
> > > +	ret = user_path_at(AT_FDCWD, to_pathname, LOOKUP_FOLLOW, &path);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	/* Refuse the same filesystem on the same mount point */
> > > +	if (path.mnt->mnt_sb == to_path.mnt->mnt_sb && path_mounted(&path))
> > > +		return -EBUSY;
> > Races galore:
> > 	* who said that string pointed to by to_pathname will remain
> > the same bothe for user_path_at() and getname_maybe_null()?
> > 	* assuming it is not changed, who said that it will resolve
> > to the same location the second time around?
> > 	* not a race but... the fact that to_dfd does not affect anything
> > in that check looks odd, doesn't it?  And if you try to pass it instead
> > of AT_FDCWD... who said that descriptor will correspond to the same
> > opened file for both?
> > 
> > Besides... assuming that nothing's changing under you, your test is basically
> > "we are not moving anything on top of existing mountpoint" - both path and
> > to_path come from resolving to_pathname, after all.  It doesn't depend upon
> > the thing you are asked to move over there - the check is done before you
> > even look at from_pathname.
> > 
> > What's more, you are breaking the case of mount --move, which had never had
> > that constraint of plain mount.  Same for mount --bind, for that matter.
> > 
> > I agree that it's a regression in mount(8) conversion to new API, but this
> > is not a fix.
> Thanks for the review. Perhaps fixing this in |move_mount| isn't the best
> approach, and I don’t have a good solution yet.

Sorry, no. This restriction never made any sense in the old mount api
and it certainly has no place in the new mount api. And it has been
_years_ since the new mount api was released. Any fix is likely to break
someone else that's already relying on that working.

