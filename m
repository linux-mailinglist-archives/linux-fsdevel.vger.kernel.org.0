Return-Path: <linux-fsdevel+bounces-32331-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B84D9A3AAE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Oct 2024 11:59:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B93BEB2635A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Oct 2024 09:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 318D520101F;
	Fri, 18 Oct 2024 09:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="JEwmoeRj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E68220101C
	for <linux-fsdevel@vger.kernel.org>; Fri, 18 Oct 2024 09:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729245559; cv=none; b=F9pGyu1MFgTarkUPjVupOO5ycFBBxXSpbEr4v/SsvHZ+62Ar+uHYhff0kWVPcYo0it1A92SSuwlDe0o9QU8ckMfH84svBJbSkWMiXKBaoiIfmoiNR0AZLhYFR2uGi4eKsddY2UcxMoWrr1fDbwUZmNKYQkkMlOzJ9HmUdvIpZus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729245559; c=relaxed/simple;
	bh=W2yqLZaQFhSAfNo505y5mh80FQgBOxnBVjtPEoOFgvs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c8linZ82iQb5ouGdymaHiJWh+x1/HSx3HLg/XYCHaNK+vRSBH4FNnVJ7mBRQScq/KbjnsuwZfcltzgYTTmzFBb3/B61CyzNbtJnW12fnd+NwS3xNCU3QiNncx7KFeGvRYoKIYgLYMo0TIYX9qRvubkSE4FvzpiNx9xHv/20eiJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=JEwmoeRj; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a99ebb390a5so567961066b.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Oct 2024 02:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1729245556; x=1729850356; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dEVozXofmob2dE9P8qAG0HgKvCfhRMamhDa+57NUyUs=;
        b=JEwmoeRjJJGWxNCdPTGQsGyhyY6ew9yVWI8XQk8MGF9kppaKa71109uUbowXtzEisj
         Zzy4GgipU4icKgkjAAcFjcsgM00ojTW1ZjA1jAI0E7kHPaBecyjY4IjIgCO77s7TKqco
         agaE3WD5iA9a2+9K0yZvKs9fhuZr9i0bK5PQA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729245556; x=1729850356;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dEVozXofmob2dE9P8qAG0HgKvCfhRMamhDa+57NUyUs=;
        b=HM8pNADghkA9VlPk2Iem1Z1C/kkaipC+H+jhoQ8SW7fzh/ZGqzM1q9ZSe2rzd1Wx3A
         VzYwozdqZ1Oe6akuiv/97DIHcdFTL995c3w1eXXK+YO9dhkZytlPweFIDA7ZQb1BNwOx
         QN8ZSy8sw9s/xo1AitIgi5P+3nNe4RWxUdv/AhEr/0Z5YoqHoMUIOOftTiQvIjLhKKPd
         w4j0EqcrR//POA8U19gUNKT+ts2F/Kc/YVePNmesNZPQ8Pp/79ps3ieYn7aAn+H7vh2J
         rLH+6JUM9L3j1VfhETsx6SFrrac+ted75TvYqN1u2sae+bpChCvaE30LAITYcyJ10fda
         piVg==
X-Gm-Message-State: AOJu0YwUIQgITURLSijCi+ZOCZCRZhT90waPM3kS5CGtdL4xnLc45tdT
	o/L2+jPkyWAg7Z0SQ+MxO5QFS7YIMqFlV382FfcFJj/NDDOW/AG89oSWhni2jc+XKnLPxn7JOzQ
	++xOZKUNaR0Cus2ifq1IlZbuRmHszOzLLubX5U2UOOQFtOJ9j
X-Google-Smtp-Source: AGHT+IFc+c1muXA/ibJ2SrlCUtcaz49mk1voaHqTMcAdqfJXzKOFYgYwfBGkuprWnRcaYBrv4VpmW/Z/zgy6LeSW5xM=
X-Received: by 2002:a17:907:3f2a:b0:a99:f209:cea3 with SMTP id
 a640c23a62f3a-a9a6a412745mr183669966b.11.1729245556415; Fri, 18 Oct 2024
 02:59:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1727703714.git.josef@toxicpanda.com>
In-Reply-To: <cover.1727703714.git.josef@toxicpanda.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 18 Oct 2024 11:59:04 +0200
Message-ID: <CAJfpegvZL_EQ12CacYUh=GX87wifzD=U2a-5TqCCWEeRk3Ge4w@mail.gmail.com>
Subject: Re: [PATCH v4 00/10] fuse: folio conversions
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-fsdevel@vger.kernel.org, amir73il@gmail.com, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 30 Sept 2024 at 15:45, Josef Bacik <josef@toxicpanda.com> wrote:

> This is a prep series for my work to enable large folios on fuse.  It has two
> dependencies, one is Joanne's writeback clean patches

Applied with minor modifications.  Now in fuse.git/for-next

Thanks,
Miklos

