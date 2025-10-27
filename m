Return-Path: <linux-fsdevel+bounces-65795-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17E99C11458
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Oct 2025 20:52:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D07B1A22B1B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Oct 2025 19:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F11672E8DE2;
	Mon, 27 Oct 2025 19:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v1dlgCdz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD452DECB2
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Oct 2025 19:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761594693; cv=none; b=OThzBG5bV1Hp3v0Mnb0PSE74GwLiBLoS3H6KnAIBtQWyXZNWCmiOBThH0ghIKLJu1X4pvFr6+ynLnj2SQJxJhWnOZIlPHMC0ZJ9eobtIhwlAs/kMMSEXZ4DGCj5RUcyiySIN/cKB+rszqqD/NNaHOHfJnERPTGebwv8ZeMSo2Hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761594693; c=relaxed/simple;
	bh=LUw2mZCfH1yOBKTSy9rxXAh/jPqUNSJVBaTxVdNrEJg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MyFjc8ZKMLVQv58fRLQq6o80hJwHTaZmDLWibQuowsrYUe79ewl1Hjrx/Fp9Wor1u+EKVDadIRzgOPAhwTPDDYE6vIgpZy8eYrrn54e6JKKm7yI/CdHNMDnIY0W4GGqXChrHd7DQNZFKfAICGnr+k/fEv56GBa7U/YFbScJcL1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=v1dlgCdz; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4ecfafb92bcso14861cf.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Oct 2025 12:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761594690; x=1762199490; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LUw2mZCfH1yOBKTSy9rxXAh/jPqUNSJVBaTxVdNrEJg=;
        b=v1dlgCdzKU2VKZ0tcQYZU9PtfJ+TzPScfLGl+vxfqtwwDx0Fz+gyS9RMoEkK5uhdHK
         IrQDFjyE1qTvzqKbCEq0gE0exVZVi+yT5xqrRJglNH+CmQy3pcG9S+6eJ2TOZsm/zeIh
         XVg4KCVTqjx1cpxfvOgqZt38KgeyUYrobhQZ3Dy4ti+iYalFFqeezm1IsXOd1p3Lq1A5
         KAZ3xncqNFuv2fvLLofC16hE0gxVIdegvos6BuV5yYi5cD0r7t2KWIgM5bXT9yFueV3N
         3EP5N8TBda13BOaWSSA/3htFfO8sq5GMcprsQ2b/3rZ+7IZgbSi+GbFAIukNi1k0mYUJ
         7AbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761594690; x=1762199490;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LUw2mZCfH1yOBKTSy9rxXAh/jPqUNSJVBaTxVdNrEJg=;
        b=vycao3Gbavu6lFP9hly9c203pV/TXoIhvyDm+xGEH3mxb9fj5n1A3CXn8D/APgFFOa
         QNKVgidETOcOrZndxcJ7lCUzykMzfrBkYs8tG0yWz+HgNlipAabtSQzTxAu9Jti4DOGQ
         T0VTOrtW2x0p3+WuwnuxpPlBFNVKaO3IL1bgVIOqIc/iW/DpiPCCjJupUwqIcLdfCzvf
         wo93wcIVGLx7WtnA63zFGuMeNYysYMf08MlkqWls1drNVWJUoTGMt8NzziJMb4v4jzRJ
         O9GNdL56npMhqLTRGE3ev2G1ziZXo2Tc0cwBxBnZjNJLifmNQlZi9ZQIGVbk/UXgSnvE
         4OSA==
X-Forwarded-Encrypted: i=1; AJvYcCWKXhMxX6VhVc/P6Vbm2Mu+nXv12cFhThFOKnKAz/wJtood1/jRYwCVqCSva3V0T7ShDrP0f347nt57S6YK@vger.kernel.org
X-Gm-Message-State: AOJu0Yxgo8LLftEDNr4W9hKPsgfRVM4pTEutgJy3vq6DRFk4KqDPItFb
	GXs5xs2K8Mo02mC2kAq8KuWFi/frcYpxhyjonbZYdBBJQuqd9sKj1zo2rO2tRWn+UMj0NGsDj0K
	mT29xuPfwh0cCh6QGw2S3obXmLpXH217r/kfXdkwV
X-Gm-Gg: ASbGncvAg3XakqJQ9VlvJ0xRidcWVNEZqYDdt46fbn3Pwh04hIc90oQXPQVgA5zaJDS
	rnO9/Khzoz+btjRmHtK7mln5Kn0FWFmGvJhVFxvZW41BWIf9+O85QdBk7BXNf1c0yHK55dPEciA
	PtViSzEyTC1oRs9gpgKyDUpiI4MoAHcxRgHGI0ErVX+A1o/NKMHlGTOZ7wOozT0r0JFndViujR3
	mqFb5KR1dmd7jlbuuPdB+XdOLkwBkfDLqh5su2wYYgeaBibFT5MsWyn/7GUiR0Q06qzZQ==
X-Google-Smtp-Source: AGHT+IEmicxEYEPLgQn38b6v1mJfTIvyLMT/qtHkmyMNLHlEBQmcYJx6gF8JYoLZrM0kAWrtv1hez5d7WlrSFzFFVW4=
X-Received: by 2002:ac8:7fcb:0:b0:4e8:b04a:82e3 with SMTP id
 d75a77b69052e-4ed08f1af35mr1416621cf.10.1761594690047; Mon, 27 Oct 2025
 12:51:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251026203611.1608903-1-surenb@google.com> <aP8XMZ_DfJEvrNxL@infradead.org>
In-Reply-To: <aP8XMZ_DfJEvrNxL@infradead.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 27 Oct 2025 12:51:17 -0700
X-Gm-Features: AWmQ_blGO7QUW6nBgXPDBNUnzq3Ln5ah_SLow5ox4iXfcHmzA4G72ZsuhQ4Fq80
Message-ID: <CAJuCfpH1Nmnvmg--T2nYQ4r25pgJhDEo=2-GAXMjWaFU5vH7LQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/8] Guaranteed CMA
To: Christoph Hellwig <hch@infradead.org>
Cc: akpm@linux-foundation.org, david@redhat.com, lorenzo.stoakes@oracle.com, 
	Liam.Howlett@oracle.com, vbabka@suse.cz, alexandru.elisei@arm.com, 
	peterx@redhat.com, sj@kernel.org, rppt@kernel.org, mhocko@suse.com, 
	corbet@lwn.net, axboe@kernel.dk, viro@zeniv.linux.org.uk, brauner@kernel.org, 
	jack@suse.cz, willy@infradead.org, m.szyprowski@samsung.com, 
	robin.murphy@arm.com, hannes@cmpxchg.org, zhengqi.arch@bytedance.com, 
	shakeel.butt@linux.dev, axelrasmussen@google.com, yuanchu@google.com, 
	weixugc@google.com, minchan@kernel.org, linux-mm@kvack.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 26, 2025 at 11:54=E2=80=AFPM Christoph Hellwig <hch@infradead.o=
rg> wrote:
>
> Hi Sure,
>
> jsut as last time please don't build empires with abstractions that
> don't have a single user, and instead directly wire up your CMA variant.
> Which actually allows to much more easily review both this submission
> and any future MM changes touching it.

Hi Christoph,
I'm guessing you missed my reply to your comment in the previous
submission: https://lore.kernel.org/all/CAJuCfpFs5aKv8E96YC_pasNjH6=3DeukTu=
S2X8f=3DnBGiiuE0Nwhg@mail.gmail.com/
Please check it out and follow up here or on the original thread.
Thanks,
Suren.


>

