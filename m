Return-Path: <linux-fsdevel+bounces-63910-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E5FBBD1879
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 07:53:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A745E3BFD41
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 05:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BBB02DEA72;
	Mon, 13 Oct 2025 05:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jukFvp8l"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4353D2DA768
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 Oct 2025 05:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760334740; cv=none; b=qbLcYumZFf5ZsiNIy4TZ7UFMdqf5h7idcKQCZLjmeI/9ufIrbUK7UXuglE7/UZZ90vafWSJ8DrBv7DIv2w1nnuoBhaWE2F825TIoiDl1bJyLwLYpmS8JU9p4hpVnAfpKRjZmlx9ObeNeqBxtTseUSOlqATxsT9df8DPqUI2inok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760334740; c=relaxed/simple;
	bh=yhgJl9Du+YoMRbJlrYs4AzxXSfm5xVjGt7nVRt8hQrw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=umzXoD8jFKRSSAoGfKxm/BIfsakP1qS+Y2OT7JhpAxEw6cmI/Oz6nMpvUaF3oXFU3gZP6unt9cNglm0nWiJF+Hs31Ue5Gl41hfFuXM0GL2JmtbW7VwEyFAZPu/NbkzEI5bpeGt9CedGi74whN5HvqNK6bwHc5nzC+pkCmflL4lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jukFvp8l; arc=none smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-63497c2a27dso3868047d50.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 12 Oct 2025 22:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760334738; x=1760939538; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yhgJl9Du+YoMRbJlrYs4AzxXSfm5xVjGt7nVRt8hQrw=;
        b=jukFvp8l78iFsihn3aBG/5rMFnFoAPFJoJvRtWvU7I1x3T8fO3hpiSmuyZ5r8zQIGr
         9ocUvIQZg0h+xgawHv3ltOurCesKqO60ULAEbT83FWUj2csJR/egFmQDLSHGPAjyoJO1
         w581uLhu5l20aJn6rHddaXuK1k+Ko3gjxhylGuH/7+YKyqMrv8EpViAIfpUC7WmmFCJ0
         xFyWeN9YKAEgNlX7M4KWPDCrgrfrD2agex03XdrOLspWVRw99K1VesztB0NVZaLWDbKk
         Xow7CBG4tTB1A/WQctju/h2XWlsVAM2GFeroObAK0yUiX2VAaBvbXmpblHNiKYpIiqFC
         s0Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760334738; x=1760939538;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yhgJl9Du+YoMRbJlrYs4AzxXSfm5xVjGt7nVRt8hQrw=;
        b=KGzZxsbH4MO6VVPUhCUkcDyS2ddWbGC0YOrXYZegjm/NTVbVy2eqaekodjtwIQydHc
         R64jmArub3fxuVLgIeyt0Hn9od5GedKb2G+vq9EWi6rXC2tJ9Ofa2PHvBxULckGHuC8b
         5xkeYXKPrNa+L5d5Gah4aVeYIW+d/0ubmBGunUpjXul6bbDpljP/0U4QDR+Hw3CfivpR
         sIaHbl5d/Z/9Fc1fbYldFVaCLlHxBtWKPeBg4jbRTTRYDLHUvgE0vpHvwS1V/BpB31K6
         pBcPKBhcg4jyM+sWi7MMq1GrFAmMTKDFURdVrfLzE5XtH62BH1zT4X7r2I+toayC/H1u
         /txA==
X-Forwarded-Encrypted: i=1; AJvYcCXWp6+rdGO7pzww7kmxioyxcrFYM7pWv2x6IJe+bRhIR25EWcPcqIjM4m9WnRODV+saqbUpotAXimiageh+@vger.kernel.org
X-Gm-Message-State: AOJu0YwHOFTGTf9Cnf0FXBUkkO4gnwlXC3jyI0hrBHS+e+r/wzEP9frK
	rB+C2aVANc+zgNzzOUkvkUXDybMvncN7qaMZODz/RG5RxazbKNoCdSW5O+h/55HuTUvBXz6M/0/
	h/xPhUoinw4heKVibizDmv/Vscc1aoug=
X-Gm-Gg: ASbGnctQkX3oIX9KrrgkaupsEsH1H1muqO52Y4KuZXoSIL0cs7Xeze7CaP06bQ9asQq
	pYl8BMfnSkm+PMxBf1Jcqp3S7ozRJxIrsb161C5tADYGK1BkBFBiIQIhuyPcrUuSYBin0xfI1cL
	bZZk1+pVYE1Oq50Xgtm6hfO+yaha/HBpu0D1OkD1gIyeyfRu4SpyBy8rqDM/OjweQ0XzhhuIk6p
	aFqM5VPSPtEctJHFAelVHvr8g==
X-Google-Smtp-Source: AGHT+IEGY6fK0SI2o5MxFnMjtVFnwQxdBDRR1/yH8JkiHdWKzjgaFPVAcGr30+j3qCOCxUWnYLmbnjaWEMYOjfl2QTQ=
X-Received: by 2002:a05:690c:6002:b0:781:64f:2b15 with SMTP id
 00721157ae682-781064f38e1mr197514497b3.55.1760334738154; Sun, 12 Oct 2025
 22:52:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMw=ZnSBMpQsuTu9Gv7T3JhrBQMgJQxhR7OP9H_cuF=St=SeMg@mail.gmail.com>
 <20251012125819.136942-1-safinaskar@gmail.com> <wk3t24r7dr5kdgb5uy4hz2ahwsd5vkkuwjch3y7kwwybemlmg4@lb2ewcanzf3m>
In-Reply-To: <wk3t24r7dr5kdgb5uy4hz2ahwsd5vkkuwjch3y7kwwybemlmg4@lb2ewcanzf3m>
From: Askar Safin <safinaskar@gmail.com>
Date: Mon, 13 Oct 2025 08:51:42 +0300
X-Gm-Features: AS18NWCHN-JNvD8JDjaa-lSYG8dCJPc3191CDDTIzSiTAJVlu6Of31P8KY1ZDRU
Message-ID: <CAPnZJGBZiY4bqcqgKQzH9ZVuRrnahe89YdSy0ShJTiNf2ot5jA@mail.gmail.com>
Subject: Re: [PATCH] man/man2/move_mount.2: document EINVAL on multiple instances
To: Alejandro Colomar <alx@kernel.org>
Cc: luca.boccassi@gmail.com, brauner@kernel.org, cyphar@cyphar.com, 
	linux-fsdevel@vger.kernel.org, linux-man@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 12, 2025 at 4:17=E2=80=AFPM Alejandro Colomar <alx@kernel.org> =
wrote:
> Maybe under a CAVEATS section?

Yes, good idea.
--=20
Askar Safin

