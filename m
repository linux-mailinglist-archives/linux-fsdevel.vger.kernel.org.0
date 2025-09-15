Return-Path: <linux-fsdevel+bounces-61314-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 257F9B578B6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 13:43:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D844A1A2222E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 11:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88CC93002DB;
	Mon, 15 Sep 2025 11:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Reb/9G62"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A957A2FFDE2;
	Mon, 15 Sep 2025 11:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757936532; cv=none; b=a8T65ZeIflYHZhAslTScTazCEPU1wVDcE9jL1ad8olChKhBa21UJIFoMfNY0a0Brt8rNKgRA9wdNzdwsn2j+G7y2YZ7EwtYSy4IWW1adAtYmufHbsqTF9dknSi7shtKt6nNOj1nphPXa7Q4j5mv9iVXMkOThccqMP/HbYNXQ8aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757936532; c=relaxed/simple;
	bh=f9AZ6ETGhgOlD9k/ZxuW8BeYMmQM+TaA/I74h6msMzM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AWVYR4tWISQTz77GPLWM1U/kArOET4F2YA6NPoDHdvzF4Hna3gZSCvve9YjM8Npri7vQ5dYziqJ86Cpivy4/eHW7JtvDyq8/gSoMqY2GyrHygA84y0zQ8VHSEZTMXmGq4lFQxiPzWY1yfedQuthwhkmoVaZZFTxlhzFiN/cYUg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Reb/9G62; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D78DFC4CEF7;
	Mon, 15 Sep 2025 11:42:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757936532;
	bh=f9AZ6ETGhgOlD9k/ZxuW8BeYMmQM+TaA/I74h6msMzM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Reb/9G62tOG8PU9Hb/xKDN5bmyg9zz54YcvMN7a02rfgSnhhxEV3y/LtUpEuSdUSj
	 U2NTxTTz060S1kFl1Y9Xs/8TdgF3YwjgbXiZHUXTCNilcmk0ut8c7Zgm3wfRtfFqcN
	 JZb7W+l6ij0bIU623xhg3SQxrj6E2Tv0oHsQ8oIZgE6etlpdrqE6Bi+cIIx/6+Xi4k
	 X2PdlRNFTE2pDgcQI242ZHch/vrP/LP/o5Y4510Up9rIfEmUpl/GQd3tS7hBcoDwxn
	 iX+3+p9RiKdr+gcztuYgoZiK1taRoLvmk5yj1r8l2vkxLbvcRv7BSElyeQEflG7csp
	 YQ7jPBRUIaJIw==
Date: Mon, 15 Sep 2025 13:42:04 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Amir Goldstein <amir73il@gmail.com>, linux-fsdevel@vger.kernel.org, 
	Josef Bacik <josef@toxicpanda.com>, Jeff Layton <jlayton@kernel.org>, Mike Yuan <me@yhndnzj.com>, 
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, Lennart Poettering <mzxreary@0pointer.de>, 
	Daan De Meyer <daan.j.demeyer@gmail.com>, Aleksa Sarai <cyphar@cyphar.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	netdev@vger.kernel.org
Subject: Re: [PATCH v2 11/33] net: use ns_common_init()
Message-ID: <20250915-ungeduldig-erlegen-f3d3770f15d3@brauner>
References: <20250912-work-namespace-v2-0-1a247645cef5@kernel.org>
 <20250912-work-namespace-v2-11-1a247645cef5@kernel.org>
 <ucldl3baqsuuiwzmubrkloblxfjvcecfhjd2nyvl6boccc3qlh@bumwo2wjyvgr>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ucldl3baqsuuiwzmubrkloblxfjvcecfhjd2nyvl6boccc3qlh@bumwo2wjyvgr>

On Mon, Sep 15, 2025 at 01:07:06PM +0200, Jan Kara wrote:
> On Fri 12-09-25 13:52:34, Christian Brauner wrote:
> > Don't cargo-cult the same thing over and over.
> > 
> > Signed-off-by: Christian Brauner <brauner@kernel.org>
> 
> ...
> 
> > @@ -559,7 +572,9 @@ struct net *copy_net_ns(unsigned long flags,
> >  		goto dec_ucounts;
> >  	}
> >  
> > -	preinit_net(net, user_ns);
> > +	rv = preinit_net(net, user_ns);
> > +	if (rv < 0)
> > +		goto dec_ucounts;
> 
> Umm, this seems to be leaking 'net' on error exit.

Sorry about this:

diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
index 5fb7bd8ac45a..466de530c495 100644
--- a/net/core/net_namespace.c
+++ b/net/core/net_namespace.c
@@ -572,12 +572,13 @@ struct net *copy_net_ns(unsigned long flags,
                goto dec_ucounts;
        }

-       rv = preinit_net(net, user_ns);
-       if (rv < 0)
-               goto dec_ucounts;
        net->ucounts = ucounts;
        get_user_ns(user_ns);

+       rv = preinit_net(net, user_ns);
+       if (rv < 0)
+               goto put_userns;
+
        rv = down_read_killable(&pernet_ops_rwsem);
        if (rv < 0)
                goto put_userns;

Thanks for noticing! Fixed in-tree.

