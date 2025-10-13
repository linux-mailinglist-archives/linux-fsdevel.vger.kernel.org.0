Return-Path: <linux-fsdevel+bounces-63937-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 48D93BD20C3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 10:26:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5144F4ED6A9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 08:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A6C82F39B3;
	Mon, 13 Oct 2025 08:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="evINQi4I"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA2ED2264B2
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 Oct 2025 08:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760343986; cv=none; b=DxLeSzuIjcNfo7A9GCaUh+83H32I87UO+xJ5g/y9F4YGWn4naaH/kwt/vugeKdm+/VqQFH7rwXe+raKZtb/pYf1/2640YLrtahZuztC64WOcDB5XP+VAX/Mxt3fu42McjdY+rt9HGRZ3N2rQSRlRr4NkZZfQB0GJQVCl20drCPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760343986; c=relaxed/simple;
	bh=aeTrMwmyr4idjATE535SD4+VwHKBvnF3DmVfBmeSGIc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OpxfyRLpPjpuAaDlzBnk9+mJ2jE5+bUqYs7uG910c5z3ICBxLHk4DfwWAuCrKM69gVIiNQKvFJNaA9Vr/MsV0jv6agVt0kC8+DCHZ/kzUUq0Y4kSvmkr3KTxvU80V8wMHSt0EuTTszPF315+Z1HvDHSfHi51z+nDtfV7BtCim6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=evINQi4I; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760343983;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f9h2lc52spfsqI+nujAwhGun9J88DEF1peaurIn3jpI=;
	b=evINQi4IcyDz3fBL4CzS71mdZYAh+NCUSxAQqsqS2U54pk0Vh+LU+GKNVLNSfWA1ylDuv/
	bvU9xoSNZpiqkSQ/YgE5snas2lXwnSLSzPL3On1AQj/5uK49FuG1XDnNeccmqC+NObtHzh
	LffbIUZf+sThPVma1li24p9LC9MTTzQ=
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-221-q73uuTm4M2uOTby7iQmDSw-1; Mon, 13 Oct 2025 04:26:22 -0400
X-MC-Unique: q73uuTm4M2uOTby7iQmDSw-1
X-Mimecast-MFC-AGG-ID: q73uuTm4M2uOTby7iQmDSw_1760343982
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-5d614f013a5so1008442137.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Oct 2025 01:26:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760343982; x=1760948782;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f9h2lc52spfsqI+nujAwhGun9J88DEF1peaurIn3jpI=;
        b=DEpk5hkKfZsA6Xpv8U/zvuwnORSVE9N9ixbh7znjWlRbATy+TyRSBOhbTrmxoUgxRz
         ocJ4eOC7nPhuUjOxV2lZbAtHp+nM5CvbV0GhI4PbOxVk9Rh3I1kQ9w4/qEiR3pt8+lxO
         MWBBpRIXX9o08hEE8M7gY8EZVgGd0TvJ5f2s+WsOACghYsbg8IQylCES51Gk8kZHQT8W
         /0/g9laf7EGh9zMhnkv1qzRYfmWGcYkuE3fYp/OsoUP2WtL3LdA4/flULLB1h+RJvNar
         ehZupY3iidTol3RNdapGDM0KWm3SItthe+zfzqyd8oiVOy4ZOYv6dGmWwOSPZDJ5u5sP
         2f9g==
X-Forwarded-Encrypted: i=1; AJvYcCXYA6QL+Yo4/cv4VPrEO3lFdW3Sycqb4qrN0j5DZbs2CnmdOcIQ2Y2FonoLzdS22c1plSGDTsbelO0aKRKk@vger.kernel.org
X-Gm-Message-State: AOJu0YzlJgDSzPLKXRKtjlDzRnmgq0XpU7tVEfxx0OaN+b9f7bPhPWvD
	jA2XNO3XZsqDrWXQc30yFgFP0ZbEAabAMEahItSEkEpKgyqkw4kGLBiWjo72PN0G/nU1m2t3HIh
	C/2CUKGAJKMD2UxEY6ShqU7acR3wEst5K0CzapzSRhyh+OGpYNorABofAUoy5OUufdRvibiy5yY
	H5anoMnAUOnLHVvL967k+ilLyu3PkphMgGO1ijcWRRwA==
