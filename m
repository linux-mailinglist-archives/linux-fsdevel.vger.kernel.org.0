Return-Path: <linux-fsdevel+bounces-40428-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3054A23521
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2025 21:35:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 550EE18880B5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2025 20:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4FEC1F1305;
	Thu, 30 Jan 2025 20:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C0SDAGsb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76271922F8
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jan 2025 20:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738269305; cv=none; b=UDCXWd8xKQu3vLr3MIE+Mtzb11c4fPRbf8/n56B2hZxYIjNJMTHTuSAivbj17OmgmOb4+yuJf6hBoGxWgyRhjNJs30S8CtoqmYGGb5Zq2ZSY4VJ05qkn8ORu7REFBZyQDZtRKBbJ1IVUfi1UlMfbMljZA/1SHXhEBtmYC+LD880=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738269305; c=relaxed/simple;
	bh=i90LZEJP39KZzuaancmUFtDGdMy9w3zyTcWopQWmg60=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RRqLDFpZRsIJfPN5DJ8wFxyKPfKp3t3OqsKTAYW7YAkBNBF/kYV5AQumUkjbC2nEB+QtAwLAXSE2Qv48ZJ8gBZGXWfiIE2I5n+D0hONGLy1wBm93HQPPa0fIZl/o6FVvlQOk5bcSea8xc6Fvyo2+rLsgm424a+bsyrBjMzMPvRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=C0SDAGsb; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ab6da1bb1a8so89110866b.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jan 2025 12:35:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738269301; x=1738874101; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i90LZEJP39KZzuaancmUFtDGdMy9w3zyTcWopQWmg60=;
        b=C0SDAGsb6aoxiIDl26VA28h6nEEWfzLSputwGsqgRGp/0q5KH4/B0nVzCAlLlQ45kA
         mN27ySAI//VFOz0+FNnTkUwbQNNdOLZIO6f+58MDqB9qvURN4cxEQp2//QNJaPcdosWn
         Oyqt3gMx+3wQRAy6cyLn5M3n8YAYPO3wycteGkxICxwACC+EIEBdpHR1x83ZE4mO0BCM
         nDKq7N8vxhABhZTuLruzsQZSlTOtuMhffpkL7orZXpr+0Q2FWb8vs8M6uQPkI4yLzfuC
         YrnebunTh0M+I3HUOy8VP31rUceAu8O1dyrmzNa8T/HrvgJT5IZ+pgQZrrrPT9y9Z2zU
         xQZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738269301; x=1738874101;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i90LZEJP39KZzuaancmUFtDGdMy9w3zyTcWopQWmg60=;
        b=AU2e4lsWoxaGm/OFUcp3+r8Dz2k+Ij+5P3X071D19nkmJnr4i1YN3r0O8QWixnhkwf
         uZsUiFb8PqYLQmNHYsgPT3WJzWDnGaYI/EUsq5DB4HtPdgczR2YuTQS3UBY/qoZbJI6Y
         kZo+sDCvP8QmPU1GhbL8HTmDPAXELZ8DasJQOmVfB00ux3ErpJbfd7+M1DN8R3f+Wjko
         5zzVAO/0p8V+WnuK+6SVEzi2oVNdErSd5g7d+ccK0q2kCqFCnrbz3xF3zrKakKn6yeda
         oKzOTMfsqqbuf942zuJyRV0q9vwjdhpeRoZgb8K1TCflUkjI0mzY1Bft6Zmph0zY44Cj
         OzyA==
X-Forwarded-Encrypted: i=1; AJvYcCW6bpXX6ttkDcy+vGVnCqmyPzWxH9DBAtta9ogypuShV43dQhQ+bddH38CCb81prcs4D4WIVttM7L9UtmlF@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7AnjsYiG86vLhnq86i3ULT2uSw3oOIx7tnn5alaAAACazsquC
	R1/t1Vmxoz2m+yovpZWhlGGbz4jk2c5WG6EyL1EJKl9p3yxGLHE1MQIzRihUdIrOcY9uaLOQx7x
	LELErTf1G7L7hcLIRGua8jBhYbklRiXJ2dF8q
X-Gm-Gg: ASbGnctoRV90Zje0o0zNXx6tuhzesCMZOgM5u/G5LkvpY6gYNsAnMixW4OMUPc+ZfPV
	DsBgIqARDhqnO5XsvE2WzTA4J/bENXBU0xY/pFMy/2E4sCbwO3UtrkpTANomH3FtCV5NmBRrrTT
	oFuoVAGHkFddQfxnbZg+Gf20q9FcclXA==
X-Google-Smtp-Source: AGHT+IGECMPAgyniOqYNB21R66I8EdMyOHzZpuuSW7CxtAKNGfo7YHvttie355d+QCVHN1qEbYdE+9qUUvFsylnBIlM=
X-Received: by 2002:a17:907:1c0e:b0:aab:8ca7:43df with SMTP id
 a640c23a62f3a-ab6cfe11fa5mr941990066b.39.1738269300801; Thu, 30 Jan 2025
 12:35:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250130100050.1868208-1-kirill.shutemov@linux.intel.com> <20250130100050.1868208-6-kirill.shutemov@linux.intel.com>
In-Reply-To: <20250130100050.1868208-6-kirill.shutemov@linux.intel.com>
From: Yu Zhao <yuzhao@google.com>
Date: Thu, 30 Jan 2025 13:34:24 -0700
X-Gm-Features: AWEUYZl3-5-D2vyBu6SH4C2leVIlg1PIhkFjDOkk3Xxy6Plb6I0iqOiSPQjOIdU
Message-ID: <CAOUHufbZAp9jJb7AA_LF2sS9TbN-T4ssSrp2GbqWSAbf5rUCVg@mail.gmail.com>
Subject: Re: [PATCHv3 05/11] mm/truncate: Use folio_set_dropbehind() instead
 of deactivate_file_folio()
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
> The recently introduced PG_dropbehind allows for freeing folios
> immediately after writeback. Unlike PG_reclaim, it does not need vmscan
> to be involved to get the folio freed.
>
> The new flag allows to replace whole deactivate_file_folio() machinery
> with simple folio_set_dropbehind().
>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

Acked-by: Yu Zhao <yuzhao@google.com>

