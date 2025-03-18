Return-Path: <linux-fsdevel+bounces-44287-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C6AF4A66D66
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 09:07:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 266C9188753B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 08:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB9441F4C92;
	Tue, 18 Mar 2025 08:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="W0HsmWYy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE99F1E5211;
	Tue, 18 Mar 2025 08:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742285262; cv=none; b=UMOM0soN6edU3wxxBlb4dheqWZutiWlLslzDBBOWIj6T0REzL6s9gGh0z0kf3VGuNdnHDld68G3zx7EUB/vepesIheOCnxbTH4mLrMuN2nil1oWWF2qzvJSSgSdOwnWMzbNUkVwRb0DDZhXDJwqvMddxJoRbKZdiK/zGa5uZLh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742285262; c=relaxed/simple;
	bh=yYAaPK4KMHyPbAfvjE/LAXlEj70e+IDL+4J3y7h/2jU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PFNN5kJw/yNCSb/I5WsljnVwNop2dlQB2nbyguWGrbhSVl9fIZ+LS8aZb1pQs/Ml75VgAF59+yAOzy2CFsL1z5UNeN5Tpvlr3H+waj2IjpPSEt7VxNFSvoYRzggEUXIxfCOSW6InRvUk9G8gwgmVsn8bGFjHeJGRNl7L19Mjmro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=W0HsmWYy; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
	:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=bXD5ixfMQVnQm/9ZG+Sq7VooSDOkIDNBkp5z/JkUoAQ=; b=W0HsmWYyz8wwNEiRdtMR6IZi/7
	f7ClQg5SWaNaJyvBXabWjbneRD9gya3sBAMvr1DlU6htfwqcfzla6alMl9xGekPIj6islyM7fltQx
	5iKzKRxo8iKnv9drk5ia+VEWYHOk6ydozei9bl1dgF9EkES+1rueGh/B4M4IFNclg71jpInJfg+WM
	m4Scda4IF/rO0NBXDYkceJRZg14u+epw13pp598X9GyEKp8s+gFoaupFinbeuv6rU/x74sih+pStr
	WnKNxOxaxpN6DM/D35SQ5J+wVxl1y2vwQ6EMr64Cz5fqDjtIyi/9IWDYK40dvrjFvOMyfaiMFbsFH
	3dvSJrIA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tuRz8-000000055vK-0y3G;
	Tue, 18 Mar 2025 08:07:38 +0000
Date: Tue, 18 Mar 2025 01:07:38 -0700
From: "hch@infradead.org" <hch@infradead.org>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: "hch@infradead.org" <hch@infradead.org>, Qu Wenruo <wqu@suse.com>,
	Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
	Theodore Ts'o <tytso@mit.edu>,
	"lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"josef@toxicpanda.com" <josef@toxicpanda.com>
Subject: Re: [LSF/MM/BPF TOPIC] File system checksum offload
Message-ID: <Z9kpyh_8RH5irL96@infradead.org>
References: <20250130091545.66573-1-joshi.k@samsung.com>
 <20250130142857.GB401886@mit.edu>
 <97f402bc-4029-48d4-bd03-80af5b799d04@samsung.com>
 <b8790a76-fd4e-49b6-bc08-44e5c3bf348a@wdc.com>
 <Z6B2oq_aAaeL9rBE@infradead.org>
 <bb516f19-a6b3-4c6b-89f9-928d46b66e2a@wdc.com>
 <eaec853d-eda6-4ee9-abb6-e2fa32f54f5c@suse.com>
 <cfe11af2-44c5-43a7-9114-72471a615de7@samsung.com>
 <Z6GivxxFWFZhN7jD@infradead.org>
 <edde46e9-403b-4ddf-bd73-abe95446590c@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <edde46e9-403b-4ddf-bd73-abe95446590c@samsung.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Mar 18, 2025 at 12:36:44PM +0530, Kanchan Joshi wrote:
> Right, I'm not saying that protection is getting better. Just that any 
> offload is about trusting someone else with the job. We have other 
> instances like atomic-writes, copy, write-zeroes, write-same etc.

So wahst is the use case for it?  What is the "thread" model you are
trying to protect against (where thread here is borrowed from the
security world and implies data corruption caught by checksums).

> 
> > IFF using PRACT is an acceptable level of protection just running
> > NODATASUM and disabling PI generation/verification in the block
> > layer using the current sysfs attributes (or an in-kernel interface
> > for that) to force the driver to set PRACT will do exactly the same
> > thing.
> 
> I had considered but that can't work because:
> 
> - the sysfs attributes operate at block-device level for all read or all 
> write operations. That's not flexible for policies such "do something 
> for some writes/reads but not for others" which can translate to "do 
> checksum offload for FS data, but keep things as is for FS meta" or 
> other combinations.

Well, we can easily do the using a per-I/O flag assuming we have a
use caѕe for it.  But for that we need to find the use case first.

So as with so many things (including some of my own), we really need
to go back to describe the problem we're trying to fix, before
diving deep down into the implementation.

