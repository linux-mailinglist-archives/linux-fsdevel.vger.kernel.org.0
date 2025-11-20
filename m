Return-Path: <linux-fsdevel+bounces-69217-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 17DFAC735BB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 11:03:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E878D349548
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 10:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A9573115A1;
	Thu, 20 Nov 2025 09:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W66DEFEN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F232830F544
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Nov 2025 09:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763632793; cv=none; b=lZ+f522Bye99dBkud2Xzpnil97k4BAPU110I41U2Yov0BMLPFV5Q29u6qrNfmjxMI3v6CzN4opo0hRo1cXSrhK7FOH7/xWkTx9oEN/Qm+Op+DucHwaX6vf8Zg7Ac9zflLUMnRksXv3oyli9rWh/N0cAvbf5SMuWu6X1T+yYnT14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763632793; c=relaxed/simple;
	bh=JQ3dbdJcaslzlpWIv88Ans2DZ8nJsLv01H4PUnHDFC4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lyi5tj1nOCRVJv7MDLbwF/SyVQcvIWxZYh+160eWCza8rMn8FcNkGEKRW3iSvJV62FGB9ArDpZhQRj/5ePR14zhPkVfa5xZTnMer1CBrkrLuKdrUWJWVXYyULl7inth+MMkcoM/HI2QCllADXjgTKM8Nok+uGopU6vFjdbAm8w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W66DEFEN; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-42b32900c8bso379060f8f.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Nov 2025 01:59:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763632790; x=1764237590; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mIODWrR7kj2FgENfGTn8a1wuC0pEHeF2hG1nTUsyQa8=;
        b=W66DEFENV2ozE2i7Y9L2UMB9ryFW1JNAyNhkTkPxh4pr0F1S5R/ELSJgoLyrc0xA5h
         jWVdqDIgBheW4vCFwh082WBcQV5MiPfPoj+qeEsMKjVW8Res7EfJN1XxhLubsF8AKj3m
         HK3hnwqSG4qmSDJV+jCopc6N6pRIVlLGxzLfFZcC1RiNiHwaXKWSMtQnlau0Fzh0gVGY
         nMrGkq2chYgQEZYiYD7JZ9hhPkC/RHWs8MhLcQ6zK7JeSEfXQLbhnC7TtMcnTsevBv34
         InVQleriGIO6N0jqF5cuj80lG/G43umz5tfbKQHP/BcVu2OgfnlzaEZ1OGeuSJM50f+F
         gCPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763632790; x=1764237590;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mIODWrR7kj2FgENfGTn8a1wuC0pEHeF2hG1nTUsyQa8=;
        b=YkCIu1SgLu/gKF5E4OsHGWNWe3OmmujLiXoJMsFybadLcmqxBS+OSRtKsV+3nZIGk+
         OT6Al48fXbQ1/brkv3B6iPAa+3SbJIHNVZgfNd5KTNz637W15E3iesKYD6rbvASxnHJC
         lO6gXaXZAZZ4UJhAqAzwxleFEfOfX2iJdz7I1L1Ph/ok/xaZhk5DHkeNKQHHEIKqsca0
         mI3fjYBao2r0K9JnxKnvmEdP1Zoc9uzLWFXOuCdgtqL8a6kuiYPQ9dtt0C5SPqRO1pvd
         DU6it8sbrK5FHLT1APRNIV1uqRuOKvOEmF8o01JenonN+IG3HN4JU9+Fc+ZDIH5Zjlc7
         sBog==
X-Forwarded-Encrypted: i=1; AJvYcCWDdY6zW2Ln3G6Mj9rE2KpS57poaK40fH/PY8brd2byyie2d4oJzSCvFYOd6AS8Zpgi+zjREko+aAiIhH8x@vger.kernel.org
X-Gm-Message-State: AOJu0YyshxjFDj+p/UvbOLKlS+MG4gj9Aw44+u853IeTyCEL4HlbjeXS
	IFGM38gNk34yM4L6a3oQnamYKni3YN6O2vcGpB+HBbNSuLaHpMk1a+tp
