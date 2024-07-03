Return-Path: <linux-fsdevel+bounces-22998-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B20C09252EE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jul 2024 07:27:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67B441F2609B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jul 2024 05:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A627B54276;
	Wed,  3 Jul 2024 05:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uhVnfzsl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4047017C60;
	Wed,  3 Jul 2024 05:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719984425; cv=none; b=pws6zvZOqJh4KYX3g0l4Dcv2RkEZ3Jh+ar36Q8P2M/1zW/koWC+Y7GVFITwrkPv18TyqTWkyO6lCt/GewD0ek5K7WuE+0Pxaqd31jPNy/KSEqiLwrDuMmPFv4Ju3FY0ovMDr5WadqoyzAA8RdvLy16t83L7RXIhP/pNGoSiLq6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719984425; c=relaxed/simple;
	bh=mZHTDOjfNldNq9pm83st4/J9NEm34dK9p7Q7e6Vj96w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S+AMSGIkZEDfAuVaDdIv8/fvTD+KvvPZ2UtsUJE/bKyeBlQke/jOJ1UAo6kGs3a08VatfRtGzd/kvkvbU23X3rpXV1I19EW3GY2A9IW3fmZP4urOXXgqena0SBjt86hCAixUzgmC7JTvhnJvSfFzyqKFppe8xKqJwWqVV7ncd8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=uhVnfzsl; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=B2QFWmmtnzG9/Nt7IO4g9fzoajf9ZPOHUxGkfqY/0Fk=; b=uhVnfzsl8Ss5ByDBA//ACjebHe
	jorQN3OuDLkgxctOg56Sg6djOeDxfc7ypq0RjIwaSmmPFXDEUZ/TW5UWehQr/LfVoSlFkiaAC6pRA
	WvgJeI4zFNwfDNZlzqcdkrJT9lGakvlV4LUKGqpz60aa64GQRq7tKAemE2ILOcCM62/kioq5QTKqv
	xL2lvZFiMCrBvDaEoHNlgd2xoA3eHdmqrwffMGPTrPWwyP1HwbKBsmqlZP+Z0fNJWZhXRpK2wYiLL
	aI/5wqPGpdtMm3LxwtISeJZIpmVQmcTBWUE5NDVOMGGK/Sm4+IAz+HiFlxcI8UJmYUzaxk/mGUo26
	CAFHPolQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOsW7-000000092xA-20k6;
	Wed, 03 Jul 2024 05:26:55 +0000
Date: Tue, 2 Jul 2024 22:26:55 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Chandan Babu R <chandan.babu@oracle.com>,
	Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>, Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
	Hugh Dickins <hughd@google.com>,
	Andrew Morton <akpm@linux-foundation.org>, kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-btrfs@vger.kernel.org,
	linux-mm@kvack.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 01/10] fs: turn inode ctime fields into a single ktime_t
Message-ID: <ZoThH9fWsdzq7IXR@infradead.org>
References: <ZoOuSxRlvEQ5rOqn@infradead.org>
 <d91a29f0e600793917b73ac23175e02dafd56beb.camel@kernel.org>
 <20240702101902.qcx73xgae2sqoso7@quack3>
 <958080f6de517cf9d0a1994e3ca500f23599ca33.camel@kernel.org>
 <ZoPs0TfTEktPaCHo@infradead.org>
 <09ad82419eb78a2f81dda5dca9caae10663a2a19.camel@kernel.org>
 <ZoPvR39vGeluD5T2@infradead.org>
 <a11d84a3085c6a6920d086bf8fae1625ceff5764.camel@kernel.org>
 <ZoQY4jdTc5dHPGGG@infradead.org>
 <4ec1fbdc6568e16da40f41789081805e764fd83e.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ec1fbdc6568e16da40f41789081805e764fd83e.camel@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Jul 02, 2024 at 11:58:02AM -0400, Jeff Layton wrote:
> Yeah, mostly. We shrink struct inode by 8 bytes with that patch, and we
> (probably) get a better cache footprint, since i_version ends up in the
> same cacheline as the ctime. That's really a separate issue though, so
> I'm not too worked up about dropping that patch.
> 
> As a bonus, leaving it split across separate fields means that we can
> use unused bits in the nsec field for the flag, so we don't need to
> sacrifice any timestamp granularity either.
> 
> I've got a draft rework that does this that I'm testing now. Assuming
> it works OK, I'll resend in a few days.

So while shrinking the inodes sounds nice, the tradeoff to have to
check all timestamps from disk / the server for validity doesn't
sound as positive.  So I'm glade we're avoiding this at least for.


