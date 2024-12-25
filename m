Return-Path: <linux-fsdevel+bounces-38118-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 257449FC5B4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Dec 2024 14:53:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 927E21883B70
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Dec 2024 13:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 127F11B6CE0;
	Wed, 25 Dec 2024 13:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="npy/rPnZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-176.mta0.migadu.com (out-176.mta0.migadu.com [91.218.175.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10BC175809
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Dec 2024 13:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735134800; cv=none; b=P/rMfkc8aRAltypn0/FbOD5PbHMj7oPGj9JHs7TnOdIhTC1ixDKy+CEDgFuR2FXBikPHVrSecuslIhWS7zS3hfSYEzJCkOZGYSfulWigC/YPL4r/zmK2h3LGScA3HdwOSsTrkz7uKbx1786t+9omghsedhuFCMqvZ1FqvgYz+iM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735134800; c=relaxed/simple;
	bh=i1I713bOjiuGmmcI/m1mu04/hFQzmHDNLw8+vGTfqIk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JaJSV1iT0cyHZzlkTgkLHkt9uUc2Jt3XYmt0Qa39ioU3Mrt/Wc2gyr1IEEwKhOlGUaaBtmwla+xkZwGVCtAGNUP7WwIVTDFjY6BvNPiddJ/KLup/YRwHm5Xxv6zZjyzbhjG/q2l8HyyivAuAXdOX0sASeVmhueWitXFtYHXN0Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=npy/rPnZ; arc=none smtp.client-ip=91.218.175.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 25 Dec 2024 08:53:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1735134793;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4wT2BRvBtRUdrnz78UtwLmugUJOChAIIZuyscLjpyf4=;
	b=npy/rPnZCihEH5jsTp5IDV739Mk1OhG6AnN/AsdgqKgu3xib5JMT8a4YsP1yz09AM96wAZ
	W4enHhO6q+w6WjdRKe0TqPKUL0LcelZxwqS6eukRmeMUkRreM+6itpFf9KCTcoE1q8U4Uc
	OYOXNf0CmZnn4Q6keKpKaMiofKeAaRY=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: WangYuli <wangyuli@uniontech.com>, viro@zeniv.linux.org.uk, 
	brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, yushengjin@uniontech.com, zhangdandan@uniontech.com, 
	guanwentao@uniontech.com, zhanjun@uniontech.com, oliver.sang@intel.com, 
	ebiederm@xmission.com, colin.king@canonical.com, josh@joshtriplett.org, 
	penberg@cs.helsinki.fi, manfred@colorfullife.com, mingo@elte.hu, jes@sgi.com, hch@lst.de, 
	aia21@cantab.net, arjan@infradead.org, jgarzik@pobox.com, 
	neukum@fachschaft.cup.uni-muenchen.de, oliver@neukum.name, dada1@cosmosbay.com, axboe@kernel.dk, 
	axboe@suse.de, nickpiggin@yahoo.com.au, dhowells@redhat.com, nathans@sgi.com, 
	rolandd@cisco.com, tytso@mit.edu, bunk@stusta.de, pbadari@us.ibm.com, 
	ak@linux.intel.com, ak@suse.de, davem@davemloft.net, jsipek@cs.sunysb.edu
Subject: Re: [RESEND PATCH] fs/pipe: Introduce a check to skip sleeping
 processes during pipe read/write
Message-ID: <am7mlhd67ymicifo6qi56pw4e34cj3623drir3rvtisezpl4eu@e5zpca7g5ayy>
References: <75B06EE0B67747ED+20241225094202.597305-1-wangyuli@uniontech.com>
 <Z2wI3dmmrhMRT-48@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z2wI3dmmrhMRT-48@smile.fi.intel.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Dec 25, 2024 at 03:30:05PM +0200, Andy Shevchenko wrote:
> Don't you think the Cc list is a bit overloaded?

Indeed, my mail server doesn't let me reply-all.

> On Wed, Dec 25, 2024 at 05:42:02PM +0800, WangYuli wrote:
> > +config PIPE_SKIP_SLEEPER
> > +	bool "Skip sleeping processes during pipe read/write"
> > +	default n
> 
> 'n' is the default 'default', no need to have this line.

Actually, I'd say to skip the kconfig option for this. Kconfig options
that affect the behaviour of core code increase our testing burden, and
are another variable to account for when chasing down bugs, and the
potential overhead looks negligable.

Also, did you look at adding this optimization to wake_up()? No-op
wakeups are very common, I think this has wider applicability.

