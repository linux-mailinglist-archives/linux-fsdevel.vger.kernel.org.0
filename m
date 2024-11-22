Return-Path: <linux-fsdevel+bounces-35593-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C43179D61D9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2024 17:16:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51BC7B25211
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2024 16:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 404B11DE3A5;
	Fri, 22 Nov 2024 16:15:54 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 342192E3EE
	for <linux-fsdevel@vger.kernel.org>; Fri, 22 Nov 2024 16:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732292153; cv=none; b=Filw3BD1iIYfjf9S1DLmtCIcoqep9HhdF9FIEWFXqWhlHYdPp2OkjZBOujrmw5N3/Sqr+H97F7nm+N/jjm6VX2/8wUVT+n6HvTcKHMbR5swzpz1FvY40qhRo2oK5FJOh/wllU6INxUGQ1Qwmnyvgt3ROaIjwPjfSVhch3tTcmog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732292153; c=relaxed/simple;
	bh=KdgWj/RXcHE+e9GGjubpHo52Z8xGw21nUc0Wb4ymvd4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fvAzaloMbg7REt4bW2gLdl7eP8fzJeXdo5c2jqhYAZxEVBK9MkN0qEsFRn2IYX5lu1G6P4KaIZmBu4P4zmYgw4WO8fSkewS/W0LAWO3hwn8xkmgsvfvNZnjQA8vMBzTBnMBai+pjTxedmkWl6ppV+6hT5PCvXlWB0fF4y6dvYXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1B2F868C7B; Fri, 22 Nov 2024 17:15:48 +0100 (CET)
Date: Fri, 22 Nov 2024 17:15:47 +0100
From: Christoph Hellwig <hch@lst.de>
To: Jan Kara <jack@suse.cz>
Cc: Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/2] fs: require FMODE_WRITE for F_SET_RW_HINT
Message-ID: <20241122161547.GA7787@lst.de>
References: <20241122122931.90408-1-hch@lst.de> <20241122122931.90408-3-hch@lst.de> <20241122125342.vmmjokiilvnuifuf@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241122125342.vmmjokiilvnuifuf@quack3>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Nov 22, 2024 at 01:53:42PM +0100, Jan Kara wrote:
> Here I'm not so sure. Firstly, since you are an owner this doesn't add any
> additional practical restriction. Secondly, you are not changing anything
> on disk, just IO hints in memory... Thirdly, we generally don't require
> writeable fd even to do file attribute changes (like with fchmod, fchown,
> etc.).  So although the check makes some sense, it seems to be mostly
> inconsistent with how we treat similar stuff.

As I said I'm not quite convince either, so just doing the first one
is probably fine.


