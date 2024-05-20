Return-Path: <linux-fsdevel+bounces-19776-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AE1F8C9B25
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2024 12:23:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3381C28127F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2024 10:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A22094DA10;
	Mon, 20 May 2024 10:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PpdrA4wE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4EC114285
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 May 2024 10:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716200584; cv=none; b=hwuu0RQkDllNRGcIYbALrMS1rhDTjrpOWcT3/ZiQG9izlob/qLiOtGOCWADBCNiXfoL5OwgIzfueTT9WlFmokpiMRZaUi7bgKQhVbovFXDjoiE8Jrb+/WyTN4Zu+BNmf6Uqb+jGWtg5nPcEBZHz9VPtX5N13ky+R4ahqR/9bxNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716200584; c=relaxed/simple;
	bh=VMWsBNDp51fIz6Ut7HJ6IcQGJIYHwmBePVqcY6/wQvs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=LXpYhAoAujBMI+Roty07h44lVPkod+XhkZr5yedlvCO/q+ZF0csZvUKyGKgbSPrYsPEnfiyffwmtTObmdGWB7o3N0F5Er6vLvPTYHCXf1tGnzQcTGAdcDLQ/BofTe2hkfJFUbQ7vlKYShGXM1MFf1m6V2jrFerZKDGMWJsQrS+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PpdrA4wE; arc=none smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-47eefa04398so556062137.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 May 2024 03:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716200581; x=1716805381; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VMWsBNDp51fIz6Ut7HJ6IcQGJIYHwmBePVqcY6/wQvs=;
        b=PpdrA4wEKtJ61dt+x4L4ZIT4mwuS+euyA4IuaCbqCxY/5ZpsMWF+DsybuAWjyn1dkd
         yNjFQzinQ3iM0GiQ2XLjVAmiWj2S93rmrnK0+xeQNKGjjhP0AxhHjd+aST4DtUJvs061
         BzNqvHZjlwPRLScjTllA3Qtl9h+mkjOVUsubLWrnn+vq8naj/ctMZjnaTAyPGQipFZdR
         Wi0R91CVIxONyGwUMm/UCHWwSYEHeFdvionlL+PpIW78ExAG+qBYEUUrZJX6lyi9SH7c
         ED6B/LcBCPdw+yNZ9DCrqleRB2XR9usCAnVaA+U3kTWPoWiXMiUfymx6uj6fdVpFMMDC
         ckvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716200581; x=1716805381;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VMWsBNDp51fIz6Ut7HJ6IcQGJIYHwmBePVqcY6/wQvs=;
        b=Nnd6pIPd/9+KHxLv2aRSjkeUduRS1q6VBKQMGwab7fyXpX4l255iKegm8pXDazhyRe
         tCPNWwXHaZxbUT3fKe82k/m2atEj/x0CiWtdQTdc3QaRHcn3wJRgGMPZirUvF9hiSqu9
         Szluj81bzPvqTsyLy9ZwanH29J7bOXbxdUmBRnzT9UuR8bqzrK7YfABgv/e2YXZIIn82
         NGA5VWRL+MBzjjAacsfFs4k1jeporh+c1f52cOGaB3zUHbcIrZX908ADwPr0X0WcqF5/
         WbEwfLfnPxIyZnOI22cQLIL9aF2zL26UVKgBlDlliaVoJmhI3X8Ugcnff5UxP9Jr/A6T
         tjBA==
X-Forwarded-Encrypted: i=1; AJvYcCXa0GbnhCIX88BDLwXXa49sT9khwV7oWt30fM2U/2bhYiSXhkA9jyBvLO+m4z2E1rBKPg4AXmOy2Mw/5nFseYCRsaGP/5nZ3asM9SD5fg==
X-Gm-Message-State: AOJu0YxNHPyftcyve8Mzgok2AxNH93TTruCGxbQD7VT6FQUWZ3Tivh28
	jRIrRN9VvpDwG28stcGh9mRmJhLkEOPs9Dg1Wo08NlDCTHs8mZMrXG/8LYpnaeG2slnkwNtFiT7
	tOXKIlVfSNefKJVINUkQ1/N9YeaE=
X-Google-Smtp-Source: AGHT+IERw3D0+fzUOu1Abg+T+vugUR8Ro++MqeOUl+ePp/0W1vPiXqmbX3HuhCDUXt16q3kLmGtsbEHQSWWyxrR1BVw=
X-Received: by 2002:a05:6102:14a2:b0:47e:eeaa:90af with SMTP id
 ada2fe7eead31-48077eb6456mr35168898137.34.1716200581615; Mon, 20 May 2024
 03:23:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOuPNLhN2pxa5KPpxiCBZMEGTgqaNddB6DZeB17tanp2gQgX1w@mail.gmail.com>
In-Reply-To: <CAOuPNLhN2pxa5KPpxiCBZMEGTgqaNddB6DZeB17tanp2gQgX1w@mail.gmail.com>
From: Pintu Agarwal <pintu.ping@gmail.com>
Date: Mon, 20 May 2024 15:52:49 +0530
Message-ID: <CAOuPNLjccNaLVAMWZ4p9U5zFe7FMwJa=3StPMTFDRngo2yRb-w@mail.gmail.com>
Subject: Re: How to detect if ubi volume is empty
To: linux-mtd <linux-mtd@lists.infradead.org>, linux-fsdevel@kvack.org, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, Ezequiel Garcia <ezequiel@collabora.com>, 
	=?UTF-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
Content-Type: text/plain; charset="UTF-8"

Hi,

In Linux Kernel 5.15 is there a way to detect in runtime, if UBI
volume (squashfs based, ubiblock, dynamic) is empty or not ?

Based on this we need to make some decisions at runtime.

Currently, we are using a crude way to detect volume empty by reading
the first 1K block using the "dd" command and checking if the contents
are all FF.

Is this good enough, or is there some other better way ?

Thanks.
Pintu

