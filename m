Return-Path: <linux-fsdevel+bounces-61942-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D1DDB7FF0F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 16:25:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AB41722178
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 14:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74EB1278E67;
	Wed, 17 Sep 2025 14:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gWqjDtYK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6F423B60A
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Sep 2025 14:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758118362; cv=none; b=UTcHn7f1GB5NAJe/WuaHQnv4gxnPu2KtWtzcg0oDodVpTR8vksSzu1bJdDvm5TlkULUVcfL0R/zTmb1UI/1ovjWKvQDTyDbmNqexLV35tnnQmxqMUv90kdKYYVbGy9bvDax2FwdOr6xBdlZJ3DBon2rd2TW/nwRQcIIAq8Kmm4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758118362; c=relaxed/simple;
	bh=vAYyAJ+N5WTUxHpW/2g+4xRdn898OyOEJIqpwPj9b/M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nm3H8tJBduKcFThIu4m/v/Kz0XmvdE69vTlnayLPIOabyi21rYoOA+CDJbrg5eZOIZxF51bvW1CQaaJ77Gz7ftwe1rFeErs0RLIy0safb8LLVtNSeMcpsPrKLcY5fSFJbfi/7ENUbwcE+sNmgRESb2VOJ1+jzTA/2ETRNpSGsRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gWqjDtYK; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-62598fcf41aso9458725a12.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Sep 2025 07:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758118360; x=1758723160; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WvQvK494s3Wti/cOQyypkRIXGy03yU4MOudBoB5xafc=;
        b=gWqjDtYKZECXpoL15ydkDavMXNNUrgcroJ92oeqmnJahgeou3sqTIMw/IR4Ol69Gws
         Xe0nQgydGx1c4lN9VwCVJYWLjUSRUeQpV9UAqcAV6JF/QNSpwe+NC6OkyrOS6kYBE9Js
         7qeqZCLVidgNsx+l65NWdctxNpFII+qNR8T2a75KIak9Os8bPLfy2WAkFl6hjDgSIKNh
         AwQodrsyY67qeRvHv0hewe370P/v0/KN9KewGy/YVGKIlJmHolIPjpZwr+5ewL6H3+pl
         wxun/kUooymxpzTUGwf/2VtPX1m+jrYI2mmo/ptkYWpfymsCKvfsriWpgsWNxyPdJ8kl
         3QwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758118360; x=1758723160;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WvQvK494s3Wti/cOQyypkRIXGy03yU4MOudBoB5xafc=;
        b=KcOm5eFpa8DEqS5Wi3fEhXO5KagSKMWsbQyiOBImWewRJEGggsEr6ok4r9nJyIUX/P
         IYv6+Wh/M7SCJYGuUxlUVydBOZLOTqgjlSQg5l0RjLA9qPrpPZsHpIuQnedGRDV9Bi53
         AToclMm356Xh+7hUM9/gLBDzCHEcT8+HaYWI//do6Ch1bNgW+n7vN6jkKyqSjjfQb7qA
         L5cFAkxABPNfTIdwzkwWm2lH7A8Q6Dd4cg8mVjJs3wNLAhSCBv7uD7oyduvwhiZT+J03
         dB8TShgyJQVuCWBVvVom3QhS7e2IbwBZHZ1Lbf89KqZvQvpk0zkM1ntg3x2cWd64blgb
         E+cw==
X-Forwarded-Encrypted: i=1; AJvYcCWi98mjOR6+8aHi9Nxf9Rp8znJ6WWGsKcX2om+m1e3Ff15KNAAde6Dr4Nj2E0kgeYTnrNt5+lxq/AHjf5lc@vger.kernel.org
X-Gm-Message-State: AOJu0YzXShh1muMJN/Q6eLXJwiCG0GKq7lc0KQRqiGdoLDdka7rRen/F
	ZOhdQouPq2rZDdArbylIQHdk7pUyKiW00sT/tRsUkYCYGzBYyOhq7rbT81CaO+vZvUNpc84YQxD
	pq+VyaUDECv5dIr+Glq6ccD5057YdMJU=
