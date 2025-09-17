Return-Path: <linux-fsdevel+bounces-62035-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62859B8227D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 00:28:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AEAD465841
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 22:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 503C730EF97;
	Wed, 17 Sep 2025 22:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="G0xhXweG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A2D30E0F5
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Sep 2025 22:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758148123; cv=none; b=cJTM0o/w+vjXSvClyuaf0ras7dAyKCgbROy9qsAlWpTI0Eyd0KIbffuaCS2BVlQoGVrOTO7+mo9NnG6rWzyomcFwfyI1skxG9bPZEGG+lcwVlcU0Oh+F6wceEWrQzc/a5FmtGoufgr/HZPcv24LuGJjJDp/+sSH6tcp9QKe+R4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758148123; c=relaxed/simple;
	bh=FibkJLFpdmPs16TWPQcjI1FEmw5E/LmUaqG65SaId+U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qxpKhc+/N3sNMRuWgCb8hBwpLOiIRrDWv0Z3DPygKJmqubpOxEwJzjXaIl4VKUto56dgCmrdWYg3LhJkA0jXac8a8/d77GCOISiyLBZjJvDBXtxc12hR98uyRypwMJZF7bvU9eFJxJ60bzLwhAoycdi5FZ8OJ8VWGt89qZwzeSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=G0xhXweG; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-826311c1774so34857585a.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Sep 2025 15:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1758148120; x=1758752920; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FibkJLFpdmPs16TWPQcjI1FEmw5E/LmUaqG65SaId+U=;
        b=G0xhXweGeD4m22BpUYK2rJAB1NzwdepdngJJZpyLeE9M2TXbsH9EtKpq+2JER/nUAa
         MqgkbSIDErbjdl4PWvA92cImUwZw93ajTaErws2Cjn17NLcx0QV8JblGkxbIMQrwD9x0
         jGY3oh773JJCAu8IIEC/+YTNwLJhA9qOmFBUU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758148120; x=1758752920;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FibkJLFpdmPs16TWPQcjI1FEmw5E/LmUaqG65SaId+U=;
        b=s1DNK4eLrjdynYHnbokbYVfXY73IbyayZfZ3CGKRTaclFPylsaZRH3HXderLFdq/o3
         YUi0a5WKH89Gw7EyYxeeLaLkw0wYIZ4IwwOgyoIiYnILNyLt2TRQ/Aihu/ni7jOp6Uvx
         EpB9rXeieihqL7BQ5BMsWYMiA56p2PZTFTJRMm0NoTwgjorwUHasiN4UCQjKX8E1OOah
         lkedWhYSg29IK1NzaH3rtsUbdmmd/uKGFQDDYozlsvOxqjCXZu64raIlS5T/WB1OIY//
         k1e2H8y6FFLDP0ZUSKvKSPcvqX6iteRaw0lox/Cfzp1en/bunlZzgKcblws2kwY2txAQ
         qhaQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQHyYoyvJkAv/Df8cmpUvI5yiIjPZl9Q+PDJbF+Eqi9KuyS1vuIWPxgU9WKMStS81BbWbrh2jX0LoYOKjL@vger.kernel.org
X-Gm-Message-State: AOJu0YxYgKAhFQ4vzEC1UH9615ISdCKoYjvcnLd/4OgXnYxfXFWg5ZTE
	ZT+rHfDoDf1PGUDsyF4bpQDtDkryi7amKjI3QEgvANhth1saVOqyzJUUaXoUE6j5eLF/Gy7Ii5H
	sn7M=
X-Gm-Gg: ASbGnctKBsJ61xH22TeUI6xLpBsii/HZdKQGEJAj6eCzmeq8ISu37dUJlN4/uCY8H9m
	E314YaU13N6L9mesDZntMnHTjB2FrUukMOgLuXpawbXMfdg5PVgyArUkBGLd1Faof6MfwPDhW/F
	hcnpsr+Hq38oWXHyRSzFKdIoLBUJzlWnEFWTEL7ZdYDBT4rveDNbylPrhqPODg2cN3JmnPntmDW
	xkM1y1SHfHdYuXvOrL6tczUwwlNNXHHslkOqX99Yt8ZTSkyP9WkrYyZ0EAbesf6+0iNZ5MfFdju
	in8KZJkNpZGHVluCmSw7AAwATzpl6+Q6XzD13CDiMSKTUN1tTXgW9ufHcK6LpHnFomwhLpSQGiB
	J58/qDtmhwfkuCKP7HTOUN7fDA0QjIpFOr5OtHtVm5+JnwfOoZwH51eyqn/gmeG6rtnIS3pFas0
	4X0C5EpA==
