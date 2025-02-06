Return-Path: <linux-fsdevel+bounces-41083-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54B62A2AAD5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 15:14:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C89FE3A31F8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 14:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 721151C7017;
	Thu,  6 Feb 2025 14:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XxUpQ+/c"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B191EA7FD;
	Thu,  6 Feb 2025 14:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738851240; cv=none; b=S39htpn/Amgwk7AYzzgYUWdck/VFHI5hcu2XBL8LQRJq9Bu/phSnPSFfxpV/9CA7ZPQO9qG2/iwqxVK1fsJ+Zcs/1uKGU62iF92e4XsIWFNtg2Yd4LYo1QBEM5pm4ZW/3+WI5fL2aG5YN9VsXP/pS07ZaI5BdiGYRukEU6Y2N2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738851240; c=relaxed/simple;
	bh=tTBBelsNUMJLiUlBRo5iz08MdzfXwXbrIJIT/U3WWTQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QrEnDXudw3HA/OVJHwWrrpbamSsVvPP+TJzF8Fra3n5A6B0tITNmvGLgAjok1751ZEwUB8ZOEHwtjDngNOdvl0+o0LmZUEMzyTBFwCdQ5hTHTMv7WLBQYyw4OPWiu1pPhWx80aVa5NgMy+oQmH5FIQOtizeJ2D4uy3oycSytcJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=XxUpQ+/c; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=gx2rvxr9FDs6g9AxWi9cdLIxGf+1LckzyMEZQup3niQ=; b=XxUpQ+/crIIp8MBeT7WtlWu332
	gDkDAMd+T0bYn4DLXue4hzCrx//a0QJ6XBNcMNxAWsV6LCmQOKEPD1v5ruW5boWORTd8k1YbBPGjA
	8oB5l/pmvffotAINOjG4ggNjYJwMC2IO3pZhenA9fBy8G6nKNPdmZZrXE4OF6Xkdjo4fu0dj3PhjH
	18TH/Pr/zdrQ0uVxSe+p5/C4mx83HblKX55qS5oTf+e4Rx9m1CqtTYdhYo2/14Mtf5rFB+hpWvOwj
	J92I1YoEMOWXbS6c27EUSsLZ8ZNvG3ixbuA+rMHh2F4qmmtpf9sFrA26KxebHfbcBlYfm9KzuIz4i
	AzjY885A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tg2dh-00000006XG8-35IP;
	Thu, 06 Feb 2025 14:13:57 +0000
Date: Thu, 6 Feb 2025 06:13:57 -0800
From: "hch@infradead.org" <hch@infradead.org>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2] btrfs: always fallback to buffered write if the inode
 requires checksum
Message-ID: <Z6TDpRo8ijZUt29d@infradead.org>
References: <e9b8716e2d613cac27e59ceb141f973540f40eef.1738639778.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e9b8716e2d613cac27e59ceb141f973540f40eef.1738639778.git.wqu@suse.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Feb 04, 2025 at 02:00:23PM +1030, Qu Wenruo wrote:
> [BUG]
> It is a long known bug that VM image on btrfs can lead to data csum
> mismatch, if the qemu is using direct-io for the image (this is commonly
> known as cache mode none).
> 
> [CAUSE]
> Inside the VM, if the fs is EXT4 or XFS, or even NTFS from Windows, the
> fs is allowed to dirty/modify the folio even the folio is under
> writeback (as long as the address space doesn't have AS_STABLE_WRITES
> flag inherited from the block device).

Btw, can you add an xfstests that reproduces this by modifying pages
under direct I/O?  That would be really helpful to verify the code when
we want to turn back on real direct I/O eventually when the VM is fixed
to prevent the modifications.


