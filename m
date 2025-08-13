Return-Path: <linux-fsdevel+bounces-57779-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1DD4B252C1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 20:06:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65D3C6843FE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 18:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DAE929B78E;
	Wed, 13 Aug 2025 18:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h4Xjkrd2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD80244673
	for <linux-fsdevel@vger.kernel.org>; Wed, 13 Aug 2025 18:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755108336; cv=none; b=YuCR3OglBMabMOHLp3AmrRFCld4ItnsHgj6Jce2Tj3ZlsDTXRWFHFJDaikDaoA9DVLXn2rbguMBQ963KjfZreA2sHXfpqvSpq4U3yoUgnz+exBQP6vLp2nm4X8tbWFSnBT4J5xJQIQHXgilT91Uvjm7y+jme/CP2wUYp80IFlcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755108336; c=relaxed/simple;
	bh=hpwdI1GXxYshB2Egw6wt9ouw1pqSkp47NAgI5Oks8UQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tCEragsf679ish4lgvwzjCf8rkHh+wubmHEuw8OBIqRQpbNVk+4h/iXhUXWlHYv7clJfhNmsNYtebf/9/abf80VT26KMpoL6sEWESI1Uz2HGynACDNjFhBi1UQUO4qiJegMRoJw99phhEI9xzT6WtcxEP/2hrsN338JdyphC38s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h4Xjkrd2; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4b109c6532fso2038001cf.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Aug 2025 11:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755108333; x=1755713133; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zo0/EdoFuQq267CRXjEejcE5R6CMkHR6JRPqzQTDXBo=;
        b=h4Xjkrd2sOLwvdAcW15+7YFTmV8/0Pwv61+ZJgNcHsyMq/0XN2FtQj9eC2w4CJbjZK
         YxpBzugzPJ93SdF4VA08A3bP6Q9QHZi5mnNVc4DEzQ30EmQsknp093hfy07rxKK64hc7
         On4mOlQjJtWtM9cSOWzrNRxoh4vlXJN36janZbtC5/51F/Jv17OeksiUvP08qtkweDH7
         PpADSK//5nnAm8sPlF/3f2r7F+TvLfV+pTpgl9ulW98Pa8u2U4bTe2Z+f7+VyHYvdXlm
         KLP+aJ+H3V0kwPLkxPKyV8fGAsY5rmQwCLCnEt8poja7SFFcI6liHvnD5lTnHSfYkOn+
         zg/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755108333; x=1755713133;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zo0/EdoFuQq267CRXjEejcE5R6CMkHR6JRPqzQTDXBo=;
        b=BhkpQPv2ibFYlndq/zfqusegPxWU0Ot1tDAt4Ng+vn28/h0aM0m7k+L4zHELrYdavD
         84u1L5K8I9u9L0/r5uFydvDyvjnrg+ZYyGPhQ4KSCpaOYiRkIJnuQ1KZhblXrAfOHX6z
         d3uh/9wfvi2l6D0U50vkVpRvhaWLy/er8PEfWMYc8rrFX/MkKEBc34jdWaHFjxOjfMGc
         3d6P18r1ETihgAV6nerpyqF+gwuXqGCVvGSNCfIvgVmCsKiE2Re+/xVS/X/DNm/InoR8
         75PMuP0Z4p71Tf7WFPjj9OjZHycvTDU88VR2o7MS10G8Ji0Y03J+cmxP2MXDmVQrPEZk
         KmnA==
X-Forwarded-Encrypted: i=1; AJvYcCW0Sc7UEJSNm0ryhcBoFB5ktQlogBEE0nrkV4K8fNWwLMFqyJJXRADK92XvqoH3XXDDsVeTuenj/x3J+ow9@vger.kernel.org
X-Gm-Message-State: AOJu0Ywu3JtQw8nnZsUaVyi2SCPuv4M7Mp5OJull0ID2EBIwhEiuAphA
	OKfInirxnSvKUo/0tuelyR6dhBPl/V5/4t+p+MhwBYf/HWySo5em4BCQ915SvFcDgGO2SNloho5
	8iKMP3XMdjQdcVIE5QZdHyoJyvP+G6Is=
