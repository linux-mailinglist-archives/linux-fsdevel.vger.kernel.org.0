Return-Path: <linux-fsdevel+bounces-26999-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3192F95D86B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 23:22:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3AABB2187A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 21:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 101AB1953B0;
	Fri, 23 Aug 2024 21:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UdJbfuoR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 106D680C02
	for <linux-fsdevel@vger.kernel.org>; Fri, 23 Aug 2024 21:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724448113; cv=none; b=V9wzMSSOePIu4+nwr7ZITExFotFqw6IkzeNVpGBWmHPyeohz4w36nCjRRWhsXwoCRX9O0fz0un9xjp5L/06yfwkb0WyVZq2AJgSLFT3isQcMYM3ZzoLi8C/8s2oA8i8n2fUrKjIHpWnNorZutDoiMzRwSuaVY9t4wE/LWFniF5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724448113; c=relaxed/simple;
	bh=JTRKGwob9D30G7IRxqoVfCY/SPj/3iVajSDHk9TUeZg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oRSsQ3r15g+7i2v7uTmEaOJSLkCj4rjlOyQEWuWaUF0vmOLt1/geVzigUIKOpbuC1S7VMsIRVsBFhBG0srAmhuH2R/lyqvj2kwW7Gw3BnFcRehsZHlb1vpF0pOTOcIbXgg/98IEg2f6mjcSS5qUcQ2o/LA3lTiFxrL3rBuxTAoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UdJbfuoR; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-44ff6dd158cso13698471cf.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 23 Aug 2024 14:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724448111; x=1725052911; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LkzrJMAAYDfytGl7GtbQCbveNALnmSvE4EuWdOiXrcQ=;
        b=UdJbfuoRMp6Ws8oiQdSbo0IFwHzni9Ci0E9JcVcaoYRSKTMDt85bcFo3vJc6dCUx1/
         mzWudUMZsxAlF6WDVjRCDgxEEA/yrjL6YApuDBoxhS9zrXEHRC9UDapgU+u32qxnmVSS
         dys5dpQxjAtAboorRv5RZqjMNwYlBxrysrbbHRYZOtd+LwymLpylhGc3DTT2xJOZ+VAh
         buFc02uqa547FzvwR4lQzv1UkW4V++6k/t5/u+XEdSbR5y1OvCfYJGA+EuTfZxEQDLSA
         7Z0ihwFaWmzNbj+mzBJ7pxoa/8sm257tban1qcIjE3pMGJ3fjkrYegtr4PaQLPpuEsnx
         rxqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724448111; x=1725052911;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LkzrJMAAYDfytGl7GtbQCbveNALnmSvE4EuWdOiXrcQ=;
        b=lfc8ABBOuLMlm0MFpAQDRI5I7Yd+ocnpjX+niEzt0n0b0ONggEMJ40BmZUhyq1nXNo
         qZbEYZuqX355oxZitNXXvI3oo5i90N8w3weDb/7TXaTnjkrc3li+cAaVao0JW0XbV68P
         b3uzT4p1HAoOR8tNacWiIYvMrSWmxQx0PqP9rQDOmU8c8FsWEF3ni0yAQggDF0VGl3Xk
         8Plfhh2/gqycETnDkLT1MqdWYezU6QD91zgn+a/Q9Ji3RghazrJRuGKZIoF0PK23mqUP
         qG/RcMyfoHvFT4uYhxNb2KUluk+cd7HhTHvPma/5rV2ww555QwOJKQkbrq4GOOXRlqET
         8FRg==
X-Forwarded-Encrypted: i=1; AJvYcCWhyM7REvtoQEEhg8TuEziKwlV+717vw8YutRZcSXcV/2bygACqEDrv7WnWH47ddq5Cpkphpq0coA9fZG/C@vger.kernel.org
X-Gm-Message-State: AOJu0YxnrpEajw8RXPE2X6/LTBMO10QKBA3pJAtTGGhGdCPRiXZs5qyi
	jwTxQjQuo87l5B9SKs1+UYZiExK6LqQoBHa5xE0hSfmp9uD+OJs5oPWakBR6bnMs7CnpTLchBZ6
	h+w2Qr6Uje0yfFzCj9c6mquhKAPY=
X-Google-Smtp-Source: AGHT+IHcePn7x1q4SGRu7bxb36GSfd/8/G4HT3YplntDhvy17v1ZxnqJvsxuTxn4UZro7fhqPMsisLyCSnMSP52sDt8=
X-Received: by 2002:a05:622a:4c13:b0:455:7f:d6e1 with SMTP id
 d75a77b69052e-45509c37559mr39091201cf.12.1724448110874; Fri, 23 Aug 2024
 14:21:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240823162730.521499-1-joannelkoong@gmail.com>
 <20240823162730.521499-6-joannelkoong@gmail.com> <20240823185953.GA2237731@perftesting>
In-Reply-To: <20240823185953.GA2237731@perftesting>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 23 Aug 2024 14:21:39 -0700
Message-ID: <CAJnrk1Z3fes=JFdaTd=MEiDxfg7byEmBCmvYTka1DTvjobU-sQ@mail.gmail.com>
Subject: Re: [PATCH v3 5/9] fuse: move initialization of fuse_file to
 fuse_writepages() instead of in callback
To: Josef Bacik <josef@toxicpanda.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, 
	bernd.schubert@fastmail.fm, jefflexu@linux.alibaba.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 23, 2024 at 11:59=E2=80=AFAM Josef Bacik <josef@toxicpanda.com>=
 wrote:
>
> On Fri, Aug 23, 2024 at 09:27:26AM -0700, Joanne Koong wrote:
> > Prior to this change, data->ff is checked and if not initialized then
> > initialized in the fuse_writepages_fill() callback, which gets called
> > for every dirty page in the address space mapping.
> >
> > This logic is better placed in the main fuse_writepages() caller where
> > data.ff is initialized before walking the dirty pages.
> >
> > No functional changes added.
> >
> > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
>
> You remove the out label in the previous patch, and then add it back here=
, you
> can probably merge the previous patch and this patch into one patch and i=
t would
> look fine, and reduce the churn a bit.  Thanks,

Gotcha. I'll merge the previous patch (4/9) with this one together in
the next version.

Thanks,
Joanne

>
> Josef

