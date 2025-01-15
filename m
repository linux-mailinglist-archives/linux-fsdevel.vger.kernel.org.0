Return-Path: <linux-fsdevel+bounces-39297-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18073A124FF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 14:41:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29F4E3A7211
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 13:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 005BD243348;
	Wed, 15 Jan 2025 13:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GqkZe/Ze"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4D22416B8
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Jan 2025 13:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736948290; cv=none; b=ksR4r7attTIvE6jBtbKnjiMffQMCMeyLmzs18kc4NIJ6cqCqQRA6CaKjjQYE97VnZx8W5KXnI1S84vjrWayOHbfO+VjTk26BwuDW6BgaFwOGsaZA3WOnA8diZNb3tl4Xexy0MS3AQba96JFO2icf8I8ATQ3rmyTRLCpNSbBJHTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736948290; c=relaxed/simple;
	bh=VjQa1OLpSyM90kBGecP1wvm0KvL1YkQqKm7jhQdDLdo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iJmG0sbkDd9O5nHS6P4kYt2YHvYj0n5PxlRWvtAxbqG++NoCcFEBt8OeNzD31kNHpFVlSbdLcVCvYL49kuyk2ASG6YcAEb50Vjwsvu07iqjnrLBUfWuwGE1ZcVPWDy48k8bT+ACymhVqZZtOkmnt3LYhpd087AnenkuevgIc6DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GqkZe/Ze; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736948287;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VjQa1OLpSyM90kBGecP1wvm0KvL1YkQqKm7jhQdDLdo=;
	b=GqkZe/ZenyujiPoqskkSZnme92cvBiR9XalEKIRd0OFP5PDYjo7TpjhmJ1R2zsYgt/9UkG
	0sz8hW88sOVEBcdznVzLEffJy62Znp3s2Z3kf9TQ2Y6KReZC/kgf5IFbtbcknaWZXUxm6G
	KJSvSEEvUrRheeylyrh8G1jXvSQD5oE=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-472-WYZ2GINMN5i4Fnxd8ZtjQg-1; Wed, 15 Jan 2025 08:38:06 -0500
X-MC-Unique: WYZ2GINMN5i4Fnxd8ZtjQg-1
X-Mimecast-MFC-AGG-ID: WYZ2GINMN5i4Fnxd8ZtjQg
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-216717543b7so171137645ad.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Jan 2025 05:38:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736948285; x=1737553085;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VjQa1OLpSyM90kBGecP1wvm0KvL1YkQqKm7jhQdDLdo=;
        b=TN9TjcaI+h6Fxhjmg/NB2LvlUQijLU9eQzGMMjY8eng1FKRIBYu3s6gq9+22muDprN
         hVZwOC2U6TDBbKnCZTDlya3Xz7JakzTrCDELO/J25mDcfspvZ5XHvCsSti5omyw9zR3X
         5Anj//DDNTBzNFBgNQC9IqNBPjmrGfwE3VKOeMtbOhMAEM5QuH9a7C1uL8RTBAnQXV5n
         m8wlw+Y/gh4Tyr0h20CltowYE+KKA4Q6F7Jhj9gwrNCI0YkV/OXkJ3EnXDNV4Zb9qlOe
         oDlRyXTGjJtkYRyPX7HjlFzo8ow8nGG3gExWEsSQiiapiJUIxv6Q3AIGlLOXblviocQd
         UcWA==
X-Forwarded-Encrypted: i=1; AJvYcCVzN+oG2lqch8YxVIE3EhYHgXuqRcLW+it1KIE8Ly6OIca+RAdp8AnCVBokkairhQQaY2/tFXDlO+/9r78U@vger.kernel.org
X-Gm-Message-State: AOJu0Yxb4Q5jxEduTQfa3vINgQQRYofNu8UK+ZWodIlnDuy3jQ502xBj
	nn4FllDwQmLAkxbGYZSy8yt0vIeaLwBXQqGYh6x2SQF6T2KjorcU5vPJgld5C6td1XUyFC1WoIS
	DmCUuhO4gbM2sZImPdVU4szSyZzkrkeUuBBHW3uiP417rULVmn3LIDfbNYApcincN6CjXCfn/D+
	/Pbn4Tfv4d3Yjti/XzC3OdT26u/SuKq5wgQQ8GWg==
