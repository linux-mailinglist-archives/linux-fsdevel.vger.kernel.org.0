Return-Path: <linux-fsdevel+bounces-14388-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6155787BB38
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Mar 2024 11:27:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 934F11C215E1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Mar 2024 10:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A73546E617;
	Thu, 14 Mar 2024 10:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="CIiG0e0s"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7E16E611
	for <linux-fsdevel@vger.kernel.org>; Thu, 14 Mar 2024 10:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710412033; cv=none; b=XE036KPANldexquQ5L8S46ut1YLOCy6A+D7egkJ8VvIiwXCHK2Ox0Q3jMS2YLxaZD/NE52ngJo2aNGSy7NNYEpM89E+65IVjFmkbHRVkl5bDZ7b2MQkyIScbCHkq6i37Ciq5rw7xRx1yB7L7VNv/fpxQlRGJGASHNBU0Rkhxyjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710412033; c=relaxed/simple;
	bh=xm+12QsRWjVqEyNWvXZ3fPFkVKObLKtHIVOdkkX+GxA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dmMroEdOMECfS1PEidYS3qgdz2Itu1+WCxmDGV6d91UdsofFoswMIySMoPUlAp095h09CeWLSQ1H4AJDW8GKw6h7sVt61tv4m6x53fBeuAVnM7QYh7nlLOiMkzsIdYqy6GcyzGpH43ofTaoCwnVs7DJX+PfVa/huu9smaQk4w/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=CIiG0e0s; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5658082d2c4so1001279a12.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 14 Mar 2024 03:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1710412029; x=1711016829; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HyCrZF0S6/AN4txJLcOCf1mC4pcCBWG+g1HjV7ZYWbo=;
        b=CIiG0e0s2PFqZwwoqYgJNFLuBL3fB4AZug35OD4flaUXt9eRJCcVx/bPtXFpUZNk6Y
         0DlU7laZbxdJ6zVT5gDyv9PbhPs+3/lAFzQcUbIKxLrpSNmQnoS5wZOm21latROEh4za
         pQagiqAQefvQKGuV0e/QcjxLYlm9jfhpE8L3c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710412029; x=1711016829;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HyCrZF0S6/AN4txJLcOCf1mC4pcCBWG+g1HjV7ZYWbo=;
        b=w2+a17CrnttFvx6g3bJWdij+rfb3KoH0ZxQw9HsRaw+CLcPCEP2CUFuHyGAHveeK6K
         +rulL/ByAvhIpacFtKUZcxjvx4XUjvItD7aSeyOM8uxGzKifVRCrXsFjjoGoyIGDRc9U
         ihqJvqYuxH7UxrLc3H1KIhr/dAdqnpJfFcnFQlTY7f1SjDUcZPCzC3Q145ZSFjnefMKL
         9Hdij/R9OfRWqGFBMyOX1VbrDzjBaYWHC10KywioJBnisHJlAZNm/xaSNieZSXei9Vwx
         6YBemd36YiLFmRmKvVsu0nk7SihGXcvY1j7x0uKJXREWig9MWpkh6SZVkEm1G9R3Yp0a
         Ecsg==
X-Gm-Message-State: AOJu0YwARewHC32JeEK97FMITh7pqiauaYa+dyDS90N/UAdnW+U8mjGg
	FVn9CGok7h9f19xUvYmCBKArKoip/EDu8td/303Dmm4CHM7eb/YPHi0Q8KczAFe+DseRRQr2lXM
	NCW0kNAJdx5DwUAed1+ApB4g87xCzrIaERHzuDw==
X-Google-Smtp-Source: AGHT+IF9M1b81BLOCeh33LBiaScfPVqjmpJTx93xIL7bkxaDtLPCKqlJR17iSrTUXR0QSLNHFhy7Ot1bMY1B3ymLAJo=
X-Received: by 2002:a17:906:3545:b0:a46:1fb:1df with SMTP id
 s5-20020a170906354500b00a4601fb01dfmr810828eja.42.1710412029213; Thu, 14 Mar
 2024 03:27:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <9d71a4fd1f1d8d4cfc28480f01e5fe3dc5a7e3f0.1709821568.git.sweettea-kernel@dorminy.me>
 <CAJfpeguHZCkkY2MZjJJZ2HhvhQuMhmwqnqGoxV-+wjsKwijX6w@mail.gmail.com> <4911426f-cf12-44f4-aef1-1000668ad3a0@dorminy.me>
In-Reply-To: <4911426f-cf12-44f4-aef1-1000668ad3a0@dorminy.me>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 14 Mar 2024 11:26:57 +0100
Message-ID: <CAJfpegunc+rw1ekUk=FJ6HYg8FkXdm3CBrCRcmNU2i6uw7WNGw@mail.gmail.com>
Subject: Re: [PATCH] fuse: update size attr before doing IO
To: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Cc: linux-fsdevel@vger.kernel.org, kernel-team@meta.com, josef@toxicpanda.com, 
	amir73il@gmail.com, Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Type: text/plain; charset="UTF-8"

On Tue, 12 Mar 2024 at 19:18, Sweet Tea Dorminy
<sweettea-kernel@dorminy.me> wrote:

> The alternative we considered was to add a fuse_update_attributes() call
> to open.

I think the atomic open patchset from Bernd should allow updating
attributes together with open.  Which should solve this case.

I also have a patch introducing the concept of leases to fuse, which
would make the concept of who "owns" the data more formal.  I'll work
on refreshing it.  The interesting part will be interaction with
passthrough.

Thanks,
Miklos

