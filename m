Return-Path: <linux-fsdevel+bounces-12035-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67C2585A953
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Feb 2024 17:53:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5D21283EF4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Feb 2024 16:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1328B41C83;
	Mon, 19 Feb 2024 16:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="h86xzF8J"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23BEE41770;
	Mon, 19 Feb 2024 16:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708361584; cv=none; b=cK/D/l2F+/iDTaP1xXmwUSrgPp/8p2k1tnOkTXm0iHu4c3UdrEGgXfwgah5gnB17MHJm8lt67hEh68N6UpkULi1HXRQblB6iENaIdnSBFNZ1BXlGZu/HYHQsgeX65WYqsYI7jlgh5dxhBkDcUYiH8tVmHykWY7Fsk659CsNIr3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708361584; c=relaxed/simple;
	bh=kI1TDFnjzqoHHflIKZRsHmh469jjbM+AR43RgSlc6E4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e2KjycpM1f6jKstrnmOUp0ewuTJAIhFgk41NHWC/4xEa/6sbv+gBpRnQmX4TikE462RSBSCvN8W5CGHQb+DJ6RqTgpyZGtmUFN1x2Rbc9/AKzXqIxdXAuWfF946MZlSNweeuabNlss1C2TjsyLFAvvLL73xaTcLfD/Ewun2QzcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=h86xzF8J; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=mBU6F4FMvCmlzghULKN4T+OEFNdK6km1uxFjLAbwvo0=; b=h86xzF8J2+X4PqV2CAcEzzI0fQ
	KsHosJXJRfwYYPnTlNXH7tAt6ycp64Qx2vSllLBJ/9h09IHDmF20dOvFgMtK3gJpt4ZbH6c67FeNn
	rEbNTBqWLPJapSBr1Z+hRozwKjU3umAvV1yS6zlENLkGpzigh1uAf0gfcrXWWnVZeyHgUOyBNaD0U
	h9rAMCEohPYK4qL7qcoqpW7fWM4mTnem1pRgh4Xvu1tYYRl3OrDoqUWqD1Dn/XLVXA4UzkAuXGNDj
	qz0Ua080uzuZGqtfxaShdXDDRQ9gFm+D4cWP+cDMO/TBXjCWc1a0pnAFpjSISyJaD5yHwVyS/2rJB
	ObGZJbTg==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rc6sz-0000000DIii-3GsA;
	Mon, 19 Feb 2024 16:52:57 +0000
Date: Mon, 19 Feb 2024 16:52:57 +0000
From: Matthew Wilcox <willy@infradead.org>
To: David Howells <dhowells@redhat.com>
Cc: Christian Brauner <christian@brauner.io>,
	Markus Suvanto <markus.suvanto@gmail.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Daniil Dulov <d.dulov@aladdin.ru>, linux-afs@lists.infradead.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] afs: Fix ignored callbacks over ipv4
Message-ID: <ZdOHaTLPkV8VlU7x@casper.infradead.org>
References: <20240219143906.138346-1-dhowells@redhat.com>
 <20240219143906.138346-2-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240219143906.138346-2-dhowells@redhat.com>

On Mon, Feb 19, 2024 at 02:39:02PM +0000, David Howells wrote:
> +++ b/fs/afs/internal.h
> @@ -321,8 +321,7 @@ struct afs_net {
>  	struct list_head	fs_probe_slow;	/* List of afs_server to probe at 5m intervals */
>  	struct hlist_head	fs_proc;	/* procfs servers list */
>  
> -	struct hlist_head	fs_addresses4;	/* afs_server (by lowest IPv4 addr) */
> -	struct hlist_head	fs_addresses6;	/* afs_server (by lowest IPv6 addr) */
> +	struct hlist_head	fs_addresses;	/* afs_server (by lowest IPv6 addr) */

Comment is out of date ...

> @@ -561,8 +560,7 @@ struct afs_server {
>  	struct afs_server __rcu	*uuid_next;	/* Next server with same UUID */
>  	struct afs_server	*uuid_prev;	/* Previous server with same UUID */
>  	struct list_head	probe_link;	/* Link in net->fs_probe_list */
> -	struct hlist_node	addr4_link;	/* Link in net->fs_addresses4 */
> -	struct hlist_node	addr6_link;	/* Link in net->fs_addresses6 */
> +	struct hlist_node	addr_link;	/* Link in net->fs_addresses6 */

Ditto


