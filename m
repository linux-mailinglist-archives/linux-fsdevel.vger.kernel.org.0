Return-Path: <linux-fsdevel+bounces-40569-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0DC5A25465
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 09:27:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D8E6161958
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 08:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E95B81FC0FB;
	Mon,  3 Feb 2025 08:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TH4aMWR4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F074F1FA859;
	Mon,  3 Feb 2025 08:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738571206; cv=none; b=KNK++JUcgbn9rkrGW0L3Gfw+cnlXguVKQzjZqBP05RA+EbCx4LpeH5250L9/p46eHfQW9NVPz4o1GFg4fFcHafD2kCWXwGXHsZd9WCumRoVj6jd3Zw7e7c9POjaT6aUK8Gh7z+EHAjJ3PmVbij1wxlG+u321KntrDtkZ2+gZxQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738571206; c=relaxed/simple;
	bh=ElcnKc7ggHQtZj/dI//f+DvKZfFtsRk990tvXDo3yfA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NglKW2xTnTsGp7eyTykznMlORZZBVqbbg8gDCzGPfOkLJlgkctIpDf0+FbzSz/DxvA0imjrfA06Hnpjii1QWMPJ7yohzt5auFhOCRAsaViC33+SFYxxY5x/QICJJKZ/ZP4h99NUtesf7CSs8jDc1b/1hvaDWo0/WjJXfJbhAzs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=TH4aMWR4; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=+DPlPVTXHHQ+Xo8ld/N2ryqVQ9X+N2CpviGEAb9r8W0=; b=TH4aMWR4o0Nimu5uYbLVMk9zbh
	h4NljevwIyFt5pXq0ZJVv/TwBqZJgOIxTWt6ZEAMRd4wX8K8MCiTLFhuMqrSq6TtvqOUYrUpbesZO
	3J72/g/E4haIeEtqpKeNgnxeNyCFg5ZeQblfFBfzZ71kypSy+BWWL6d4BHh7X3N5VB0fp/B9aFVhW
	vwdpIfWdpsWKhULtZOJzq2bP6d5lnZGniQQ37QrGrTQ0Y3sUVv2Rnqi4m2CiOcrgZN6530pgEVY4f
	T5NuzBqUfdk/HbXB5byAWa73/V1oVrXt5kF2tkt4yPfq4fDxI25G3MNCYpCDQ4K4+Cr7moDgCyUyT
	Ws26Vj4g==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1termr-00000000iiC-1obY;
	Mon, 03 Feb 2025 08:26:33 +0000
Date: Mon, 3 Feb 2025 08:26:33 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Qu Wenruo <wqu@suse.com>
Cc: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
	"hch@infradead.org" <hch@infradead.org>,
	Kanchan Joshi <joshi.k@samsung.com>, Theodore Ts'o <tytso@mit.edu>,
	"lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"josef@toxicpanda.com" <josef@toxicpanda.com>
Subject: Re: [LSF/MM/BPF TOPIC] File system checksum offload
Message-ID: <Z6B9uSTQK8s-i9TM@casper.infradead.org>
References: <CGME20250130092400epcas5p1a3a9d899583e9502ed45fe500ae8a824@epcas5p1.samsung.com>
 <20250130091545.66573-1-joshi.k@samsung.com>
 <20250130142857.GB401886@mit.edu>
 <97f402bc-4029-48d4-bd03-80af5b799d04@samsung.com>
 <b8790a76-fd4e-49b6-bc08-44e5c3bf348a@wdc.com>
 <Z6B2oq_aAaeL9rBE@infradead.org>
 <bb516f19-a6b3-4c6b-89f9-928d46b66e2a@wdc.com>
 <eaec853d-eda6-4ee9-abb6-e2fa32f54f5c@suse.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eaec853d-eda6-4ee9-abb6-e2fa32f54f5c@suse.com>

On Mon, Feb 03, 2025 at 06:46:49PM +1030, Qu Wenruo wrote:
> It's pretty common to reproduce, just start a VM with an image on btrfs, set
> the VM cache mode to none (aka, using direct IO), and run XFS/EXT4 inside
> the VM, run some fsstress it should cause btrfs to hit data csum mismatch
> false alerts.
> 
> The root cause is the content change during direct IO, and XFS/EXT4 doesn't
> wait for folio writeback before dirtying the folio (if no AS_STABLE_WRITES
> set).
> That's a valid optimization, but that will cause contents change.

XFS honours the bdev flag:

static inline void xfs_update_stable_writes(struct xfs_inode *ip)
{
        if (bdev_stable_writes(xfs_inode_buftarg(ip)->bt_bdev))
                mapping_set_stable_writes(VFS_I(ip)->i_mapping);
        else
                mapping_clear_stable_writes(VFS_I(ip)->i_mapping);
}

so this is a block layer issue if it's not set.

> (I know there is the AS_STABLE_WRITES, but I'm not sure if qemu will pass
> that flag to virtio block devices inside the VM)

