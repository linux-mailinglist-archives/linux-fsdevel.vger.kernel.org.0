Return-Path: <linux-fsdevel+bounces-36371-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79C7C9E288F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Dec 2024 18:03:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F45D28AF16
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Dec 2024 17:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57D2A1FA270;
	Tue,  3 Dec 2024 17:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CoQAxbGk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2501D1F76C6;
	Tue,  3 Dec 2024 17:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733245380; cv=none; b=D6xqcaBmmG5BWaTz6U1sWnJQLOdd9Kqw7GuYA6LjtN1NYqLI/s7g+3j1EKzk18hTcIaMtdt2L8hjDe37u0UBrTR4P19FWNAEAmB8R1+Y8VhhJt4SbcYSw4D/f+eroyIpGZVnW9b9V3iuB+5sQ77hyvsG2NEPj0+OPhgkPmRyd7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733245380; c=relaxed/simple;
	bh=76NB2wMnWzWLzvkfmhJUYDxLuZU1HP2J+kABwgXrLrQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nCLEY6cpiJs3a7xOqmpzMeaJpQEmhxo2K8YgcC/9jRZq5Y+AzxsE9pjE7KpbWe7mspJ5A3lghjfETV/XQCeIJqo949HJPdt/Xko5IKb2aEyrYMlvfJ1X2ClYACuEFS8mwEC07xDHGnHW+4hjuNRizmnuDDYQ1r2QtXlWC+ELaF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CoQAxbGk; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2ffdbc0c103so82071611fa.3;
        Tue, 03 Dec 2024 09:02:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733245377; x=1733850177; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=76NB2wMnWzWLzvkfmhJUYDxLuZU1HP2J+kABwgXrLrQ=;
        b=CoQAxbGkz1OkCqunslM4imhpxQ2h0Lj+AbV+2me0lJdWoddu6J5tVikTeQrP0a/qj/
         t7U6qSisVrWcGI00SnkCXmL5n7E0VCfU9Ca2HPIXhjcEUlhS4+jORrcS7cb15oPOfT9j
         vjv19w4BWpyavFwwXoRn3OeB12qVJ1O0YddRwdL5uGVoMyQYGkCMYg0Nd+uTnHt9PeWR
         vXzQ17JzpHvjupZASCXONwLZDTtUoXMkyXOIgKKmkb6tmSNJ7JzHBUZPcn4n/rgbNpzR
         4/bmU5A1aWaGRTmeHQJadLNCcGZyiknDz4l27OESAziPxrlpQcGnQN51WebsmqaBQhEw
         w5HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733245377; x=1733850177;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=76NB2wMnWzWLzvkfmhJUYDxLuZU1HP2J+kABwgXrLrQ=;
        b=Ty3qjK2cBGLZQDBD50DPocuyM48b41gqnVr/18211uFFiOkD4ZLkRnPxAbl88csjYN
         7AFOJsicb7xIAsnTrwio+281wmYreN6IQ/GrN8ujFhsE+Jr3UsaKvhLqi3yotQ3WzQsM
         Wec7R/CBTHEEVQRFt88qI67VcTEmXrT0yN4rVnvrnTEMWZix264kXXmRt0aGljWU96Vq
         UrHnHFgFBW3/YQ+6h4SQY6uy6F6OogyaJhs/rONQOhjFdvbsQbdOzZL0pMxvQM8HIaBF
         JF/yBmBE69FpNTmei3diRo2B12ftTXBtDE+eYVt+So0QGqr2za7HWCOJBfaqGa+dAyLe
         jN+A==
X-Forwarded-Encrypted: i=1; AJvYcCU0BueYvLuvfzv5PvNMtG4xH/ZTvpQkL2wxafcSnHjUKBBzeebtII2rmZDPu8ZLx04hCOtgDUnkT5helT0E@vger.kernel.org, AJvYcCUw55c5x4DWzfAIGDzA/NM/OY3IDdQO/ijUJNoklVuY4AlN5YCbIeQ9cWt8l08c34nLBIhMnX1sOUQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3B2X6BzyDngF1DNXB4TpetYiw4XBDMwLtNo369e84grU4f4ZR
	AiBw2aLmhmFHLuGD4AiSjvAIKXgtTJPUmCGMY05DagDgoRo++xaRhOVEXnqxl+ZXj9QBxzOU4sD
	ZzKQwXJAMJl1V2707ezxJSjti5Qk=
X-Gm-Gg: ASbGncvFuApeRat9AvEbR7m1f7tDMkHWFQJCwZKgyidTH1Gyy/qFVzHhi0TFTUdoKjr
	JMAdP1xCKU0hrBn5qrAbFFaTFAyfjgmZosmurRp9Tjx1WUyQ=
X-Google-Smtp-Source: AGHT+IGqM5oQaVz2x2s7/Atw27CI2FwxkpodpOX0PPsmv5aDcc5i2aOnpXpcfouxbg+gdLwS/d23greQtBw9MjFHJew=
X-Received: by 2002:a05:651c:1988:b0:2ff:a2ba:103d with SMTP id
 38308e7fff4ca-30009b8c32amr30583031fa.0.1733245375346; Tue, 03 Dec 2024
 09:02:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241105-xarray-documentation-v5-1-8e1702321b41@gmail.com>
In-Reply-To: <20241105-xarray-documentation-v5-1-8e1702321b41@gmail.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Tue, 3 Dec 2024 12:02:19 -0500
Message-ID: <CAJ-ks9kJSNMJCzVSyp1YUJ7RHsLU+QLsVdUkGuAnu-ny-kturA@mail.gmail.com>
Subject: Re: [PATCH RESEND v5] XArray: minor documentation improvements
To: Matthew Wilcox <willy@infradead.org>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>, 
	Bagas Sanjaya <bagasdotme@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Gentle bump. Matthew, could you please have a look?

