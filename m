Return-Path: <linux-fsdevel+bounces-27515-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82E5D961DA3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 06:32:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 370622852ED
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 04:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F26D146A63;
	Wed, 28 Aug 2024 04:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="zkD7r4P1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA23A48;
	Wed, 28 Aug 2024 04:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724819557; cv=none; b=BbCEjy4+k6oSXvvCLEWuPVRyEnxZrOKF4IduDhh77QvunJw8sSVMjjZF2zOuWnwXzS93mFNMf6G+5U7NYYs6Lmha+IrD3caL0x2JPvUTvHuDNw/EHnK8+p4HNkugTKuQJ+xFixjkfBh9PW2g633vD91fWCbQrrcqiDZagSn0Jxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724819557; c=relaxed/simple;
	bh=zt8HFHN+KLKybUEPSC1qVuw+SAE/WwOB9cLLcno3f1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HqW7vRmEhKPRn3LKiZ8pibdMHhzoQPXxsjMZKfXFUAa5NnxBCMVqlZfW1OCsAE4gY6qVPuxlvJQAB9Hi87PKJ4NbVvEKkm6WBN7ggBLAYlbDiYpgv0GPVCoQf5PMiMRMxGB2sqDxVLb/nYYo6Ka0hvr27PCsHXC4+2d/3SqcI90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=zkD7r4P1; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=zt8HFHN+KLKybUEPSC1qVuw+SAE/WwOB9cLLcno3f1U=; b=zkD7r4P1VXX9qv0vxWdRdWftCW
	841z7yRGrT0/RWpY42dhICoteoB45H+YDMeWFZdMyT/rTzy1iwnuyz4wKeFJdgqPe3afLTNdWkrEY
	AWhpfLZu4hHUWh0qig9PQSW6miSb6CqTHWBYI10nGSF5FxeN7fUxjLZgIgweR5J3I+Oqu4IFl0ias
	W3PZJEddtSfu0wI3w8kw6rm9ylBU7DkVBPHyRPKFraFa1jcQ8TBJLVxJHnPFEe7XU58WoQiVYVDBa
	rJRua4tKc9pvBoHaJcmLCaNabJVqCak7IMjyQgby6tNeKUAlVGskV2exI2az7utBSffKG+ak2LXIN
	3FVueBIw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sjAMF-0000000Dns2-3s6w;
	Wed, 28 Aug 2024 04:32:35 +0000
Date: Tue, 27 Aug 2024 21:32:35 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Brian Foster <bfoster@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org, djwong@kernel.org, josef@toxicpanda.com,
	david@fromorbit.com
Subject: Re: [PATCH 2/2] iomap: make zero range flush conditional on
 unwritten mappings
Message-ID: <Zs6oY91eFfaFVrMw@infradead.org>
References: <20240822145910.188974-1-bfoster@redhat.com>
 <20240822145910.188974-3-bfoster@redhat.com>
 <Zs1uHoemE7jHQ2bw@infradead.org>
 <Zs3hTiXLtuwXkYgU@bfoster>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zs3hTiXLtuwXkYgU@bfoster>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Aug 27, 2024 at 10:23:10AM -0400, Brian Foster wrote:
> Yeah, I agree with that. That was one of the minor appeals (to me) of the
> prototype I posted a while back that customizes iomap_truncate_page() to
> do unconditional zeroing instead of being an almost pointless wrapper
> for iomap_zero_range().

I only very vaguely remember that, you don't happen to have a pointer
to that?


