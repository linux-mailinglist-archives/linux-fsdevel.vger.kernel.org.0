Return-Path: <linux-fsdevel+bounces-14805-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DCD387FAC7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Mar 2024 10:33:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EBF00B215F2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Mar 2024 09:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94E927D07F;
	Tue, 19 Mar 2024 09:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CnsDUczc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 193CE7CF3A
	for <linux-fsdevel@vger.kernel.org>; Tue, 19 Mar 2024 09:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710840780; cv=none; b=OL8zqVwF1a1n/Ruy431o2yHBNgus4n07GOm4d/RqcJHiR8RaHK7hwc7Edly+jwGkMhZxUlc4e6sOLttMhNOyW+BFOA3wFiuy+lohtA4eUWGgJCStOZzuosvTALm3i2SdParhpMqYBhBAN5e1sKGHeaM0KPOjcjEJDf08owhsyIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710840780; c=relaxed/simple;
	bh=ltFAvz+UR3pI1vVG/Qog2FjzivTlcNabCPQD33jgFN8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NHevHyvZMvCaGoB8NNMmCLM8NmriR03Gy42awTyUR90dPkihjaJNOe+gH8JhQWnyt85dpQf6E8nSC5ETxDCrsw+fHT24/gmiYA7i01b5y3yhrF2ThtUnTK+1iPugQNOMzuZFsVreX0cjuuQk/wndmvEQltpf0bRI5Og+xkwXRbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CnsDUczc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710840776;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=myUYXSXEfRiI3CauEW1rnw2E2713JJIdN6pCUXco+PE=;
	b=CnsDUczc24b4FpaSdKqKyt+Vij1i/GbGQR2ikCvH5FLoBw6V4tZuexJqYiRuOm8os0bmgT
	qIJMto/sJDeYNP2Ewibf/7P+27R+XYrZ1OP1h1RUwi7jIifT1HbR4MhvEWIw4RP09pc9Sy
	hC4V7ouov9P/FdTjf8qTOKeG+l3hbok=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-202-iY_1SOPRMLeGUpL_hXTO3w-1; Tue, 19 Mar 2024 05:32:54 -0400
X-MC-Unique: iY_1SOPRMLeGUpL_hXTO3w-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-29c74083a99so1896016a91.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Mar 2024 02:32:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710840774; x=1711445574;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=myUYXSXEfRiI3CauEW1rnw2E2713JJIdN6pCUXco+PE=;
        b=OC0gPtRx4YIA4eXZrZOx2WdVsYpHFXbGd4tXY+59glpc7OW4KBWzUCNlBoqkN3AieT
         oCPT7+upkJqw/E+5CX9yYIq6Xbt6M+9DRQ9JFpm4gpt18oDkYMUYBM6FCOUw/NxxmEMu
         4EKD/Mc26pvmFboaqkbpp/VZvu6M762XAK7E1W3SOoxHyp8/NpNDHitVx4OysqtcJycF
         P8DqgF3LU/AAEOXd7OX500h6U/vCmj9cg+qp1HCaM63GfaezhgeZpivgK118GrCogZEh
         JZOQNNDJem8hesYQJP3X6zQ1ZFtXIBzMh+QzmKbn4g1RP6sYB0b+UK1pYlg2c7CgAs3f
         SNiA==
X-Forwarded-Encrypted: i=1; AJvYcCUY/103RhjQnF+X0xRaANtPCYkpyDMDOcQXZGT1jVMQiIKYmx21K/zO0fBjXY9ZdBGkHzp0apAtirBMehQEylY4SQ2DLvT0jsXRUGOGkw==
X-Gm-Message-State: AOJu0Yz8mWgfTNqZHEzscySxDUEtvQvhgOcGMivvR606BMmxrDS/r7o/
	+/gCxziB2L4gMPKRFITYgG8Or0y5zM9Mn96Q2bChC1rxyD3Q8mDzkUkmAqR9hUhTBd976f+cxx6
	ghM5cbv+yj62qslVuvX8wEgxeLWiTcpNmWftYYRNvNluYd/sOkV0P+rBVpKmD+d0=
