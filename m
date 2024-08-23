Return-Path: <linux-fsdevel+bounces-26874-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DDD3495C565
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 08:24:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CDD21C21D9B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 06:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E3436F2FE;
	Fri, 23 Aug 2024 06:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="s7mkZwos"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B3803F9F9
	for <linux-fsdevel@vger.kernel.org>; Fri, 23 Aug 2024 06:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724394286; cv=none; b=DcEL4/Ufj+JLkbHErTr39hnas03LovlxaIulrTXA2XYhFLcCthV/Ia9Uz1o8AThU44mq50B7MNYZn6ZVCSzuDk+PfV+OVReiDA5esVevjB/K6TWmIbqnXZI1J7sjWpFfuwIpk15bxd+ft1UH0NWmLb0CoxtZ+9FrZq//n+4P0Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724394286; c=relaxed/simple;
	bh=wEdy6OrRGOb8h5kGeX1N57n4z83+3vbHds9wCY3cpiI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CDQEFeBfNjBHLC6Xn+T/xki++Po0SxHbAEXZ4i5JCFbwxTBEhFcO7bB1CQ2xCzonCCA+GpJMsInoGAQ6XmEy9IytaXWEnPLDtqG4qMyoVPnkfMUydqjj6butFOQ3c5lT32guWsHbrmOm5ofHtHgHa+GNMfwcKiZxJWhsxTuF84k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=s7mkZwos; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ZswqAwnP9+f0TXvXBiXS2tp70ePBbo0nJ/2MoOBH0AQ=; b=s7mkZwoswujkxVXob+JZJLoS7Z
	mfSpkzrcOte4AXTQQoyqvxrfxyW7B8fgTiNk1A+hgruc5PL3hzNZEP5xMPfGp+251HAmr99ItDxcX
	jJy15GRY0RsdJB5/+yeH06EigpSFW3TRvFg/e6bOoqKYtuvncgzAIv2ok4766bfijCNpp6B3Qzrvn
	mCYzdX8GEUvgOEYwJgS8SCw9H9nXIYazvCe8UKVMz4U9K5BIe+sfLprOs9KoSHtn7sPSJHNx83f71
	TrCInfPF5xm3+uQvSPBW5wljue/JN3pZ0A3MCOAjMvaFwDnZ+K8uiHf6iaX2t6YyK+HBd65CGNtR4
	P+EStkhA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1shNj1-0000000FREi-1Lz7;
	Fri, 23 Aug 2024 06:24:43 +0000
Date: Thu, 22 Aug 2024 23:24:43 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] fs: switch f_iocb_flags and f_version
Message-ID: <ZsgrKxvTko9sLCXD@infradead.org>
References: <20240822-mutig-kurznachrichten-68d154f25f41@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240822-mutig-kurznachrichten-68d154f25f41@brauner>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Given that f_version only has about a dozen users maybe just kill
it and make them use the private data instead?  Many of the users
looks pretty bogus to start with as they either only set or only
compare the value as well.


