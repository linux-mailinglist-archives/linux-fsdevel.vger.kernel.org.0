Return-Path: <linux-fsdevel+bounces-64941-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BAF2BF7439
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 17:11:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A2B98503705
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 15:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D428A3431ED;
	Tue, 21 Oct 2025 15:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GDmQNpyl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB3B242D7C
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 Oct 2025 15:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761059310; cv=none; b=qBjT2p65HicjVa0tsCbPAl+Lc+giMskXwm8ecW45/38xOpGFIrWWxI63YDmkoyLaaTGeMgGjwcoB22c8CzVuGXBFSDlY84kwgO2hDlujlWiEWzRN3gDW+pPiD5MTNSZKkKgk0nDfs3EelRqWmmM9ESCY2eSdsLCJc5wALKbreWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761059310; c=relaxed/simple;
	bh=qFg4+yNAZ27UrKFa/0jY50pQQ/TyaCnL0WzY/AbT3Uk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SOCiOg8NtETW+rFXKf91wIol/zdJ7nv5IapAaHbgrjn3DtSbk2OrnhEjRh0Skd1zqsrjRm5rgO4U5F+V8oARRb/Wt0tfyvxlwS3hnhHufJ0fu00KK1GF2ZBqQHeJiCJ+4yJCfbJA2UU1ASnTngE9d2ymvSSbb1IurA62icwjtdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GDmQNpyl; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-28d18e933a9so9131015ad.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Oct 2025 08:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761059308; x=1761664108; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qFg4+yNAZ27UrKFa/0jY50pQQ/TyaCnL0WzY/AbT3Uk=;
        b=GDmQNpylqDx1ao5zQVD847VGaErTwC9mikxRVUvxuQkmWPTmtaWf00RSlc40/i+kQo
         XKfjdgsq9RUAcjdjyrXvf+g7lvZwAmLrzH21U2JZsI8Xe4hG5BUajmvHwJ5B37tiri+e
         VRviq/6rBOC0/4MIRCOD64U7lRo6Bndb/9TMH3MYtcRcp0Zr+B3gRkD6VV/pVOPwPrgr
         X3Prcmrwnx3CHQz48nQJ/PlpbEwBdRWpL7hOFaNLxEyaXi0qJtkMkg86nlHDtJM7uIKG
         iXtTUI3s3UWtP6mL5uqDpvIz1wlIaIfYgF5MYOon2T5l3wxvrI9N3G+9DPze33/14P75
         MTEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761059308; x=1761664108;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qFg4+yNAZ27UrKFa/0jY50pQQ/TyaCnL0WzY/AbT3Uk=;
        b=IZf7IeyipL5n0JSWUpoxN4TkkLomjhHyRAPK62dc3le7BgWSTKa0MiwgZYVacaLmrI
         cUTsXAIl1/6S/wsusZ8icfkS99ss+wdtQRS0GO/zhnznmtifYV1xXuhpPbcdr2J8iyYn
         kvYaZMapmnupCnxw5In3/rlleOEN4gdFuY7ttPdsqgkz8vNH1W8GBoWZy+zrKOK180ns
         NuUpxu6li9noAypCrfL4rQTu8WX0USEggUPeoTgWKZKSRWZPisiad7i7mwL7rebxdWYE
         /ltStv/XLn46rqtNGYCdL108FpPoHFDauHGFYBUvWR360LOpAQFW7l1Lra5FeyVFUIg+
         uG+w==
X-Forwarded-Encrypted: i=1; AJvYcCUN8qs67BR+7DYrjVtNryRkvKX7tliw8ICqcqSbGeLwLUEzbls5K8tpD97xz9uvasNAL2zy+tPsUp6G3kgd@vger.kernel.org
X-Gm-Message-State: AOJu0YzbrH/6ylSvDouHMznZk5z31xNb80T9eBhxLCLrOTGs3gSXpTc0
	Y6kTCeKUUs0jXwxE+zuhutUzk7BrzEvDurpjnorOGfLxTXRjjlVt18h0DcW4h3OUPs2c8ts2VfS
	roIjfFIU+YnVMKf1w0rvk/7F/lyqjVak=
X-Gm-Gg: ASbGncvjOJQrKm4n2n+N7Gympfv/QwewzEGqk4jSR/HpL3swz3FylQzc6wvRNxWFTuO
	FEmzdCIvfrm8uI0SgD58fcwgL74Bxq/3J+OgjCsAlltqoT5ODR7yUcmcqlBWp/ma3tLvFICK7Be
	GaQoDMgxJ2NUtrH/9Vd5y9zd9FuFiZKXDqTxjvy7bfW0448wEa5/UXz6VHr35vXI7WuZS316Rtc
	ZICejYT+qZRp55dFux964KfsxKO0IKINUdxJiM/koEjwMxai6F28GpmHbBTv9WbAHupFxqDltMu
	YMm/poH1Q89pIxKK+ZWBw7QHeccRVCyjFnczw8QRalJSatsFAKxa0I/30c4TCujyBO/1f0JH/HI
	KJYU=
X-Google-Smtp-Source: AGHT+IFreHdov+uVhNjI+vb4zuqGdoRtHfpLdbPpRiyIyY5EB+5Z0lQXG7LeNg1R8D52vs+phURtS3CNMV6Qy7+3LW0=
X-Received: by 2002:a17:903:22cc:b0:26b:1871:1f70 with SMTP id
 d9443c01a7336-292d3f7212amr26756455ad.5.1761059307987; Tue, 21 Oct 2025
 08:08:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251020222722.240473-1-dakr@kernel.org> <20251020222722.240473-2-dakr@kernel.org>
In-Reply-To: <20251020222722.240473-2-dakr@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 21 Oct 2025 17:08:14 +0200
X-Gm-Features: AS18NWCCy2kjmOIA6ceL9V6OXhZcSR6v5l_FF-ORfDMjRgq5VddXOb7GOLYgjmY
Message-ID: <CANiq72m_LSbyTOg2b0mvDz4+uN+77gpL8T_yiOqi1vKm+G4FzA@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] rust: fs: add file::Offset type alias
To: Danilo Krummrich <dakr@kernel.org>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, ojeda@kernel.org, 
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org, 
	aliceryhl@google.com, tmgross@umich.edu, mmaurer@google.com, 
	rust-for-linux@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 21, 2025 at 12:27=E2=80=AFAM Danilo Krummrich <dakr@kernel.org>=
 wrote:
>
> Add a type alias for file offsets, i.e. bindings::loff_t. Trying to
> avoid using raw bindings types, this seems to be the better alternative
> compared to just using i64.

Would a newtype be too painful?

Note: I didn't actually check if it is a sensible idea, but when I see
an alias I tend to ask myself that so it would be nice to know the
pros/cons (we could ideally mention why in the commit message in cases
like this).

Thanks!

Cheers,
Miguel

