Return-Path: <linux-fsdevel+bounces-55551-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AB46B0BC61
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Jul 2025 08:14:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E038318967F1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Jul 2025 06:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91DD6221721;
	Mon, 21 Jul 2025 06:14:20 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E30221277
	for <linux-fsdevel@vger.kernel.org>; Mon, 21 Jul 2025 06:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753078460; cv=none; b=iwf6Yrc7Nn1uCzU24LNDHqshnWGEvA/4vM1OB5UflNDETguCyCfMlKIoSiXU51H9wZxg4MlrqpGz+wJOiUDjKDqpru7rBj/dqscGujywOSokqhSFAZpMyl57jfEZx52aFwfynq9RL8X7UnW1WF3IkYPZiq0q/PmI2Nt65wF5+pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753078460; c=relaxed/simple;
	bh=0Dm1whuHOlFNPccsEPpbizlEE+UyVaq3z9lXSiMotQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q1YA8+TqukOO9fdITM3kqqKal3UDeQQb3oRBJWG+ZEnk45swT1SZV0v3XLu+CMQr38JD5Bt9LWPBRUicXnZTO22i33YQkMeSq8H4H/lEsK2halPwZAOdm0tN91kDvUdaGj9FAS/3AydKpE24tZwBEh95xbU3cou5L88hkzXid0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id D5B9668AFE; Mon, 21 Jul 2025 08:14:11 +0200 (CEST)
Date: Mon, 21 Jul 2025 08:14:11 +0200
From: Christoph Hellwig <hch@lst.de>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.com>,
	Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Josef Bacik <josef@toxicpanda.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC DRAFT DOESNOTBUILD] inode: free up more space
Message-ID: <20250721061411.GA28632@lst.de>
References: <20250715-work-inode-fscrypt-v1-1-aa3ef6f44b6b@kernel.org> <20250718160414.GC1574@quark>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250718160414.GC1574@quark>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Jul 18, 2025 at 09:04:14AM -0700, Eric Biggers wrote:
> If done properly, fixing this would be great.  I've tried to minimize
> the overhead of CONFIG_FS_ENCRYPTION and CONFIG_FS_VERITY when those
> features are not actually being used at runtime.  The struct inode
> fields are the main case where we still don't do a good job at that.

Can you take a look if my idea of not allocating the verity data for
all inodes but just those where verity is enabled and then looking that
up using a rhashtable makes any sense?


