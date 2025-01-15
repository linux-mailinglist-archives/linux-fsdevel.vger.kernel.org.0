Return-Path: <linux-fsdevel+bounces-39333-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE185A12D00
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 21:52:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB84A165D44
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 20:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2573E1DA62E;
	Wed, 15 Jan 2025 20:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Rl0PiRgm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8121DA103
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Jan 2025 20:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736974326; cv=none; b=Wvc33rL3UJlde+2q6bRVnsThem05KqWqCMwtbvFJSUqxHBR+8znnhhtNLF4k76CvSbBbiuAThftPDfXc0uP4YBcDVPBuJzsDD37VP4vU3W214enLE+ct4nA4bfS8cjMnCB4KdL4yrhL6wFGpMiX2cVVo7d37wWyDlsxq3wI7+7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736974326; c=relaxed/simple;
	bh=wpDHiR0bXsDBwMbTlH1GqxYsn52KOd85vJTdbko6Ftk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bl3wMJ7bkF2xDjPVhwRwf0S5nNNjdja0ktH1njcm8Hcb5PVC/954vSYVPiSrV/hcig62RVJycrwEAuCtNArSywXw6p9lLan8gy9Dqccr3RkfuVLM8Ip8T8mq75r5oNid6Ysx1u4/fmpcmiFTR9FeQw9MayNT7WS94RpQWPKfCkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Rl0PiRgm; arc=none smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-4aff620b232so38531137.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Jan 2025 12:52:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736974324; x=1737579124; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wpDHiR0bXsDBwMbTlH1GqxYsn52KOd85vJTdbko6Ftk=;
        b=Rl0PiRgmJ2aa9WknDv1tB9zUSs5cTfTRokme8z9m2ePJjTN+yYWyKWpqyISrZTydEC
         Sc4iz1b1MIJg34/L/s3LYPzyJLSewZ3d28GyB5/xjh+p3yvFj169qBDwwVskHk7qRuSF
         jjkJx9YzZNVJssWH1palOuwn5MXZ5EAJPfRH6LEy1RjRl+B9EeKJJ4jPjzE/H5yDAZP4
         yFosU9zdCIBuRTUVmh9DPjUgOsADN+lzw9zIr/LufrbnM/qXRpWytU261LGkwD/MgCO/
         A6LNjjD95o5cPfRKo5KCvwejW+YJ8MfdVbRToZQId/i+TZD57jSpY5lC6E/36SqpXjcJ
         CNow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736974324; x=1737579124;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wpDHiR0bXsDBwMbTlH1GqxYsn52KOd85vJTdbko6Ftk=;
        b=N7Ldg5RzyOaagFtjLwhTBLlVUAoUNej154hPNC/JgCpLVMw0kerA67lEhZ37DZ4T7H
         ZGkzMdP11HD5qvkTHSSqXciNp+wQS9l98Ln7X4Kjr+7z2fxaT/QASCAI+he+tbxtqRP0
         gDenNn+AQA2r2A9E0JpIw7Rn9eywIeYOt4HRuDo8hPa7HCU99tbUtnssrDtFnb+PnuQI
         h5lFhuM/TtSj+8+Yw1zHCCNg1c49GahfUBdky7tgGxML8uzTKiuhHcJrTMJChdYA0XDl
         jUI/yGdsRR6S/Swq6+ji8ogygPX/oXHgZbC9TVEeCuBZmMbPlSDPGnW96tzeBZfo1wQO
         CA9g==
X-Forwarded-Encrypted: i=1; AJvYcCWNP/AGHuIJLvjJHQCrtw3/myLh1c9Dt8jhYZMZ2hKnwOzZmEew7yb+6TTsEgpyF5jG74ex5kgfUjVHvFNT@vger.kernel.org
X-Gm-Message-State: AOJu0Yze0bFhBZFCKJR7LBKzi4vVvZu+/TZcTkDfl//hjl//2eVeHKM8
	bDQMQ95vqM0J98k+gIMp8/nub6K7w84gw5CCrhPkMO34RY2QlP0zprxpEleEVGUDLxW/oPjVbpk
	g936k6ke9Jsnu/ucekOwdYEux2UjlKD8Z1KAA
X-Gm-Gg: ASbGncsZwnH2DcfdY4lvU6wLtcaMGKQ7kuyAwOv/tJVKLBo6tDNHrwmAzaaXC0TYKrd
	SkBQ1OF5HfUn+kTHTDFSESsoiAvF9D1Sg4lU+BsHm5FueQv8vew2daqCs4iRomXBUTIE6
X-Google-Smtp-Source: AGHT+IHGJFSTuM3b37+opctt2tHn7VfsuBf4+beVaoaeJuq2++z1RLzVhsDuXLrd9Ee3ASMK9Iz4XTd2JqH50R6dmnc=
X-Received: by 2002:a05:6102:b06:b0:4af:adf8:523f with SMTP id
 ada2fe7eead31-4b3d0f97294mr22811598137.9.1736974323734; Wed, 15 Jan 2025
 12:52:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250115093135.3288234-1-kirill.shutemov@linux.intel.com> <20250115093135.3288234-10-kirill.shutemov@linux.intel.com>
In-Reply-To: <20250115093135.3288234-10-kirill.shutemov@linux.intel.com>
From: Yu Zhao <yuzhao@google.com>
Date: Wed, 15 Jan 2025 13:51:27 -0700
X-Gm-Features: AbW1kvYv76oC6MvIVQyrimg9-wYM-36QWhw54pvoHz-UApVxWVH0m4ZuWq7_GXQ
Message-ID: <CAOUHufbet0=S=9e06jMeoSPef3GzoFm2V-k_NJYbdq2yJe6LRA@mail.gmail.com>
Subject: Re: [PATCHv2 09/11] mm: Remove PG_reclaim
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

On Wed, Jan 15, 2025 at 2:32=E2=80=AFAM Kirill A. Shutemov
<kirill.shutemov@linux.intel.com> wrote:
>
> Nobody sets the flag anymore.
>
> Remove the PG_reclaim, making PG_readhead exclusive user of the page
> flag bit.
>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

Acked-by: Yu Zhao <yuzhao@google.com>

