Return-Path: <linux-fsdevel+bounces-23320-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D05592A93C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jul 2024 20:49:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25DF81F2142B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jul 2024 18:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9985D14AD29;
	Mon,  8 Jul 2024 18:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KhUBMvQl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B0D14884B
	for <linux-fsdevel@vger.kernel.org>; Mon,  8 Jul 2024 18:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720464539; cv=none; b=GWcX/OoBAJ8ZmPz5+WtVdg2O7xYPP8/7l1+4wzaFs1C4O6qZ83OOfHbC0g2QOO+0w59wH/A2YcFnpaDadYUC3yfW2BaMqJvfSG35ZsSWwEVwdUlED0aws3IEnP421WNNaT455I1IUmLAaVog1LwR+UKe8kDyAJDAYQK+WNhFRjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720464539; c=relaxed/simple;
	bh=OXJM3L/yW/nwyt1EGcUE0qDAnAXYEemw0jbNG4hD2A0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nQQYzAx5Z6rmW2eaU/3ZJJdsnvSl4KmjL27VQZP7fKJcIPvueZX7dyKvFd2oygBEhECIpWsW3zTcsbqjKUdCh1ElcKV0lOiG4loLzFZVHVZ3zeLuMoMQV9pME9yRPX6tQYyrPKMW3RKNeXLIQs46Iey3hKdRafTNbSY9L8LTOcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KhUBMvQl; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: lihongbo22@huawei.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1720464535;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Jk1Nf3tVbWZTRKv08ukdluHV8zBxAJ5mugLT4DvVlmk=;
	b=KhUBMvQl/7mLhqP0OvQTWiwjO47SzUT3pr9lWH8vJloTyxYMWn2fv8Rd2Iad7lauld0Bqf
	c5fDr5K9mWWbYXd2JBE/b+cRJgxAXTSLTyJ/YjxMA8IroalYTYls4DW7Ez4nb7dWFdJUeS
	yQPEOGmXPW+oN1/sKM6a3G1V5GQR9ME=
X-Envelope-To: linux-bcachefs@vger.kernel.org
X-Envelope-To: linux-fsdevel@vger.kernel.org
Date: Mon, 8 Jul 2024 14:48:50 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Hongbo Li <lihongbo22@huawei.com>
Cc: linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH] bcachefs: make directory i_size meaningful
Message-ID: <yjl6lvsbzokqtvi5el5mqzpfwuz5vqhgsrnqqtg7gwubwctldt@sfz6hrhhcgd3>
References: <20240705072006.2768861-1-lihongbo22@huawei.com>
 <2sjq2njetbhhqo2zuufrjuarzvo4jl2pid52idwdz45h7li4bm@throc6jwnckk>
 <618bcb90-f735-4475-ac0f-91732e9591d8@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <618bcb90-f735-4475-ac0f-91732e9591d8@huawei.com>
X-Migadu-Flow: FLOW_OUT

On Mon, Jul 08, 2024 at 09:35:25AM GMT, Hongbo Li wrote:
> 
> 
> On 2024/7/6 12:11, Kent Overstreet wrote:
> > On Fri, Jul 05, 2024 at 03:20:06PM GMT, Hongbo Li wrote:
> > > The isize of directory is 0 in bcachefs if the directory is empty.
> > > With more child dirents created, its size ought to change. Many
> > > other filesystems changed as that (ie. xfs and btrfs). And many of
> > > them changed as the size of child dirent name. Although the directory
> > > size may not seem to convey much, we can still give it some meaning.
> > > 
> > > The formula of dentry size as follow:
> > >      occupied_size = 40 + ALIGN(9 + namelen, 8)
> > > 
> > > Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
> > 
> > I like it.
> > 
> > It's going to need more work though; it'll be a new on disk format
> > version, and fsck needs to know how to sum up dirents and check i_size -
> > which won't be bad, since we already have to sum up child directories
> > for i_nlink.
> 
> Yeah, more effort is needed. This is just an RFC, and I will refine this
> patch later.

Sounds good. This is also one one we'll want to CC to fsdevel and see if
any other filesystems have interesting to say on i_size for directories.

