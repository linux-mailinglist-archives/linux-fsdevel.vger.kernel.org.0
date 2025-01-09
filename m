Return-Path: <linux-fsdevel+bounces-38705-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81B61A06E39
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jan 2025 07:25:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8380D16789F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jan 2025 06:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D8D921421B;
	Thu,  9 Jan 2025 06:25:09 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76212136352;
	Thu,  9 Jan 2025 06:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736403908; cv=none; b=BsMOMR3kVEdacavUvjT0MKjwbi/C2gCQEgEdkNzWYKfthjexd7K0B+o1v9Ze1Y/XSb3AKo1ulx+2wwpJkvr2IXY4aOJr3yfNPfR6nQsA53Sa6rQdZc+aJ89SBeQYItQMVI3eDzMNIL9Xl1+UFE9E8GmDfvVTWWcMAQ7lQ76A+oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736403908; c=relaxed/simple;
	bh=Su4rTo17EfFzoY+MpjC76kRglPhmsEiaJ11GhC7RQDc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BcKq76gJXzPGBZxUgrezKagVNZKF/y1NspUDMGaV15wo+nb3tpu5cyV/g1Opyhbfx+X2prXXxWn5rhL/F3bPb5tD5ALoiIuPQvHHV9jotQOMHA/krczToro260KmtMlmivpgFpV7u1k8jX0frExUa18ZIKZTyJqEaAxB3xszcNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id EF7F968D05; Thu,  9 Jan 2025 07:25:00 +0100 (CET)
Date: Thu, 9 Jan 2025 07:25:00 +0100
From: Christoph Hellwig <hch@lst.de>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Chandan Babu R <chandan.babu@oracle.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Hongbo Li <lihongbo22@huawei.com>,
	Ryusuke Konishi <konishi.ryusuke@gmail.com>,
	linux-nilfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH 4/5] xfs: report the correct read/write dio alignment
 for reflinked inodes
Message-ID: <20250109062500.GA16763@lst.de>
References: <20250108085549.1296733-1-hch@lst.de> <20250108085549.1296733-5-hch@lst.de> <20250108175358.GA29347@sol.localdomain>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250108175358.GA29347@sol.localdomain>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Jan 08, 2025 at 09:53:58AM -0800, Eric Biggers wrote:
> This contradicts the proposed man page, which says the following about
> stx_dio_read_offset_align offset:
> 
>           If non-zero this value must be smaller than  stx_dio_offset_align
>           which  must be provided by the file system.
> 
> The proposed code sets stx_dio_read_offset_align and stx_dio_offset_align to the
> same value in some cases.
> 
> Perhaps the documentation should say "less than or equal to"?

Yes, I'll fix it up.

> Also, the claim that stx_dio_offset_align "must be provided by the file system"
> if stx_dio_read_offset_align is nonzero should probably be conditional on
> STATX_DIOALIGN being provided too.

I'll add a "if requested" to the man page.


