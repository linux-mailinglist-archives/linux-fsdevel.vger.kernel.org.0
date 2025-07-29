Return-Path: <linux-fsdevel+bounces-56225-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54C92B14758
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jul 2025 06:53:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 998ED3A36A6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jul 2025 04:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F876230981;
	Tue, 29 Jul 2025 04:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="mHler/Pm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 616DB4A01;
	Tue, 29 Jul 2025 04:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753764811; cv=none; b=tODbTXXdhAzjOwXb8iLz2G5i3F861cgjKvoNRKMxoagw6BZP9Lvm0iMskvW3C1ADe/zyUghdghMdRhEIOO0GB4WlZHaCEPqppFkMTljwpfgsLgi25lBertrWusJLdKdc59TbV/FAP+J3nVJ20iGKcWoRHhKeWt3lft5EzX37Cks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753764811; c=relaxed/simple;
	bh=Fdyx/OimqGQoKVQbQs/ah6wsPuKUqNgsq7edekvUva4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ps09giPxXn45yZtZ3v6Gmc5n23lefslTY4cUreKt5svTHZVwahqlit8BT4UXqb9WBvMnfKOTrncEjKMfMp0iwAf2F6fXuosB9mDD5IFFrcgUy4FDMw4/1A8ceHjQA6qF4wWdOYnWt2VUui2TQEMQriWQ08zAJNuRv2zm/v1DzPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=mHler/Pm; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Qi3htPNP2czm/a/W/z7KK1ldvUA9ttokkrJynE402W4=; b=mHler/PmoNoxEmo/FM+zuAP7Gk
	2+1P3jjec8elpvHkwdF2SlvRNX9V0070TA1h7XxKUpolSrILzlCnb6UO8HMtgsRUgWC45JsNZeY9V
	/CCaBlv64DMC5r3k2m1dHVObDbyIKTyHj2jbLhB9pIe2JegrDjMT3L2Fpf2Yl4UV/PCwqlwLmHquw
	VWMRdqOvMiozzlW4d6chX+Ep+skdPcTXiUSbJ6gdvOfizUS16LwuVukRk4qiDV18CQCHgAhbqwBJL
	sOjGBKcecyoGP2i33omUmvd5TfZlPEHBxrjhl7PBzE3HX6ucicA7jrFLoJ46BLSCe/Or5WG8fP6tR
	lky2i2uQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ugcL5-0000000GyEi-1B8C;
	Tue, 29 Jul 2025 04:53:23 +0000
Date: Tue, 29 Jul 2025 05:53:23 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Edward Adam Davis <eadavis@qq.com>
Cc: hirofumi@mail.parknet.co.jp, linkinjeon@kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	sj1557.seo@samsung.com,
	syzbot+d3c29ed63db6ddf8406e@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] fat: Prevent the race of read/write the FAT16 and FAT32
 entry
Message-ID: <20250729045323.GE222315@ZenIV>
References: <20250728163526.GD222315@ZenIV>
 <tencent_3066496863AAE455D76CD76A06C6336B6305@qq.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_3066496863AAE455D76CD76A06C6336B6305@qq.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Jul 29, 2025 at 12:17:21PM +0800, Edward Adam Davis wrote:
> > >
> > > Could you be more specific?  "Incomplete" in which sense?
> Because ent32_p and ent12_p are in the same union [1], their addresses are
> the same, and they both have the "read/write race condition" problem, so I
> used the same method as [2] to add a spinlock to solve it.

What the hell?  ent32_p and ent12_p are _pointers_; whatever races there
might be are about the objects they are pointing to.

> > > Which race condition would that be?
> data-race in fat32_ent_get / fat32_ent_put, detail: see [3]

References to KCSAN output are worthless, unless you can explain what the
actual problem is (no, "tool is not quiet" is *NOT* a problem; it might
or might not be a symptom of one).

> > Note that FAT12 situation is really different - we not just have an inevitable
> > read-modify-write for stores (half-byte access), we are not even guaranteed that
> > byte and half-byte will be within the same cacheline, so cmpxchg is not an
> > option; we have to use a spinlock there.
> I think for FAT12 they are always in the same cacheline, the offset of the
> member ent12_p in struct fat_entry is 4 bytes, and no matter x86-64 or arm64,
> the regular 64-byte cacheline is enough to ensure that they are in the same
> cacheline.

Have you actually read what these functions are doing?  _Pointers_ are not
problematic at all; neither ..._ent_get nor ..._ent_put are changing those,
for crying out loud!

If KCSAN is warning about those (which I sincerely doubt), you need to report
a bug in KCSAN.  I would *really* recommend verifying that first.

FAT12 problem is that FAT entries being accessed there are 12-bit, packed in
pairs into an array of 3-byte values.  Have you actually read what the functions
are doing?  There we *must* serialize the access to bytes that have 4 bits
from one entry and 4 from another - there's no such thing as atomically
update half a byte; it has to be read, modified and stored back.  If two
threads try to do that to upper and lower halves of the same byte at the
same time, the value will be corrupted.

The same *might* happen to FAT16 on (sub)architectures we no longer support;
there is  no way in hell we run into anything of that sort for (aligned) 32bit
stores.  Never had been.  And neither aligned 16bit nor aligned 32bit ever
had a problem with read seeing a state with only a part of value having
been written.

