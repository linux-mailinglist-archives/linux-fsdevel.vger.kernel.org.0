Return-Path: <linux-fsdevel+bounces-6534-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D65B8194F6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Dec 2023 01:09:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE3B1287B0B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Dec 2023 00:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D57003D82;
	Wed, 20 Dec 2023 00:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WFFjoKNd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 226DE28EA;
	Wed, 20 Dec 2023 00:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=SOfn9nF2j9WVhkT4iazg2mOWZYi27n9v0LAXi5A+lGI=; b=WFFjoKNdluVrShYbfz6lNh4XvZ
	+sNCv0vXzmnqkuXmVLhCUV8i5eZGHhOaQKPUFOJiOu7ch4s9YSURPGie2d3Mi3OvGnNGP2xNfA/MV
	ui20waemijB/Kjk2U7dXWnTb1i3MmIJlcOeEk6yKN+/7HzDRQaZE40yYvFBEHr+G0VdCyrthY0oYk
	CPjltBrYyhIgq+d1jp57Bbk2md+Yzl4nhkfV5dH3bk9G7zltvynZfoMFopz8DI11NCAwXPeRsUNQz
	MLAOmvNnCGYsUNuMWH1ENx5cQRBr7f3d2iQkCUIi9iR/4RFU56lDMFuA5Iwd7QsvibV4wgCjzK5Mk
	23xmTl7A==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rFk96-00Fk2R-2s;
	Wed, 20 Dec 2023 00:09:08 +0000
Date: Tue, 19 Dec 2023 16:09:08 -0800
From: Luis Chamberlain <mcgrof@kernel.org>
To: Julia Lawall <julia.lawall@inria.fr>
Cc: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	Joel Granados <j.granados@samsung.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Kees Cook <keescook@chromium.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Iurii Zaikin <yzaikin@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 00/18] sysctl: constify sysctl ctl_tables
Message-ID: <ZYIwpHXkqBkMB8zl@bombadil.infradead.org>
References: <20231208095926.aavsjrtqbb5rygmb@localhost>
 <8509a36b-ac23-4fcd-b797-f8915662d5e1@t-8ch.de>
 <20231212090930.y4omk62wenxgo5by@localhost>
 <ZXligolK0ekZ+Zuf@bombadil.infradead.org>
 <20231217120201.z4gr3ksjd4ai2nlk@localhost>
 <908dc370-7cf6-4b2b-b7c9-066779bc48eb@t-8ch.de>
 <ZYC37Vco1p4vD8ji@bombadil.infradead.org>
 <a0d96e7b-544f-42d5-b8da-85bc4ca087a9@t-8ch.de>
 <ZYIGi9Gf7oVI7ksf@bombadil.infradead.org>
 <alpine.DEB.2.22.394.2312192218050.3196@hadrien>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2312192218050.3196@hadrien>
Sender: Luis Chamberlain <mcgrof@infradead.org>

On Tue, Dec 19, 2023 at 10:21:25PM +0100, Julia Lawall wrote:
> > As I noted, I think this is a generically neat endeavor and so I think
> > it would be nice to shorthand *any* member of the struct. ctl->any.
> > Julia, is that possible?
> 
> What do you mean by *any* member?

I meant when any code tries to assign a new variable to any of the
members of the struct ctl_table *foo, so any foo->*any*

> If any is an identifier typed
> metavariable then that would get any immediate member.  But maybe you want
> something like
> 
> <+...ctl->any...+>
> 
> that will match anything that has ctl->any as a subexpression?

If as just an expression, then no, we really want this to be tied to
the data struture in question we want to modify.

  Luis

