Return-Path: <linux-fsdevel+bounces-47692-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A06EAAA413D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Apr 2025 05:14:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 967677ABF01
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Apr 2025 03:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 229811C84B6;
	Wed, 30 Apr 2025 03:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hXoSF8zc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26F111187;
	Wed, 30 Apr 2025 03:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745982885; cv=none; b=mkgdRgFvPj84NwaGDBRZThythbEYPdl6gWA1htx9C2rkH9ztqqHo8x0PTKZ7Wy/RIPh71nN7K8nr28r6hWL55NIoHzogZvDYy5MQ5QaGCsHvp6fP62eCukUX7omffGPakEgemX4mzCfhl7zH2nTsD+BdkJanpo8WIV45vLt0TkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745982885; c=relaxed/simple;
	bh=enxdkZGI+MwwXsp2Rv91bxKEBaLcLDtqjFvp2qJR0zI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UdbUtG7ucOOSl3p7hEFcHKjWOcViETq86LASTVLTyYBjBHxI7SJAzNsCbMYVaJJ3gmoCOujtIOYHQhMLWmNLv1hrUGgSTzJE8CDMQmT6aHZcG2RxjVyLUsrpld2WVyIpQsOll9D3A+0ijZhu6uqGD4OwyiW2jqSodePXHAsqe7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=hXoSF8zc; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M096DRvsOm9f8Lc3UB4ItYvJL5fMP1d9sYVGr1HBCwY=; b=hXoSF8zcnH9GYizFTGGdOOolFe
	7+5xp0Df7aCSXEIqB5Mk3H/hNwU32qax+otczkN+lhuThp3pIHnKyXE1IYUeEGyazq/6my9EHkfyU
	uZkXzdB8FEjUoSkndLPtO7dUNqx9rrDlL9N/qtcaG+R35ZaFk4ChuWfVYRY7QY26bHhACoHaJER4M
	Cy7pzBrFIQfxrrPWtWm6hqC8BYfqIyC33iq18pep60+OUK+bJLcK73XBOhSjvyWEFHoZT042H3cOs
	5C+/eA7/PI08dPtZHlgwTMczrrL3vMypNPyJJIH8boI9M3gzHeuKvn5Oc6bdP+rtxM3Js7eAHKbLK
	UXFzTfhw==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9xu4-000000097QE-27h5;
	Wed, 30 Apr 2025 03:14:32 +0000
Date: Wed, 30 Apr 2025 04:14:32 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Zhang Yi <yi.zhang@huawei.com>
Cc: Liebes Wang <wanghaichi0403@gmail.com>, Jan Kara <jack@suse.cz>,
	ojaswin@linux.ibm.com, Theodore Ts'o <tytso@mit.edu>,
	linux-fsdevel@vger.kernel.org, syzkaller@googlegroups.com,
	Ext4 Developers List <linux-ext4@vger.kernel.org>
Subject: Re: kernel BUG in zero_user_segments
Message-ID: <aBGVmIin8YxRyFDp@casper.infradead.org>
References: <CADCV8spm=TtW_Lu6p-5q-jdHv1ryLcx45mNBEcYdELbHv_4TnQ@mail.gmail.com>
 <uxweupjmz7pzbj77cciiuxduxnbuk33mx75bimynzcjmq664zo@xqrdf6ouf5v6>
 <ac3a58f6-e686-488b-a9ee-fc041024e43d@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac3a58f6-e686-488b-a9ee-fc041024e43d@huawei.com>

On Tue, Apr 29, 2025 at 03:55:18PM +0800, Zhang Yi wrote:
> After debugging, I found that this problem is caused by punching a hole
> with an offset variable larger than max_end on a corrupted ext4 inode,
> whose i_size is larger than maxbyte. It will result in a negative length
> in the truncate_inode_partial_folio(), which will trigger this problem.

It seems to me like we're asking for trouble when we allow an inode with
an i_size larger than max_end to be instantiated.  There are probably
other places which assume it is smaller than max_end.  We should probably
decline to create the bad inode in the first place?


