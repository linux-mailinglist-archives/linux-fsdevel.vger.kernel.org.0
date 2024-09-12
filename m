Return-Path: <linux-fsdevel+bounces-29156-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 640C79767FD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2024 13:37:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96A961C2100F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2024 11:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 270D8190079;
	Thu, 12 Sep 2024 11:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DeUpvYmS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C28190482
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Sep 2024 11:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726141020; cv=none; b=Yh1OXzUYaTA1B1n1iNoIlPsmmHBatcIet3IkomLrdKorMnMun7sxbEgrPWkNGR2VLqIyJ2p51SorU3OiWclnyK1MzhXVhfKnaHX2LRuttSLjNVpKgg1y5mSDBNXfjMoWwUcM8GIc/CkVgEpp+Pd3GjscHIg9Urq3Q5YpH0ta/qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726141020; c=relaxed/simple;
	bh=9f2GbLLwUW0BkAz7MmT3DlEAAt7E3+wC1Y2NPkV6CCQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xv8NE7zVXohI+NfezN2rkvVjkaSIFlietPmxureGk3uvY2H7VlS/GxZSz2Oa0d7XOlIXdDNrQqhUFM8KrsG6ycbFc0SDS1t+/aPMBrzXTHNFJmzBwig92eiTNUCJ6DvhkwqlOb/HAZvUAUO7P9bHhMq4PJ88dbdMZ5qi34E1d+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DeUpvYmS; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-374ca65cafdso574822f8f.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Sep 2024 04:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726141016; x=1726745816; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qo+/z/H6YP7glZxEKDzAxkCwRAdU2ktBeKwS3tGOJB0=;
        b=DeUpvYmSjw0W4A7+qdH+sjgg5Ji62ieZcdj9ya1lOmgVMdAX8R0juwv/yx20bFtmj/
         Y5zz1pH338y+T00MOu3dQamMmZmMZfC0hNcfvz6kvDI7RsMVOMo3s7JTiF/OrdCIzTMq
         qfFviZh1oTfKtxcHwauHXMTG1Zqh6CFAVGrcTDsoIJwe5mSbZgesIqIqCWOuHxL8HjJi
         tXHb1JKsVCp6ynLuOy6bAS1MzR+UmI3Q/cIHghiBYNvys9IHHWTtDSDgj3S4s8UxX0Gz
         Pna21KsYxcAxZjeyZxhcwNidn434rkCMHZl3oj6sv5cxYGJvUQyi0Pazd7mHnhqgmcmT
         z0Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726141016; x=1726745816;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qo+/z/H6YP7glZxEKDzAxkCwRAdU2ktBeKwS3tGOJB0=;
        b=j3X0gucUwfGJFDTxkSjsStqXxIXblj8a+a0+J14n9lJM+4ZHZTng/joNEk+m4Ma3mW
         dR/8BG6ruwCs5z6fMYxoC85blQy1UGpA+xkyv4T41nY8QJ78A8JII0ItR024ZurIZJJa
         HTTSd0lOu5STGEx43G7dnXt4NbmM4Z6L4CWA82dTAsXhCnuRkiMm8C75U0mcumF9iWP1
         Ieyy/v0NCyf/dKhKSGU3OYAnBZmKSjLdP0jkL+eWA83IucZpEwiXApKnKD3REsVzmTT0
         Xf5PLfpHqIhHyySyRL7nMz5w7c5NHsk1AmcRstKQRSQzLGCYKmiXHcaUyoYKHngjw1nn
         1XcA==
X-Forwarded-Encrypted: i=1; AJvYcCXPhGkbnkVq2MSd2MIf/EwAKo44Z04WKJP1FCUQ4n7Gxpbu9swpS1rz9Hxdnx+6snGQz0vAQoAfTB8aE5x0@vger.kernel.org
X-Gm-Message-State: AOJu0Yxpb6DndQKiCbccO8Nqh3UyuPxkFURE4i+r+g9GUwW/oGsWmcAX
	FPtG5QiD08LJk3bcop/0gtEDBx0zSvzzCdzrnYO6JpCTPcTFya5G
