Return-Path: <linux-fsdevel+bounces-70289-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 7431DC95CCE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 01 Dec 2025 07:27:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C59CA342C74
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Dec 2025 06:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AC33279DCC;
	Mon,  1 Dec 2025 06:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="diUvYkqQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F124226ED3C
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Dec 2025 06:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764570442; cv=none; b=jrNh8mqxvZveqagFhbmHk4sf5RR8jK2JnIQr5mW1m4TZ6/JsMY966nRqpYgotuK0wB3qP9UPIqtNSGpLTDTEr4oEf04l7hrGf0PHtqFiFCkmQCcPGWmPUY4pZiqzsC+1GEGRf/SMFptHzi2jOwBEsua3E3Wai3JOgtQcVuCKXy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764570442; c=relaxed/simple;
	bh=4tuW/07fuJwuiqoJvvItaDu7mFOzV/6zMpck9JTrQSY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XwQ3OutNWVraxBfEm4BcIghWtAAd+VDA5grB0ml7mzlqGdZZ05I7l1zyDy2I1XgOdkp6bL0jPq2mVQtuZGo66WRknClUFNPt+JWL96xnIJ/vkCtsw0o4LLZ5WsOEgPHZicXNX45S5wopTUD+CEQSILFFObd3HEemDbj9zQwoIkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=diUvYkqQ; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-64198771a9bso7375718a12.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 30 Nov 2025 22:27:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764570439; x=1765175239; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4tuW/07fuJwuiqoJvvItaDu7mFOzV/6zMpck9JTrQSY=;
        b=diUvYkqQNWxdyCsLf4cEIG2gYLVwzPirs3HyJQPZwyiGJsSSIjFEEI2tPR8Ylqk/Cf
         +oqYSlCjM0rWOMkIz3LL6HQgb74X61IyWPHEapsBoDlR7Hi8VFUcsQebkYdfrGt9q9z4
         1Gfab2LtfjgMoLWGl3Gp43l3rt2ZA1Hs2IrB8EfFtKHqfluGrnXKTz9Btn2BlEZiP5cv
         LVuZPfhIIMSR1h1iOnSequeLwfz4vCSyw7p5aO5oDd98RRC7K/7NGTjzUZN0EtE6vA7o
         9dDO9AyijAIMmwqf6/VacWobbBRX7SM4acq4xHR/8e8WJvBxIZvHcUjCP/5BJ7dCO9D0
         HL9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764570439; x=1765175239;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4tuW/07fuJwuiqoJvvItaDu7mFOzV/6zMpck9JTrQSY=;
        b=uRgka3D1kw28Ol9eVOtPP+5y9YC9FLuDeJRtTjiI47uObtu3vAu6qqY7jfM2d43MLt
         s3S8Y+f8wOysvcqrIE2nIcGoq1lATEOtduKD4XWB6JYw+8M+bcTp7YJYt5YgY0ZfALqN
         wr28Dwx/KCTeWfDfRK0d5uBUPK3BW5WbI2V0El6HUHj6L7MVWQFKdBjRtfDrH4/0uPEM
         Oh97z4hbkWKVPUXFX5onKTwx3CXYzP3SveL9MmWGlqEGzTbMQKLPjZ3dYo7RdqH6qtZl
         O+k6sQntuqoTx0iq3WeKvLGJd03BjM/6jH1IvwPhxu/8QMGccICYw4cUlHbmHhsLyx3O
         Xt/A==
X-Forwarded-Encrypted: i=1; AJvYcCWdMRkxgPUHtXkOtLRxUn52l4UR4Crhsj0w6nqhxg7MliuM9UPR7F80T7/w0KkzGD/LkZ/TvJ32FvWGpKGG@vger.kernel.org
X-Gm-Message-State: AOJu0Yxy22X0ctvphs5TMB2X0eoBjPRyOXNCvP6i+42ycqKCaILbOg5U
	5bdFIoZOOWBS7eM0eKZLEslLNgszivmXgrQ4jCzQ6VYpaeuUOnIQjdm5y7W4g5QEBjzDrpU66X6
	QVcM9YTVhJMmZmKuVovmQLz6kpoXFeNE=
X-Gm-Gg: ASbGncs64dFIdXylIKWr2/9/w78QeHYuxKO1pQCZorjExAmushowrTfjfBUvt6kfgBr
	gD7rgVk6u1NS8Uv340X4wMQYQPGixHCUnioR6mTq16dGRuN9+yH7BERWQQnnAkRP52e4I7T4BI1
	79HTzvNOigkuWr1Rl5Uiwic4AROt+hF+hvAkVkpXIBmqLSBpPwTzIb4rmAKyd7iYvsklDd+e2RL
	zYM5Z2mErWIRP1/EKHaEaYSuwnVjC6DQqWr8zLOs3LRiycpHxWIDKOOExzFFTID/Gla3tedN1AY
	cN1vq7FfV9LFg5Zkwu2aXZvy2I8QHNYQdAv3
X-Google-Smtp-Source: AGHT+IGXawMuA2MxkFWERJonqEPl7h17EkCJJNxwHWXKVKUP7BPiJPjGHaGIVU7NAxHfDoy5Z4cyGp35gAyciUrEMts=
X-Received: by 2002:a17:907:741:b0:b76:3548:b741 with SMTP id
 a640c23a62f3a-b767153f880mr4007226266b.10.1764570439011; Sun, 30 Nov 2025
 22:27:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251129155500.43116-1-mjguzik@gmail.com>
In-Reply-To: <20251129155500.43116-1-mjguzik@gmail.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Mon, 1 Dec 2025 07:27:05 +0100
X-Gm-Features: AWmQ_blfvvf0kLGOEQJGFWeQbdMDUD0QYPJrQkwxVWCrlrfNuQVBB-ESA4zi7Ng
Message-ID: <CAGudoHHnzB5-OWujgJsbyvCfo71QDkbgwsvWeqOady6BCi8Fcw@mail.gmail.com>
Subject: Re: [PATCH 1/2] fs: move getname and putname handlers into namei.h
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk, jack@suse.cz, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

self-NAK, i'm going to rebase on top of
https://lore.kernel.org/linux-fsdevel/20251129170142.150639-1-viro@zeniv.linux.org.uk/
when the time comes

