Return-Path: <linux-fsdevel+bounces-6572-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 157948199BB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Dec 2023 08:40:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AABFFB243B4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Dec 2023 07:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B719C168D1;
	Wed, 20 Dec 2023 07:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="qy7Cmt9O"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 434032135D;
	Wed, 20 Dec 2023 07:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=ngYO8w4xEMeyVxDuDZMJoLOL2uVoOjZGaa0n4KABU6c=;
  b=qy7Cmt9O1QYf0vjHyuwJw3P+qhTDMvpEMzlir3AJxAjLzUS2dre6bV9D
   SzXdnvC/AVxnoHe79EsDsNHOfRgtEIjsJCg2Cbd8U8QT47ADsw1iNBcN4
   rE24mYdFEJWM2YJPk50LyiwQUxEfo4eQqGPTVIJmQ5lC/2z/GHC4+PKPd
   8=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.04,290,1695679200"; 
   d="scan'208";a="143245362"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2023 08:39:20 +0100
Date: Wed, 20 Dec 2023 08:39:20 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Luis Chamberlain <mcgrof@kernel.org>
cc: =?ISO-8859-15?Q?Thomas_Wei=DFschuh?= <linux@weissschuh.net>, 
    Joel Granados <j.granados@samsung.com>, 
    Dan Carpenter <dan.carpenter@linaro.org>, 
    Kees Cook <keescook@chromium.org>, 
    "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
    Iurii Zaikin <yzaikin@google.com>, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
    linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 00/18] sysctl: constify sysctl ctl_tables
In-Reply-To: <ZYIwpHXkqBkMB8zl@bombadil.infradead.org>
Message-ID: <alpine.DEB.2.22.394.2312200838160.3151@hadrien>
References: <20231208095926.aavsjrtqbb5rygmb@localhost> <8509a36b-ac23-4fcd-b797-f8915662d5e1@t-8ch.de> <20231212090930.y4omk62wenxgo5by@localhost> <ZXligolK0ekZ+Zuf@bombadil.infradead.org> <20231217120201.z4gr3ksjd4ai2nlk@localhost>
 <908dc370-7cf6-4b2b-b7c9-066779bc48eb@t-8ch.de> <ZYC37Vco1p4vD8ji@bombadil.infradead.org> <a0d96e7b-544f-42d5-b8da-85bc4ca087a9@t-8ch.de> <ZYIGi9Gf7oVI7ksf@bombadil.infradead.org> <alpine.DEB.2.22.394.2312192218050.3196@hadrien>
 <ZYIwpHXkqBkMB8zl@bombadil.infradead.org>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Tue, 19 Dec 2023, Luis Chamberlain wrote:

> On Tue, Dec 19, 2023 at 10:21:25PM +0100, Julia Lawall wrote:
> > > As I noted, I think this is a generically neat endeavor and so I think
> > > it would be nice to shorthand *any* member of the struct. ctl->any.
> > > Julia, is that possible?
> >
> > What do you mean by *any* member?
>
> I meant when any code tries to assign a new variable to any of the
> members of the struct ctl_table *foo, so any foo->*any*

Declaring any to be an identifier metavariable would be sufficient.

>
> > If any is an identifier typed
> > metavariable then that would get any immediate member.  But maybe you want
> > something like
> >
> > <+...ctl->any...+>
> >
> > that will match anything that has ctl->any as a subexpression?
>
> If as just an expression, then no, we really want this to be tied to
> the data struture in question we want to modify.

What about foo->a.b?  Or maybe that doesn't occur in your structure?

julia

