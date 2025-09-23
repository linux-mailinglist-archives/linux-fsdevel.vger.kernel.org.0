Return-Path: <linux-fsdevel+bounces-62483-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C092BB94B53
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Sep 2025 09:10:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65A367AA8F9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Sep 2025 07:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 987E619DF66;
	Tue, 23 Sep 2025 07:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="MUDl3+Ds"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F291926CE15
	for <linux-fsdevel@vger.kernel.org>; Tue, 23 Sep 2025 07:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758611438; cv=none; b=XLVfK6m54E/pi8dJZBq5ED6/QauxeOB1rMM+EkiF2fON1IcJOEBL6d7q1w6kvNx4cIMwEastmiYrIaf6o1hskvodZaglKrfvF1kaOXAHt0q4XIYXd8Rkv8L9MWDxARQUbCLP9xCTOmBD01BfobxgqRbpSmlGjld55xc94QsqTRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758611438; c=relaxed/simple;
	bh=fH12eOrJkeuIYzMN4uSILgjgrPsFe7pqoYldSObT19M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hlpBfnQug/LCYy0+rZOKOBph5mmRHJWoUnQVXjDUiyyjVdORoDo4S0hjmmqKh3CVFh+NWTQealcCGo5rI3ih6KiY/boKu/1Lw/1ZB0UjE3O6GymP/Z80M+VRnxMAQsJz7AHXs7xnr8S8tntqh/wK8L7kCUmaMb6a796nRKHPOcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=MUDl3+Ds; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4d3aad01a9dso3438261cf.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Sep 2025 00:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1758611435; x=1759216235; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Zx4KAtlXII6+MRsPkHeERk1awByqcg438XULFFE7xJY=;
        b=MUDl3+DsUDKHQtkBNBhnwlJwXqY7+y2cclbaXiWmxxhHODhlcWlfjAQO48OMZGeEan
         MMFmea4LS2Zb+teGW9KWuDavN5Wm9r/m+J7QrezDZB0A9ZDW9iMnlO5nnjcOOgPURJCa
         nXHTncNcj9TUKZ/N/IBbPeZUCkwviCOxG8anY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758611435; x=1759216235;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zx4KAtlXII6+MRsPkHeERk1awByqcg438XULFFE7xJY=;
        b=OVVN/rjQGgxzdVxlVF8bySGdIaFGk0DkOStAAnTmyjqPRI4jRAW//kj/8SNGWvZVGC
         z9axMjSHfG319ibUblQWxvAuTYMrnlNEMxFh3TbezdOPLmjzh1Cl9kUvosLWQNoF+Fsr
         qv7xpOqbPD9dobPUCjxZGhwtfRDlCqgJlG68di1TMFLRZSifNZpBUuAuoHG2C2pPbzTh
         5q1XytlytyMHLezvpcM9osP66YWOdScDuqtJrAz6Yx1Qq88GIOWxGFzXAnir1LcDw7Lh
         RFBUWXT1pR6gjH7XbtmawYP6rcHXKWl1LNLKA8rBzOnuhDtNtC0qV9orAuEcHoai1BlG
         lIPQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxcjKmNUbu77zP654weQnPyGbh+KuSU4pr8Cgn+l3WTuvEq5tjvIfMFqGRvhpm870vprFnkCbmYiP17zPj@vger.kernel.org
X-Gm-Message-State: AOJu0Yw78Mu6JFSidea7PSQ77DTcsQiB9jPkMdjmTum3SF8RfncpJM9E
	lzi0ltmj9FxdZAdcCYJTmk1jOcjX13WV+x9uOC+tjxN8Dr6gIdQff5ViHh5JnaifgVBW5VhKXuA
	iTxxUGW8XBLjL4d7OsuIMrV0pk0dWD5ZzbJWlWkRxew==
X-Gm-Gg: ASbGncuo6zp6eTeHtKqEUtQkWBdKe+SpSvrvvfFTCLr+cYZl8ePMfNSucCfjzF+bTLK
	XZA/4ngCbQxqGE4fbvOX68anFCzTlrKAUS+eFKaBktZk1LhXJAzbpp7Xz7cAfLp4VACL2Kol1ak
	38VWDY9u4xfiPduM4zvB3XLZ2mdXkwV+lPz32nvUya6B+pluGTsejEt2KEhKnuhv2SS8Yg7DWET
	LjYjkKFXsvyQc5I7EF7iWpu4p8fz35OEmOtdIQ=
X-Google-Smtp-Source: AGHT+IHtIqh1nO/q8WRo3P7LNY5Dh+zBK2hbR8HfJdSGOKW3ZudbQtvlNUueEbZ6VdEgSehhe/S2kkvRpCjJza+llGM=
X-Received: by 2002:a05:622a:5587:b0:4b7:7fc4:45f7 with SMTP id
 d75a77b69052e-4d36e5dee72mr17411201cf.42.1758611434712; Tue, 23 Sep 2025
 00:10:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <175798151087.382724.2707973706304359333.stgit@frogsfrogsfrogs>
 <175798151352.382724.799745519035147130.stgit@frogsfrogsfrogs>
 <CAOQ4uxibHLq7YVpjtXdrHk74rXrOLSc7sAW7s=RADc7OYN2ndA@mail.gmail.com>
 <20250918181703.GR1587915@frogsfrogsfrogs> <CAOQ4uxiH1d3fV0kgiO3-JjqGH4DKboXdtEpe=Z=gKooPgz7B8g@mail.gmail.com>
 <CAJfpegsrBN9uSmKzYbrbdbP2mKxFTGkMS_0Hx4094e4PtiAXHg@mail.gmail.com>
 <CAOQ4uxgvzrJVErnbHW5ow1t-++PE8Y3uN-Fc8Vv+Q02RgDHA=Q@mail.gmail.com> <20250919174217.GE8117@frogsfrogsfrogs>
In-Reply-To: <20250919174217.GE8117@frogsfrogsfrogs>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 23 Sep 2025 09:10:23 +0200
X-Gm-Features: AS18NWCbS-teU2d7wmg71KZ8kBTNgaO5RTISqeIfj5N88p9b4fmTz2JnSimimuk
Message-ID: <CAJfpegsEL9oD5z+UQ9NDEQtKv55vHcbZGko0ZgMY9RXnZzFmBQ@mail.gmail.com>
Subject: Re: [PATCH 04/28] fuse: adapt FUSE_DEV_IOC_BACKING_{OPEN,CLOSE} to
 add new iomap devices
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Amir Goldstein <amir73il@gmail.com>, bernd@bsbernd.com, linux-xfs@vger.kernel.org, 
	John@groves.net, linux-fsdevel@vger.kernel.org, neal@gompa.dev, 
	joannelkoong@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 19 Sept 2025 at 19:42, Darrick J. Wong <djwong@kernel.org> wrote:
> I think capping at 1024 now (or 256, or even 8) is fine for now, and we
> can figure out the request protocol later when someone wants more.

Yeah, whichever.

> Alternately, I wonder if there's a way to pin the fd that is used to
> create the backing id so that the fuse server can't close it?  There's
> probably no non-awful way to pin the fd table entry though.

I don't think this could work.

My idea back then was to create a kernel thread for each fuse instance
and have FUSE_DEV_IOC_BACKING_OPEN/_CLOSE operate on the file table of
this thread.  Not sure how practical this would be.

Thanks,
Miklos


>
> --D
>
> > Thanks,
> > Amir.

