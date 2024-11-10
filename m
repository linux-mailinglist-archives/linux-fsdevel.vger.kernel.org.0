Return-Path: <linux-fsdevel+bounces-34165-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 215159C34FE
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Nov 2024 23:09:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD76E1F21333
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Nov 2024 22:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1124815855E;
	Sun, 10 Nov 2024 22:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="LGoHEhmr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A63C8157493
	for <linux-fsdevel@vger.kernel.org>; Sun, 10 Nov 2024 22:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731276545; cv=none; b=sh2N3Mn/md8As7NfRGwkv+j+OLHuWeRgiA6dePb8qxfTPJG4GuNQcimzdPzUND7g+P7slHVJ8brA049G0nPiy6pwbIFLTjb3bpHoKVfsWmJ6dsASHJi4EXc59Z02kYNIqHVdHZ4HkxzOhTLGpLAdLSQmGz7svnq/HTc8DjksIsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731276545; c=relaxed/simple;
	bh=0MQpXldGbOUiOX0Q59t4XbUm1yl5q3vOpFkNG4YlEq8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RV2xWbUQFC5O3IQczg/FRzB2V36oCavSZABISGmNbdAaaR1CTs5YF2PJ2ztXUiNv7sLj58Numy3yH6h8SYdiNNdo5nKsVpE4UCa3iiafCkPIMolkrzY5HquU5piRGU+HhwHEVZ/nycBXKPOr5oameSPVvG2dZ8Y1zW/0Sj/CIu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=LGoHEhmr; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5cec9609303so4719901a12.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 10 Nov 2024 14:09:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1731276542; x=1731881342; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ldAepWh5Q6dryoEoVJkGu/LkFMWpEkN9IhbtZ9HDemA=;
        b=LGoHEhmrd1bIQPhHXi65GDZa1fXRxZAPn2nv7YxCET9+iaGOwq02k4vWzWa72iSVP7
         ARhRYgVQo0Ihw2aIJV3ys1qEfCa+qNBZtqekhV3Fhdsvj5yBh2gO/SO3Fcmlb4l0ZK2j
         pfL4s2l0coydZz+XQfpZdGVXHgIKgMivCRrxY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731276542; x=1731881342;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ldAepWh5Q6dryoEoVJkGu/LkFMWpEkN9IhbtZ9HDemA=;
        b=cYNpTrJnr26nE/Up7jXIggjMLxGhMBoWmFqtQaQV/sStBgbfUEwkoJeK7DEGsJ1ejP
         bK/0ATlxMICND7Xn+yU1V8XSVMdBgNetP93oxduqqO6p7UwO3F+DhrT36E7BSsEOQSbX
         s4JvTTIAqrcxStVJnBM45e/fRa4pmGm8E6KJ9wUrhEXdHXFtFpAV1FAI1pYFsnNl2xbS
         9dyq0hT2uAIKC9t4CFA16sNV2UnhGwhxNgyZnPKi87V+q+FP0zLoot2NUCyOQ1JdzpdQ
         xDx/BcSd7zRtt8Ts6ctliTQPm6Paro4zQaO1l30zxE2jcA9UQCPwKP4W0KdJ7nyZx0SJ
         YY0w==
X-Forwarded-Encrypted: i=1; AJvYcCXNjCncmdA32IbvZEeLUi2FZ2kGkSoCw3c8n0EXmph+D4MP7mvlJisSheffKrVUYBtsmeZUE62byVVFWgRp@vger.kernel.org
X-Gm-Message-State: AOJu0YyOeOOovTndOuau21jdW034wJcJDm2UJ4rtvqr+nyjE49ahlz0N
	HbcP3Wew2UHxOSoAfGwpsOdQumsytkqSv1kj3s9WGVVKIXu/KVEfexn2jIGb1tq6n8jagMCBCtk
	7/X4=
X-Google-Smtp-Source: AGHT+IEi3GPtx2cqW7iKinooStPgcOZ+pB3jph5RgemT5ohrwm+eAd5ec/N5xhl4dt1FbsEg4XToJA==
X-Received: by 2002:a05:6402:1e91:b0:5cf:22ab:c3b3 with SMTP id 4fb4d7f45d1cf-5cf22abcbb9mr4922494a12.2.1731276541762;
        Sun, 10 Nov 2024 14:09:01 -0800 (PST)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cf03bb7fcasm4434164a12.52.2024.11.10.14.08.59
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Nov 2024 14:09:00 -0800 (PST)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a99eb8b607aso570142866b.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 10 Nov 2024 14:08:59 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUVoRwv9cSIqaQCT4dgallSkRhun9Cf0sync1Bi4wuag+HGvUT62LPAiXupYtCoBrxLpJQd1+W1A+A8SIKi@vger.kernel.org
X-Received: by 2002:a17:907:1c11:b0:a9e:82d2:3168 with SMTP id
 a640c23a62f3a-a9eefff1525mr946225066b.46.1731276539301; Sun, 10 Nov 2024
 14:08:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <f875d790e335792eca5b925d0c2c559c4e7fa299.1729859474.git.trond.myklebust@hammerspace.com>
 <ZzDphC-x1XEFlDvD@kernel.org>
In-Reply-To: <ZzDphC-x1XEFlDvD@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 10 Nov 2024 14:08:40 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi+h=Pqby5RBnOfrPH2TikXK6S_bsX8-9Usp0LjJKnHxA@mail.gmail.com>
Message-ID: <CAHk-=wi+h=Pqby5RBnOfrPH2TikXK6S_bsX8-9Usp0LjJKnHxA@mail.gmail.com>
Subject: Re: [PATCH RESEND] filemap: Fix bounds checking in filemap_read()
To: Mike Snitzer <snitzer@kernel.org>
Cc: Matthew Wilcox <willy@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Christian Brauner <brauner@kernel.org>, trondmy@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 10 Nov 2024 at 09:12, Mike Snitzer <snitzer@kernel.org> wrote:
>
> This mm fix is still needed for 6.12.

Thanks for pointing it out. I've applied it directly,

            Linus

