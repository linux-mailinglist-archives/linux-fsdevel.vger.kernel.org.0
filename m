Return-Path: <linux-fsdevel+bounces-6526-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ABC23819232
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Dec 2023 22:21:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F6EEB24671
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Dec 2023 21:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB9693B79F;
	Tue, 19 Dec 2023 21:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="faJ1eSGj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D1B3D0AF;
	Tue, 19 Dec 2023 21:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=T6+SsNZScQS1eMrdG8r2jB2esUWxn8xnhRMnIHOnfWw=;
  b=faJ1eSGjRVU/VL21IliFaaK3hMpLy5Z6vevuC9wkuFeb7Tk9mUrgp2xD
   glV0dtWhOz4IBfciHRbdzhBiNx8+WPYc9PlEfdOQSv8Fi7Xh00Hp0TgCg
   nHDTlx/KlSnxkAPKzx4beooZ3ecmKC+VLTiIBqn4fctIOonzCqFiPiG5O
   k=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.04,289,1695679200"; 
   d="scan'208";a="74897141"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 22:21:26 +0100
Date: Tue, 19 Dec 2023 22:21:25 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Luis Chamberlain <mcgrof@kernel.org>
cc: =?ISO-8859-15?Q?Thomas_Wei=DFschuh?= <linux@weissschuh.net>, 
    Julia Lawall <julia.lawall@inria.fr>, 
    Joel Granados <j.granados@samsung.com>, 
    Dan Carpenter <dan.carpenter@linaro.org>, 
    Kees Cook <keescook@chromium.org>, 
    "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
    Iurii Zaikin <yzaikin@google.com>, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
    linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 00/18] sysctl: constify sysctl ctl_tables
In-Reply-To: <ZYIGi9Gf7oVI7ksf@bombadil.infradead.org>
Message-ID: <alpine.DEB.2.22.394.2312192218050.3196@hadrien>
References: <20231207104357.kndqvzkhxqkwkkjo@localhost> <fa911908-a14d-4746-a58e-caa7e1d4b8d4@t-8ch.de> <20231208095926.aavsjrtqbb5rygmb@localhost> <8509a36b-ac23-4fcd-b797-f8915662d5e1@t-8ch.de> <20231212090930.y4omk62wenxgo5by@localhost>
 <ZXligolK0ekZ+Zuf@bombadil.infradead.org> <20231217120201.z4gr3ksjd4ai2nlk@localhost> <908dc370-7cf6-4b2b-b7c9-066779bc48eb@t-8ch.de> <ZYC37Vco1p4vD8ji@bombadil.infradead.org> <a0d96e7b-544f-42d5-b8da-85bc4ca087a9@t-8ch.de>
 <ZYIGi9Gf7oVI7ksf@bombadil.infradead.org>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

> As I noted, I think this is a generically neat endeavor and so I think
> it would be nice to shorthand *any* member of the struct. ctl->any.
> Julia, is that possible?

What do you mean by *any* member?  If any is an identifier typed
metavariable then that would get any immediate member.  But maybe you want
something like

<+...ctl->any...+>

that will match anything that has ctl->any as a subexpression?

It may be necessary to put this in parentheses to address parsing issues,
but the () won't need to be present in the matched code.

You could also use

assignment operator aop;

rather than =, to also match += etc.

julia

