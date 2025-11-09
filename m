Return-Path: <linux-fsdevel+bounces-67625-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9DFEC4495D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 09 Nov 2025 23:42:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84871188A742
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Nov 2025 22:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C9CC26CE2B;
	Sun,  9 Nov 2025 22:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="MzX4VfDs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73BE21B9C5
	for <linux-fsdevel@vger.kernel.org>; Sun,  9 Nov 2025 22:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762728139; cv=none; b=puDkn9JcRBjFfmCJuPjUjiAiDo2a52tsEVly3Xlpk25fpuSZsP5reJhCluwpZIk3uq2cy+fTBKFniGGG0j5m9bxpmlem2SfwxSU3BXyvKM27eb8fc5b3eTSwecDhGlg9a5MAkOk6sSlV/i9R4/uu2eGUy0tmSk+4NEno0TnR0E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762728139; c=relaxed/simple;
	bh=qIjdEUO4UIxlK8RXL91T93B918tKVIx5tlbLeaqNZTs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LG9/UZk0GctDF1mnK4Q5jVskT+4pBUc0Gfy/GvRKw9C3ZlILO7vWoF9Our39god68bUUB8SDiE+Oi6AwW/mqzd2BiVXaNhpH0uGeHORw5p+4/GlRWaNZ9hn9hQBXhgX+x4EBkuCKnHu4k53pRRwgkRdFrz1CUZciB0yIFV+eYfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=MzX4VfDs; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b7291af7190so359271766b.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 09 Nov 2025 14:42:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1762728136; x=1763332936; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7S1tPI9KX5FxZpbFA6GTKD9y2rwBJh6/sJGdbAgzg24=;
        b=MzX4VfDsnyjNO0R0WafNm74z/mAMlXZi2wgGt/ByHmFKH03MtFD0c1Ic1GShzg7/lE
         Q3xQgiZ4GiotpvNqKQOb6P9JzqQrehpMi8twO20QcQ+j1R4ZD2SDs5hG+y+WB1/GJn/E
         k9taFObJ48GV+2HskA2OjteraGRrbHHldHY4s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762728136; x=1763332936;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7S1tPI9KX5FxZpbFA6GTKD9y2rwBJh6/sJGdbAgzg24=;
        b=tLXLtqVJLg6hNWnF7+vg9aXfrjmpFjr6V69gBwlGNzyITxf8zB0wicsP9KVWiG8tKh
         v4BU8I+mzYl7Xuv3GonNgTVm56VPN9AWP0/Mmin+Onn/8p5a1+gSLtkOM2qSXUoDAtoE
         uzWc03bmVq1bWqkpANz51UxfhXWeudktTDpvRPlUZo9G6ZPrXTzH7fEDBU7/hUJYg3ka
         OyWgvNDMrEKj6Nhaftk8yyCmQiST6w72Iuiq2ifHVgrQW94DWg4tJAwEV9v6//qCvTQY
         +X1ymSvpJI3zogdB9715rwl4koEw3w41TzHlSU+UWAanlkfdBfJcknutDeH4OYCWruQs
         rE6A==
X-Forwarded-Encrypted: i=1; AJvYcCXVNcMadSB8BXz2JEjSpieXeZI76vVho66q3It7WqkpJP+GNHSXuVHNpb7xG6xGLhwnSXvUMjV3gBRdMQ4b@vger.kernel.org
X-Gm-Message-State: AOJu0YxpuXaIP0OJ2rlC5oCJR3vNXlUKxUtXyIV/Vs8gpWi6V0K/Vq6c
	9j+TBtCIf/W6OKzNtU3eRXF6d3hqNt+oKyT2DtU1tQ/EryvvAYQkCiLgnnRa6kF8AdMpwz9eQif
	Q73GNUHA=
