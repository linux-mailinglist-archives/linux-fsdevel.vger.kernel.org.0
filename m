Return-Path: <linux-fsdevel+bounces-1553-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CB967DBE3C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Oct 2023 17:47:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 447D41C20AF3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Oct 2023 16:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 075F419440;
	Mon, 30 Oct 2023 16:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RIoSIG7W"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A2D18E0F
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Oct 2023 16:47:15 +0000 (UTC)
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE5DA98;
	Mon, 30 Oct 2023 09:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=bIhF2shbU9yQ1xXu88DNW/2t71hPJ3iaMiPIW4OxDQA=; b=RIoSIG7WggABdOi0WX4MY6rASx
	WEinxOItdKlCxZt2IY5dzNeQIrQl3kumM4SkUssTiyTgpyXbZe2fjl8Obs29AVsEn+nkh9hGAVYBr
	OyALFWPiJZa2I1sjJcW6ciJlfTTD3xRqlVe1CSeL6/EJ7kbyvEUMdpvwHdB4/p+QZ6Wtsrse4CtfU
	4Mik9G6cO0xGU1ndKSieed3xTVVvWrJggwrbK2//5SbANhLriTGgCyENp1XFAyzuf8XANqgxiS2As
	JmvZpN+OIMpOccqV4T9OBzH15eZiWFqQiaHB5w7Wcp8SiXQ+806Y0o77G8n6JSwY8VCNffQk+g9d+
	K3K+gLzw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1qxVPu-005A7k-4n; Mon, 30 Oct 2023 16:47:06 +0000
Date: Mon, 30 Oct 2023 16:47:06 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Youling Tang <youling.tang@outlook.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, tangyouling@kylinos.cn
Subject: Re: [PATCH] readahead: Update the file_ra_state.ra_pages with each
 readahead operation
Message-ID: <ZT/eCvQ/Iug8GB1l@casper.infradead.org>
References: <MW4PR84MB3145AFD512F2C777635765B381A1A@MW4PR84MB3145.NAMPRD84.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MW4PR84MB3145AFD512F2C777635765B381A1A@MW4PR84MB3145.NAMPRD84.PROD.OUTLOOK.COM>

On Mon, Oct 30, 2023 at 03:41:30PM +0800, Youling Tang wrote:
> From: Youling Tang <tangyouling@kylinos.cn>
> 
> Changing the read_ahead_kb value midway through a sequential read of a
> large file found that the ra->ra_pages value remained unchanged (new
> ra_pages can only be detected the next time the file is opened). Because
> file_ra_state_init() is only called once in do_dentry_open() in most
> cases.
> 
> In ondemand_readahead(), update bdi->ra_pages to ra->ra_pages to ensure
> that the maximum pages that can be allocated by the readahead algorithm
> are the same as (read_ahead_kb * 1024) / PAGE_SIZE after read_ahead_kb
> is modified.

Explain to me why this is the correct behaviour.

Many things are only initialised at open() time and are not updated until
the next open().  This is longstanding behaviour that some apps expect.
Why should we change it?