X-Gm-Gg: ASbGncuaWWxfBlkfUna/iQ30CwlyETzdgW6nWI1nLbSEn5IuvrAxdlUYmU7Ykh+2r7s
	dWlKlLEyRbgeAfUJal3NCHwkC+SQZxDLwFSMCAAUyWZ44GR+u6OQH+b/s/a0QOFPytsWlXTqfxu
	x7Yc0e/Nr98BITIVbOpSGWag==
X-Received: by 2002:a05:6102:8399:10b0:5d6:bbe:fe00 with SMTP id ada2fe7eead31-5d60bbf01ccmr1298633137.10.1760343981908;
        Mon, 13 Oct 2025 01:26:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEqxQ3r8mKG19gkUS7w6zdeOC2dbsppCKLD7LIyf0aaxI4o4mEw27yhWt4MDd3wyBHEFiKHvB7PUDNAXpEj720=
X-Received: by 2002:a05:6102:8399:10b0:5d6:bbe:fe00 with SMTP id
 ada2fe7eead31-5d60bbf01ccmr1298632137.10.1760343981594; Mon, 13 Oct 2025
 01:26:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250928132927.3672537-1-ming.lei@redhat.com> <20250928132927.3672537-7-ming.lei@redhat.com>
 <aN92BCY1GQZr9YB-@infradead.org> <aOPPpEPnClM-4CSy@fedora>
 <aOS0LdM6nMVcLPv_@infradead.org> <aOUESdhW-joMHvyW@fedora>
 <aOX88d7GrbhBkC51@infradead.org> <aOcPG2wHcc7Gfmt9@fedora> <aOybkCmOCsOJ4KqQ@infradead.org>
In-Reply-To: <aOybkCmOCsOJ4KqQ@infradead.org>
From: Ming Lei <ming.lei@redhat.com>
Date: Mon, 13 Oct 2025 16:26:08 +0800
X-Gm-Features: AS18NWCWxgbBN23g61iYzMfQYeFdjbQ0IHgI_c-2448u3QBnJ6IKRiHfJ5F8vfs
Message-ID: <CAFj5m9+6aXjWV6K4Y6ZU=X9NogD5Z4ia1=YDgrRRxxfg6yEv5w@mail.gmail.com>
Subject: Re: [PATCH V4 6/6] loop: add hint for handling aio via IOCB_NOWAIT
To: Christoph Hellwig <hch@infradead.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Mikulas Patocka <mpatocka@redhat.com>, Zhaoyang Huang <zhaoyang.huang@unisoc.com>, 
	Dave Chinner <dchinner@redhat.com>, linux-fsdevel@vger.kernel.org, 
	io-uring@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 13, 2025 at 2:28=E2=80=AFPM Christoph Hellwig <hch@infradead.or=
g> wrote:
>
> On Thu, Oct 09, 2025 at 09:25:47AM +0800, Ming Lei wrote:
> > Firstly this FS flag isn't available, if it is added, we may take it in=
to
> > account, and it is just one check, which shouldn't be blocker for this
> > loop perf improvement.
> >
> > Secondly it isn't enough to replace nowait decision from user side, one
> > case is overwrite, which is a nice usecase for nowait.
>
> Yes.  But right now you are hardcoding heuristics which is overall a
> very minor user of RWF_NOWAIT instead of sorting this out properly.

Yes, that is why I call the hint as loop specific, it isn't perfect, just f=
or
avoiding potential regression by taking nowait.

Given the improvement is big, and the perf issue has been
reported several times, I'd suggest taking it this way first, and
document it can be improved in future.

Thanks,


