Return-Path: <linux-fsdevel+bounces-15198-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF3E288A2C0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Mar 2024 14:44:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6667B2C8C1E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Mar 2024 13:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AF9A1429B;
	Mon, 25 Mar 2024 10:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Uq2X0aGi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA475156864
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 Mar 2024 08:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711356198; cv=none; b=rcgXLmz+CBWns8/ZI+Fs0/H5TDDpqG2gaDbwwUJsvMff0XJig3qnVJe/0ukbHJj0Txvj3pW6BMEJoHc1n74JAlOkcRjox+1rK6kDVayNQUo4r/Pd0/IoWwyHL/BdKMlhTI0KQos749twDOKO7kI9bRN55vJ4aYZOgzOeWyQhuzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711356198; c=relaxed/simple;
	bh=bUngXxE+xkBJBbVYn9yVX78eixbXv9i58GAmXmTCTXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o3C1VaxyHPGYyVCfnRUKiZkqtXK/1StNQrWXYVFsK6UqC5m+gDbNuWm1ydbyeALF7Z2Nc/zIkU92p5q8rp2ZK7lVw0+FfqYkMGrROn7GVKjyKB7U20xn7YCtFdfFHBP2lhTTU4uIdcDx8+gmP2x9KjFYhmOrur3VtKTsfd5ZkGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Uq2X0aGi; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-56bf6418434so1992561a12.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Mar 2024 01:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711356195; x=1711960995; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BU/kZtD50v5ty9hTrosmBTlEPTlQkgsM/cmQtKt4ASY=;
        b=Uq2X0aGiPP6659mGmBecJf0iF6pHRtGWD7o73MdnlCX9COg2UQ56RFSjYPHB8Zw6w4
         zUhgkT3PbQY/79568h7TKS1pe0GMbApWyi5U9wzJWGku/hJhV7jC1d0xzgcwEAazT/Xl
         eZRWX5AV+OWUf5WR9NxfWufW2ZCteojQffwTXI8MW4IcxxSvjTHQHbamgIqrmASWfSyH
         i12FgkosOrqjED07zRc50XTZtsVu3595Bmo7vMNBSHrTBfx91pNKJk/8JON7D8U7shu8
         zIv6NyHptpD5hNyEVy6kPDgTzWZ7mNZ/rfrRozXdCFr8zb05GZvYmZ3yKaW2miwLmEgo
         TBzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711356195; x=1711960995;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BU/kZtD50v5ty9hTrosmBTlEPTlQkgsM/cmQtKt4ASY=;
        b=I0ovO+BiiFUhORECDyMPLn+XdEUWRrdIi/a1a8YpAsyStSPXGLHOeatRCZ0Ay9Omf8
         jcOHiAd/3VzuzyP7OqdSkl7sKVOMPCG+ksmaB/U41817g5fjIoW4RKArdNTh1l4plojf
         sRKHK5zEsoqK9kA4KgVcJFZCOcUvWO46Q4UbQ/uCS1U1x69EYpwTu92xn7uPrRfkeKfn
         SsDKhJStAK+MOO1fVLxa11vsjlPeeXa7bMvbuQ1n61yObJpmHCYOgOmKCENR2/10LWSY
         7yCV3oNKkxWJMtWvLuH4MYtTKxG4Zm4MCoxXkgjJzInipOmFuO9Tb2XUZWquG6D+bmce
         5B+w==
X-Forwarded-Encrypted: i=1; AJvYcCW2vE9iLTrkQj4CmjNfRwfwIRlyivoocKH84em5lh573MQf5EofPVRIeA6w0fo7zoDkbyzoRujEpfOlfyUNij4q7pMDlenRPwFJxSFFAQ==
X-Gm-Message-State: AOJu0YzGw4l+mYP7YFw0av1tdNkC8SbfS0GWUxIItyMSrHq7O18B9Hpt
	rLUnfcmB0IVjj8PtaFusUH6JlPmHZjLFLJCYD3yXxmv18MQA/bjCoK6ZcxkTFRM=
