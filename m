Return-Path: <linux-fsdevel+bounces-41669-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8190A34748
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Feb 2025 16:33:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 947811715DA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Feb 2025 15:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCFB415E5D4;
	Thu, 13 Feb 2025 15:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Km/EJqId"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB1D15A856;
	Thu, 13 Feb 2025 15:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739460459; cv=none; b=Cmt8Psy9KbzrgT20G+ytN9xpWBYBa4dt1utXP3cjIN0Ct62UulSKgoHnUqn1NNihWzphxc+OmqTZ1eJ2tvPoeTkoYTby/N1ModPdkgHpKt5+BqGOK0I7vqLGRRWNX+sYSLrpWibLJQX6Ys9hPRbtgVoOxRt+H4vZitvrJVUROyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739460459; c=relaxed/simple;
	bh=MuP+XmkFAfCI9gqjMWhacbC6RlNrrf77w1csG5Met0s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z6+6Iw830PDNn0D9Qp0DcYMeGddruEL4JnT3BJKc7sAyAwhgS9WgjPdmhtm6AhkOh4YrGqZL0FI/jpmfTS6Ce9ftG5ewC8P/c5zDxmDuc2lZw9Yx6Ysv59LeASLip6xLTHsuxj/k6pQRpuI64OHJIYw/2cHqLYLvrcE7X1ssDVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Km/EJqId; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-726ea524419so342433a34.1;
        Thu, 13 Feb 2025 07:27:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739460457; x=1740065257; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MuP+XmkFAfCI9gqjMWhacbC6RlNrrf77w1csG5Met0s=;
        b=Km/EJqIdl/77IQQ8o0at1ncuzVxZjmMsmkaAH82LeS4iimDQVjOO8tADzMRfCwsEUZ
         ieVmapuvIbdb0y1IzGtrwXUe64Z3YbdzKRNUjyRwO1orJFA9jQWy7/olNWc94wzwNYt8
         oHhvsZkEeS54lvamoOhYxx5g5t1Tp8eGkV67qwT7csxn1tsOvaq70zIIuJxiwjGx2KeJ
         jx7cLQ2e6BNZMVeN5IDgbgPg1eju4Jrx3vw25MJKdhPL0dW5gk9ij4VPjTxI+6kztVGA
         2vngqgcUMSYa6Gw5F/u/P6ZCaDKY892Un0i/27hXWPQBD+Uyx4R9dmhqWmfi3lSgB2Yv
         HwOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739460457; x=1740065257;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MuP+XmkFAfCI9gqjMWhacbC6RlNrrf77w1csG5Met0s=;
        b=qqn6JDQFimbYFzITFKEOJ3p2t5U2oJBBiVfki0qot/Eo2yY+hDOD8ES9cpval9wqQ3
         E8BNElf7Cf4cgZG3HmNgo90niY5ZLh1ni+uPZQQyCg/7EJp21o3jtHSo1QdjYBUM8RA5
         OoLDJ1wHxlK0A1OZPLB9SHMVF5Cv/xxq4CgOzTrvimEhFKW/+ttHEmVYGp1y9IqH6Jfx
         xH16QoaZViauwRxJOIsJ9qG1gdGUS2TqUV/V0wP/8umMCKFpRQr8g9tVM3oEyafyz/Fo
         ybAp3c4Up5tE9vVklHG4jKbPA45TcZ201CIXSBR6zvDYJm0DAtvMJU3in3+NJAyusTcH
         nlfw==
X-Forwarded-Encrypted: i=1; AJvYcCWgy7CCZ7WjBlrGYDEsidNlSMDwbZTx47ZH710Ci2PJflSBKCdHKBLFJEQEYt/RWDHkCoyTck/XNsPjgQJq@vger.kernel.org, AJvYcCXF2/qdl5bU5RkddBtMeTWw2Rte4HMUonEIAQlSQu4R43mQ2US8GenHF30WVDqm05iCHuyZM2eh32WYOAgn@vger.kernel.org
X-Gm-Message-State: AOJu0YyxHMhBDoFq3y1RzYE9bIJ2N8xxrB2vwSV0ptGtDfiylqILcZbO
	Lzf+fLm0yuyDQF0jz4m5eavWY1To1S1CVxnIKLk8jNr8em3bhBEldgm6MVrwAFJ+v9ZJBuQ4dsw
	3wN/Eqbdt3pcArMvIrLyzT2lY/a4=
X-Gm-Gg: ASbGnctI8fx0xx+uzeDTIeSt/ZJp624ZhMPUMKr77CvoMVcDrphEZqvAx881m0AUFsu
	IFeYVXBfFqorSwDof33MFicRJeRSW1tlt7dy3F1JKdWvuTBd79jmOreNM0iysjrErU6jV+Gr2IV
	s=
X-Google-Smtp-Source: AGHT+IHMXUwmI/PVw+wJieNWH/dKc/pl6QNWwBDvTkzNh0bPHVCVw8B+ttVQAi+r7a8Hj92o5/2R6JVC3hzPvvkDdcI=
X-Received: by 2002:a05:6830:3c84:b0:726:fca9:bb9 with SMTP id
 46e09a7af769-726fe76785emr2517272a34.5.1739460456672; Thu, 13 Feb 2025
 07:27:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABXGCsMnkng1vqZ_8ODeFrynL1sskce1SWGskHtrHLmGo5qfDA@mail.gmail.com>
 <9f3ad2da-3a85-4b1e-94b5-968a34ee7a7a@oracle.com>
In-Reply-To: <9f3ad2da-3a85-4b1e-94b5-968a34ee7a7a@oracle.com>
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date: Thu, 13 Feb 2025 20:27:24 +0500
X-Gm-Features: AWEUYZnqOhkmMlR-uyVrXGvAiRy96jCtbuqAhyRMQ3CgIDqFoSRRt7ZCb3imdZo
Message-ID: <CABXGCsP9vPxu=hN5CO5MPJ5QVNJURKsBbbeb-NLoq60=M=CN3Q@mail.gmail.com>
Subject: Re: 6.14/regression/bisected - commit b9b588f22a0c somehow broke HW
 acceleration in the Google Chrome
To: Chuck Lever <chuck.lever@oracle.com>
Cc: brauner@kernel.org, 
	Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, 
	Linux regressions mailing list <regressions@lists.linux.dev>, linux-fsdevel@vger.kernel.org, 
	chromium-dev@chromium.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 13, 2025 at 7:18=E2=80=AFPM Chuck Lever <chuck.lever@oracle.com=
> wrote:
> I need a simpler reproducer, please. "Chrome stopped working" doesn't
> give me anything actionable.
>

After applying commit b9b588f22a0c, the internal page chrome://gpu/ in
Google Chrome indicates that GPU acceleration is no longer functional.
I apologize, but as I am not a Google Chrome engineer, I have no idea
how to create more clean reproducer code.
I only noticed as a Web browser user that when I scrolled through
pages with a lot of images, Google Chrome got substantially sluggish.
Hopefully, someone from chromium-dev will read my message and help us.

--=20
Best Regards,
Mike Gavrilov.

