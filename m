Return-Path: <linux-fsdevel+bounces-68077-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6A00C53977
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Nov 2025 18:10:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17037565E05
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Nov 2025 15:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D378343204;
	Wed, 12 Nov 2025 15:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MI7on72x"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D113396E5;
	Wed, 12 Nov 2025 15:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762962991; cv=none; b=jkOUVsfUvP8NR1AcDTZhE/5N/ZxJZVZoBInDe7cwFrUempSeISsRqymQhfy2t9xVvmwcW5A52knhngOyP3DzkVU+udWD/0USg9saHx4vBSpnAPPImRAgjBeIbT1AI+UN9B9Wl2QAJ5lo3a7tWENFaUkVu6PfpPVL0/2d/bfUbl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762962991; c=relaxed/simple;
	bh=uLDieheKOzLy4GDpWlq07ziKepek+0aifH9IiDXeUXE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KeLwRADB4okkxMOWQzKQZcD2kjjzjfHUgiI1NqY0M9Xsh2y2c5w/5kP0FOfGgsAcV7lQv4rVpunZKiJ7gzbQiZ7O5JL9iqAncv4x/h33v2GfPG9OXM1srhIK33y/aEOe2cS5tEiH23a+B+aFJTjfBBACAgRoLZj7cJneLfHwiZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=MI7on72x; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=unTZnhIKbo/kPjktubhrqmYbcE5u2DsI4RiHT1r059I=; b=MI7on72xw2kf/B0fnp/Td1CmSV
	cU9dbT/g+mZGa1UNpCIHupjk46WxBL+uRHMUEeWxwLRSkXz17Be9Hne9VcX6KQdww6djkwn9ioHUy
	aH17QCGTqVUWDLtpdaZdhL2ibY70RahsDhZ47uDJKzVCKDXDHtAIkciT+X+oZPq2xGTQKnUjSXAt9
	XcJ5YUbQ5SdLn0wYzI1hCu+1eqmst/T2SVkPRcnqOc56dc7Cpc1aK9cytD0hdTWtwVmewWHNt5GAY
	CqXjbe2HM5IMYV/N8UWZhtq+Jn4qR3w4265TBNhvAI2OMRzWsEptBnvVN11hXrCNrX7VeS64P/vMI
	ednyePxw==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJDCh-000000068nw-2KVV;
	Wed, 12 Nov 2025 15:56:15 +0000
Date: Wed, 12 Nov 2025 15:56:15 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: Christian Brauner <brauner@kernel.org>, djwong@kernel.org,
	ritesh.list@gmail.com, john.g.garry@oracle.com, tytso@mit.edu,
	dchinner@redhat.com, hch@lst.de, linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, jack@suse.cz,
	nilay@linux.ibm.com, martin.petersen@oracle.com,
	rostedt@goodmis.org, axboe@kernel.dk, linux-block@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2/8] mm: Add PG_atomic
Message-ID: <aRSuH82gM-8BzPCU@casper.infradead.org>
References: <cover.1762945505.git.ojaswin@linux.ibm.com>
 <5f0a7c62a3c787f2011ada10abe3826a94f99e17.1762945505.git.ojaswin@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f0a7c62a3c787f2011ada10abe3826a94f99e17.1762945505.git.ojaswin@linux.ibm.com>

On Wed, Nov 12, 2025 at 04:36:05PM +0530, Ojaswin Mujoo wrote:
> From: John Garry <john.g.garry@oracle.com>
> 
> Add page flag PG_atomic, meaning that a folio needs to be written back
> atomically. This will be used by for handling RWF_ATOMIC buffered IO
> in upcoming patches.

Page flags are a precious resource.  I'm not thrilled about allocating one
to this rather niche usecase.  Wouldn't this be more aptly a flag on the
address_space rather than the folio?  ie if we're doing this kind of write
to a file, aren't most/all of the writes to the file going to be atomic?

