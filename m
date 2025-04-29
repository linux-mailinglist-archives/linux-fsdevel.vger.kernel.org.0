Return-Path: <linux-fsdevel+bounces-47647-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B024AA3B7A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Apr 2025 00:29:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9C4E1B6602A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Apr 2025 22:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9BC2274FEF;
	Tue, 29 Apr 2025 22:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="CwsTNlZV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9D22750E2
	for <linux-fsdevel@vger.kernel.org>; Tue, 29 Apr 2025 22:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745965733; cv=none; b=Sina3yX2CQLEbMIeWfS9nPoSbn1hIXegZGplzmnj7Rf3J2P3SZ0tdhiTgQz8yUFQRcNqUDkobbGBXQCt8bee6U71pVuv0Z5bwLk0F/MuXpf/kUz2maQQyFOYKVUJd22Q2TuOWY7eY9n3l70R+tLnzSq6/tabnNPInzu6i/IPU1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745965733; c=relaxed/simple;
	bh=DrQtm2k0BGV++MkLZyElQxuNZpVur889SFIJ8Whsq50=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uVdhYxJLcBKTBwB2X+KlDAQVZWEEsh12XB5fjmXI/pb8aSH3XryrNXQVBg9bl8oi3Y9RcxBkE28lf3AI5W0DdIUma1U4tK/emb6UhgfLGmmbAlylR2ePipy0oIVf5Nqa70m1iUSdcM87qsj5isEdyoAjsU7eT7+6BjoQk0Uq8kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=CwsTNlZV; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-72d3b48d2ffso6024061b3a.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Apr 2025 15:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1745965730; x=1746570530; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=n/nJ7e7iCqZBPKST8vR+KgVRMpE1FAtOL+yQEdG3UJA=;
        b=CwsTNlZVDNH1VUwZWyWPUkH5uUTR9FGjtM/FXPllDfVRoeR0oBrJZrLanCu/h+1FUU
         26IlvYb6SB8rocxhFI3Eti1m7GxCPA+IJzoSUttkGNh1agwkDSx20y3vBLUnMvreBjlm
         TFKniQu/PZUsichl91Vgwwi9L1PX8AtHi+3yPXwexK2VOd1UW2blxc0dG99NMPsv/gDp
         N70ePnFhAQDxHjbPebZW8Is8s6eb++m819ZvI9MSMRwXFaB7KqDKh+EesKC42DKNrpmn
         zdPoo1YoLyf81hTleuPCDt/JnPt6/B7bdj+3frYEhWhhl5SwrtlS4M4Bobr0JfV4/fKu
         JBRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745965730; x=1746570530;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n/nJ7e7iCqZBPKST8vR+KgVRMpE1FAtOL+yQEdG3UJA=;
        b=actptlBtb+tjN18aYoiQzqMXOBYJhoN85Iav+5SQj2R3uhV6RvL0VMF+KRM9L+01bz
         dMoxuGzknZhIG6YRp/diw1nZ1EkaMt59BrbFJ2hflhFT/9MIWA1bK2XLZzB6nN7zIsUh
         HwzLjrX+wigh1aJtJg3TGWg92AJd20gm/RsiT/EOxz/sjOajUkIVQV8EBM6u6Tf86C2P
         KCCIO/C8p4LRxzEUSSYNkD218ftsYXQflGPaX6etl4GoVRIp1Af8b0uOL3wWIYFLw7uY
         2KbxKFKqRvtbZjUtf/dG25kZfwdds1f8StIw/x2KYqIL5a2hrY+UbwkZISQhFS3L5PJt
         +wzg==
X-Forwarded-Encrypted: i=1; AJvYcCUtiynRXqN8eU+EkR1GmvbYaMZ9G9HBCwypFeDye/qt044XfFQ3Y3HHchpFnkeGZG35WlUzkertPAcKtxjQ@vger.kernel.org
X-Gm-Message-State: AOJu0YzCxHEmLnmPD/PtDeeOuvXTZSraYDhsX4mAJC6G/OFSwABxyzWQ
	mC2+l8wEUKMSDT8uaAtuuURADoApmRabS2GUhqlWiC6lEFtKamhe9sHgVKPbfzg=
X-Gm-Gg: ASbGncsq50KkWOECdOOp9dIo09wSkE0NZqOFDI9KH8ABqMm0EFNCqBpLGBxRW6gSC+1
	aQtlQYmsEI0dUHGS4ATFipaZ+X+7HuyTKGaRqw5VgNEqzA8VIaFLq5jysrlGk5kMiNf28WfgJ0B
	yNyWUJxViaaBB+RHcJOZXDUGZXWLvchPRhmptkIvlsMs2kC+EgEBcD01AXqTByL4CdPc1wnfPj+
	H5ZEs4PLJkEjOE1p7mmMTWtKuNrRWuaOOa7/xRzV29B4zf/AZ7BNQjCAjgNquSX3VAia4Vjxsnt
	f+SF3bBopUKvWHTsu2377JEK8MStm5WgfWO2AMl/wPJGmw==
