Return-Path: <linux-fsdevel+bounces-61731-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A920B59803
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 15:44:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE1BD4618D7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 13:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A173A31B10A;
	Tue, 16 Sep 2025 13:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="aAgNAUG/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from kylie.crudebyte.com (kylie.crudebyte.com [5.189.157.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E167331A05B;
	Tue, 16 Sep 2025 13:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.189.157.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758030227; cv=none; b=gUMBmUw/KnD0efoJ5QchAANx0aklDD074eLQUis0hzUmVzSBlMxKdyTFn1J6aqeMQ7x8awMn5IdltApaurk/CVvAQUyTWcpwGdb54Ba31gjMfwQchVGADSoGNQDxzTeOr2roDX3OZZBiXx+NAh9OaWajmrZf0MOrBhpUStJhQqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758030227; c=relaxed/simple;
	bh=4RPsniceCxTbDvIQYtXo7KbQrexVuJ3owhcslNfqKlE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X+p5EqNvAXV5g5/5RnN3/5/JLn/0FtQQOm3mQWhA3FV9wd++XNm8vunKAklSEAUmriuCoJHIjQb/zWklcgUwrMJT+5No+3+N0F62Or09/sJdjcE/GQcxUgiPmtpjDX4qtr7Zp2jLtMcd4/xp54FT9G+CGw6hqLOL9qr4qK6yoo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crudebyte.com; spf=pass smtp.mailfrom=crudebyte.com; dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b=aAgNAUG/; arc=none smtp.client-ip=5.189.157.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crudebyte.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Content-ID:Content-Description;
	bh=7ImHOzG3mjGym1iYUJc4foIPK8/k8Yedk8oGlL7UsVY=; b=aAgNAUG/wunDgGVcWNxOFDQJaT
	hx3bS58WhDpIWZeFUX9lLiCpL/r9ic212DUwcF2xi56C9CROL43qnc3M/fzM7G2Z05b1tpyGEhT28
	SnRzs36jaMEa73sH1SEWyG6hkMd82Ofm+IkOHh5dCuo5phpBtkUJHEvrNc3NlmK1DV/J0gb0iLAQi
	uSZ/PjEymNRBxrrl4NOCXCfjjSFdiHqOgWMMRXzNXWu8KGFE6w2xavO7Y4C7vQVaFCWpIY4mjAjFY
	wps1U+SzvyEERlN7MJ8jjbl9HSpMekw/M8h3kyzpXaR9mDxnwtgUREZrNgnf3jfQlwd+TENJO5QQt
	kh7V7o4CuEQDWSOoMgKN9ytrDZPLpOTPXgu6A1D4SIZBDexdJ/zw2CGXtX+u0tCNf4EiHHHdQytiy
	hy77IDNIizcO8VDnkscPlFnkNMItyKyve7bk51G9Olfdi4P3Rt4xFO5dUQRW3adcfg2fHnkD+rDVb
	m1LHPsSdUvnsOuphSd66/YLB4YD1o3h/j/8wblaaJWrAlgzuvz28lR1sVace45NV2q9ImcMmW3io+
	kOeT/WF/x8o9nVnCEVW4h7uSipowuSoRZtSdizFnzQlMnTEblxABRPY0obZ1S1m6tS0Jc0I7WFjC0
	de3JYIIiphuqBUy6aCrIO+jgMo5cdRbDUYlu4Bf3U=;
From: Christian Schoenebeck <linux_oss@crudebyte.com>
To: Dominique Martinet <asmadeus@codewreck.org>, Tingmao Wang <m@maowtm.org>
Cc: =?ISO-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
 Eric Van Hensbergen <ericvh@kernel.org>, Latchesar Ionkov <lucho@ionkov.net>,
 v9fs@lists.linux.dev, =?ISO-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
 linux-security-module@vger.kernel.org, Jan Kara <jack@suse.cz>,
 Amir Goldstein <amir73il@gmail.com>, Matthew Bobrowski <repnop@google.com>,
 Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>,
 linux-fsdevel@vger.kernel.org
Subject:
 Re: [PATCH v2 0/7] fs/9p: Reuse inode based on path (in addition to qid)
Date: Tue, 16 Sep 2025 15:43:33 +0200
Message-ID: <16279923.yzM2DkEX5f@silver>
In-Reply-To: <6502db0c-17ed-4644-a744-bb0553174541@maowtm.org>
References:
 <aMih5XYYrpP559de@codewreck.org>
 <6502db0c-17ed-4644-a744-bb0553174541@maowtm.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tuesday, September 16, 2025 2:44:27 PM CEST Tingmao Wang wrote:
> On 9/16/25 00:31, Dominique Martinet wrote:
[...]
> >> I tried mounting a qemu-exported 9pfs backed on ext4, with
> >> multidevs=remap, and created a file, used stat to note its inode number,
> >> deleted the file, created another file (of the same OR different name),
> >> and that new file will have the same inode number.
> >> 
> >> (If I don't delete the file, then a newly created file would of course
> >> have a different ext4 inode number, and in that case QEMU exposes a
> >> different qid)
> > 
> > Ok so from Christian's reply this is just ext4 reusing the same inode..
> > I briefly hinted at this above, but in this case ext4 will give the
> > inode a different generation number (so the ext4 file handle will be
> > different, and accessing the old one will get ESTALE); but that's not
> > something qemu currently tracks and it'd be a bit of an overhaul...
> > In theory qemu could hash mount_id + file handle to get a properly
> > unique qid, if we need to improve that, but that'd be limited to root
> > users (and to filesystems that support name_to_handle_at) so I don't
> > think it's really appropriate either... hmm..
> 
> Actually I think I forgot that there is also qid.version, which in the
> case of a QEMU-exported 9pfs might just be the file modification time?  In
> 9pfs currently we do reject a inode match if that version changed server
> side in cached mode:
> 
> v9fs_test_inode_dotl:
> 	/* compare qid details */
> 	if (memcmp(&v9inode->qid.version,
> 		   &st->qid.version, sizeof(v9inode->qid.version)))
> 		return 0;
> 
> (not tested whether QEMU correctly sets this version yet)

Define "correctly". ;-) QEMU sets it like this since 2010:

  qidp->version = stbuf->st_mtime ^ (stbuf->st_size << 8);

https://github.com/qemu/qemu/blob/190d5d7fd725ff754f94e8e0cbfb69f279c82b5d/hw/9pfs/9p.c#L1020

/Christian