X-Gm-Gg: ASbGnctxMLkFd/FyT9KOgdXzho4Dg8V7uT8HoA4garpYxeTCDnVtMt+4vTnhOnOyQJG
	fFiWN952lqtIKsGpuL/xqFt4BOvlzy1Ssrr9MyKoEqAwGul89/sYJxKlptV7jacS9NSjMCLhhNi
	KRqYzuHkEaen4+NnbM6CYZTYgMJjMEhm4P6B5/Is5p0wB595V1xk2OYOEILza61ZTsMGi7oW+WT
	FkhlmuN6t7gZf4+W6/IKyphjCoQl2Om+GPsLuk=
X-Google-Smtp-Source: AGHT+IE9tr65JazvM/P627oMjCH4lIxKxEXEjsbR4TaPhmEPiMyOp6W2xKFTSemRXPP2tElpIwdULTqBUJpCrnwZP+8=
X-Received: by 2002:a05:6402:280a:b0:629:949c:a653 with SMTP id
 4fb4d7f45d1cf-62f8422dd27mr2681936a12.24.1758118359355; Wed, 17 Sep 2025
 07:12:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250917135907.2218073-1-max.kellermann@ionos.com>
In-Reply-To: <20250917135907.2218073-1-max.kellermann@ionos.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Wed, 17 Sep 2025 16:12:26 +0200
X-Gm-Features: AS18NWBVEzgWJelbyAZl8OravcOrQ3fPpZBJDvJxRNN-yXIAsbshHF34p8BX9gc
Message-ID: <CAGudoHF0+JfqxB_fQxeo7Pbadjq7UA1JFH4QmfFS1hDHunNmtw@mail.gmail.com>
Subject: Re: [PATCH v2] ceph: fix deadlock bugs by making iput() calls asynchronous
To: Max Kellermann <max.kellermann@ionos.com>
Cc: slava.dubeyko@ibm.com, xiubli@redhat.com, idryomov@gmail.com, 
	amarkuze@redhat.com, ceph-devel@vger.kernel.org, netfs@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 17, 2025 at 3:59=E2=80=AFPM Max Kellermann <max.kellermann@iono=
s.com> wrote:
> +/**
> + * Queue an asynchronous iput() call in a worker thread.  Use this
> + * instead of iput() in contexts where evicting the inode is unsafe.
> + * For example, inode eviction may cause deadlocks in
> + * inode_wait_for_writeback() (when called from within writeback) or
> + * in netfs_wait_for_outstanding_io() (when called from within the
> + * Ceph messenger).
> + */
> +void ceph_iput_async(struct inode *inode)
> +{
> +       if (unlikely(!inode))
> +               return;
> +
> +       if (likely(atomic_add_unless(&inode->i_count, -1, 1)))
> +               /* somebody else is holding another reference -
> +                * nothing left to do for us
> +                */
> +               return;
> +

LGTM, I see the queue thing ends up issuing iput() so it's all good, thanks=
.

No idea about the other stuff it is doing concerning ceph flags so no comme=
nt.

> +       doutc(ceph_inode_to_fs_client(inode)->client, "%p %llx.%llx\n", i=
node, ceph_vinop(inode));
> +
> +       /* simply queue a ceph_inode_work() (donating the remaining
> +        * reference) without setting i_work_mask bit; other than
> +        * putting the reference, there is nothing to do
> +        */
> +       WARN_ON_ONCE(!queue_work(ceph_inode_to_fs_client(inode)->inode_wq=
,
> +                                &ceph_inode(inode)->i_work));
> +
> +       /* note: queue_work() cannot fail; it i_work were already
> +        * queued, then it would be holding another reference, but no
> +        * such reference exists
> +        */
> +}
> +

