Return-Path: <linux-fsdevel+bounces-24829-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D132C9451C0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 19:45:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8854D1F243F2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 17:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADD251B3742;
	Thu,  1 Aug 2024 17:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="il1JUOQP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C767313C8E3
	for <linux-fsdevel@vger.kernel.org>; Thu,  1 Aug 2024 17:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722534341; cv=none; b=eVl+8P/6W11Ta94Kst4NRfm9MeTNoP/vdpo2X7tW3vWCbihYO5JWbRcjxeQ9qoUUikDETjbPNt6Z6n9dKtZym3/xNtpqG5eHkHC13u6+C8h7hl1J9YZZW20fYQ/910fV/CguT5bJPAPHM8a09PvGUZde+WUhexRKWDeIUnK6Ad4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722534341; c=relaxed/simple;
	bh=Md+tCugX0T6DBlJwjfQAImnL31p6sihip5oruYd0jwI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FpwHn7A7Fzi/9cfHod4i/Ih/J/gZIY+CGnATup2PNBGKr7ehHCHQ5itUvOYUxaI0ojSaQvOJJSlWziwwit3PtAxcnn6MaiKcGi6AV7eBInnarXCXe26l4bJ5KoM0EKqdRa1FnlEQlnHETMIGSpzwOurPbuYGxfodsE6B++yWWRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=il1JUOQP; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6b79fc76d03so40830016d6.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 01 Aug 2024 10:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722534339; x=1723139139; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Md+tCugX0T6DBlJwjfQAImnL31p6sihip5oruYd0jwI=;
        b=il1JUOQPm2e5t3jH9ynm5lAPIr4aXRRPUNbkRi6qZIStlLoaHjHANUmWVb6Kntr6Gu
         52QCf8XeTIDWtwwtuR8V+RhOT+ByYhGTGvVD/QPX3DyLltIwFzZXvkkjkxmG6KgAHN9B
         nIIzQeXEYrShVZ70Fr8e5ay4yZr9WrpqTedd5+s+sJTLFFwzbwDEpYM+PECJNJXQHbl2
         DodFjktjQHHRIxdU9brulkLudt/Wa2AECws+RlSLkBaeODs6CxuFpw+fqqg7ZFziuUfS
         qgXQM5vXUaptQMSSsr9qtHYOrXn/Zn5P6xbLSnjZCt6grDRE4CGUCLGHJY7awngiKkvS
         qNKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722534339; x=1723139139;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Md+tCugX0T6DBlJwjfQAImnL31p6sihip5oruYd0jwI=;
        b=WN/P5t18SoTptY9dH3m2Q2xxUrTljEUXeCa7efhvKO6LHgYeUcJkONRk3pVfNgRKDq
         4rc0TTyAHpZKmV4AQ6Rt98jzVAZk3qEVn3tG3gkUH5gkjPLr0rbLX9D1C2slUoIVEFWC
         qwIq8ceSQnYlNfJHon4CxMib3pm/TM+8X3LVG/mglu/dyYS7kCSYldAG7BDYLN77BQe2
         v4gN59n1dEA29nyUCYwr3HzpDnX4/W6tjATMV3Zzuu3uQXy6fM1z3xdXeI3IBaCkg971
         riB/PZBUUpstSbPTTZCbSO2R8T+WdrbkWw2BXlqH2l+vRJQNlap6qTH5dwH71Zei7XKJ
         AQPA==
X-Forwarded-Encrypted: i=1; AJvYcCVLmURfzfZ7u7n2bRLvslDyhmIfOa6MouKBeU78sgeoWx/+vI5cJfKNDdCNDxRiHeIbHAo8qkP483+dFERPdGtWqUzG6tP0Pmp5Sd3GWA==
X-Gm-Message-State: AOJu0YxQ0ubndNJdy13kr5qwCeCvHdBnHlUSi1N6J7Vk2s2AxZndB3t7
	h/rhjVON4Ghed678c9Mb1FO8wMqf6Qr2WUj1viVQVOipq6H6Q1MDgwcknFxVH/mzgxzr2bRDy1l
	ciiWAB5kWasR0DB5VFfMEE871YMLyFcYwG2H6
X-Google-Smtp-Source: AGHT+IHxqFWXrBnwwKA5uii4m8WRktVKp0ck40g4Sz01mi9eFCVRKd2tDwa3fcr6zENHmZS+RQTGRB9qTrhExEKmqA8=
X-Received: by 2002:a05:6214:5b85:b0:6b5:e3ba:5251 with SMTP id
 6a1803df08f44-6bb98332800mr13418176d6.8.1722534338642; Thu, 01 Aug 2024
 10:45:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240730142802.1082627-1-arnd@kernel.org> <20240801010953.GA1835661@google.com>
In-Reply-To: <20240801010953.GA1835661@google.com>
From: Richard Fung <richardfung@google.com>
Date: Thu, 1 Aug 2024 10:45:01 -0700
Message-ID: <CAGndiTNdCGuHRmnp+G-=_PzTaLXnUZpuXAT8dK-wdoG7Mpwt4A@mail.gmail.com>
Subject: Re: [PATCH] fuse: fs-verity: aoid out-of-range comparison
To: Eric Biggers <ebiggers@kernel.org>
Cc: Arnd Bergmann <arnd@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>, Arnd Bergmann <arnd@arndb.de>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

> I think this was just defensive coding to ensure that the assignment to iov_len can't overflow regardless of the type of digest_size

I agree with this. Removing it sounds good to me