X-Gm-Gg: ASbGnct3/rBu7wyOvDm0S8orQyuG4i+D4JYXUE9ntpIoTEzqBhWN1cvdVtyDOtVzzFF
	tPUpvqioCmG2VGtKBcWZDp7RFmHYINFTRfVD+92Re6QVTY50GVivWwBtID/I8r5Eh0DH9EXS4a9
	7XmviIncNRn9b7JrcpqWY4liIOC4fuma7sPWBZylYLoAKhbcPclf/pHtiYLL+CDvhs638SMI0ND
	VOfkZc7
X-Google-Smtp-Source: AGHT+IFioJYdP3goiEcVuDCidsX1tiBw1B9JRMQ0cbSLdfFCP/NX0m+AzZQLGi8XEzRZriaj5MhJ5hfQ6mR7JQaPuMI=
X-Received: by 2002:ac8:5984:0:b0:4b0:f8ee:9355 with SMTP id
 d75a77b69052e-4b10aabb577mr1556851cf.30.1755108332771; Wed, 13 Aug 2025
 11:05:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250811204008.3269665-1-joannelkoong@gmail.com>
 <CAJnrk1ZLxmgGerHrjqeK-srL7RtRhiiwfvaOc75UBpRuvatcNw@mail.gmail.com>
 <CAJfpegs_BH6GFdKuAFbtt2Z6c0SGEVnQnqMX0or9Ps1cO3j+LA@mail.gmail.com>
 <20250812193842.GJ7942@frogsfrogsfrogs> <CAJnrk1Y27jYLxORfTaVWvMxH1h2-TrpxrexxxqawSK1rOzdrYg@mail.gmail.com>
 <CAJfpeguPhzQptvGmxzqxxJX8g5A1TNBiUp5UQDSwkhg-jU=Bpw@mail.gmail.com>
In-Reply-To: <CAJfpeguPhzQptvGmxzqxxJX8g5A1TNBiUp5UQDSwkhg-jU=Bpw@mail.gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 13 Aug 2025 11:05:22 -0700
X-Gm-Features: Ac12FXznXOdmiA_BMh5giLfsC2CJjBkjxgASHSVJbowjYSdr_jdmHH-tAWJgq6c
Message-ID: <CAJnrk1Y-_jy_cXBVW9VdYyf7njV9CdJ3=hsJG1DuLjsYB4wK+Q@mail.gmail.com>
Subject: Re: [PATCH] fuse: enable large folios (if writeback cache is unused)
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: "Darrick J. Wong" <djwong@kernel.org>, linux-fsdevel@vger.kernel.org, 
	jefflexu@linux.alibaba.com, bernd.schubert@fastmail.fm, willy@infradead.org, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 13, 2025 at 1:20=E2=80=AFAM Miklos Szeredi <miklos@szeredi.hu> =
wrote:
>
> On Wed, 13 Aug 2025 at 01:02, Joanne Koong <joannelkoong@gmail.com> wrote=
:
>
> > My understanding of strictlimit is that it's a way of preventing
> > non-trusted filesystems from dirtying too many pages too quickly and
> > thus taking up too much bandwidth. It imposes stricter / more
> > conservative limits on how many pages a filesystem can dirty before it
> > gets forcibly throttled (the bulk of the logic happens in
> > balance_dirty_pages()). This is needed for fuse because fuse servers
> > may be unprivileged and malicious or buggy. The feature was introduced
> > in commit 5a53748568f7 ("mm/page-writeback.c: add strictlimit
>
> Hmm, the commit message says that temp pages were causing the issues
> that strictlimit is solving.  So maybe now that temp pages are gone,
> strictlimit can also be removed?

That sounds good to me but I think it's a bit unclear / ambiguous what
the limit for unprivileged servers should be (eg whether it should be
more conservative than that of privileged servers).
I think there's an argument to be made that strictlimiting wouldn't
deter a motivated malicious user, they could start up hundreds of
servers and pollute RAM that way.

Maybe one option is to disable strictlimiting by default but provide a
sysctl that admins can set to enforce default strictlimiting on all
unprivileged fuse servers?

Thanks,
Joanne

>
> Thanks,
> Miklos

