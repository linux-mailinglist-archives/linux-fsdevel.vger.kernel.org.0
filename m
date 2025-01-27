Return-Path: <linux-fsdevel+bounces-40140-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B916A1D672
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Jan 2025 14:16:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61A371885E59
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Jan 2025 13:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A005E1FF1AD;
	Mon, 27 Jan 2025 13:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="p53ldGLM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8471FE476
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Jan 2025 13:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737983811; cv=none; b=u3IMDxMcnJMnRB/FpOWFflcclyu59w4+yBAU3OIidby0AWCYc47rh5UCPudYcZWtyuQuegdGtxRW/JzbF/knThfUx67xTNLpOekPQqQb3L919/JDBwF03NKjv/m7JTkfiwyVEiJImsQamwJ8Wnkg2X/DEJQcf9dE+MJq0N4IXMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737983811; c=relaxed/simple;
	bh=G8PJm+hThbliVSLtcEBZD25D4KwFF1De8y45qsXNmHM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n+zJ7AK4L6sWBxlEVGWYqzyFin5pAq4uXqcMbx0VXAl36YSJggeJOJ1yUPv35YK3JdUFj0rESimzvsbg6hTXIc2uO6OamqHVUXxhVTWESkQ0oDV040yKJP+8omIrP1m61fppOSY2d/2qXZ3JA9gfucscc5agr6hZTk7HOO4WqT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=p53ldGLM; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-467a17055e6so48509791cf.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Jan 2025 05:16:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1737983807; x=1738588607; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aeAUBHAxqRHwtw2HenMgr9XFFNr09LE3fgqcZM8fhdI=;
        b=p53ldGLMoouHUxdczIj/K8rswSSZFII1Pn+AhjbNEAyFuC8PCFVDC1WIw9ETxaB27/
         mwdWPhXCCMUiQeghPHtqKd8O700cYdgYXDrWnFndCrthz7dgFMqxi6uSBuaMHG0HSFXk
         1XN9jSGAz0Pr9eXqfM2Lgye4wZuoTvypdrXO4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737983807; x=1738588607;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aeAUBHAxqRHwtw2HenMgr9XFFNr09LE3fgqcZM8fhdI=;
        b=rWdhIXjkjhnRsrCWbQm1YISTyqL/MpMYDbQng9/EudZhpeFU0WKZXb/y3zVBzqtXpV
         gd2z8uIftv9CplQGTeQI4vPdHmagCzQrob7ccKNVUM5NRlUvcDzue21C4Woo2+lZhFW7
         jUt/degH+guSaxAqhcxhL0RAAstfCfr2os2HtErnb8yOyJY4V3erbCYM5ZOkAHrmutex
         KnlVcuqN+rhTCN5KOWxwDyLuslccMo5ydb2pWD7TdoYIscHdIGkjxL1i341adDHp3M3h
         YhM76STxdUPJ+aac4hMumXVruWomEGEPqbeKr5DYkhk90tP7T1yrUueWECb3v2wzfbPG
         9iog==
X-Forwarded-Encrypted: i=1; AJvYcCVdS9ceS+msbbiw8+W39ACtQSmXRqHpJiQCE3q18dZKludUNoAQO+03Eb+Rax2/Qzwl27O8s9XQ3eNHUXjH@vger.kernel.org
X-Gm-Message-State: AOJu0YxvwGSCv0WNgVKKAAXPQGH8K0yjyYgPIEesCvZ5uy1DNxf7BrDR
	am1HskTihZYQrA6ziyD/dZuPdM8FtFyqZxsDZIyATafo4AO5SItaqYE+PEvsuLovWL/RWgsFrEV
	+1QKiAPipMLMxCKF2tfYgryS5AnxtonQZgvazFg==
X-Gm-Gg: ASbGnctpHLkc/IB3+cmgrI8uRwzEZ8EpV/krJhFkgy7B894W9wqeMFNQ7MqjULiL7IW
	U+slPY+tHL5FCR/JX99e0Sb8GjIu94TBeVvz+jptz2fNwSxcFTzEUQhj+2BRfELE=
X-Google-Smtp-Source: AGHT+IHeTUtNHYgzQhBWDBSZZKYKIcZeNPnC4ZnEFmxdUV+qMVJ7HNJtLvTBq3pue9xFQHL/OI016x5biChO0gamMaw=
X-Received: by 2002:a05:622a:1455:b0:467:6710:bbf5 with SMTP id
 d75a77b69052e-46e12b57378mr671148961cf.41.1737983807626; Mon, 27 Jan 2025
 05:16:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250125-optimize-fuse-uring-req-timeouts-v2-0-7771a2300343@ddn.com>
 <20250125-optimize-fuse-uring-req-timeouts-v2-4-7771a2300343@ddn.com>
In-Reply-To: <20250125-optimize-fuse-uring-req-timeouts-v2-4-7771a2300343@ddn.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 27 Jan 2025 14:16:36 +0100
X-Gm-Features: AWEUYZlJq4GDrwL5agnog5_pFn20z8A2-GIRjRK2JM3sjJQ3H2Dk4d33wS-jeO4
Message-ID: <CAJfpegsN3nybf6iTbMPUJJ6Tdv61ngG8qfTwQ+8UYucHA3XQPg@mail.gmail.com>
Subject: Re: [PATCH v2 4/7] fuse: Use READ_ONCE in fuse_uring_send_in_task
To: Bernd Schubert <bschubert@ddn.com>
Cc: Pavel Begunkov <asml.silence@gmail.com>, Luis Henriques <luis@igalia.com>, 
	linux-fsdevel@vger.kernel.org, Joanne Koong <joannelkoong@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Sat, 25 Jan 2025 at 18:45, Bernd Schubert <bschubert@ddn.com> wrote:
>
> The value is read from another task without, while the task that
> had set the value was holding queue->lock. Better use READ_ONCE
> to ensure the compiler cannot optimize the read.

I do not think this is necessary.  The ordering should be ensured by
the io_uring infrastructure, no?

Thanks,
Miklos

