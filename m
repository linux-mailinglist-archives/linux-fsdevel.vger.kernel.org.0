Return-Path: <linux-fsdevel+bounces-6532-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E61BA81944D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Dec 2023 00:05:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A6841F249AA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Dec 2023 23:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA1BF3D0C7;
	Tue, 19 Dec 2023 23:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="GFjBVzq3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D323FB21;
	Tue, 19 Dec 2023 23:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=deXv4lVWUMilBoHHp3w75/hwr/YXbvS5EAOYrGm50ic=;
  b=GFjBVzq3UEyJCplsoXruB0h1ovFTW98nX14OvI9oetApWxfKE7sGGgFO
   1NjM2xaL3m+1otjrLN1wusNIqhIF21wg08GVaucCR/4Hwz+ByuKjtpl3K
   q/exQW1D1Yw8KTlpQfMblBOQTlQHrgLuDVoTzL1huBprh/HC5+9RS//sr
   0=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.04,289,1695679200"; 
   d="scan'208";a="74900283"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2023 00:04:48 +0100
Date: Wed, 20 Dec 2023 00:04:47 +0100 (CET)
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
In-Reply-To: <ZYIGi9Gf7oVI7ksf@bombadil.infradead.org>
Message-ID: <alpine.DEB.2.22.394.2312192358500.3196@hadrien>
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

I came up with the following:

@@
type t;
const t *x;
identifier y,z;
expression a;
assignment operator aop;
@@

(
  (<+...(<+...x->y...+>)[...]...+>) aop a
|
  (<+...(<+...x->y...+>)->z...+>) aop a
|
* (<+...x->y...+>) aop a
)

@fn disable optional_qualifier@
identifier f,x;
type t;
parameter list[n] ps;
@@

f(ps,t *x,...) { ... }

@@
identifier fn.f;
expression list[fn.n] es;
type t;
const t *e;
@@

*f(es,e,...)

---------------

The first rule takes care of assignments, while the remaining rules check
function calls.

This is not extensively tested and has false positives.  One case is when
you have a->b[x->y] = 12; and it is x not a that is const.  Maybe I can
improve it to avoid this problem.

I would suggest to replace the occurrences of t by your specific type of
interest (and then drop the occurrences type t;), to reduce the amount of
work to be done and the chance of false positives.

This is also limited in that it only works on a single file.  Thus in
particular the last rule on function calls will only be triggered when the
called function is defined in the same file.

Despite the current limitations, maybe it will find something useful.

julia

