Return-Path: <linux-fsdevel+bounces-62148-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 341E6B85C6F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 17:51:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AF01170105
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 15:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A85722D7B5;
	Thu, 18 Sep 2025 15:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eAOavc2C"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 344D630DD26
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Sep 2025 15:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758210522; cv=none; b=jtUr4lvkm5/rAOknHpGaGCpnR0kks/14yIUxVkzgWDf/7cRoyNHnaSTp3eq9wLw9GNFBWKydnz2C4i+uRIOPxV0IK2j0m7HeLV1wyaTaBeaWF/vEncvo07LPv4DzmbGmq4r57NvWhDYI1Y9MnhBXZLp0midKbV5/QPm9eJ0A0D0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758210522; c=relaxed/simple;
	bh=3fuPAHF2wqUzCF+Ih+V96s2Pa8BfHBVrf909ozzJYxs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iXe0IaSVURIvi4B17lGVddLRKKebGqp5YdfZblnJTdoTn1Chh5PxiKs7hG/9iBXWsu5FgltetAAuPd8kgN9gwx5ua3kFz77d4xSxBAiZYjqtOZs9Uhe0HNP1gTtjOdHKg/M67Zb4DehyDgsQTIVD2CJABQkslyiJt9Rt/c0zwKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eAOavc2C; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-621b965a114so598587eaf.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Sep 2025 08:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758210520; x=1758815320; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3fuPAHF2wqUzCF+Ih+V96s2Pa8BfHBVrf909ozzJYxs=;
        b=eAOavc2CN3hKS95ih6fHrGk7HQYI14S9OGRboWaVhlIeSO+Siqxx6vtu4Fl75VShUA
         LFUlJB0hQTDvqMb+/ypW9RfbOVQcZ7S+pncqwJ2jtRXaSJOq4a2SIf5XLmgBS2y8+6Kk
         dxiFvkxUZt2A+13w0SonMvcT3N653WVBTXiCV/FHeN4/5ZrKJpSMujE7gFlWJVS3Xxy+
         qOvEnthHP6wMEhDH9I1y2nXWSnFvZb0rlGAE8VBoDEjch1ROO0nbPsNP+dIN5F/86Jox
         lfV2dgUthYT4i3k2/kSAQ338iJ0Lq+E7ZO+ysx+GVp+mALPXS/0U0YhCDCbeJDc7N1UE
         +6/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758210520; x=1758815320;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3fuPAHF2wqUzCF+Ih+V96s2Pa8BfHBVrf909ozzJYxs=;
        b=fdYdrV4xdVk81fE0/ovLqjMzUfC0nVC2UAAjQLFZlsB94ypRshyw+f3stOwxvW25PO
         R4gAhIjBuVcS4LILA/DehxVFAK7r/8wMNGk2HZL3khRFFAY76HBWW7gly8H1j/zTkvvF
         k4uYXDUbfVdyrUWKqM2FbYg0fIix6d6Io/lHFj3ir/rZDdRpwD3EUxcPG4Q0z+oOOrJ1
         P5ReG4QkYH3vzYf1GkgANOLyXFHF2mFpcP8wesE+LuAFzaTjkgOBgrUNY/DtpQkaqK6o
         oLNzHG8JkEF2DSB0pv6jn9mVcgWHCcHVBrGFURtQfVhxm2W2X6DFNiEgexWWdvt5b7nA
         sZmA==
X-Forwarded-Encrypted: i=1; AJvYcCUaG61ned8kAAh5p+88n20cagxsHd6ZAidDG8s/8ikHyeuk1eeeJvKbywVRmhyRR8VTB5vn9mwu3kwt7mZn@vger.kernel.org
X-Gm-Message-State: AOJu0Yzz1IJ8CPYu0YzuI2HcrsgwkYsplJOB/4XMX5H0Vc+PA5vTKc2U
	0OH5GCKnsgBivPtPOqjAA5Cx1SsEe94INoZhvrKxk3uPcCJoor87dS/mo01xW6DtyGClq1E/3l7
	V42hpkOvAr1hRSUz9uo9b5T4ORvWjlU1YYAGigJN4
X-Gm-Gg: ASbGnct2/w79VgTYJ7jahUnw7RsKByP2ZUgl/54Ln7nv9P+671EBzWr9fEFi6eBB8qI
	2zqsqMQg5fk/4XyrccjCsiQMSgWGMLjL1rwD8AcFNt5SZ6YDY6BjpPklGR3LuD2Th7hJ12+EZyc
	jldc4bSIAfa4em+1b8DGYWEEQfgEMS6ndyjz60gHlOC6CqFudFeoK3kOT00I8yo3U+mKYdbX5c2
	BvlkHSEg7I52emeHadJGyJQcu+Je+THTkLBN5HY5PzQuA97Pp57yziALfjKpuc=
