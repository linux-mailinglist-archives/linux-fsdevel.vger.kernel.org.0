Return-Path: <linux-fsdevel+bounces-46171-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 74D66A83CA8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Apr 2025 10:23:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 965E91B661F7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Apr 2025 08:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5817C20E022;
	Thu, 10 Apr 2025 08:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RpWvJqaK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5AA1E5B97;
	Thu, 10 Apr 2025 08:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744273243; cv=none; b=e/30LSeMjdvHTOKpSuuuc7QKZXHqa4GsW33JleqNWYs12sz9IyTx1ghzVQxgK1Y3LFrG/DCrGERShr2Fb2aoyjMR+9m7/U88lsyTsnUvT39WtErjdRhz0sBlWal/jLFaxU6B4rDbvAH+ZoHk2H72y8bSnZh2N8f2HtXIVxhBal0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744273243; c=relaxed/simple;
	bh=YgQZI2+bS0r3KyGq34MBVFDhX4BUm2eJmrGkw/kgVT8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rVqO4kuXpWS9HOREq0Yi4BpSe0ESUxS9gwFG2aRHuBxIuZhuDuhADOB9JWtH8Rh20Db8w5YCaBU/qTPaSRM3Czj7gb7WSmFxyU/GDgl9k5EPNogeplLiBnrL5u6aMTkRKKusL34JWZ7S+afjDktDS1j7gMMG54bucsTyhpFaWL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RpWvJqaK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50ECCC4CEE3;
	Thu, 10 Apr 2025 08:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744273243;
	bh=YgQZI2+bS0r3KyGq34MBVFDhX4BUm2eJmrGkw/kgVT8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RpWvJqaKvTE/btMBJezY0+TzIVZFo6iMd3QE9E3IGJVCDFd2F76GVsz57hOknfpE5
	 jZxllrJ3N3DbH3+uv9ZHHYrrfFgyRcK7QqSakVZiTg5lJs+o+nwwllB2G2g2ivYJ0f
	 XZdHUzjN71la1YQ85wZ+ULJsoBZKXmxNkFFfI7zZILynyLL+8H34GHTgc8exE4YpLM
	 Wv85WSPJn19pxfUXpjS18ukegqDYAleOgGZ/39ODRJvzIgCsFk2LqnmO6ok1NfZjTh
	 p23jjdXQODTYtCQ9mESNPxKIFf4ZQAK9pzJunWbJgfcyy6XJVURM9aoh5Ev+5mz0DX
	 Fm0HaSUcp0csw==
Date: Thu, 10 Apr 2025 09:20:36 +0100
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Zhang Yi <yi.zhang@huaweicloud.com>, linux-fsdevel@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-block@vger.kernel.org,
	dm-devel@lists.linux.dev, linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, tytso@mit.edu, djwong@kernel.org,
	john.g.garry@oracle.com, bmarzins@redhat.com, chaitanyak@nvidia.com,
	shinichiro.kawasaki@wdc.com, yi.zhang@huawei.com,
	chengzhihao1@huawei.com, yukuai3@huawei.com, yangerkun@huawei.com
Subject: Re: [RFC PATCH -next v3 01/10] block: introduce
 BLK_FEAT_WRITE_ZEROES_UNMAP to queue limits features
Message-ID: <Z_d_VDvgBkgt4UhS@kbusch-mbp>
References: <20250318073545.3518707-1-yi.zhang@huaweicloud.com>
 <20250318073545.3518707-2-yi.zhang@huaweicloud.com>
 <20250409103148.GA4950@lst.de>
 <43a34aa8-3f2f-4d86-be53-8a832be8532f@huaweicloud.com>
 <20250410071559.GA32420@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250410071559.GA32420@lst.de>

On Thu, Apr 10, 2025 at 09:15:59AM +0200, Christoph Hellwig wrote:
> On Thu, Apr 10, 2025 at 11:52:17AM +0800, Zhang Yi wrote:
> > 
> > Thank you for your review and comments. However, I'm not sure I fully
> > understand your points. Could you please provide more details?
> > 
> > AFAIK, the NVMe protocol has the following description in the latest
> > NVM Command Set Specification Figure 82 and Figure 114:
> > 
> > ===
> > Deallocate (DEAC): If this bit is set to `1´, then the host is
> > requesting that the controller deallocate the specified logical blocks.
> > If this bit is cleared to `0´, then the host is not requesting that
> > the controller deallocate the specified logical blocks...
> > 
> > DLFEAT:
> > Write Zeroes Deallocation Support (WZDS): If this bit is set to `1´,
> > then the controller supports the Deallocate bit in the Write Zeroes
> > command for this namespace...
> 
> Yes.  The host is requesting, not the controller shall.  It's not
> guaranteed behavior and the controller might as well actually write
> zeroes to the media.  That is rather stupid, but still.

I guess some controllers _really_ want specific alignments to
successfully do a proper discard. While still not guaranteed in spec, I
think it is safe to assume a proper deallocation will occur if you align
to NPDA and NPDG. Otherwise, the controller may do a read-modify-write
to ensure zeroes are returned for the requested LBA range on anything
that straddles an implementation specific boundary.

