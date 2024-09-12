Return-Path: <linux-fsdevel+bounces-29170-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D19EE9769AE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2024 14:54:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4ADF9B24A7D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2024 12:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A1CD1A4E86;
	Thu, 12 Sep 2024 12:53:58 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78DCF19F424;
	Thu, 12 Sep 2024 12:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726145638; cv=none; b=jfeFSL6d7p6gYdsEUZBpsg9yFxmne0tJdl0uujd6XakBT2Tww1KCNqscWjOgqMcUcpP37wWjbb2Wx10Y1W4k4b70P6fwEdjXkpd0GgDIO680b2Oikpl6LxB6xr17O4GEn8AB07eeTZ1oAZK22nDh3Ew7/G0h6JOAoOHuDP3oJEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726145638; c=relaxed/simple;
	bh=vIKfxdpXoZ/XNeIbpIk/mUSnEFEaryGhqrhIpPs460c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yu9JFUSEdD/21IzjPmzg8Aq2dRZ33vwHqJHabpqkoDfXIohlA8blYD0/Ugzndytkhq7vkoQ51Kl/G9cH7XaRaSq9x18wYgIX8iq3sNFSoZijy1jkOfdMjXql5WTV7HRx8S3RoYRyxBnaMcQry7gesOn/938ECB+Kt5gChGu6hbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1096E227AAF; Thu, 12 Sep 2024 14:53:48 +0200 (CEST)
Date: Thu, 12 Sep 2024 14:53:47 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
	martin.petersen@oracle.com, James.Bottomley@HansenPartnership.com,
	brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz,
	jaegeuk@kernel.org, jlayton@kernel.org, chuck.lever@oracle.com,
	bvanassche@acm.org, linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net, linux-block@vger.kernel.org,
	linux-scsi@vger.kernel.org, gost.dev@samsung.com,
	vishak.g@samsung.com, javier.gonz@samsung.com
Subject: Re: [PATCH v5 1/5] fs, block: refactor enum rw_hint
Message-ID: <20240912125347.GA28068@lst.de>
References: <20240910150200.6589-1-joshi.k@samsung.com> <CGME20240910151044epcas5p37f61bb85ccf8b3eb875e77c3fc260c51@epcas5p3.samsung.com> <20240910150200.6589-2-joshi.k@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240910150200.6589-2-joshi.k@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Sep 10, 2024 at 08:31:56PM +0530, Kanchan Joshi wrote:
> Rename enum rw_hint to rw_lifetime_hint.
> Change i_write_hint (in inode), bi_write_hint(in bio), and write_hint
> (in request) to use u8 data-type rather than this enum.
> 
> This is in preparation to introduce a new write hint type.

The rationale seems a bit sparse.  Why is it renamed?  Because the
name fits better, because you need the same for something else?

>  static void submit_bh_wbc(blk_opf_t opf, struct buffer_head *bh,
> -			  enum rw_hint hint, struct writeback_control *wbc);
> +			  u8 hint, struct writeback_control *wbc);

And moving from the enum to an plain integer seems like a bit of a
retrograde step.


