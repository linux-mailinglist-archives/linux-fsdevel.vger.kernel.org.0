Return-Path: <linux-fsdevel+bounces-44175-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DFF6A64379
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Mar 2025 08:26:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 061A43AD00B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Mar 2025 07:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CA5921ABD4;
	Mon, 17 Mar 2025 07:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jqGWUzt8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B4621ABA4;
	Mon, 17 Mar 2025 07:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742196348; cv=none; b=rlumcJUQKHjRWVVVCtxpleiXGntTcSK8wJK0a5A8cq5yh2pCF/rhEPw54bqP8pkQ/kNmt1R8qCbni21Ez+EnpPJQFwHQ71ITxsbZOoqiFXEUUkuymk8sEMegGHJb4lBbg8thBpjRlHXLcA0ncbHoGa15ftatXJRe6MD1Rs69+jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742196348; c=relaxed/simple;
	bh=JzoP5yzKpTJ7PuP2QtN1xaA+IYoWEmYujuhmEHGzY9I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=happRtmZTcvUYWw202Dql3N1xmVtiM/Xhh4zbITi+VeJ5fhiXMvzC9B3DfoTlV+jdfzz3Kx62sWyWT1vo/uoEYZVkf4OwNovj9u+w7AtAGo90mB3prQdYMtuLl5BSa9iqrK16mU9EEPY+fRPaMAIziqpef5GsAD4Wu3Cj4Jj3iU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=jqGWUzt8; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=EGbSg0bG5fPXPVKWZzh9nWVVFmYOorGZJPYkwHy6xo4=; b=jqGWUzt8DmwByL+khi3b6qCsAc
	H7Hfn7uQIWTXAi98RHCKlqis44R16mpXnoQbkqW5hH/tgjuxHXQbrYTjmjaRt6xxqXAig3RBJgnR1
	No0W8srsw6uOCABuEqh6kIcn4aZ3VrSzi6/Z+yWbRFgaCII9oh3/EFpaHzPfzEOY5Q7xfmq5eNjW6
	OwUTpxTEELaiCef5rcAxSB6ZuRL3UzOQ+FAUfi4xSahjib8PxyeKw+AqwuAAhrLkUuOsOE7+NhNPo
	cljX4Mao2J4hKlH5QEXynUgZGkobyCT66Ls2ojS9xSwmjyQhU86sohlogRraAMiQr2GZI3Jf3/mKK
	M91pRdtQ==;
Received: from [2001:4bb8:2dd:73af:768b:3020:1cfb:1718] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tu4r2-00000001YjZ-082y;
	Mon, 17 Mar 2025 07:25:45 +0000
Date: Mon, 17 Mar 2025 08:25:36 +0100
From: Christoph Hellwig <hch@infradead.org>
To: John Garry <john.g.garry@oracle.com>
Cc: brauner@kernel.org, djwong@kernel.org, cem@kernel.org,
	dchinner@redhat.com, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	ojaswin@linux.ibm.com, ritesh.list@gmail.com,
	martin.petersen@oracle.com, tytso@mit.edu,
	linux-ext4@vger.kernel.org, Carlos Maiolino <cmaiolino@redhat.com>
Subject: Re: [PATCH v6 13/13] xfs: update atomic write max size
Message-ID: <Z9fOcFB5dhpK4Lsw@infradead.org>
References: <20250313171310.1886394-1-john.g.garry@oracle.com>
 <20250313171310.1886394-14-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250313171310.1886394-14-john.g.garry@oracle.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Mar 13, 2025 at 05:13:10PM +0000, John Garry wrote:
> For simplicity, limit at the max of what the mounted bdev can support in
> terms of atomic write limits. Maybe in future we will have a better way
> to advertise this optimised limit.

You'll still need to cover limit this by the amount that can
be commited in a single transactions.  And handle the case where there
is no hardware support at all.

>  xfs_get_atomic_write_max_attr(

I missed it in the previous version, but can be drop the
pointless _attr for these two helpers?

> +static inline void
> +xfs_compute_awu_max(

And use a more descriptive name than AWU, wich really just is a
nvme field name.

> +	awu_max = 1;
> +	while (1) {
> +		if (agsize % (awu_max * 2))
> +			break;

	while ((agsize % (awu_max * 2) == 0)) {

?

> +	xfs_extlen_t		m_awu_max;	/* data device max atomic write */

overly long line.


