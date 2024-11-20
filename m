Return-Path: <linux-fsdevel+bounces-35368-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99BA19D4454
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2024 00:12:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 527481F21B04
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2024 23:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF6091BDA80;
	Wed, 20 Nov 2024 23:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qkcRHLPP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF44342048
	for <linux-fsdevel@vger.kernel.org>; Wed, 20 Nov 2024 23:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732144337; cv=none; b=AwIT0eQ8sWssgyTye8HJWuwAkpSxyOZLr/otKCKyvl0rbtYrGob1Lbdk6mNOT5lEPFsW+fI2mot4rdlOmVumXTLwz0Z7mgucYg1bUfm9KK0PjgbKJLp3YaValQXJevZPdUg+Vt6ZqZGmS068wfFfF9zmncDWmgm8A14H/W+z+to=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732144337; c=relaxed/simple;
	bh=x8HjiroxpsIYhVfoexyBukF6/dMPHY3yTGvhwTLtPGQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uwUwsfKBMBnBXmjVu93HNG0TFRAlYNw3yGS3q3nuFn4DomfX/6XcLgZgGPBX2fXEsf1q2F57H3mnihcg3XFhZZ1RaRMPmTxr+cR41wRPrEzDWsmbTZUlgHMvf4pmVaGw00ofjOgtzBp2MFtYvmROTcrzqRLwugHg2lxXr8OTHwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qkcRHLPP; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-211f1b2bf2bso29355ad.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Nov 2024 15:12:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732144335; x=1732749135; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x8HjiroxpsIYhVfoexyBukF6/dMPHY3yTGvhwTLtPGQ=;
        b=qkcRHLPP8S8S7w4JmZ7ARV5u8q1ncE2PvDvoAhBduj+1UvkBS6sry9vp6hapUld/EI
         241wBtNXi9zg1YymLCIjS5LOyaSdEPQl2S1Tnn8HQhrLUg36n7K646vJ16/d8txrLeOk
         25oG34zHOduCyvgfQWSw9zgtcim2fO2R3qhyE/LiEaCFzoMp41tCD2EWKq0OfGgU3jnS
         Xo44JsvoyKzR/SQrShRhSsekaA9O8QbDWbQT/iJMrtC29TeNMnsjws7fOU1yQ2H0bK0o
         M4C8n3bYw8ZV68WQxsd2Eq2TAr2tgbVPqWzm9aZ5F6CKw2SavHOUzDdUFeiordS0FVrW
         oNmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732144335; x=1732749135;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x8HjiroxpsIYhVfoexyBukF6/dMPHY3yTGvhwTLtPGQ=;
        b=MF5M1zWz3Yffkvwk/Q4fWDx9TvcW89QYrBl4TJrt5UFPekiWuo8LZIYs/xOHHRQKnf
         0HFfqOWB3W8Q+7sMkXg94qKP0JZUCo1qqw6jQcHudp8KjYbdeB7qZwFgs+71gMifJSyL
         DOPwIRjnWyoQ1ENfeXLmm2EUH1pret2y6UY9Tku3hBH/0YSAH5Ki5dHiNWq7G6q9C4zF
         bWvh3jooBOCPkLHvnzJJ00ZqO6RJlB3pV84RIbj5Ti2E+wU+SWB4v4a0f0zfbX/cRME9
         1MadnxtvAF5Fx6EEQqLHAoTeNxRtXPv0BJhJuTDtV4H/XxWrgljthgnmhin7jH/lna0p
         CQVw==
X-Forwarded-Encrypted: i=1; AJvYcCXlS64rtDlnDb4SVBFTopoVWNyZZqozLgoAWFiKLbPgRVmX20abK+kL2oy4nyVz9xCZ9FzxL1tHXV2JWXTt@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7BtvAVeJdJU5z66urZKdD663vKg6C6VD86H/FS5CPlwqO4eid
	wcr/L8b/+UvtCOG0NP2zEdMq7w4lO3bAKf7FZeqAx+Mq6CAJ+rGRi6QRtbnx5GRGNRRe2sauOmc
	0Cqp49ldOVAM5ub4XMjTUH1A4QVEk8kydnr6u
X-Gm-Gg: ASbGncudLIJMg3o0hkbsJgKQ2M/MflrmDkrvTHIe0Qu6E4x+oQs3QxV8EuF63kxqWAT
	PA15pOhQg18afehqNnxPDo//yMsrxQD4lRrq9d/jF+JBBHkF4yHkXMnUpp3s=
X-Google-Smtp-Source: AGHT+IHllzdMFCX/RYl2KtmCvSHbJhx7iEOYFL56BaE8loYLrfNGhRx1//aKyRIuYiDsLRGb0J/wKReDd2pe3MAnsZw=
X-Received: by 2002:a17:903:985:b0:20c:bb35:dafe with SMTP id
 d9443c01a7336-2128428b639mr1047155ad.0.1732144335092; Wed, 20 Nov 2024
 15:12:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241110152906.1747545-1-axboe@kernel.dk> <ZzI97bky3Rwzw18C@casper.infradead.org>
 <CAOUHufZX=fxTiKj20cft_Cq+6Q2Wo6tfq0HWucqsA3wCizteTg@mail.gmail.com>
 <ZzJ7obt4cLfFU-i2@casper.infradead.org> <CAOUHufadwDtw8rL76yay9m=KowPJQv67kx3hpEQ-KEYhxpdagw@mail.gmail.com>
In-Reply-To: <CAOUHufadwDtw8rL76yay9m=KowPJQv67kx3hpEQ-KEYhxpdagw@mail.gmail.com>
From: Yuanchu Xie <yuanchu@google.com>
Date: Wed, 20 Nov 2024 15:11:58 -0800
Message-ID: <CAJj2-QFworodFR0CE7FryJdKnv=2AEGbvJF=txZhdDPmFvaYsQ@mail.gmail.com>
Subject: Re: [PATCHSET v2 0/15] Uncached buffered IO
To: Yu Zhao <yuzhao@google.com>
Cc: Matthew Wilcox <willy@infradead.org>, Jens Axboe <axboe@kernel.dk>, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, hannes@cmpxchg.org, clm@meta.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 11, 2024 at 2:08=E2=80=AFPM Yu Zhao <yuzhao@google.com> wrote:
>
> I was under the impression that our engineers took care of that. But
> apparently it's still pending:
> https://lore.kernel.org/linux-man/20230320222057.1976956-1-talumbau@googl=
e.com/
>
> Will find someone else to follow up on that.
>

Following up on this thread. Alejandro applied the manpage change for NOREU=
SE.

https://lore.kernel.org/linux-man/20241120104714.kobevbrggqo7urun@devuan/

