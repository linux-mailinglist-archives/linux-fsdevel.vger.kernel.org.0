Return-Path: <linux-fsdevel+bounces-26869-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B09095C414
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 06:13:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAEFF28573F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 04:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA3383FBA5;
	Fri, 23 Aug 2024 04:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CcEXuaVB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 054B720DF4;
	Fri, 23 Aug 2024 04:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724386376; cv=none; b=L66y7hun2GekTF52ogDHeh8QsarXaskbrULtzeKVbNy+l3/vYfXsC3RNdgSDFxziCJv1L4JLyTczKQZm5HynyxkqwasgAeYxQ5YxHryfTqQjm90vybOjk3JZx9JZjiNYSQB28yZ+kKA3wHcvlnI+8qpTq7Ig3/cQqjrz/0yYztU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724386376; c=relaxed/simple;
	bh=orG3i4aC50Y2+w24ZR54cn8YeKGYgkrgemAFcdwKaA4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gZPt3LoAEFS1Hus73bt7+tA9tZG4kdUQc+9trbQ8WLcQryUCtzimsvBKp2eGldQPqtQv/oZrWEoSOtQMREEiCSvEjLydldeIX3FL6CtcTUmKkP57JxbHT4zSwIhZdmT1YSNCNdQ/8FW18+y+zPjv5+i6FCoHBiJrsbSsBhEfJnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=CcEXuaVB; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=+2tuBUHgyGGUFpDJLqCfcZl9Dehbaq5TnacgaFILWGc=; b=CcEXuaVBC8jwyxcUuZAepnBzrW
	iSkce6/tu1rFt+PaNG/H1eUSgn/U976HzEGJXB/UOkZgR3zW8cr5b/z1CKj6UDZS7UBMGXziI91ct
	Mp63Juo2nnCpVpj39pXEk1nJf08j0sa2f+rn1SlN5agNqU58tsn2mBFMIirnEecrDy1ypDyKKD30C
	bwpW3p0k/ps6nllqore/Dg+mViWN39yvfB9xFQOOpfQTpKlMkozcaUyiKZIGAO6zhonUo5JbQMCYv
	P2B8YZdriLDR5bHus71yYZ28J1LeHJP+Bg/RA78uAuzHhiL+UjK1a4KR+6vgKmiUitKM1dWk6hRVW
	nAZ1f6/A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1shLfS-0000000F9ec-2kce;
	Fri, 23 Aug 2024 04:12:54 +0000
Date: Thu, 22 Aug 2024 21:12:54 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: hch@lst.de, linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH 1/1] xfs: introduce new file range commit ioctls
Message-ID: <ZsgMRrOBlBwsHBdZ@infradead.org>
References: <172437084258.57211.13522832162579952916.stgit@frogsfrogsfrogs>
 <172437084278.57211.4355071581143024290.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <172437084278.57211.4355071581143024290.stgit@frogsfrogsfrogs>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Aug 22, 2024 at 05:01:22PM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> This patch introduces two more new ioctls to manage atomic updates to
> file contents -- XFS_IOC_START_COMMIT and XFS_IOC_COMMIT_RANGE.  The
> commit mechanism here is exactly the same as what XFS_IOC_EXCHANGE_RANGE
> does, but with the additional requirement that file2 cannot have changed
> since some sampling point.  The start-commit ioctl performs the sampling
> of file attributes.

The code itself looks simply enough now, but how do we guarantee
that ctime actually works as a full change count and not just by
chance here?


