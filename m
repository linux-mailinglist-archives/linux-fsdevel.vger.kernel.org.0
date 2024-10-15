Return-Path: <linux-fsdevel+bounces-31937-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0938299DD7A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2024 07:26:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3D4D1F23A0F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2024 05:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C56AC176231;
	Tue, 15 Oct 2024 05:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="4/7yZqc/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E936158D9C;
	Tue, 15 Oct 2024 05:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728969958; cv=none; b=cU+HZKsCLiXIzmERiQzUixv8i6u0NrJO9crtUvmTkAD3wZ/qvGENiimXPioXPzvh3YRGmUXuw/+nArg2RS+c/SBljTaFYpsLuywdBXhPrnypcPIa63isIRD+ycPdezFLu7Hq5KNTBQ54gQGvC9jzLhjhdIDpJnXbLg7T7eivMMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728969958; c=relaxed/simple;
	bh=w3NvioodbzuHowQ5dRt9a9MQJLsZvOqryodBp0IN5NY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K5Ujitu/t76+IAu4lFQpNMY4pBRTzmIyguXGldpPIDUrNmQTP4mlJZLza5liliDrbb6GAB8hwj/xSVVNprusjQtbN5F7/eItMSRPLb7AGW6B0RziW+ECcx2+oDmOYCNC0YHzpFXnmZatjV77UWMAh6lWBMmhxIh0KQefd1ro4Tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=4/7yZqc/; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=X61thiCQ2MrPzuNzqJSyAOXJpMPhhB5o1RAuj5AlnTs=; b=4/7yZqc/y3R0G1x5i4COOsUBn7
	y5SGuQzsgEEqTOTut/qkDz//qtfn7gKjPLfRQON/c5cuUVvVn1Dyc0bvNx7WeyjnPdBsZS25Y/1t+
	OMJc0R1Qo0X8DITjUXNeLBtBXewEOIjKGmC2EiZIQ3odmeXOSLVLpkO3uW1/91713JiyDyl99Di/d
	MuZ1Uc7uvSaWKdcrXqSEUTOTOF9KZSnvpEoIekYSHqst6WTG062Z7tUH7V+ZpSudcp2MAxdMvS3Zk
	m5nPOOAOXJA3gJeWSyvNkHTrY4R6mj6GPzQsTk150b2KRMIeWqC5PJcvlU6RU8dM5J8yJkXgPoQQP
	1GPT874Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t0a49-000000076SB-2YGp;
	Tue, 15 Oct 2024 05:25:53 +0000
Date: Mon, 14 Oct 2024 22:25:53 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Song Liu <songliubraving@meta.com>
Cc: Christoph Hellwig <hch@infradead.org>, Song Liu <song@kernel.org>,
	bpf <bpf@vger.kernel.org>,
	Linux-Fsdevel <linux-fsdevel@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Kernel Team <kernel-team@meta.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	KP Singh <kpsingh@kernel.org>,
	Matt Bobrowski <mattbobrowski@google.com>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Extend test fs_kfuncs to
 cover security.bpf xattr names
Message-ID: <Zw384bed3yVgZpoc@infradead.org>
References: <20241002214637.3625277-1-song@kernel.org>
 <20241002214637.3625277-3-song@kernel.org>
 <Zw34dAaqA5tR6mHN@infradead.org>
 <0DB83868-0049-40E3-8E62-0D8D913CB9CB@fb.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0DB83868-0049-40E3-8E62-0D8D913CB9CB@fb.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Oct 15, 2024 at 05:21:48AM +0000, Song Liu wrote:
> >> Extend test_progs fs_kfuncs to cover different xattr names. Specifically:
> >> xattr name "user.kfuncs", "security.bpf", and "security.bpf.xxx" can be
> >> read from BPF program with kfuncs bpf_get_[file|dentry]_xattr(); while
> >> "security.bpfxxx" and "security.selinux" cannot be read.
> > 
> > So you read code from untrusted user.* xattrs?  How can you carve out
> > that space and not known any pre-existing userspace cod uses kfuncs
> > for it's own purpose?
> 
> I don't quite follow the comment here. 
> 
> Do you mean user.* xattrs are untrusted (any user can set it), so we 
> should not allow BPF programs to read them? Or do you mean xattr 
> name "user.kfuncs" might be taken by some use space?

All of the above.


