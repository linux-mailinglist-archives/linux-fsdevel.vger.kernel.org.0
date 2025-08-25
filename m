Return-Path: <linux-fsdevel+bounces-59126-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CFBC0B34A92
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 20:45:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 895AB5E2100
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 18:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F2EE248869;
	Mon, 25 Aug 2025 18:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Z/BJIZ1I"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D65023BCEF;
	Mon, 25 Aug 2025 18:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756147527; cv=none; b=YSat/k9+syANQ2jT/qVU6MShF1VCGFRWQkR4foNKm8qGTlTX4B9M1gA664QLHU10XcLco6vasuU9f87PhU+4GVp74nnJVn+w0LFV2zEHA+qpBt/xsu5ALWjC3E3Waqf0sQ+UGn7W5tkMPrGm428vahMqKOSHG6lOvkWzBqCgD/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756147527; c=relaxed/simple;
	bh=smi+KmAxojiQhsj6Muma/DlYlWlX97XxL12GLasWTj8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dcCwBSbsBXipEDH40nypdAFUPGrmttc/3L7PcwSfjxx8bJMXBeXj460vAjzk2jZQ9LLkXe3Snm1TFnaXO0NUEAicGIKfKmsGgLfz3522SGjGfNZB+HBz7ulm/6uomHBmDP9Kb3QZAIZlBwm4mlDtVyFNhdtoB0KlvxYu8YN5uMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Z/BJIZ1I; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=jcGbJRKn457P/rPO1gB7SWr02nQvJ1OsIbhHBpeMdqg=; b=Z/BJIZ1I0NTgESi4GXRCKzX2lh
	QDcmdcZxfsRzEK6xF2oJXHrXPVg9XGhyrWRRxJY2PM+Kn1xyyafarRDtsrR3yrFfI8pGCoIPgRngJ
	sJjt0PJ+qmvwUgb/Lpua6Wphg5Y9VRKtOCu6gy1Gaw+RvzSneUECj4gma/khgjGOQLjHitEh/TFO7
	DuUvyEZy5kk0i4q/A3t32DuCFk6syusf0rDiu19aiJfu1ocx9g7cRb8i3XNLnW7mHBvrASYwuI9vv
	9ftJRCffm1PEgNiHHIYYyWI38K4v9hM9gpkzDjTCuPWCWr67ZLSMzuyJSN25nyGZkGB8gp0kmagll
	82EUSUcw==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqcBv-00000002XL4-2rbx;
	Mon, 25 Aug 2025 18:45:15 +0000
Date: Mon, 25 Aug 2025 19:45:15 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Alexander Aring <alex.aring@gmail.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Aleksa Sarai <cyphar@cyphar.com>, Jan Kara <jack@suse.cz>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [PATCH] uapi/fcntl: conditionally define AT_RENAME* macros
Message-ID: <aKyvO2bvPCZEzuBd@casper.infradead.org>
References: <20250824221055.86110-1-rdunlap@infradead.org>
 <aKuedOXEIapocQ8l@casper.infradead.org>
 <9b2c8fe2-cf17-445b-abd7-a1ed44812a73@infradead.org>
 <aKxfGix_o4glz8-Z@casper.infradead.org>
 <0c755ddc-9ed1-462e-a9f1-16762ebe0a19@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c755ddc-9ed1-462e-a9f1-16762ebe0a19@infradead.org>

On Mon, Aug 25, 2025 at 10:52:31AM -0700, Randy Dunlap wrote:
> $ grep -r AT_RENAME_NOREPLACE /usr/include
> /usr/include/stdio.h:# define AT_RENAME_NOREPLACE RENAME_NOREPLACE
> /usr/include/linux/fcntl.h:#define AT_RENAME_NOREPLACE	0x0001
> 
> I have libc 2.42-1.1 (openSUSE).

I wonder if we can fix it by changing include/uapi/linux/fcntl.h
from being an explicit 0x0001 to RENAME_NOREPLACE?  There's probably
a horrendous include problem between linux/fcntl.h and linux/fs.h
though?

