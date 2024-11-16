Return-Path: <linux-fsdevel+bounces-35009-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AD6D9CFCFB
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Nov 2024 08:42:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13FD3B27A8C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Nov 2024 07:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC796191F91;
	Sat, 16 Nov 2024 07:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="r0DbCl+v"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80E7C623;
	Sat, 16 Nov 2024 07:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731742933; cv=none; b=Jj26cW7UjcwMGsljHcZQ2F5KeaGYUmKhWMtfTEkYlEfrJVlxSbDJ08gSTtQDATAap4qFY0kUr9zqj8RcEIOj2C5h/C0M3/fEGv8PujPluuGjgUo/4pP5Zqr3M8rCsO4nL/Ux/uGF6/DYFIa4j/Zd8QYStRSbDXn5EXYadKaFHsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731742933; c=relaxed/simple;
	bh=87lEHpn2RySloHeYR2dGn92iefSw83+iMZ/NCGTM+U8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BQFr9SiaEmrymU6AHfoEMC4dB08hzMy1Pszpz0N+GBhZLaIr4KfmGSOHJ3Nvyc/SL8RkafeGbzrjMbSJmkILWHKss5Sij+S9BCZH+1K9gBj+kZQWQ0ykm0x7Jisr1/LcrlWBOBDW7FOTbBfSrdWJzqZZ1q81gKZEg4/o3fxy3R0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=r0DbCl+v; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Ww2nOhEgzo23sFG//zM4xEZH+oUXJE92LqQFZD/7M/o=; b=r0DbCl+vcOU2U9QZkvTb9zSXZ6
	lJwEMC0pUeQKPN5IHtpk9Uqw80BVTZsubNRGXhqfmpisevg9AG5ZoeZiW7YgMlNphss9oC3mEDQrs
	UtkP6rUMlnHyyZBLphCkiXi3l4CKx/U3fVCATRSo0Z8R4EB5pvzy9dgYVeszBBPUR29hNygxO4hCj
	bNzvVU1VRaH16S0pRV+RkYzU3RCHz7he5Wfz58V01HF1IDdlVyQB/c0TTRqshLRl6No9ZWWMFs8H9
	FlsE7Zk09Uww2dgjIciT873LkEw90Q/O2RbaDUco966MdFq+uHfW4nNs5Gj0KCaQYVBNlktIfRBlT
	1WB7fXlw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tCDRZ-0000000FhO1-1FE5;
	Sat, 16 Nov 2024 07:42:09 +0000
Date: Sat, 16 Nov 2024 07:42:09 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: brauner@kernel.org, jack@suse.cz, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: delay sysctl_nr_open check in expand_files()
Message-ID: <20241116074209.GC3387508@ZenIV>
References: <20241116064128.280870-1-mjguzik@gmail.com>
 <20241116073626.GB3387508@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241116073626.GB3387508@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sat, Nov 16, 2024 at 07:36:26AM +0000, Al Viro wrote:
> On Sat, Nov 16, 2024 at 07:41:28AM +0100, Mateusz Guzik wrote:
> > Suppose a thread sharing the table started a resize, while
> > sysctl_nr_open got lowered to a value which prohibits it. This is still
> > going to go through with and without the patch, which is fine.
> > 
> > Further suppose another thread shows up to do a matching expansion while
> > resize_in_progress == true. It is going to error out since it performs
> > the sysctl_nr_open check *before* finding out if there is an expansion
> > in progress. But the aformentioned thread is going to succeded, so the
> > error is spurious (and it would not happen if the thread showed up a
> > little bit later).
> > 
> > Checking the sysctl *after* we know there are no pending updates sorts
> > it out.
> 
> 	What for?  No, seriously - what's the point?  What could possibly
> observe an inconsistent situation?  How would that look like?

PS: I'm not saying I hate that patch; I just don't understand the point...

