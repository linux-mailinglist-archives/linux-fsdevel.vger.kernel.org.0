Return-Path: <linux-fsdevel+bounces-69881-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9138BC89971
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Nov 2025 12:48:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 76E734E4532
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Nov 2025 11:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E71BC325494;
	Wed, 26 Nov 2025 11:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="VOuGzfx2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5607C320A0D
	for <linux-fsdevel@vger.kernel.org>; Wed, 26 Nov 2025 11:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764157682; cv=none; b=OrIhz22oBsP2lCBkgdWHX5KAIjLGr4UYP5tsLF4i6cSd5x6T7dW7dNt6pzro9tb3Cptt/NbjsrPclofTmO5IhHo4Y9Vc558lfHv8wjmWBraon6+OVA/G4SJVY2UjIhZUB4LvWYZC00hQXiBZWSE1RITa6xwkal2XHa6lk+O66jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764157682; c=relaxed/simple;
	bh=4O7jgySbMcJkLhg+PrL7yjifT5q2ij1NuUvZr5tjjJo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iLTaev11Ievp+TtfIc6gCSPLMREndAtWfDYSbK1tUBR5+XZoSFkOMrx9IXfZkmkaPLjIUPrFDBI4ZgQWfbzYo7FtDVw0xsrrG6LkAmsqDWB5/k6L4xddxkpwsYNopO3EeLAQ6CgspNzapgRhYKUXGqBkVEceLzgT196z+JivSI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=VOuGzfx2; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4ede6b5cad7so25921451cf.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Nov 2025 03:48:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1764157679; x=1764762479; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BLKOGEBOWC7uykTpFffxCnUm0v64AscVBGyJtT1rdTQ=;
        b=VOuGzfx29CkEbkrI1noWvHMWrYWtcEAS89SJVd+hZiQLS8GLL9lgcvcoiFL1sdik4z
         3Nwz0uedJYX11yYI0YHq88gii31XtHE2ZLFNZYe7gySHglDNBH7RwEH5wFnfwMJ/PVOI
         ax8+G6digBgyIUgM/PtT+6MKfDR2/LLuvzOgE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764157679; x=1764762479;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BLKOGEBOWC7uykTpFffxCnUm0v64AscVBGyJtT1rdTQ=;
        b=rIg5U4PEAhZVj3IiyQbbwqn56uisBlw3cFExDN7Hx9V2qByixHRo5BsAG5djA+18je
         GL3rRxiJOcaanvbD2VCPymSilSkNOgQxtHV7R9BLU/JmpSsPlDXgR+q7grlnLgly4nA6
         2U6WLc5htVbYtEVLR2vX1jRmvR2oqtGN/T0mlUgFyJhqj0zOiorSBzGB09ZujtD1v12l
         k2WvhVuIDo9+A3lr5A/QOFSoeuvRIQHr7fF+YRYg9rczr0EP8AALdbYNnvr64MHyxaGR
         /R/Gw9y0guAbJOakhZFIUbPU3fKqApHWG0pgUNhHP7chySw4YMBskjaNO9lRyKMpmv8U
         xOPA==
X-Forwarded-Encrypted: i=1; AJvYcCWVWiH7hGsqxn3iCzUyf8h/Wp7F5+3Gk06iFRsVYHc+/X9d90EGJuHTXJqMIKs0Bhrxq49nMoUloBWPoR/g@vger.kernel.org
X-Gm-Message-State: AOJu0YwFONrfgThfY2qSuJykvpartWMaackXqaeNwn+WhwUFNIPdyWcH
	9otTcb22l7FKLBvP5BWeD2MD0Jth0eb83GpEyCLqzhrgmFf7fP991usf5gIbnmyE97JQzBtnaCr
	3lICJX8rtM+hkPzT7Nhzz2pBAhr58inSZqS9SmlxTmw==
X-Gm-Gg: ASbGncubSEuIisjHiT3AGnlwa6DTt0E+XicmOCMJfn+NjuOKwTIubF5ZRpLLE5zUeFJ
	QkeRAXtK5dAtUF3GsSvPpayHJWtRW0FFzTMTsPmMsO4mi0J1CpQhjfrHxrSMBl9sWmdXTBl1An5
	Zx9uAXuHOPdiYOf8qnCytwAx2VtRdTfVC8ZyjKEOG9aBeZOiP9NI2nTK1Y7yARSwtrp0AP1yWZa
	WzNInDVj0HoalKum4xhofIT/WeSAIhqaOc8xQ4XsxmewHz4SuUXBs0u9Hvac2cC4FRXQA==
X-Google-Smtp-Source: AGHT+IG4szwDZ081eiwPu6e8wnBK6+JbjcwhY5/NTsvzbpX29nJZHZ7+aOplZyZt2DzkggNCzH1Gzb7H5BXIzibNHXs=
X-Received: by 2002:ac8:5a87:0:b0:4ec:f2d8:9817 with SMTP id
 d75a77b69052e-4efbd8f5cf4mr72591521cf.26.1764157679282; Wed, 26 Nov 2025
 03:47:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aSP1iMPil7wTnboD@stanley.mountain>
In-Reply-To: <aSP1iMPil7wTnboD@stanley.mountain>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 26 Nov 2025 12:47:47 +0100
X-Gm-Features: AWmQ_bljsEjNml8xxPC1oDm2c1EpX7z5TuWP1P7GQPAoAzkU82dlBPGJC6-hYvA
Message-ID: <CAJfpegsnFYLkHP=KCwkK1UW=KJOqFPKX9H28G4BERkzebg=igQ@mail.gmail.com>
Subject: Re: [PATCH v2] fuse: Uninitialized variable in fuse_epoch_work()
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Luis Henriques <luis@igalia.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 24 Nov 2025 at 07:05, Dan Carpenter <dan.carpenter@linaro.org> wrote:
>
> The fuse_ilookup() function only sets *fm on the success path so this
> "if (fm) {" NULL check doesn't work.  The "fm" pointer is either
> uninitialized or valid.  Check the "inode" pointer instead.
>
> Also, while it's not necessary, it is cleaner to move the iput(inode)
> under the NULL check as well.
>
> Fixes: 64becd224ff9 ("fuse: new work queue to invalidate dentries from old epochs")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> Reviewed-by: Luis Henriques <luis@igalia.com>

Applied, thanks.

Miklos

