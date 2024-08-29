Return-Path: <linux-fsdevel+bounces-27765-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65D5C9639FF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 07:43:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98FB01C22694
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 05:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05A311487D1;
	Thu, 29 Aug 2024 05:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="K3hucU2z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F65CEAD5;
	Thu, 29 Aug 2024 05:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724910231; cv=none; b=GMXM4BFEXHvdsCkGPRb5Y0bXkzEIOAmXzezV0wSjpjQ7mMOW9c9uaHWGHJ12M2YoeVhf4bJoct2u/5pHKq/p5NqS+4ZxNZh+OgrodtFZwQYEUAUNcrlv3krZUOeaDMdPnCtXNNWyaCaogYR8WNTLk29MEe92xu6wR/O4+xu+0Y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724910231; c=relaxed/simple;
	bh=jUIHeK/BDy4jzx7HR0noatAjCLGtn2ZEUgWxwo4zGk8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nnJyDGOqPfgPNfBCtQ7+nBTq8NYHFgqARfFj0Mi+HjAPSg9PNvKLG4wVA0g4JQs063biPgN4Wxr9Fc6qT8sPiWKN6+quDj11BGlHpUtsBHV1GbvinCD4/tbIcgTZRb6P942GtZQ62fmW/HNXhglfMSSRd9LMXatkWUuJF26cE2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=K3hucU2z; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=WmQTcBSbwE9bnMyFvx5Bde9YwMgvJmizo+t94rLk1Nk=; b=K3hucU2zZMIS+M2H2pDm3cc/kg
	S/tfo/f6GzvJGj851xxY3qi22qqEg8r+ESEugrrvMW1/ICZo7GmaOkGAZ8jIRhEmeofiu0Teku6IK
	2o0fwsVwzKCrLE5Ne/evg+J1KSWfLAXMtgz6p/5q8mg1tbgL+MqmWSiP+Tli7tmAf7YHN1CynpqrF
	f8TXU0Opc34nUMFB1EZ5jiI75Cdn+Jwwb2oCD7EDRN7dD2npSOVIV1VmOaFOu/ei9Ssht6C+pu1jN
	bWQ2Mzdv9POxCmc/f4B6E3xgjFLsBTGUW4CJRIgni1ew4FWr+e7tZ7EGhyeDy6kKslpcIi27XtCBz
	Ywsz5Fug==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sjXwj-00000000d9Z-3BVa;
	Thu, 29 Aug 2024 05:43:49 +0000
Date: Wed, 28 Aug 2024 22:43:49 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Brian Foster <bfoster@redhat.com>, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org, josef@toxicpanda.com,
	david@fromorbit.com
Subject: Re: [PATCH v2 1/2] iomap: fix handling of dirty folios over
 unwritten extents
Message-ID: <ZtAKlYQlSpzFHQuq@infradead.org>
References: <20240828181912.41517-1-bfoster@redhat.com>
 <20240828181912.41517-2-bfoster@redhat.com>
 <20240828222222.GB6224@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240828222222.GB6224@frogsfrogsfrogs>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Aug 28, 2024 at 03:22:22PM -0700, Darrick J. Wong wrote:
> I wonder why gfs2 (aka the other iomap_zero_range user) doesn't have a
> truncate-down flush hammer, but maybe it doesn't support unwritten
> extents?  I didn't find anything obvious when I looked, so

gfs2 does not support unwritten extents.


