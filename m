Return-Path: <linux-fsdevel+bounces-16207-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B6A989A191
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Apr 2024 17:41:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B51731F21CAF
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Apr 2024 15:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 886E116FF2B;
	Fri,  5 Apr 2024 15:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cIbe4UZc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9425F4689;
	Fri,  5 Apr 2024 15:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712331695; cv=none; b=rL4J2vHKgpKsDoa6TwnZVrKbZuwMaStLe13jOD2vsRMhakRW3ncGUz2+AUx6rK8jYngp/mEzY/nVhc+ih6lsD/ozkaqdT4NtJgCHigTnJQYA7NuUxvdpAGVUPf6cG0j13S0Cn9IUXNxp3yHXMq42ZkS3Id6RcydylSKEj+SOEVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712331695; c=relaxed/simple;
	bh=fjFv2oGljsYZ8RlUB2XmSpfbt8CKLn8bKBCjtdk8lZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q/j1c/5wLjGanZgTiWa6qNMLVTIpMrlEwF4NiTVHTUYGH/RLawpTj6n/Gs5/CM/7DpuvC4GhF5cTUS6Kja+rtzUmfdCd32o/zhAirJsnfduKzMEuU+2kj+/9zeVWR3hKwY+2w+mM8OvsIrMbYR3JTdJayajkOfYwXtcr6uuRKaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cIbe4UZc; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-5cfd95130c6so1747687a12.1;
        Fri, 05 Apr 2024 08:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712331693; x=1712936493; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tZ5Mwph3/XmYRqypIO/r8wSsIZPfEOkaYE7lglREnJo=;
        b=cIbe4UZcoD57IsRNUDKdHGwXUip+bwQu//hWtlZgjuodMLdqdicajRGTSfTHI9xcC3
         zepVR/fK5SzaSrvE4I++rIipXUyZ2FhnkX3d0VKfe5FC+MghHcsf1/dxzDCatZbg5SRl
         kqqWtONiEf4PCFPl0qTQkOGRlsVXgtZczk3hl/vB5EUSi/FtgGuneyo1G7E7F2CpOD33
         kf2xAWLJA2xk8mWo1FhwM26CpijYNz0yTTJlKju5SCslgRYBG7uUPolVXEwJHTc/SdRW
         AnGI70lzHf9PwAUv+jOVqhsuG1MFE/WVBbOqnsNfp5P1/xA8BrRdsWdhLvZHgdAkGot7
         +Y9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712331693; x=1712936493;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tZ5Mwph3/XmYRqypIO/r8wSsIZPfEOkaYE7lglREnJo=;
        b=hVx4t6J85f9GXFbbUR6UrmDf3/hH2mMNnQooi8XsCK1fE3N49Qn6D6THYskPDTCia7
         Kz5EoHLOr4T+45R8BnEFoDy7u5TEAvooVOYyx749brQXMD9a11fmDuhmTUQbJKg4p+Mt
         o5JRL0qyX3Gnsi2tTIsxYZxVPAqQne649LFVW2wu80KzsCG+gE/bvrmyI4jgJ2TAYw6S
         gmyrBaZo6au4EKKMlhE0ROR4c9n1ZA9rfwYNQyXWwE6Ui7jcCVIix+pbuvaAvypUaNA0
         7LnMaHcWdxXiVSgqeJSUR77YMqjiFrXxNhUf+ayUi/41/o+lyqvGx6B6TegO6wtQd2D8
         xNtA==
X-Forwarded-Encrypted: i=1; AJvYcCUTVhvVbqUUT1d/eLXNxaBDKDVUsZ0bBoT+qDb5LU18NejVVObxCTUuXuRLhGl+XXZ0okCcLHkZv9FpFTglwf4FSNXr4/aa4fnURZEzqUxcsOE0vSOlCJ8oiDfbuwopR/5RYYJsEuwI7X6t7A==
X-Gm-Message-State: AOJu0YxHEtOJlHmI3QKd3RpFVIIzXOxl2sm1gURu+Pv90z7eAdYQWexi
	waGsFkYMU0O6nZOkYKCkVsmKOyetcIzhmaEaDZsT6Yh2naBdyNxg
X-Google-Smtp-Source: AGHT+IEi5erSHhlEtyUDl4ceLZr3Ogc9RUtr0VOL67S+SNiFqrklx1MYFA8hVBtxvmQQZtaaq/dLLg==
X-Received: by 2002:a17:90b:4414:b0:2a3:be59:e969 with SMTP id hx20-20020a17090b441400b002a3be59e969mr1447018pjb.47.1712331692857;
        Fri, 05 Apr 2024 08:41:32 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:25ab])
        by smtp.gmail.com with ESMTPSA id d18-20020a17090ac25200b002a219f8079fsm1656244pjx.33.2024.04.05.08.41.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 08:41:32 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Fri, 5 Apr 2024 05:41:30 -1000
From: Tejun Heo <tj@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Amir Goldstein <amir73il@gmail.com>, Al Viro <viro@zeniv.linux.org.uk>,
	syzbot <syzbot+9a5b0ced8b1bfb238b56@syzkaller.appspotmail.com>,
	gregkh@linuxfoundation.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
	valesini@yandex-team.ru, Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>, Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: [syzbot] [kernfs?] possible deadlock in kernfs_fop_llseek
Message-ID: <ZhAbqvXeeZ0mz2ZX@slm.duckdns.org>
References: <00000000000098f75506153551a1@google.com>
 <0000000000002f2066061539e54b@google.com>
 <CAOQ4uxiS5X19OT2MTo_LnLAx2VL9oA1zBSpbuiWMNy_AyGLDrg@mail.gmail.com>
 <20240404081122.GQ538574@ZenIV>
 <20240404082110.GR538574@ZenIV>
 <CAOQ4uximHfK78KFabJA3Hf4R0En6-GfJ3eF96Lzmc94PGuGayA@mail.gmail.com>
 <20240405065135.GA3959@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240405065135.GA3959@lst.de>

Hello,

On Fri, Apr 05, 2024 at 08:51:35AM +0200, Christoph Hellwig wrote:
> On Thu, Apr 04, 2024 at 12:33:40PM +0300, Amir Goldstein wrote:
> > I don't follow what you are saying.
> > Which code is in non-starter violation?
> > kernfs for calling lookup_bdev() with internal of->mutex held?
> 
> That is a huge problem, and has been causing endless annoying lockdep
> chains in the block layer for us.  If we have some way to kill this
> the whole block layer would benefit.

of->mutex is mostly there as a convenience to kernfs (here, sysfs) users so
that they don't have to worry about concurrent invocation of the callbacks.
It needs more careful look but on cursory observation, it shouldn't be
difficult to implement a flag or different op type which skips of->mutex if
this causes a lot of pain.

Thanks.

-- 
tejun

