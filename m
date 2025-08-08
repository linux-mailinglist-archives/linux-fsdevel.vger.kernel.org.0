Return-Path: <linux-fsdevel+bounces-57054-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61A09B1E775
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 13:37:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57F8D188BD1E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 11:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52935273D6C;
	Fri,  8 Aug 2025 11:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="v57oPpag"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from kylie.crudebyte.com (kylie.crudebyte.com [5.189.157.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE21242D6E;
	Fri,  8 Aug 2025 11:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.189.157.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754653066; cv=none; b=OLNQMZ1cD9SycgH8cKT2SnpW+U17lKbJeYCEXCxIVVgw/Rqc8s+/zuRgrC+H/bvMxIDPWMqfulK+/G3StuOGsIzoHsBxTW8n1i6nMs9HDkTx9YB2V5V4pWwTtuY6EHFFj7/p7066srzes0Wjib/PZ7TKPmCvdzfWPAEaygp0txY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754653066; c=relaxed/simple;
	bh=q86u2q3E0J9VVCxDEgPxY2X12X8ilwraUch8EX+MS8M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CdS56FwEaD/4IMK6tOfMszcZytw7Us2dkIZHVejwvOtJXi++lwGGT2LmZZYQCAEbJcgHsxR2EsTVj9K/rw4T4EgWlrTi0kFpCnA6jE5E98N+ZebIT/l+s0oOFM6yZwzlnFHTFvwFVkPsHa0BOEqu+YlrRmENko2WNIuR23JRTvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crudebyte.com; spf=pass smtp.mailfrom=crudebyte.com; dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b=v57oPpag; arc=none smtp.client-ip=5.189.157.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crudebyte.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Content-ID:Content-Description;
	bh=2qBntLxlZ49ZMmoDuyXBV++1xNmyGAoNPONRB31R6QY=; b=v57oPpaghOOCrtFx39Vet4uGwu
	Ij9hUaWJ2CHHln+l+fvTrpzwIfS4nruPcDPVuDkhwS3lo1tmZjqNUxrDOdVHp2Ec68uI3Tm8Z6+lr
	JXvIpuw/btvuznFF6RaP4NYlUSShQw82TN0fkmcy90i/h/6xwzxo0smBzxS4Kh9uJ/IG39BTdzZdk
	Y1GNaxWz2rAT+6E4LM03eUDWa7hYwRe0q0V2W9AvsuPCH+n7mhsfcJnjXLimZI54Ig0JSaeEnYkyG
	/N4mp6GABgvCTICGQPK2Od33JkdWG36WXQavVXusiDln9UB3yDwN97EFCfV+PL8Ti7708yBGJtJXU
	CRlogAqBOWenyZ21inBGPbwXyIqbWeSwR53bt2TqvHrzrjbjZTYmUBIHGLr/xQe8pCa0v7rQK2zbo
	OUMmS0zvi0VtBe4FXRSHcz2nQm6TINsWdyJA73rtqLyrY4dhlmJDOZ7DLLYbHrTzyvHDVKrFVtLdo
	ep/O6i+aSs+oEhXZiScvVUMzSExbA/Uoz7H1nU8B8OPJtF8lig5XidOKBhBeS+zpLmwCCi8334JCQ
	v+FMVJDroTEKu9yFYa8Ueq3AvdJQ1qL6BMw9zExpa18U/3GvWGwtGn+6QgEi1QwUCaGkhg9h3vbM2
	kergTBKoT0fEzzA12BerWlmNFaiD4h2VlNKj2cKKo=;
From: Christian Schoenebeck <linux_oss@crudebyte.com>
To: Tingmao Wang <m@maowtm.org>, Dominique Martinet <asmadeus@codewreck.org>
Cc: Eric Van Hensbergen <ericvh@kernel.org>,
 Latchesar Ionkov <lucho@ionkov.net>, v9fs@lists.linux.dev,
 =?ISO-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
 =?ISO-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
 linux-security-module@vger.kernel.org, Jan Kara <jack@suse.cz>,
 Amir Goldstein <amir73il@gmail.com>, Matthew Bobrowski <repnop@google.com>,
 linux-fsdevel@vger.kernel.org
Subject:
 Re: [RFC PATCH 0/6] fs/9p: Reuse inode based on path (in addition to qid)
Date: Fri, 08 Aug 2025 12:52:38 +0200
Message-ID: <13395769.lPas3JvW2k@silver>
In-Reply-To: <aJXRAzCqTrY4aVEP@codewreck.org>
References:
 <cover.1743971855.git.m@maowtm.org> <aJXRAzCqTrY4aVEP@codewreck.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday, August 8, 2025 12:27:15 PM CEST Dominique Martinet wrote:
> Sorry for the delay...
> 
> Tingmao Wang wrote on Sun, Apr 06, 2025 at 09:43:01PM +0100:
> > Unrelated to the above problem, it also seems like even with the revert in
> > [2], because in cached mode inode are still reused based on qid (and type,
> > version (aka mtime), etc), the setup mentioned in [2] still causes
> > problems in th latest kernel with cache=loose:
> 
> cache=loose is "you're on your own", I think it's fine to keep as is,
> especially given qemu can handle it with multidevs=remap if required

As of QEMU 10.0, multidevs=remap (i.e. remapping inodes from host to guest) is
now the default behaviour, since inode collisions were constantly causing
issues and confusion among 9p users.

And yeah, cache=loose means 9p client is blind for whatever changes on 9p
server side.

/Christian



