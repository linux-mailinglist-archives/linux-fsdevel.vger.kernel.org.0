Return-Path: <linux-fsdevel+bounces-40430-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4442A2352A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2025 21:39:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7F2F3A59DD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2025 20:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C6A21F12FD;
	Thu, 30 Jan 2025 20:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bCNu2G3x"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B0C1A9B40
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jan 2025 20:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738269575; cv=none; b=B2YDyyoI7nJNuNE+YMk77AfNUhlblxWP5FtT7F8xn4D1x9iWhwNS7gQCxpj3y2d7/A0d1upU1pXvVXiG896qV0WoMS9CJXv0fg+qm+D3wfpx85OnheWBwJV9V2aVvSpirJRBEzPc5Tsq4wgRdLFJ4cDHs8XtctW+qOBJANulcyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738269575; c=relaxed/simple;
	bh=Zjc/ukGYviU6e9aVM8L8Zjtty0hNQpOZXKBc9NxwJp0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RRWfg6nN6xRJMZVLTAHufbFi1iq3vxa+Rqq0lfP58u9J4Y0okv8qDw1ix5VzFJ37MlxSr0Jzpllep+F+8vTwPVlY8TOK21bIf40K88DuHuk02K2gB66IdsZbN3MVE79diTytrcW0xlp7bYeZ4LPO3Xt559XyDhHVxj1cP1u3i8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bCNu2G3x; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-aaec61d0f65so90571166b.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jan 2025 12:39:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738269572; x=1738874372; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zjc/ukGYviU6e9aVM8L8Zjtty0hNQpOZXKBc9NxwJp0=;
        b=bCNu2G3xtBTaB9c5N9vtPo/9JNZsYdyMy8UaOKvc1CBds3Z6VWCbtsxYZU5oR5hJRi
         5qhbVMsmSfmECg6DKZrvEyenSQUYhqmC3uzU6UKwtn/U9/+jjSo5Hh2VFwuB0d/Rbcb8
         uX7EbZf3NksmpwfTBTv3Fncda/jRmu6oIRYut7pGXDXdN+EFW8YdqRGPwJtDmSB8CIDw
         bw+c9CBLAZcvDE1QQBwm873t1QEgwtuQ5lU5WZ8LKdCWbty4BND5WFTOiAw04HabVUzA
         bHTgH8Au+WT+sUxbKlVWlFuOcFSVo0ZRcp4vYAn3P9dapSHOHigl94Xq4ewHiZZX8RfH
         v3OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738269572; x=1738874372;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zjc/ukGYviU6e9aVM8L8Zjtty0hNQpOZXKBc9NxwJp0=;
        b=vZbgqylfJtJT5HWIEno1oyrZph58BD5gWomFikoQ0N+OLJx9rx8z30jlV3tiT9DAE7
         Qx5kHNNXS+z+Nk5yL7MS+G5fDMa5wpb7TjGfskFu5IhGHR4PcChdUFfIY20FJOaA0ixv
         enlSEVEVh75YNCvcdne5vH3KOgSogwSNM/HP3f9CD7wDeyJyBQqAJM0Dsv0KMJBoucHE
         35x5E9bg+0xuFyLyk6wyssiGERHjhA3wKUnyfLtZ15/IJIa9OQHZcy8m5683uhaPFHS9
         EGUjDFo/xUmJIb5Hta+/5P89auLdCqBat+Y5dnB8l0HpygaLO+mEsouqvpiRY2lH2Wf9
         USGg==
X-Forwarded-Encrypted: i=1; AJvYcCWe7KElhLCpXM1sisqvAFfFgUI27oGiwKfjLMSGOb6RAFKRSd+Vehk3jqHt1itAms0MXvQep+ocPUU6DC4E@vger.kernel.org
X-Gm-Message-State: AOJu0YyKrwvgnNRYsUqGFn8sMX0vAz/iUNwmFnnUOGAP2jccXsWEl7Df
	sQSY4sopcXYu5RyaEllGnuKcL07s2pfpSHgrU0rLXUEhDG8cHCc+gd4/ozC0efobt8Wq3Ono9d9
	RGsLS7DExSmR/IbbGz32yf/3QxO1qQXiaexNY
X-Gm-Gg: ASbGncvHTEqs9TdOXrIWrD0KbxtEW9Mh+W/HkasbRpkJUn5ffkJ1N2rOnbRe4xzW/ey
	5hugOkSS+DejR/Puobh7Du1EM7MQzxlTX5PlVw8rGCGsi3Jk05VfTaIaJz4oiSki91tgWO3miVW
	PnY7frBOmMSpP9vVsLqmDoHqITMfVRiw==
X-Google-Smtp-Source: AGHT+IGrgFfO/K+h4P6zJOggzHtL/MGdhzkU7jyuReGUYiXkVzMuxOLtpvutFaZEw44utsgnrxP3JQA41Hof3U2VRwU=
X-Received: by 2002:a17:906:f74a:b0:ab6:d688:257c with SMTP id
 a640c23a62f3a-ab6d68826e5mr639571966b.43.1738269571901; Thu, 30 Jan 2025
 12:39:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250130100050.1868208-1-kirill.shutemov@linux.intel.com> <20250130100050.1868208-12-kirill.shutemov@linux.intel.com>
In-Reply-To: <20250130100050.1868208-12-kirill.shutemov@linux.intel.com>
From: Yu Zhao <yuzhao@google.com>
Date: Thu, 30 Jan 2025 13:38:55 -0700
X-Gm-Features: AWEUYZk2YQUyps1dQbKiaYF6w_rV2K1IgcShMby4WAMvmMJrPU_zLRbp4lsvUNA
Message-ID: <CAOUHufa9VWCsVyAdgtdJ-5cgCUkot+tdD9huU1NAAmDSKzi6tQ@mail.gmail.com>
Subject: Re: [PATCHv3 11/11] mm: Rename PG_dropbehind to PG_reclaim
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Jens Axboe <axboe@kernel.dk>, 
	"Jason A. Donenfeld" <Jason@zx2c4.com>, Andi Shyti <andi.shyti@linux.intel.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Christian Brauner <brauner@kernel.org>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Dan Carpenter <dan.carpenter@linaro.org>, 
	David Airlie <airlied@gmail.com>, David Hildenbrand <david@redhat.com>, Hao Ge <gehao@kylinos.cn>, 
	Jani Nikula <jani.nikula@linux.intel.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Josef Bacik <josef@toxicpanda.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, Nhat Pham <nphamcs@gmail.com>, 
	Oscar Salvador <osalvador@suse.de>, Ran Xiaokai <ran.xiaokai@zte.com.cn>, 
	Rodrigo Vivi <rodrigo.vivi@intel.com>, Simona Vetter <simona@ffwll.ch>, 
	Steven Rostedt <rostedt@goodmis.org>, Tvrtko Ursulin <tursulin@ursulin.net>, 
	Vlastimil Babka <vbabka@suse.cz>, Yosry Ahmed <yosryahmed@google.com>, intel-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 30, 2025 at 3:01=E2=80=AFAM Kirill A. Shutemov
<kirill.shutemov@linux.intel.com> wrote:
>
> Now as PG_reclaim is gone, its name can be reclaimed for better
> use :)
>
> Rename PG_dropbehind to PG_reclaim and rename all helpers around it.
>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

Acked-by: Yu Zhao <yuzhao@google.com>

