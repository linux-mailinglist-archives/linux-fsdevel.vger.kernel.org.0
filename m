Return-Path: <linux-fsdevel+bounces-44347-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D4B3A67B88
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 19:03:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54CC719C464B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 18:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC4C92139DB;
	Tue, 18 Mar 2025 18:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZAD/NeBW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D2A1ADC90
	for <linux-fsdevel@vger.kernel.org>; Tue, 18 Mar 2025 18:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742320946; cv=none; b=hfKL41Da43u6ehCslygsO7Ki5G9cCC0ipjPhte/lj4Bwb/t/h5cLHAsW9LdpeFXs+6SlmlKiBNSM+WXpSCbOL45NRjKeBvJIhBNRtcGHVfyUc2723JvHbdL7yeV4waxs/wm0h3cCZotgv66EZA9OoATLvNgbM3Epkgry/Ctdp+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742320946; c=relaxed/simple;
	bh=BjcYVEKKpUzz2FsrjqEYaGy5upsDyp7dXMD/jUWpPEw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PDPwDwf8KWyptVJCKehz5N6CrOr7Jm0raQ82tmZz3BPj5ch07PgTjXTXNHJTDBXFuuye9nYcuicmzEXNt723H25Nn9bfW/cUQwrF1kuLjajSMvjijFdxGTUz0Jq/nBJxxyq8QewTotb4njCjbGsMvZrw0yWpFYiWpRdht4ggvg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZAD/NeBW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742320943;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qlRKauU87C/lC5/9zx115U/gNR/bBnOd+yZH1lsjrlY=;
	b=ZAD/NeBWXRLqqr+ZtTbPJIEfkmuf8YO6XpSR6wKXbivr/jUtKk85Hmaj3YCm+I2M8aUUMa
	Q+1ZnyoEn48OIK5pFPDzM/AuI6YdNhJMtUe8dYRRhxjFZQL2plNF5UzP4YgDYvOcsOGS4P
	rMMdT+dmZ6otfto3CTs2Is04WWi9BHU=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-218-fPASn-btOoyG8R2AHX-J2w-1; Tue, 18 Mar 2025 14:02:21 -0400
X-MC-Unique: fPASn-btOoyG8R2AHX-J2w-1
X-Mimecast-MFC-AGG-ID: fPASn-btOoyG8R2AHX-J2w_1742320941
Received: by mail-yb1-f200.google.com with SMTP id 3f1490d57ef6-e6373b4cbcfso9013444276.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Mar 2025 11:02:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742320941; x=1742925741;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qlRKauU87C/lC5/9zx115U/gNR/bBnOd+yZH1lsjrlY=;
        b=mnpH3uCYU0TSHrUMMBybS05PAfV+jKWqxKO72Ny0orAtFspphsCRH440s5q01ks4tV
         mFmZsgWEUZ5Pp4HtCTaaO8AaOwewgzwlOEbfo3SKuVbNAaK9KhMDofzWXlqr9KqB0p/t
         xAFa7QnJT8MxtuX017SWY/0bgBLazThvjw3CXehkhdb6xNBa4adp2IXO+MliXeU4Onxt
         5/mZYsVX3vSPVQJ6e3uboSE8a37as0EDGKGfAIQkWPyxSvLPfX8zLf/sukqx79ZJippg
         lDuLIvrIRMtI/MZ2QirkCY1mcbxglMB9o4WyZz9hLM/QWZqmcEF/oEXIwIO4nRCiXi+t
         TYvA==
X-Forwarded-Encrypted: i=1; AJvYcCVtvCJZwF36URnbmEJXkCEQ4TFL3YWfOG6jSEpa/z6DlhsyzEZkFM15Q7dJw56mJclOW5zSoj+j5KGPiEWO@vger.kernel.org
X-Gm-Message-State: AOJu0YzR5+5UbH8JuFTAFApoLOVB+5wYbDNn3WeZKgxdTmjjwf6Ermqo
	Fa1n2CnDrLJ9sBdkwATYmG8wdmltVtW/FWcDVY4RBZ/QMZzzLlZNM0q1RE/3W5FP39d91pFHNa9
	EX3XUpGaQAZbTtLL9B5zUJ6ulme896CYVeesdpJShgIDMRDxKJc7HmXmg0FaKUsh4nBornx1gW1
	aaOK3339UCp/ltYYV5hzENMhxERZIAuk+s/UsqQHQ/GdQlX8fS
