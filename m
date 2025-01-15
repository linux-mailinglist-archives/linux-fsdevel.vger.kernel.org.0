Return-Path: <linux-fsdevel+bounces-39296-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3C5CA124D1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 14:35:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DD4F188C48B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 13:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3567A2459AC;
	Wed, 15 Jan 2025 13:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M0WCYaQC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 202A82459A1
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Jan 2025 13:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736948120; cv=none; b=YU0322dp783dZZ2P0AcqrrLd5S87kuAIIjXkir2t/I/R68kNbX3L+NsgaUjIAVVU8RmYmqtS/48ymy683nLWToVt9wgDpIli/EFAA1gowO71vDYsJwnn9E2SNFviRJbi/VN1pt5C1I6zYdYbSlKZNniHHT2xzHWnGStt2VFSh44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736948120; c=relaxed/simple;
	bh=RIL+nwqLthbjx+M+EsQdph+tsv5s12wizfoAqsoo2lY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k8iHBac4lQrsEGTHmUZy5GmrReBhHSFM+0cIG3r7xt5AuIxpBwG79nsibPs1HjYh5gufMvuIuYzM1WoGSr80M3Uk+vKwfu16uV3eAqlxPZmzOLtilkBJB/iB3gnhUb7O48U/QzZ9u9VXyhwRy+oBQQ5BCgXGi3sDCDBpGSuQPPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M0WCYaQC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736948118;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EHMPieLiEBxInJQ6B0H0UcMOipXZzYAKvCo+eqZFwfU=;
	b=M0WCYaQCEKWDtcykVOJyD28jtJsKG4ZrWV442+zinW8zxn+3ObqkKdjv9Nq2JBHTTX273o
	7kIGSskESIMhccDwPC+1hExlu33hy9ZsBhCdTW2FjCQ7lH464NLJsYRbFjPnmpQWZmTiQh
	XXWJydouPAr31rzpYWcIzVueF4BNA88=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-401-6OKGSEvyNbmyoyTrW7HHVA-1; Wed, 15 Jan 2025 08:35:16 -0500
X-MC-Unique: 6OKGSEvyNbmyoyTrW7HHVA-1
X-Mimecast-MFC-AGG-ID: 6OKGSEvyNbmyoyTrW7HHVA
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-216430a88b0so133035515ad.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Jan 2025 05:35:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736948115; x=1737552915;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EHMPieLiEBxInJQ6B0H0UcMOipXZzYAKvCo+eqZFwfU=;
        b=HLzPN9UvNKWbq8prCZIFT6s7atqTDwtzHCGq4l34hHxwQ5W+Wii7UH1W6HczRHRCjp
         Fg/2pJ36MuGK3qXK7eoil8awQfD9F5fAL01Cy66XMZ4hwLmsCtmyerBUjKGQ9SEAE+UO
         mxCN8E8dTFQqLRVsTt91fiqqM54RMB3somGpVaAPhIyXJOyso3fDTDdJfR8avD+c6JDL
         Z1AH5Yd2Yy/3P/gWCDUuZE7cqOz8syPBV8EAg9KYM6BAZwRjjzAkgVzJB7JWw0jHQETY
         aNczGL/t2XmLbVrX6Ha/JUWS7WOJzf09kqtzuq5DowB9hJz3U8vlNXB1k+M76PQw4Q8a
         PK0g==
X-Forwarded-Encrypted: i=1; AJvYcCWHduardH84fWU4eYp6tYaRY47IzrXNdviBkLMu2ed7RolRsVUVCjG/9Ws6WhZYS9bdvP9otr7vz2TWB3j6@vger.kernel.org
X-Gm-Message-State: AOJu0YxwH7H62j/1qVgeiI27GZ1Rh7DNjTBPjbcaH+g5QEqCYz6kF58F
	yb9oxjWSfUJYpa8kDETP/np5Oj9V8V0H/Qwuca6THwIlgxlpA8hnNOwVyKTYsc2rx1hvDmdXVgb
	ObRdZLE/KQylRMCOmVPOhlwoPTwSrZdcLA8GDmwhWvFE/XJe657DL0ubW+fz5dTra+/devwM3TS
	cIL1imXDauyM9HD4CuCQwXhotHmVkflA+xbNsqng==
X-Gm-Gg: ASbGncsBKXPgRKRK8wId+ZfvwHe9m09AOO801psUNPIzWfLL6zlez4U6/WC1PZOfvH2
	mieEVRSkPdQhAJXzkygL/ojhkev7M+eC6WiUA
X-Received: by 2002:a17:902:e548:b0:216:30f9:93d4 with SMTP id d9443c01a7336-21a83f3706amr390736915ad.8.1736948115362;
        Wed, 15 Jan 2025 05:35:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE4uFvmvU7kjxrhOu/tKhko5zsquSsHGxstfr2wyI0IDTeSXaYwdT9BokTtob0w3UYMJQDUxkbCE6bgd9fA2Go=
X-Received: by 2002:a17:902:e548:b0:216:30f9:93d4 with SMTP id
 d9443c01a7336-21a83f3706amr390736605ad.8.1736948115070; Wed, 15 Jan 2025
 05:35:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250115094702.504610-1-hch@lst.de> <20250115094702.504610-9-hch@lst.de>
In-Reply-To: <20250115094702.504610-9-hch@lst.de>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Wed, 15 Jan 2025 14:35:03 +0100
X-Gm-Features: AbW1kvauTrK99eaFRcWITgoY8moGa8lcIr8CyUarTCKymnr2mM79lYdYrNNq1Dk
Message-ID: <CAHc6FU58eBO0i8er5+gK--eAMVHULCzHPnJ9H5oN12fr=AAnbg@mail.gmail.com>
Subject: Re: [PATCH 8/8] gfs2: use lockref_init for qd_lockref
To: Christoph Hellwig <hch@lst.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-erofs@lists.ozlabs.org, gfs2@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 15, 2025 at 10:56=E2=80=AFAM Christoph Hellwig <hch@lst.de> wro=
te:
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/gfs2/quota.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/fs/gfs2/quota.c b/fs/gfs2/quota.c
> index 72b48f6f5561..58bc5013ca49 100644
> --- a/fs/gfs2/quota.c
> +++ b/fs/gfs2/quota.c
> @@ -236,8 +236,7 @@ static struct gfs2_quota_data *qd_alloc(unsigned hash=
, struct gfs2_sbd *sdp, str
>                 return NULL;
>
>         qd->qd_sbd =3D sdp;
> -       qd->qd_lockref.count =3D 0;
> -       spin_lock_init(&qd->qd_lockref.lock);
> +       lockref_init(&qd->qd_lockref, 0);

Hmm, initializing count to 0 seems to be the odd case and it's fairly
simple to change gfs2 to work with an initial value of 1. I wonder if
lockref_init() should really have a count argument.

>         qd->qd_id =3D qid;
>         qd->qd_slot =3D -1;
>         INIT_LIST_HEAD(&qd->qd_lru);
> --
> 2.45.2

Thanks,
Andreas


