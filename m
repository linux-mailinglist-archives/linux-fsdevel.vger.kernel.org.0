Return-Path: <linux-fsdevel+bounces-34758-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DFFA99C8875
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2024 12:09:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 867B5B37792
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2024 10:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0D2218991E;
	Thu, 14 Nov 2024 10:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H+CAJaQU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F2291F818B
	for <linux-fsdevel@vger.kernel.org>; Thu, 14 Nov 2024 10:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731580907; cv=none; b=FHnWyMIdSgHxae/0EZ0oe9kcGg0KrNo4QdT9ct9qI10JIUU8E+teWn4PSvpxwKQMj2fapp1/25gqtVdxzN2ap4PP39M42YNfRADGIQDYeDT/qIeawGuq+SzJ9zBFHUqRMjH70lby+u5uoLrCizxI+qSeMbaReGzl8vwzYPlre10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731580907; c=relaxed/simple;
	bh=9R6KqGQWB/QtAMdDlwbVD0gupHiDeJpaVWqmK4mNQgM=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iG3gHo7JIs5fUI/0ZYl+3KQsdTzxqUPw864FBNcbRAGzwDX2+dUy4PI/MroXcHFWq5MHXpS2SSibNeHGk/udWgGLeXWM/v/ySuojWVcpyn6B1GyhW1tG3G9vLVrmQPqlLVNwpbQbla2NJwtSxY3A/43MHMfQa2bl+qOt3reIfwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H+CAJaQU; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-720c286bcd6so355866b3a.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 14 Nov 2024 02:41:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731580905; x=1732185705; darn=vger.kernel.org;
        h=mime-version:user-agent:references:in-reply-to:subject:cc:to:from
         :message-id:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wcRtZRAtklIfbX452cq3UuL4sVx5Lq8L0ye2jnnDq/U=;
        b=H+CAJaQUWZdiEqM4PNsz7hmL6+mWflLkJ9Kn5ecsLpVsEIPUd4T8aHf6nsoAJJxT6W
         E4T4TcLozNZvi1gtLNTX0rZ8vstJQuH/wcV1nGvttkY0F/XqQUnjEepDbEL1vqIliMgw
         OKJUiHisSllKavwhSejLLR22/PydVPVqzbKhJ4PXk2PnBoWqK2Ss8GMbopkpceTxBEe+
         j4a3Koy34UhjTdZqvv0Do1wsJQV1vElLJaI1SbZE4HNFB/BCAHALeZDGcE6zKj60+/ua
         WuXzgfr5r4wdB8v1Zps307TFe8Q9Kg2KwpryZGTjSyHDvnw6MMXHjy3iJWq1F0lPyK8b
         t0Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731580905; x=1732185705;
        h=mime-version:user-agent:references:in-reply-to:subject:cc:to:from
         :message-id:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wcRtZRAtklIfbX452cq3UuL4sVx5Lq8L0ye2jnnDq/U=;
        b=CeyA2k0JIBvWH4aafcJb6UYgV3vpPOBup/HNeTxq3FaWuPn++W7RwoVFlUZB+UDQ2g
         teD8Sx2pIBZzPKOAnTm43rkPPlmJQSNEeWEsjEI0S6q3QSAk96mS1DLoQzP85C5Tg7wr
         z1QJCCWQxtcZdJok4iy+kKSFLhBMhLv0+hTzu/RHVpKRthsAzgsiwp3D6hnaLloiVluF
         GnBchOv1gP7jgaTRKfOFzAxgoXv7Peoh9y/4euwhoC6BoNBEt9yfHbNtTRN0dylG3IZo
         7Rz4b6LgWSZPuOudAHizV0waUzoa3Q0Za7Ar9lGDeqdIteYRoctcTRpL8FKycgGM6ofr
         SW1g==
