Return-Path: <linux-fsdevel+bounces-48135-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B5D06AA9EA7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 00:00:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD63E1A811ED
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 22:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 695B6274FEB;
	Mon,  5 May 2025 22:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="DtOuOVt6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A04741474B8;
	Mon,  5 May 2025 22:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746482451; cv=none; b=Z5c45EOrYky/2l8QyfcILHnStQAI4qrvx92MPgY4jr5tFmteF9CSP+20P4kzOPx+UEkTSsMMg+vbACKfAIzFDWvzK9LPp3n/Kx28UdIIN89p9/OvzaYikPk60G9ZeZ3jNlm6/AFRRt+QqqYLa7tDj0lpUCbZVypsov1utOYIo7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746482451; c=relaxed/simple;
	bh=v8wCf0cb2xu2OXSPBF8BBKLZZQKTFEDHSE/lWH7ctjU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IQRsBSgk1Y1fHrupUG+BMbnrYlwpoNk6tYG34oj83ZxIbmjh5jCjVK4TsztIajniYhw7/hDj4J2Tn09EVoudfbqQarf7l9QHYzPLgchZAkEZObaPkQwo2zTenqXZkvhFqT49i6v/gpBVgzOzZE7/2CoGSZMWXa2s2JDs5gQZ2ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=DtOuOVt6; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=esQbZH8CJXU5uC8AxaoEVgECgvTMI9c24OVe2K6DwyE=; b=DtOuOVt6cM2mwgH3bjVHfnMQ1k
	m0KTVGR/5tUx4zcgGCkQBo/N+ZF9Nt6M92GjzvxpmnVvbz6uqKxiVIDRI9E976xofx/WY8+RqRPlw
	LguNQAB3jqM1sCy3romfBT/D/RPJGm+eJHfSDgpGTL/Hpg42vEvWEdlvEybJqK9z03j4VMnlC6eB3
	m8HL+uqoEgvnotGWCmZTK1XD1nhaBzAraR0JFzqzhZheSjEb/XdF/nJsqWkVPbW5BYWSpI0LdMC6V
	nSSxQwHB+IONFKqF6aljul0DxnR73D+6qEgkewwWmUyy8sohbHZ0gyHbqQn/Nn1oxESxyiVkyF2DE
	5LCgQQig==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uC3rj-00000006tTP-1IOF;
	Mon, 05 May 2025 22:00:47 +0000
Date: Mon, 5 May 2025 23:00:47 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
	linux-trace-kernel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v2] kill vfs_submount()
Message-ID: <20250505220047.GJ2023217@ZenIV>
References: <20250503212925.GZ2023217@ZenIV>
 <utebik76wcdgaspk7sjzb3aedmlcwbmwj3olur45zuycbpapjc@pd5rhnudxb35>
 <20250505213829.GI2023217@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250505213829.GI2023217@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, May 05, 2025 at 10:38:29PM +0100, Al Viro wrote:
> On Mon, May 05, 2025 at 12:55:34PM +0200, Jan Kara wrote:
> > >  	if (!type)
> > >  		return NULL;
> > > -	mnt = vfs_submount(mntpt, type, "tracefs", NULL);
> > > +
> > > +	fc = fs_context_for_submount(type, mntpt);
> > > +	if (IS_ERR(fc))
> > > +		return ERR_CAST(fc);
> > 
> > Missing put_filesystem() here?
> 
> Actually, I'd rather have it done unconditionally right after
> fc_context_for_submount() - fs_context allocation grabs
> a reference and it's held until put_fs_context, so...

Just in case - that stuff is still on top of ->d_automount() calling
conventions change; see viro/vfs.git#work.automount for both.

