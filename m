Return-Path: <linux-fsdevel+bounces-6347-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97C8A8162BC
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Dec 2023 23:10:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B4F11F21918
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Dec 2023 22:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A753749F89;
	Sun, 17 Dec 2023 22:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="DdxFoikZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BED54A9A2;
	Sun, 17 Dec 2023 22:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1702851016;
	bh=jV/gJmx2dRn8bG3USFFs1YL9j9hEU8IS+OZeoAALh/o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DdxFoikZMeNyWuoAcpms0q4zk04TBG1+e7/RgRUcBAW3qWQyxlpxF8KdpM/9LPfl9
	 BBHrENFjN2DUvXLi2LoDd4+Kz2e/FTz1/pMX69PXVc2aCnw0eZ33SCunVdMjK7/TE8
	 WGGHUvAHXg7I7Y4b9/DQW9E3syClaE5qe8IGSFfE=
Date: Sun, 17 Dec 2023 23:10:15 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Joel Granados <j.granados@samsung.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Julia Lawall <julia.lawall@inria.fr>, 
	Kees Cook <keescook@chromium.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	Iurii Zaikin <yzaikin@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 00/18] sysctl: constify sysctl ctl_tables
Message-ID: <908dc370-7cf6-4b2b-b7c9-066779bc48eb@t-8ch.de>
References: <CGME20231204075237eucas1p27966f7e7da014b5992d3eef89a8fde25@eucas1p2.samsung.com>
 <20231204-const-sysctl-v2-0-7a5060b11447@weissschuh.net>
 <20231207104357.kndqvzkhxqkwkkjo@localhost>
 <fa911908-a14d-4746-a58e-caa7e1d4b8d4@t-8ch.de>
 <20231208095926.aavsjrtqbb5rygmb@localhost>
 <8509a36b-ac23-4fcd-b797-f8915662d5e1@t-8ch.de>
 <20231212090930.y4omk62wenxgo5by@localhost>
 <ZXligolK0ekZ+Zuf@bombadil.infradead.org>
 <20231217120201.z4gr3ksjd4ai2nlk@localhost>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231217120201.z4gr3ksjd4ai2nlk@localhost>

On 2023-12-17 13:02:01+0100, Joel Granados wrote:
> Catching up with mail....
> 
> On Tue, Dec 12, 2023 at 11:51:30PM -0800, Luis Chamberlain wrote:
> > On Tue, Dec 12, 2023 at 10:09:30AM +0100, Joel Granados wrote:
> > > My idea was to do something similar to your originl RFC, where you have
> > > an temporary proc_handler something like proc_hdlr_const (we would need
> > > to work on the name) and move each subsystem to the new handler while
> > > the others stay with the non-const one. At the end, the old proc_handler
> > > function name would disapear and would be completely replaced by the new
> > > proc_hdlr_const.
> > >
> > > This is of course extra work and might not be worth it if you don't get
> > > negative feedback related to tree-wide changes. Therefore I stick to my
> > > previous suggestion. Send the big tree-wide patches and only explore
> > > this option if someone screams.
> >
> > I think we can do better, can't we just increase confidence in that we
> > don't *need* muttable ctl_cables with something like smatch or
> > coccinelle so that we can just make them const?
> >
> > Seems like a noble endeavor for us to generalize.
> >
> > Then we just breeze through by first fixing those that *are* using
> > mutable tables by having it just de-register and then re-register
> So let me see if I understand your {de,re}-register idea:
> When we have a situation (like in the networking code) where a ctl_table
> is being used in an unmuttable way, we do your {de,re}-register trick.

unmuttable?

> The trick consists in unregistering an old ctl_table and reregistering
> with a whole new const changed table. In this way, whatever we register
> is always const.
> 
> Once we address all the places where this happens, then we just change
> the handler to const and we are done.
> 
> Is that correct?

I'm confused.

The handlers can already be made const as shown in this series, which
does convert the whole kernel tree.
There is only one handler (the stackleak one) which modifies the table
and this one is fixed as part of the series.

(Plus the changes needed to the sysctl core to avoid mutation there)

> If that is indeed what you are proposing, you might not even need the
> un-register step as all the mutability that I have seen occurs before
> the register. So maybe instead of re-registering it, you can so a copy
> (of the changed ctl_table) to a const pointer and then pass that along
> to the register function.

Tables that are modified, but *not* through the handler, would crop
during the constification of the table structs.
Which should be a second step.

But Luis' message was not completely clear to me.
I guess I'm missing something.

> Can't think of anything else off the top of my head. Would have to
> actually see the code to evaluate further I think.
> 
> > new tables if they need to be changed, and then a new series is sent
> > once we fix all those muttable tables.

Thomas

