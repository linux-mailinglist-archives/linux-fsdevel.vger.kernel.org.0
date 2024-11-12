Return-Path: <linux-fsdevel+bounces-34558-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA7589C6404
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 23:08:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F621283B80
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 22:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F47921A4C4;
	Tue, 12 Nov 2024 22:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z7EXBb67"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FBC820370A
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 Nov 2024 22:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731449273; cv=none; b=c+pdendMR1jqPFyla6GEnZHLIFjkELSUX14Daijr0A5ngxVme+tjmujoe8uhfka8ti500hsabkhci7/B19BYW5P+g8TtUe23PxOrynQd1CsjXCD9YMBub1m7rD877/7oM/iEaAqRr7fslcbFDw3EgpVJg42vGOCfDCL2sTBkrDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731449273; c=relaxed/simple;
	bh=L9qdnGwKHBUrVgMudO4Zu7QMm7HkE2ShwUItuSy6SP8=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qfogUAdXXpT5ZMX9j9tDjfRGrx/Xm/uXSBMpj8Bxg9epzw9C5Mv9Kq3REBmaWsmT4vPczY9PGIzZlfD5FmKFlLSQQQVCG7QQf8NZ5nZ2KIHTutUFdOCd3yOqjquwdUBPkg4CPrmCEzo3hUn3x2I6wzKlFPlyy26mX7AVMCm3+ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z7EXBb67; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-7ea76a12c32so4531980a12.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Nov 2024 14:07:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731449271; x=1732054071; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=d+UW2Op7GE7GQXptwht/lcrjAza1pTojZMwL+TK4pmQ=;
        b=Z7EXBb673JdjcLfiQ+XSTNMT0MPqHgKL7apvOJZnBmzWURhOhn3qOTWAUMI9dbNYJ8
         qJU7zBwY9YoPzEtWjm75HgR2NwzA7hymHXiPdsBnM4XNu5WID8VNhCmraXXGPXSvlpfO
         RSupxzmUAu6DpwGR3pIQr2uoZmqLseK5vuZQF7hhA/fP6TdyJ4MuGAOn0D0v3Vv8EVzd
         jZXWkRmFim3n3T0lGVd3yX2/cr8Y1GqcmwWLoqL4npANU0e7z2JkEeZUndO2Ha9YWGBV
         Q+fsXeG/ncaUv+c8cdYJ7raimG9n0C9WVamfUBFoD6l3sElbefQ0EtuiWcH0m+RR01Fb
         sDgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731449271; x=1732054071;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d+UW2Op7GE7GQXptwht/lcrjAza1pTojZMwL+TK4pmQ=;
        b=e8d6sB+HKfxeUaiLntJWfVEwXeDJ2qpeui1fuyEnHMLZhZfn7/XOT0kCRF615YWhCU
         wn5n2qTJRutqmkqZRG487C4Ca8PzlSp/tuphNmv1MMw3tB3QsLN3LBSVHUalILvZQE7Y
         t6inU2KraafNPOpKJmUKkenzLVzA7sXbN1h1BLJJON+8aTicfN2kZlxGxJmEfPO7C1Zc
         n8mbKsldwsLWOthaHhSkB6lxiCt7Ctrnci7h2YUmfnKZfdEUTVsMQ3103S5bBEbkMwVq
         oqwqhapbEm3wnmZHQvwglPOCFSD2NcU+PW8WFvptSZXjuCAjtUFUGUzNTsQ9dPdGqiVt
         TAWg==
X-Forwarded-Encrypted: i=1; AJvYcCXJjSwnREZtM3R5VXdoF6tjobglWmMGXu0BBGZuag2jbrnJo+dwojhdtMnEdKduvR1mKL0q/Hx/hLoePAzl@vger.kernel.org
X-Gm-Message-State: AOJu0YyKxZYrcwmBQO+U4IETRKXKOudnzlum+S7ATKS9t1+88LPD1Za3
	5dYbjIBEQDek2D5f1yURBua2skT9fUJSU9TPmuPABfvXNjLetv/m