X-Google-Smtp-Source: AGHT+IHkRIjjxmR3uX949cS8V0XiY7lPmRW0fo6zlMPwUUKvW5McecdvaF/jcMtnHjyQUwl0koLBWA==
X-Received: by 2002:aa7:8895:0:b0:730:9946:5973 with SMTP id d2e1a72fcca58-7403a75b45bmr362186b3a.5.1745965729860;
        Tue, 29 Apr 2025 15:28:49 -0700 (PDT)
Received: from ?IPv6:2600:1700:6476:1430::45? ([2600:1700:6476:1430::45])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74039a63182sm220283b3a.154.2025.04.29.15.28.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 15:28:49 -0700 (PDT)
Message-ID: <3593872f41acf104bb2822d3e10c88bc71e05b77.camel@dubeyko.com>
Subject: Re: [PATCH] hfs: fix not erasing deleted b-tree node issue
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>, 
 "glaubitz@physik.fu-berlin.de"
	 <glaubitz@physik.fu-berlin.de>, "linux-fsdevel@vger.kernel.org"
	 <linux-fsdevel@vger.kernel.org>, "frank.li@vivo.com" <frank.li@vivo.com>
Cc: "Slava.Dubeyko@ibm.com" <Slava.Dubeyko@ibm.com>
Date: Tue, 29 Apr 2025 15:28:48 -0700
In-Reply-To: <9c2571057c141f46515e26b5e0cb06176d5df093.camel@dubeyko.com>
References: <20250429011524.1542743-1-slava@dubeyko.com>
		 <78d3899f-5e07-4a76-8135-81cfea3b0086@wdc.com>
	 <9c2571057c141f46515e26b5e0cb06176d5df093.camel@dubeyko.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-04-29 at 10:19 -0700, Viacheslav Dubeyko wrote:
> On Tue, 2025-04-29 at 06:05 +0000, Johannes Thumshirn wrote:
> > On 29.04.25 03:16, Viacheslav Dubeyko wrote:
> > > Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
> > > ---
> > > =C2=A0 fs/hfs/bnode.c | 2 ++
> > > =C2=A0 1 file changed, 2 insertions(+)
> > >=20
> > > diff --git a/fs/hfs/bnode.c b/fs/hfs/bnode.c
> > > index cb823a8a6ba9..c5eae7c418a1 100644
> > > --- a/fs/hfs/bnode.c
> > > +++ b/fs/hfs/bnode.c
> > > @@ -219,6 +219,8 @@ void hfs_bnode_unlink(struct hfs_bnode *node)
> > > =C2=A0=C2=A0		tree->root =3D 0;
> > > =C2=A0=C2=A0		tree->depth =3D 0;
> > > =C2=A0=C2=A0	}
> > > +
> > > +	hfs_bnode_clear(node, 0, tree->node_size);
> > > =C2=A0=C2=A0	set_bit(HFS_BNODE_DELETED, &node->flags);
> > > =C2=A0 }
> > > =C2=A0=20
> >=20
> > Hi Slava,
> >=20
> > I've just checked HFS+ code and hfs_bnode_unlink() in
> > fs/hfsplus/bnode.c=20
> > is a copy of the fs/hfs/bnode.c one (maybe most of the file is so=20
> > there's room for unification?). So I think the fix is needed there
> > as
> > well.
> >=20
>=20
> Yeah, makes sense. This fix should be there too. I simply started
> from
> HFS and I didn't take a look into the HFS+ code yet. Let me prepare
> the
> patch for HFS+ too.
>=20

I double checked the HFS+ code. The deleted node's clearing logic is
already there. The hfs_bnode_unlink() set HFS_BNODE_DELETED flag. Then,
hfs_bnode_put() check this flag. And if it is set, then
hfs_need_zeroout() is called. If it is the catalog file and volume
attributes contain HFSPLUS_VOL_UNUSED_NODE_FIX flag, then
hfs_bnode_clear() is called. Also, I don't see the corruption of the
HFS+ volume for the case of generic/001 test-case.

Technically speaking, I could follow to the same logic in HFS (I mean
of placing hfs_bnode_clear() into hfs_bnode_put()). But, as far as I
can see, HFS hasn't similar volume attribute like HFS+ has.

Thanks,
Slava.

