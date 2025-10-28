Return-Path: <linux-fsdevel+bounces-65922-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E964C1505C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Oct 2025 15:00:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 663F05045DD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Oct 2025 13:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E4582E88A7;
	Tue, 28 Oct 2025 13:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g1P5+oPl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D216238D54
	for <linux-fsdevel@vger.kernel.org>; Tue, 28 Oct 2025 13:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761659862; cv=none; b=qWbBvMylrzvS+ufXdqA4EmrcOqwGS+G2xycDi7Jf809g6+Nlqa1RP8PmnsChM/n7Q6bfCuQkPW88XU8QDU/naZJQPedC1t4yQPWpO+jjzR4gytTLKya/Fa13BOM39I1L8nlSexfgIQYmpUUE5Jr0DlOG6pM4qju4AA4ZtMRRcDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761659862; c=relaxed/simple;
	bh=nV8aVqNOJAIyIjO/EUdFBuENKUMJmFxkUUBjy1ynmIA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=leQgydCg3wFMlnAI01qoSDqHkwPMt/d8VS+gII2xvgaSqKNVcEaN6mmRNDwbbO2vdfHmonJpFAKX24tvbQ1Lqz7BquAIH5U9X8STfecfp6gAuxdxRnavcV8eMCBJkARzyJ5bEUxkql6UaODYNW6DRxFIiOpuU8XP9QHy7/hJTQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g1P5+oPl; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-592f1f75c46so983635e87.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Oct 2025 06:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761659859; x=1762264659; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1C2XMyUgu0EHbkLApoQMoHRbeyl5zqyqZMRCLgfDJEo=;
        b=g1P5+oPlWgZ9CxUj11nsE68Y7kuCvnhAWJiZMttzVN+7SGSh1Hi3Wi2ycPRVAZv/OB
         /3UNZcd2zyl5im3c6Y9MpMX3t2wtioTB9B32myg1d5GoBhmk7JxTDguhODygf2Oyfcat
         azxfXaoSzj0YsHU59cYdLOlHRahrUAlQuoLaQ1g/Qz0On0ojDGGQbgeiEuccz0ltQd6Y
         AI/EdR+7wLRzUlVX/YuPgk31POyP/lzQpZiDEr9phBCNXUgI/phu0TI6not+bZF6fw8r
         Yjwf1EZmkBdrUOJKItEeH9YrvOnxPi6OSetlJsv/zGPqe9IHEXR7wWK4IRBMgx5XM2Wy
         ZhpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761659859; x=1762264659;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1C2XMyUgu0EHbkLApoQMoHRbeyl5zqyqZMRCLgfDJEo=;
        b=XR6Z/OrtAd3oHQjrLn4PklRRzl8gGGY1r2kivDrpCuRDO2FEzptwh6oeTPE+cInj+F
         DUz/1etV2gcD6l4bzPVW28Up30RfaI+aE/TeSve5igKDtxwBDOF08xJkXGQAuTlodZuB
         JwIXP8vfA1YbZAfZ6r+PNnt2TO76WKPBFURrRVXhrsgMvB+cndaJPgcw8faDrnSK4TAl
         SFg2ibx8VkF0tshrJT4GWICHg84/oH4FSV6ZNVfT5IGWCSmA1vXt+fTiUMcMEhjrn8Bu
         JWUzol3lBKUksNlMNAXyOExPBA9vgC0xMDnQ6TUkktHK/n3hMMNbBGJOgYO9NfyVecBo
         0Z2w==
X-Forwarded-Encrypted: i=1; AJvYcCWwM3umE8NZIiblMquCY9jR0gda6l5YnESPVK7TniFLeLmhUUJg24OEyafs2ETrxyaPaApmBItdZ725idgt@vger.kernel.org
X-Gm-Message-State: AOJu0YxzJtqW8VfwHjMlUmjvQf8/RC/i+c/QehzUFZ2JnAa5MHGiO3Py
	MceRAz1VwbkfmdELbid2d4j3yA8r79ktUQLmdiEarq0mM5UtkfkJxhdbNL0u2Vmd4ysF+5qG2tT
	zUIgN+ryXzZzcGl6UskB6S5/z+21+RfE=
X-Gm-Gg: ASbGncu4blQU8wv6CGibNCpJtBWRcbiELVnoCx6DgY4QjGwGgAfQaI4lmIItTwSTjBH
	jj/1ggmvP0UaKFQ9ay4U2b/EhBysg0YFZmyz7OT5UpPIAWCxMrcuuxocv6WVsiTSiUd4/s9FP76
	MPgzFN+1XBOBCHo+QWlfoVGNVjlLIaDKrM32HprpHhTBpPgNbQQXJqveYYvkAmVVw64FNRE1yhe
	VrJjxwkqxIIdedyDbc4QII+EuBCJI66cq5uH87n89XcfTwUzrbRU2raUyRMMT5jM0oIk0Bxr9w9
	5tvffEgsF/B+ly2Aaaz4W6O52S0OKU2ukObw+7LLxW1B/KP4aaFYxc2ga/580EkEsLefE4hmqjv
	uiJ2RBF9bWHHbHg==
X-Google-Smtp-Source: AGHT+IFS57SRzyAyh1eA0T/y//nY2/lPuyiomWpmCMnvcaMsoEebfDQSxTVSOlnauCaDmOiZN5PfiOLQuY4tBm0ugog=
X-Received: by 2002:a05:6512:a90:b0:57a:8bb8:2a26 with SMTP id
 2adb3069b0e04-5930e9c8d1dmr707784e87.6.1761659858839; Tue, 28 Oct 2025
 06:57:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022143158.64475-1-dakr@kernel.org> <20251022143158.64475-5-dakr@kernel.org>
 <aPnoTV4kPz5NHGBE@google.com>
In-Reply-To: <aPnoTV4kPz5NHGBE@google.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 28 Oct 2025 14:57:23 +0100
X-Gm-Features: AWmQ_bnk18uRC3GZJw-yqZUBJTaPq1ujFmD1FsVkdoikw4byHiqEGaMJE2xDXoI
Message-ID: <CANiq72nSugiQhNU++HYGi=N6hUN815copxgXnfW7fXt6pWhkjw@mail.gmail.com>
Subject: Re: [PATCH v3 04/10] rust: uaccess: add UserSliceWriter::write_slice_partial()
To: Alice Ryhl <aliceryhl@google.com>
Cc: Danilo Krummrich <dakr@kernel.org>, gregkh@linuxfoundation.org, rafael@kernel.org, 
	ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com, 
	gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org, 
	a.hindborg@kernel.org, tmgross@umich.edu, mmaurer@google.com, 
	rust-for-linux@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2025 at 10:33=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> =
wrote:
>
> Isn't it more readable to write it like this?
>
>         let Some(src) =3D data.get(offset..end) else {
>             return Ok(0);
>         };
>
>         self.write_slice(src)?;
>         Ok(src.len())

Yeah, I also tend to prefer that style for things like this, because
the "main" operation (like forwarding to `write_slice()`) is at the
top-level. rather than deep in a closure. Plus early returns look
closer to C.

Cheers,
Miguel

