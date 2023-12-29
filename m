Return-Path: <linux-fsdevel+bounces-7017-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7799881FE40
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Dec 2023 09:51:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78A321C210FE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Dec 2023 08:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3740C8473;
	Fri, 29 Dec 2023 08:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="a3bdh6+w"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5347493;
	Fri, 29 Dec 2023 08:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=zUGYiv9pf0gsR+xsThOtoJjaGjo2zmNHPQw801ghpqI=; b=a3bdh6+wNPZXlwfejs9ZFUJ263
	BX4BcKKXC5KJPZSLdng4RRJmU7QMBBwPqGvi47t5Epn4WW1IedxTFvj3N5RJvUn5pZCy6mTrqm094
	qfe8YkuRsnZuNPg58mz0XR1EEYY8E64fZSvj8cwaX9R62lMtw8QN4wTwU1reWu6AWt7Q31yfX9Qxi
	+ikcUcPvSfb/66RoE6SXN/I+5bsFMW9tVLofjZJtOF7ZuGJKbwFkAGkb8X5XQsUO0ZhBT/bfnnr55
	3MOcjUawQ02zJkebhgpXZ8YdxuIsPhpVjRLH80LMzETkoW2QmazLuPZla4lm7Y9yiMum/WTZa8tDa
	um4L2qmg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rJ8aQ-0064ep-Tv; Fri, 29 Dec 2023 08:51:22 +0000
Date: Fri, 29 Dec 2023 08:51:22 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: virtualization@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	kernel-janitors@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] virtiofs: Improve error handling in
 virtio_fs_get_tree()
Message-ID: <ZY6Iir/idOZBiREy@casper.infradead.org>
References: <c5c14b02-660a-46e1-9eb3-1a16d7c84922@web.de>
 <5745d81c-3c06-4871-9785-12a469870934@web.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5745d81c-3c06-4871-9785-12a469870934@web.de>

On Fri, Dec 29, 2023 at 09:38:47AM +0100, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Fri, 29 Dec 2023 09:15:07 +0100
> 
> The kfree() function was called in two cases by
> the virtio_fs_get_tree() function during error handling
> even if the passed variable contained a null pointer.

So what?  kfree(NULL) is perfectly acceptable.  Are you trying to
optimise an error path?