X-Received: by 2002:a17:90a:a882:b0:29c:7697:d2dc with SMTP id h2-20020a17090aa88200b0029c7697d2dcmr1514749pjq.4.1710840773867;
        Tue, 19 Mar 2024 02:32:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE17qD0qlNXiH735OuHqzRdQxRNKobNEC0s5dp7fWezTGMhk1Ph5axwwnCg8WUHfB7wqi2kDA==
X-Received: by 2002:a17:90a:a882:b0:29c:7697:d2dc with SMTP id h2-20020a17090aa88200b0029c7697d2dcmr1514738pjq.4.1710840773528;
        Tue, 19 Mar 2024 02:32:53 -0700 (PDT)
Received: from pstanner-thinkpadt14sgen1.remote.csb (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id pa10-20020a17090b264a00b0029c693a1e6dsm9420560pjb.17.2024.03.19.02.32.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 02:32:53 -0700 (PDT)
Message-ID: <c8279ceb44cf430e039a66d67ac2aa1d75e7e285.camel@redhat.com>
Subject: Re: [PATCH v8 2/2] rust: xarray: Add an abstraction for XArray
From: Philipp Stanner <pstanner@redhat.com>
To: Alice Ryhl <aliceryhl@google.com>, =?ISO-8859-1?Q?Ma=EDra?= Canal
	 <mcanal@igalia.com>
Cc: Asahi Lina <lina@asahilina.net>, Miguel Ojeda <ojeda@kernel.org>, Alex
 Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?ISO-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin
 <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>,
 Matthew Wilcox <willy@infradead.org>,  rust-for-linux@vger.kernel.org,
 linux-fsdevel@vger.kernel.org,  kernel-dev@igalia.com
Date: Tue, 19 Mar 2024 10:32:48 +0100
In-Reply-To: <CAH5fLgi9uaOOT=fHKWmXT7ETv+Nf6_TVttuWoyMtuYNguCGYtw@mail.gmail.com>
References: <20240309235927.168915-2-mcanal@igalia.com>
	 <20240309235927.168915-4-mcanal@igalia.com>
	 <CAH5fLgi9uaOOT=fHKWmXT7ETv+Nf6_TVttuWoyMtuYNguCGYtw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-03-18 at 13:10 +0100, Alice Ryhl wrote:
> On Sun, Mar 10, 2024 at 1:00=E2=80=AFAM Ma=C3=ADra Canal <mcanal@igalia.c=
om>
> wrote:
> >=20
> > From: Asahi Lina <lina@asahilina.net>
> >=20
> > The XArray is an abstract data type which behaves like a very large
> > array of pointers. Add a Rust abstraction for this data type.
> >=20
> > The initial implementation uses explicit locking on get operations
> > and
> > returns a guard which blocks mutation, ensuring that the referenced
> > object remains alive. To avoid excessive serialization, users are
> > expected to use an inner type that can be efficiently cloned (such
> > as
> > Arc<T>), and eagerly clone and drop the guard to unblock other
> > users
> > after a lookup.
> >=20
> > Future variants may support using RCU instead to avoid mutex
> > locking.
> >=20
> > This abstraction also introduces a reservation mechanism, which can
> > be
> > used by alloc-capable XArrays to reserve a free slot without
> > immediately
> > filling it, and then do so at a later time. If the reservation is
> > dropped without being filled, the slot is freed again for other
> > users,
> > which eliminates the need for explicit cleanup code.
> >=20
> > Signed-off-by: Asahi Lina <lina@asahilina.net>
> > Co-developed-by: Ma=C3=ADra Canal <mcanal@igalia.com>
> > Signed-off-by: Ma=C3=ADra Canal <mcanal@igalia.com>
> > Reviewed-by: Andreas Hindborg <a.hindborg@samsung.com>
>=20
> Overall looks good to me.
>=20
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if ret < 0 {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Err=
(Error::from_errno(ret))
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gua=
rd.dismiss();
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Ok(=
id as usize)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>=20
> You could make this easier to read using to_result.
>=20
> to_result(ret)?;
> guard.dismiss();
> Ok(id as usize)

My 2 cents, I'd go for classic kernel style:


if ret < 0 {
    return Err(...);
}

guard.dismiss();
Ok(id as usize)


P.

>=20
> Alice
>=20


