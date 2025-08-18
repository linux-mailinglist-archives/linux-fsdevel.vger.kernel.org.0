Return-Path: <linux-fsdevel+bounces-58154-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD82EB2A1C4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Aug 2025 14:39:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D7147B0FAA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Aug 2025 12:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 373CB3218D8;
	Mon, 18 Aug 2025 12:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="ScoVF09o"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FBCC3218CC
	for <linux-fsdevel@vger.kernel.org>; Mon, 18 Aug 2025 12:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755520762; cv=none; b=lYmoAcrlApjNak+JoWRXQIjCfsvQeafau3kbs66lcUsI9/cBID2TcOUqv4LwWbpmAz7z3EvHCR8dS9SuvPNcbGhuii9EudLCNJoOsvcVmjU4tejxB5ltlEh1i+CFfbwKSIdPn/Z0qyDFGzOQ0m0HzkTzIaJMNPQIZPf/0CliEAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755520762; c=relaxed/simple;
	bh=4S3lO57l8+iKrAxUl+Kvk3EmV6llV1LJafB7h3SlimI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qXo38ORYKqUpM/3H6xQLMpUxMr+E3sbxY6oZiJrploMTVCVghqbWKRc/0do4le3wSgAkJfzZAxvwqU5J0Y3jfp+377jQrElJa25Fb9BTBCAM5/sEwxwatWSqJJ0bXSZwaZju4fqxLcR3uNS1QvewY5W4RJQ/NenLIneMaAH+V2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=ScoVF09o; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4b10c1abfe4so49768781cf.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Aug 2025 05:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1755520760; x=1756125560; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4S3lO57l8+iKrAxUl+Kvk3EmV6llV1LJafB7h3SlimI=;
        b=ScoVF09orgf9P7ajsve9iU7nOsTPSGxvwHHJDFrOuXadBQcteeChxnZ8TXg0VhEZRX
         BFj4N0bp0eQ7Mh1tiSSlgRiUN2AnJClFhc+1QKxFW48wcUVrwvM5zGkyNtAPPPRTeuff
         aL30jqBswVeHrCyb48tUwuIxRnpjQI6Y+//7o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755520760; x=1756125560;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4S3lO57l8+iKrAxUl+Kvk3EmV6llV1LJafB7h3SlimI=;
        b=ANO5D1C2eomQMywjKvYZYUxgWCXqZT0RqsEGohG2VBcmXswoZoI78R+uzrcx81KFro
         V2Na/aWaf1MBQgh05og2pRC1wDS2iwK2rBSTIBFDl/9fgojRueoEtpj3MSztrWyYyFCQ
         tRyGmCqHq4yK1BRo5+hP0ajLvGY+ZmudK7jsDb1D8pN9Oju8ftnxx3MXuLjdSCrbA/a+
         SwhdrVpRzy107KnIc5CiaK7CrHR1K9FKUYHQgsHCksnPMDNwHrIFZBgH49bGIhZvJSVR
         MuKcD4DIyNEfqt3wMspm0dYnqLLMMSmig8AGA0pveOFdz8fPl3mbR4NTCv43AhtP6UhG
         TxSQ==
X-Forwarded-Encrypted: i=1; AJvYcCXjx6BEchdvD92QVWquk1m+0jya3K9n69m/eL2tDvOSRpGooold1Y6QMNF3N9/tMAsfW5VZKEiOhbasQD7Z@vger.kernel.org
X-Gm-Message-State: AOJu0YyUBpXP58ulSOTNgUSV8Dhp9kc1UeHUfP2UanWBzESOCwrBkgnc
	GwSfYAx4L+azVi+oDe6BOrzO72Zw+8dw8p6bchYqnbeIFzlxTztQFx/u21Jdxop6EeLxKqayLcd
	q2WwfhTjroI2btCCfO9Q3BDkxVyUJtVV+7c7Oa2T0Ew==
X-Gm-Gg: ASbGnctCEOnrD2bZbhzsY8UZH5X6/PI0ibsDl7T3ENiilhk0X574fa4/yqCVvg63HOe
	8lhLDXps6pitjGT4zl3W1VG0b0miMAEeHOPnsBbkod7SMM2i8P2mHBAeYvWp38M4otfyKWAUmI0
	woeluWajd+ow02g64gbxIScuzEo5jxy5kvwmDMPLYQaizZV21DfJ7e9xWWgwpX4VEOBwRVnaIUg
	+hni3Su0A==
X-Google-Smtp-Source: AGHT+IHTVfIp3tGvUZAFXAJoC8pdO0JicuolNHjGaNOBIUbD022NhuaCOz+3QiJZ9hTn1z+upsABGRkQm9kDTstUAig=
X-Received: by 2002:a05:622a:5984:b0:4b0:67c2:8fc4 with SMTP id
 d75a77b69052e-4b11e30abc0mr198664701cf.32.1755520760011; Mon, 18 Aug 2025
 05:39:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250703064738.2631-1-lirongqing@baidu.com>
In-Reply-To: <20250703064738.2631-1-lirongqing@baidu.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 18 Aug 2025 14:39:09 +0200
X-Gm-Features: Ac12FXwdvgsTsqvq6Gd_fh853qWx2O0CMMumZ62t0U7IHrddSGRW6GK52NgJ_c4
Message-ID: <CAJfpegtAB+N5A+MAfw5uqqEXQaOC=rbvLRa_H0bFT8UOyaUp6w@mail.gmail.com>
Subject: Re: [PATCH] virtio_fs: fix the hash table using in virtio_fs_enqueue_req()
To: lirongqing <lirongqing@baidu.com>
Cc: vgoyal@redhat.com, stefanha@redhat.com, eperezma@redhat.com, 
	virtualization@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Fushuai Wang <wangfushuai@baidu.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 3 Jul 2025 at 08:48, lirongqing <lirongqing@baidu.com> wrote:
>
> From: Li RongQing <lirongqing@baidu.com>
>
> The original commit be2ff42c5d6e ("fuse: Use hash table to link
> processing request") converted fuse_pqueue->processing to a hash table,
> but virtio_fs_enqueue_req() was not updated to use it correctly.
> So use fuse_pqueue->processing as a hash table, this make the code
> more coherent

Applied, thanks.

Miklos

