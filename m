Return-Path: <linux-fsdevel+bounces-18408-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E85298B85D8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 May 2024 09:11:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A46E02848D7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 May 2024 07:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 640E24CE05;
	Wed,  1 May 2024 07:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="y19vz27t"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C3C1D6BD;
	Wed,  1 May 2024 07:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714547455; cv=none; b=I9TPuY67YQ2Ai91OVIn0zGIBtx5oYoZi0odP3XYMridTgy3et1XV/V9j9/70ge/XufHEDDVd+J9GWdntIYjF+Xd29EyI2tngf92QTN4ASeNaX+6G7IhwEJ+xbaNsTzb7sjH6fm1xdCtitynlJOQI5OMZG/OvK+YFyxYhrIZQVxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714547455; c=relaxed/simple;
	bh=A1Nt1Xo8yXFkgV8OBhbDmbIv8RL5fPlr76oponqmJrk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WxY9koYNJ66Ae6D0L4ApXCfg8dPllUheqpsjyddZbxVog8/JJu4DqRp2O0reglM2NGIRRAreM1tCqME2AqeS19l+3WWBvk1k44IWnNLdGD5J6kwYolKuhapeycT6glhPLxYe8NGBIrUVoCoUbbzthHEAqVaYySxjnwO0efFIIFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=y19vz27t; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=uV0UR1K1pOyt4v23Tp0M3E66+FnT4rJrNkLOemn97cQ=; b=y19vz27tHgF4Yoj+YkdWvjFOcJ
	F6rQGiYInEfKh+ZbNXpIG+HT84QSqk5C9KJLOVtlfcxfxRSIloVSmiYhDj1OyvL3Y0EjBO2wRm7Ro
	yqf1lpabiP4dzp4iiVVKMtiNoXJ+nicuyqac5wc2qVKFhcMimlmLg1I1DWLBQjVThzuP7kwJz5RhT
	/07ZYGYWsZQDeF3V5HteUYyAcOwJVxRFBjEQWVFP4cdzGgneekfak753lvX0IpclLrnM1hFCNRfku
	SBrCg410sVkM2gyoAEM4GWrxTSvCfMG4yTvPUJMDl0ySMoTCpwWrZM+t7oh59bOdmWoA/Re8Xrkd4
	AGhs5Zug==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s247B-00000008jUP-40X5;
	Wed, 01 May 2024 07:10:53 +0000
Date: Wed, 1 May 2024 00:10:53 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: aalbersh@redhat.com, ebiggers@kernel.org,
	Christoph Hellwig <hch@lst.de>, linux-xfs@vger.kernel.org,
	alexl@redhat.com, walters@verbum.org, fsverity@lists.linux.dev,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 18/18] iomap: integrate fs-verity verification into
 iomap's read path
Message-ID: <ZjHq_XiLQnXO_pqo@infradead.org>
References: <171444679542.955480.18087310571597618350.stgit@frogsfrogsfrogs>
 <171444679890.955480.13343949435701450583.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <171444679890.955480.13343949435701450583.stgit@frogsfrogsfrogs>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Apr 29, 2024 at 08:24:06PM -0700, Darrick J. Wong wrote:
> From: Andrey Albershteyn <aalbersh@redhat.com>
> 
> This patch adds fs-verity verification into iomap's read path. After
> BIO's io operation is complete the data are verified against
> fs-verity's Merkle tree. Verification work is done in a separate
> workqueue.
> 
> The read path ioend iomap_read_ioend are stored side by side with
> BIOs if FS_VERITY is enabled.
> 
> Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Not sure where my signoff is coming from.  It looks pretty similar to
a patch I sent a long time ago, but apparently it's been modified enough
to drop my authorship, in whih case my signoff should be dropped as
well.


