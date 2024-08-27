Return-Path: <linux-fsdevel+bounces-27304-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3F6E960128
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 07:48:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 288071F22CC6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 05:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC07C84D34;
	Tue, 27 Aug 2024 05:48:04 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5C18C13D;
	Tue, 27 Aug 2024 05:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724737684; cv=none; b=MqVIEuHm/ykJa7mb2f1gUlz02/T3tTN0o4PtyklGHXeJN00y2YkO4Ye8ro2b94stv8Rv5Xhfg8Zqt31+nlGNhBlt/SGrLzkxLrXFKVVOQEmVV+lRuVq8DRFjhVUfPzB1KV2M5oaPFlfTYN7+HxwvLLBEesgZkG/VZck4lKzrESc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724737684; c=relaxed/simple;
	bh=lezOOOSZUg5mrVlFMHc9ELIrjW7hEcsKAGCqz6l14oQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TI8daUzj0TD1zkbJKnLS7MiprcOHo0e02AqXgoAW4kZnuFfGiz8fZ8horVy2iBcQs7Sh1WoYJZrFUZj3quTTPxd7HBAwRBsHwLuHTY4qOVl6rDZVHuDa4YoCMVUCcRYfRY2MpA0ksirrxMiuMUCt2NCQo/Hty+JItzM0WnFmYcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id EE990227AAA; Tue, 27 Aug 2024 07:47:57 +0200 (CEST)
Date: Tue, 27 Aug 2024 07:47:57 +0200
From: Christoph Hellwig <hch@lst.de>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>,
	Chandan Babu R <chandan.babu@oracle.com>,
	Christian Brauner <brauner@kernel.org>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 02/10] iomap: improve shared block detection in
 iomap_unshare_iter
Message-ID: <20240827054757.GA11067@lst.de>
References: <20240827051028.1751933-1-hch@lst.de> <20240827051028.1751933-3-hch@lst.de> <20240827054424.GM6043@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827054424.GM6043@frogsfrogsfrogs>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Aug 26, 2024 at 10:44:24PM -0700, Darrick J. Wong wrote:
> Maybe we should rename it then?
> 
> IOMAP_F_OUT_OF_PLACE_WRITE.
> 
> Yuck.
> 
> IOMAP_F_ELSEWHERE
> 
> Not much better.  Maybe just add a comment that "IOMAP_F_SHARED" really
> just means an out of place write (aka srcmap is not just a hole).

Heh.

For writes it usually means out of place write, but for reporting
it gets translated to the FIEMAP_EXTENT_SHARED flag or is used to
reject swapon.  And the there is black magic in DAX.



