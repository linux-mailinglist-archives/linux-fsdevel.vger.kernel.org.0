Return-Path: <linux-fsdevel+bounces-16795-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 32F858A2D6F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Apr 2024 13:29:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C98AD1F223E6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Apr 2024 11:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1773B54BEA;
	Fri, 12 Apr 2024 11:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="dt2SN8bc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FEF042069;
	Fri, 12 Apr 2024 11:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712921376; cv=none; b=h03N62oRafCta9wf/PJckFxKezIhSlLykLuOmrByLWC2DIodfjmLXttm6Hm2Uaf2CMN1/htkvOsdaYmo0MSL5sHe+tm9GT7Ky55zXpU+BXXvZ1GZVm2IGzFJOZhATEjHkhisARjqus33YvVpaD9cIafTE8tvDkW7yp7p53nTeEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712921376; c=relaxed/simple;
	bh=kMGYNWu6GFRSJjGCKwdnJ4mn5dBo1RiNBMBClBdUXtI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=azp7VYGjRlxXSpvD54FopwGaljMQiCJkAR5HUiaTpveXY6KqXGOwLnFUBk6N8F1CKspXc0umfaZms4VEsr2Fka8igq03o3+zM4nvLp0FbGw59NzuxzI3V9xrT1PDUDXFREwfPaYTOIqheZEDrurR5px2nhF72OYOxQYq14yIyZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=dt2SN8bc; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=kMGYNWu6GFRSJjGCKwdnJ4mn5dBo1RiNBMBClBdUXtI=; b=dt2SN8bcjqv/LfKAeXM/5V5htV
	h+eeV78URZQ1NOp41L23kFnPiNryTRrwjKl+DF+oviyAo3ApCOysG5lQKsMOh5FhfjjQdOEyy+Sd5
	1ktDdwDi4C3QgOFKiCNJMV4FkpR88p2758mI5GVPiz4ih6Me/fKesOC+gGHp69Ap6LdXi1KxSM77e
	pfqF4e0qO9+5hEHuCxIA2ngYVE/auI8yr4R5Ds46yT+HjidNjkRMs61BvvT9w2FU4+3Q0fg+AfhSx
	8BwCsYPwZgaPw4UP6WIyDM3zi84uudauNuiHPc0ivHSdCqLDA5w3QCgzjRf+Cib+qiMh9dgSgRqWi
	9YRX9/EA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rvF5r-00B7tI-0H;
	Fri, 12 Apr 2024 11:29:19 +0000
Date: Fri, 12 Apr 2024 12:29:19 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Yu Kuai <yukuai1@huaweicloud.com>, hch@lst.de,
	axboe@kernel.dk, linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org, yi.zhang@huawei.com,
	yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH vfs.all 22/26] block: stash a bdev_file to read/write raw
 blcok_device
Message-ID: <20240412112919.GN2118490@ZenIV>
References: <21d1bfd6-76f7-7ffb-34a4-2a85644674fe@huaweicloud.com>
 <20240407030610.GI538574@ZenIV>
 <8f414bc5-44c6-fe71-4d04-6aef3de8c5e3@huaweicloud.com>
 <20240409042643.GP538574@ZenIV>
 <49f99e7b-3983-8074-bb09-4b093c1269d1@huaweicloud.com>
 <20240410105911.hfxz4qh3n5ekrpqg@quack3>
 <20240410223443.GG2118490@ZenIV>
 <20240411-logik-besorgen-b7d590d6c1e9@brauner>
 <20240411140409.GH2118490@ZenIV>
 <20240412-egalisieren-fernreise-71b1f21f8e64@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240412-egalisieren-fernreise-71b1f21f8e64@brauner>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Apr 12, 2024 at 11:21:08AM +0200, Christian Brauner wrote:

> Your series just replaces bd_inode in struct block_device with
> bd_mapping. In a lot of places we do have immediate access to the bdev
> file without changing any calling conventions whatsoever. IMO it's
> perfectly fine to just use file_mapping() there. Sure, let's use
> bdev_mapping() in instances like btrfs where we'd otherwise have to
> change function signatures I'm not opposed to that. But there's no good
> reason to just replace everything with bdev->bd_mapping access. And
> really, why keep that thing in struct block_device when we can avoid it.

Because having to have struct file around in the places where we want to
get to page cache of block device fast is often inconvenient (see fs/buffer.c,
if nothing else).

It also simplifies the hell out of the patch series - it's one obviously
safe automatic change in a single commit.

And AFAICS the flags-related rationale can be dealt with in a much simpler
way - see #bf_flags in my tree.

