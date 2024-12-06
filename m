Return-Path: <linux-fsdevel+bounces-36603-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C05459E651B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2024 04:39:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4B6E168783
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2024 03:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D736190688;
	Fri,  6 Dec 2024 03:39:34 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E839913DDDF;
	Fri,  6 Dec 2024 03:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733456374; cv=none; b=PdhoQr2OqRzG9dpF0IIUg25qF85kvM10GoIyXtmiVQiq5B56Gd4WT1VeWr+5nmA0m6FPJcH7XW8D8X5bwwSt9gr7LuUPN25bXWI86vOEeqVylNHKcVA1PQdtHsjSqNz8Fa12eMDoV9Vzs4WFiwb6pNusS7GnTow8yn2VzbzpYJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733456374; c=relaxed/simple;
	bh=+wCFR+BFpuzUhSQJY0ZRBgjC4nfhUcUpo+8+Fncika4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b7Oc3s5uS440FlREVGkSReNKZlnYncphpI7A+xqYleUuZ1tjvaK9dIWhpF33zeQ/BS6pEqcU8SfKwtI3B+vAlLDbHeRUATmR/7o1SS2oD4Ub65ioG8b9aqOqPuSUyGT1fJxCqEEiCLoqJTSKfb8SGEfy8QCSFZ6WqEAGjodDtQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Y4H3r6txDz1V5LG;
	Fri,  6 Dec 2024 11:36:24 +0800 (CST)
Received: from dggpemf500017.china.huawei.com (unknown [7.185.36.126])
	by mail.maildlp.com (Postfix) with ESMTPS id AC905140118;
	Fri,  6 Dec 2024 11:39:23 +0800 (CST)
Received: from localhost (10.175.112.188) by dggpemf500017.china.huawei.com
 (7.185.36.126) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 6 Dec
 2024 11:39:23 +0800
Date: Fri, 6 Dec 2024 11:36:53 +0800
From: Long Li <leo.lilong@huawei.com>
To: Brian Foster <bfoster@redhat.com>
CC: Dave Chinner <david@fromorbit.com>, <brauner@kernel.org>,
	<djwong@kernel.org>, <cem@kernel.org>, <linux-xfs@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>, <yi.zhang@huawei.com>, <houtao1@huawei.com>,
	<yangerkun@huawei.com>
Subject: Re: [PATCH v5 1/2] iomap: fix zero padding data issue in concurrent
 append writes
Message-ID: <Z1JxVRp4hHC5tb6j@localhost.localdomain>
References: <20241127063503.2200005-1-leo.lilong@huawei.com>
 <Z0sVkSXzxUDReow7@localhost.localdomain>
 <Z03RlpfdJgsJ_glO@bfoster>
 <Z05oJqT7983ifKqv@dread.disaster.area>
 <Z08bsQ07cilOsUKi@bfoster>
 <Z1AbeD8QVtITsvic@localhost.localdomain>
 <Z1BFbVhqjnCt-Gk5@bfoster>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <Z1BFbVhqjnCt-Gk5@bfoster>
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemf500017.china.huawei.com (7.185.36.126)

On Wed, Dec 04, 2024 at 07:05:01AM -0500, Brian Foster wrote:
> On Wed, Dec 04, 2024 at 05:06:00PM +0800, Long Li wrote:
> > On Tue, Dec 03, 2024 at 09:54:41AM -0500, Brian Foster wrote:
> > > Not sure I see how this is a serialization dependency given that
> > > writeback completion also samples i_size. But no matter, it seems a
> > > reasonable implementation to me to make the submission path consistent
> > > in handling eof.
> > > 
> > > I wonder if this could just use end_pos returned from
> > > iomap_writepage_handle_eof()?
> > > 
> > > Brian
> > > 
> > 
> > It seems reasonable to me, but end_pos is block-size granular. We need
> > to pass in a more precise byte-granular end. 
> 
> Well Ok, but _handle_eof() doesn't actually use the value itself so from
> that standpoint I see no reason it couldn't at least return the
> unaligned end pos. From there, it looks like we do still want the
> rounded up value for the various ifs state management calls.
> 
> I can see a couple ways of doing that.. one is just align the value in
> the caller and use the two variants appropriately. Since the ifs_
> helpers all seem to be in byte units, another option could be to
> sanitize the helpers to the appropriate start/end rounding internally.
> 
> Either of those probably warrant a separate prep patch or two rather
> than being squashed in with the i_size fix, but otherwise I'm not seeing
> much of a roadblock here. Am I missing something?
> 
> Brian
> 

Agreed. Looks like there are no other roadblocks. I'll update in the next
version. 

Best Regards
Long Li

