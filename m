Return-Path: <linux-fsdevel+bounces-38863-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52BBEA08F94
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 12:37:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7559D3A5D88
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 11:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4965320B80A;
	Fri, 10 Jan 2025 11:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MJmzoecL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18AEA205AB1
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Jan 2025 11:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736509039; cv=none; b=VuJVKCY+Pi7g+Mqrp2bmH1BSVvTpsDudP96B2jQm4ZxVQA98l1TMFsql9ROQdzBFcWlSD87zlYiRauOwKksI778ecqxu7drGAtbjM7KQnY6oPvAYw4ihebE5EnHQr8Sw+I9qGchlrE0IdzlVZoUTuxG605HLdqXz5RBlO+tx0uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736509039; c=relaxed/simple;
	bh=7zmvdbFWSKbkAV4KyjZZv86GYrGfYPkJHSF3xMZZcb4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nv8eSS+KbNwOF52LoW7Oh66kWWkPsHI+jF+USVgA2f2v9s4l90M8fLliWOx4gpm9DvG2cHf1zZqb01wsta70uDpPsFuVXIw7fbk/HHA/cRuSLKHJ6M9ip5bQPdmn3dMpcJ4Sh0OZiBsAP/hjxfPgzOBMThX5gDJmb3F2qweqAcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MJmzoecL; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-38a88ba968aso1756872f8f.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Jan 2025 03:37:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736509035; x=1737113835; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7zmvdbFWSKbkAV4KyjZZv86GYrGfYPkJHSF3xMZZcb4=;
        b=MJmzoecLUdC2br+CmUw5U/rdCaFGXDaIzxCSb8KUDc2ufTwh6wC6NDRE6fAuEtzOoJ
         le1vjeq+gnbIyTPXnVXFeTZg6nv1XLwFZB3MOM4/hg5F5kL+QMF8K/x7LDu6kabrmGgL
         NvpC2pU2YVy5McGdQGGVcufcp8oDvs5WNIXx4LIzIWmNxiAZE7qJfeLenRUUFWW33p0P
         oVYEYurLrwGI8MdG4GUV5uttdLwNTy1pJdGgEM0eTlHH2DDZQClkdM6drla/EnO43OEA
         BbYFGIFPXooa8YXKEIdFo2AKneAI0SCLqenWN0lFak7nD4DSXh0R6MrUiV4bPHsn/E4N
         JHzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736509035; x=1737113835;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7zmvdbFWSKbkAV4KyjZZv86GYrGfYPkJHSF3xMZZcb4=;
        b=km0u/A19u0OosuQ1O8iqr2Gn1kqg/qp6UJMAWMeuzx/9+F7+v80URZtv22xQ1zifRk
         /a5Ggczb5Q56qKzltQPboLnBJGAUslpfZI8iSdnTcX6k233dxRsRGDYMK0EigX0zyNrA
         fWOa/KH6feeyku/HpRiQXNlCT9VZ9qzJX+LsjrwwphDfqji6usVFDhayRQyW5Nedg77A
         6Qal2IeEriwVOtXcAQ4EM7b95w8TtBAO0CFBndFojD00QJGXobnkorTHctnvivtexUnm
         Yjc/3abQ7tLQtvtY89VT5jt39k53RQ0SEUWR9v/Fxtz4uksiCK5LQhhaR3FOe0C2tlgq
         ur0Q==
X-Forwarded-Encrypted: i=1; AJvYcCU1y5aLZGXmrphabq4o5Gi8th8k72DEUNCkgF8K9uJS+3CETD40cAyNuW4E/txeMGunKdax96rEq1AsQxYp@vger.kernel.org
X-Gm-Message-State: AOJu0Yxa705Iwxj0PloWrcWXCgWvb/oFTnwIIUiCSOzliQHC/ApREXZi
	Pt0z3IJog+YYZap9g1Kla0+HS2/vb60pSPZ0/hTwx0lCxZ1jj0rbjnHeIFqF8ti4HurXJZcDPB/
	ZSEsdiNweXoMli11bVoIVXsUGFuKv5jbbUHUm
X-Gm-Gg: ASbGncs10XGj3s78BH0GLTgBjl1vgo2pX77PESkuuXevSruzM1vowy5a09sEtyoPBcv
	XRYI10ygICG0eO8gTEA/hdI1ZQdEfdLYruyPjRbrcCwmmcRwMIm6Hxo5WFt/XObk5
X-Google-Smtp-Source: AGHT+IHTjv7ZEaDdnZKccljFWwP2cqfKG/YwK1Bus+BafuIS4nyzS6/p2+0zJfumRICahytHtsKlLLgGE1/LM/YxhoU=
X-Received: by 2002:adf:9799:0:b0:38a:888c:7df0 with SMTP id
 ffacd0b85a97d-38a888c8017mr6861676f8f.1.1736509035458; Fri, 10 Jan 2025
 03:37:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241227015205.1375680-1-isaacmanjarres@google.com> <20241227015205.1375680-3-isaacmanjarres@google.com>
In-Reply-To: <20241227015205.1375680-3-isaacmanjarres@google.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 10 Jan 2025 12:37:03 +0100
X-Gm-Features: AbW1kvbVlPrXTHnA7AqgeRpIk1UcxEJGcZCoLyM-wZBRKWBCXPeNHX_wgjxQVTQ
Message-ID: <CAH5fLghiNqhLeO0199kvyJyqDkGO=d_n7--J0nhTHD+W3=wj5A@mail.gmail.com>
Subject: Re: [RFC PATCH v2 2/2] selftests/memfd: Add tests for F_SEAL_FUTURE_EXEC
To: "Isaac J. Manjarres" <isaacmanjarres@google.com>
Cc: Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
	Alexander Aring <alex.aring@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Shuah Khan <shuah@kernel.org>, surenb@google.com, kaleshsingh@google.com, 
	jstultz@google.com, jeffxu@google.com, kees@kernel.org, 
	kernel-team@android.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 27, 2024 at 2:52=E2=80=AFAM Isaac J. Manjarres
<isaacmanjarres@google.com> wrote:
>
> Add tests to ensure that F_SEAL_FUTURE_EXEC behaves as expected.
>
> Signed-off-by: Isaac J. Manjarres <isaacmanjarres@google.com>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