X-Google-Smtp-Source: AGHT+IHm8wLajdzgjk/MuRvLkI6fuVlUObnTwIEp04GFoqsU+9MezaVkJdiYQxD7kW3ahZS26eaIbQ==
X-Received: by 2002:a17:906:c210:b0:a47:37af:3783 with SMTP id d16-20020a170906c21000b00a4737af3783mr4341914ejz.15.1711356194818;
        Mon, 25 Mar 2024 01:43:14 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id m19-20020a1709060d9300b00a45c9945251sm2774263eji.192.2024.03.25.01.43.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 01:43:14 -0700 (PDT)
Date: Mon, 25 Mar 2024 11:43:10 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: NeilBrown <neilb@suse.de>
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	Dave Chinner <david@fromorbit.com>,
	Matthew Wilcox <willy@infradead.org>,
	Amir Goldstein <amir73il@gmail.com>, paulmck@kernel.org,
	lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	Jan Kara <jack@suse.cz>, Jiri Pirko <jiri@resnulli.us>
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Reclamation interactions with RCU
Message-ID: <4fd3337d-bfb1-4292-adec-44a5081c3224@moroto.mountain>
References: <170925937840.24797.2167230750547152404@noble.neil.brown.name>
 <ZeFtrzN34cLhjjHK@dread.disaster.area>
 <pv2chxwnrufut6wecm47q2z7222tzdl3gi6s5wgvmk3b2gq3n5@d23qr5odwyxl>
 <170933687972.24797.18406852925615624495@noble.neil.brown.name>
 <xbjw7mn57qik3ica2k6o7ykt7twryod6rt3uvu73w6xahrrrql@iaplvz7t5tgv>
 <170950594802.24797.17587526251920021411@noble.neil.brown.name>
 <22363d0a-71db-4ba7-b5e1-8bb515811d1c@moroto.mountain>
 <171107206231.13576.16550758513765438714@noble.neil.brown.name>
 <fa490acb-2df6-435d-a68f-8db814db4685@moroto.mountain>
 <171131951305.13576.14679515391685379475@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <171131951305.13576.14679515391685379475@noble.neil.brown.name>

On Mon, Mar 25, 2024 at 09:31:53AM +1100, NeilBrown wrote:
> On Fri, 22 Mar 2024, Dan Carpenter wrote:
> > On Fri, Mar 22, 2024 at 12:47:42PM +1100, NeilBrown wrote:
> > > On Thu, 21 Mar 2024, Dan Carpenter wrote:
> > > > On Mon, Mar 04, 2024 at 09:45:48AM +1100, NeilBrown wrote:
> > > > > I have in mind a more explicit statement of how much waiting is
> > > > > acceptable.
> > > > > 
> > > > > GFP_NOFAIL - wait indefinitely
> > > > 
> > > > Why not call it GFP_SMALL?  It wouldn't fail.  The size would have to be
> > > > less than some limit.  If the size was too large, that would trigger a
> > > > WARN_ON_ONCE().
> > > 
> > > I would be happy with GFP_SMALL.  It would never return NULL but might
> > > block indefinitely.  It would (as you say) WARN (maybe ONCE) if the size
> > > was considered "COSTLY" and would possibly BUG if the size exceeded
> > > KMALLOC_MAX_SIZE. 
> > 
> > I'd like to keep GFP_SMALL much smaller than KMALLOC_MAX_SIZE.  IIf
> > you're allocating larger than that, you'd still be able to GFP_NOFAIL.
> > I looked quickly an I think over 60% of allocations are just sizeof(*p)
> > and probably 90% are under 4k.
> 
> What do you mean exactly by "keep"??

Poor word choice...

> Do you mean WARN_ON if it is "too big" - certainly agree.
> Do you mean BUG_ON if it is "too big" - maybe agree.

WARN_ON_ONCE().  But a lot of people have reboot on Oops enabled so
triggering a WARN_ON() is still a very serious bug.

> Do you mean return NULL if it is "too big" - definitely disagree.

Yeah.  It's going to be a style violation to check a GFP_SMALL
allocation for NULL so it needs to have GFP_NOFAIL behavior.  It can
still fail if it's larger than KMALLOC_MAX_SIZE.

> Do you mean build failure if it could be too big - I would LOVE that,
> but I don't think we can do that with current build tools.

The limit is going to be a constant so using static analysis to check
that is easier than checking if we're less than some variable.

regards,
dan carpenter

