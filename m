Return-Path: <linux-fsdevel+bounces-69677-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F584C80F57
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Nov 2025 15:18:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 096D2345A18
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Nov 2025 14:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 585A130EF9E;
	Mon, 24 Nov 2025 14:17:57 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 665E63074AA;
	Mon, 24 Nov 2025 14:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763993877; cv=none; b=N8tpdx1phGjoZK6S7MfGsFhrluucGe1W5wQOSKyCV+Dnny59jwL1HISL5TWXeYmspdW6JHs24CFTHpB/VZsWPMyH2gUtLtqcSYfwoNrPDgAWeKWRYaYFQG6vAiivlXbxoc6YBnO+EfSonAlalSqJR73yAV0fdFArlgkUqR+95eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763993877; c=relaxed/simple;
	bh=2gtoUd7PHZ/+I8i5rLE1++jGjWcqIlteLbadvcXGAac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dCtGAW77dbnmCEvnsi9+v/SsP00u5TxUeJCHGjEx/ec/i5TfmC6iYucKwllv0oql1PQ0EwbMOL2VgjGJxjX0Bwie662EKPUI9oODWEJbhOYVm/axc2344ob3z37vs0eqp/sKz0oPjloU8JjJMcwQwbRGZdkAjtotD55ZnwvRq2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id E7D8168C4E; Mon, 24 Nov 2025 15:17:51 +0100 (CET)
Date: Mon, 24 Nov 2025 15:17:50 +0100
From: Christoph Hellwig <hch@lst.de>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, "Theodore Y. Ts'o" <tytso@mit.edu>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Chao Yu <chao@kernel.org>, Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	linux-fscrypt@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 10/11] fscrypt: pass a byte length to
 fscrypt_zeroout_range
Message-ID: <20251124141750.GD14417@lst.de>
References: <20251118062159.2358085-1-hch@lst.de> <20251118062159.2358085-11-hch@lst.de> <20251122182926.GC1626@quark>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251122182926.GC1626@quark>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Sat, Nov 22, 2025 at 10:29:26AM -0800, Eric Biggers wrote:
> The type of 'len' is still unsigned int, so this reduces the maximum
> length accepted by fscrypt_zeroout_range() from UINT32_MAX blocks to
> UINT32_MAX bytes.  Is that really okay?

Linus has limited Linux's read/write I/O sizes to a signed integer,
even if size_t/ssize_t could be larger.  We have internal support
to do a few things larger, so there would be precedence to support a
64-bit value and I'd be happy siwtch over to that.