X-Gm-Gg: ASbGnctoZDIEV1WcYFRSZAaGjoRdzDh8h3bKmBnqNiNGai5lkW7Ses+TNy987u8mVIe
	C7lpn6KJLZwHyt/tDjhsmrvdILFHWuZYJkH4bR1xggN8OoSg3yM8cGQeM2tLtKT6V5WwL+9k6LO
	jB98czTwNv/+ZPEOQ5JivDuMW8gksmPv+YHekTF41NP57qwkRW3Y440NbWTpbioZejO262c9hWY
	vEH4GDVn6lCOghTzp8k/O07V5Gy/SDgy4ESsuTiXuntP1ABaTQaPq2s9sll0J9P6o9GdNZBmrBQ
	BrhCHi3GvSuVcODzWWSjHnZL/mrIrWiCLXkGxGi6GE8bhxOYBdzJcxrWHejo+qzbvb4iXC/k6yM
	TDF8J02lrk+FbeZGWPTbjeLBpizqYXg1GU2ojyfVGGkwMbgRazFPH+Q8dpmpw3p76lofLsyCJwK
	AX6NLeufeyX8sfB4MpUxwGptNjyUOBIzQtqgF7avb1QSA1q1JObfWHzMtzQXod5xg=
X-Google-Smtp-Source: AGHT+IG37lZw7UpcsHmGZ/1ewOEV2psrqqY4t9wOw/ImHxPGIdO3yYJVfl/Q35dOCEa9SiO9Kt9qOQ==
X-Received: by 2002:a05:6000:1787:b0:42b:5567:857f with SMTP id ffacd0b85a97d-42cbb2b1d24mr1644470f8f.50.1763632790127;
        Thu, 20 Nov 2025 01:59:50 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7f2e5b6sm4429203f8f.1.2025.11.20.01.59.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 01:59:49 -0800 (PST)
Date: Thu, 20 Nov 2025 09:59:46 +0000
From: David Laight <david.laight.linux@gmail.com>
To: "David Hildenbrand (Red Hat)" <david@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, Axel
 Rasmussen <axelrasmussen@google.com>, Christoph Lameter <cl@gentwo.org>,
 Dennis Zhou <dennis@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Mike Rapoport
 <rppt@kernel.org>, Tejun Heo <tj@kernel.org>, Yuanchu Xie
 <yuanchu@google.com>
Subject: Re: [PATCH 39/44] mm: use min() instead of min_t()
Message-ID: <20251120095946.2da34be9@pumpkin>
In-Reply-To: <7430fd6f-ead2-4ff8-8329-0c0875a39611@kernel.org>
References: <20251119224140.8616-1-david.laight.linux@gmail.com>
	<20251119224140.8616-40-david.laight.linux@gmail.com>
	<7430fd6f-ead2-4ff8-8329-0c0875a39611@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 20 Nov 2025 10:20:41 +0100
"David Hildenbrand (Red Hat)" <david@kernel.org> wrote:

> On 11/19/25 23:41, david.laight.linux@gmail.com wrote:
> > From: David Laight <david.laight.linux@gmail.com>
> > 
> > min_t(unsigned int, a, b) casts an 'unsigned long' to 'unsigned int'.
> > Use min(a, b) instead as it promotes any 'unsigned int' to 'unsigned long'
> > and so cannot discard significant bits.  
> 
> I thought using min() was frowned upon and we were supposed to use 
> min_t() instead to make it clear which type we want to use.

I'm not sure that was ever true.
min_t() is just an accident waiting to happen.
(and I found a few of them, the worst are in sched/fair.c)

Most of the min_t() are there because of the rather overzealous type
check that used to be in min().
But even then it would really be better to explicitly cast one of the
parameters to min(), so min_t(T, a, b) => min(a, (T)b).
Then it becomes rather more obvious that min_t(u8, x->m_u8, expr)
is going mask off the high bits of 'expr'.

> Do I misremember or have things changed?
> 
> Wasn't there a checkpatch warning that states exactly that?

There is one that suggests min_t() - it ought to be nuked.
The real fix is to backtrack the types so there isn't an error.
min_t() ought to be a 'last resort' and a single cast is better.

With the relaxed checks in min() most of the min_t() can just
be replaced by min(), even this is ok:
	int len = fun();
	if (len < 0)
		return;
	count = min(len, sizeof(T));

I did look at the history of min() and min_t().
IIRC some of the networking code had a real function min() with
'unsigned int' arguments.
This was moved to a common header, changed to a #define and had
a type added - so min(T, a, b).
Pretty much immediately that was renamed min_t() and min() added
that accepted any type - but checked the types of 'a' and 'b'
exactly matched.
Code was then changed (over the years) to use min(), but in many
cases the types didn't quite match - so min_t() was used a lot.

I keep spotting new commits that pass too small a type to min_t().
So this is the start of a '5 year' campaign to nuke min_t() (et al).

	David

