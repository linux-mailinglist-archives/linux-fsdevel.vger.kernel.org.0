Return-Path: <linux-fsdevel+bounces-13159-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6958686C010
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Feb 2024 06:02:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B64A62881DB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Feb 2024 05:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82B0B39ADF;
	Thu, 29 Feb 2024 05:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TFCgcOxg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8895638388;
	Thu, 29 Feb 2024 05:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709182951; cv=none; b=DT5jcXMH3pvROfFyzS/sxikbTtyp8EdRiU85whZ4+BqxPcrB264v1nvOJW1CYBmqN0oUbe1YjcpKTFUH955qzEd/dvrxF6UhjHJCXwp33aImag8IjmelpkOYk0wj9fDeRWfq8xFdPgvF2DzpYBZ25cK7kaQK4q+AfAC7vveSfz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709182951; c=relaxed/simple;
	bh=+pIA+DXty69iFSp98prrZrA4u9BZqD+RQvuKbGVZ4y4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qpSyDfYYJnqaSQWUmof5Pvj3qXzXO5o4l/K0JiASdmtFLLIhoVutFey0IcycaA5qEuo1weWngITWyh8MhaKQbLfHcxnu/0IJr9xY81Ze+H8YVPBRNpCjWfbunEa7wJOTocUVdfXGdixEomWeA6PLNeb0fOJeYrKB/HsXNf5JuvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=TFCgcOxg; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=HRJATlj7p3FpdJlJsD3VREDUaHS6lFKhVmn7mzyRVro=; b=TFCgcOxgno2VhCfFarXxUq9fJy
	0ETkhQtvQmZHD9J/8sAJ0me39dN4gvfla1OJi4xuHbItrMqfDwoRgVVPdg7fL1JNXXBneY11QPjt5
	UxgAkAZPEmDE10uMHrzBSfGxGhEL9gjmrVIt+CQDv9Z35OiQ30GB15pUoOgwWWzPRRYiU9JPEi+lE
	/WHDt1SMo0JeMhrIe6bOVoeF31z2JDIQdfb/L4TRVD+0P7ZTmI4Uj1sFz4dPlftS2MllBapBrRBNW
	EEOERRFWTLHgtIRQ1rR9XZCE3p7+CMKOcaXNJ+HFuo4HOjJAGR1e9OoXseZ+GUyC9udU/wLwcnGP9
	RdfSMkeg==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rfYYd-000000079kl-1LdX;
	Thu, 29 Feb 2024 05:02:11 +0000
Date: Thu, 29 Feb 2024 05:02:11 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Chandan Babu R <chandanbabu@kernel.org>
Cc: akiyks@gmail.com, cmaiolino@redhat.com, corbet@lwn.net,
	dan.carpenter@linaro.org, dan.j.williams@intel.com,
	dchinner@redhat.com, djwong@kernel.org, hch@lst.de,
	hughd@google.com, kch@nvidia.com, kent.overstreet@linux.dev,
	leo.lilong@huawei.com, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org, longman@redhat.com, mchehab@kernel.org,
	peterz@infradead.org, ruansy.fnst@fujitsu.com, sfr@canb.auug.org.au,
	sshegde@linux.ibm.com
Subject: Re: [ANNOUNCE] xfs-linux: for-next updated to 601f8bc2440a
Message-ID: <ZeAP01ULpmV0u9Ba@casper.infradead.org>
References: <87r0gvna3j.fsf@debian-BULLSEYE-live-builder-AMD64>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r0gvna3j.fsf@debian-BULLSEYE-live-builder-AMD64>

On Thu, Feb 29, 2024 at 10:23:45AM +0530, Chandan Babu R wrote:
> Hi folks,
> 
> The for-next branch of the xfs-linux repository at:
> 
> 	https://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git
> 
> has just been updated.
> 
> Patches often get missed, so please check if your outstanding patches
> were in this update. If they have not been in this update, please
> resubmit them to linux-xfs@vger.kernel.org so they can be picked up in
> the next update.
> 
> The new head of the for-next branch is commit:
> 
> 601f8bc2440a Merge tag 'xfs-6.8-fixes-4' into xfs-for-next

Some kind of merge snafu?  It looks like you merged all of 6.8-rc6 into
for-next:

https://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git/commit/?h=for-next

