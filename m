Return-Path: <linux-fsdevel+bounces-25584-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44DD494DA88
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Aug 2024 05:55:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 772791C22427
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Aug 2024 03:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CE7D13D52C;
	Sat, 10 Aug 2024 03:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="m5RYSlPi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 975A013699A;
	Sat, 10 Aug 2024 03:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723262002; cv=none; b=Dl2V/ZCBymn3uyRgMYeZuM7aGYgzVDsVoG30aFy8y7SySOSQVmRlpe3cYL++33HZZvWhPVzO392H+YBoJYUbK8PMX3qPxu6WG8zJksfHCX9YHPnR9aFSRzypp+4oM77bVPGywrNWXk4Qp6jGIjlac+RuWJqOMsjrSEKEbrM1P1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723262002; c=relaxed/simple;
	bh=xxBJMprPtvqrEKrigCedZ5Y4I5aHj5neZIj5zaaT5xE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c+N1BHXaazWndeSfVz+ENevKWRRnA0ylI7OVB/IXDCKaQ06f6q2R6kiirLv10oCdlo0reGHgzwXVsgt0h0IlTFex1pqj/bt0taAUNN720R5xziCtRJR+cqtZE9u9RYLTnToXbUNP9VZHUU1R51uI9rTIWnzaiskx7TgSNE7wTwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=m5RYSlPi; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Z7rOrE8Y70JiFgLapf0LWjP+GlmJwlh6UaRo/jTzlXs=; b=m5RYSlPi9w+4OuRnkGq8Ku00yw
	Nt/2xLSd/j8cN52wBop+kKn3ydSAZPgZSYIu1yyjhsDDRocaH95pz/O5OZ97F4gNHbkPJh++wOIgn
	bNDpyVoS7t9KMvIu3QnFjMotBqT3PAoDkpSwMBomQzsMHbt1fnpVYvT3A8VPIEwty5JC7JR3d2XmK
	+el+WaS29AdtwOvt9xlDu8hr1XvvmZjB7d/hRlZpUWditEa+NxY56htH/8vP+yzuVo7VGmEU/LmrZ
	ASyUCq1rqTrG/30wzIGYP6NO8NNYqEPVVY7WCDsI2/PHkCI8tJEQFJAcBETR0+TiHLD1xbqq9JwEI
	cQoiJ6gQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1scdAM-00000000L2Q-1dkz;
	Sat, 10 Aug 2024 03:53:18 +0000
Date: Sat, 10 Aug 2024 04:53:18 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Christian Brauner <brauner@kernel.org>
Cc: viro@kernel.org, linux-fsdevel@vger.kernel.org, amir73il@gmail.com,
	bpf@vger.kernel.org, cgroups@vger.kernel.org, kvm@vger.kernel.org,
	netdev@vger.kernel.org, torvalds@linux-foundation.org
Subject: Re: [PATCH 36/39] assorted variants of irqfd setup: convert to
 CLASS(fd)
Message-ID: <20240810035318.GD13701@ZenIV>
References: <20240730050927.GC5334@ZenIV>
 <20240730051625.14349-1-viro@kernel.org>
 <20240730051625.14349-36-viro@kernel.org>
 <20240807-evaluieren-weizen-13209b2053ab@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240807-evaluieren-weizen-13209b2053ab@brauner>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Aug 07, 2024 at 12:46:35PM +0200, Christian Brauner wrote:
> On Tue, Jul 30, 2024 at 01:16:22AM GMT, viro@kernel.org wrote:
> > From: Al Viro <viro@zeniv.linux.org.uk>
> > 
> > in all of those failure exits prior to fdget() are plain returns and
> > the only thing done after fdput() is (on failure exits) a kfree(),
> 
> They could also be converted to:
> 
> struct virqfd *virqfd __free(kfree) = NULL;
> 
> and then direct returns are usable.

No.  They could be converted, but kfree() is *not* the right
destructor for that thing.  This is a good example of the
reasons why __cleanup should not be used blindly - this
"oh, we'll just return, this object will be taken care of
automagically" would better really take care of the object.
Look for goto error_eventfd; in there...

