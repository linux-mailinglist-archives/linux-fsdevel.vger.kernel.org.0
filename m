Return-Path: <linux-fsdevel+bounces-26876-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B131B95C582
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 08:34:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21349B22D25
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 06:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5751B757EA;
	Fri, 23 Aug 2024 06:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="bkwT1MoW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A656F307
	for <linux-fsdevel@vger.kernel.org>; Fri, 23 Aug 2024 06:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724394856; cv=none; b=pIrAUrv0ad5KD60+Trkc0uSUOOgz8TTrbAlEl4eL49otlQMmeKXN4idHLR/afyC491KYrmfffaTdy6bm+61xrMCuv5svJAmpHrmRkX8JrTDW3zNlINCPEWmQGhCB0vw4aYvpBhk7/IODbNCioYIJ5EctCmz+m6N+1RvNMPyZAog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724394856; c=relaxed/simple;
	bh=mf3DP1h80OX//ipLXLHaW1N/qCLvfceMTueKju+Jw+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tEbtfHN+CTTn3Yye1upb2NPmtnBCDfURglmxGOrGN7sElQ8jIZPePOkQlCMzBGud9BI/jqYKzXZn3FV4H0VjY4Oiio2WZHSpKrFN46/1opyqCt/coY7CaoPsLY6tPx69x1DXY1QcrkjeKE8z1C4+tNCOle1cQA9JTtrhRykXTmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=bkwT1MoW; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ptEwHtQHg9BHjPO0YRtZeyIIMuMhrHdUKzqWdsTuZcE=; b=bkwT1MoW2Wy9m978SwKS6vixG4
	hwq7U1NdndI6RZEmwI4cOxDq5o0VIdwdIM667Cx+3K3aVF/e7b1/YXtNMqcEu1IAF6QQirBv/BWuW
	/55NPQSM1oNUIVjb06jm0YqWwSYad1m6nHpvB+E1M0JIHotOCqEdF6WcRvSCR1xCWBUCOrJkaLLZA
	Pprgz44Rn01JOa5jVHkCnFuwGu9g5tYCaN23eQlTbu5Daj48N/AUs84lL6Ze6VxhLv5jPfvFRcmRp
	8Fg78bhx3gKQCxbhWCGa8gwvuUpcXNltiFDqRStNEEs6flau0BM3JfQs0RUY3Pyf2SHNMUbilqjps
	jMv3xTfw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1shNsB-00000004Qj0-32bY;
	Fri, 23 Aug 2024 06:34:11 +0000
Date: Fri, 23 Aug 2024 07:34:11 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Christoph Hellwig <hch@infradead.org>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] fs: switch f_iocb_flags and f_version
Message-ID: <20240823063411.GB1049718@ZenIV>
References: <20240822-mutig-kurznachrichten-68d154f25f41@brauner>
 <ZsgrKxvTko9sLCXD@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZsgrKxvTko9sLCXD@infradead.org>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, Aug 22, 2024 at 11:24:43PM -0700, Christoph Hellwig wrote:
> Given that f_version only has about a dozen users maybe just kill
> it and make them use the private data instead?  Many of the users
> looks pretty bogus to start with as they either only set or only
> compare the value as well.

Take a look at the uses in fs/pipe.c