X-Gm-Gg: ASbGncvssd/qkybxUoTWkng3v6yesFXVTCWljrMYYxdc/WYgRJ4dTEuVpCk9P3bpifB
	UDxIllzc1YVhu/oY9rih3rowqBCi7QahqhJVz0jFZF/Ddh2fc1h6JXMJf82lq27PbqkSqjqGmK5
	emEP6QE7w54A==
X-Received: by 2002:a05:6902:230a:b0:e60:a2e2:9359 with SMTP id 3f1490d57ef6-e6678ef846fmr311887276.3.1742320939556;
        Tue, 18 Mar 2025 11:02:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHf71qxvLWsxGimRT+uGjSq1Z0p53QdA8cl8alstSBpREqHbGhALnJb5uq3wRaeZHh2Md4lHGIZ8rqQbUzgZjw=
X-Received: by 2002:a05:6902:230a:b0:e60:a2e2:9359 with SMTP id
 3f1490d57ef6-e6678ef846fmr311841276.3.1742320939131; Tue, 18 Mar 2025
 11:02:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250317230403.79632-1-npache@redhat.com> <e2807c0f-c6db-4946-a731-009d34c2c72e@redhat.com>
In-Reply-To: <e2807c0f-c6db-4946-a731-009d34c2c72e@redhat.com>
From: Nico Pache <npache@redhat.com>
Date: Tue, 18 Mar 2025 12:01:53 -0600
X-Gm-Features: AQ5f1Jqld-DTVBJ5lnYhAbXgkaFBEnpnySW3WxHs_U8l1d99uleiybSQ_j4TBT0
Message-ID: <CAA1CXcAr+rjZmzbzHSuvCDqyfi6wW1-32c6_3isZMSr-qM7DLw@mail.gmail.com>
Subject: Re: [PATCH] Documentation: Add "Unaccepted" meminfo entry
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-doc@vger.kernel.org, kirill.shutemov@linux.intel.com, corbet@lwn.net, 
	akpm@linux-foundation.org, surenb@google.com, pasha.tatashin@soleen.com, 
	catalin.marinas@arm.com, jeffxu@chromium.org, andrii@kernel.org, 
	xu.xin16@zte.com.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 18, 2025 at 2:42=E2=80=AFAM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 18.03.25 00:04, Nico Pache wrote:
> > Commit dcdfdd40fa82 ("mm: Add support for unaccepted memory") added a
> > entry to meminfo but did not document it in the proc.rst file.
> >
> > This counter tracks the amount of "Unaccepted" guest memory for some
> > Virtual Machine platforms, such as Intel TDX or AMD SEV-SNP.
> >
> > Add the missing entry in the documentation.
> >
> > Signed-off-by: Nico Pache <npache@redhat.com>
> > ---
> >   Documentation/filesystems/proc.rst | 3 +++
> >   1 file changed, 3 insertions(+)
> >
> > diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesys=
tems/proc.rst
> > index 09f0aed5a08b..8fcf19c31b18 100644
> > --- a/Documentation/filesystems/proc.rst
> > +++ b/Documentation/filesystems/proc.rst
> > @@ -1060,6 +1060,7 @@ Example output. You may not have all of these fie=
lds.
> >       FilePmdMapped:         0 kB
> >       CmaTotal:              0 kB
> >       CmaFree:               0 kB
> > +    Unaccepted:            0 kB
> >       HugePages_Total:       0
> >       HugePages_Free:        0
> >       HugePages_Rsvd:        0
> > @@ -1228,6 +1229,8 @@ CmaTotal
> >                 Memory reserved for the Contiguous Memory Allocator (CM=
A)
> >   CmaFree
> >                 Free remaining memory in the CMA reserves
> > +Unaccepted
> > +              Memory that has not been accepted by the guest
>
> I was wondering if we could be clearer like
>
> "Memory that has not been accepted. Especially in some confidential VM
> implementations, memory must be accepted manually by the guest OS before
> it can be used the first time."
I actually grappled with the description for longer than I'd like to
admit lol. I wanted to add more but *most* others left the description
short-- so I tried to make it short too.
>
> In any case
>
> Acked-by: David Hildenbrand <david@redhat.com>

Thanks!
>
> --
> Cheers,
>
> David / dhildenb
>


