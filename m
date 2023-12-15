Return-Path: <linux-fsdevel+bounces-6202-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32C59814DD5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Dec 2023 18:05:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 390C71C24105
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Dec 2023 17:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 249923EA7C;
	Fri, 15 Dec 2023 17:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="LOQXWakv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C993FB30;
	Fri, 15 Dec 2023 17:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=b1r61txkB9I8VrHQEVInIZpLPckdP0rJJDvEIPWqnEc=;
  b=LOQXWakvBy71xew3ASNMm74HJhXhtZmGAWww6FCy4WhqGrbYOkvEXM4a
   jhWMjanSBJoz+2nppCXYM5oKMZWx0CGF5sk8M8F3MSacN05AhGcRBx45+
   Y2rLF835GG08AE8+Sep1xKrSZSpyMR0LZlDFp4clPo2WHVVS3kpcLkE0h
   c=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.04,279,1695679200"; 
   d="scan'208";a="74574559"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 18:05:04 +0100
Date: Fri, 15 Dec 2023 18:05:02 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
To: =?ISO-8859-15?Q?Thomas_Wei=DFschuh?= <linux@weissschuh.net>
cc: Luis Chamberlain <mcgrof@kernel.org>, 
    Joel Granados <j.granados@samsung.com>, 
    Dan Carpenter <dan.carpenter@linaro.org>, 
    Julia Lawall <julia.lawall@inria.fr>, Kees Cook <keescook@chromium.org>, 
    "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
    Iurii Zaikin <yzaikin@google.com>, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
    linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 00/18] sysctl: constify sysctl ctl_tables
In-Reply-To: <46d68741-0ac8-47cc-a28f-bf43575e68a1@t-8ch.de>
Message-ID: <10ea8782-5eea-879-e31e-278bb2fe73a5@inria.fr>
References: <CGME20231204075237eucas1p27966f7e7da014b5992d3eef89a8fde25@eucas1p2.samsung.com> <20231204-const-sysctl-v2-0-7a5060b11447@weissschuh.net> <20231207104357.kndqvzkhxqkwkkjo@localhost> <fa911908-a14d-4746-a58e-caa7e1d4b8d4@t-8ch.de>
 <20231208095926.aavsjrtqbb5rygmb@localhost> <8509a36b-ac23-4fcd-b797-f8915662d5e1@t-8ch.de> <20231212090930.y4omk62wenxgo5by@localhost> <ZXligolK0ekZ+Zuf@bombadil.infradead.org> <46d68741-0ac8-47cc-a28f-bf43575e68a1@t-8ch.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1238573808-1702659903=:10294"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1238573808-1702659903=:10294
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT



On Fri, 15 Dec 2023, Thomas Weißschuh wrote:

> On 2023-12-12 23:51:30-0800, Luis Chamberlain wrote:
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
>
> The fact that the code compiles should be enough, no?
> Any funky casting that would trick the compiler to accept it would
> probably also confuse any other tool.

I don't know the context, but the fact that a particular file compiles
doesn't mean that all of the lines in the file have been subjected to the
compiler, due to ifdefs.

julia

>
> > Seems like a noble endeavor for us to generalize.
> >
> > Then we just breeze through by first fixing those that *are* using
> > mutable tables by having it just de-register and then re-register
> > new tables if they need to be changed, and then a new series is sent
> > once we fix all those muttable tables.
>
> Ack. But I think the actual constification should really only be started
> after the first series for the infrastructure is in.
>
> Thomas
>
--8323329-1238573808-1702659903=:10294--

