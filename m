Return-Path: <linux-fsdevel+bounces-24045-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41FF793845F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 21 Jul 2024 12:59:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BE891C20A1C
	for <lists+linux-fsdevel@lfdr.de>; Sun, 21 Jul 2024 10:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2080F15FA73;
	Sun, 21 Jul 2024 10:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UrlCfNs6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E53C8F70;
	Sun, 21 Jul 2024 10:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721559555; cv=none; b=I7iViaMntZyr3ZD77D9Y7Sxj2c/Ktm+qtXb5etQHcob5I0SXK3B3wtYbR8iod8rQ8C8iszbb7+k9Ltc26ew1c4H8dZCG8qfvm5KaWfj/B2kiV//RdduF+wpfpFN8XuMRYKeHLHqMZSn79XZ8nO3OUVzaVtO6piNB3+XVBNbEbgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721559555; c=relaxed/simple;
	bh=92j5GWWjGInDqkyO616LjPDFfV/SQcIzsD8VEc0YMrQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gHYsNNHqHSny5ANJ84MnmO3aeRfbFaOZapDMBnZV4jmrcTfoJvmpbIgxpcMzJrbMQaOHkx8IvDkovr/8jNuzOvg+602vYYw9GEZztIbukG32wQq51PQOIxYfPrc/e24iYP1q0ViqO2CphLh6jpCGi5jfa3t5f0gD4w2Ov5Vdno8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=UrlCfNs6; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=92j5GWWjGInDqkyO616LjPDFfV/SQcIzsD8VEc0YMrQ=; b=UrlCfNs6zL0Dd0FRTysmoov/Bw
	/wsboegaWfzf/Zebihfv+b1g4sUGQGelgzjEX1vBwQ0WPhoShzhNG01Hk1BYs7pEjv3px6rLpywDv
	xaKDQ3PjKLMpM3DSinoXfrJYkuLipD2958Z/IAL3E6c9hxzxd6H9OnrGfHawvYhr5uelTsw7MIuew
	0LBjmAEKvlJnjn0qj9xJrjc2E6RB+j8p/Mr7s8TpuTBNlvfCo9FpJdCWCMp16Yy0QEAgGtmo++uje
	cm/uTytcLU7SjnZfrO0Zb+KZiQxPzsaf+vyOHpfwjlh/d84SXHA+EMvHqgldUkDYeH9ZHgszAhlmG
	kxD4d7Mw==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sVUHQ-00000004lM7-0vcY;
	Sun, 21 Jul 2024 10:59:04 +0000
Date: Sun, 21 Jul 2024 11:59:04 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Edward Adam Davis <eadavis@qq.com>
Cc: syzbot+34a0ee986f61f15da35d@syzkaller.appspotmail.com,
	brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
	viro@zeniv.linux.org.uk
Subject: Re: [PATCH] fs/pidfs: when time ns disabled add check for ioctl
Message-ID: <Zpzp-NO6dyRhcqmH@casper.infradead.org>
References: <000000000000cf8462061db0699c@google.com>
 <tencent_7FAE8DB725EE0DD69236DDABDDDE195E4F07@qq.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_7FAE8DB725EE0DD69236DDABDDDE195E4F07@qq.com>

On Sun, Jul 21, 2024 at 02:23:12PM +0800, Edward Adam Davis wrote:
> syzbot call pidfd_ioctl() with cmd "PIDFD_GET_TIME_NAMESPACE" and disabled
> CONFIG_TIME_NS, since time_ns is NULL, it will make NULL ponter deref in
> open_namespace.

what about PIDFD_GET_TIME_FOR_CHILDREN_NAMESPACE?