X-Google-Smtp-Source: AGHT+IGZQIGtkvyQ7wUbXbPktQnaEGHmteV66ZUVON5NljKX83ZF9JtYWo+pN7TerpN49zbUut8goBymhFyWExBBTaQ=
X-Received: by 2002:a05:6820:c006:b0:624:abae:b650 with SMTP id
 006d021491bc7-624abaeb894mr2040726eaf.0.1758210519920; Thu, 18 Sep 2025
 08:48:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916234425.1274735-1-joannelkoong@gmail.com>
 <68ca71bd.050a0220.2ff435.04fc.GAE@google.com> <CAJnrk1YKPWkaBXe7D2mftN2DMEBqFow80reUGE=2_U8oVFc1tQ@mail.gmail.com>
In-Reply-To: <CAJnrk1YKPWkaBXe7D2mftN2DMEBqFow80reUGE=2_U8oVFc1tQ@mail.gmail.com>
From: Aleksandr Nogikh <nogikh@google.com>
Date: Thu, 18 Sep 2025 17:48:28 +0200
X-Gm-Features: AS18NWAU9uKKLdv_CQUnITI5tezk67S_wzRhWyVluYMjy37dGuE_05c1-3Y9NYc
Message-ID: <CANp29Y5Y8iO+UbKHtDEc=0d+76WxbWJK1asLaux++_n+Pr+d5g@mail.gmail.com>
Subject: Re: [syzbot ci] Re: fuse: use iomap for buffered reads + readahead
To: Joanne Koong <joannelkoong@gmail.com>
Cc: syzbot ci <syzbot+ci9b5a486340e6bcdf@syzkaller.appspotmail.com>, 
	syzbot <syzkaller@googlegroups.com>, brauner@kernel.org, djwong@kernel.org, 
	gfs2@lists.linux.dev, hch@infradead.org, hch@lst.de, 
	hsiangkao@linux.alibaba.com, kernel-team@meta.com, 
	linux-block@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org, miklos@szeredi.hu, 
	syzbot@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Joanne,

On Wed, Sep 17, 2025 at 9:59=E2=80=AFPM Joanne Koong <joannelkoong@gmail.co=
m> wrote:
>
> On Wed, Sep 17, 2025 at 1:37=E2=80=AFAM syzbot ci
> <syzbot+ci9b5a486340e6bcdf@syzkaller.appspotmail.com> wrote:
> >
> > syzbot ci has tested the following series
> >
> > [v3] fuse: use iomap for buffered reads + readahead
> > https://lore.kernel.org/all/20250916234425.1274735-1-joannelkoong@gmail=
.com
> > * [PATCH v3 01/15] iomap: move bio read logic into helper function
> > * [PATCH v3 02/15] iomap: move read/readahead bio submission logic into=
 helper function
> > * [PATCH v3 03/15] iomap: store read/readahead bio generically
> > * [PATCH v3 04/15] iomap: iterate over entire folio in iomap_readpage_i=
ter()
> > * [PATCH v3 05/15] iomap: rename iomap_readpage_iter() to iomap_read_fo=
lio_iter()
> > * [PATCH v3 06/15] iomap: rename iomap_readpage_ctx struct to iomap_rea=
d_folio_ctx
> > * [PATCH v3 07/15] iomap: track read/readahead folio ownership internal=
ly
> > * [PATCH v3 08/15] iomap: add public start/finish folio read helpers
> > * [PATCH v3 09/15] iomap: add caller-provided callbacks for read and re=
adahead
> > * [PATCH v3 10/15] iomap: add bias for async read requests
> > * [PATCH v3 11/15] iomap: move buffered io bio logic into new file
> > * [PATCH v3 12/15] iomap: make iomap_read_folio() a void return
> > * [PATCH v3 13/15] fuse: use iomap for read_folio
> > * [PATCH v3 14/15] fuse: use iomap for readahead
> > * [PATCH v3 15/15] fuse: remove fc->blkbits workaround for partial writ=
es
> >
> > and found the following issues:
> > * WARNING in iomap_iter_advance
> > * WARNING in iomap_readahead
> > * kernel BUG in folio_end_read
> >
> > Full report is available here:
> > https://ci.syzbot.org/series/6845596a-1ec9-4396-b9c4-48bddc606bef
> >
> > ***
> >
> Thanks. Do you get run on every patchset that is sent upstream or is
> it random? Trying to figure out if this means v2 is right and i just
> messed up v3 or if you just didn't run on v2.

The intent is to run on every patchset, but since the system is
currently still in the experimental state, some of the series are
skipped due to various reasons. E.g. syzbot tried to process v2, but
failed to find the kernel tree to which the series applies without
problems: https://ci.syzbot.org/series/7085b21e-ae1e-4bf9-b486-24a82ea9b37d

In the original email, there are links to the C reproducers, so these
can be used locally to determine if v1/v2 were affected.

--=20
Aleksandr

>
> Thanks,
> Joanne
>

