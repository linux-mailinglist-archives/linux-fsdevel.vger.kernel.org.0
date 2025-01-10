Return-Path: <linux-fsdevel+bounces-38798-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21E95A085C3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 04:06:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9918188D9A0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 03:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 259701E3DDB;
	Fri, 10 Jan 2025 03:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="JB8HSWR2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A6881A4F1F
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Jan 2025 03:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736478383; cv=none; b=MjQD7ykwv9HdCWPDAgHq1V6qNx1gwbb3DRbyA2aMrhVZjXz1AR1eL2EK7tEpx4E2Nh6ayoTBKP+0QdA28yceadi18BKeNQiN1Fmzyrb10Ba+b5tnP0JUB9lZfnuzvj/jyHd7IAM24ggbxUqUzH8uyGdSQSzn6mXkM1p84KiaUkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736478383; c=relaxed/simple;
	bh=eO9qA3/8ifU3K1qAWG9+/jWM0J19EBHyfEdTCwZPx8g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SQ13Dfsv8xY7omA+YxwMxn+Wq4ks99C3CHiRv16jGPo/p6PyeruwDUcGDggmAXuFRdFOCrd0oy79gVT8gccr3L3h6j/9Ezmr6zpPlUWwS1RmVvMFqFFq5WdmwwFI5A9jW88ivkpwwF5WTBTkfVDkkgJt8p1ytEQeYbnvnq5lppg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=JB8HSWR2; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5d3ecae02beso2059923a12.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Jan 2025 19:06:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1736478380; x=1737083180; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NT3GMHnGMUPgyBvIrXX2eIZQS9LIQ7g/foVqlCeiI5w=;
        b=JB8HSWR2baufp/g1ombS5eN2Ro74klSpVUiFXpT43/5/opWtW5QBQzcGlhZinIciOU
         ScZ4dKp8YzqJzUxMxB5trllUdwydJEsL3mkEs2lmh64LfAvGJ0cmn9e9AiMoLdbPUN+h
         6YiSTBE7eCGVZzAgScd/RgL2IOWDZouB3/VaE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736478380; x=1737083180;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NT3GMHnGMUPgyBvIrXX2eIZQS9LIQ7g/foVqlCeiI5w=;
        b=Veg3zU22gJ7roTwuLsph3/dtMqopPUmQYw9bm6aynujTTaAjO3Up6s2RLVCyGVxJ76
         TmrRYoEF6nYloCuc9rNur/bMl90UqOjAVUtDEITYTraZlXzP9V9sSgFIfWOt3WRjceT+
         QL/PJJ5fwhXgVvdd0NiGk9+7Z99dtG4DNypeH9eqI9zGNEJ3gfuiM3F2wUOExoF6pv8N
         VjoRQF/TTSZnCvrPq44jARST463p40biuYD2GM4HC/vHbklAlEZvcjfd9tK9IstUiTuC
         fWtY36GUgV1Ptyq4Yz3Lutr+JzzodpyhyKvey25TbwxGBB2SgT1Fk8Yp/XT2dDV39A/W
         TwUg==
X-Gm-Message-State: AOJu0YzdTRPmsDz9Ja4puJ70WjfYUjxXvvHYtglatGbBZsJNa8nq9bLK
	lE5YU21bX8F65beWXUrnWtMJvmQOYsrFoPLvdfZAF7kCXXhsR89uhHBze42kaIrbs3aMDw+0m02
	ALdZtYA==
X-Gm-Gg: ASbGncsEOC+6JfmEhkQuH7ogSvgxYBwALUDrMlb9ZTBXVdKvSFJDGC1KFlpgcOGVwEU
	aon9RtrOENDtSz1OC5CEMZYi79stWDi8pyAbgUPopf5ep5IHgOXeFXCM+BI7HpFBpj9rqzAH+CM
	EK2r4DMQEqmlso82L/GswxAjxtJIUEdtqtABISgytVAB4Yyh7hU1KjK51cHHMwhswEf//hskdMM
	LfW0g6rBKYj2h/aVSbRGJt/pY2AYP2+Dw2GAXD65rk4K82zuCL5OpRNj0eh/8TCCi9qdO/oFGjj
	D7bfSezbqHsde7A+cokzLMb7p6wMfis=
X-Google-Smtp-Source: AGHT+IHd124WTBzdmX5kOUsqlJa/UQjngQtALYf9wLx5jY9XrKE1/ezpkvNKjAx9aRzVqExYgC5kSA==
X-Received: by 2002:a05:6402:2548:b0:5d2:7456:9812 with SMTP id 4fb4d7f45d1cf-5d972e4e53fmr8275428a12.22.1736478379668;
        Thu, 09 Jan 2025 19:06:19 -0800 (PST)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com. [209.85.218.48])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d9903c355fsm1215603a12.49.2025.01.09.19.06.17
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jan 2025 19:06:18 -0800 (PST)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-aaee2c5ee6eso268635766b.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Jan 2025 19:06:17 -0800 (PST)
X-Received: by 2002:a17:906:f58c:b0:aab:740f:e467 with SMTP id
 a640c23a62f3a-ab2ab67061amr690971166b.8.1736478377190; Thu, 09 Jan 2025
 19:06:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250110023854.GS1977892@ZenIV> <20250110024303.4157645-1-viro@zeniv.linux.org.uk>
 <20250110024303.4157645-19-viro@zeniv.linux.org.uk>
In-Reply-To: <20250110024303.4157645-19-viro@zeniv.linux.org.uk>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 9 Jan 2025 19:06:01 -0800
X-Gmail-Original-Message-ID: <CAHk-=whbsqyPw2t=OaCgiNKSSDs48hXm7fdGnTbDqTg7KTY-JQ@mail.gmail.com>
X-Gm-Features: AbW1kvYZQhGLGE_BMmhRgYKnvI869LDYbaAYYJtKtzXM8cY35G-c_oMO0L1sNfg
Message-ID: <CAHk-=whbsqyPw2t=OaCgiNKSSDs48hXm7fdGnTbDqTg7KTY-JQ@mail.gmail.com>
Subject: Re: [PATCH 19/20] orangefs_d_revalidate(): use stable parent inode
 and name passed by caller
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, agruenba@redhat.com, amir73il@gmail.com, 
	brauner@kernel.org, ceph-devel@vger.kernel.org, dhowells@redhat.com, 
	hubcap@omnibond.com, jack@suse.cz, krisman@kernel.org, 
	linux-nfs@vger.kernel.org, miklos@szeredi.hu
Content-Type: text/plain; charset="UTF-8"

On Thu, 9 Jan 2025 at 18:45, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> ->d_name use is a UAF.

.. let's change "is a UAF" to "can be a potential UAF" in that sentence, ok?

The way you phrase it, it sounds like it's an acute problem, rather
than a "nobody has ever seen it in practice, but in theory with just
the right patterns and memory pressure".

Anyway, apart from this (and similar wording in one or two others,
iirc) ack on all the patches up until the last one. I'll write a
separate note for that one.

          Linus

