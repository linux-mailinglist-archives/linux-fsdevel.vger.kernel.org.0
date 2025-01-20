Return-Path: <linux-fsdevel+bounces-39690-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4632AA16F7E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2025 16:45:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81B8F161404
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2025 15:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8576F1E9912;
	Mon, 20 Jan 2025 15:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SEVoNbcM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715C81E3DE5
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jan 2025 15:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737387916; cv=none; b=kMbMLND7IOhyCFD1AmcXgMWvG3ty2/yXn/139LkLRhiEHWj8R+PqKLzsqa6ZylWrH552Ua4DPNkKXHsRgZWFcIOD5Ffyo2kHi/T2qbmU1aCfLP8fej4fgH5VxZPPV6eGey0UY3y8vZDc4xnkSOu62I7DtiAsr38u4tUta8fipQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737387916; c=relaxed/simple;
	bh=Oda9mln6fEOlY14aL6317hxcaxqFGoBRiFYJ48KMZC8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OYnApABZSrzKNG6i1bdqnzjbD4sHr6Qcwol+Ndy93C3hQYzm1XFuml4WVl0o1kg6+ro8fHVMRW2X1q/nqCmHe6XHhZDiE/I7cyiyOzZ/29cQeAFcT+gupqM+nFusGmtjwkhSxCp8jT3Laz+g/uwIQZAs2FpPMa9jvJIAK0lSqw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SEVoNbcM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737387913;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lIGGrFqr7H0caVdn+ErlhooF/AWh7D0WDDnrCqb47yA=;
	b=SEVoNbcM7P+atvX8ZABpCkGKNZ34/pnJ0jl/2ui4+by9mzNgWYtDrRW4tzKQaUHYqs630w
	PJotek0dejVkbYDDBlU4UafKTGDOr6JwepTdsbch4SFczyPIumsi8JtVNAEpkkTfg9wtZu
	9ycoIpMXQbJOwRbSE87bAwIxgra0JF4=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-225-9mj-FCdfOG-Nm2X9NLYrJw-1; Mon, 20 Jan 2025 10:45:12 -0500
X-MC-Unique: 9mj-FCdfOG-Nm2X9NLYrJw-1
X-Mimecast-MFC-AGG-ID: 9mj-FCdfOG-Nm2X9NLYrJw
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2166f9f52fbso142664525ad.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jan 2025 07:45:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737387911; x=1737992711;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lIGGrFqr7H0caVdn+ErlhooF/AWh7D0WDDnrCqb47yA=;
        b=oltlraLqH5kr1RmwLtvSyyMVxXqtw3Z1BNro4S7zeyPxIsVRuG2XT3G7AOlkBnGT3F
         ujFrHMxIoSIVgvu7E0LWC+/mKdd4reIoa7t2IW0tsJuvZF/jNWJuXQId79ymkLxQKK7V
         2nvG1iuMdfc7kG9COSKLTtQ6AUuTmLSiz5DESo+hKZXAeXG4LZEIoeGZlEpHDyYYF744
         mPLDHSWB/t32itsCoDq0SAsK5FkSNrBDzRYTKp25oU8W6gAJlU4n3I5rtATPzjOVoIsw
         DyOV4wiKllXHeHUZaMkGoYTQmO4CAJQbXYJ0UCMfjx76qD501yAo1cC8GMfoQXpEvukE
         dObQ==
X-Forwarded-Encrypted: i=1; AJvYcCUV0/p5jtlpUm2ct6+SXZHGrfd0o/nbtqbN69k8JTVUe9A/p9q07c14+WRN1SWtxS5WZ0xtt2GbniuIJSTP@vger.kernel.org
X-Gm-Message-State: AOJu0YwmGVT0k4IBIRhH5nR3fj6cJSQhVF9FOu7b5lN9sGT56wFZycas
	dw5s30OCqS9GbAIA4jeOvXErvbE3BNY9kNm8tb7+bywJGpDvFz7SFKbbzqALKFODYNgZg3puAWJ
	lu7Lzud4QcEyhdV2NhyYrIG8aNOjDniMHMdFzwsjYIhD04YoxThUeFISpzjyLfG3+/Rit95Zyg7
	DI3lJ+kiJmZofHnici59wwvB6DtjprMoMX4+KNiQ==
X-Gm-Gg: ASbGncu2LQB3KfJn/KXKmMrLjmbaXPH6dpkxfWxFNSqpGRZICHe6Hx2HcC+KEOesMDo
	PCj3TENeWxhcFwVNZpVvQpadR1Cv3zjAUcGoNR0gXOTMhF3MSIg==
X-Received: by 2002:a17:902:d50e:b0:210:f706:dc4b with SMTP id d9443c01a7336-21c355b641dmr185100505ad.13.1737387910852;
        Mon, 20 Jan 2025 07:45:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEuQe5UfQ3x73vBIKz+Vas2Vh1EUeCLsJdDGZT/xsX13VrNUtSO8YwlyHZngSzILoKv0/LIxcX/SpneTI4V0bM=
X-Received: by 2002:a17:902:d50e:b0:210:f706:dc4b with SMTP id
 d9443c01a7336-21c355b641dmr185100145ad.13.1737387910533; Mon, 20 Jan 2025
 07:45:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250116043226.GA23137@lst.de> <20250115094702.504610-1-hch@lst.de>
 <20250115094702.504610-9-hch@lst.de> <CAHc6FU58eBO0i8er5+gK--eAMVHULCzHPnJ9H5oN12fr=AAnbg@mail.gmail.com>
 <20250117160352.1881139-1-agruenba@redhat.com> <20250120-tragbar-ertrinken-24f2bbc2beb4@brauner>
In-Reply-To: <20250120-tragbar-ertrinken-24f2bbc2beb4@brauner>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Mon, 20 Jan 2025 16:44:59 +0100
X-Gm-Features: AbW1kvbnR4jxYY1OmmWJQiLZ57eqMNbLkpoGBmLc4oA3QTE98Cmi7zx5BVBckp0
Message-ID: <CAHc6FU6EpaAyzFPdJUa97ZZP76PHxJb-vP8+tzcZFRYT5bZeGQ@mail.gmail.com>
Subject: Re: [PATCH 8/8] gfs2: use lockref_init for qd_lockref
To: Christian Brauner <brauner@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Andrew Morton <akpm@linux-foundation.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-erofs@lists.ozlabs.org, gfs2@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 20, 2025 at 4:25=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
> On Fri, Jan 17, 2025 at 05:03:51PM +0100, Andreas Gruenbacher wrote:
> > On Thu, 16 Jan 2025 05:32:26 +0100, Christoph Hellwig <hch@lst.de> wrot=
e:
> > > Well, if you can fix it to start with 1 we could start out with 1
> > > as the default.  FYI, I also didn't touch the other gfs2 lockref
> > > because it initialize the lock in the slab init_once callback and
> > > the count on every initialization.
> >
> > Sure, can you add the below patch before the lockref_init conversion?
> >
> > Thanks,
> > Andreas
> >
> > --
> >
> > gfs2: Prepare for converting to lockref_init
> >
> > First, move initializing the glock lockref spin lock from
> > gfs2_init_glock_once() to gfs2_glock_get().
> >
> > Second, in qd_alloc(), initialize the lockref count to 1 to cover the
> > common case.  Compensate for that in gfs2_quota_init() by adjusting the
> > count back down to 0; this case occurs only when mounting the filesyste=
m
> > rw.
> >
> > Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
> > ---
>
> Can you send this as a proper separae patch, please?

Do you want this particular version which applies before Christoph's
patches or something that applies on top of Christoph's patches?

Thanks,
Andreas


