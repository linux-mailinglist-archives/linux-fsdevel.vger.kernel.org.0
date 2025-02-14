Return-Path: <linux-fsdevel+bounces-41717-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B81DCA35E74
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Feb 2025 14:11:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 731701892AA0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Feb 2025 13:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 833E22641FC;
	Fri, 14 Feb 2025 13:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="T2b7UZJc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C30F1DF261
	for <linux-fsdevel@vger.kernel.org>; Fri, 14 Feb 2025 13:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739538277; cv=none; b=L1NClnItMh9lJofFIOsEP5/kZYvweOFwYxG3WA2bRYAgCc0lptmGjtfRqrm5qXd5StMaYkgxvYzfxV4XfuUqH+LBO1OwjRqo2srCYoQWqrt+TDqIU3FkEvAKzIaw0UxVWtBYdFAVX+7imeqSKmuSP56ywVEMKfRJTw5TJeSKfEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739538277; c=relaxed/simple;
	bh=kGaoVgiLrAptOxmwP6NwhdVGvRR6+XxpWuwi1Jikbtg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SMXHN9Yoh4egW8pjogxJyMmAcadUnPc/YR5I+6VQLTLDyZhPzyM49MjuoSW1dhcPVPQ5UIY05XtNSIjUXRbGvmLNftPsged8vmPICLAxaMXlCzKl3NoIf30+NvLrA2SYW+UnCiS2p523MxHcmkOxep/lSsMXxp3mCRsfemX8O04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=T2b7UZJc; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-46c8474d8f6so17093801cf.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Feb 2025 05:04:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1739538274; x=1740143074; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vHmrVly4vSIGIYyzUZmKOCsqXSVt8EErpUP4XcPKMr0=;
        b=T2b7UZJca3LzpCfkJPWK6V5bg+bkr/gLt14DsWvnb/zQXsYybaIz7eN/DjbqJmyBaj
         P359geUYIxffyWtMCWN42ER2GUW8QJt8RTLiNjENCz3H8JuXUaY93ExY0/y2RJvZ423Y
         nV2pdm/jtR25QpTj8JOOh+t0cNOIhV2x+XdRM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739538274; x=1740143074;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vHmrVly4vSIGIYyzUZmKOCsqXSVt8EErpUP4XcPKMr0=;
        b=gdwm60u1IxZ6xbkLtoPv2ZWRecUYCdUoEZNAHFYIxo/kCPVGfEjNsHt7rVMWJPkhNd
         KAc/TfWc+dD9J1cwoKSpiBBkFXqZ/Igx1b5UBtEacjVhiq7Z6ZEhzFCjvwiOXq3akV1Q
         /Qqok4Fx4V4GTOylpBDltLoxiUT+SlEBbwBxnAKePJ5w4+WZIj/GN044/WKiJeZ2PR5Q
         hRirkafJbUK2SJA7tBCUMzC2F4zaEsxQOtU5ewNPuFatKlRvY5j8FpwN3ovXJpRLPPOQ
         Vcve3mVnVleL4LogVBJgvapR4cUbqHnfIYfqGmPlMwdDnM3Q0sax6jkTWyX7fISyu0Cj
         FNlQ==
X-Gm-Message-State: AOJu0YyuSxnOoaVyzDanwim7Jm7PvB/91b7FBLdUgaG37vtHq8uhp9X7
	O5GTkRFoELsFPp6sw1jAlQeBa1qFiP/TTY+bQkmNFvwwQXbUlNApPVgdON3HfeyX6NZxbqILqI4
	EqVyF3pZz5gx3R1aMvGRpVsV39dc8xuM2eSegMiXpqrZIBKoW
X-Gm-Gg: ASbGncvO8yTs81Y85X+QhoLZlmtABAQICntDhSsUybK7JF72eZy/0VMEApkvtefUCYY
	layudxdh2xAPPJd66H6MHAS1/Yc+rJdEcrpTxBuo8SBuCXvIQxMpSo11AKP2aGC4+tFPpQpU=
X-Google-Smtp-Source: AGHT+IG5kEh3YPDEBWIqGR1p6/QdcG8b7Iu1qWbMrjez2iR0FJKFb8x2TLZXC+sfw+BSDXjsMLaUEB6y1UUJwV5p8cA=
X-Received: by 2002:ac8:5988:0:b0:471:bf91:816b with SMTP id
 d75a77b69052e-471bf9182b2mr119967451cf.32.1739538274221; Fri, 14 Feb 2025
 05:04:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250204-fuse-fixes-v1-1-c1e1bed8cdb7@kernel.org>
 <CAJfpegsOOv7c3R5zQZWWvYEgZxyWGCJyf8z=A8swQQZsGyvuDQ@mail.gmail.com> <2ec361038d22e9ed5dbe8e69b08a0a31685c7274.camel@kernel.org>
In-Reply-To: <2ec361038d22e9ed5dbe8e69b08a0a31685c7274.camel@kernel.org>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 14 Feb 2025 14:04:23 +0100
X-Gm-Features: AWEUYZmahJ6iPY3B9j5L8nh0hKDFOG0aES3WJjmrI2sFzF2I1X0TUqGuRE9Y918
Message-ID: <CAJfpegvKGa6RzxNKCDER+hXvKCJuMzeHq-xQaRNYzgQr_9yhUg@mail.gmail.com>
Subject: Re: [PATCH] fuse: don't set file->private_data in fuse_conn_waiting_read
To: Jeff Layton <jlayton@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 14 Feb 2025 at 13:58, Jeff Layton <jlayton@kernel.org> wrote:

> It's just an unnecessary assignment. Nothing will look at or use
> private_data in this codepath, so there is no need to set it.

I think the reason it was done this way is to return a sane value even
in the case of small reads (i.e. char-by-char).  It's unlikely to
matter in real life, but removing it is not a big enough win to be
worth risking it.

Thanks,
Miklos