X-Google-Smtp-Source: AGHT+IFnw6dHcd8i/qYm2bdIa0j4Bea62zSvUWe1fmDxL2gbB2wyt+SjZFwSqnHfePsoD+JQDR0Gww==
X-Received: by 2002:adf:e3cf:0:b0:377:2df4:55f6 with SMTP id ffacd0b85a97d-378c2cf3d5dmr1414932f8f.17.1726141015744;
        Thu, 12 Sep 2024 04:36:55 -0700 (PDT)
Received: from f (cst-prg-85-144.cust.vodafone.cz. [46.135.85.144])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42caeb44473sm170388925e9.26.2024.09.12.04.36.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 04:36:54 -0700 (PDT)
Date: Thu, 12 Sep 2024 13:36:45 +0200
From: Mateusz Guzik <mjguzik@gmail.com>
To: Jan Kara <jack@suse.cz>
Cc: Yafang Shao <laoar.shao@gmail.com>, torvalds@linux-foundation.org, 
	viro@zeniv.linux.org.uk, brauner@kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC] vfs: Introduce a new open flag to imply dentry
 deletion on file removal
Message-ID: <f7bp3ggliqbb7adyysonxgvo6zn76mo4unroagfcuu3bfghynu@7wkgqkfb5c43>
References: <20240912091548.98132-1-laoar.shao@gmail.com>
 <20240912105340.k2qsq7ao2e7f4fci@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240912105340.k2qsq7ao2e7f4fci@quack3>

On Thu, Sep 12, 2024 at 12:53:40PM +0200, Jan Kara wrote:
> On Thu 12-09-24 17:15:48, Yafang Shao wrote:
> > This patch seeks to reintroduce the concept conditionally, where the
> > associated dentry is deleted only when the user explicitly opts for it
> > during file removal.
> > 
>
> Umm, I don't think we want to burn a FMODE flag and expose these details of
> dentry reclaim to userspace. BTW, if we wanted to do this, we already have
> d_mark_dontcache() for in-kernel users which we could presumably reuse.
> 

I don't believe any mechanism letting userspace hint at what to do with
a dentry is warranted at this point.

> But I would not completely give up on trying to handle this in an automated
> way inside the kernel. The original solution you mention above was perhaps
> too aggressive but maybe d_delete() could just mark the dentry with a
> "deleted" flag, retain_dentry() would move such dentries into a special LRU
> list which we'd prune once in a while (say once per 5 s). Also this list
> would be automatically pruned from prune_dcache_sb(). This way if there's
> quick reuse of a dentry, it will get reused and no harm is done, if it
> isn't quickly reused, we'll free them to not waste memory.
> 
> What do people think about such scheme?
>

I have to note what to do with a dentry after unlink is merely a subset
of the general problem of what to do about negative entries.  I had a
look at it $elsewhere some years back and as one might suspect userspace
likes to do counterproductive shit. For example it is going to stat a
non-existent path 2-3 times and then open(..., O_CREAT) on it.

I don't have numbers handy and someone(tm) will need to re-evaluate, but
crux of the findings was as follows:
- there is a small subset of negative entries which keep getting tons of
  hits
- a sizeable count literally does not get any hits after being created
  (aka wastes memory)
- some negative entries get 2-3 hits and get converted into a positive
  entry afterwards (see that stat shitter)
- some flip flop with deletion/creation

So whatever magic mechanism, if it wants to mostly not get in the way in
terms of performance, will have to account for the above.

I ended up with a kludge where negative entries hang out on some number
of LRU lists and get promoted to a hot list if they manage to get some
number of hits. The hot list is merely a FIFO and entries there no
longer count any hits. Removal from the cold LRU also demotes an entry
from the hot list.

The total count is limited and if you want to create a negative dentry
you have to whack one from the LRU.

This is not perfect by any means but manages to succesfully separate the
high churn entries from the one which are likely to stay in the long
run. Definitely something to tinker with.

If I read the original problem correctly this would be sorted out as a
side effect by limiting how many entries are there to evict to begin
with.

I'm not signing up to do squat though. :)

