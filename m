Return-Path: <linux-fsdevel+bounces-30977-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E83A9902FD
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 14:34:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA68D2832A0
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 12:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB01117625A;
	Fri,  4 Oct 2024 12:34:17 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9A316F265;
	Fri,  4 Oct 2024 12:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728045257; cv=none; b=I0g3cBCL4xLY5IytbxDSTiE/FIE7kSd9ADByWik6G8FfesRRIsg+iJ+rEcP6RiRppCWaDe+sADAYhhY8aPMOFn5NxTTN4dDL/TUNFZyIuBDseTV+GmzHHUjqTqkW3NgtwIlkekfcjHwQK5HbFigADzt3/5YIs0TGjpfQ6V1KXtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728045257; c=relaxed/simple;
	bh=ugvzjZbElpG5CMRhdqYmHDkoC2mKBsIkmwx/10lZkvg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TBHI8vb/mJblCCuTEOuTaX3S17GtN7QkzGpauYt4/yb4jORezJ8ofEkNHF+w4n1BlcN8T80L2+8zwtcndgp5e/uWPO0qn2Jr3P/K/cZ2jZ2UbZsud6ISSG/4RR2A3ABRjxmEudwkz7FqxIQM67dF7BuYOchD76MYKsuGGrhyv5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 27A65227A87; Fri,  4 Oct 2024 14:34:11 +0200 (CEST)
Date: Fri, 4 Oct 2024 14:34:10 +0200
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: axboe@kernel.dk, brauner@kernel.org, djwong@kernel.org,
	viro@zeniv.linux.org.uk, jack@suse.cz, dchinner@redhat.com,
	hch@lst.de, cem@kernel.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, hare@suse.de,
	martin.petersen@oracle.com, catherine.hoang@oracle.com,
	mcgrof@kernel.org, ritesh.list@gmail.com, ojaswin@linux.ibm.com
Subject: Re: [PATCH v7 3/8] fs/block: Check for IOCB_DIRECT in
 generic_atomic_write_valid()
Message-ID: <20241004123410.GA19295@lst.de>
References: <20241004092254.3759210-1-john.g.garry@oracle.com> <20241004092254.3759210-4-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241004092254.3759210-4-john.g.garry@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Oct 04, 2024 at 09:22:49AM +0000, John Garry wrote:
> Currently FMODE_CAN_ATOMIC_WRITE is set if the bdev can atomic write and
> the file is open for direct IO. This does not work if the file is not
> opened for direct IO, yet fcntl(O_DIRECT) is used on the fd later.

This sound like a bug fix for 6.12-rc?

The fix looks good to me:

Reviewed-by: Christoph Hellwig <hch@lst.de>

