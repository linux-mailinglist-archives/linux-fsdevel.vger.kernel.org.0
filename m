Return-Path: <linux-fsdevel+bounces-53811-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 868D8AF7AB7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jul 2025 17:16:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 862653AAC43
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jul 2025 15:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 581172EF9CF;
	Thu,  3 Jul 2025 15:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="GfKAXFWU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C09902EA149
	for <linux-fsdevel@vger.kernel.org>; Thu,  3 Jul 2025 15:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751555429; cv=none; b=A0pt8uwbZ74x4hTMeRYjSTvPRhnwrqc/XC1lfySr+HQDA6zWJAXsD7dNqlpCLJxKVxLamuc2FRIJ5h0Mf7tfXkF4jqUtzoSlxhJmWH/0Yi2/YJi9YL0X2wkfqLIsmEmxcDen4rzy59n+ppIUWJVQL3pE3rdb+4XmUZ0F1RSrtFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751555429; c=relaxed/simple;
	bh=Wc2GLdcXKW6hEB01Xcr2iieOtXdrOI7+56JHFUtEH4I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rKfOtptDgdXnjOSfLBWiCWPKvsyNJ5WWBEpkm9mb9z0SQoO+S3E11TUGytSnJ/yqrh0g14vUdn/pree0X2E/bQpwzsN1ssc4tLqb62bRlg6oWTLdonA8zcZme3dOrhIM0pOfeSxh0IQWysNBH+W5zATya0f+EF0HpbIYzSt/Dzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=GfKAXFWU; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=KHO5F2gS4NsM2cj8DILH9cfv+lGEr4oHFKOA0q0LhyA=; b=GfKAXFWUwfWAQUjYucF9scqsdu
	G+xWKXkIPqeFH+7/0OxHTVOlNTMMLM2XKeLUyfTsiL65l2lM83uFOmjLopIQgTyJK/SS2yO5icf2G
	bU+Us3ArfoPjoPi0gvDDWxuN2tkyBTi00C83pElAyUckh7F9BGnSpE7Yui5Q8DvHqs4RVfCzKhUBp
	pMd/mWNunPR9RJfbxNwng0gSEuajT9djtGepcAUSWqHlLWSOTctTF+niIj2YVYhxAiZtOagnX1TDo
	DV9j1DcrddKeRyJp0+b9c+ElqyYygrbWHkrag2dOhjnkQRqiWHrnky4O7mkvIKSo1BqsDRwiFP/uS
	T9+mV9Sw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uXLZw-00000003xSo-1qp2;
	Thu, 03 Jul 2025 15:10:24 +0000
Date: Thu, 3 Jul 2025 16:10:24 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: Re: (subset) [PATCH 01/11] zynqmp: don't bother with
 debugfs_file_{get,put}() in proxied fops
Message-ID: <20250703151024.GL1880847@ZenIV>
References: <20250702211305.GE1880847@ZenIV>
 <20250702211408.GA3406663@ZenIV>
 <175149835231.467027.7368105747282893229.b4-ty@kernel.dk>
 <20250703002329.GF1880847@ZenIV>
 <2025070316-curled-villain-c282@gregkh>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025070316-curled-villain-c282@gregkh>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, Jul 03, 2025 at 01:37:58PM +0200, Greg Kroah-Hartman wrote:
> On Thu, Jul 03, 2025 at 01:23:29AM +0100, Al Viro wrote:
> > On Wed, Jul 02, 2025 at 05:19:12PM -0600, Jens Axboe wrote:
> > > 
> > > On Wed, 02 Jul 2025 22:14:08 +0100, Al Viro wrote:
> > > > When debugfs file has been created by debugfs_create_file_unsafe(),
> > > > we do need the file_operations methods to use debugfs_file_{get,put}()
> > > > to prevent concurrent removal; for files created by debugfs_create_file()
> > > > that is done in the wrappers that call underlying methods, so there's
> > > > no point whatsoever duplicating that in the underlying methods themselves.
> > > > 
> > > > 
> > > > [...]
> > > 
> > > Applied, thanks!
> > > 
> > > [10/11] blk-mq-debugfs: use debugfs_get_aux()
       ^^^^^
> > >         commit: c25885fc939f29200cccb58ffdb920a91ec62647
> > 
> > Umm...  That sucker depends upon the previous commit - you'll
> > need to cast debugfs_get_aux() result to void * without that...
> 
> Wait, what "previous commit" this is patch 01/11 of the series?

Jens replied to 01/11 saying that he'd grabbed 10/11, unfortunately
without 09/11...

