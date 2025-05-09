Return-Path: <linux-fsdevel+bounces-48621-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 140E6AB17D8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 16:59:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD62BA06DC3
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 14:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5D77233144;
	Fri,  9 May 2025 14:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="Ezl4Qw9J"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43E2120F07E
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 May 2025 14:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746802789; cv=none; b=VeXe6ZXufbdSaijU2x8Xh3G+54Iez5tP4uVPT0p+iHKRK+k5N0wrGss2zqES9FvE2KJ6bBUG+ovW7pMRXnzo2BxcM2JETFa4MTG2xF5OGuOzIsOQGtmqkWip3+4FWi8PEPNCT3/D3bqTWFm+Uze1LzJFK7VZx8fMZ9HfHhKJR5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746802789; c=relaxed/simple;
	bh=OvMYc1/NUx+TgNc2MMSVWxhyIqAkyH8S2lTspemIULg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f+0g2n3CHUcbRlWO3Tp0/1sxWknidfluTsfF54b7Z8eYeASyqhTtiZ8dNzZH8WjUlzdej3/raxPEWv5F7HB63R6culvdV/jDW3ovbM7NWy6qZzimdc1wKuXdq3nnsHwWu2mkxVoPFTc71OLRzTtf/buChf98qlETmpLjBj9SUhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=Ezl4Qw9J; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-476b89782c3so24551261cf.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 09 May 2025 07:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1746802786; x=1747407586; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MNXRVZ0d/TjYbo6sUWZT1QLfUnTslA1zk9rlwUpo1tw=;
        b=Ezl4Qw9JDyf9TCS/xQkNcL6GUAoaAPjZGQx8bp0e0LqITQK5hY84mEMofy1A+lRelG
         W9EDyRJNcVysyC4Fb821TTgNVBPtPQ1PTD126FvPZCBnyOOZDpiuhiC08+9K8FRDNvtc
         JbxFMqzKThidN0ptbISq3Yq+Vls3nrawxX7pA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746802786; x=1747407586;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MNXRVZ0d/TjYbo6sUWZT1QLfUnTslA1zk9rlwUpo1tw=;
        b=b52E+dhkAYLc8QAxWECqi7DDSVsY5mI4CyCLSSlAfCArmGw7YzqVWYSV8X5r1+CfWN
         AKxN/7SZ18WClPMaXR0Isc1a6O4/0/4g3kgTrpPX6vd7wiOKwo9CtkwbRkd3xkpMjAgO
         ZccIDjw56yKlRldNt7ogujlMqh5ssbQ3ECLuQujSmN98aBl4ZgfgiME0QmMLvNzvjsCz
         nNvU/Oj/K54ndVbCl2ZBjT/mOKdGAaCD1/bzWtOFrcYKW1smfbOOMDKcEC983N/uSHo2
         +sUy/Htrc0RynWe4II0Mcj0WrgzK5A9GsJszIRQ9f4IyBqR37mcshhs6xH5+23DfrYh4
         8kfw==
X-Forwarded-Encrypted: i=1; AJvYcCU7fc70+dnkdHO+n5WfxXz3SlH1xlmpU7BVtBHRMxoGG1yFbljvMOd3/lYU7Uajho3jVL0qvm3MPFcvbABa@vger.kernel.org
X-Gm-Message-State: AOJu0YwYRHIzWVbj5JSOeYKjeKTnI524GRVASED5pxuE3zQQ4GZzevYn
	rW6hLGGo+XLIE5F9UDtAnMZjbd4E4JotVaybiZO3pvQBK5V28vui7OhW0OUMGUNnVk8dAONdYTo
	wjuRVKzV9+dSD7TzumVNjH0EtaS6RqnzZAd+jg0IabPDvIjMWiFY=
X-Gm-Gg: ASbGncv2mYXaxsf4/GAwQB5aIOG4AsFOjJTNGWUomMdwnCVNJx2mPpQ/ufk06jwhTLX
	XQYtFeYS42B0jNTDT/a40v9Babqd0Ttjr25YUlP0z0MRuPZTw7Eq9QEkEEt1xDEYQ8sIFV1DzVW
	F91jK5tIlynKQ+uteGEvCnlMyqBkB0fR777Mg=
X-Google-Smtp-Source: AGHT+IEGg5EPbwceICKwU9GYa8CHn/MC2J5tKBbA2YoAU+VowXJmNgUja1eah9jrraoBnCvYPjDb6UQWdVrv+wNUAJk=
X-Received: by 2002:ac8:598b:0:b0:48e:2503:9966 with SMTP id
 d75a77b69052e-494527efdd3mr43429321cf.51.1746802786021; Fri, 09 May 2025
 07:59:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250509-fusectl-backing-files-v3-0-393761f9b683@uniontech.com>
 <20250509-fusectl-backing-files-v3-2-393761f9b683@uniontech.com>
 <CAJfpegvhZ8Pts5EJDU0efcdHRZk39mcHxmVCNGvKXTZBG63k6g@mail.gmail.com> <CAC1kPDPeQbvnZnsqeYc5igT3cX=CjLGFCda1VJE2DYPaTULMFg@mail.gmail.com>
In-Reply-To: <CAC1kPDPeQbvnZnsqeYc5igT3cX=CjLGFCda1VJE2DYPaTULMFg@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 9 May 2025 16:59:34 +0200
X-Gm-Features: ATxdqUHzlndRCdmL06YZ6rW7gSuswirUqpTeDMbgj-3obx94kuYTadQnEG_x9Fo
Message-ID: <CAJfpegsTfUQ53hmnm7192-4ywLmXDLLwjV01tjCK7PVEqtE=yw@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] fs: fuse: add backing_files control file
To: Chen Linxuan <chenlinxuan@uniontech.com>
Cc: Amir Goldstein <amir73il@gmail.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 9 May 2025 at 16:43, Chen Linxuan <chenlinxuan@uniontech.com> wrote:

> Note that io_uring has already exposed information about fixed files
> in its fdinfo.

And that has limitations, since fdinfo lacks a hierarchy.  E.g.
recursively retrieving "hidden files" info is impractical.

> For io_uring, the path could be the corresponding /proc/PID/fd/* of io_uring.
> For FUSE, the path could be /sys/fs/fuse/connections/*.

Since lsof is ultimately interested in the mapping between open files
and processes, I think using  /proc/PID/fd/* for fuse is also useful.

> But for SCM_RIGHTS, what would the corresponding path be? Could it be
> the fd under procfs of unix domain socket?

Right.  But I'm not asking you to implement this, just thinking about
an interface that is generic enough to cover past and possible future
cases.

> I am also uncertain whether there might be similar situations in the future.
> Would we really be able to find a suitable path for all of them?

Open file descriptors are generic enough to represent most kernel
objects that need to be represented in userspace, so I think this is
not a worry.

Thanks,
Miklos

