Return-Path: <linux-fsdevel+bounces-25928-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 246A9951EF8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 17:46:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D5481F23CCC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 15:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98E0C1B5839;
	Wed, 14 Aug 2024 15:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="Fd6F1YzY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 250C61B5815
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Aug 2024 15:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723650400; cv=none; b=nViH06W7OfBfmVBZPMsmdCANe+Ox+Ch2g6yGuWzShqNFEzfla0CH8zZ3+w4Of8w/1/MqgXXkCrQYksxhoCuyoZPrVrOlSQxCpLdK1D9qXFsA+PJeL4+HHePJsfxyyEpLZmqGYuRp8xmEoaUm4ovCLp+HPXlW6KIuNCOfSl7+7Mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723650400; c=relaxed/simple;
	bh=3CZ+eZQLTvRe5s8+CdkE8KJ8fPl1lbuinuD2iVYUImE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZkP/o9v4855jhFj6a3w2O2dA6CRDCcV+HCf8T2ZhMceUN8HuG0fmdpm6ODgtnhoSHFdpBbj/1lqp76wZxZvaFEsSwYsI6pZIwIs0U5Vw/hVUmsI6dsRMMDO875vpBsf4Aza5AWcql0flcHaWCNgyRHUm+cvE185MKYsNgMmyfUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=Fd6F1YzY; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2ef2c56d9dcso353901fa.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Aug 2024 08:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1723650396; x=1724255196; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UMvW5XN814MmHmeNdCsuQ+x/zBS9ZcHLiBHoPUEkIYk=;
        b=Fd6F1YzY7RgsiEhc4a1ml1Rr2waWCADgGhCnIqbCpF5cO93cBaPpzW4nrkxK7Rllqi
         m8iGbN9oxduu8REIlhm0oXvKqdTq6nRqp7FpN6smp/XWu8uHZEhYx0eiJ0yG1Mt942U4
         KiyqDwt6Zpqun9b6SPRd05oiHq/lDbNunTeTc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723650396; x=1724255196;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UMvW5XN814MmHmeNdCsuQ+x/zBS9ZcHLiBHoPUEkIYk=;
        b=fchT3A4Vh98clqpDH2xjrIVtJPpHn++ahS9HquJhXStJUBGYhp+i6IFhp9z+jC451x
         9Hmq3muNqjef7mxCPP1+lveilu58U2ankoCPgBRBOkVfPqK0nnQW0ttHNFJyq/XdKyYi
         OEgyTuOQy6p/R4DZeDXkFN4ZVeUv1XG7Lir5mSjok5pGWk/GHmGk5tKDinakxEdJsa1R
         88OjYqjsDtv9EChnsNEPIPwqNu1YCsDHiWD48FnHGRPMvlIUsTLjzyiTh6UZN1rrA/VC
         cKUn32vVU8aXExhmG+RWDD2LZhK3BmEmc4CssNhImlpLwB7keAbdAHPS/fT72M41yiKL
         DE+w==
X-Forwarded-Encrypted: i=1; AJvYcCU0cXcKjyWUD3qE41CG4ell2UdBTicRSYSA57t2FOLOfYTuYhkQV37iE3lcycBCUPOIjtsvdyH6bMfq15eVXOmbHaNV/6BLQc3yVnEyDw==
X-Gm-Message-State: AOJu0Yxfm7QD7b1dQd7wEHP0xBtJWh40SixHVq1qiKChG/F+w6Ylk+8/
	qIt5Sid+TaWiIC/Mdn5ktyscTQ9q1saU4ugaZaZxmvmtwPHrRQU/L3zxrWs6zic=
X-Google-Smtp-Source: AGHT+IFAW+r4bsXhzgqn4nSPYnHoVTMgVTn+Fc+6nuodprTLSx0anVrp0sa8TsMaaN15SPWkigXMXg==
X-Received: by 2002:a05:651c:b2c:b0:2f3:a854:78f6 with SMTP id 38308e7fff4ca-2f3aa1de7c6mr25666671fa.34.1723650396054;
        Wed, 14 Aug 2024 08:46:36 -0700 (PDT)
Received: from LQ3V64L9R2 ([80.208.222.2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429df78a7c6sm18550645e9.45.2024.08.14.08.46.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 08:46:35 -0700 (PDT)
Date: Wed, 14 Aug 2024 16:46:33 +0100
From: Joe Damato <jdamato@fastly.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Martin Karsten <mkarsten@uwaterloo.ca>,
	Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	amritha.nambiar@intel.com, sridhar.samudrala@intel.com,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Breno Leitao <leitao@debian.org>,
	Christian Brauner <brauner@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Jan Kara <jack@suse.cz>,
	Jiri Pirko <jiri@resnulli.us>,
	Johannes Berg <johannes.berg@intel.com>,
	Jonathan Corbet <corbet@lwn.net>,
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
	"open list:FILESYSTEMS (VFS and infrastructure)" <linux-fsdevel@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [RFC net-next 0/5] Suspend IRQs during preferred busy poll
Message-ID: <ZrzRWU_39wpePVvg@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Martin Karsten <mkarsten@uwaterloo.ca>,
	Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	amritha.nambiar@intel.com, sridhar.samudrala@intel.com,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Breno Leitao <leitao@debian.org>,
	Christian Brauner <brauner@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Jan Kara <jack@suse.cz>,
	Jiri Pirko <jiri@resnulli.us>,
	Johannes Berg <johannes.berg@intel.com>,
	Jonathan Corbet <corbet@lwn.net>,
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
	"open list:FILESYSTEMS (VFS and infrastructure)" <linux-fsdevel@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
References: <2bb121dd-3dcd-4142-ab87-02ccf4afd469@uwaterloo.ca>
 <ZrqU3kYgL4-OI-qj@mini-arch>
 <d53e8aa6-a5eb-41f4-9a4c-70d04a5ca748@uwaterloo.ca>
 <Zrq8zCy1-mfArXka@mini-arch>
 <5e52b556-fe49-4fe0-8bd3-543b3afd89fa@uwaterloo.ca>
 <Zrrb8xkdIbhS7F58@mini-arch>
 <6f40b6df-4452-48f6-b552-0eceaa1f0bbc@uwaterloo.ca>
 <66bc21772c6bd_985bf294b0@willemb.c.googlers.com.notmuch>
 <Zry9AO5Im6rjW0jm@LQ3V64L9R2.home>
 <66bcc87d605_b1f942948@willemb.c.googlers.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66bcc87d605_b1f942948@willemb.c.googlers.com.notmuch>

On Wed, Aug 14, 2024 at 11:08:45AM -0400, Willem de Bruijn wrote:
> Joe Damato wrote:

[...]

> > On Tue, Aug 13, 2024 at 11:16:07PM -0400, Willem de Bruijn wrote:
> > Using less CPU to get comparable performance is strictly better, even if a
> > system can theoretically support the increased CPU/power/cooling load.
> 
> If it is always a strict win yes. But falling back onto interrupts
> with standard moderation will not match busy polling in all cases.
> 
> Different solutions for different workloads. No need to stack rank
> them. My request is just to be explicit which design point this
> chooses, and that the other design point (continuous busy polling) is
> already addressed in Linux kernel busypolling.

Sure, sounds good; we can fix that in the cover letter.

Thanks for taking a look.