X-Gm-Gg: ASbGncupKAxPxpVuwvWy9u8BxnO3Qn0zIFRZOh+18Ay570M7queZY4UcE5mBohVuXZB
	ewiTa1vSarrxLZpRIGYS6OWPtJHjNh4t+Vf3y
X-Received: by 2002:a17:902:ea03:b0:216:2d42:2e05 with SMTP id d9443c01a7336-21a83f6fa87mr555113845ad.22.1736948285233;
        Wed, 15 Jan 2025 05:38:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IErMQnmVTC/5MIwIzeYkaeNX5Ux0e7rhk5lUfGZ2fT2+jhaqfFmt9SGK4LAJYtpbYNeZW4dNZPKHk7XlcaxcZ8=
X-Received: by 2002:a17:902:ea03:b0:216:2d42:2e05 with SMTP id
 d9443c01a7336-21a83f6fa87mr555113515ad.22.1736948284976; Wed, 15 Jan 2025
 05:38:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <F0E0E5DD-572E-4F05-8016-46D36682C8BB@m.fudan.edu.cn>
 <brheoinx2gsmonf6uxobqicuxnqpxnsum26c3hcuroztmccl3m@lnmielvfe4v7>
 <5757218E-52F8-49C7-95F1-9051EB51A2F3@m.fudan.edu.cn> <6yd5s7fxnr7wtmluqa667lok54sphgtg4eppubntulelwidvca@ffyohkeovnyn>
 <31A10938-C36E-40A2-8A1D-180BD95528DD@m.fudan.edu.cn> <xqx6qkwti3ouotgkq5teay3adsja37ypjinrhur4m3wzagf5ia@ippcgcsvem5b>
 <86F5589E-BC3A-49E5-824F-0E840F75F46D@m.fudan.edu.cn> <CAHc6FU5YgChLiiUtEmS8pJGHUUhHAK3eYrrGd+FaNMDLti786g@mail.gmail.com>
 <27DB604A-8C3B-4703-BB8A-CBC16B9C4969@m.fudan.edu.cn> <31f0da2e-4dd7-44eb-95ee-6d22d310a2d6@redhat.com>
 <CAHc6FU63eqRqUnrPz0JHJdenfsCTWLgagX+2zywHNTcFoZA8XQ@mail.gmail.com> <958E28E8-3046-4030-963A-7A0789E8809C@m.fudan.edu.cn>
In-Reply-To: <958E28E8-3046-4030-963A-7A0789E8809C@m.fudan.edu.cn>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Wed, 15 Jan 2025 14:37:53 +0100
X-Gm-Features: AbW1kvZhqaGG_k4tyej31nWk7IyisIppO7ylJG-0Gf9Pme9vzez2SCsYE1LPqCA
Message-ID: <CAHc6FU7OjuDqTfdG+rAmEsfi_6LhNRcaAEYcdE+o+HXPywOYMg@mail.gmail.com>
Subject: Re: Bug: slab-out-of-bounds Write in __bh_read
To: Kun Hu <huk23@m.fudan.edu.cn>
Cc: "jjtan24@m.fudan.edu.cn" <jjtan24@m.fudan.edu.cn>, Andrew Price <anprice@redhat.com>, Jan Kara <jack@suse.cz>, 
	viro@zeniv.linux.org.uk, brauner@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, gfs2@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 15, 2025 at 2:25=E2=80=AFPM Kun Hu <huk23@m.fudan.edu.cn> wrote=
:
> I've posted a fix and pushed it to for-next:
> https://lore.kernel.org/gfs2/20250114175949.1196275-1-agruenba@redhat.com=
/
>
> Thanks for your help,
> Does the patch need us to test again?

That surely wouldn't hurt, thanks.

Andreas


