Return-Path: <linux-fsdevel+bounces-68489-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E8C7CC5D523
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 14:23:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E36363464C9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 13:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52231314B95;
	Fri, 14 Nov 2025 13:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uhTAacUV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F405030F52B;
	Fri, 14 Nov 2025 13:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763126222; cv=none; b=W4Mkx9/DGkwCF+SWm3GFdWJjnmNywXMFrkGJc5vAbzr2PWfvENq4+Etu5B5zawMsWD9mbVb9Jl2ZfuQYIxVw96MNi3DWlMwtR159El0mmqUYV//y5lGgS7DxQPdQuR9HBbkx+jhBocIwCNTdKTTuuCSeeAaYwthKPGV7R76Ty9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763126222; c=relaxed/simple;
	bh=m25Ht5MJmYjNkEujCtZhivVNuoNdHi2llzCoTBXzsv0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=faUkkKPVboDcIKTbVRyNDVNV+gOsPDgykr0FSJfNDA5MzLQMFQj2kEqhBOzktZr8z43/4l9tuxeEOawYJh7Gn0EWxTs047MgRGs4jpV+sPeV3zg1VxqVMEDgvOT7bAu/ayCi4RAgg581gDbhYSdZ+Afh2QBqmMoXjIpklJHlLVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=uhTAacUV; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Vo+N5YbzZDjZeiNvAhfJhGp+deegDT8E/3cOAOwzUvY=; b=uhTAacUV/flhXWxNQV5FeR3HnC
	dbisfExygmslgLyDpvLG+2/Hlg/pmt0VQFR60ENfWSheMwZ71gSfJvn5cpAz3jQ4C8GbW22mGZnvr
	IAvWXV16IcxEqXlj9aGECgc6jWa+TYNslUF/UG5UZnNeVmX9uCBtHkF3/PhZqpKloo53DY7lQjfBs
	aJlrIOpHrSuxqQ5zFLrpzFxS0hDURfOE1mKKnlaxrFAzISnDVMx2YoDYjEeGrpZfA+xmHgA5z4Aqa
	ikMn5lzxyvLtVuWvtU3KSheAYA6RnH67j72rXcCqX5yw2ewTbxE7qcEs/APRhRTTgydkga2huH2E1
	f93tK/uw==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJtfX-00000009Mru-0lqh;
	Fri, 14 Nov 2025 13:16:51 +0000
Date: Fri, 14 Nov 2025 13:16:50 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Ritesh Harjani <ritesh.list@gmail.com>
Cc: Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	Christian Brauner <brauner@kernel.org>, djwong@kernel.org,
	john.g.garry@oracle.com, tytso@mit.edu, dchinner@redhat.com,
	hch@lst.de, linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, jack@suse.cz, nilay@linux.ibm.com,
	martin.petersen@oracle.com, rostedt@goodmis.org, axboe@kernel.dk,
	linux-block@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2/8] mm: Add PG_atomic
Message-ID: <aRcrwgxV6cBu2_RH@casper.infradead.org>
References: <cover.1762945505.git.ojaswin@linux.ibm.com>
 <5f0a7c62a3c787f2011ada10abe3826a94f99e17.1762945505.git.ojaswin@linux.ibm.com>
 <aRSuH82gM-8BzPCU@casper.infradead.org>
 <87ecq18azq.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ecq18azq.ritesh.list@gmail.com>

On Fri, Nov 14, 2025 at 10:30:09AM +0530, Ritesh Harjani wrote:
> Matthew Wilcox <willy@infradead.org> writes:
> 
> > On Wed, Nov 12, 2025 at 04:36:05PM +0530, Ojaswin Mujoo wrote:
> >> From: John Garry <john.g.garry@oracle.com>
> >> 
> >> Add page flag PG_atomic, meaning that a folio needs to be written back
> >> atomically. This will be used by for handling RWF_ATOMIC buffered IO
> >> in upcoming patches.
> >
> > Page flags are a precious resource.  I'm not thrilled about allocating one
> > to this rather niche usecase.  Wouldn't this be more aptly a flag on the
> > address_space rather than the folio?  ie if we're doing this kind of write
> > to a file, aren't most/all of the writes to the file going to be atomic?
> 
> As of today the atomic writes functionality works on the per-write
> basis (given it's a per-write characteristic). 
> 
> So, we can have two types of dirty folios sitting in the page cache of
> an inode. Ones which were done using atomic buffered I/O flag
> (RWF_ATOMIC) and the other ones which were non-atomic writes. Hence a
> need of a folio flag to distinguish between the two writes.

I know, but is this useful?  AFAIK, the files where Postgres wants to
use this functionality are the log files, and all writes to the log
files will want to use the atomic functionality.  What's the usecase
for "I want to mix atomic and non-atomic buffered writes to this file"?