X-Google-Smtp-Source: AGHT+IH3Ec6tmhKPi//e3rqGnC9qn1fv+SISw9lX2T/TSvZKbfCeJ5xucg2Zbub96//9oQ2dBRpRDg==
X-Received: by 2002:a05:6214:1309:b0:783:c657:6db0 with SMTP id 6a1803df08f44-78ecc631483mr43954786d6.14.1758148120439;
        Wed, 17 Sep 2025 15:28:40 -0700 (PDT)
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com. [209.85.160.182])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-836278b80bbsm56279585a.25.2025.09.17.15.28.39
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Sep 2025 15:28:39 -0700 (PDT)
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4b4bcb9638aso140521cf.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Sep 2025 15:28:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW8kwl9cPfhqVqstcs6DzdVBn/9PPhw7hmhSzBjJ+0TA/UquzA2RPPP1Lf952vChiAfYGTRtemIf2NiDsDK@vger.kernel.org
X-Received: by 2002:a05:622a:290:b0:4b0:f1f3:db94 with SMTP id
 d75a77b69052e-4ba2dbd91e3mr7888171cf.5.1758148118686; Wed, 17 Sep 2025
 15:28:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1752824628.git.namcao@linutronix.de> <43d64ad765e2c47e958f01246320359b11379466.1752824628.git.namcao@linutronix.de>
 <aflo53gea7i6cyy22avn7mqxb3xboakgjwnmj4bqmjp6oafejj@owgv35lly7zq>
 <87zfat19i7.fsf@yellow.woof> <CAGudoHFLrkk_FBgFJ_ppr60ARSoJT7JLji4soLdKbrKBOxTR1Q@mail.gmail.com>
 <CAGudoHE=iaZp66pTBYTpgcqis25rU--wFJecJP-fq78hmPViCg@mail.gmail.com> <CACGdZYKcQmJtEVt8xoO9Gk53Rq1nmdginH4o5CmS4Kp3yVyM-Q@mail.gmail.com>
In-Reply-To: <CACGdZYKcQmJtEVt8xoO9Gk53Rq1nmdginH4o5CmS4Kp3yVyM-Q@mail.gmail.com>
From: Khazhy Kumykov <khazhy@chromium.org>
Date: Wed, 17 Sep 2025 15:28:27 -0700
X-Gmail-Original-Message-ID: <CACGdZYLByXsRruwv+BNWG-EqK+-f6V0inki+6gg31PGw5oa90A@mail.gmail.com>
X-Gm-Features: AS18NWCUMtpdk9H0fWidPAaF1Bc8oxlz8rdMZKPuVQEPlj7Pq_GvycrjQRByVOg
Message-ID: <CACGdZYLByXsRruwv+BNWG-EqK+-f6V0inki+6gg31PGw5oa90A@mail.gmail.com>
Subject: Re: [PATCH 2/2] eventpoll: Fix epoll_wait() report false negative
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Nam Cao <namcao@linutronix.de>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Shuah Khan <shuah@kernel.org>, 
	Davidlohr Bueso <dave@stgolabs.net>, Soheil Hassas Yeganeh <soheil@google.com>, 
	Willem de Bruijn <willemb@google.com>, Eric Dumazet <edumazet@google.com>, Jens Axboe <axboe@kernel.dk>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 17, 2025 at 11:03=E2=80=AFAM Khazhy Kumykov <khazhy@chromium.or=
g> wrote:
>
> One ordering thing that sticks out to me is
(ordering can't help here since we'll rapidly be flapping between
ovflist in use and inactive... right)

