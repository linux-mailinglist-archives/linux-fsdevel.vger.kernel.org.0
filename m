Return-Path: <linux-fsdevel+bounces-70612-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CC17CA1E55
	for <lists+linux-fsdevel@lfdr.de>; Thu, 04 Dec 2025 00:09:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D0A29300C0C8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Dec 2025 23:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B76D32AAA9;
	Wed,  3 Dec 2025 23:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OY4K88Uz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49611327BE6
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Dec 2025 23:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764803247; cv=none; b=e3dtn0ErZJyPS5ez2ZSHCP5YD5u9Jzwsip3VboxsYxLkLyqRBcMU6WiAQIPFmukS9HkNcVK/lUvTIQ66rwfG5hEnHmz4LTtEdf3KUNq+spb7+dJNfnYvCi12QaMkpd6+Sf0y9SN6SOnQ1dhVEFVLBJFj9CgrdnDwA7hno4Rfneo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764803247; c=relaxed/simple;
	bh=ARjBU24hBcskgb7NtDM1BJQCy1LB2oT4dOF6omBJasE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oLPYpnF2wIoOUp/yH645Oqr2UX5PhOOG22HXVZdr4RTw6U8i5sD0QLuZwzRa4mcRGmqU0upx+WcA333FqE96ELKCzMG78x7zuZ5Zko/01TOE7Wk/8IBWrwvwhGf6i1Ii6Vc+G4fuHB1igvcNH3pdS9r2DEKaItMr1OM0mX3dXaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OY4K88Uz; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4edaf8773c4so3577991cf.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Dec 2025 15:07:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764803244; x=1765408044; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ARjBU24hBcskgb7NtDM1BJQCy1LB2oT4dOF6omBJasE=;
        b=OY4K88UzxcvkONG26+JORFBUO2QDasetSxjwW5bSA0nRRXZ92JS7pMr2Q8g7aK9o3+
         MD51NDs34S6ZwVGm9X7VVRcTeRcFlQw1utEkK7ib3kCI2L5YclEtuIE0VsjbFysXXxwG
         LXhbeR2/iSxRjg7hgD7iTaCi6S/JgO6O4tETbrTcXL/DVxDgR1ZxfgqxVpcYaKtmh0VH
         ChgpRRHdlKeIyNeyraFTeVuF2QS87oOAIh0yhQHEmdXhZhnxuhRk2Kq5iv1bEiqUk3RZ
         o7jGyGzHZYnQ0huRw9/C1NR7JuLEXdfIi4W8s3rYn7c+HoJfgVhYv5PooXsc/rhVVRwq
         +KOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764803244; x=1765408044;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ARjBU24hBcskgb7NtDM1BJQCy1LB2oT4dOF6omBJasE=;
        b=B+CA9k4tjp202KGPqepSY7XJ0LppM4keYxRCoq0SlhTM14cDOzjTsVRdLbZj8dGZ43
         liCzNcdt/82Hd+3pS9TtDCI7s5uj/znkT2cDQRrcB+Ff0ZBw0NMEbPt4scrrTjxK/nv0
         5Ydd3f8s5ViuGITFGogqH7PeKITrxXzoLey7F2dHEYWS96vd1wKmo3u1UGJ4qfi9XXD8
         xhVEHEigKqCN5zAw+4IP3I/VdErKW7ZKJ2L0hcLrCwcp05fW0P+JODmNwqeGnL4J8CWU
         VYdqDIowHfneN6FV77h1xQoleBjpS0JtQDbRPwA/17Z17HQ1FBtdy0zrR20ALUtZ8WiV
         /aDw==
X-Forwarded-Encrypted: i=1; AJvYcCUBGFvtyXlyUlaepB9iZ+54f3jjxGk/tOksHZZJPMthLRh4tyxUSv4qgHuirqDE87UCZH3K+T7j4ugkRldY@vger.kernel.org
X-Gm-Message-State: AOJu0Yzqe+Zd/uQJ0seZAK+uPp4+Th0wBivHyMHFJt+vsgrBMET/wbfh
	652n9yM73DYFJfXyExOpv5GJZmIX7AXk5zlEKpuLCGcS0PhYqOlI4JwNFXMjdNf7dq+49DVc9sK
	J48MJJRDq/wid+2KvszVDvi/ruUL0fuY=
