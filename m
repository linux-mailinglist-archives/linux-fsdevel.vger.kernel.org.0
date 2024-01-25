Return-Path: <linux-fsdevel+bounces-8870-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FCCD83BED7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 11:32:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FC8C1F261E0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 10:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DD7E1CAB9;
	Thu, 25 Jan 2024 10:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BeoCtGvM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28BE01CAA8
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Jan 2024 10:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706178718; cv=none; b=dB/XUyATLDVLFGMvrTAmfqA80CzY0VKHM0iFOYV0/Kf3i3cP3ui1Lx2kIIkWiYYZqMtpsRcEMluEoRekGvKQUR2kYAnKoSjb+pKBogpn2k25M6oKHppvA9GWV9Bml7a0Em2buN0915PIgr1Gcb7PjbD4VWXMpexQw3RpeVskK2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706178718; c=relaxed/simple;
	bh=cWf6jbJM4bTIZZq86/kL7elUKyQFSEDd12/W/Q8QCyI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AqNKiGjkCXmLcZSYNZkoLAnkkf5+jWWSGmllNPu+6SyTDYpAgriafM1po8W2s3Q570zJMPPYszydkea6vRy1jeYPJhWp4PAvkczi4ah43DNTU7/Hb/+CyvqQrjF2UJUoseivaskaZykVY3NN2aLS0/TpPW0P63gneIHIbUt1h2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BeoCtGvM; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-55cc794291cso7251a12.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Jan 2024 02:31:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706178715; x=1706783515; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cWf6jbJM4bTIZZq86/kL7elUKyQFSEDd12/W/Q8QCyI=;
        b=BeoCtGvMNuAMkx9bTQJa45NPOXWML4wWC7ct8hyo3Xd7PegyigVJtjK+8x692IFBjM
         lMtcmZNpT2CerWJlgm8V1CaZP5Kld4o4xvBGtfgq3HxW8ZKK8zdtAK+5WOApLjAwHG3/
         iItiuCqFwjwrQyDRmfx/2p4uyVURuFNJxyk9M6LqNA16cfboPxazF+6ilYkMIr9ueyOk
         9fVfdeL+NvIjqsCpBijJPwVUdBGII+d/0gVSHgpCA7FwofKYU0+H9o1DDJwuhDgAwoqW
         AD6ZKT7nXtJbfd2Ehzm7LK9bSuQAvm92Uybocs5/WunCATM62AusnlJ4YjzjQPPya5TQ
         qQCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706178715; x=1706783515;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cWf6jbJM4bTIZZq86/kL7elUKyQFSEDd12/W/Q8QCyI=;
        b=rsi53Hl3XmTZRkTbJLpzmln1hKEpKipyoJiqlneX0seD+TGY7FF4GuqxcbIcuxydAU
         JFztWFCbblb10qq8XfuU7oQe62imJ43UEnOBmU7Um1KxNZFUj9as3PB0svCgO4Ir9MXt
         be1YEpnh27lUBEuHggEqF2vFWsd4hjGoVzLi0snJRYmTzy6WPK7FGxhCX+8od5HeQCYS
         yFrC9PnMTREZ0RM5DK77XB0P75G74CcAXruQzltapvsffrssvVvQRk+S2k5/vQeEWoTQ
         lpB0SpLowaRte/go74m17HD2HbDekj3UVY3eR2lcQVZfEHT6m14jJVoqYh9ngRaqs9KO
         vnuw==
X-Gm-Message-State: AOJu0Yx3jhOsc/iagXWuPuUkKJu7mDxBTLyGRd2RSKPM18bPgWg7x2ZV
	0k4Ax4YBd41gf3pjSpGkkeWtDcBZ/8cWf32vvNZ2KociR0UqDPmpKB+pas1yOOkOlwo3xw60cuU
	SkVjV8drwKwZhfIoeWJqKjqbWzHI/2gJQ2gO+
X-Google-Smtp-Source: AGHT+IHtqUYvp4/VdtenInel7W+JfvX7Hf8VwjhjBJFEhAw9CuJLqpo7Ij201tiBjQxKUPCTaH7PXQp8tVrb6IBxWEM=
X-Received: by 2002:a05:6402:22a1:b0:55c:2131:56cf with SMTP id
 cx1-20020a05640222a100b0055c213156cfmr118666edb.7.1706178714987; Thu, 25 Jan
 2024 02:31:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240119092024.193066-1-zhangpeng362@huawei.com>
 <Zap7t9GOLTM1yqjT@casper.infradead.org> <5106a58e-04da-372a-b836-9d3d0bd2507b@huawei.com>
 <Za6SD48Zf0CXriLm@casper.infradead.org> <CANn89iL4qUXsVDRNGgBOweZbJ6ErWMsH+EpOj-55Lky8JEEhqQ@mail.gmail.com>
 <Za6h-tB7plgKje5r@casper.infradead.org> <CANn89iJDNdOpb6L6PkrAcbGcsx6_v4VD0v2XFY77g7tEnJEXXQ@mail.gmail.com>
 <4f78fea2-ced6-fc5a-c7f2-b33fcd226f06@huawei.com> <CANn89iKbyTRvWEE-3TyVVwTa=N2KsiV73-__2ASktt2hrauQ0g@mail.gmail.com>
 <d68f50a5-8d83-99ba-1a5a-7f119cd52029@huawei.com> <CANn89iJSxsx_6oTM+ggo90vacNM33e_DpgJJg1HQRfkdj3ewqg@mail.gmail.com>
 <531c536d-a7d1-2be5-10aa-8d6eb4dcb5c9@huawei.com>
In-Reply-To: <531c536d-a7d1-2be5-10aa-8d6eb4dcb5c9@huawei.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 25 Jan 2024 11:31:42 +0100
Message-ID: <CANn89iLThLScqJh0YSC0W3d2M6DrPzYeX3ViL7UM2BDiNbiWTA@mail.gmail.com>
Subject: Re: SECURITY PROBLEM: Any user can crash the kernel with TCP ZEROCOPY
To: "zhangpeng (AS)" <zhangpeng362@huawei.com>
Cc: Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	netdev@vger.kernel.org, akpm@linux-foundation.org, davem@davemloft.net, 
	dsahern@kernel.org, kuba@kernel.org, pabeni@redhat.com, arjunroy@google.com, 
	wangkefeng.wang@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 25, 2024 at 10:22=E2=80=AFAM zhangpeng (AS) <zhangpeng362@huawe=
i.com> wrote:
>

>
> This patch can fix this issue.
>
>

Great, I will submit this patch for review then, thanks a lot !

>
> If all the pages that need to be inserted by TCP zerocopy are
> page->mapping =3D=3D NULL, this solution could be used.

At least the patch looks sane for stable submission.

If we need to extend functionality, it can be done in future kernels.

