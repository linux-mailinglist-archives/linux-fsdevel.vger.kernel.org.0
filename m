Return-Path: <linux-fsdevel+bounces-30410-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 035F898ACED
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Sep 2024 21:29:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9158282EBA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Sep 2024 19:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C526919ABDC;
	Mon, 30 Sep 2024 19:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZKfUeF5I"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D9519ABB6
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Sep 2024 19:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727724443; cv=none; b=XgBu3ijAHqTqW+6tO93y7Wpspp0c7iqN+hwgh/WfXCNUo4uG3PQVFDQPd3s2A2EUDWyuA1wRaNra2B7eZ7RzbrwyJNavhvXuUBwj8sE/qE3bRjEBUtoL22VR02CQ4iAQJR1xTXXo1l3bCuNwKqxQPYWhhLGjJFTVKdg1KMtv+c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727724443; c=relaxed/simple;
	bh=ZSI71VfgsPW9jmTOsnIN09a8tp2Zltjs0l+l2+dvrM4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KawFNp/tFu8AC/OiALadKJMuwr2q+b8bzHwHTBHte4FNRvcKdFwf5fjIxx0qKgBx/JcIVHELmcNpBWmXAXdVE+2abPXgHp4CV2ZmbBZNMiJO9wEg5SCOlbtGkUdQECXmuIVzXOxTAG8q1v5EydX3gSvY4cgjYg3NCxOkeLMj2Fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZKfUeF5I; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-20b7463dd89so19124835ad.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Sep 2024 12:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727724441; x=1728329241; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZSI71VfgsPW9jmTOsnIN09a8tp2Zltjs0l+l2+dvrM4=;
        b=ZKfUeF5If8O63GfiLKPsVLhelurgjmhGAl4Sa3gHvztOCCpvsYqpVeVmp2eu0INfIQ
         fETaub7OAbUd6RoDNII4GtNGUcj/wGcgq25aPA0WkJ2TsrJWCN2fd5y/RGSHJZppNIGS
         xzsD3SUKSINGDgJM9t9K5rb2fIHMF98/u14aPLptW/TLiBCMdTeHs/txtrogo7qTqmfd
         4YjfAdRYuXiWRGlj49Bn2b+dUw4fQMVTQ7wpfT0BaQ6OBzowHcnDC3kOf+nKeNBHdOSo
         5DJjgT+QhpEZEZ9nskYuDxMHFNvCe9AzMRQSmMEDT79pIUipQb/ttsqKFi4KSRuITayc
         Xm2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727724441; x=1728329241;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZSI71VfgsPW9jmTOsnIN09a8tp2Zltjs0l+l2+dvrM4=;
        b=E0IJZc1yCtblhvs+A+ILl0BkyU4piX+azgBLRCGaADbGKGJN2aw+IudThR9Dstd8Ph
         dtm1MFCV/AWhUoK657Qz2HqXv7jqevs0cl+4GOfLdgjXdWqTbz3KrykyHZ16GEme9Slo
         PzeUnEKLFTyO982BM1JYFBCCDiipksckkIIrp7q7GPASvcaMYTaFvA+d0J9AcBWkFaCy
         l7dA6ZLG9MBts6XiQmExO+DWxGBfiDpaa6iv/E0QJeHv8ON4s2thumJfIp08XmcbOdFH
         aLvxI0oOkMSsOzQmwnfzZTKTc+2W4dqUVNERjAmMucs4dBKI6nK0pQRumrFAGKRSZUMP
         mACg==
X-Forwarded-Encrypted: i=1; AJvYcCUXxnIYBjnSUN2KN1cZI+LC75hy73cp3hqvOZtFSlrMiPk73BGUEeaOtDm87zE7VtDUGYU8nNFlXyR0EZXh@vger.kernel.org
X-Gm-Message-State: AOJu0YyPOkECrp4ym5HjMCdqt9UKNyaPJsn2IDn6pGgUB8IoEcHstMng
	H21orseo8C8wR4dA0y7KEFEFCHHhBn29/wuOb1wOYoDFeX6TOeIsmSTf7ttc
X-Google-Smtp-Source: AGHT+IE5LZEwGMZKkvbjZjxjC9ZU09pH/y4FRVHIQHiz8SiyRcXl3F0aiqKrl0A1iXG03jHtCG9HDQ==
X-Received: by 2002:a17:902:d490:b0:20b:93be:a2b5 with SMTP id d9443c01a7336-20b93bea53bmr40831425ad.32.1727724441157;
        Mon, 30 Sep 2024 12:27:21 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7e6db292b19sm6780357a12.17.2024.09.30.12.27.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 12:27:20 -0700 (PDT)
Message-ID: <88f034c09850004f6468f8b31a9fc31058d36981.camel@gmail.com>
Subject: Re: [PATCH] iov_iter: fix advancing slot in iter_folioq_get_pages()
From: Eduard Zingerman <eddyz87@gmail.com>
To: Omar Sandoval <osandov@osandov.com>, linux-fsdevel@vger.kernel.org, Al
 Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>
Cc: kernel-team@fb.com, v9fs@lists.linux.dev, David Howells
 <dhowells@redhat.com>,  Manu Bretelle <chantr4@gmail.com>, Leon Romanovsky
 <leon@kernel.org>
Date: Mon, 30 Sep 2024 12:27:15 -0700
In-Reply-To: <cbaf141ba6c0e2e209717d02746584072844841a.1727722269.git.osandov@fb.com>
References: 
	<cbaf141ba6c0e2e209717d02746584072844841a.1727722269.git.osandov@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-09-30 at 11:55 -0700, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
>=20
> iter_folioq_get_pages() decides to advance to the next folioq slot when
> it has reached the end of the current folio. However, it is checking
> offset, which is the beginning of the current part, instead of
> iov_offset, which is adjusted to the end of the current part, so it
> doesn't advance the slot when it's supposed to. As a result, on the next
> iteration, we'll use the same folio with an out-of-bounds offset and
> return an unrelated page.
>=20
> This manifested as various crashes and other failures in 9pfs in drgn's
> VM testing setup and BPF CI.
>=20
> Fixes: db0aa2e9566f ("mm: Define struct folio_queue and ITER_FOLIOQ to ha=
ndle a sequence of folios")
> Link: https://lore.kernel.org/linux-fsdevel/20240923183432.1876750-1-chan=
tr4@gmail.com/
> Tested-by: Manu Bretelle <chantr4@gmail.com>
> Signed-off-by: Omar Sandoval <osandov@fb.com>
> ---

Tried this on top of the following commit from net-fs-fixes branch:
e1b0d67c7ae0 ("9p: Don't revert the I/O iterator after reading")

The boot issue is gone, thank you!

Tested-by: Eduard Zingerman <eddyz87@gmail.com>

[...]


