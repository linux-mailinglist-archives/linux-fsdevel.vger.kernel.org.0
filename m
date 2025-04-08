Return-Path: <linux-fsdevel+bounces-46012-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CC055A813CF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Apr 2025 19:36:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 017487AD7CB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Apr 2025 17:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2441D23BD1C;
	Tue,  8 Apr 2025 17:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fg8mg9gE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E457236433
	for <linux-fsdevel@vger.kernel.org>; Tue,  8 Apr 2025 17:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744133805; cv=none; b=r0l1EceFluy20jZh8/jhf8ZcMVaibI/xEeBNnVp7CAV+OPMW2PPsql4bt54TutyK7E6jPFtAW2Vl27XWiZGOxi3QxfEEq4gfMCk6TYSQx4Zg5x8HEdeOCHpRq7pjvlt3nQeVmgHwpqStEynJhoJTdxIU8oef2UEKRbQDxSDC6sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744133805; c=relaxed/simple;
	bh=e1v03qhoKHe5NlE/St2NS6gkQC+osDJD17p9pFuJSoo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QKxk40+a0X9dx9VknnLKXidrgCnB/BUHpMDJivYZ5Fl65/eh2U8CTi6n6z0sdBmS8+JnD4psbGaKgvbwJgGSm0mJ4lw5HGiBxzzM3Ty7rGkWbmaqiJx4BO6SIwei0MXtKQROUBSzpauwesvh+aVYFhaadHMmmcyNhaX0pwwEf20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fg8mg9gE; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 8 Apr 2025 13:36:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1744133791;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YiTj+TYMMrnw1KVdV+/Tp51hNrHvFavfK7rU6JmuP/8=;
	b=fg8mg9gEmWQ8T8G3GlTPaHrVH0lKp9cL+mxLgUqeAPE+fL3Mqw+vqjiPGr5eYr3VIGYaJd
	awCFAWoL3gBEldkX/wLwKOR3bvK81dNYUTock/dTngzseMmnH96uiw72FZEaK6G+IIkvq7
	50gtJzIvPVGm9GA1ogMfbS9gZ8Mzo7Y=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Phillip Lougher <phillip@squashfs.org.uk>
Cc: Jan Kara <jack@suse.cz>, Andreas Gruenbacher <agruenba@redhat.com>, 
	Namjae Jeon <linkinjeon@kernel.org>, Sungjong Seo <sj1557.seo@samsung.com>, 
	OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, Carlos Maiolino <cem@kernel.org>, 
	"Darrick J. Wong" <djwong@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: Recent changes mean sb_min_blocksize() can now fail
Message-ID: <z3tovmo2cxgkvesiyrrvhnd3nk2qgogt6553hyxrmmodoiptdh@4hahwdkhx7da>
References: <86290c9b-ba40-4ebd-96c1-d3a258abe9d4@squashfs.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86290c9b-ba40-4ebd-96c1-d3a258abe9d4@squashfs.org.uk>
X-Migadu-Flow: FLOW_OUT

On Tue, Apr 08, 2025 at 06:33:53AM +0100, Phillip Lougher wrote:
> Hi,
> 
> A recent (post 6.14) change to the kernel means sb_min_blocksize() can now fail,
> and any filesystem which doesn't check the result may behave unexpectedly as a
> result.  This change has recently affected Squashfs, and checking the kernel code,
> a number of other filesystems including isofs, gfs2, exfat, fat and xfs do not
> check the result.  This is a courtesy email to warn others of this change.
> 
> The following emails give the relevant details.
> 
> https://lore.kernel.org/all/2a13ea1c-08df-4807-83d4-241831b7a2ec@squashfs.org.uk/
> https://lore.kernel.org/all/129d4f39-6922-44e9-8b1c-6455ee564dda@squashfs.org.uk/
> 
> Regards
> 
> Phillip

this would be a good time to use __must_check

