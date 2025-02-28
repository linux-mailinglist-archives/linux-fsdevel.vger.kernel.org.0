Return-Path: <linux-fsdevel+bounces-42838-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75148A496DC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Feb 2025 11:18:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9994E174C61
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Feb 2025 10:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C27C25C6EF;
	Fri, 28 Feb 2025 10:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mLqOEgup"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B0C1957FF;
	Fri, 28 Feb 2025 10:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740737806; cv=none; b=TIz9TwY4VeWCDpT7dMbgJC3cGNGXWUZH0UbmONOvdFdJtbsVKrF2ggcEK499EUgwuAcov8++ieNhBhUp4DuAuwoybsUq7atuxvVkr6O1tJ6H6BAlvVilPe93ECrY+k7h0arUGtIf7h9TmGbtGf0yn/qT8+E6OGa7T0Nv4uhnfTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740737806; c=relaxed/simple;
	bh=xplsmJGPsBQ8UanuLRWY/+EKejwxGRiN7g/vc4yJnxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jazxPyFBIyvUP+UuJcj6pJXlgyNAcFJmLoxGJtznOaCCuOTwaPfpzQ+thcEJRESfHrblP5XEJLTfF87v2aJFrLQz4z7HxtXnFttPfvpuRCdRbULyx/WEAF0x9exU1J3ghMCX+h7EdlLswPC0WvahuIAIAu5bYGKd8OuhAOlC6o8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mLqOEgup; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59CFCC4CED6;
	Fri, 28 Feb 2025 10:16:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740737805;
	bh=xplsmJGPsBQ8UanuLRWY/+EKejwxGRiN7g/vc4yJnxQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mLqOEgup9S6oObZnrpTVaZE5xrUyII39jc+rjP75/4oia/+Kmf6Fra4hrIXrUbOen
	 EkMNBr70KbgQ32p31sTHi0/UoZ7Jz9X5N47fcCUxJNPpl0j1QBt3WETym582eWo55v
	 KPkiES/mlU7EbYNkvjCotS8nlMX6bdf52MHeaSqC/I5veSJ2qO3ktOkCkFUMMb5T+l
	 fzJYji+2Vc+HcKRdVxaMv5fbSZ3KCTozoR1arVO46wJXhCP60pxvkvNby6JmH/m4CO
	 ZhX72VaF6k9G/bZEKcBrnfYLfGbUegG8D5S9FrFszcV93YlXZm6RrtARLnIRydaQyc
	 oRjbCaKP58fUg==
Date: Fri, 28 Feb 2025 11:16:41 +0100
From: Christian Brauner <brauner@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Oleg Nesterov <oleg@redhat.com>, viro@zeniv.linux.org.uk, jack@suse.cz, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] pipe: cache 2 pages instead of 1
Message-ID: <20250228-neuverfilmung-teeservice-076e89999806@brauner>
References: <20250227180407.111787-1-mjguzik@gmail.com>
 <20250227215834.GE25639@redhat.com>
 <CAGudoHG7EF5_wnNhsyFoiRtU-qW1b=vUaVaFk7TKnqeSjC6sOg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGudoHG7EF5_wnNhsyFoiRtU-qW1b=vUaVaFk7TKnqeSjC6sOg@mail.gmail.com>

On Thu, Feb 27, 2025 at 11:07:45PM +0100, Mateusz Guzik wrote:
> On Thu, Feb 27, 2025 at 10:59 PM Oleg Nesterov <oleg@redhat.com> wrote:
> > > +static struct page *anon_pipe_get_page(struct pipe_inode_info *pipe)
> > > +{
> > > +     struct page *page;
> > > +
> > > +     if (pipe->tmp_page[0]) {
> > > +             page = pipe->tmp_page[0];
> > > +             pipe->tmp_page[0] = NULL;
> > > +     } else if (pipe->tmp_page[1]) {
> > > +             page = pipe->tmp_page[1];
> > > +             pipe->tmp_page[1] = NULL;
> > > +     } else {
> > > +             page = alloc_page(GFP_HIGHUSER | __GFP_ACCOUNT);
> > > +     }
> > > +
> > > +     return page;
> > > +}
> >
> > Perhaps something like
> >
> >         for (i = 0; i < ARRAY_SIZE(pipe->tmp_page); i++) {
> >                 if (pipe->tmp_page[i]) {
> >                         struct page *page = pipe->tmp_page[i];
> >                         pipe->tmp_page[i] = NULL;
> >                         return page;
> >                 }
> >         }
> >
> >         return alloc_page(GFP_HIGHUSER | __GFP_ACCOUNT);
> > ?
> >
> > Same for anon_pipe_put_page() and free_pipe_info().
> >
> > This avoids the code duplication and allows to change the size of
> > pipe->tmp_page[] array without other changes.
> >
> 
> I have almost no opinion one way or the other and I'm not going to
> argue about this bit. I only note I don't expect there is a legit
> reason to go beyond 2 pages here. As in if more is warranted, the
> approach to baking the area should probably change.
> 
> I started with this being spelled out so that I have easier time
> toggling the extra slot for testing.
> 
> That said, I don't know who counts as the pipe man today. I can do the

Linus or David should have the most detailed knowledge.

> needful(tm) no problem.

