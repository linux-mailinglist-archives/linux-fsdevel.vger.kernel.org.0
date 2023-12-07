Return-Path: <linux-fsdevel+bounces-5105-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B2C8808340
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 09:38:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DA5F1C216E5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 08:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C15E30345
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 08:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="sz34+fma"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25BFB10EB;
	Wed,  6 Dec 2023 22:49:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=HiucoW+8Qq+OeGHdkctb71sJtz0w/36Ur4eVZYT+4P8=; b=sz34+fmatIf4sQJKuz9hINZ+wK
	Ml8GARBI7U2S82llMyj6nKnhgN6JS0a+NHihfwUeHWmuBvEUSpF4Qn+NwaXoZS1vL5A3fFn/NrqVe
	TJIDO+8XXB+whFkoqiZqL73hpiH2NOg1PvNWaPvAwNBkf8qM3AbYZG9t4bLphAUehRqBoU8W6x/EY
	ZLaPJFCenV3O7pb51r73svqe+JQjqOb+C5L5skHhISACaK+4PFPweYQSi6B1nOagTGVG6IMB43fF5
	EmLeBpxT0rcfo0Apwf+NlpqSD7VNssQv6w6qHM53RxZlbZL94bOge/FHZBFvhaqedJwZMwNIGzfgB
	rGuyIp0Q==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rB8CE-0087sO-2z;
	Thu, 07 Dec 2023 06:49:19 +0000
Date: Thu, 7 Dec 2023 06:49:18 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Dave Chinner <david@fromorbit.com>
Cc: linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	linux-cachefs@redhat.com, dhowells@redhat.com, gfs2@lists.linux.dev,
	dm-devel@lists.linux.dev, linux-security-module@vger.kernel.org,
	selinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/11] lib/dlock-list: Make sibling CPUs share the same
 linked list
Message-ID: <20231207064918.GZ1674809@ZenIV>
References: <20231206060629.2827226-1-david@fromorbit.com>
 <20231206060629.2827226-5-david@fromorbit.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231206060629.2827226-5-david@fromorbit.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Dec 06, 2023 at 05:05:33PM +1100, Dave Chinner wrote:
> From: Waiman Long <longman@redhat.com>
> 
> The dlock list needs one list for each of the CPUs available. However,
> for sibling CPUs, they are sharing the L2 and probably L1 caches
> too. As a result, there is not much to gain in term of avoiding
> cacheline contention while increasing the cacheline footprint of the
> L1/L2 caches as separate lists may need to be in the cache.
> 
> This patch makes all the sibling CPUs share the same list, thus
> reducing the number of lists that need to be maintained in each
> dlock list without having any noticeable impact on performance. It
> also improves dlock list iteration performance as fewer lists need
> to be iterated.

Probably a dumb question, but... "available" != "possible"; the code
actually goes for the latter, which avoids nasty questions about
CPU hotplug interations.  Is the sibling relation on CPUs unchanging
on CPU hotplug?

