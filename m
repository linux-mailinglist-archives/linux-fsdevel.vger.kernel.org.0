Return-Path: <linux-fsdevel+bounces-22999-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BC0B9252F4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jul 2024 07:27:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7257287822
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jul 2024 05:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0484712EBF5;
	Wed,  3 Jul 2024 05:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="zjLqNvHb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 393B012E1DB;
	Wed,  3 Jul 2024 05:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719984437; cv=none; b=roMgobLRv21sgccVcw7vcBApURE0pYowhoslD3sYOej/UueC0rG0lHY+ZAT99Jt3O5ZfngLYzMAUdaIzT36yz+s0dVTN3Pp6tO1Z9VBrUJeLvI7u1FwnlSaNmfx5bzcAjjaxiwcX4Qc6JPRNqEakOjFe9HhmqwLFQL5ZvAl5Ng8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719984437; c=relaxed/simple;
	bh=J7UtXdVsH0Dw4tNImhJzkj7vjFu39SjrHJHN2KzikT4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fuerSqskrtXsgt0B6FUjUkjLLFFDNOTiXGTo0dqpxmxaKEQfMvxaS84U8o+6vxBb9NZcjrG/vDrMIe+hUSf62pLi0ssD629kceWJSeWKLxjHj+CYZlMUDmDNraFQYG3oWjLQ7uqqF9SntvfEDZnUP0kJkqqudn0Ip1UsWx+1+dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=zjLqNvHb; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=esNNsuJGjIuM6Ww/dTRdzcA7GhPLycKN8GnrTM6U61w=; b=zjLqNvHb33FcejJlisXXryXdLR
	P2ufv7DorFVmR0mc6IHxAwnrVNY6psPL5Zyj5YQ5jnlpzKWxYo/Ycw4dvtV2E0X2Lcdw41irhZttF
	Al6PKmK91DYcBqEfO+zgSf1+/lwW/O8cgnpkGF31tbc8nUjHX8PHGqiKJTxm5Wnxllc8yS04FmfLi
	pA86woHVKDXUXDSvJaalFwuDIMNcEnJwPzMpTXn1KUJcaiZCXD6xbk1WAr/Hmxk5lDzG0yt2Fyk+W
	5P7rvn9FY8cXdXcv+QZnWBbTuPed94nu0sFBeBuFk3XWk+OxurZBBnUL8hIxXGjQfTOaej+CdUuUL
	HXFxzssw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOsWN-000000092z8-3yX1;
	Wed, 03 Jul 2024 05:27:11 +0000
Date: Tue, 2 Jul 2024 22:27:11 -0700
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
Message-ID: <ZoThL-Fmyt-9Akrc@infradead.org>
References: <d91a29f0e600793917b73ac23175e02dafd56beb.camel@kernel.org>
 <20240702101902.qcx73xgae2sqoso7@quack3>
 <958080f6de517cf9d0a1994e3ca500f23599ca33.camel@kernel.org>
 <ZoPs0TfTEktPaCHo@infradead.org>
 <09ad82419eb78a2f81dda5dca9caae10663a2a19.camel@kernel.org>
 <ZoPvR39vGeluD5T2@infradead.org>
 <a11d84a3085c6a6920d086bf8fae1625ceff5764.camel@kernel.org>
 <ZoQY4jdTc5dHPGGG@infradead.org>
 <4ec1fbdc6568e16da40f41789081805e764fd83e.camel@kernel.org>
 <ZoThH9fWsdzq7IXR@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZoThH9fWsdzq7IXR@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Jul 02, 2024 at 10:26:55PM -0700, Christoph Hellwig wrote:
> So while shrinking the inodes sounds nice, the tradeoff to have to
> check all timestamps from disk / the server for validity doesn't
> sound as positive.  So I'm glade we're avoiding this at least for.

... now.

