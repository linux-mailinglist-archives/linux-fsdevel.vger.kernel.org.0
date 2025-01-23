Return-Path: <linux-fsdevel+bounces-39991-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ADDBA1A99E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2025 19:24:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A71A2188E9F5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2025 18:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D42F1ADC80;
	Thu, 23 Jan 2025 18:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CwNzVJyj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362131ADC6B
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jan 2025 18:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737656669; cv=none; b=YmRzrGZJwmKH4tBK8YIybo8ptzE4IHcZ2L9Kn7rz3yiWzY944g7uZ6/jne6dajk/Z4oUiiyzQmRGrKrlgzhBFIM1b7yJJx0YtdxdLOokkCsBVksjkMPuu0pFLDrLLHYy2aHFYqy2Gv6kSdn+HW+gTCjYxdtBWEpbWfHYSNEjnPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737656669; c=relaxed/simple;
	bh=3X+Szd815VSNNIJsgs3yntBxmNAVRhZ40UzUIUsT8kg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=szg+uJZGJDzgS8IkgXg/RsS7yD4etZjEhbfKHe+VyNZMZi5vIuw7hxVd9fpRqBJISOtX73LCfmBIj0Fw65VieoMFbcdx+WIZx4lIbBIcDK9UAhjEF7MbjqfW9CgW4yk3Y2+FpZ69QrVeICLCNCfZg9pjWWyGByC+vwECoCbO3ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=CwNzVJyj; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ntBPn0EcpAEGSOSnRP5O3Iafq8TgV9z+O9aCnXNsGrA=; b=CwNzVJyjLG+zWuM2PXIo5yW1uT
	oTtFXZF6bJpL9mSAbqkWnYkWz++2+TpPterGMfeLiRr0+2MY7bWUNu7iM9CpE26EGZkj9LUFaKh7q
	ca1MjlJIWHtmIifKGcvwA+aajugw/sCkAVzuCmCAQM4g3LGo2gy4zoio7fjSbmbXfSjhlcxC6vtJY
	3UZ4fY/4L5eXTvuRRGBjPUiDZthdk4V7oxliomrXUj+eMF51WCXFZsV0MsVeC+VDBTfEXu0qhkV1k
	zbmW+RDCCv2YLm+WZ3VRJExhcqsPGQDduoQtC2kZHbtFeRAyMt7bc5oifZx0e2fqZFJFgI+iltHv9
	cCcj0PYw==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tb1sM-00000009xmA-1UGj;
	Thu, 23 Jan 2025 18:24:22 +0000
Date: Thu, 23 Jan 2025 18:24:22 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, josef@toxicpanda.com,
	bernd.schubert@fastmail.fm, jefflexu@linux.alibaba.com,
	shakeel.butt@linux.dev, jlayton@kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v3 00/12] fuse: support large folios
Message-ID: <Z5KJVtXwNsLdzLSz@casper.infradead.org>
References: <20241213221818.322371-1-joannelkoong@gmail.com>
 <CAJnrk1a8fP7JQRWNhq7uvM=k=RbKrW+V9bOj1CQo=v4ZoNGQ3w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJnrk1a8fP7JQRWNhq7uvM=k=RbKrW+V9bOj1CQo=v4ZoNGQ3w@mail.gmail.com>

On Wed, Jan 22, 2025 at 03:23:08PM -0800, Joanne Koong wrote:
> * I'm going to remove the writeback patch (patch 11/12) in this series
> and resubmit, and leave large folios writeback to be done as a
> separate future patchset. Getting writeback to work with large folios
> has a dependency on [1], which unfortunately does not look like it'll
> be resolved anytime soon. If we cannot remove tmp pages, then we'll
> likely need to use a different data structure than the rb tree to
> account for large folios w/ tmp pages. I believe we can still enable
> large folios overall even without large folios writeback, as even with
> the inode->i_mapping set to a large folio order range, writeback will
> still only operate on 4k folios until fgf_set_order() is explicitly
> set in fuse_write_begin() for the __filemap_get_folio() call.

Maybe you already understand this and just expressed yourself badly,
but what you've said isn't true.

The fgf_set_order() call is about creating large folios during write().
If instead you do a large read() (or do consecutive read() calls which
get turned into large readaheads), you'll get large clean folios.
If you then dirty those folios, we won't split them.  Writeback will
still see large folios in this case.

It depends on your workload how common a scenario this is.

