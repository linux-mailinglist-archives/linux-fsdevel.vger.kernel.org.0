Return-Path: <linux-fsdevel+bounces-37348-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C92029F1315
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 17:58:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89AEE2853BC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 16:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DAA01E3DF2;
	Fri, 13 Dec 2024 16:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YON/FWCT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE06D1E0B74;
	Fri, 13 Dec 2024 16:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734109075; cv=none; b=IXoq4lyZsqVcnycV8avvGrVHdxqcE2wg1Yfzg2gECIkm6AFKRRQ0jkRIFHpG0uMXxI+WwzI8pRT5ymMR9dJMq4hK4HwMNhH0TG8xaFcdxGMBr6auRdgeZy0dt/06xvcqgmsH6HDddqsfmGl7c0bEN+5HU9gwM5KBQRfkEaDaZa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734109075; c=relaxed/simple;
	bh=9tKfVKHxrk5dru2TiY/h6eJP348r7CDCU+evc63Yon8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YisjDSzTfxn44IjBqxYl/Arsuh9RHMp/mb96aZZ8wM/wsrFHhxf/U4RWbgY2xLnWaV/0ve/n66tR8/9mREVnQF+vDlNM1AvOYthhe9KRwbiUb3In9cU1ctOnwTd/t9/OyQQA+zBIimo+oJ+YpAoQtnS8lW1fsJRhhPOM6oLKzU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YON/FWCT; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-3022c6155edso18147161fa.2;
        Fri, 13 Dec 2024 08:57:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734109072; x=1734713872; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9tKfVKHxrk5dru2TiY/h6eJP348r7CDCU+evc63Yon8=;
        b=YON/FWCTM4K+B5YFs/NDqWPWucj4SNHf+HNgbJHH5NZ1bKB3jidcbJdcrOFyCAFkUk
         6+XbXz2N1p4s/q/82mnoYgh7+6VsJSWJMNirdtVBP3qEZgTHBDqkRwyAxKrT0K7oPde8
         ttQlb8nsf2sXanE1PKywH1RkRx3+W6veBux2zu63PJ2h0Qqrfn/7dnrOhfL28JUKtX1v
         PwTq1ceKF5i6nLZyn/zgaom/1inmO5GRMsDUAZCInBXTbnUiMB0YWRrOqDR2icqPDAQt
         CHWo6rXcflrONZfRmnaGIiXnAgxuwxZsaF8FA/NjvX807KnUcdcQGliLeYRX6U0XkW8e
         Mb9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734109072; x=1734713872;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9tKfVKHxrk5dru2TiY/h6eJP348r7CDCU+evc63Yon8=;
        b=B2BEfIXW/uubTudfDvHQs63L0fURqr2RH0FgvH48FNvXdEhd/CJB2Ko0G+rZcG8w5g
         8KmPX78syqnztLkTyGY+vTVFdvNmusWL8GLiHJmw+8aTTMUsEPJpUckdZ1wN2wTqYHqV
         3OTfuckqcB1N57rvRdd/iQBr8bGQupelyoQ2YF2rIWmBEs0FN09J4UToUUl9qWYLWdoG
         bQA9jEFqHldjsTiCy/jwoKo2o4UcZEqN51vwyYjneYQRgdhOrQRzHkUA9foQOWNQETjV
         JgBIEK8+0my0NAER6sXBolqpwxAqKZwWkMta2bTLOpD3DXPsmRE0+NGFzzT1S6/wjInL
         zu8w==
X-Forwarded-Encrypted: i=1; AJvYcCUmug9hNIUk4Ad77N6WXrI2etOchwRTdw1/mG8XojPJmc/Dxn6xGgOfc1FZMAK/q1If8kjXJgzqoOE=@vger.kernel.org, AJvYcCXyy/288aHG10snNNSKMtsMeKj6L+3zAs1bMPS3D6Y3pydnUVcRn/+YbQfWFJ46Fs3sI9wsaSxVnAY+jquS@vger.kernel.org
X-Gm-Message-State: AOJu0Yxt2KUJ8RMhrrYc+7r4L7AUNxl+7hjWWXgnMeo52XwiH1hayUnY
	syop3K9Vnj+GrKIgGNfTbUiIyuHMcql4QH3upi14bT+OSYUSayGcExji34cKQZXzJdlQI4Cs5K8
	hnbdy1FAgPIyroCioI791G+4OEwk=
X-Gm-Gg: ASbGncvABRtKWwZpPw8zDBdLNvx8IW2qyRvTw5zoaZtUZ9K+haiKF3J8qqxULe+KcBr
	XfaXpAm24AeGJVtfe2ga01uyof97+CuaaWCbGtXtocJyeSbTtmoJZ
X-Google-Smtp-Source: AGHT+IEj0a50PpPSA3XfbrkR7UoflZUpcMLRa+mSCxTx81NIq94ulb3bvJLoawJJrFEoQEiahA0dEhVt0NlVqzQnqzc=
X-Received: by 2002:a2e:9f13:0:b0:300:38ff:f8de with SMTP id
 38308e7fff4ca-3025444ae89mr10026781fa.16.1734109071944; Fri, 13 Dec 2024
 08:57:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241105-xarray-documentation-v5-1-8e1702321b41@gmail.com> <CAJ-ks9kJSNMJCzVSyp1YUJ7RHsLU+QLsVdUkGuAnu-ny-kturA@mail.gmail.com>
In-Reply-To: <CAJ-ks9kJSNMJCzVSyp1YUJ7RHsLU+QLsVdUkGuAnu-ny-kturA@mail.gmail.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Fri, 13 Dec 2024 11:57:16 -0500
Message-ID: <CAJ-ks9=7NeZ87-gHp2Q87FNAfrxgNZvQ1F+F8OomO=9En84niw@mail.gmail.com>
Subject: Re: [PATCH RESEND v5] XArray: minor documentation improvements
To: Matthew Wilcox <willy@infradead.org>, Jonathan Corbet <corbet@lwn.net>, 
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>, 
	Bagas Sanjaya <bagasdotme@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Andrew, would you mind having a look? I've not had engagement from
Matthew in the last 2 months.

