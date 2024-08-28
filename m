Return-Path: <linux-fsdevel+bounces-27609-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46846962D28
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 18:02:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA00D1F219C6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 16:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9A0F1A3BBF;
	Wed, 28 Aug 2024 16:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="IHL+oubC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC40D1A254C
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Aug 2024 16:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724860900; cv=none; b=Q2YAfDMlk5FCLEV5bQ3CxCL7xixxLjaFOr1Xxs5U4WEqcyWBSOhMZNSX5/2PZfkS5DsZ7PSQj55bHmsPqB8hoVf5CpmSbtKdGo2jzlUpbIXExyYfqv5yP+d6jcsn5apa2c+cjFp+CZxDi3gqxWVaXfv5oeExOqo7q02WAjiWjAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724860900; c=relaxed/simple;
	bh=xOJyaX8eDP3JJi8TXw9iibsjr95k7dWvoIYF0PDKRt4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VyrHwVsy5vgBa6LDDsXlpP8Od/Shlp4nPKpMoiRLhsm6TnHtIn08q2ewtIeTz4lUmaR4fBI9iRTjdTC3Fr6kCNjTrKQ3UBadwfTuYv9HYPyFlI44K4TmoYE1LalNWlaB8fGv2Q9BVOy0wfNwKPRSAl6x4r51SNibutQCxPqc5c4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=IHL+oubC; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a86a0b5513aso608715866b.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Aug 2024 09:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1724860896; x=1725465696; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BvzGWmKRfT1F45Aqj5R12rQjwDY4TtY3hxkmmi79R88=;
        b=IHL+oubClNaZvOC/KWkru7R7KK2Am2ecPolUPGY5Td6chveRshKS6wzHpZmqjhaTUR
         qs6mLxOOTI7F9+6dtE+H4Ucu05G5GI3/HMJtS0Gt5nCHHiT4HEAUh4E3nK8cgZSltiKA
         Rru+LytMHLWZ7Kr2gLMxXa3HDgRvZaD4IXddM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724860896; x=1725465696;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BvzGWmKRfT1F45Aqj5R12rQjwDY4TtY3hxkmmi79R88=;
        b=Y+28778XAmi01o/Rqq1IN9bcbrljN9OO+HL5L+W56perWvXMyvqIqzF7QWP7OVzql5
         x/WeT4qACjIYxR61MZFfxjCUf1SKeXHYAbTBIKWVZHVLqq2/nYMNJJDi8KJIOUuBC8T/
         uvHetaS+g7Mj3meprqzp/1cXCAsiCfo8ccIEDLASH7TRWaACAA9T9XRUuZmWJF1ZJ9kq
         YytRoi+sNaWzshGMULtW6+LKKpTkjEZbiXV4C18SVBRMrfp0lNxFBDOZp/d3+gCm7MfR
         wi7UQv+b1b1VmpdolegPyEK5QNNrO6zZT11RyhUGrmhVTeoBkpDHWuUmS/eFuVwOqbL5
         As2w==
X-Gm-Message-State: AOJu0YwCnSdEr/n16cQlxCJD/HlDFdlR2HYDWHz2qbA3338ZvSU5LvEs
	IJGuyjIevlCS4CXVQ9b/jUvVTp7eyT6Zh3PkZgKJqNhpMsGuNMr+szAQvj6rBX3yx+UvqNs8YYD
	PyhaBTEVzP5D9sOodZWHjnYo1xQkT/PPjzW86Rg==
X-Google-Smtp-Source: AGHT+IEwHNc1kfEtW3POxV8Da0toY1GDPKpdHXzApzzezvVoGapBNR5raTns6y7lPGVZvIIvMGyIzCXSD3u7V63eJqA=
X-Received: by 2002:a17:907:d5a0:b0:a86:a090:5caa with SMTP id
 a640c23a62f3a-a86a52de579mr1181447566b.34.1724860895583; Wed, 28 Aug 2024
 09:01:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <fc6559455ed29437cd414c0fc838ef4749670ff2.1720017492.git.josef@toxicpanda.com>
In-Reply-To: <fc6559455ed29437cd414c0fc838ef4749670ff2.1720017492.git.josef@toxicpanda.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 28 Aug 2024 18:01:23 +0200
Message-ID: <CAJfpegv07=fxHxT8mfE0HGXr1XpmER8bV0hpE32LSoaVr-4qGw@mail.gmail.com>
Subject: Re: [PATCH][RESEND] fuse: add simple request tracepoints
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 3 Jul 2024 at 16:39, Josef Bacik <josef@toxicpanda.com> wrote:
>
> I've been timing various fuse operations and it's quite annoying to do
> with kprobes.  Add two tracepoints for sending and ending fuse requests
> to make it easier to debug and time various operations.
>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Applied, thanks.

Miklos

