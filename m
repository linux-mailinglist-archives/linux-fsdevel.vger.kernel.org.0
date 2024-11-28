Return-Path: <linux-fsdevel+bounces-36067-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 835719DB648
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Nov 2024 12:09:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39653164881
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Nov 2024 11:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54FB1194C96;
	Thu, 28 Nov 2024 11:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ivd8PnJW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 404281946C8
	for <linux-fsdevel@vger.kernel.org>; Thu, 28 Nov 2024 11:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732792189; cv=none; b=KtwTSlSHVScBDFIOaacUM8mY+rqOog20oDH09jk3MwvoJWUxRO/ywEufHqhJL796ofS0XFFd9JQq+8VI7cmr5zDdpHZLufRIUhBMbGPN+ImY1BGkkr/0AeTX/58Llr90YVdA6TK+5vc0g02HLxQ+Md1FuThO6od/b1eHkxMOb8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732792189; c=relaxed/simple;
	bh=BjHnUpgHa9d8ABqVb/Ix4JQWpOGl2+Jv/HoK5z9CH4s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kjzUu19QFZf8Qf6rl3UK1S6inN2o29WFnSZLRVjCt5VVpeyu9xQAI5HGw64I4oBhYne0B3wagtV7p3RT/QtHPiW/IFjEoN6pB+pc7Sl7HrPsH35VcYTFH5xt5uRIZBNEwwL5MJaBIc0q7fsz9V219eiRBVYJcIO08LsOR5FGL74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Ivd8PnJW; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-724f41d520cso480930b3a.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Nov 2024 03:09:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732792187; x=1733396987; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pBrFE+bpthASpm2LcgtJNskCJm/FukDUPjoycU3sFWE=;
        b=Ivd8PnJW0X8921NJOdAezibvx1j8AtQnFIbT7A603hkG73w09xwwuXoyCIbXaQh42n
         breDN6VxU111E7dEK/+Vy3KW98MIUhIFDkJb/4DeZINQvpx7nASSK5+f+gpTXNb+srOl
         ENhi4Co/7oGdIC57HDNdYkLRVhyNfbhV+MaUs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732792187; x=1733396987;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pBrFE+bpthASpm2LcgtJNskCJm/FukDUPjoycU3sFWE=;
        b=q+a6gDQtYLhoUoB7ZRN/s7WC1vuxykKXB3+9LpyNNM+a0+JOt/UfP9NttB4B+21VuA
         8ZNRKakvwrHoC+1KSSg5a/g1TumYafEurxopt6SaA25axKdWAxH1Wi20zBeZPZDA+Mod
         Yps6zvaAf6PrsVmtD63nRoWQN3J3FxrzhxI+c+nnnsXl9XvB5YsnfWN2KNh9S/NANH0h
         GGU1x4KLPqcDRkh/Owtut7lCIqyZBRS/Wpx9G3T45GLckpcCvlnv0CT2SMVpOTxY5wTP
         Srv9dbHB8JQwd8EG8O6d+sS0Urmmir23q4Km2OsW0zc7a2AUZ/BdUKbbwc/aHXJ3+SaX
         PZbg==
X-Forwarded-Encrypted: i=1; AJvYcCXWDORHoJDwSraBoJOLgZ68uJqRmDY6WL19ABHlOgN+vG1zgQ1d0kPw2WdMq/UpmaJIMxRnaURi74z5M9V7@vger.kernel.org
X-Gm-Message-State: AOJu0YxFSMXKKgIDBWl9TcQSgJOE3VJPL6QnnxY6NxtSx5luUvaTNyYF
	hsskkmsyLKVFs8nOW0+JSW7QfS/pw2qZr1EHuayc7o9Y3AszuKFhailZqIzrug==
X-Gm-Gg: ASbGncsRAEEmzyHJzcDzRmOl2N60+mHr3+QJ5WQ8w05vwXJrqYyoMsiac8H+YBGPUz6
	TVFlP7a/hNzfnVifZZuVFSl7REDG+LNKigw2zK76X+8kxO5fZP06eS0ErceFHy4K0R+2P+dnxEM
	6VGBhk86xSFBp3fupQB3//XZalsiyK2I+3a7rfFZ3wnkTpRgtFgrskuWuSvi0VLk3nEWP4pKAAd
	kJya5QNojmkCtEzb17/xRlv+NEsSWC3+NakAjPmMf+OabQN8RrSEg==
X-Google-Smtp-Source: AGHT+IGjJlVao+r71tmRrCkPfXwkPOY+UXy0tHWCIcBgBLh0rRFxp5FisWTN736ikgCpKOp2OXmCEg==
X-Received: by 2002:a05:6a00:14d5:b0:724:6f2d:eb0c with SMTP id d2e1a72fcca58-72530013a1fmr8607791b3a.7.1732792187480;
        Thu, 28 Nov 2024 03:09:47 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:e87e:5233:193f:13e1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7254177d4e4sm1250877b3a.86.2024.11.28.03.09.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2024 03:09:47 -0800 (PST)
Date: Thu, 28 Nov 2024 20:09:42 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Bernd Schubert <bernd.schubert@fastmail.fm>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Joanne Koong <joannelkoong@gmail.com>, miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org, josef@toxicpanda.com,
	jefflexu@linux.alibaba.com, laoar.shao@gmail.com,
	kernel-team@meta.com, Bernd Schubert <bschubert@ddn.com>
Subject: Re: [PATCH RESEND v9 2/3] fuse: add optional kernel-enforced timeout
 for requests
Message-ID: <20241128110942.GD10431@google.com>
References: <20241114191332.669127-1-joannelkoong@gmail.com>
 <20241114191332.669127-3-joannelkoong@gmail.com>
 <20241128104437.GB10431@google.com>
 <25e0e716-a4e8-4f72-ad52-29c5d15e1d61@fastmail.fm>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <25e0e716-a4e8-4f72-ad52-29c5d15e1d61@fastmail.fm>

On (24/11/28 12:00), Bernd Schubert wrote:
> On 11/28/24 11:44, Sergey Senozhatsky wrote:
> > Hi Joanne,
> > 
> > On (24/11/14 11:13), Joanne Koong wrote:
> >> There are situations where fuse servers can become unresponsive or
> >> stuck, for example if the server is deadlocked. Currently, there's no
> >> good way to detect if a server is stuck and needs to be killed manually.
> >>
> >> This commit adds an option for enforcing a timeout (in minutes) for
> >> requests where if the timeout elapses without the server responding to
> >> the request, the connection will be automatically aborted.
> > 
> > Does it make sense to configure timeout in seconds?  hung-task watchdog
> > operates in seconds and can be set to anything, e.g. 45 seconds, so it
> > panic the system before fuse timeout has a chance to trigger.
> > 
> > Another question is: this will terminate the connection.  Does it
> > make sense to run timeout per request and just "abort" individual
> > requests?  What I'm currently playing with here on our side is
> > something like this:

Thanks for the pointers again, Bernd.

> Miklos had asked for to abort the connection in v4
> https://lore.kernel.org/all/CAJfpegsiRNnJx7OAoH58XRq3zujrcXx94S2JACFdgJJ_b8FdHw@mail.gmail.com/raw

OK, sounds reasonable. I'll try to give the series some testing in the
coming days.

// I still would probably prefer "seconds" timeout granularity.
// Unless this also has been discussed already and Bernd has a link ;)

