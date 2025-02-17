Return-Path: <linux-fsdevel+bounces-41867-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A3DFA38A40
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2025 18:03:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E78A3A6EC1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2025 17:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BAF1227B82;
	Mon, 17 Feb 2025 17:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eU1NLoMH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2F722757F;
	Mon, 17 Feb 2025 17:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739811820; cv=none; b=AtpN+A3P1By0XUNqU3iHCKAHhl5oTEul174tCRkRelzLc8Sy2/4bvNUvO5Pt67Uuf1k5C00G6oPtw6l1M8yXVlq7Kus4sYRoCRJ8wJItI4hRBeyASfaY3PpMrfwdPXCECDNNsOjEHMtHMVVx+Z0bStF6ftmHrpLp9YSIqCXLqf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739811820; c=relaxed/simple;
	bh=892kOeSJSF9lWeOepUaAD/OoV3ulliQZRTtXabXbYD0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G0AKq0iHVILQ2uFL+kTB9MgNomjvtLQV0RYs6cuFH4/wzWZmFmCokelYb5EH7ug8z9mbC8P1G1JEUHm+ZlpFTyk0xbb2xHdhuSeWQxUNl8XctppXcFXdR98j1brjn5PDMtXBcKzxsvQDroXZdJuC1t0z73n9QyTpgrigtK3kZJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eU1NLoMH; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2fc92215d15so113772a91.1;
        Mon, 17 Feb 2025 09:03:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739811819; x=1740416619; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=892kOeSJSF9lWeOepUaAD/OoV3ulliQZRTtXabXbYD0=;
        b=eU1NLoMHUkAOPXpVsWA8v1LdDH+IQRgFL0gxsGmzb1etWUIhlOuXKJsSWhm7XqlYHg
         1iRh09xPHJdURF7h8ggjdQa8s5WKKxcHVgd5I0cRjZpT9+7jFrVbZPDmw9M0dnr+ygpD
         QifYvZpNnx0trU1y+aQV5GV3iJcgKYpj6Ypezoa5FYRhTzrCSxG1lOn8u3JjqRt4Dh9l
         q5ISDUxeBmUtsDUC/ZAg5QBFyMPlLvtEx8Y60ToqKYEOtVON2K5o3x7sopzsocwiWCSo
         mTCHvrJGanFPvil4UYTGAsX8feIBfuUFzTWBiAcVxR0NyPD5B42y4XTsVWJHmU+ySeTw
         CF/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739811819; x=1740416619;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=892kOeSJSF9lWeOepUaAD/OoV3ulliQZRTtXabXbYD0=;
        b=vFVzq8mv8G+YdUTzf/ydyapuNG6i7RdRbG/8llYPuMt++LStx3ZqIp5a4+T4Z6iaD2
         PNDDEpJ7pezbguhKg1G0fwn24gIPc646iL+gqUz5Y1N4E5zl9aNVVR387UHMrkYcBQNB
         roDDDKuZB7qpqKyJNYgdLwPpm49XY7iD4Ql5st4fg6VNF0LSOzPGrQxFpuairFR8xvaS
         zibdsqxgXMfZeZ8H9zpbj72jnn1sfB82NqM1ysT6/aoUirkHlsS8ksLTPltn9My8rRA1
         Nl2FK7KqHRvaO/v4B7AqMZAotaxfTn6uQlL6LgLBZ5/3vlo1O1kjoA1cIQ+wfBbN2/PJ
         h8OQ==
