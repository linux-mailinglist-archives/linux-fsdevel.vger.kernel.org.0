Return-Path: <linux-fsdevel+bounces-7004-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A6C3081F8CA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Dec 2023 14:21:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 477131F24327
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Dec 2023 13:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A22D8493;
	Thu, 28 Dec 2023 13:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WWeg/q28"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A0378468;
	Thu, 28 Dec 2023 13:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
	bh=5WFJOinis3qnBF0y2Gbqc3b1zDBHhNI054O6/NG5o8I=; b=WWeg/q287JzG0bdYrkhQdR09yn
	Z0iuMEGKu/O9WN2ICtTBHHPGgFWTMNYBLrKVBLJdchoHbsr51+emugvuNopT4oKVe7gFl1sPzJtrb
	Qakz2NOKvDg1Uyl5WGmnzB3x3A8Ez6f1/qN+qG1IXHUa4Gj/lZGqj4vAEbHzXb4+C4QpwLxV4IUS0
	mDr6anCHvAccaZd8XOg4VfrzbDeB1Nx6r9CKIDOVFmG0wxIhT7wQF1jOVdT0+jyOTRlk1NE8b5V2u
	9lJf/DCDx8gFxd4erglO/6RGV41VziwT0uh6xXDc5deXge+QN0te14tpd1t3nxGQ+YwZDCqmKgY8c
	R6aA1z4Q==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rIqK1-00GvJg-1y;
	Thu, 28 Dec 2023 13:21:13 +0000
Date: Thu, 28 Dec 2023 05:21:13 -0800
From: Luis Chamberlain <mcgrof@kernel.org>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Kees Cook <keescook@chromium.org>,
	Joel Granados <j.granados@samsung.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH] sysctl: treewide: constify ctl_table_root::permissions
Message-ID: <ZY12SeFBVb46iUg5@bombadil.infradead.org>
References: <20231226-sysctl-const-permissions-v1-1-5cd3c91f6299@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231226-sysctl-const-permissions-v1-1-5cd3c91f6299@weissschuh.net>
Sender: Luis Chamberlain <mcgrof@infradead.org>

On Tue, Dec 26, 2023 at 01:08:48PM +0100, Thomas Weiﬂschuh wrote:
> The permissions callback is not supposed to modify the ctl_table.
> Enforce this expectation via the typesystem.
> 
> The patch was created with the following coccinelle script:
> 
>   virtual patch
>   virtual context
>   virtual report

Nit:

The virtual stuff is not needed really, specially if you are not
creating rules which depend on them, they are used mostly if you
want to use coccicheck, but you could just simplify things further,
by removing them, it is implied we are expected to just run coccinelle
manually against the linux kernel tree.

So the above 3 virtual lines can be removed.

>   @@
>   identifier func, head, ctl;
>   @@
> 
>   int func(
>     struct ctl_table_header *head,
>   - struct ctl_table *ctl)
>   + const struct ctl_table *ctl)
>   { ... }
> 
> (insert_entry() from fs/proc/proc_sysctl.c is a false-positive)
> 
> This change also is a step to put "struct ctl_table" into .rodata
> throughout the kernel.
> 
> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>
> ---
> The patch is meant to be merged via the sysctl tree.
> 
> This change was originally part of the sysctl-const series [0].
> To slim down that series and reduce the message load on other
> maintainers to a minimumble, submit this patch on its own.
> 
> [0] https://lore.kernel.org/lkml/20231204-const-sysctl-v2-2-7a5060b11447@weissschuh.net/

It does that since the diff stat is small build tests suffice to ensure
in this case that no users exist which do modify the tables.

  Luis

