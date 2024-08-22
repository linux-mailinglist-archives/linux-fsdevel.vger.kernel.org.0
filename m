Return-Path: <linux-fsdevel+bounces-26579-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1FB695A8A0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 02:15:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 471D5282739
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 00:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9211D4C74;
	Thu, 22 Aug 2024 00:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="VYFkP06w"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72AB515A8;
	Thu, 22 Aug 2024 00:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724285741; cv=none; b=pq2hZz4aTOikUJxKeZmF5Re1YWlt22LsMGHKtu+UW7KRhngIBKBsmybh0NE9UJmsKScZLGXNe7oua/36AAFmPS3h9CqAuyWRRevQFvrmLHOlrr0Pm5wQ6Txy30HDXHD74cf0Mao9XBJD1v3Q0/yz9y3pPHpAwI4AfECVnK+lYr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724285741; c=relaxed/simple;
	bh=OdM38FkNTcBPHl7pFSwql2F4vrUHZrxewqYWJilfLzI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iX1MXYbQt0Uaah2cqZF0VhrVjNDEos30+7ZrCX6Yt4e52FFm7MPHFZktgMP7Zn488Yvyu7n0CNflLyOwEnyPPv6kOHyYzfjGUoVzCYF0gC78sYuFxBsP7P4wett90lV6gFuvpNCGejb9eUgjFoDbKGsbiV+croekbvXjjJDNLAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=VYFkP06w; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=4a0JEl55wyrWU4+T/Db8ieIP2AEXOZlCwxjkTfa2lPI=; b=VYFkP06wHX6YzgSWCOvmB/AEac
	+4MDovWSQi/7RqC3QRLEcV26+KM4ZcMtZdiNS1Acc8VPIJkH92dI61BkiGhaXSHZ63hGR0CIzPSNr
	g7Jo2zdCdORw2pO2poqc//4LbofkNPZOzJJ9lu/rm1fveMOniacJNv21e3lsWezB0FElHikfh2GdO
	c9KcbbHnIkpg2sKLXeeFM1barlPKNICecvYKoCxj0MtD9GvWPaKCP6W/Hxzldit+eccois7WQlzky
	xL7Z+LiJZo2XvIJo5+pyxo7zs8k4uOC1mHXGDZM4IWFV29FVjCA5nLZFA2LFMIo8s+DjythTyGG8g
	YmJe6w3A==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sgvUG-00000003w2k-1Yec;
	Thu, 22 Aug 2024 00:15:36 +0000
Date: Thu, 22 Aug 2024 01:15:36 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Dan Carpenter <dan.carpenter@linaro.org>, oe-kbuild@lists.linux.dev,
	lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, Shuah Khan <shuah@kernel.org>
Subject: Re: [viro-vfs:work.fdtable 13/13] kernel/fork.c:3242 unshare_fd()
 warn: passing a valid pointer to 'PTR_ERR'
Message-ID: <20240822001536.GL504335@ZenIV>
References: <020d5bd0-2fae-481f-bc82-88e71de1137c@stanley.mountain>
 <20240813181600.GK13701@ZenIV>
 <20240814010321.GL13701@ZenIV>
 <7bf93dfd-1536-438c-9ffd-f7dcfce0b3f5@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7bf93dfd-1536-438c-9ffd-f7dcfce0b3f5@linuxfoundation.org>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Aug 21, 2024 at 12:38:48AM -0600, Shuah Khan wrote:
> On 8/13/24 19:03, Al Viro wrote:
> > On Tue, Aug 13, 2024 at 07:16:00PM +0100, Al Viro wrote:
> > > On Tue, Aug 13, 2024 at 11:00:04AM +0300, Dan Carpenter wrote:
> > > > 3f4b0acefd818e Al Viro           2024-08-06  3240  		if (IS_ERR(*new_fdp)) {
> > > > 3f4b0acefd818e Al Viro           2024-08-06  3241  			*new_fdp = NULL;
> > > > 3f4b0acefd818e Al Viro           2024-08-06 @3242  			return PTR_ERR(new_fdp);
> > > >                                                                                 ^^^^^^^^^^^^^^^^
> > > > 	err = PTR_ERR(*new_fdp);
> > > > 	*new_fdp = NULL;
> > > > 	return err;
> > > 
> > > Argh...  Obvious braino, but what it shows is that failures of that
> > > thing are not covered by anything in e.g. LTP.  Or in-kernel
> > > self-tests, for that matter...
> > 
> > FWIW, this does exercise that codepath, but I would really like to
> > have kselftest folks to comment on the damn thing - I'm pretty sure
> > that it's _not_ a good style for those.
> 
> Looks good to me. Would you be able to send a patch for this new test?

Umm...  Send as in "mail somewhere specific", or as "push into vfs.git",
or...?