X-Forwarded-Encrypted: i=1; AJvYcCUkdP0U6U5kSj0Yv4mNsIPZxS8gluAH/yl9UVh+TfjQo6Ree5YhidaRdxBaY81J1nAOk/yN6lBWO+PYJI6v@vger.kernel.org, AJvYcCVMlirqkKAzAhP2Vdqe8TFUVKJ2+tIjZhXpOUaj3m7jIskfzTJrYamrIrOX33GkwdgvN3sKAmWwxEvYOZNF@vger.kernel.org, AJvYcCWai/73M5BN6d8qqS5Nzqm/KdQDxCcoYQ8cz6O/aIcDelUpwc/5DcwEYAGsMMIIoeet+tb18CaHGXPdM84F10g=@vger.kernel.org, AJvYcCXA+x/kkdqGw0i24gQv3zFNYZ8Y3fU9RoRSmHkRxu1IdHC/myx+yY3ye+lMfwLXprp6HKDry6JKj8mW@vger.kernel.org
X-Gm-Message-State: AOJu0Yxv5ETnVkjjTbORTTABQjF7w/KNfkV7R5y6zL9bxioi8XXPyNiK
	/uS/vd3LPyX8agZfW2YZ4sXB1yBN1B+k6JVB0lS4QiIRfS/PKj7pV1Qs53tf0IKmnRigYL1jfKb
	uED6Tt5ZrHqOwWT4JQbgexndGPSStsUAHZes=
X-Gm-Gg: ASbGncvgi4nz7Jv/j2pUVafdHl3W6Kwes/BGBTXSad9xdMmUXn+e3tvzNj+cB735rnp
	WBf0STQXkiEq1Ka5tp71RJXoGCxAWX0tw4xLKPGVut8UyFQTdjs5M4Omh0pBbDZU7AeU/Wm4k
X-Google-Smtp-Source: AGHT+IHQdV7SvCXJgf7HfuQ9geGQBDFeTyL9q2C1rtrt3cDvQ7P/OGGgYBIR2/bQVwyRlfkLFnUZ2yrgwtDLe5uOBEI=
X-Received: by 2002:a17:90b:180e:b0:2f4:447b:f095 with SMTP id
 98e67ed59e1d1-2fc41042aaemr6268777a91.4.1739811818643; Mon, 17 Feb 2025
 09:03:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250207-rust-xarray-bindings-v16-0-256b0cf936bd@gmail.com>
 <20250207-rust-xarray-bindings-v16-2-256b0cf936bd@gmail.com>
 <Z7MnxKSSNY7IyExt@cassiopeiae> <CAJ-ks9=OG2zPPPPfZd5KhGKgNsv3Qm9iHr2eWXFeL7Zv16QVdw@mail.gmail.com>
 <Z7NEZfuXSr3Ofh1G@cassiopeiae> <CAJ-ks9=TrFHiLFkRfyawNquDY2x6t3dwGi6FxnfgFLvQLYwc+A@mail.gmail.com>
In-Reply-To: <CAJ-ks9=TrFHiLFkRfyawNquDY2x6t3dwGi6FxnfgFLvQLYwc+A@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 17 Feb 2025 18:03:26 +0100
X-Gm-Features: AWEUYZkHuwpcc8BVbA7X3JH9BSePpg7sWruJpNt-Bnq4-NvALs5XCn7NODxxEbY
Message-ID: <CANiq72kAhw6XwPzGu+FrF64PZ9P_eSzX3gqG9CLvy7YJnbXgoQ@mail.gmail.com>
Subject: Re: [PATCH v16 2/4] rust: types: add `ForeignOwnable::PointedTo`
To: Tamir Duberstein <tamird@gmail.com>
Cc: Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Matthew Wilcox <willy@infradead.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	FUJITA Tomonori <fujita.tomonori@gmail.com>, "Rob Herring (Arm)" <robh@kernel.org>, 
	=?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>, 
	Asahi Lina <lina@asahilina.net>, rust-for-linux@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, Fiona Behrens <me@kloenk.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 17, 2025 at 3:21=E2=80=AFPM Tamir Duberstein <tamird@gmail.com>=
 wrote:
>
> because it doesn't acquire the git blame on the existing line.

Hmm... What did give you the impression that we need to avoid that?

Cheers,
Miguel

