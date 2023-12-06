Return-Path: <linux-fsdevel+bounces-4931-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3092980674B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 07:32:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E023A280A80
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 06:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 866FD14F6D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 06:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AaHiFtxw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DEC018F;
	Tue,  5 Dec 2023 21:44:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=X+sjnLZJ2l3e2jdAF84glp/xQ6OVtmNr71eC56Hfvi0=; b=AaHiFtxwniAaOcJjCOrvNRytvi
	N0klteAyDmK89PqenX1ZmD/oxc+wJzYNX95a42dOBEeftTmJnVVHgEfPx8nvW/5a3q3Ul1dc52oKz
	Q+ZaucPg2jyjMppZ/T9PqxC+vTv04K+nKosBNYTIVX/4v/jkcuwAQbnmt+HLl05hocrwTss3AU64r
	9ryVKSAVXot1wj/C2jxUkhJJQEd38mayys4TkVPFvOEH9S1HXPIXCv3Q0+7waLjQJDIZR1U21sRZa
	2diq2SQYO+pXfg442jiEYy7HyKwgidTu97iJPS1mj31GmMkUzOLAXGOvErFv2D9/0yxlw55sKdM24
	NOLBpJcg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rAkhX-0097d5-2Z;
	Wed, 06 Dec 2023 05:44:03 +0000
Date: Tue, 5 Dec 2023 21:44:03 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, NeilBrown <neilb@suse.de>,
	Al Viro <viro@zeniv.linux.org.uk>, Oleg Nesterov <oleg@redhat.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nfs@vger.kernel.org
Subject: Re: [PATCH 1/2] Allow a kthread to declare that it calls
 task_work_run()
Message-ID: <ZXAKI76NLlCHGQ7h@infradead.org>
References: <20231204014042.6754-1-neilb@suse.de>
 <20231204014042.6754-2-neilb@suse.de>
 <e9a1cfed-42e9-4174-bbb3-1a3680cf6a5c@kernel.dk>
 <170172377302.7109.11739406555273171485@noble.neil.brown.name>
 <a070b6bd-0092-405e-99d2-00002596c0bc@kernel.dk>
 <20231205-altbacken-umbesetzen-e5c0c021ab98@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231205-altbacken-umbesetzen-e5c0c021ab98@brauner>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Dec 05, 2023 at 12:14:29PM +0100, Christian Brauner wrote:
> > For me, the more core of an export it is, the stronger the reason it
> > should be GPL. FWIW, I don't think exporting task_work functionality is
> > a good idea in the first place, but if there's a strong reason to do so,
> 
> Yeah, I'm not too fond of that part as well. I don't think we want to
> give modules the ability to mess with task work. This is just asking for
> trouble.

It just seems like a really bad idea.  At the same time it fixes a real
problem.  If we go a step back how could we fix it in a better way?
Do we even need the task_run based delay for file usage from kernel
threads?


