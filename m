Return-Path: <linux-fsdevel+bounces-57974-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E394DB2746F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Aug 2025 03:02:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDC0D5E40D3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Aug 2025 01:02:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0580C19343B;
	Fri, 15 Aug 2025 01:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ymFXDpZI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E81191F72;
	Fri, 15 Aug 2025 01:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755219739; cv=none; b=g5DNkZOGCusNt0h+ftYWf+tKMbQkHy509dXD+ieP/c2/0ki+ulR1ActQc0YtA6kZYwmINSlroOX74sPM3fcfK35GJFsQyFKcVbV9i6thTyfQCLARIu+dPX9jblxjOnhq6YXvl4PkvYOIQJJIbzn+E95l4HaohRj5KzLJoQvpBk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755219739; c=relaxed/simple;
	bh=aihU9DtoEvag9K9c6xo9yUJa4EYuRTt9+t8d76M7c1s=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=D+RqQHC8q0+5Fw0E2TCH34fU0EtoWeefLPUBIzz3T7s5Tj2zQ4nAeilLmlZBcpj3NFKD2fppC7UEePJoJhqOR6gQ/3QSyi4mxGB1hfAAns7+i+8VfTLtpkjDnx3+uBYjIq2/1m1m3/etn4QUJOLLWvdoX9q52je7MxgH6MC19ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ymFXDpZI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1B60C4CEF7;
	Fri, 15 Aug 2025 01:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1755219737;
	bh=aihU9DtoEvag9K9c6xo9yUJa4EYuRTt9+t8d76M7c1s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ymFXDpZIIp3WlpSY3ApmpyoK+ZWZaGFrwQ4ZDyKG7c3XGDICwY2WNztQjGE+Zh/2a
	 w+OSG5I+CZXpaeAiNBagoOVEYqByBhrnzCZLEWKDrFmy5XOebjvvEyaZguFnlFW2yf
	 GUWHNnnpmNaaq9ByvFiB5B3TDZyzUGg3fwO1t18s=
Date: Thu, 14 Aug 2025 18:02:17 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Pedro Falcato <pfalcato@suse.de>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R . Howlett"
 <Liam.Howlett@oracle.com>, Matthew Wilcox <willy@infradead.org>, Sidhartha
 Kumar <sidhartha.kumar@oracle.com>, Vlastimil Babka <vbabka@suse.cz>,
 maple-tree@lists.infradead.org, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] testing/radix-tree/maple: hack around kfree_rcu not
 existing
Message-Id: <20250814180217.da2ab57d5b940b52aa45b238@linux-foundation.org>
In-Reply-To: <kq3y4okddkjpl3yk3ginadnynysukiuxx3wlxk63yhudeuidcc@pu5gysfsrgrb>
References: <20250814064927.27345-1-lorenzo.stoakes@oracle.com>
	<kq3y4okddkjpl3yk3ginadnynysukiuxx3wlxk63yhudeuidcc@pu5gysfsrgrb>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 14 Aug 2025 13:40:03 +0100 Pedro Falcato <pfalcato@suse.de> wrote:

> On Thu, Aug 14, 2025 at 07:49:27AM +0100, Lorenzo Stoakes wrote:
> > From: Pedro Falcato <pfalcato@suse.de>
> > 
> > liburcu doesn't have kfree_rcu (or anything similar). Despite that, we can
> > hack around it in a trivial fashion, by adding a wrapper.
> > 
> > This wrapper only works for maple_nodes, and not anything else (due to us
> > not being able to know rcu_head offsets in any way), and thus we take
> > advantage of the type checking to avoid future silent breakage.
> > 
> > This fixes the build for the VMA userland tests.
> > 
> > Additionally remove the existing implementation in maple.c, and have
> > maple.c include the maple-shared.c header.
> > 
> > Reviewed-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
> > Tested-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > Signed-off-by: Pedro Falcato <pfalcato@suse.de>
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > ---
> > 
> > Andrew - please attribute this as Pedro's patch (Pedro - please mail to
> > confirm), as this is simply an updated version of [0], pulled out to fix the
> > VMA tests which remain broken.
> >
> 
> ACK, this is fine. The future of the series is still unclear, so if this fixes
> the build then all good from my end :)

Well, can we have this as a standalone thing, rather than as a
modification to a patch whose future is uncertain?

Then we can just drop "testing/radix-tree/maple: hack around kfree_rcu
not existing", yes?

Some expansion of "fixes the build for the VMA userland tests" would be
helpful.