X-Google-Smtp-Source: AGHT+IGiSna4phvEa18H2dmaztl3E7zrI8XNXhPBJZoWXHLfFfW7LEz/pSyGk/kBpuZb2oG9B5sMpg==
X-Received: by 2002:a17:90b:1c8f:b0:2e2:cfef:86 with SMTP id 98e67ed59e1d1-2e9f2c4ef4cmr641002a91.4.1731449271222;
        Tue, 12 Nov 2024 14:07:51 -0800 (PST)
Received: from mars.local.gmail.com (221x241x217x81.ap221.ftth.ucom.ne.jp. [221.241.217.81])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177dc9073sm98363485ad.1.2024.11.12.14.07.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 14:07:50 -0800 (PST)
Date: Wed, 13 Nov 2024 07:07:45 +0900
Message-ID: <m2pln0f6mm.wl-thehajime@gmail.com>
From: Hajime Tazaki <thehajime@gmail.com>
To: geert@linux-m68k.org
Cc: linux-um@lists.infradead.org,
	ricarkol@google.com,
	Liam.Howlett@oracle.com,
	ebiederm@xmission.com,
	kees@kernel.org,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH v2 02/13] x86/um: nommu: elf loader for fdpic
In-Reply-To: <CAMuHMdU+Lyj3C-P3kQMd6WfyjBY+YXZSx3Vv6C2y9k__pK45vg@mail.gmail.com>
References: <cover.1731290567.git.thehajime@gmail.com>
	<ea2a3fb86915664d54ba174e043046f684e7cf8c.1731290567.git.thehajime@gmail.com>
	<CAMuHMdU+Lyj3C-P3kQMd6WfyjBY+YXZSx3Vv6C2y9k__pK45vg@mail.gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/26.3 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable


Hello Geert,

thank you for the message.

On Tue, 12 Nov 2024 21:48:28 +0900,
Geert Uytterhoeven wrote:
>
> On Mon, Nov 11, 2024 at 7:28=E2=80=AFAM Hajime Tazaki <thehajime@gmail.co=
m> wrote:
> > As UML supports CONFIG_MMU=3Dn case, it has to use an alternate ELF
> > loader, FDPIC ELF loader.  In this commit, we added necessary
> > definitions in the arch, as UML has not been used so far.  It also
> > updates Kconfig file to use BINFMT_ELF_FDPIC under !MMU environment.
> >
> > Cc: Eric Biederman <ebiederm@xmission.com>
> > Cc: Kees Cook <kees@kernel.org>
> > Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> > Cc: Christian Brauner <brauner@kernel.org>
> > Cc: Jan Kara <jack@suse.cz>
> > Cc: linux-mm@kvack.org
> > Cc: linux-fsdevel@vger.kernel.org
> > Signed-off-by: Hajime Tazaki <thehajime@gmail.com>
> > Signed-off-by: Ricardo Koller <ricarkol@google.com>
>=20
> Thanks for your patch!
>=20
> > --- a/fs/Kconfig.binfmt
> > +++ b/fs/Kconfig.binfmt
> > @@ -58,7 +58,7 @@ config ARCH_USE_GNU_PROPERTY
> >  config BINFMT_ELF_FDPIC
> >         bool "Kernel support for FDPIC ELF binaries"
> >         default y if !BINFMT_ELF
> > -       depends on ARM || ((M68K || RISCV || SUPERH || XTENSA) && !MMU)
> > +       depends on ARM || ((M68K || RISCV || SUPERH || UML || XTENSA) &=
& !MMU)
>=20
> s/UML/X86/?

I guess the fdpic loader can be used to X86, but this patchset only
adds UML to be able to select it.  I intended to add UML into nommu
family.

-- Hajime

