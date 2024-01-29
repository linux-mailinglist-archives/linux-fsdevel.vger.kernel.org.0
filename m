Return-Path: <linux-fsdevel+bounces-9376-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE04A84067D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 14:16:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8808528A551
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 13:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4934662804;
	Mon, 29 Jan 2024 13:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xzz7UJ9I"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 477E15BAD2
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Jan 2024 13:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706534181; cv=none; b=OE1IRJsy9jujzGgPa/1CnwACVzd9JghaNjYAeTIO9zsLnQEE1CpHzs/buEtSlPRPY3j3vaifU7KN1s5tmaCp8JVD4K1SX6g1dlhs4weUYPufngFLOS0RwNEAA4fmHj/4YEerPWupwD5QQJZBH8aLM0EXxvLPIXVPbI6U4KSCcFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706534181; c=relaxed/simple;
	bh=kGxA5hm/lgN4Izl0zMPyH8ilOLAwdv/7UUaa19didCw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ipnEFeIFHnAycr+coXPmijUUgPD2Uq+xfGMXymZF6Af43qshBi7YbHEnBVkpYNG2F/wdgblF6vjZHk4yj4wTe1lpoUowkNRcUCa+rfa5RDSOLBIQPcXjt74Yjko0fao4EibejWSETGLlFBLoZ0gOdwZ8q5wFeyPxF9sSJ+As7o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xzz7UJ9I; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-783f7db2833so105090685a.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Jan 2024 05:16:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706534179; x=1707138979; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kGxA5hm/lgN4Izl0zMPyH8ilOLAwdv/7UUaa19didCw=;
        b=Xzz7UJ9IReTxiJeKT/v6K3DHKq9Vf0EERgFq9BakGEWB8gJBvb1A4urq+u3seD1brQ
         EDFd1tf3J0nJpzdPLlbT//ktQpBnAx9y56kVk+HeHgwBRqt1WWDuWt/HB5lXvdkkgAdh
         sYoQenp85BrswGaOSx+4pbbnuVg6CVplqO/n2pJpDdIZ1AGPeZqD2KhjJHih2d3ded8G
         G0y9DeuErCntx79bzlJ+UJ8XIuI6/iSpLQavlWAucYLaLXq6Lu+ykV/iVJ3bBotu2NXW
         eFn5MbMDuSIncpyp834Xo0kGbWwJXq25IPCTlct8aELtVReQV6OTiZtq9ZFrCjeoPhnd
         BtIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706534179; x=1707138979;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kGxA5hm/lgN4Izl0zMPyH8ilOLAwdv/7UUaa19didCw=;
        b=XQ/c2p3W1DbvYYgaz7mdx0FIllx+FgN/zO6JJN5s1yaKFFUA4hRvK3a1VsaXH4XPyx
         WycpchPIq/Skq3JOeI+Ud0xPbSYzpWUjppYxrHHdERGAj8s2o3CW3a/TxIzYYh2DNM8J
         DcN5JT8hMrR759dgHYi88IoaQ8dEz82i6K0NvFQMweVJmvlrtbeIfY1itsPPm2DSF9na
         AxczD2PrldQJ4y7ighL1PV/QT9IJoSUdXUwCPbeAfnre9lbU8vdrOsSkrhCUSDPAtxiD
         iEJlTddmZQCjEPFl1Lixq81iNGPJJ8/H0SikOhgPCh6a4L6xEn1U2Lnjt9NeQygE0ndH
         oX+g==
X-Gm-Message-State: AOJu0YyCXE12AW4xLJSaUmwKS0OzKsHszBy0SF/Rd4elmo62DcwVsGc7
	3gDJaLzjM+MjJeK4+NDcBm/dAHXiSEbnm2tNHGVVnW1g9XYm9orbrozlRadsHEFL6jOMdypaIxX
	mYmNycqQGk+Gnab8wojXNHY8sQx4=
X-Google-Smtp-Source: AGHT+IEDqfY+CmT5kOpCpuyA2YlIRLF3h3kvQC2ea32DS/mm5ZZqXflAnkRxsWdfbwujUrkvjhoM/i2KQ6kpWXBwT3A=
X-Received: by 2002:a05:6214:f08:b0:680:aedb:72fe with SMTP id
 gw8-20020a0562140f0800b00680aedb72femr7377169qvb.81.1706534179095; Mon, 29
 Jan 2024 05:16:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <b1603752-5f5b-458f-a77b-2cc678c75dfb@app.fastmail.com>
 <9ed27532-41fd-4818-8420-7b7118ce5c62@fastmail.fm> <92efd760-a08c-4cb1-90ab-d1d5ddb42807@spawn.link>
 <3435db6c-d073-4e60-adfd-53b2e0797b3c@fastmail.fm>
In-Reply-To: <3435db6c-d073-4e60-adfd-53b2e0797b3c@fastmail.fm>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 29 Jan 2024 15:16:07 +0200
Message-ID: <CAOQ4uxju6Y1=a0c1Qwf1YdTL2A2RdDcS58zK_cQVPqMD+pXSOA@mail.gmail.com>
Subject: Re: Future of libfuse maintenance
To: Bernd Schubert <bernd.schubert@fastmail.fm>
Cc: Antonio SJ Musumeci <trapexit@spawn.link>, Nikolaus Rath <nikolaus@rath.org>, 
	Martin Kaspar via fuse-devel <fuse-devel@lists.sourceforge.net>, 
	Linux FS Devel <linux-fsdevel@vger.kernel.org>, Miklos Szeredi <miklos@szeredi.hu>
Content-Type: text/plain; charset="UTF-8"

> >> I'm maintaining our DDN internal version anyway - I think I can help to
> >> maintain libfuse / take it over.
> >>
> >> Btw, I also think that kernel fuse needs a maintenance team - I think
> >> currently patches are getting forgotten about - I'm planning to set up
> >> my own fuse-bernd-next branch with patches, which I think should be
> >> considered - I just didn't get to that yet.
> >>
> >>
> >> Thanks,
> >> Bernd
> >
> > +1 for Bernd's maintenance *team* idea. But perhaps extended to libfuse
> > as well? There are a number of us who are familiar with the code and at
> > least semi-active in the space. Help spread the load.
> >
> > I could help out at least on the libfuse side.
>
> You are absolutely right, a team is always better.

Might also be a good opportunity to start the linux-fuse mailing list
on kernel.org.
I find the disjoint fuse-devel and linux-fsdevel mailing lists a bit
counter productive
for new fuse feature development, which afaik, are mostly driven by linux-fuse
driver developers these days.

Thanks,
Amir.

