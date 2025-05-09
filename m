Return-Path: <linux-fsdevel+bounces-48603-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F2A8AB14D4
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 15:21:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AAC1A2562C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 13:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4F6A29347C;
	Fri,  9 May 2025 13:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="DeBl4dBL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC3F29292A
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 May 2025 13:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746796467; cv=none; b=lKs3aAN3f8cjiYCTibFy/EY7DmrLXb156+noD8AwLGcKdn/nA7O7xZ+jwjajWIAz4YrSfCou3XS84b364AiXqt/cWE6RTAxXCTaEqJYnO3aTFnguLUwmvVafIdA9ez6LObvGvkXth5l4yKApdKL8g0f7jZ1xK2N+I4Zl6l5pMSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746796467; c=relaxed/simple;
	bh=KSWxgLBt9iNu+W2gwxOsv3uUQUlLsR80lwPpcYA00IM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mAUH8/327Vxem3p0bQJCSpym+7LffW9+zXFGA+YqIMnfF9nrgsLQDIi2d8X4SZBTR+Kv6x75U2sLBi7Z3ADx6Nh3YBliAvDvtSvZbkV96Z0DSHAShB3Q1dGP26yo1nm34upmCIpHT3gXPifDE7MC7tHmCkdHEpj0eraxHeGabvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=DeBl4dBL; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7c58974ed57so242773785a.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 09 May 2025 06:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1746796464; x=1747401264; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1wuHYvY9TE0ehuOIB/jYes0+Q8eGbfL5Wth0ZjKDdKI=;
        b=DeBl4dBLDGehrYXn/lmZXsd9TBpPWk8cn1PtYnVe8axZj96jNINaj1vKm5QGzUKfXb
         uCivdKToIcMVilB5uGW1ZyOyH2rRy5zr0xEW2CI9aZmhosXBDbc0qnljnt3Ys5w8LX2H
         1q3qsnhC4VA6QFlTpy6BmB7NYDrMqKgPJ8NVA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746796464; x=1747401264;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1wuHYvY9TE0ehuOIB/jYes0+Q8eGbfL5Wth0ZjKDdKI=;
        b=K0PNg6LkdoK2nwmdK4iXbTNy3j3fK64kgMSkOsk8fuOoe4Y5aBO24zeXvlI/gtz7Mw
         GWm9QSuvjY71fQMWDWLhkcGEdNl1Llkin9X/LGaZm/1jLWeL8nXA/kDac3L4pfJJhqIx
         gPjz60BxWkGwUnjfLDrdIQ/l1j+gJkZOlUVemvu1I0SSsFueF6sdPnDoLmHrYriEb6IA
         ARktN/qjzsCy1bxyXBI4+nZJjyZgCVOO1d2hnlrfG0KDkoU21DGCAzUrcky09vB8SyrK
         8kS+5bSamkbiG4/o4k03iLQT6+/pCKz+GIlqgYhZ8ClHIexXfk8spr6gtMBqeP3rOoI4
         /qSw==
X-Forwarded-Encrypted: i=1; AJvYcCV/BIMGJH3hbBsSI/L2KgWOokjW58CqmiAjmRYHKc6mvF2mVBXJZ14MPhvV69tNZWHw7JzBA0rcgZQOZw87@vger.kernel.org
X-Gm-Message-State: AOJu0Yws46PnkodwE692po1LRze6GcftGgY7hBGdxCfm99BYQcMpU+zz
	OSRy1n1xK7VKTMXrohUUwhWQcsU3G0BQruwU3rHKVwWZJhuR09Okvv1CQq/KtHQZwzvotTj1CiV
	UWX76tWteE8MZz2T+ICIbLqv8xq3kIuA17JcTKQ==
X-Gm-Gg: ASbGnct478sYCxGms1Y7P1h0Nz3+23WDhR4mQmWCCc7h8cZxzHR8KSiKB0ofzpkRs9n
	sfvv0ay7uTXVn7Q0wdoV/T7NiYcOPyUejTtecfUZzPAaqRVze9OLOu0LayK1OOG4g53CUrKS37w
	3owMcRifqbAIaA+a5gRbrTO9K4
X-Google-Smtp-Source: AGHT+IEI3puvqThQlqq0KVhrZ5KQwMenEd8/Y1uIX7gEk73Z+TEhqZJWbjf4NkO60KZ1lrGz4/VXQmOvi5r7glYegFY=
X-Received: by 2002:a05:620a:191a:b0:7cc:58e5:17a6 with SMTP id
 af79cd13be357-7cd010f4275mr540946285a.8.1746796463656; Fri, 09 May 2025
 06:14:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250509-fusectl-backing-files-v3-0-393761f9b683@uniontech.com> <CAOQ4uxjDwk6NA_UKiJuXfyY=2G33rruu3jr70pthFpBBbSgp1A@mail.gmail.com>
In-Reply-To: <CAOQ4uxjDwk6NA_UKiJuXfyY=2G33rruu3jr70pthFpBBbSgp1A@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 9 May 2025 15:14:12 +0200
X-Gm-Features: ATxdqUHOG_qOnUoa0UNQFUYGPrSWq-neQTRbvMiWLcTxWd52TgDxDOOospnlmVs
Message-ID: <CAJfpegvEYUgEbpATpQx8NqVR33Mv-VK96C+gbTag1CEUeBqvnA@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] fuse: Expose more information of fuse backing
 files to userspace
To: Amir Goldstein <amir73il@gmail.com>
Cc: chenlinxuan@uniontech.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Type: text/plain; charset="UTF-8"

On Fri, 9 May 2025 at 09:36, Amir Goldstein <amir73il@gmail.com> wrote:

> This is not the case with displaying conn, because lsof is not designed
> to list fuse conn.
>
> Is there a way for userspace to get from conn to fuse server pid?

Define "server pid".

One such definition would be

 "A fuse server is a process that has an open file descriptor
referring to a /dev/fuse instance."

This definition allows a mapping between tasks and fuse connections to
be established.  Note that this is not a 1:1 mapping.  Multiple
processes could have the same fuse fd (or a clone) open and one
process could have multiple different connections associated with it.

This might be sufficient for lsof if it can find out the connection
number from the fd.  E.g. adding "fuse_connection: N" to fdinfo would
work, I think.

Thanks,
Miklos

