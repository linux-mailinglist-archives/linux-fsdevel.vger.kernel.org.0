Return-Path: <linux-fsdevel+bounces-69050-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 77B57C6CD57
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 06:53:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3928234CA41
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 05:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72BC5311C15;
	Wed, 19 Nov 2025 05:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DCDGMOIt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F48E21257E;
	Wed, 19 Nov 2025 05:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763531532; cv=none; b=ZFb7NGX9hNmRv1n1JIPgUKwogK0hB3FxyijDacJ26ErXHl9GOe5Cr0RQ8E1hhpoF0ZDll0b4/mVbaaz73XX/3RdbwqvBbD1MOBImqoanB+Iem+JkXFFLdXiQFk6SGbMnt3IK8EkHST341jj86UB0BBJn2o/VyR5qoEtFQQjKnpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763531532; c=relaxed/simple;
	bh=I8I1AprjDBUOj7jue2dl3t9Iqf4Cwq10RSkL95tBmzw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QPFTSr/g9GCHgV6Cu9eLPec5Af951i/DcbeEwOHokcwqCeTwhWIkBp0akLFPMTNinR/+DI3F4oJoPwY2HvNroueZnsdgloBSOIBxCjoxykHzu1br+J4O82ugGLZ5ZZlZSdMxNhWnPF7p8PxECDkS+510qY84vCQnp1DX2Mn5BbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=DCDGMOIt; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=I8I1AprjDBUOj7jue2dl3t9Iqf4Cwq10RSkL95tBmzw=; b=DCDGMOItsmmDvLY2JYHYouj2Xc
	OMO73rZ6noq0tsz/j4b9DcP9NFeBYTfCbxfUML6nP9c2GxYLjlRYa787wx5GKEyAsMLJgZNRbOfd9
	NAAe/QcIO5vwHMXsvm0u7IRRN+j5fetrVEXgu/rAqG9m4KGIs7BTr0t3S8mqm43c2TH+k6j+erJwd
	OuF+otZTirQnwvM+rCvPmSCSsRzaKg6eCV7DFxxX99OsbSnkmCR6v8VEOjtDAH8m3zFTkL9VENnRX
	ISVNVDCFed/qMXULXTivoZJDh+55W0Pa5NmvrW8V9YxisnUpjpQsyv1w2o63rKf3sSBpF4l8wUhKe
	SxK9wpqg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLb6p-00000002Rs3-1eOi;
	Wed, 19 Nov 2025 05:52:03 +0000
Date: Tue, 18 Nov 2025 21:52:03 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Christoph Hellwig <hch@infradead.org>,
	SHAURYA RANE <ssrane_b23@ee.vjti.ac.in>, akpm@linux-foundation.org,
	shakeel.butt@linux.dev, eddyz87@gmail.com, andrii@kernel.org,
	ast@kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev,
	skhan@linuxfoundation.org, david.hunter.linux@gmail.com,
	khalid@kernel.org,
	syzbot+09b7d050e4806540153d@syzkaller.appspotmail.com,
	bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH] mm/filemap: fix NULL pointer dereference in
 do_read_cache_folio()
Message-ID: <aR1bAzXYJF5TicnS@infradead.org>
References: <aReUv1kVACh3UKv-@casper.infradead.org>
 <CANNWa07Y_GPKuYNQ0ncWHGa4KX91QFosz6WGJ9P6-AJQniD3zw@mail.gmail.com>
 <aRpQ7LTZDP-Xz-Sr@casper.infradead.org>
 <20251117164155.GB196362@frogsfrogsfrogs>
 <aRtjfN7sC6_Bv4bx@casper.infradead.org>
 <CAEf4BzZu+u-F9SjhcY5GN5vumOi6X=3AwUom+KJXeCpvC+-ppQ@mail.gmail.com>
 <aRxunCkc4VomEUdo@infradead.org>
 <aRySpQbNuw3Y5DN-@casper.infradead.org>
 <20251118161220.GE196362@frogsfrogsfrogs>
 <CAEf4BzYkPxUcQK2VWEE+8N=U5CXjtUNs6GfbfW2+GoTDebk19A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzYkPxUcQK2VWEE+8N=U5CXjtUNs6GfbfW2+GoTDebk19A@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Nov 18, 2025 at 11:38:36AM -0800, Andrii Nakryiko wrote:
> We have plenty of build ID tests in BPF selftest that validate this
> functionality:

And none of them is run on a wide variety of file systems, presumably
because they are only run by BFP developers.

IFF we allow for magic file access methods it needs to be part of
regular file system testing.


