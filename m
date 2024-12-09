Return-Path: <linux-fsdevel+bounces-36795-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0DBE9E9732
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2024 14:35:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EFCD1883434
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2024 13:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F4F71A238F;
	Mon,  9 Dec 2024 13:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="eav4163b"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED933597C
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Dec 2024 13:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733751090; cv=none; b=ARlOncYo1LHZF5r2sd600Ih6r6FEaAHpcmEJ7+G2YivgR02n2NSwkXVtvdr/Jt+b/rpNhh5Lxe3NIYM/p3okTXqT5IanKa6hHTFO7NGtvZq/A6x7PlA2pRqsB+LowmvLoLpy8BfzdfvXnFtPI9RxFa7aEplBiLNzuqR9/fYnnLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733751090; c=relaxed/simple;
	bh=ftTBkUoM2LcsGeAp9168BTi0yYIu6Ei50+DC8gomF3g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fO/PlmDBy0oJNAaXD1IUBF2TTMFV2sVPV95la1z/4tR/A1PUzoYKD6WcZgnND1muaZ4Qo+F9rlojWNbdh466IkrGpf22AGQR2wOanzDH3iDjvDsU65xVdpVYbG3wqhyWWuVJixqcXUE3+8WxcCHbEIxqzEH+IuXWLx+RsA+kcbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=eav4163b; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-aa69251292dso127053766b.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Dec 2024 05:31:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1733751085; x=1734355885; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ftTBkUoM2LcsGeAp9168BTi0yYIu6Ei50+DC8gomF3g=;
        b=eav4163bKLVCrPUzdJn2t6pP0npxxYcNFWQ7XABtjftU9OfbNpiJ7k4k2omG0DajVi
         v3vXyRwCsvblR8EyhnRHYJtIWVxageQiA3dTIp4R53NAqeNI/9ZU02OqCiw9ax31t5pM
         KkzOHe/gBvOVcUiAaViftb9Wbj9yuU4LpykbyKrveKQcsmxhZafVPgcg0Scs+ZxCNSeS
         Ski9zY/rTdN/SCBYG1Upoz9gb8jzL802cQmEGHH7jocRpIC2MR1FKufjXigVdovmb6EB
         gNScHhiCnQdKP/juqshHE74bwNpunczm2W4sjy6HRSJX/Ebv8OOBdog1NmxyYckRENfz
         u7NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733751085; x=1734355885;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ftTBkUoM2LcsGeAp9168BTi0yYIu6Ei50+DC8gomF3g=;
        b=UKKADKmJd+JljRMhb7ojM5ZdpVr1+RpvWf0u0CSLpUy15d+E7Kw3w1QoJC/Fn0EpHR
         GBsmzxN63P8ZNhA6T7+5tvNG8HNzHUEKgXOt5C2WVHmoMmIysFDV2bWLnAI/3zjlfxtj
         Rnkf2Uu9jvJRhcIZEfGS72EO6R5Dz6rEh24lPu9hUlWyIQIDc2Ox64AFBFsFPapPwXFQ
         FrRRXOmLZFNOUPJt0d+O+sK95OgiI7BZ8Shi01JvZj6113GsOAP9wVNKeZo5+9sJk0jH
         LDJkT2m0t0hdTRGERCUhQCPuWlrvFHUBZxMEFe+vePK9s2zD0jh4HmeAkzkD3GvJEzMB
         3hsg==
X-Forwarded-Encrypted: i=1; AJvYcCVhN+h69xmQpt5MaY1VUOaRKs/hhWZNLQittTDXVm7MO5wEYspePXXHYs/LJU/oXd1972qC/aDo5KgXYlKm@vger.kernel.org
X-Gm-Message-State: AOJu0YxkXwmtDUSGk+mGLhjM7b5b4rKzV6I7J8CcokdyGR/vv9HhWvin
	k4lm0X1HULILHL1mLInco+AM7Ze07VHqLtefz2wHV4sWr7CIPkpCm7FG7K5qQt10+geUPRwLWU/
	V+Hpg8863SPkNwIf3VTE3BiCIP+jJVjSn9r9uUQ==
X-Gm-Gg: ASbGncvdnVBgWY/zotrcMkF/OI0G9pgPdgXSOLRomP5UqcCGKE94F9L9T6LIsOb4i3x
	RlRB4bkhIrXpjpvXzCegNoHwtSlUMLMU5P9D9GWRMoDuuQC9RIS3eQMhV3MRl
X-Google-Smtp-Source: AGHT+IEmztFz48a0t6/WSmXctJ2wrGWImd2oFKYKo2f4N5KU2N5Ux6YRxIOaj/ZsHQRzkCXMX15Wbqnx3MAscmomOG4=
X-Received: by 2002:a17:907:9518:b0:aa6:7662:c56e with SMTP id
 a640c23a62f3a-aa67662d783mr557411466b.55.1733751085028; Mon, 09 Dec 2024
 05:31:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKPOu+_4m80thNy5_fvROoxBm689YtA0dZ-=gcmkzwYSY4syqw@mail.gmail.com>
 <3990750.1732884087@warthog.procyon.org.uk> <CAKPOu+96b4nx3iHaH6Mkf2GyJ-dr0i5o=hfFVDs--gWkN7aiDQ@mail.gmail.com>
 <CAKPOu+9xvH4JfGqE=TSOpRry7zCRHx+51GtOHKbHTn9gHAU+VA@mail.gmail.com>
 <CAKPOu+_OamJ-0wsJB3GOYu5v76ZwFr+N2L92dYH6NLBzzhDfOQ@mail.gmail.com>
 <1995560.1733519609@warthog.procyon.org.uk> <CAKPOu+8a6EW_Ao65+aK-0ougWEzy_0yuwf3Dit89LuU8vEsJ2Q@mail.gmail.com>
 <CAKPOu+-h2B0mw0k_XiHJ1u69draDLTLqJhRmr3ksk2-ozzXiTg@mail.gmail.com> <2117977.1733750054@warthog.procyon.org.uk>
In-Reply-To: <2117977.1733750054@warthog.procyon.org.uk>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Mon, 9 Dec 2024 14:31:14 +0100
Message-ID: <CAKPOu+-Bpds7-Ocb-tBMs1==YzVhhx01+FaiokiGR3A-W9t_gQ@mail.gmail.com>
Subject: Re: [PATCH] netfs: Fix ceph copy to cache on write-begin
To: David Howells <dhowells@redhat.com>
Cc: Jeff Layton <jlayton@kernel.org>, netfs@lists.linux.dev, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 9, 2024 at 2:14=E2=80=AFPM David Howells <dhowells@redhat.com> =
wrote:
> Could you try this?

No change, still hangs immediately on the first try.

