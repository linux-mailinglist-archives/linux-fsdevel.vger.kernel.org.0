Return-Path: <linux-fsdevel+bounces-59361-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B260B38256
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Aug 2025 14:28:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2F5D1897036
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Aug 2025 12:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3509E304BBF;
	Wed, 27 Aug 2025 12:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="FwJYw79x"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5629020ADF8
	for <linux-fsdevel@vger.kernel.org>; Wed, 27 Aug 2025 12:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756297692; cv=none; b=X/qnbEopawnzanK5lguEbRz7BTodwHhyMO8JS4Pf4JduamCZ9pvTczn1vppHmVd5s7aBv/FrErCum+1p6KaGNPPrR81f64HzrdDF6WysSOb4UyDJ8zgjpCW9gCTFV9BlS2QpKWU+n1dDhYspDgr5kwZeleNF+dtUkyxQt4ip91I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756297692; c=relaxed/simple;
	bh=cciLdDNWk9AkjK+8HEt0e9tOL/3D8lMjgC3N+oRQBJ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AiI4mrjQ5dMoeWXc+bCnZFbW1cCLwlMwZSSDliiwDmjDyrM/J4BcZ2whvl7b9hynRio08vZA8W1XBF6RI2Q/0Id2IbgcLnBFAuLWK58NMCH0F6lYS+ALJfHpBLLemo0ilPrIz96pHAOTKs65E0xXTWmzBvxiP/Uv4FXai1yLgxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=FwJYw79x; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4b134aa13f5so81521921cf.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Aug 2025 05:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1756297689; x=1756902489; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cciLdDNWk9AkjK+8HEt0e9tOL/3D8lMjgC3N+oRQBJ4=;
        b=FwJYw79xLXbdZ8iStPGTmElOefELzvHDRO6bMAQtdejH8iZ3JcPVRkaTzFFLoP/vf2
         YDvrZjGn/HhvnZadGUadIDuvtX3xukXyflx9MkDBbHfHYbiWUcXInFusLuiiRTiqwLTk
         y3Syc4i7U8m+zW9faqX4w8GVkpJDebOqyKx/U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756297689; x=1756902489;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cciLdDNWk9AkjK+8HEt0e9tOL/3D8lMjgC3N+oRQBJ4=;
        b=J2kNONWzUCgiqY8yDCC14SFqzrGp+1eDDRspKSPtvE+Dx86M4xfD5AWG4WyQOA9SxD
         ay2T3XQ7eDS+21QVhdxUitRcaLcFf+xDH7jrWpI0SBb/A7Yu12Hv0jAAOZVa0UipJUqL
         Bs9tdTdPXXjewrW2brAFW1k50uoA4RtYtFvFt1cnPcEVQrrQp4g6eRN0DRYMmg63mK/K
         NBzUr5qb2sm5ysC/yTGb1ey9dJW5bpGsoF17NhpcK3VYYvcMJzq9aHpVMf2TUOc8q9+a
         c9KStKI66od6NTsue/jiL9oYKocxyHF2hFbUCvGthZX+AeqjngAV1MmCnT5NXfczdIiQ
         s0Lw==
X-Forwarded-Encrypted: i=1; AJvYcCUiigypRCgefg79pPDYNwfidgXt/DrIi7k3qyMGsBcQgpeakSetHcT+8MhTmkp9MKhJ3FZlZcL9GQW5o5eX@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/IOpfPLxZ41HKamP0AUdjSWeJ/qix+FZIE4F6rMREwXVfDyUO
	Y9LqDHdn0lmX3cFCgRkDsLdqzP8DJc9Y4YWAvVa6Cf0BM/sXoHboIIFxs6S5hwAjh1Tcla15k9B
	CyUahY9xKeXFfNwEg9dTFuIB9XbJpbDKMQluOTby6Xw==
X-Gm-Gg: ASbGncu0WhSFdmwDWCisgn64V5XsZdseQE+CE32RfWaAajpsmtkhOYxpq9Do5d7TaD4
	8+9gfdXim/2pxuxxcu/jmN+g2RRF+DaQg4gCFYpYf6SpCrpJzoDhtBbUM0x249NDJpFaNOXSmSE
	k1RDjdghBWSR2ErZsim7yxC97Ej13EhK6rf9/L/7ogrKgHxz2ywjMq503vDktAAWSOUFya9GNPy
	jTne8mTGA==
X-Google-Smtp-Source: AGHT+IHFYGUTAdyDScXL1Kg7O2sQVX4H/OlxaHU5YMXRscRKJZZrM7lhYrK13HVT2pm1fj6alcTWhr+LxU1+oYexl2c=
X-Received: by 2002:a05:622a:353:b0:4b0:b5ba:bb9 with SMTP id
 d75a77b69052e-4b2aab06870mr239441681cf.56.1756297688908; Wed, 27 Aug 2025
 05:28:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJnrk1acbc80OLZe9Pf7a-8HPRmkJhz=bZVRPOnJQWB78neVVg@mail.gmail.com>
 <tencent_35D325E7BA1BBB7B33559EE41B034B1A1B08@qq.com>
In-Reply-To: <tencent_35D325E7BA1BBB7B33559EE41B034B1A1B08@qq.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 27 Aug 2025 14:27:58 +0200
X-Gm-Features: Ac12FXzdFXIBx0ILGiBZiGUPGjukWoMB-_3YB01BpSNAgI64WyRfmrS4dRFP5wU
Message-ID: <CAJfpegvk_KT7cnGDYbfBwPjQ68a9MkGrOa0Sva6fqYe3o_68cA@mail.gmail.com>
Subject: Re: [PATCH V2] fuse: Block access to folio overlimit
To: Edward Adam Davis <eadavis@qq.com>
Cc: joannelkoong@gmail.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	syzbot+2d215d165f9354b9c4ea@syzkaller.appspotmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 27 Aug 2025 at 03:46, Edward Adam Davis <eadavis@qq.com> wrote:
>
> syz reported a slab-out-of-bounds Write in fuse_dev_do_write.
>
> When the number of bytes to be retrieved is truncated to the upper limit
> by fc->max_pages and there is an offset, the oob is triggered.
>
> Add a loop termination condition to prevent overruns.

Applied, thanks.

Miklos

