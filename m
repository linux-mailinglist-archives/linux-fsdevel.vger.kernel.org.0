Return-Path: <linux-fsdevel+bounces-51773-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D7C29ADB3D9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 16:31:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02AFB1891542
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 14:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E4311F4612;
	Mon, 16 Jun 2025 14:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NTVakR5S"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E2B2BF017;
	Mon, 16 Jun 2025 14:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750084034; cv=none; b=QlTEYjWFshZrhgyt721Elx/2ph+WlmteXr4KNEZcFRrnJxxOojV0FfLoh1nyoFg7j/v4pDSwq5Ixsmxu1kylM9MCdShD+I0Ndw/SWy/30Q3YqU4jo3D+mqdvNA5oRazeLl/amei47LAlQBtg73NnaLAQTlirZF9LpAsr/iSuqk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750084034; c=relaxed/simple;
	bh=27LBzjkFKC0MWbPlUQj6Tt4KZ0Jk3l3sGSDRRlvA7Qg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rhqpd05+UhJQEADLxrAhSAapzJgcZXVebK45QjJlK94hmpzaxc/fRZnN1M+UsdySERbhtToGCRSGHuq2yXg8dOWjHKsYdGubF7GDLKyqY2pQM1jqKSFKYHebLQBfn+XXsfp8Lu8fSZCWo8O6STI+N98YHF3lZQKLUc8b5uMMA4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NTVakR5S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F3D8C4CEEA;
	Mon, 16 Jun 2025 14:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750084034;
	bh=27LBzjkFKC0MWbPlUQj6Tt4KZ0Jk3l3sGSDRRlvA7Qg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NTVakR5SXYu6c0BR4in/xtNji5OdDLRcOb+1S6kRPnlTkxHPWFuXHEYB2XKVOnV5V
	 XKW8fuD7PUAxa0hc9pOLobc3bi0uPxw+HNln+mqm/IAkPNktMrm+/b1hQwe4msPHOt
	 /RBrG+An7Q7/xCH/oFBha8sLE7asffKwinvo7s0gsMMJkwqWOFFVu1jWoUz0qVEXqh
	 8nYbEvxVezT7bLn6rjAKCURMMss27siUxZLadBGHlsr1LHHNUVo8hPE4huYEBXn5E5
	 fAacJRg0Mlzep6Qt2V5d4o+LEnwopKyEIQ5mGnZXFdLg6Twux+PSTbq1SyQ5q+r4bW
	 c85QZmNSdOsqg==
Date: Mon, 16 Jun 2025 16:27:07 +0200
From: Christian Brauner <brauner@kernel.org>
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Zhang Yi <yi.zhang@huaweicloud.com>, linux-fsdevel@vger.kernel.org, 
	linux-ext4@vger.kernel.org, linux-block@vger.kernel.org, dm-devel@lists.linux.dev, 
	linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org, linux-xfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, hch@lst.de, tytso@mit.edu, djwong@kernel.org, 
	john.g.garry@oracle.com, bmarzins@redhat.com, chaitanyak@nvidia.com, 
	shinichiro.kawasaki@wdc.com, yi.zhang@huawei.com, chengzhihao1@huawei.com, yukuai3@huawei.com, 
	yangerkun@huawei.com
Subject: Re: [PATCH 00/10] fallocate: introduce FALLOC_FL_WRITE_ZEROES flag
Message-ID: <20250616-wasser-replizieren-c47bcfaa418a@brauner>
References: <20250604020850.1304633-1-yi.zhang@huaweicloud.com>
 <yq17c1k74jd.fsf@ca-mkp.ca.oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <yq17c1k74jd.fsf@ca-mkp.ca.oracle.com>

On Mon, Jun 09, 2025 at 09:47:13PM -0400, Martin K. Petersen wrote:
> 
> Zhang,
> 
> > Changes since RFC v4:
> >  - Rebase codes on 6.16-rc1.
> >  - Add a new queue_limit flag, and change the write_zeroes_unmap sysfs
> >    interface to RW mode. User can disable the unmap write zeroes
> >    operation by writing '0' to it when the operation is slow.
> >  - Modify the documentation of write_zeroes_unmap sysfs interface as
> >    Martin suggested.
> >  - Remove the statx interface.
> >  - Make the bdev and ext4 don't allow to submit FALLOC_FL_WRITE_ZEROES
> >    if the block device does not enable the unmap write zeroes operation,
> >    it should return -EOPNOTSUPP.
> 
> This looks OK to me as long as the fs folks agree on the fallocate()
> semantics.

That looks overall fine. Should I queue this up in the vfs tree?

