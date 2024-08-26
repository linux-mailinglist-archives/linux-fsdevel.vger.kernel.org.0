Return-Path: <linux-fsdevel+bounces-27179-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C6BF95F33A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 15:49:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10B3E282345
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 13:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BEC21885A9;
	Mon, 26 Aug 2024 13:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="gwe1A62x"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4062715B108
	for <linux-fsdevel@vger.kernel.org>; Mon, 26 Aug 2024 13:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724680154; cv=none; b=P2vtxnKpUOOwUazo7cWQMA+yUZ8tBX2AraJlsgUFNy6E1NwqkAGOHtbeMlFrWqrPm6Zn8/aj2QdQfB0Q9fpNYZdsJBjMQguocVMwZE1VEEMgZCexxgcnUNOSJh9d2kJoA/Vp5a2/SfRiUvfVKRu9GARPl9fYPj2+dr20x59kgA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724680154; c=relaxed/simple;
	bh=f5Z6QuQ1qD8kiTVZdJfh3XTnfrGzSnB0LcLECwuW9oU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ku5uQUCioV0MF5mggANAZi06CPDETMVkEWT+ZEcCt1GK2kXWHC2FdXrDZuKJHiN0o72EtCNffD285ew6O2Rh4CQw/cELe1YTwBPDblnGeT7nMnVWcZFPmlr2xaap5479MVYXK4qiakECFvgQ+l9uZyiTAbVX/tA9KUGHXcijoj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=gwe1A62x; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=JwNE+/qH6cbZRhPp9dsc1Q+pQn1T5i43IiCM1MrKqZ0=; b=gwe1A62xmcr21Qp5pbQWWECDvo
	sl11aVpCgn6QgkvpArzlYCGVZLEMG59obfOM4TUkIBIee2QFwDBtMOTSuPGl/3YBCWC8Kolsr149g
	/Ga0CAT3rX5xFWS2MRjGH5FtA5Fnom+34kbfhbF3cV8+GZWg+FVFxWPHO5wpdqI7ZQqnxka3H1VvP
	pyTFpABXL7xiHBuFLnaoUqZnu0Ipy4UeoravzQsj41yLp/yaAYdR8wye8VhJCMHvSYFJoiIBroGra
	ZB+uQFSWlNNMVITVjznMiaXh+8fkmJvMc84juJ9rnoOiLaCrsU9A7yVB0CLjiKCjPJ2SPE99jgG8R
	T0lnh+Ew==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sia5k-00000005KIB-1naT;
	Mon, 26 Aug 2024 13:49:08 +0000
Date: Mon, 26 Aug 2024 14:49:08 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Yan Zhen <yanzhen@vivo.com>
Cc: brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org,
	opensource.kernel@vivo.com
Subject: Re: [PATCH v1] fs: proc: Fix error checking for d_hash_and_lookup()
Message-ID: <20240826134908.GF1049718@ZenIV>
References: <20240826090802.2358591-1-yanzhen@vivo.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240826090802.2358591-1-yanzhen@vivo.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Aug 26, 2024 at 05:08:02PM +0800, Yan Zhen wrote:
> The d_hash_and_lookup() function returns either an error pointer or NULL.
> 
> It might be more appropriate to check error using IS_ERR_OR_NULL().

Not for procfs it doesn't.  Please, don't use that shite.

