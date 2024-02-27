Return-Path: <linux-fsdevel+bounces-12921-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CF64868A42
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Feb 2024 08:55:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3906F282EA3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Feb 2024 07:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2077155E79;
	Tue, 27 Feb 2024 07:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b="Jp4HxUI5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D8D854FA4
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Feb 2024 07:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709020512; cv=none; b=hI+nvt2gNOeedsu6JiY5ZQkRUPU5fkp4u4Lox7WTOFlfCvsWba1D8EWOOSsfo96qyGoenZqlxFZXpYh/7W1FMe5/EQlZA9YqaJfSFcOEhW+WFly0enF2AavdozAQXYYVpOMe1uDRO0JdQDShp3R2le05082SqCPtzH1qu0CcW/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709020512; c=relaxed/simple;
	bh=xbWkD4wvguVY9u5Ayn0gXU+FmdtJqxG5pcjSnxUJL8E=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=QRUWT9jMUu5s21IQs1OrQqK1KXxncMT37d49GaGv9d15YeaFapH09jilnrhXQozRlib0F5ZDa+dC8oGxiUn7tiL54SF4piqJnESagaV/vT90VWXOiATOBC2VH3//Zl8Mj7TAQ7M05Go3XquFbi+nfNmk+QmY6EwfaR+i8uk0rkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk; spf=none smtp.mailfrom=metaspace.dk; dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b=Jp4HxUI5; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=metaspace.dk
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a26ed1e05c7so629359266b.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Feb 2024 23:55:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20230601.gappssmtp.com; s=20230601; t=1709020507; x=1709625307; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xbWkD4wvguVY9u5Ayn0gXU+FmdtJqxG5pcjSnxUJL8E=;
        b=Jp4HxUI58TZJiAGwYMXWDhNNGQXZWMauGsLNnfwRqY8jb1QTFqiJl7AvbCYZOJhVty
         BS7o54yUkZwnpiCWTJFgXEDwASbVbPWMRETKpqGRtehI2shx3aABtF5G1JGD7tt3JTJx
         eKglGJb4x1PLFRdsNukbriIxHIxiHlQFqD8e+5i4iL8Gd+XtMMtBco/WRm28pGCyeZ9C
         LNbdjy/J9QQmkl9FwnpbHedNp5i1WOVBspLHXOjeGTkw4Y69sHD22WR1CW5R9Swa/uIb
         h1IWwN0FW+yQQC+H0MknXocw7MCfJj6nHBByVBdm265jxX5BLu7UsOpRNsW0OFhFf0Lx
         6naw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709020507; x=1709625307;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xbWkD4wvguVY9u5Ayn0gXU+FmdtJqxG5pcjSnxUJL8E=;
        b=ECFI/JSvlwfQEO0r5g6unDGTRFHAnDG0TICjYUs/TBOrn631YoQC7kpKu9cr0Cc16n
         MqGWL1XjRASUCChXHjl79qEU6I19BmDwhJvCT/lgXRk/5C8B7AXecRn2Gm72ynQidgMo
         ybzAues8EdMHfmh4/aKXGWxIpnQwyVuWI1zgntRSswO5cgj+F1c+Cb/++PR05kfKDvWm
         mwyZXYve6NjVxwnvksijyFbjalK/ZNW4nEqOq31kR0flM0qQTITsYCLsZDXAN80nXMX4
         hQR2VyR7Ci4x6M2evr/OP/fIW98FaeH5GUeYI1EFshNwLH1GF5RCNi4siN/AloC2ZFRr
         giDA==
X-Forwarded-Encrypted: i=1; AJvYcCUMRVlo3Z9CySMKrruW7bOUomu3C9hpFLsttSwBTEi8Y37XIC4Y2mNrB/kw+0R8dQY+56cPBIXr1+ej/WsRDiVqV4Y0KCWEqnqqk6X7PA==
X-Gm-Message-State: AOJu0YyXXkDQRDwMM1WMyGqhEnaxO/Es4LDOxG1j7ERqU5CTufjhy1jn
	HZM4UBDJaf6pP9t9Jl0bwYqzWQBXHYv4ecaBfro+r8U5hpnhtETzN8Icf7+gfH4=
X-Google-Smtp-Source: AGHT+IHKg0r6A1VdrZrNe9qtQFQ82Ul+9F7i7Pp7nuPZzWOtYrIU+3C5V8PmiOf6x3tZT3xbnnCCyA==
X-Received: by 2002:a17:906:3683:b0:a3e:c738:afa2 with SMTP id a3-20020a170906368300b00a3ec738afa2mr6226824ejc.76.1709020507423;
        Mon, 26 Feb 2024 23:55:07 -0800 (PST)
Received: from localhost ([79.142.230.34])
        by smtp.gmail.com with ESMTPSA id lu4-20020a170906fac400b00a3ecdd0ba23sm503372ejb.52.2024.02.26.23.55.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 23:55:07 -0800 (PST)
References: <20240209223201.2145570-2-mcanal@igalia.com>
 <20240209223201.2145570-3-mcanal@igalia.com>
User-agent: mu4e 1.10.8; emacs 29.2
From: Andreas Hindborg <nmi@metaspace.dk>
To: =?utf-8?Q?Ma=C3=ADra?= Canal <mcanal@igalia.com>
Cc: Asahi Lina <lina@asahilina.net>, Miguel Ojeda <ojeda@kernel.org>, Alex
 Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn?= Roy
 Baron <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>,
 Alice Ryhl <aliceryhl@google.com>, Matthew Wilcox <willy@infradead.org>,
 rust-for-linux@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 kernel-dev@igalia.com
Subject: Re: [PATCH v7 1/2] rust: types: add FOREIGN_ALIGN to ForeignOwnable
Date: Tue, 27 Feb 2024 08:53:55 +0100
In-reply-to: <20240209223201.2145570-3-mcanal@igalia.com>
Message-ID: <87ttlu9wb9.fsf@metaspace.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


Ma=C3=ADra Canal <mcanal@igalia.com> writes:

> There are cases where we need to check the alignment of the pointers
> returned by `into_foreign`. Currently, this is not possible to be done
> at build time. Therefore, add a property to the trait ForeignOwnable,
> which specifies the alignment of the pointers returned by
> `into_foreign`.
>
> Suggested-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Ma=C3=ADra Canal <mcanal@igalia.com>
> ---


Reviewed-by: Andreas Hindborg <a.hindborg@samsung.com>


