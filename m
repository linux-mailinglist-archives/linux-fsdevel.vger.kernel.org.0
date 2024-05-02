Return-Path: <linux-fsdevel+bounces-18520-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 72BBC8BA17B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 May 2024 22:17:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A112B22D03
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 May 2024 20:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B268F181305;
	Thu,  2 May 2024 20:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZSZPuzPu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE96040BE3
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 May 2024 20:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714681048; cv=none; b=Sqw/Q1GhYGRnqfXtcBHDtX8cnR573ww79vijacHiWb5S0uKzpKlN0CBdDcugf1jImMo3MNhzODAt8aqYyUYZQ69UNyfHGbt4Xxv6Uo/VXw3APwTzfZPR7ZcO2pwkiSHoqTckwLm2JhIk0Yv93ueBPL7kR8IeL2+NjYeuBjgDUpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714681048; c=relaxed/simple;
	bh=4RHxfi53wIEd6JqUPxfrXAoUpSxbk4fwPAifJPNDrhM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YkTX94VKMDJPE+PTWZm/HqMW4dXRpF8ok2/kuXOkJ96kDfN7EQ4VFS2f3wKmO8QSdAk4Hcl/EcEwoQK3lL9iEQJ93J3FuID9HIq5h3dzX7a012X62PeptIOk+MLseJQwANjYlBz5Hqbl5f+Ek17TkBi0jmMcmqljnxZy+TOj1lI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZSZPuzPu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714681045;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VbBqeOpD7Ka/zVtu/tJ94H3PCNLziAZYUNi8FEkKEko=;
	b=ZSZPuzPu7+9lpRfsfnQGHMhy81cGBOHak6CLQK6r4Xvb/oYyfsBqThvJIeyUIgxa4Ht+YF
	uEYqbCnmMf/cGOQRngFG0eLOLsN2VVasbDl1A9Uzocuz4YSVkAHJHoyEWmPooff/JQKodx
	7TtfBg7vLa3WvtHVZW3Jnl+y3yJ5PcY=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-130-TjMPeSB7O6Gulh8xCDwF4g-1; Thu, 02 May 2024 16:17:24 -0400
X-MC-Unique: TjMPeSB7O6Gulh8xCDwF4g-1
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1ec3279c43dso41795015ad.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 May 2024 13:17:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714681043; x=1715285843;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VbBqeOpD7Ka/zVtu/tJ94H3PCNLziAZYUNi8FEkKEko=;
        b=VwELGeLMfmHJyDlyjehd1wN01WhIYH76I0i6Gh5dn0+t2l+Pl6FvFcpGN6S2535cxR
         nnhMiCqaG3v0sRE5Me5dRPPoQe3qZQA1htTrx0xtfmGDuu6cXVbKwvOiU93Zd6hmHPY/
         igZSfLAxgBheej8prNqGJC3PhqqXmMyZtZw0p2r+Ra4lJYjUSafLupGB2WoLKJnUEOe1
         Ms10OiKruAipKtR0aXbGLO3pZaU7+onylULeCvlLGgwLMUUmKGFmcahiENNwH2ezi/d7
         H3vjhIK+GRhi0uqc57auAxtz2tBNPa73dIUJqWWfhoFn7EJiKJM8r4DRjNkiB7D7CEgF
         9vZw==
X-Gm-Message-State: AOJu0YyUhaawNmq7Kcmc2Dj+AlioPXC1K4kGsfK49n5jh/Up0CCRDqmL
	9gJATME8Ycp4Y4aYTuJlnWYPEdKGD1PxN/BKdzidFdrk6+evHNauIeMtIZUzVdEgNtGig/Ek2c7
	AEgkms7ll6G0CqJJhyDxvOI00IV6WXpDN5ukgGUwwWPf28CyPtGsZPeED2YyM+mpsr3SnqcP8E1
	W6c7fv/r0z9vIGe79qjmVdT8UJ0iuAWp4AldPCqQ==
X-Received: by 2002:a17:903:2283:b0:1ea:26bf:5989 with SMTP id b3-20020a170903228300b001ea26bf5989mr979543plh.1.1714681043207;
        Thu, 02 May 2024 13:17:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IES8pb2h5WMXry13XBJ+sx5LzQj27HizreXZd3yLm/TbuqBwvZVFnMvkbisY810Hd1pBjgIyDgiLaHbLeMJ1i4=
X-Received: by 2002:a17:903:2283:b0:1ea:26bf:5989 with SMTP id
 b3-20020a170903228300b001ea26bf5989mr979519plh.1.1714681042829; Thu, 02 May
 2024 13:17:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240403172400.1449213-1-willy@infradead.org>
In-Reply-To: <20240403172400.1449213-1-willy@infradead.org>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Thu, 2 May 2024 22:17:11 +0200
Message-ID: <CAHc6FU5-1Qm170Qc_DV1zEidd+hQEEGDa6K=tnmKjfOm=Hnb4Q@mail.gmail.com>
Subject: Re: [PATCH 0/4] More GFS2 folio conversions
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, gfs2@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Willy,

thanks a lot for yet another set of folio conversion patches.

On Wed, Apr 3, 2024 at 7:24=E2=80=AFPM Matthew Wilcox (Oracle)
<willy@infradead.org> wrote:
> Yet more gfs2 folio conversions.  As usual, compile tested only.
> The third patch is a bit more "interesting" than most.

The third patch looks fine to me, as does the first and fourth. Those
are the ones I've added so far.

The second one is problematic; I'll respond to that separately.

Thanks,
Andreas

> Matthew Wilcox (Oracle) (4):
>   gfs2: Convert gfs2_page_mkwrite() to use a folio
>   gfs2: Add a migrate_folio operation for journalled files
>   gfs2: Simplify gfs2_read_super
>   gfs2: Convert gfs2_aspace_writepage() to use a folio
>
>  fs/gfs2/aops.c       | 34 ++-----------------------
>  fs/gfs2/file.c       | 59 ++++++++++++++++++++++----------------------
>  fs/gfs2/meta_io.c    | 16 ++++++------
>  fs/gfs2/ops_fstype.c | 46 ++++++++++------------------------
>  4 files changed, 53 insertions(+), 102 deletions(-)
>
> --
> 2.43.0
>


