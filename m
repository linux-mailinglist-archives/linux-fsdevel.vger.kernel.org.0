Return-Path: <linux-fsdevel+bounces-37751-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CEB019F6DA0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2024 19:48:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BACA118813B0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2024 18:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEDF81FBE83;
	Wed, 18 Dec 2024 18:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QeZENIgW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D97B1FAC4D
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Dec 2024 18:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734547701; cv=none; b=ZKlwuw7PrUf02sfwcoy2hX0YskGAsUaahLhmfQ/f6oxgkv62Zd2ZngSivvN5FapBGeCliXbYA+KvqgRAztrOGeqwyO6scqcKeY85cOc6269JDlwmG6P/jJiO793gitAkevhp4MXItGb2kYQbaEmG0Hgi40dBeis3MOAIgfPQq74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734547701; c=relaxed/simple;
	bh=Wk7EU0ytP8hY/vCIGFtE2cggHvtOIXl/UftACoCEbkI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fRkRAsSLyDMRIU3wVqdWkZXyffTruXqLfDMd0rWWbO/lzSMZDXfxz6GSXH6tVlALf5/OV7gkde8XTHw8PsilmEW3/HHWqJIl2z9+21IjQG8cdWGmz1NEV4sUEKC0LRveAtSmAlXI/ZXuUVyWKQEXsnCcLMz5dx1A92vYnunidsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QeZENIgW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734547697;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wk7EU0ytP8hY/vCIGFtE2cggHvtOIXl/UftACoCEbkI=;
	b=QeZENIgWVNgGBrm6aYbEZsU/xhzw7avZlZTWO5nt+Qh61g3prL0q9aBJb5gJXxLMDHMoFK
	dVgU8snAOPIGvEVJYJxwOjyfRQeYIlAJxYhW+JBE+8o63JQuOsq3bTOGgqWsosf9eZw5r3
	7jx8zLRDqVf7CfOsyee2rgzd62ANzAQ=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-HnGvowt_P-2922J66qOKig-1; Wed, 18 Dec 2024 13:48:16 -0500
X-MC-Unique: HnGvowt_P-2922J66qOKig-1
X-Mimecast-MFC-AGG-ID: HnGvowt_P-2922J66qOKig
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-467b19b55d6so64575641cf.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Dec 2024 10:48:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734547695; x=1735152495;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wk7EU0ytP8hY/vCIGFtE2cggHvtOIXl/UftACoCEbkI=;
        b=GtClenrHj2b2d46fKm9WkrKPcoV3Ir1rtXbbkdGxiVHHIck3I96F2bowlo7Xco/k9f
         dHEkujn3SXNCZUs4NgVZNJT5Z1YV13szDY5ELv7r1kPYK4sbNEW5Y02EK+dw9CJ0f1x0
         lTnK6IbsxkKa900vni4XO9cCPOiKWa4KSmiocC982ub7t8GRC25BR8QkkmLOJaA4nzis
         1I/zTHUToHflPAH1vMU7o1kisYX1ntdXENtxIr6CSpwo7uQDJ3mZFjK2d3Y84IVOrGL6
         JmKAMr8B1er0bVNHy2G7b29HQ9J3DEFL2BsaKNcGg2/2cdiCS/X1CJefnYxTIVB/Ji7R
         AgMw==
X-Forwarded-Encrypted: i=1; AJvYcCVUcOn53CDoXIQ1MD15GBLwa+m6c6Jk0fSjERsBtey+FQ/DmG+X2nGUR+0iKnZhpAB4bZK5GVrZJMAQpYkF@vger.kernel.org
X-Gm-Message-State: AOJu0YzRkueWUW3crRLAT6kUYLShB7j6oEsu+xhsH9RcPFVu3K+I0lsM
	D6XOMUVUjCT0HgnY2BukwTPnPlL5ptTZBEZb8r4ev3AFmWfCADDtdiahqcUFsqercTXCT/e70dK
	VPrgLJbVCz+MYeE3DMSGlLwmH/h1o+hm77WmoQiAhmBzv72dWVwEMtOfAlSVOw2ZuBjTD3Qpqy7
	6bL9fHzsSKTnDnEuie6/M7SRL/BvgZz7EAWfr+sw==
X-Gm-Gg: ASbGncs5oS78+IaFJozjc6kqsvq7PJEJZ8M5dziCO/EBNGTQ7I5yqzsLb8/UFD/NfXs
	E3FTawc92bQhViq5awTSEMPoCRrOaX3U7AXuplw==
X-Received: by 2002:a05:622a:1828:b0:467:70ce:75e9 with SMTP id d75a77b69052e-46908e022d8mr64195251cf.23.1734547695708;
        Wed, 18 Dec 2024 10:48:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFTVv+XdS41U4i15obok7wAWPYGesrwGIM+ruomJGBbnb0CVE9F17mMba1sCRuq3dKoJgnBmXNFkG96ND3MBeI=
X-Received: by 2002:a05:622a:1828:b0:467:70ce:75e9 with SMTP id
 d75a77b69052e-46908e022d8mr64194911cf.23.1734547695442; Wed, 18 Dec 2024
 10:48:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3989572.1734546794@warthog.procyon.org.uk>
In-Reply-To: <3989572.1734546794@warthog.procyon.org.uk>
From: Patrick Donnelly <pdonnell@redhat.com>
Date: Wed, 18 Dec 2024 13:47:49 -0500
Message-ID: <CA+2bHPbSWHEkJso18Ua=k+OccZq4HzuOLAmZYTD1d5auDxQ9Vw@mail.gmail.com>
Subject: Re: Ceph and Netfslib
To: David Howells <dhowells@redhat.com>
Cc: Alex Markuze <amarkuze@redhat.com>, Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>, 
	Ilya Dryomov <idryomov@gmail.com>, Xiubo Li <xiubli@redhat.com>, Jeff Layton <jlayton@kernel.org>, 
	ceph-devel@vger.kernel.org, netfs@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello David,

On Wed, Dec 18, 2024 at 1:33=E2=80=AFPM David Howells <dhowells@redhat.com>=
 wrote:
> Also, that would include doing things like content encryption, since that=
 is
> generally useful in filesystems and I have plans to support it in both AF=
S and
> CIFS as well.

Would this be done with fscrypt? Can you expand on this part?

--=20
Patrick Donnelly, Ph.D.
He / Him / His
Red Hat Partner Engineer
IBM, Inc.
GPG: 19F28A586F808C2402351B93C3301A3E258DD79D