X-Gm-Gg: ASbGnctiXeItvaabAzVTjaIUPx8kAkEZ7X6+/BIPSETc5EHGc6C0dz0+7AmKm+xxkOV
	7Kja0nDKv4PzPRAc4EThkpBgFgJbSEW1QvrngS6ld5uVKVexek8wTgnwYU27WdQqqc+EoLZ62jD
	cJvKSegCVkdKYlScBN5D3R9x6G7WyAtyiMCC+Nw9miGukSvTJGkt8NBU+Wi59rEw0/Dg+GVM7nA
	xu9Zj/SeYEsP6GXZ7WiMOXDm3hGEynu9h9AfdeUsh0uOqmNgHbBeoU178dGpp5ePnC+q1d1tm2Q
	aQbOHXVB/mxkJPzLly5wHoU4V84hSvKCR3mzvKwyFExn/eS+aPfRzStajTpRIMsBD1VHwMWoGVq
	qK3CZWaL75gHBMxnLPf1qXeTMJTJM5NKXyZHUQyuDnG21tnBfPOk3lFBA55dHbuuTngGuDqLf6J
	d3Y3JXA8QT5K1/gjrGAWp60jeAnQtAFnfB4bpVqsaucwni1GHhAQ==
X-Google-Smtp-Source: AGHT+IGSAMCL9gHUKqFuj90vrG8bv9F+QyV3f9xVnwnPEbOj49A/4URW6C1eAZBXpnLqiAetvg5ACA==
X-Received: by 2002:a17:907:1c03:b0:b72:9c81:48ab with SMTP id a640c23a62f3a-b72e050415bmr571890866b.59.1762728135890;
        Sun, 09 Nov 2025 14:42:15 -0800 (PST)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com. [209.85.218.52])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bf97e563sm916385966b.41.2025.11.09.14.42.14
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Nov 2025 14:42:14 -0800 (PST)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b710601e659so382871966b.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 09 Nov 2025 14:42:14 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW9BQkCTPPz29Gr7pJzHSxcJjOzbfP3YTDBymDKFbg29M5+JhIbHtiLmtRkx+RrjNetySZaScgV4I0lao4m@vger.kernel.org
X-Received: by 2002:a17:907:7246:b0:b72:5e29:5084 with SMTP id
 a640c23a62f3a-b72e02729dfmr660861066b.4.1762728134438; Sun, 09 Nov 2025
 14:42:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251109063745.2089578-1-viro@zeniv.linux.org.uk>
 <20251109063745.2089578-11-viro@zeniv.linux.org.uk> <CAHk-=wgXvEK66gjkKfUxZ+G8n50Ms65MM6Sa9Vj9cTFg7_WAkA@mail.gmail.com>
 <CAGudoHHoSVRct8_BGwax37sadci-vwx_C=nuyCGoPn4SCAEagA@mail.gmail.com>
 <CAHk-=wiaGQUU5wPmmbsccUJ4zRdtfi_7YXdnZ-ig3WyPRE_wnw@mail.gmail.com>
 <CAGudoHGCkDXsFnc30k10w-thxNZ5c0B9j26kOWsCXkOV8ueeEA@mail.gmail.com>
 <CAHk-=whxKKnh=rtO9sq0uUL76YGLB3YTb98DVBub_84_nO6txA@mail.gmail.com> <CAGudoHHA_dDXMZFh1=U=AjPsqK9PRUGq3fQ_GjOdebUBK-sn3g@mail.gmail.com>
In-Reply-To: <CAGudoHHA_dDXMZFh1=U=AjPsqK9PRUGq3fQ_GjOdebUBK-sn3g@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 9 Nov 2025 14:41:58 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj5GSLaqf+rVE6u-4-rzdUK+OM_oUnPLQoqVY4J_F0uRw@mail.gmail.com>
X-Gm-Features: AWmQ_bk5CNTgXVq9Wj4DrVDvXfYphjsw9So7wK98LkhJD7EILYp-AjhoG9v3pfw
Message-ID: <CAHk-=wj5GSLaqf+rVE6u-4-rzdUK+OM_oUnPLQoqVY4J_F0uRw@mail.gmail.com>
Subject: Re: [RFC][PATCH 10/13] get rid of audit_reusename()
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, 
	brauner@kernel.org, jack@suse.cz, paul@paul-moore.com, axboe@kernel.dk, 
	audit@vger.kernel.org, io-uring@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 9 Nov 2025 at 14:33, Mateusz Guzik <mjguzik@gmail.com> wrote:
>
> The programs which pass in these "too long" names just keep doing it,

Sure. So what?

We optimize for the common case.

Sure, there's an extra SMAP sequence for people using longer names,
but while those SMAP things are costly compared to individual
instructions, they aren't costly in the *big* picture.

They are a pipeline stall, not some kind of horrendous thing.

It would be *more* expensive to try to keep statistics than it is to
just say "long pathnames are more expensive than short ones".

                Linus