X-Forwarded-Encrypted: i=1; AJvYcCURFg4gWcQzzL+6RWyHKsxnsg78uVUP7RKu37+SuzsCmf1mlRaxn+7W5Ow4dgdZPktrwNp0dG1iUIIObftJ@vger.kernel.org
X-Gm-Message-State: AOJu0YxOoF4nka3z6jCUxOQYjhwjywcnm5gDlCcnvSsElUgrT/otSzfp
	KFigMaiO4Ae6pvi5O6Vo/S/ITaMueOlmL2aHyX4PQBOBZ1jJPr/p
X-Google-Smtp-Source: AGHT+IETO0T5CdPmBixIh/jL5AuC+2KzjP5/EEdAOtq5cp8iWXa+uieiimcZX5nA4JZQrpMEgBBSCg==
X-Received: by 2002:a17:90b:6c7:b0:2e0:5748:6ea1 with SMTP id 98e67ed59e1d1-2e9b1797ba9mr29895862a91.37.1731580905114;
        Thu, 14 Nov 2024 02:41:45 -0800 (PST)
Received: from mars.local.gmail.com (221x241x217x81.ap221.ftth.ucom.ne.jp. [221.241.217.81])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ea06f9c6b1sm885062a91.32.2024.11.14.02.41.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 02:41:44 -0800 (PST)
Date: Thu, 14 Nov 2024 19:41:39 +0900
Message-ID: <m2frnuf670.wl-thehajime@gmail.com>
From: Hajime Tazaki <thehajime@gmail.com>
To: gerg@linux-m68k.org
Cc: geert@linux-m68k.org,
	johannes@sipsolutions.net,
	linux-um@lists.infradead.org,
	ricarkol@google.com,
	Liam.Howlett@oracle.com,
	ebiederm@xmission.com,
	kees@kernel.org,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	dalias@libc.org
Subject: Re: [RFC PATCH v2 02/13] x86/um: nommu: elf loader for fdpic
In-Reply-To: <7290bc34-d398-4ea1-8e52-193f1021e114@linux-m68k.org>
References: <cover.1731290567.git.thehajime@gmail.com>
	<ea2a3fb86915664d54ba174e043046f684e7cf8c.1731290567.git.thehajime@gmail.com>
	<CAMuHMdU+Lyj3C-P3kQMd6WfyjBY+YXZSx3Vv6C2y9k__pK45vg@mail.gmail.com>
	<m2pln0f6mm.wl-thehajime@gmail.com>
	<CAMuHMdXC0BbiOjWsiN1Mg8Jkm03_H6_-fERSnFEB2pkW_VWmaA@mail.gmail.com>
	<8bbfe73f7f1ef9f1a4674d963d1c4e8181f33341.camel@sipsolutions.net>
	<f262fb8364037899322b63906b525b13dc4546c2.camel@sipsolutions.net>
	<CAMuHMdVRB46fyFKjZn3Zw2bb8_mqZasqh-J7vse-GQkA3_OQDg@mail.gmail.com>
	<m2o72jff2a.wl-thehajime@gmail.com>
	<CAMuHMdXKAz0bxBGrbbHD6haeCbhYh=pCb4stox1fOifCvyCwpw@mail.gmail.com>
	<m2msi2g15z.wl-thehajime@gmail.com>
	<7290bc34-d398-4ea1-8e52-193f1021e114@linux-m68k.org>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/26.3 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII


Hello Greg,

On Thu, 14 Nov 2024 10:40:03 +0900,
Greg Ungerer wrote:

> I was only interested in the ability to run ELF based static/PIE binaries
> when I did 782f4c5c44e7d99d ("m68knommu: allow elf_fdpic loader to be selected").
> I did the same thing for RISC-V in commit 9549fb354ef1 ("riscv: support the
> elf-fdpic binfmt loader"), limiting it to !MMU configurations only.
> 
> There is no need for binfmt_fdpic in MMU configurations if all you want to
> do is run ELF PIE binaries. The normal binfmt_elf loader can load and run
> those already.

Yes, my motivation to use this loader is run elf PIE binaries under
!MMU environment.

-- Hajime

