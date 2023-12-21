Return-Path: <linux-fsdevel+bounces-6688-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B78281B60E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Dec 2023 13:38:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC7D828280C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Dec 2023 12:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4A2C6EB4F;
	Thu, 21 Dec 2023 12:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y/4hUsMV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63D64595A
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Dec 2023 12:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703162299;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cfOAS/Cfvy73NfYNUGoNrYx/8Pw3cjNZcgnpRXHhVXg=;
	b=Y/4hUsMVm09qwOBnvvT9v9i3SSjuIcPKm+CdF7fTrkVZpj324/9id1xef4Yg2VfLVp3QLv
	bO1Pww1ChsvyhQX/vBURd4/W/CcNVXcmAlaako5XII1788JKBK3ncQtC8LO9Hob6fNPD+4
	9C6Xw2re7VbazB/Vq/3ZFuts5L0D/WY=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-155-UeRKl7mpN2abuOFJDsrxlQ-1; Thu, 21 Dec 2023 07:38:17 -0500
X-MC-Unique: UeRKl7mpN2abuOFJDsrxlQ-1
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1d3e5d18308so7636225ad.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Dec 2023 04:38:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703162296; x=1703767096;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cfOAS/Cfvy73NfYNUGoNrYx/8Pw3cjNZcgnpRXHhVXg=;
        b=XHDgBP7nEYMcNka5pe50vHBLSaDxSZ9h1fjmM+/pQ5T7/5zN54xeATafIftzvvuMqf
         79k/ldStnUulOA5+ktdwLgDkbPOAOLMMV9Arx89lLBGRiC9edG/FWH3hCA+I6sjwzBhE
         i2qUhCqDJoeZ5m23j4tjI5cqr4bonbTGzQd59W4LVVzkPfh8a7dj0W4WoWgYhEoiRyjk
         XJH4XlHvC0IfSNKs2/OYLyFJm27U6JwtZQApEs9kSs1S3R55ljfjF843Xi1YFP/cSz8v
         Ukrc88rvZt3CS4sBPpH1meTNVoTg2DuQuGraUMoScbMHuHDw0y2ye7wbakrc3WgLHQn1
         dZng==
X-Gm-Message-State: AOJu0YwgXp3FlTubrp6dzmcaBSnpTAEQ4dbL7PQYjG9Iq2FpLy7zaaRz
	Ky7YTpz4R/5PqkvYHI1xMMbHAJvEG6769Hiezb+xX3OegjViQjZ9LgpYXPr8Dgtuz8Gs1u6L8jW
	yjctAehBSTAAY5OP9bXozAmX8ISwgVWMZ5eGeNz6BKQ==
X-Received: by 2002:a17:902:e54e:b0:1d0:b42f:e41b with SMTP id n14-20020a170902e54e00b001d0b42fe41bmr24446210plf.64.1703162296759;
        Thu, 21 Dec 2023 04:38:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEcxmSGTi9Cen2vOZLOtaY1q0MkvT4Sc2+5Jcq+fjVEuZ63u18UmONPJhGdPt3NhdWBJzlbTeYFpqiaqcEO7EY=
X-Received: by 2002:a17:902:e54e:b0:1d0:b42f:e41b with SMTP id
 n14-20020a170902e54e00b001d0b42fe41bmr24446200plf.64.1703162296493; Thu, 21
 Dec 2023 04:38:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231206195807.764344-1-willy@infradead.org> <ZYMQx2070yb9Vkgs@casper.infradead.org>
In-Reply-To: <ZYMQx2070yb9Vkgs@casper.infradead.org>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Thu, 21 Dec 2023 13:38:05 +0100
Message-ID: <CAHc6FU5Wn8NYn96SXyeWq5ifHnO9GChqcbDX5x2ebQaKKfvJYg@mail.gmail.com>
Subject: Re: [PATCH] gfs2: Remove use of error flag in journal reads
To: Matthew Wilcox <willy@infradead.org>
Cc: gfs2@lists.linux.dev, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 20, 2023 at 5:05=E2=80=AFPM Matthew Wilcox <willy@infradead.org=
> wrote:
> On Wed, Dec 06, 2023 at 07:58:06PM +0000, Matthew Wilcox (Oracle) wrote:
> > Conventionally we use the uptodate bit to signal whether a read
> > encountered an error or not.  Use folio_end_read() to set the uptodate
> > bit on success.  Also use filemap_set_wb_err() to communicate the errno
> > instead of the more heavy-weight mapping_set_error().
>
> Ping?

Pushed to for-next now. Thanks for the patch and reminder.

Andreas


