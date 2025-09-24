Return-Path: <linux-fsdevel+bounces-62660-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E830B9B7A2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 20:26:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCD80620E93
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 18:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B693E3115A6;
	Wed, 24 Sep 2025 18:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NMFoieRM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D7CD238C23
	for <linux-fsdevel@vger.kernel.org>; Wed, 24 Sep 2025 18:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758738196; cv=none; b=i5FX+2p9kjVXP6F1dObeSj+WhNwTVuoWKH7Uhqzr6Q94nzhsJfLn0g20dEQ7zJO+YV3MPw1KXTPgzXuSMr91FeFpTV+LuePzA49Vmsk8kUiQke6Z1Mp4AepEBpR9r9nWwI1pbRxILOA/ZJTMeigMf/15MVqo3wQrUzI7zfZJ64Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758738196; c=relaxed/simple;
	bh=r/pO+CZyHHxpu+YW1zwr7CM/wT81oD3rByhrRLtBYgk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YB9CtNKhb6+NoMAydqljTVsP+a0zi6K1/mdJjXQMMzNJAllefecyFD1XJmKXWHH4/hZixgnEaYxzn6nCiqRGMPlAVDxqyGd9fnv6/p4tg3z4Wxh74jbnmtLRA+sJlPz3ahoso0hb36X5asnXRsR1jWWtPY8Mk0fGCIohr4fcml4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NMFoieRM; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4b3d3f6360cso1653711cf.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Sep 2025 11:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758738193; x=1759342993; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r/pO+CZyHHxpu+YW1zwr7CM/wT81oD3rByhrRLtBYgk=;
        b=NMFoieRMf70j0nmf7phGKZA8RP/pRvY15virdS7+eREcjXYe84y7Z70t2ZZDyj0XmO
         jxaZRgPnG84n/ZBFrjb0N+vyr2Ai50EYvZsQnPtRC/4GN8S6svv2/PvsVoFV6IaTKF99
         +34xIAjfPy12NT+EPAzgP+pDs/la+2Q9rsUjz/pid1pBokBAjJyKOF7pPUh07kZ9gsPe
         kGsJ3hmncjxHj3QlYu1j/09kKVJebS+VP/ftthqlDfrytccynMveH5lqD2thIWlpWogT
         NX/fxOV1WwlGjZSO1sDL0javZbtyLlzral7wG9bs4f8+fWy17Bf0kRnYwasZz6UNL59o
         QOag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758738193; x=1759342993;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r/pO+CZyHHxpu+YW1zwr7CM/wT81oD3rByhrRLtBYgk=;
        b=GSJDMHon0sVpEcpFKZVz/F8gzCg1AUaapOw93/nB0KUNZEcQQQz6TsY3esoAMTOHTC
         X4wBp4M4jnyYLWai7w+K+HuSl56Jc8aKR/tWVr/H5lh9+B+i3Yhm3UNR7DdLluWLce2P
         40vVzaTJHFr9lrzcyrU9O0zPJuFiErXERMZTfOWgj/hboy6rxJogSdpkUwAG0V3QBaih
         OJEii/rp6esugare+wFinPEtM9NGudNXvl5ueBo4I1MxHTe9V9lbs+yfK9ffVIJieMMs
         YQUTj0yki8tuYLAAyWtCLZDueBDxKnZvcVwXPwEfEY+ConCTcEnkgDYffB8jnr9RC02M
         4yTA==
X-Forwarded-Encrypted: i=1; AJvYcCWq84l6e9JK/Dntr0dtURyRseYmZjEjYcW7bugKHVpJvM0Sjx4dYWmcknHNx6wvAb6SPM7Z5wiRSgnWuySh@vger.kernel.org
X-Gm-Message-State: AOJu0Yzg9KHTDASSbsBpVPi4A9AO7jhqC1F3/0IWXs13StV1PkMmRsWA
	WNnNo8COH4Q1tgn5P75s1RxBB3ylYuCm0k7/nmYxbpm9GwqH4BDLkWsgCn+7V/MYD+XAjHHxIw0
	892jO994lRf9V/uIiNA/4N7Z3HGUKu54=
X-Gm-Gg: ASbGncsrv5BqCpmBQqiwPGsziKHdES4GlIXc2wFmKMCtzT8uZNVcFxwua4LDHaAeVwy
	iS6/q6WaYp3ZTnHEmnM5R9lP0R1HbNNjVSw6X7U8d8w7s+40XONfRdIc0GcPc74LiQ6RTxXxaie
	eE8JyDL24k73v/vnjfZn7uPAmDiIZTs2pwh1ceszMhwLd6qUITCcoBaNHRuHPFwHz4dwdjkmvRE
	mieNGFFte2iYalbf5Y/p9pz0THAykaxUpniBfpm
X-Google-Smtp-Source: AGHT+IFb2hnIa33/rJNkCrkGQy65hGr9PbmGe9myzP3aURdvVIcxUKeZQP66X+68mdhz4LTVXyo8AURYpcXobTiuOWo=
X-Received: by 2002:a05:622a:1188:b0:4d8:afdb:1277 with SMTP id
 d75a77b69052e-4da4b428a11mr10874201cf.38.1758738192675; Wed, 24 Sep 2025
 11:23:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250923002353.2961514-1-joannelkoong@gmail.com>
 <20250923002353.2961514-11-joannelkoong@gmail.com> <20250924002832.GN1587915@frogsfrogsfrogs>
In-Reply-To: <20250924002832.GN1587915@frogsfrogsfrogs>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 24 Sep 2025 11:23:02 -0700
X-Gm-Features: AS18NWCrgkvYY30dc-QDZpxRITAd1Rc6cqAqGzLtb2nb9C8hv8zV40q9qN2yU1Y
Message-ID: <CAJnrk1aLtP6fVCqfNTM+boFFnHQ4amB=614efyGS2vW2iauZ7Q@mail.gmail.com>
Subject: Re: [PATCH v4 10/15] iomap: add bias for async read requests
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: brauner@kernel.org, miklos@szeredi.hu, hch@infradead.org, 
	linux-block@vger.kernel.org, gfs2@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org, 
	linux-doc@vger.kernel.org, hsiangkao@linux.alibaba.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 23, 2025 at 5:28=E2=80=AFPM Darrick J. Wong <djwong@kernel.org>=
 wrote:
>
> On Mon, Sep 22, 2025 at 05:23:48PM -0700, Joanne Koong wrote:
> > Non-block-based filesystems will be using iomap read/readahead. If they
> > handle reading in ranges asynchronously and fulfill those read requests
> > on an ongoing basis (instead of all together at the end), then there is
> > the possibility that the read on the folio may be prematurely ended if
> > earlier async requests complete before the later ones have been issued.
> >
> > For example if there is a large folio and a readahead request for 16
> > pages in that folio, if doing readahead on those 16 pages is split into
> > 4 async requests and the first request is sent off and then completed
> > before we have sent off the second request, then when the first request
> > calls iomap_finish_folio_read(), ifs->read_bytes_pending would be 0,
> > which would end the read and unlock the folio prematurely.
> >
> > To mitigate this, a "bias" is added to ifs->read_bytes_pending before
> > the first range is forwarded to the caller and removed after the last
> > range has been forwarded.
> >
> > iomap writeback does this with their async requests as well to prevent
> > prematurely ending writeback.
>
> I'm still waiting for responses to the old draft of this patch in the v3
> thread.

Ahh, thanks for clarifying that. I'll go back to that thread and get
some more alignment.

Thanks,
Joanne
>
> --D

