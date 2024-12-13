Return-Path: <linux-fsdevel+bounces-37358-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F3DB59F154C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 19:54:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 706271883AE3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 18:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BF181E47A6;
	Fri, 13 Dec 2024 18:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gdNJsxhj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 096451547CA
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Dec 2024 18:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734116040; cv=none; b=hHTqiFu1eeKaPlaZEIVb1GHtC46M1Vn6mwOBnbvBNqhIwudZrffBD+R/3JbKvI3gTvNJ6zCylKWzGloQz0qZPmiCM1tQtlM8dECn085JSzy1PW89U/5BgBLu7HsukCP+of+pbQWIg9yXV4RaDvdku/5rXhqTSUudwSeC7qSw3uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734116040; c=relaxed/simple;
	bh=ic0luJPSFrN/wKGYFwnW3uYdoiNTvJ9VVIbU8vy1UjQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=agv73hem7iiawqN05pK2A0m4nRkG+K6omrOzEg464QXemZI0sw287OQSel1txBwM1mLYq/yE5b16ojZ6jwlGU2FcIMt/t+dDUmVfvwHClsthaBl0O7pljSEl0GO7dszBW8nPnU/5OlavBkU5lx2Cel9K0hcICOJeSfxhiHEMsNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=gdNJsxhj; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=bMu8gCOULP0dSD2N373vlgc5cAsZEX/ENInNlr+JMjk=; b=gdNJsxhjQZcdcSZpOFex7GKjdc
	fExJ2Ni3xx/X8HMlAlSGyHlfmZntxO0CU7kWzxAZ/SDLtCQ+RaTACyWmXMjcm3mVYiV/SYnGdZfpw
	paxlR+DzlUMDNRutht99IzELLmQNVc6TGmQdACEp1PtXt78XTWo4BUGGDemsRzBA8AmbmiDsK5wCw
	RN2GFnCcKWb/10bBDQe7JKI2MQA1qS/2HGwtsFH7qJjIbIjv7V3bkFI17sbz8+jPzwYY9mF/m5lzm
	J/we1K32GL+QcTcr4a+9541D9cuQh7Kpd5nh3vp3corBlwyusN9nmKr69G4Hy5HkIdXXQOwZgaSHq
	8mE8ZDKw==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tMAnU-0000000F43H-0B9D;
	Fri, 13 Dec 2024 18:53:56 +0000
Date: Fri, 13 Dec 2024 18:53:55 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Christian Brauner <brauner@kernel.org>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
	linux-fsdevel@vger.kernel.org, maple-tree@lists.infradead.org
Subject: Re: [PATCH RFC v2 0/2] pidfs: use maple tree
Message-ID: <Z1yCw665MIgFUI3M@casper.infradead.org>
References: <20241209-work-pidfs-maple_tree-v2-0-003dbf3bd96b@kernel.org>
 <oti3nyhrj5zlygxngl72xt372mdb6wm7smltuzt2axlxx6lsme@yngkucqwdjwh>
 <20241213-kaulquappen-schrank-a585a8b2cc6d@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241213-kaulquappen-schrank-a585a8b2cc6d@brauner>

On Fri, Dec 13, 2024 at 07:51:50PM +0100, Christian Brauner wrote:
> Yeah, it does. Did you see the patch that is included in the series?
> I've replaced the macro with always inline functions that select the
> lock based on the flag:
> 
> static __always_inline void mtree_lock(struct maple_tree *mt)
> {
>         if (mt->ma_flags & MT_FLAGS_LOCK_IRQ)
>                 spin_lock_irq(&mt->ma_lock);
>         else
>                 spin_lock(&mt->ma_lock);
> }
> static __always_inline void mtree_unlock(struct maple_tree *mt)
> {
>         if (mt->ma_flags & MT_FLAGS_LOCK_IRQ)
>                 spin_unlock_irq(&mt->ma_lock);
>         else
>                 spin_unlock(&mt->ma_lock);
> }
> 
> Does that work for you?

See the way the XArray works; we're trying to keep the two APIs as
close as possible.

The caller should use mtree_lock_irq() or mtree_lock_irqsave()
as appropriate.

