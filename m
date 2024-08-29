Return-Path: <linux-fsdevel+bounces-27850-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A75F964759
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 15:58:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2E391F22916
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 13:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 089A71AE873;
	Thu, 29 Aug 2024 13:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fi8Wj1mz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC611AD9FA;
	Thu, 29 Aug 2024 13:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724939872; cv=none; b=kig7LDTVhAT3qDx3nhtUFxyTzr7AqTChvaZb62U0HtYQUamgpqKu9qJrJMa8rE737pGJALRdZTfPKQGWmJcTVOuR0Ct/sQbM5Z1v5v/ECamqwpMrUvVMbP/+4TszU91dBHejlp1X2t4vbQY93hj+MsNC1AFZqpGFcrh1GYSsI2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724939872; c=relaxed/simple;
	bh=2SRfQnOkjrGsIdLv3up5m1cm2I8BhCPtTqy+1qCTNmE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qBtkLa1muETTswCMeSq1xKwL2eads5MKzLxiSkYUZ9lscV1nph0YHURoiTiowgH4mGQBK17T6C3dTBg4UNXXAEtdbEG5TlktrxNdEtOBCexIaKua+NbCcCiq2uDnd7hoQDxW1HgWvG2ihqukeZpNnAeu+GtTLL+uJndyVJ5qF74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fi8Wj1mz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05B08C4CEC9;
	Thu, 29 Aug 2024 13:57:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724939871;
	bh=2SRfQnOkjrGsIdLv3up5m1cm2I8BhCPtTqy+1qCTNmE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fi8Wj1mz+XR0Bx7TlQDx5tYh+hfgW086Ar3j9shr7Iql1qKxt1MIlhmVIf6fvTxUs
	 rT1QD58bBimfeBwBNyvO0fNWIZRB2aqdepoEY9H3oD9gxzcdj4DEerGpndstcHFRp1
	 mxCGJvxVnJ3P/sPfVES3NavKfyuzURRJKplGy+Co=
Date: Thu, 29 Aug 2024 15:57:48 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Dominique Martinet <asmadeus@codewreck.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	David Howells <dhowells@redhat.com>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Ilya Dryomov <idryomov@gmail.com>, Steve French <sfrench@samba.org>,
	Paulo Alcantara <pc@manguebit.com>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	v9fs@lists.linux.dev, linux-afs@lists.infradead.org,
	ceph-devel@vger.kernel.org, linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org, netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.10 083/273] 9p: Fix DIO read through netfs
Message-ID: <2024082940-unbend-purple-a400@gregkh>
References: <20240827143833.371588371@linuxfoundation.org>
 <20240827143836.571273512@linuxfoundation.org>
 <Zs4v6aV4-VpIqdfy@codewreck.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zs4v6aV4-VpIqdfy@codewreck.org>

On Wed, Aug 28, 2024 at 04:58:33AM +0900, Dominique Martinet wrote:
> Greg Kroah-Hartman wrote on Tue, Aug 27, 2024 at 04:36:47PM +0200:
> > From: Dominique Martinet <asmadeus@codewreck.org>
> > 
> > [ Upstream commit e3786b29c54cdae3490b07180a54e2461f42144c ]
> 
> As much as I'd like to have this in, it breaks cifs so please hold this
> patch until at least these two patches also get backported (I didn't
> actually test the fix so not sure which is needed, *probably*
> either/both):
> 950b03d0f66 ("netfs: Fix missing iterator reset on retry of short read")
> https://lore.kernel.org/r/20240823200819.532106-8-dhowells@redhat.com ("netfs, cifs: Fix handling of short DIO read")
> 
> For some reason the former got in master but the later wasn't despite
> having been sent together, I might have missed some mails and only the
> first might actually be required.. David, Steve please let us know if
> just the first is enough.
> 
> Either way the 9p patch can wait a couple more weeks; stuck debian CI
> (9p) is bad but cifs corruptions are worse.

Ok, now dropped, thanks!

greg k-h