X-Gm-Gg: ASbGncuk0a6hr80gNGihqBSZpXrsomtuV6OwP8lyPB9A5ko0wMFjrv2WGyPdmybLGws
	b/Z1D/w6/yIoSg9tNk43KrjGUrtEr2JnwmcpgPx5gwPsIH/JcpzRi+cG5G2g27muhA078BRsOa6
	gLwzu5S0p3VxfaiFcANcoyZChMhrZfZvqqhdel4uPfLqenYj+e/sUbcUVKyNyDWTmA/NC2WhLvQ
	xzjGMfurpyiXFVjVemsKAOBB1mhr+yAODCoGoMmu698cpYJ/I9BGNvJocDgqPyw4RWVtFk=
X-Google-Smtp-Source: AGHT+IHeXlWltuajJrx5d5zaBmOs+3Uu+5HXat5Ce2MX4X5ZPI8oXVau0JJuFiDWUeYCCz9yKCjgfAUsfswBi07X5PE=
X-Received: by 2002:a05:622a:3cc:b0:4ee:1b0e:861a with SMTP id
 d75a77b69052e-4f017592726mr59846181cf.13.1764803243439; Wed, 03 Dec 2025
 15:07:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251203202839.819850-1-sashal@kernel.org>
In-Reply-To: <20251203202839.819850-1-sashal@kernel.org>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 3 Dec 2025 15:07:12 -0800
X-Gm-Features: AWmQ_bmqhNk5StWxxmTMDLwKPZbVHBIiLQfZnv8DcnlEQfJufs1LWeozSv_ldNk
Message-ID: <CAJnrk1aSf+bTiRE40BSM72y8p_0CZjeJ4AHF78QbxxPicmPMXw@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 6.18-6.6] iomap: adjust read range correctly for
 non-block-aligned positions
To: Sasha Levin <sashal@kernel.org>
Cc: patches@lists.linux.dev, stable@vger.kernel.org, 
	syzbot@syzkaller.appspotmail.com, Brian Foster <bfoster@redhat.com>, 
	Christoph Hellwig <hch@lst.de>, Christian Brauner <brauner@kernel.org>, linux-xfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 3, 2025 at 12:28=E2=80=AFPM Sasha Levin <sashal@kernel.org> wro=
te:
>
> From: Joanne Koong <joannelkoong@gmail.com>
>
> [ Upstream commit 7aa6bc3e8766990824f66ca76c19596ce10daf3e ]
>
> iomap_adjust_read_range() assumes that the position and length passed in
> are block-aligned. This is not always the case however, as shown in the
> syzbot generated case for erofs. This causes too many bytes to be
> skipped for uptodate blocks, which results in returning the incorrect
> position and length to read in. If all the blocks are uptodate, this
> underflows length and returns a position beyond the folio.
>
> Fix the calculation to also take into account the block offset when
> calculating how many bytes can be skipped for uptodate blocks.
>
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> Tested-by: syzbot@syzkaller.appspotmail.com
> Reviewed-by: Brian Foster <bfoster@redhat.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>
> LLM Generated explanations, may be completely bogus:
>
> Now I have all the information needed for a comprehensive analysis. Let
> me compile my findings.
>
> ---

I don't think any filesystems had repercussions from this. afaik only
inlined mappings are non-block-aligned and the underflow of length and
the overflow of position when added together offset each other when
determining how much to advance the iter for the next iteration. But I
have no objection to this being backported to stable. I think if this
gets backported, then we should also backport this one as well
(https://lore.kernel.org/linux-fsdevel/20251111193658.3495942-3-joannelkoon=
g@gmail.com/).

Thanks,
Joanne

