Return-Path: <linux-fsdevel+bounces-72205-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DECE6CE80BB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Dec 2025 20:29:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F4171302049A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Dec 2025 19:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1139B276041;
	Mon, 29 Dec 2025 19:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="byTQYatV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE9C62673B7
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Dec 2025 19:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767036549; cv=none; b=cIzh4U1/FDpOYSg6qHdKLBzAUgCF9BT6Vjl6+anUMsqKVOCIgPYwmjwKgWQYXhb0fKYG1fnDuiB3HnAYrvJWKafsGzz7Pww8Yo22N6wliPxPtZbuxmbKCErQFZV4AxNfg0OcfQjuKouz0BH8zt1XlMQsgG4M1G3vnJxJfvtyvBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767036549; c=relaxed/simple;
	bh=7cKFhjr54cqxpv9cPtbUcDVBvVr36fqCHEYop6xOea8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TwuC/DWpp2lZY4NHxyYW2qOPib0HDHopE9k973CcHbIe5YULSSez4euguGUueHPeaF3s0jmwYvv70uEHhsSMI/0w5YKxm7nRX9ft8g8NzS0NkH599nsY3Vr5edDWJVQFSXStksgorHf/bVTnoXdCWTVuezG3MHtJOuM3jCbLfck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=byTQYatV; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4ee0084fd98so79954711cf.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Dec 2025 11:29:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767036544; x=1767641344; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7cKFhjr54cqxpv9cPtbUcDVBvVr36fqCHEYop6xOea8=;
        b=byTQYatVVPNEfU8yiIPYqkMAdH9vxfLvF03byPpNWBkRQ0kk/OZTbMVQU/mxUnsl34
         mRA7oWnjfO4htv05eceDt0XOmrz8hC4CbBultzyKPzHrDnH49OLogIAdNJwS1bAkDs09
         gpq8kN0iuK+axweUd3YU5QwBv3ccnhaQd0mN9+m4GxmpzMp7NHk2aCzdFXhAMDjvtb7A
         jvWP+qsMMqZiI5YG8bOS+uIIGtVEDJHPdTFa9WYqmqShg+0yRjmqS2dbl8GMzmSa2ZHo
         1jZVfMqFJw1g01I91FXDocGjUwyxTlY5WkKSZniEP/pC3VfFgH115O35XRdqBXO+r5qM
         Z2zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767036544; x=1767641344;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7cKFhjr54cqxpv9cPtbUcDVBvVr36fqCHEYop6xOea8=;
        b=id/jCpCEhw/oc2NT0HkBmVPC6nAFVvUcVtPhAze+JI8QbiEKQnNPPAqYHsIDjzQKQs
         OUjQ42THy/YMhPyJ8weTesOSI5cYAx30FCmn7drU7KlgVGLx4NNMNiJB4CiEx/+Na//N
         Xv7m5NwhtrJnI/6aTkUQ2Nk1fQc8MEjvlINjbq7VEjh3tcr9H8HrYdiJ96m22KAb+SHN
         fcjMxlsWad4MFaqBdn70Ads9Rs8Irpw9Dm5YoEW5jIkyzl8EsMvTY0XoPY03eYa1Osy+
         3Ic9ZbGiNKLo29CKqiFhpRAO3U9fwuh98rk1HnSQwg/tti7GHHBWmTR8EojwJaCXrDVA
         XMBw==
X-Forwarded-Encrypted: i=1; AJvYcCWNLMirFIlkrXCG/tJGgRqbMwmL/c4dKX48pJe9KjlVND7etnuTKZgV+GpJAmkYF2AV58rCCxGifAQDkuQo@vger.kernel.org
X-Gm-Message-State: AOJu0YxovTyrqNKBLhsmJV1srwTd3qEn+964hy2ENrrcCAZiLahfWEPo
	gam1dPpHBvh9MOTpHvZQPIkZ0oYdSOdV/rWxf5FcXyYT82/qOV/XumB+8/6A7baHLuIYsVHELOe
	WB1HNhhcUyABV0l1CwshSgfchGl1UdEc=
X-Gm-Gg: AY/fxX7W01TUkIuSaRI2aZV64kAjwE4ZwN7LYcU3bddfl8IHuwjDEeW90i7TRKIVq9K
	XD3oVTppSch0NO3OtK0M4NLTIT7ErSIPK6Ss/vMjEm8KoPLwUDj54YGsJHvWhuEe4sJItO2+Xv5
	lVDkVhtyVFzb0Z1TURli56hopXA1tI07NmiGC7fk0LacwoMkQoRi4Fs+dUGNng6W+RPwJFBmiTB
	KB9X/30Gmuozu5sf1zBgaANfSQKMbeU+iIdzPhb0qTO9gIKOmIgHWHGYEqPPXIgP3y+LQ==
X-Google-Smtp-Source: AGHT+IEWNnZQMoOT55jrN8388zMv6SnHQcsIhiKIuQon4yEQ+n+qZqOjvKQ446ixI8geflMDdDV5LH1/ckXAvbGwgGI=
X-Received: by 2002:a05:622a:4c0d:b0:4f1:8412:46df with SMTP id
 d75a77b69052e-4f4abcd0a33mr469996051cf.13.1767036543718; Mon, 29 Dec 2025
 11:29:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251223062113.52477-1-zhangtianci.1997@bytedance.com>
 <CAJnrk1aR=fPSXPuTBytnOPtE-0zuxfjMmFyug7fjsDa5T1djRA@mail.gmail.com> <CAP4dvsf+XGJQFk_UrGFmgTPfkbchm_izjO31M9rQN+wYU=8zMA@mail.gmail.com>
In-Reply-To: <CAP4dvsf+XGJQFk_UrGFmgTPfkbchm_izjO31M9rQN+wYU=8zMA@mail.gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 29 Dec 2025 11:28:52 -0800
X-Gm-Features: AQt7F2oXtMtciJbl-BZPLulWOcj-3p2-MsPsPsWNd9YjmB_0ur3oZYzKyz7-hug
Message-ID: <CAJnrk1Y0+j2xyko83s=b5Jw=maDKp3=HMYbLrVT5S+fJ1e2BNg@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] fuse: add hang check in request_wait_answer()
To: Zhang Tianci <zhangtianci.1997@bytedance.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, xieyongji@bytedance.com, 
	zhujia.zj@bytedance.com, Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 23, 2025 at 7:04=E2=80=AFPM Zhang Tianci
<zhangtianci.1997@bytedance.com> wrote:
>
> Hi Joanne,
>
> Thanks your reply,
>
> > Does setting a timeout on fuse requests suffice for what you need?
> > That will detect deadlocks and abort the connection if so.
> >
> The timeout mechanism does not quite meet our expectations,
> because the hang state of the FUSEDaemon may recover in some ways.
> We only expect an alert for the hang event, after which we can manually
> handle the FUSEDaemon and attempt to recover it or abort the connection.
>

Hi Tianci,

That makes sense. In that case, I think it's cleaner to detect and
print the corresponding debug statements for this through libfuse
instead of the kernel.

Thanks,
Joanne

> Thanks,
> Tianci

