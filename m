Return-Path: <linux-fsdevel+bounces-5816-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8B53810BD4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 08:51:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4C70B20A54
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 07:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B5BC1A733;
	Wed, 13 Dec 2023 07:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dOw65wL1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68C84BD;
	Tue, 12 Dec 2023 23:51:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
	bh=yTukDIvPvseoy1hNbDDGgwwb3/RxkKSXoPYCWaH//5k=; b=dOw65wL1I3pJFA5OkCVW55giVL
	jJOalIrBc4j5r5LTdtvyxA1zUhkCTVINrUqDH91ldAoL5//nxZU6VM6LJDAHN+y+04ahad3r6/7Yt
	DEQIDRkPkYN+kmbw6X2G+ZSVBc39WtgYe+rCMFFt6P9w8Inp3lDn8SSU1hIFnrcn+RwKzOlIUQMNP
	mN69RIlgKuKQzEI6IkWrsjn2oYkIsOcLAQeMo46wLMFqi0XRJFNiVgkPqEib7Nhgr8OGCQTJXqsJG
	l6xc1q3tNol6mXgirY7wtWqmBT69VNPXFz108aP/W+EQpl+jM1nykC/2BzDh9FJ1OHjmAoU6xeY31
	lC0TRIqw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rDK1i-00DxGw-2a;
	Wed, 13 Dec 2023 07:51:30 +0000
Date: Tue, 12 Dec 2023 23:51:30 -0800
From: Luis Chamberlain <mcgrof@kernel.org>
To: Joel Granados <j.granados@samsung.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Julia Lawall <julia.lawall@inria.fr>,
	Kees Cook <keescook@chromium.org>
Cc: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Iurii Zaikin <yzaikin@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 00/18] sysctl: constify sysctl ctl_tables
Message-ID: <ZXligolK0ekZ+Zuf@bombadil.infradead.org>
References: <CGME20231204075237eucas1p27966f7e7da014b5992d3eef89a8fde25@eucas1p2.samsung.com>
 <20231204-const-sysctl-v2-0-7a5060b11447@weissschuh.net>
 <20231207104357.kndqvzkhxqkwkkjo@localhost>
 <fa911908-a14d-4746-a58e-caa7e1d4b8d4@t-8ch.de>
 <20231208095926.aavsjrtqbb5rygmb@localhost>
 <8509a36b-ac23-4fcd-b797-f8915662d5e1@t-8ch.de>
 <20231212090930.y4omk62wenxgo5by@localhost>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20231212090930.y4omk62wenxgo5by@localhost>
Sender: Luis Chamberlain <mcgrof@infradead.org>

On Tue, Dec 12, 2023 at 10:09:30AM +0100, Joel Granados wrote:
> My idea was to do something similar to your originl RFC, where you have
> an temporary proc_handler something like proc_hdlr_const (we would need
> to work on the name) and move each subsystem to the new handler while
> the others stay with the non-const one. At the end, the old proc_handler
> function name would disapear and would be completely replaced by the new
> proc_hdlr_const.
>=20
> This is of course extra work and might not be worth it if you don't get
> negative feedback related to tree-wide changes. Therefore I stick to my
> previous suggestion. Send the big tree-wide patches and only explore
> this option if someone screams.

I think we can do better, can't we just increase confidence in that we
don't *need* muttable ctl_cables with something like smatch or
coccinelle so that we can just make them const?

Seems like a noble endeavor for us to generalize.

Then we just breeze through by first fixing those that *are* using
mutable tables by having it just de-register and then re-register
new tables if they need to be changed, and then a new series is sent
once we fix all those muttable tables.

  Luis

