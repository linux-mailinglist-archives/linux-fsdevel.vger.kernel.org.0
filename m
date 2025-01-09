Return-Path: <linux-fsdevel+bounces-38735-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE5A7A076E4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jan 2025 14:14:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01AAC188A578
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jan 2025 13:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44114218E8E;
	Thu,  9 Jan 2025 13:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="VZgq4P8M"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6652218599
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Jan 2025 13:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736428438; cv=none; b=CJ2NnnaqOSmxfpBL4t31Z57huroGMlmK2CReLDRFrp64MtGjXEXb03LVY5VH49lxo2wIrd38I+gEIIfKY0QOVchzAYSY3AJr45RRdcr1qAxgChi7Cj+7xXAXTUsQxrfrzpXBF6KEM5ddz7dWEFMlQKrTDnRGiDcWPr27Q7w+ZKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736428438; c=relaxed/simple;
	bh=TwqBlKCo/5ENazwKpYfsYMgEwFOcQaBDDaRLL6b7F0Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JhulrUwCEPpbNJFchp2BTfJ+BvkGB3JxQud3D9GAoP1Y0uuXMgB4lHJRPM2e3Sexxvel5j6/zt9JALmWeuwvG1CSlI96PHu2nJqDkX02lxKZ2aVaswz1acuiqFOn8v4ONWqQMjDSery3dQ8qEG7fGc1iTJKYTiBxzYZStzmZc8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=VZgq4P8M; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4679eacf2c5so7614341cf.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Jan 2025 05:13:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1736428436; x=1737033236; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TwqBlKCo/5ENazwKpYfsYMgEwFOcQaBDDaRLL6b7F0Y=;
        b=VZgq4P8MzzCxCeL4uDMp4vnX5xbYFma5IQHgNdf2FJkHIxzJ8xIm2uIeSMLB4PWMfY
         uhkouWeV2ZKEoOTDKG5dkosJIe1wZBBTit3fTuTCROfG1bWQJuucu8dBTluU34PqdHad
         t8zXwi+XF4bOljc3v5otAc1pBORXchCox8+ws=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736428436; x=1737033236;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TwqBlKCo/5ENazwKpYfsYMgEwFOcQaBDDaRLL6b7F0Y=;
        b=LY5cKDxTdZSjVQ0xP2JWlXehmW0UnlSKtzjqsadecews6S3M0An+5n3XzvGVTgZYlD
         8sftxAEOKiKlAM7HvPT6n+akNgLb73Bq4LiF1gtE55aBiNQhOa9EMXi4/sdEelzVxI3u
         Uf3Z26LMpMUXu0xzgNajKGjd/gaN1NmSBlD9B9pTpYdlNJKHW3nnhdc++LTA+uV5Ic51
         CiaOnB+XNxYslkTYt67JH/GZz2Xx+0jX8nw5F5voBHbIaAp8DYRqbg9FyIICrvpDmzIr
         H5Bv+cv77Lc8Oc/JT51DHouDFL3gDHvHDP099eT6ysRGc6HK1mQCq2wgG8GfO6qAYf40
         0vrQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1/LiBFVWvMmvLbtuYcKQ4QRwReBOWmx6B8dw5T+pFsXSODRWzCnQb3BphsQssKcc3Wglrwvy72V3dsjXg@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/6FW+GutNoAAvrWG+1zAyjv2a6e84De/jaPaUHbBNbKymST2E
	NXlnDhIQ1+PhE7POMP4yrPfQXsoQOdR96OaY6SZrOcdvkQN9ofbYa2EBZ5UXZOeheb9yBNMgUz6
	wq35LPeofKxsTRVW9Ws2R4L9lybK9YxGnoQr8TQ==
X-Gm-Gg: ASbGncvc6shpU4HB/IggUGzc0cmsXPe74YLzQUGE0Zf8Axay99nie2CNoUkwb1M83Jj
	7Mvc2dq72q/tGd9xT41xQUM4lLKZwi8tNZ4eIuEk=
X-Google-Smtp-Source: AGHT+IFG9GJ09B4FJOZ+YFICJgZdpqOWtmk2iKM62UmCr1P+AGqCNFgZVmbiuXdIM4c1ctKzMWFGlhfolaoLVp2CoEQ=
X-Received: by 2002:ac8:5a48:0:b0:467:5712:a69a with SMTP id
 d75a77b69052e-46c7102fcb6mr96531341cf.29.1736428436036; Thu, 09 Jan 2025
 05:13:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0000000000003d5bc30617238b6d@google.com> <677ee31c.050a0220.25a300.01a2.GAE@google.com>
 <CAJfpeguhqz7dGeEc7H_xT6aCXR6e5ZPsTwWwe-oxamLaNkW6=g@mail.gmail.com>
In-Reply-To: <CAJfpeguhqz7dGeEc7H_xT6aCXR6e5ZPsTwWwe-oxamLaNkW6=g@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 9 Jan 2025 14:13:45 +0100
X-Gm-Features: AbW1kvavAsEfIUw5DyroXkQiIKTKKS9TDRTAdAT2RB5wVAD6b1Ef2WcW4M0Jvo4
Message-ID: <CAJfpegsJt0+oE1OJxEb9kPXA+rouTb4nU6QTA49=SmaZp+dksQ@mail.gmail.com>
Subject: Re: [syzbot] [overlayfs?] BUG: unable to handle kernel NULL pointer
 dereference in __lookup_slow (3)
To: syzbot <syzbot+94891a5155abdf6821b7@syzkaller.appspotmail.com>
Cc: aivazian.tigran@gmail.com, amir73il@gmail.com, andrew.kanner@gmail.com, 
	kovalev@altlinux.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	stable@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

#syz dup: BUG: unable to handle kernel NULL pointer dereference in
lookup_one_unlocked

