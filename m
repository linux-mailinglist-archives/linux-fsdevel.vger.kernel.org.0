Return-Path: <linux-fsdevel+bounces-6198-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42556814D5B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Dec 2023 17:41:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED1671F21556
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Dec 2023 16:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2B803E489;
	Fri, 15 Dec 2023 16:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="d837zuSZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D473DBBF;
	Fri, 15 Dec 2023 16:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1702658460;
	bh=0ax0RyEqWr1bicQX9ceD1II9EiZ3PVvN4J7hKz475aU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d837zuSZbanA9sG8zz8oXkyu/FNP8MtTSoBYUW669y4cWsvJqWSmsXy9sc5u1ZJEY
	 98cmcsH4JpNWiiUTfbC0bUrJKPIrrUXK4XnzZkHkaSZD9c3DQgufYYavwsOLkt2Ol/
	 mD0qkN+fZCXekLFJyAPWof4ZP29tAZHsTSjMIzW4=
Date: Fri, 15 Dec 2023 17:40:59 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: Joel Granados <j.granados@samsung.com>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Julia Lawall <julia.lawall@inria.fr>, 
	Kees Cook <keescook@chromium.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	Iurii Zaikin <yzaikin@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 00/18] sysctl: constify sysctl ctl_tables
Message-ID: <46d68741-0ac8-47cc-a28f-bf43575e68a1@t-8ch.de>
References: <CGME20231204075237eucas1p27966f7e7da014b5992d3eef89a8fde25@eucas1p2.samsung.com>
 <20231204-const-sysctl-v2-0-7a5060b11447@weissschuh.net>
 <20231207104357.kndqvzkhxqkwkkjo@localhost>
 <fa911908-a14d-4746-a58e-caa7e1d4b8d4@t-8ch.de>
 <20231208095926.aavsjrtqbb5rygmb@localhost>
 <8509a36b-ac23-4fcd-b797-f8915662d5e1@t-8ch.de>
 <20231212090930.y4omk62wenxgo5by@localhost>
 <ZXligolK0ekZ+Zuf@bombadil.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXligolK0ekZ+Zuf@bombadil.infradead.org>

On 2023-12-12 23:51:30-0800, Luis Chamberlain wrote:
> On Tue, Dec 12, 2023 at 10:09:30AM +0100, Joel Granados wrote:
> > My idea was to do something similar to your originl RFC, where you have
> > an temporary proc_handler something like proc_hdlr_const (we would need
> > to work on the name) and move each subsystem to the new handler while
> > the others stay with the non-const one. At the end, the old proc_handler
> > function name would disapear and would be completely replaced by the new
> > proc_hdlr_const.
> > 
> > This is of course extra work and might not be worth it if you don't get
> > negative feedback related to tree-wide changes. Therefore I stick to my
> > previous suggestion. Send the big tree-wide patches and only explore
> > this option if someone screams.
> 
> I think we can do better, can't we just increase confidence in that we
> don't *need* muttable ctl_cables with something like smatch or
> coccinelle so that we can just make them const?

The fact that the code compiles should be enough, no?
Any funky casting that would trick the compiler to accept it would
probably also confuse any other tool.

> Seems like a noble endeavor for us to generalize.
> 
> Then we just breeze through by first fixing those that *are* using
> mutable tables by having it just de-register and then re-register
> new tables if they need to be changed, and then a new series is sent
> once we fix all those muttable tables.

Ack. But I think the actual constification should really only be started
after the first series for the infrastructure is in.

Thomas

