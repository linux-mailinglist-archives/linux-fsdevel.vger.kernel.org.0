Return-Path: <linux-fsdevel+bounces-27161-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 958D895F14C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 14:26:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8F6FB21EFA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 12:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3233516F908;
	Mon, 26 Aug 2024 12:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="O5dxkop4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5929A16EC19
	for <linux-fsdevel@vger.kernel.org>; Mon, 26 Aug 2024 12:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724675181; cv=none; b=Br2UNV/SBLcnCCOWmLZr4VSBFotrMq5of3IQ/v8ehzL2Xs+85SgcZU3TrBXJZXR7jLa2nr1SnHvM3/Sl6yF2ym3tprdL7lrZw8N6EevbdFORpIFxvZwNZfEmNGAq9u3PAockel0bycY+HcmNJ+z3LbfvuG2Elj3ZTnZnwwRjkp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724675181; c=relaxed/simple;
	bh=pagydAvzvZpx88GqbX7fQb/9e8ooMGjJGmoNcsY+0zE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IXSUbwE4CeSE3xlvodC8BbDaY5XCnbRhGQxJ9aSzuRnFjJ7RSbazTl35QZ3W3kjEzXlGwijz4Wc42QqFpMTkn4rQ+8uHX9CQA4ChDs2rqKYAMHCi8VNo4TIxsu1Hbfg0FV0HTGo+GypehEahRPqNJ3YEKLN8cT7vvvNyHwWItKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=O5dxkop4; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-533521cd1c3so4854257e87.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Aug 2024 05:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1724675177; x=1725279977; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZPZa8z5KaYcGXwMz9yqXraXx2BOzrBRSPNhLZ5vpqsA=;
        b=O5dxkop46IFyT1R9BcvU3+t2qWZFZXPCvMLc28Jo/ji4JbdZAYCeERNEpNWPA3j2Or
         qfV9kkFGeEU4FOF0cMe28Tg1gM7leZtrKJh7DIlgC9dA5mUfqca3dLBhtwzq5FqJHe2y
         4+LaQq3yEwsn5iEVcLYekkhczHfyNrWJ0cdFU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724675177; x=1725279977;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZPZa8z5KaYcGXwMz9yqXraXx2BOzrBRSPNhLZ5vpqsA=;
        b=s4MeZR+A25ld3huVyL8Fqv/+kXdHO/DonG/IVIEcfKGlLs4z/HnInWf/ZRXtoXhuZ1
         Ua5cWUYkt8Fz81F8Pew/v03466+s/aPW/pBk1PQfYAQJJJUe9oc0hFHog7205LP+RFxr
         7N7RBTIY9dNqCdDLQY5fwyx+wNOpLxa2E5E8xOyyQim7CQgXdGgcScoftTkXyjN6pidZ
         mSVRafROohsl2C+cxjfgrrVUpjN1ZEsTmEP18g8Xdkp77qHRHAIZe3lhs3dTY63lAMGU
         Ctoa8WwuX6DW/rc8XjU/a5b2vrxTczV+PdjNDqRKPadp3DcqsLK+Oe6BcW1QQeeosN3T
         G2kg==
X-Forwarded-Encrypted: i=1; AJvYcCUm4/5fZmw6q2ayE/f1ZHaeT2zihu5TFEukLKbLQD+nG+3BNM/exO0qXQ7hCDuPYt3jYEMxXR0K4H2hLglB@vger.kernel.org
X-Gm-Message-State: AOJu0YxwmDdMK6DVyCBFieEG4DWSmXrD1zVD86gltEbxW/DoOR3WqCQq
	tAGTAzVtRKnkAHo48siJlEISylKrL6FQ//apWNIasriiYoGcZcHwzSjXHqhiBG7j2cZ8nKemSWA
	vzd1ScX2VO4JdLd1p9QOjXYzp4NMcObb41/cpWg==
X-Google-Smtp-Source: AGHT+IHcIrvI4/qCTVNkp4GR0C2hU9chlKv5LmalO9VjJeNbl8gIATqDEuVCEuFUip3z+LI8mm4ypP9hikrdoWLQ0Zg=
X-Received: by 2002:a05:6512:ba1:b0:52f:cd03:a823 with SMTP id
 2adb3069b0e04-5343887e0f9mr9418735e87.45.1724675176318; Mon, 26 Aug 2024
 05:26:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87seurv5hb.fsf@oldenburg.str.redhat.com>
In-Reply-To: <87seurv5hb.fsf@oldenburg.str.redhat.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 26 Aug 2024 14:26:04 +0200
Message-ID: <CAJfpegsxVmJLT7uL7d2s1nhGQaXr4ymYeZZ-ttaOAVauf6Zv=w@mail.gmail.com>
Subject: Re: Recommended version handshake for FUSE clients
To: Florian Weimer <fweimer@redhat.com>
Cc: fuse-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, 
	linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 26 Aug 2024 at 14:22, Florian Weimer <fweimer@redhat.com> wrote:

> Or perhaps I should bundle some older version of <linux/fuse.h> with my
> sources?

Bundling the fuse header with your sources is the only sane thing to
do.  Libfuse does this, and so should you.

Thanks,
Miklos

