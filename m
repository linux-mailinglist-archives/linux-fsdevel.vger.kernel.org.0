Return-Path: <linux-fsdevel+bounces-20311-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7C648D1529
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2024 09:16:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BAF61C223D1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2024 07:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EB3E17E907;
	Tue, 28 May 2024 07:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZeEaFy8H"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6489F762DE;
	Tue, 28 May 2024 07:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716880556; cv=none; b=i57M2O2MEZofpqss8r2EHSgzTAai5iUapzFVwf0L0ooKOwLBqjee7DO5YoBuBxGQbiJAQ7wwrrCySNmrEe8iglR/1bGMFNBCAoYOIGA2k/AFGGuy52+2oenlMcPzEnclr75NTRn2BnSq93QOs83LgJ+mcDLq7IdWcHit+jwkO3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716880556; c=relaxed/simple;
	bh=MLD9H2Czeuk8yzIl1o8T8vYs2svQSfY1C3nOel6q2Q8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O1oaacQnHXy1muV+NMQ2jJgVyjQv6pvvP3y6cSHGJ4forfo3vvlkNXntmh+kNlfLPk97LZaLyiwozZ4lxpwXWBx8RvxDVxXwkQiHnTd9RyhTO9Wypl88BaltBD/E3K7D3ycyPTMrhoUVgeiA5ew65msLZuoniZuTHKJqmE4VgXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ZeEaFy8H; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=c56LmE5EVD7j+b/usANfOmh+EBtk5ZiTU/F1vZzSWfI=; b=ZeEaFy8HdyEAO9fdeR/nxeNUJF
	ogdOH5XkKv1kGbNB3Eizu2B5Y8ZeDo9IUNuf4osGALsJAbbuijUbR2lsZOW+bRTPLv8oWDpGF0l22
	9pprWxzdsXSkGEgwz8qwjKMiFJYe/K6DGUZRlcX1L1EqDVbQEbMNXCxparCu32Z3Zw4RHX6keIX6z
	KSi61oaTs02/u0nuzM5DbLrSd4SQ0y4z7v0pOgz5MufyfIYLx+y116pX+FqgDbeD07DP9Hje3rKbh
	H7Y0acQIZ2yCIMAYquzTUBNbj55FryZzAjnCKshjlCyBl1HdJB0fCtAY6StAy+Q0a5GYsbAQzDIeL
	gbIk1acQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sBr3o-0000000HILb-231F;
	Tue, 28 May 2024 07:15:52 +0000
Date: Tue, 28 May 2024 00:15:52 -0700
From: "hch@infradead.org" <hch@infradead.org>
To: Christian Brauner <brauner@kernel.org>
Cc: "hch@infradead.org" <hch@infradead.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	"jack@suse.cz" <jack@suse.cz>,
	"chuck.lever@oracle.com" <chuck.lever@oracle.com>,
	"linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"alex.aring@gmail.com" <alex.aring@gmail.com>,
	"cyphar@cyphar.com" <cyphar@cyphar.com>,
	"viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
	"jlayton@kernel.org" <jlayton@kernel.org>,
	"amir73il@gmail.com" <amir73il@gmail.com>,
	"linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH RFC v2] fhandle: expose u64 mount id to
 name_to_handle_at(2)
Message-ID: <ZlWEqIGbVLbzypr1@infradead.org>
References: <20240523-exportfs-u64-mount-id-v2-1-f9f959f17eb1@cyphar.com>
 <ZlMADupKkN0ITgG5@infradead.org>
 <30137c868039a3ae17f4ae74d07383099bfa4db8.camel@hammerspace.com>
 <ZlRzNquWNalhYtux@infradead.org>
 <86065f6a4f3d2f3d78f39e7a276a2d6e25bfbc9d.camel@hammerspace.com>
 <ZlS0_DWzGk24GYZA@infradead.org>
 <20240528-fraglich-abmildern-cca211d1791c@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240528-fraglich-abmildern-cca211d1791c@brauner>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, May 28, 2024 at 09:12:33AM +0200, Christian Brauner wrote:
> It's also used by userspace for uniquely identifying cgroups via handles
> as cgroups and - even without open_by_handle_at() - to check whether a
> file is still valid.
> 
> And again a 64bit mount is is a simple way to race-free go to whatever
> superblock uuid you want. They cannot be recycled and are unique for the
> lifetime of the system.

And then break when you reboot.  Which you might not care about for
cgroups, but which is really bad for the concept of a file handle.

See one of my other replies for a proposed interface that is just as
easy to use for userspace, a little more complex in the kernel but
safe for it.  I'd much prefer that over using ay kind of "mount ID"
which doesn't fit into the file handle concept at all.

