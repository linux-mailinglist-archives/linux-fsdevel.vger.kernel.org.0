Return-Path: <linux-fsdevel+bounces-49465-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55E88ABCAD8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 May 2025 00:26:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 455063B390F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 22:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E81321F1302;
	Mon, 19 May 2025 22:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="HIhicLvP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF5221CA10
	for <linux-fsdevel@vger.kernel.org>; Mon, 19 May 2025 22:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747693611; cv=none; b=ST3I4amYyXQvUzQmLc+aLcp+SzwZPbZA3GuyXHZIJH/KXUz6elgEGjLP2LJ6KDlVo6JjQcispfOyv5ofQDbFfrn8Ozo4T3YjDwxeF/6/eXRxcfedbD4+Q3qLj4HZPLyuax7KIRydShKxZ+OER40t4gtN4KKAL2IMQqYbi8aw24Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747693611; c=relaxed/simple;
	bh=lYBzKlMjPQTdw8e0RgRLYHd7mp2bi+NQi68U4mQQ5Q8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jjyz6mTn1f5gfmPSmTZBycEFIlVOU80zsLlojLuMdU8iYCGpuXw1nwkwsKzMhkmQuRYsxLiNbJ7TYoeBAw0+7SIZ9Kyvpmi23BLHyy8cWQ7ZFjsM+yufCw18v9J8ss+qKrN8wLWV5PfvaUQj84fo3H9jscRpCPSocgr5w4fCIm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=HIhicLvP; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ad1d1f57a01so865504766b.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 May 2025 15:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1747693607; x=1748298407; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=04pR4qHK4R2T1tsMAM+3CVANN1pmz971Du0kP0i4hKo=;
        b=HIhicLvPKobXn2rYnOGqj7QkxQCFC8l475dwIuHSKWIg3Gvj4EHGh4kJdzOGVROkdK
         wigAWfIfGnZYDJ+daQPo2jbqeRe8G+r+y7CIV8Ja4DfQz0YSMG7dZLE0oPwgG6DJUGDO
         aayqBT+MigqKjOwbzyIsHcYlOY1pbBj2OSSIU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747693607; x=1748298407;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=04pR4qHK4R2T1tsMAM+3CVANN1pmz971Du0kP0i4hKo=;
        b=kdVPgvCuormW6vMcl74qBAJfNrabWPKj9il26mIZgJt6YOjDDXaalLqftr7bf5SFiS
         V7BSlmloIr2zqBA16GPPZ6fK2G9j6MaUZqfyCIBL3eWOVuN0+FSDOYwl4Z+yfMTQfagF
         C20w7LHBFQZW837WfVaKKsSel9Nr7QL0pkVV1EIESqr+SofGIsLnDru5ZyJr3O2w3Wt5
         8kWGzt6FqOOiw08FZSNKm29IbnCr1fs2YSqCBjz/TmDrfomWKqs0gZ0OZyL0mgsRnRDQ
         BOaZ34KfOSFOdX7iMbe2xfU7uXtDuCmT2f0M6TLyvSvUK8qsJjHARxO3hqau1GcwVG+d
         wyRw==
X-Forwarded-Encrypted: i=1; AJvYcCX1A8v52JwqCJ2dbm7DijnXQ2zqe5KkNNqbWG++Ul6jcvl0IzEm9nMTO9u/58M09rpay+GQ9PydGSpf74RB@vger.kernel.org
X-Gm-Message-State: AOJu0YzsYULxd62lcTWmxnsq6rliusldtWkt8HLR1JOUENmyNlbIZrh+
	LbZsUk9DUV7ch6/jhci3gO7GbHukCy2A0VjS8ZgSNT6qqXc66OSiqxAS6xob7s+z2jkOuF7/PZr
	upfSOW1A=
X-Gm-Gg: ASbGnctf5vzT84cvGkD3t6fpVry3fIvoljhvFBpVv4/H9mfoxps4X6FS4jzOzfHHOHK
	hs8uTxsZiNqydapsSXSvP5LDyGMzzr3lpbZH0BzBxf/sHvLPDCnsBQVOZYg3iCm1ITcH/vL69Bb
	BmCVbL7Yh6pZlpIVPmJ/0jqCB/MH7d2gYrFpLJK580sl8Fn1C/Le8iEzlDfwLATua/VG1CQIw6q
	/r1NRW7frJoROSWB5JK2QBU1UkbfXB0iFMXDoYk6/irGnvWWye8PQMNwBBYEbGOuKtHaWJU/YaI
	W6qTq/xY4KVKcdEyttgx1RpW9oFCSfhSOti/oY4hO/g3Q6G5FT9r38Xveh8Lx8IFYH0oJ448rjO
	JiBuzJZKXLOaIpTA8Id8yNFLx4w==
X-Google-Smtp-Source: AGHT+IE7adIJR6ZHiYRfUa66OnuuR7l6pvfuwR3BDGO438PPBE2xhBwA+fsMW687tTaScTuNGQ04TQ==
X-Received: by 2002:a17:907:1b19:b0:aca:c38d:fef0 with SMTP id a640c23a62f3a-ad52d08120dmr1455897466b.0.1747693606848;
        Mon, 19 May 2025 15:26:46 -0700 (PDT)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad52d272047sm642258766b.72.2025.05.19.15.26.46
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 May 2025 15:26:46 -0700 (PDT)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-601470b6e93so6853492a12.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 May 2025 15:26:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUIzA3CXLNOM7RzJ9WzKOf8Tw7in+GXbu4rCecO5dEZJpteroq9usgb75gKoY3BakBWxsCdoEzn9iilK+W/@vger.kernel.org
X-Received: by 2002:aa7:d342:0:b0:600:e549:3c19 with SMTP id
 4fb4d7f45d1cf-600e5493dfcmr9830161a12.1.1747693605759; Mon, 19 May 2025
 15:26:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250511232732.GC2023217@ZenIV> <87jz6m300v.fsf@email.froward.int.ebiederm.org>
 <20250513035622.GE2023217@ZenIV> <20250515114150.GA3221059@ZenIV>
 <20250515114749.GB3221059@ZenIV> <20250516052139.GA4080802@ZenIV>
 <CAHk-=wi1r1QFu=mfr75VtsCpx3xw_uy5yMZaCz2Cyxg0fQh4hg@mail.gmail.com>
 <20250519213508.GA2023217@ZenIV> <CAHk-=wixv3XKa8hzsy=WQXaXcE4kDLbBkc3vQiW3eoRjStQ+uw@mail.gmail.com>
In-Reply-To: <CAHk-=wixv3XKa8hzsy=WQXaXcE4kDLbBkc3vQiW3eoRjStQ+uw@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 19 May 2025 15:26:29 -0700
X-Gmail-Original-Message-ID: <CAHk-=win8dm1kEFSZEJNPD7MT4W905WWit8=BWmx--6QF1pZDQ@mail.gmail.com>
X-Gm-Features: AX0GCFunTj-Hb6byOiiGITgi6PJJY7K3t0ts2WSPraYzSaPTJ3TiAvJoJj5W21Q
Message-ID: <CAHk-=win8dm1kEFSZEJNPD7MT4W905WWit8=BWmx--6QF1pZDQ@mail.gmail.com>
Subject: Re: [RFC][CFT][PATCH] Rewrite of propagate_umount() (was Re: [BUG]
 propagate_umount() breakage)
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, linux-fsdevel@vger.kernel.org, 
	Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 19 May 2025 at 15:08, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> And I guess passing the list head around wouldn't have helped make
> that flow more obvious, because the removal is through the list head,

     is -> isn't, obviously

           Linus

