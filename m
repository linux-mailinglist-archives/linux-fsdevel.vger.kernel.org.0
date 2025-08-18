Return-Path: <linux-fsdevel+bounces-58179-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C37DAB2AB9E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Aug 2025 16:52:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4BBA5A804A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Aug 2025 14:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B53F35A2B2;
	Mon, 18 Aug 2025 14:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="to41R6vP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FFBE35A2A2;
	Mon, 18 Aug 2025 14:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755527608; cv=none; b=uRA6IG7JgjHJLkY1K6zrW3O2hAuMj5vcl/73WS5FJvuh9HJ0/klPw1A2STRaau0/OF0NpFaJxSmqB7b/JqYA605gOWjgoD6ZU3qv/9eXt6Xgosk9b+d38NDy5DTmHcmcEy29nGox6vlDs2XGZ8OeaN2dxKislPUtnO858StG4Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755527608; c=relaxed/simple;
	bh=2cEuLsC2iG5zRvxhL333RmCdZRVo9OnSZw03YVfnatM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cWxDWhuRYjOMT6+f0qqdPx30MBb/vVhMJQhRXegxaXGRY+l2RvNJnb/cj+L4iPAw7N/Pii/4CO0rhlGQDBP4ncWOWmPzivmMT+rp8rsJNi+KaXiGZ8b3aBNDiiOAkQXCO2l3DLQZ0zX6ySMhB+7zwuLgamd2FdHJM4aGFXMjkv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=to41R6vP; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=2bKVcHPa7Hp1PTCyMkRD0bE4Beico8C6cJy9TiNStRM=; b=to41R6vPu8mdKrYFkBL7cPSNki
	vzB/LdkfJFVSqYtC7IMA1RwL3x41IPTFlgzF660xD0zuTm40xBvqKdCiGvihRs/KoX8fyh7wqBUtH
	TJDtiQyHGmg9PaKVaUKjjoA3tErS30kY3XYeNRxqQ/rw3JvyjBBUdcxwr/f3IWzgZU/G9ig+HiEB7
	nyMoGRQfIb+wIyGBnnuUIbn1pr/LoBtvTgyZXGmWzc0WLG4t15xgmgkGut23hE8/nsHZHjuy7BBKh
	Xg2sinQ96xAL2RcBHFfEzuYgnSbp0OIfUDik+N+XCYhDPIhRqNzrMjdeeVsPAiSmjLDGY05w3sEpw
	1HYlmL2g==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uo0vJ-00000007EYT-2i59;
	Mon, 18 Aug 2025 14:33:21 +0000
Date: Mon, 18 Aug 2025 15:33:21 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Chi Zhiling <chizhiling@163.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	Yuezhang Mo <yuezhang.mo@sony.com>,
	Chi Zhiling <chizhiling@kylinos.cn>
Subject: Re: [PATCH 1/3] mpage: terminate read-ahead on read error
Message-ID: <aKM5sUFuOevaG4_i@casper.infradead.org>
References: <20250812072225.181798-1-chizhiling@163.com>
 <20250817194125.921dd351332677e516cc3b53@linux-foundation.org>
 <9b3116ba-0f68-44bb-9ec9-36871fe6096e@163.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9b3116ba-0f68-44bb-9ec9-36871fe6096e@163.com>

On Mon, Aug 18, 2025 at 06:04:23PM +0800, Chi Zhiling wrote:
> > Also, boy this is old code.  Basically akpm code from pre-git times.
> > It was quite innovative back then, but everybody who understood it has
> > since moved on,  got senile or probably died.  Oh well.
> 
> Actually, I think this patch is safe, but I'm not sure if we should fix this
> issue. After all, this code has existed for a long time, and it's quite rare
> to unplug the device during a copy operation :)

Converting exfat to use iomap would be a valuable piece of work ...

