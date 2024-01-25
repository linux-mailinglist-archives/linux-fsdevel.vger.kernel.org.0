Return-Path: <linux-fsdevel+bounces-9018-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C8D583D088
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jan 2024 00:20:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C98A1F25DAA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 23:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE82612E40;
	Thu, 25 Jan 2024 23:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qFapaksl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22BD312B8A;
	Thu, 25 Jan 2024 23:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706224839; cv=none; b=XiUkcSzVc3IDRc59JmCKWZWNParp9Wh6vHMUYYMAjnhTC/2FFf3LajxISlvQygR/QvPCfuVZ3Te0EnF4WjE4yimirmj/C6zgLD555VloixsYOWyFyxGh171yerqxyg9PG7Ex5ivvsg2JVcEivD5y4YK0D0fpvz+xFNB3J2HQgus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706224839; c=relaxed/simple;
	bh=Z5D1PY2CAAXEPTMCVPGBGFQOw3qPNmTGxykS0jU56Mw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AiNjPzoNSgWic+J05TwJjcHwO9t8La53eC4/KWvtpuwofRDT0p2/UrR3b4AXQaqf1cxUril9QOr/gPrpalysdWRk/rjbrQh7KvSj2eedhs7foq61BHfEOqzgyjAnmd+OJzvax/J72sb7NyACCWZkn11QjrdFYszDPrxkO1dNRWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qFapaksl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83E63C433C7;
	Thu, 25 Jan 2024 23:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706224838;
	bh=Z5D1PY2CAAXEPTMCVPGBGFQOw3qPNmTGxykS0jU56Mw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qFapakslXpv/a++Oj3QugNOWhJjpNJ+bjkPKX3/QcKx5BQYb7i65n2NfXnzU15s9f
	 FzuK56WP3M8kr0haVSDdurBSwS1hrQxx0bK9tNVngVi0NuQ9f7F2hPqxbVHm9afbqH
	 7nl+PkSqY8UpBPrYpbkIAkN+YUVuOpbyILB4hS9M=
Date: Thu, 25 Jan 2024 15:20:37 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Joe Damato <jdamato@fastly.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	chuck.lever@oracle.com, jlayton@kernel.org,
	linux-api@vger.kernel.org, brauner@kernel.org, edumazet@google.com,
	davem@davemloft.net, alexander.duyck@gmail.com,
	sridhar.samudrala@intel.com, kuba@kernel.org,
	willemdebruijn.kernel@gmail.com, weiwan@google.com,
	Jonathan Corbet <corbet@lwn.net>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nathan Lynch <nathanl@linux.ibm.com>,
	Steve French <stfrench@microsoft.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Jiri Slaby <jirislaby@kernel.org>,
	Julien Panis <jpanis@baylibre.com>, Arnd Bergmann <arnd@arndb.de>,
	Andrew Waterman <waterman@eecs.berkeley.edu>,
	Thomas Huth <thuth@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
	"open list:FILESYSTEMS (VFS and infrastructure)" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH net-next v3 3/3] eventpoll: Add epoll ioctl for
 epoll_params
Message-ID: <2024012559-appraiser-coerce-b32f@gregkh>
References: <20240125225704.12781-1-jdamato@fastly.com>
 <20240125225704.12781-4-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240125225704.12781-4-jdamato@fastly.com>

On Thu, Jan 25, 2024 at 10:56:59PM +0000, Joe Damato wrote:
> --- a/fs/eventpoll.c
> +++ b/fs/eventpoll.c
> @@ -6,6 +6,8 @@
>   *  Davide Libenzi <davidel@xmailserver.org>
>   */
>  
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +

Why this addition?  You do not add any pr_*() calls in this patch at all
that I can see.

thanks,

greg k-h

