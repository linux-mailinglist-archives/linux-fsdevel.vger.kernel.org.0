Return-Path: <linux-fsdevel+bounces-40429-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2D7EA23525
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2025 21:37:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46C347A1D4D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2025 20:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0064B1F1311;
	Thu, 30 Jan 2025 20:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v7tWGvBt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE2413D89D
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jan 2025 20:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738269458; cv=none; b=AoE302e8ZV7d1cLznFkQwWXV+oRW02kepHrVZdKi7kTRgy9KAtCVZAm/kZhdJbNi1uorEhppKrbiRWFKZYqUNoqRId3CPzpg8ZMsgNWBgruLAVr8ry3F109TMiFTWRDdeHKLObdbHcDv+DnvNJrZpAdBRqUbR3sTTxuRF44MV6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738269458; c=relaxed/simple;
	bh=xT8Ut8gLz6JZTplLJnZjKEdD7Di9InMwjf2e/4aq99k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TCRdwLpsSIY4ysmAXrmh9SGp+RNk2b268/T8aZ+QfM1EljP7vivc2GQIKwf6nBJZ8qTETDvp3ZrIB98FBbprZjjyk68fBjWrz+qKD8ms8Av94H7o5ZSK5dNxQ5PvVSCyYVaIyI508jD6G1r+BE4G/nbN26R+l6wf0eChKcAKSlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=v7tWGvBt; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5d3d479b1e6so1717974a12.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jan 2025 12:37:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738269453; x=1738874253; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xT8Ut8gLz6JZTplLJnZjKEdD7Di9InMwjf2e/4aq99k=;
        b=v7tWGvBtWDgymFPE9TJ8ePUVMVQNn7yOt1pquGABTZEmIXPVd/SngyRtfl7jC9s90R
         Hwtd8LkajRsTmTK+bkwi8f8OrW+WRBwnJET91aYi9JUaRw5Y1VvhAQifqbtS32N5LkMi
         qvYxpB4kK/PAlp1m8Aru+cnBvytkoSj80SEDE26tga+nuTmrea2W1kiYKaXa3JwgzDx+
         5Tc7vMY6xEkLJByJhXYpSb0fHQi1paGIUiCtSLMQAPwEoqiZ5LNR71q4dJcGUnCMZqWE
         /lI7nQa4Qetv0qJZDVLFibXqX2qogVTvN4k7a5lHaF7VuOMwNj/92t/xwx8FQIy36FkF
         NJmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738269453; x=1738874253;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xT8Ut8gLz6JZTplLJnZjKEdD7Di9InMwjf2e/4aq99k=;
        b=k0yMz9KZx8If5jMl3WRdtQzInDbBERp1ErOLgyvpJb9CTAKjVYDOww+BgdcVupevxe
         fk7FSO94XWIo47uuMkaXcSdYNAR1MVdrrYZjOGZLpk9fjONXVV/MA4W9GoekCxKOKaV6
         K6hCfCX7UvftBb80pH44eZa1D6H4qi6lGSrV3+9YYV23uuivQwfhu3Zsk41C6aWclwss
         iPHs7Hw6bk1sKNVt3IblkXuI/THC+E27QoytQayBKdiGDLrW85JZzyQe9jyBkGuY5vSf
         IFVCK9h9scmRd6cBT2CN7Z5JYgfkaoAZBj4xrlZuexRxzfAwefVs32yBu5w+DDX/9oS7
         avnA==
X-Forwarded-Encrypted: i=1; AJvYcCXLH5RsYu1ssOxeQWMV4ByUiVsV7o4yM49MheD1sKb8IAhduFsuDwQGV9qktzcJhbeJpzKl6+/yBCZ4BXTm@vger.kernel.org
X-Gm-Message-State: AOJu0Yzm9TUEpC3Iffo1TtSTWZvrcjlVnuOOFzgaD2nSLlc52xTeo+Q4
	eRn/a0zOc1iHhG1r00VgQBM5CphN5wmztDtq1vrFyOI1ZaiFWaBux6Wmu1TdCRPYWiOpgPqprOF
	ENORerjsQXrLlV6ACq/bUp4bo7UpoZs+JzgS0
X-Gm-Gg: ASbGnctgRcXScIrjKXuD677R3C9te7DtJTNagkKlfdXZVf9wSgAfykHvydEuc0TdOb4
	L+VMrGOp6w4tDOzyG5kMLe08+4jnZxXKEOpjpJlvccxv777prnh9psu0VCfTqkbeDTr3QTFQMAb
	7n/MNdL6jIpxbzFI2I/umiPKYpe+mREA==
X-Google-Smtp-Source: AGHT+IHgOIJu66b5+FkCjUTqLe+kFJ5pnzkiI2EWbnmTxxfuYeBlU3TGfepPLf9b4v1IsOlZVSVianh0S1Lnh6AsAs4=
X-Received: by 2002:a05:6402:4311:b0:5db:f5e9:6760 with SMTP id
 4fb4d7f45d1cf-5dc5efa8bcdmr18615952a12.2.1738269453403; Thu, 30 Jan 2025
 12:37:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250130100050.1868208-1-kirill.shutemov@linux.intel.com> <20250130100050.1868208-2-kirill.shutemov@linux.intel.com>
In-Reply-To: <20250130100050.1868208-2-kirill.shutemov@linux.intel.com>
From: Yu Zhao <yuzhao@google.com>
Date: Thu, 30 Jan 2025 13:36:57 -0700
X-Gm-Features: AWEUYZk-T3PmFiMQXizTQSxtfw262HuFGqWt0YvgioLZEIzF4uEgK1GJyl43NpI
Message-ID: <CAOUHufaap0fbU5LGhvm66Dh7jiBjsJiKPmLjVje=BkoB3C8ToQ@mail.gmail.com>
Subject: Re: [PATCHv3 01/11] mm/migrate: Transfer PG_dropbehind to the new folio
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
> Do not lose the flag on page migration.
>
> Ideally, these folios should be freed instead of migration. But it
> requires to find right spot do this and proper testing.
>
> Transfer the flag for now.
>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

Acked-by: Yu Zhao <yuzhao@google.com>

