Return-Path: <linux-fsdevel+bounces-45629-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E68EA7A126
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 12:40:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8266B1758E0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 10:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26B3D24A079;
	Thu,  3 Apr 2025 10:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rz5e6qXf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001971F4619;
	Thu,  3 Apr 2025 10:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743676759; cv=none; b=iL4fSPO+vMf6T0HJGL0VECXpytc+n1gBEFdZb8lp9DIQIc+jyVmNXkuhNm0ve2O0VDwixOo5SNdGkp4M8e4iQ+FgsF2EplTNGgm+zUZGAnRu0POoFzkEgSsoslz8wer3E9RHnNSmTPF1yIJ8bUnsbCWBdmQrxOKtayKhSENj0DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743676759; c=relaxed/simple;
	bh=f2s72k6hZXE1+MxAuCu9EHvm4hPGdXoA6i/NXrk3yh4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DShq9bi7FONStPS7IX6fEWHmeFmUFfogpr4zpfgoB+0znATKTV+nxJpfz51ud+tU29zSRBOkwUieCoNMKK7Vmxsz7MvH5j+hPCrFahSjg3t/3woNQjpZWw7XtM8XhKbzSWT3rIk/pOcsM+zZBmYb0Bf4ssY0GycKEi3Y2BnN56Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rz5e6qXf; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5e5bc066283so1220231a12.0;
        Thu, 03 Apr 2025 03:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743676756; x=1744281556; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f2s72k6hZXE1+MxAuCu9EHvm4hPGdXoA6i/NXrk3yh4=;
        b=Rz5e6qXf1Kt9mj25TRzJ2EWsBhCb6dTweg1WS/PAZWr+L8eABgOMat4qQ9BnGvAxlw
         UlRyRhXZH3SJ31aTCE8m8zJB1GoQ/grbW/PxWEuCg9BmMGPKrEiDn0e62Uqg+kqi0wpH
         dtF2wT96KX3riQP8A5i7VyZ4dzg8DM3S8Xjdl4P4iaD7UTR3fHAx1ZSjpRlENodAErGd
         XIZ2JAe7TfMycZY6QZaEwvKgapMJREnt2qrBlbZnerX476bQb1m6ZLjZ4hw1vTf/bK6c
         IxSUFQYp9om+vhApg+AuthbBKL3b0dbQeLV+5cGTIrPQaVEow5B/FC/sgmMYMJUrY7zJ
         VWBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743676756; x=1744281556;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f2s72k6hZXE1+MxAuCu9EHvm4hPGdXoA6i/NXrk3yh4=;
        b=bs+DeeYROw604nU7Ftz5xgcuFG5jHuon+s5EPHmyOTuO53E7kysd3Ma4EqIdu8B9qo
         Be822rDV0MJPWFM0ODqKDpORGWAWWVy1nlDNG7eLZSMdgL028Q1ErfAAA1eG73ttUZXz
         c/Gv/3fCcWQRAk/LpGVVd8KZaUBYxbKQsFZMz9Q61sXb9d4Y1cUtbkdX7Nu2jKLm4wxS
         3betVrXKzVU63YCEaM07Zg2cXDgsTzg5vBVlv0zfv0muy14E3fAuNdsu2g9ciTRHhJyQ
         epCfghCRqfTfPvioq66cVau4Jw+hSWF4bBPUSwz/TihVHWuOe7GJmgaTI3VPRoYmR2Vv
         vJ/w==
X-Forwarded-Encrypted: i=1; AJvYcCV6Pa4x3rpQSYixwDtaf3qdESZRRapw0RB+IhER0Qekq3QnlrW98uTzZmE3MpdpdZ3Pd9OL2SdmQNvD2+Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnRpFEXwQXHv6y7OnfTbHcYfVmlCHnupIQj4JqQyPkLnYCejn1
	AFhKFAEgWO09yUbEX1KM9MggOMytA+EGAJLdLwXPQ71otQrpO8oz7DLfaSRMQ1WFq/weP6IgdiE
	BMM5s0WLvNVaPqDHvj6tPR6L8dyYmdg==
X-Gm-Gg: ASbGnctJs9Z0UdJXR3I0R0yH8QjNRIIMsCnmh2gKkQSMfOyKb0j0yBaC0P9e0RjVmh2
	kd4xIrafwr4QPkc+sAlfdlBXMacjkzTfUXu6QuAwfI2a5w19/LV6A95mDdiE07gAQhnLTgl/uNP
	qFU51RFhCX4xOmGfZOD0qF+RZ/
X-Google-Smtp-Source: AGHT+IHIukhkHjVflcnny2IBC7gWeeYwrnVBl16nslGqunjb8kJjosZ/URQlVF4IQKhdSqnYdsRU46Yv7gVE8StzJak=
X-Received: by 2002:a05:6402:510a:b0:5e7:97d2:6d10 with SMTP id
 4fb4d7f45d1cf-5edfdf190cdmr17128321a12.28.1743676756107; Thu, 03 Apr 2025
 03:39:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250401050847.1071675-1-mjguzik@gmail.com> <20250401-erwehren-zornig-bc18d8f139e6@brauner>
 <CAGudoHF_Nfjq1nLZhMbFr3GJz-z=9Z4goacCgXbifxrQX7yiwA@mail.gmail.com> <20250403-tunnel-lethargisch-810d83030763@brauner>
In-Reply-To: <20250403-tunnel-lethargisch-810d83030763@brauner>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Thu, 3 Apr 2025 12:39:04 +0200
X-Gm-Features: ATxdqUFvI8tyQVh3jshVUVLys_2xhv_TOu-2NG0ecAf6L454qwG69K9BNf7diuk
Message-ID: <CAGudoHFWrxxy8eMO1gz782aUA-7JobSTWYpuxuD-iR=UvYofmA@mail.gmail.com>
Subject: Re: [PATCH] fs: remove stale log entries from fs/namei.c
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 3, 2025 at 10:39=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
> I'm thoroughly confused how this would be a meaningful April fools joke?
>
> The comments in that file are literally 20+ years old and no one has
> ever bothered to add new updates there even though Al, Neil, Jeff,
> myself and a lot of others probably rewrote that file a gazillion number
> of times together or significantly or at least subtly changed the rules.
>

I agree they need to go. The joke part was not the removal, but the
addition my own log entry stating the removal has happened.

A genuine removal might have ran into opposition and I'm happy it did not.

That said, my "submission" does not even have a commit message.

Perhaps it would be most expedient if you committed the removal and
repurposed part of your response. No need to mention in any capacity
in such a change.
--=20
Mateusz Guzik <mjguzik gmail.com>

