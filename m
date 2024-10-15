Return-Path: <linux-fsdevel+bounces-31980-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FB6799ED76
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2024 15:28:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D889D288060
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2024 13:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB4221D5ABD;
	Tue, 15 Oct 2024 13:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="HXVu+an1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3551D517F
	for <linux-fsdevel@vger.kernel.org>; Tue, 15 Oct 2024 13:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728998808; cv=none; b=AHCN9LEwa9p+BtSrkZiUdbN4wLl0YKWfiiGccr94A6O4RI8OQzPJssNK1GTtHleoNCPAu0m+132XLNuxBGC8Q45Px2kq9Bp5NrCtTD1TkvQIWIjujfc/og1TXH0vMgMlDRKbnmnrkjRD9u9opl/qWty5RIXEWVKDCtX7xXwqgRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728998808; c=relaxed/simple;
	bh=EE+mwIJ8EdN6E5Nrc+ehEO6VYGIoaWe5dQFGFmdxNbI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fWZnmzWe2czH/uDeNBd3GHRZjcdCOYFSc+fMWb3ZHAVus3qNGVL9cBvbl5NRz7MEHRuWoUkRyCJ+9vrqvfqyHFailPL8Y/TpxemCrmm5uAwNCTdrpT7k+O9RJvT7zfrPqy6QutrWi2N66yHKoynRJ1vVqcAQmTkWp6eQ/X45o/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=HXVu+an1; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a9a01810fffso384473666b.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Oct 2024 06:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1728998803; x=1729603603; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mRZXUpffY97rnBRIDS+MokMhh64COlCpPreMnjnNvZs=;
        b=HXVu+an1FR+h+vgbFbYAcXb2yHJAnLx1yrIZzhRKkHfh4rscp2uD2I5PZhm5IGy0Iw
         adOv723JjU4W+uNYC3sWv19/5wrH855qFJVv1LZcLrhkvcCIPJEZ9rTPq06g52wZpGRo
         z7RWfnSE0P56IT7PbSZNYBbq+lUrouEIcw2u8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728998803; x=1729603603;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mRZXUpffY97rnBRIDS+MokMhh64COlCpPreMnjnNvZs=;
        b=ev2u1sRjjJjzv6yRQnOhyP8RnMDlfzuQxOQ/IeWCRHSSGvwq1mn6Td9y3HAxF4h8W8
         wT2LNMFaqQdiVEuZkKRyVx87n+ytO8STCL9Ze2m8W0DBH4t/P7OlniczLHpSRbpSQhCH
         fb8kvEr54sEU6OozU80Jj52jnLIUODDg7sMioJJYZre72X3L2gczkbNcfUSpmNP7jtHP
         OZuBlcd8nwdfGStAFi9l0UT9d8Ud7D27ADmFI5SQgif6Hc94bRHPEfbtWzOxnfmhQ5hN
         uKM1zclAnKAYFF7AA4gdroI+uuNsRcwOqheW+m1CKy18UuPxSyfZYHTOS3CKQHWiEMe1
         x7QQ==
X-Forwarded-Encrypted: i=1; AJvYcCXBeTjzsmLffNowkUGRI/Y+/izEDA64Tzt5E5luTurp+gHnhhLjUZIrGAaAgA9WKP+pVDZH9dIsMgl87wHR@vger.kernel.org
X-Gm-Message-State: AOJu0Yzd2YX8KO2Xp1biVMb4sUOvgq3NYTC4LKyU3FtECXIDTTJU/FfP
	4nuQY9lXE30Ju5qr/o0foOYKaO9yNBg+wG9U0P0Bzgc/Ws8Hv/6ughTHawukvLp3lRcq4kPRR1Q
	x0NjNqAodQh6y7GGTr0gkKcx0VnjhupDU7Ou6RBrnQDKu23x3
X-Google-Smtp-Source: AGHT+IEqUl8aGmHFCwd7iaPq9cNnaSEnfX0KhaS09sAlRU6JegSD7VxVWGlDEanfTxM4ESAr0E0oY4Kpo5i+cEOI0UM=
X-Received: by 2002:a17:906:6a2a:b0:a9a:1575:23e2 with SMTP id
 a640c23a62f3a-a9a157525c9mr546282866b.1.1728998803445; Tue, 15 Oct 2024
 06:26:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014192759.863031-1-amir73il@gmail.com>
In-Reply-To: <20241014192759.863031-1-amir73il@gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 15 Oct 2024 15:26:31 +0200
Message-ID: <CAJfpegs1kxyy72+b3ViMuMzwsRdEKVY05mm=CSJMyKwDmc5piw@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Fix regression in libfuse test_copy_file_range()
To: Amir Goldstein <amir73il@gmail.com>
Cc: Bernd Schubert <bernd.schubert@fastmail.fm>, yangyun <yangyun50@huawei.com>, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 14 Oct 2024 at 21:28, Amir Goldstein <amir73il@gmail.com> wrote:
>
> Miklos,
>
> I figured it was best to split the backing_file interface change from
> the fix, but both changes should be targetting stable.

Looks good.  Applied and pushed.

Thanks,
Miklos

