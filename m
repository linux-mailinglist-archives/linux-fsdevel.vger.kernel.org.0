Return-Path: <linux-fsdevel+bounces-62269-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACE40B8BA0D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Sep 2025 01:17:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6855E568864
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Sep 2025 23:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4A002857F0;
	Fri, 19 Sep 2025 23:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="D79/joK5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411013A8F7
	for <linux-fsdevel@vger.kernel.org>; Fri, 19 Sep 2025 23:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758323835; cv=none; b=CWeCM1QWILMZp2gwEEB1m3toVRLoR7ggsiMW2ZHT5GgL8oBPVOgQOXgRTCLWi4HdYrdluhCnX+wEH+t3QezsRAau5dJBvC53eCD3+0cNRPJe0MN1OmjGWNrljuIiaXYys6obIJGQy3WwTXqVjRfppM9q9CbgsC7f9cHYYnsivGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758323835; c=relaxed/simple;
	bh=RQGE6uOr0/K5HKGtWJSJ2uRYValqy8w50H6R7/ZZdb0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PtvskC24IEbl381voWiNN6Q7r1vqCl/5XthNGbqn2GY9eEM9J4z8jourI88Llxe5Z6jZAAP7jlOFttL2TDOTRyHTQQJofDENPFs3ygmiXhibFUYw6CYAsTGCJRTMzD/AmW13hz5AO+8n0qGnHID1MA1Sv7E6Ah6rsrGKqpoCEy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=D79/joK5; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=WgyKHQxgZ+ecaOEthP7/qpFnWl/+qxOBNxU6iK/eZsw=; b=D79/joK5bniZrwHLm63qfXbbTn
	AfgkHvha/fIHTdAidjL88GYWsVw1zSw2sGCEutMeK1Ntq/xjmVYa61mYcPGJz5UF6kpBlbFJMaNwK
	CxXrETMzgabmuWz7QPZTlEUhPr1fUlRo2bmghkrXscTryESM4OipW3Vfb3veHf4CLYZdiGQr4Z56E
	lwqTksW7XExMLWA0I65Zryzmd2uXOghO24lLUSRl6sqmBaRrFgseu3xFtqLUA7uP0GSFzA9kDv/AJ
	X+Mjxd2A7mei2HzgXySDxGY2+Y7yIvvJvCB/j8ph6BVZ7z0GFrnhaX2jw2oOw0Zllw/g0oFwbEaf3
	yHz3L3hQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uzkLk-0000000AfrT-1Nh2;
	Fri, 19 Sep 2025 23:17:08 +0000
Date: Sat, 20 Sep 2025 00:17:08 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: NeilBrown <neil@brown.name>
Cc: Christian Brauner <brauner@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 4/6] VFS: unify old_mnt_idmap and new_mnt_idmap in
 renamedata
Message-ID: <20250919231708.GJ39973@ZenIV>
References: <20250906050015.3158851-1-neilb@ownmail.net>
 <20250906050015.3158851-5-neilb@ownmail.net>
 <20250915-prasseln-fachjargon-25f106c2da6b@brauner>
 <175832247637.1696783.9988129598384346049@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <175832247637.1696783.9988129598384346049@noble.neil.brown.name>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sat, Sep 20, 2025 at 08:54:36AM +1000, NeilBrown wrote:
> On Mon, 15 Sep 2025, Christian Brauner wrote:
> > On Sat, Sep 06, 2025 at 02:57:08PM +1000, NeilBrown wrote:
> > > From: NeilBrown <neil@brown.name>
> > > 
> > > A rename can only rename within a single mount.  Callers of vfs_rename()
> > > must and do ensure this is the case.
> > > 
> > > So there is no point in having two mnt_idmaps in renamedata as they are
> > > always the same.  Only one of them is passed to ->rename in any case.
> > > 
> > > This patch replaces both with a single "mnt_idmap" and changes all
> > > callers.
> > > 
> > > Reviewed-by: Jeff Layton <jlayton@kernel.org>
> > > Signed-off-by: NeilBrown <neil@brown.name>
> > > ---
> > 
> > Hah, thanks. I'm stealing this now.
> > 
> 
> I was hoping you would steal the whole series - v3 of it.
> 
>  https://lore.kernel.org/all/20250915021504.2632889-1-neilb@ownmail.net/
>  
> Is there anything preventing that going into vfs.all now?

1/6, perhaps?

