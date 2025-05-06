Return-Path: <linux-fsdevel+bounces-48264-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C769AACA2E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 17:55:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 113EF5226D0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 15:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D117284676;
	Tue,  6 May 2025 15:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YA/lDEym"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9341427FD67;
	Tue,  6 May 2025 15:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746546918; cv=none; b=RCmQWK8JeMm0JUN34d0YhXl/2DQ4tMmjzyWBUPt7xCf/23mjl7Q64v5iPbIZg/WAbO2fGr8HnAIMllfcMBZTUbC3MtVEYhtW7D4vQ3C4lA0BP3QQ/vjnNWqhVzI+fLxrEp4XSu2Q1OiA+TjQjRHh8AwUeG7lsa0FALzrm5uuCsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746546918; c=relaxed/simple;
	bh=KokwTcsPEjcIZ/f64cPMglQ909nlpDnMzhPyZGYvzxw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=exbdEODe0RwZrlhJEf6UbFgU8jULxbkEmqeF0o0R+Bbuh3e6un8eXXZTDU1Pv2KR0ZJAaxso8hwMvyLNjpVqdu2NQjNo1AeG89u4d5NhWsQsYToSjpFENdHKv0+SCELEgg/5ZaO6p0V8KmDl7kayMm2DqynBsvNsXyFu+OViZzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YA/lDEym; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED659C4CEE4;
	Tue,  6 May 2025 15:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746546916;
	bh=KokwTcsPEjcIZ/f64cPMglQ909nlpDnMzhPyZGYvzxw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YA/lDEym02kXPHJYYAshEh37VVEPXYr6h6uUOT3HR5v3gjEgKBOj1grHVWAuVgdtJ
	 8reM6KCZV5esAd60c4cIkLJo1L6p4kV6Roxnos9n5MjPW7xW/XLfQYonwyhmXvLFoM
	 9EI3HKKa7GNlohfqkWY+hAhP3v46T18EJBGhmMXzu49uqvTibHpMsanT7iWqsoHoqh
	 ecDC9NIr1t/MsHrIYhKdR/msNFEoAQHS1f8sa9oQR7tXwFKusOM38K7A7cjMzKOwEs
	 nQCLhZaGH+jh7whmh0N7cGYW2y2NP4M7dC3JhGvHmT9xJhTbyH5ljZTmmslu47n5Ia
	 hP7QgfInSFQWQ==
Date: Tue, 6 May 2025 08:55:15 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Zhang Yi <yi.zhang@huaweicloud.com>, dhowells@redhat.com,
	brauner@kernel.org, linux-fsdevel@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-block@vger.kernel.org,
	dm-devel@lists.linux.dev, linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, tytso@mit.edu,
	john.g.garry@oracle.com, bmarzins@redhat.com, chaitanyak@nvidia.com,
	shinichiro.kawasaki@wdc.com, yi.zhang@huawei.com,
	chengzhihao1@huawei.com, yukuai3@huawei.com, yangerkun@huawei.com
Subject: Re: [RFC PATCH v4 07/11] fs: statx add write zeroes unmap attribute
Message-ID: <20250506155515.GL1035866@frogsfrogsfrogs>
References: <20250421021509.2366003-1-yi.zhang@huaweicloud.com>
 <20250421021509.2366003-8-yi.zhang@huaweicloud.com>
 <20250505132208.GA22182@lst.de>
 <20250505142945.GJ1035866@frogsfrogsfrogs>
 <20250506050239.GA27687@lst.de>
 <20250506053654.GA25700@frogsfrogsfrogs>
 <20250506054722.GA28781@lst.de>
 <c3105509-9d63-4fa2-afaf-5b508ddeeaca@huaweicloud.com>
 <20250506121012.GA21705@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250506121012.GA21705@lst.de>

On Tue, May 06, 2025 at 02:10:12PM +0200, Christoph Hellwig wrote:
> On Tue, May 06, 2025 at 07:25:06PM +0800, Zhang Yi wrote:
> > +       if (request_mask & STATX_WRITE_ZEROES_UNMAP &&
> > +           bdev_write_zeroes_unmap(bdev))
> > +               stat->result_mask |= STATX_WRITE_ZEROES_UNMAP;
> 
> That would be my expectation.  But then again this area seems to
> confuse me a lot, so maybe we'll get Christian or Dave to chim in.

Um... does STATX_WRITE_ZEROES_UNMAP protect a field somewhere?
It might be nice to expose the request alignment granularity/max
size/etc.  Or does this flag exist solely to support discovering that
FALLOC_FL_WRITE_ZEROES is supported?  In which case, why not discover
its existence by calling fallocate(fd, WRITE_ZEROES, 0, 0) like the
other modes?

--D

