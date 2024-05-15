Return-Path: <linux-fsdevel+bounces-19558-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B42F8C6EE5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 May 2024 01:10:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33A92282987
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 May 2024 23:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B9B042058;
	Wed, 15 May 2024 23:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ep7+mVF+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE7540861
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 May 2024 23:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715814596; cv=none; b=hXH6JmFAVfIPE2sFqNowP/LzjElcytbiujRexYbc8Mz59U0LRbxWFzF02Jr/a802GoTbElkvODOep8ijB2pjjy979RnrIiOulo+dRNQvopMleUhVJYWi+pPN/itAPSARuOHckSxZHZhWx34IxSfBjXAbf8qYnVqfWDfroLds/JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715814596; c=relaxed/simple;
	bh=7Xlm5yGRMgBQRwW27EUWqyelZjdD0SW+x2HN/QamkDc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jbWmfM3bRbuOenlH0B5kIch0tzPFgWlmMrBGPvY97w1YwXZyQkJuXd5drQcQAA3I3vduK8bNc/D/W1iz5kLrgL9i0OSeusyVDqS8Spq2tJiFLaRfgZWNgf8HbJa6MCTClJ3QQBtDPWDi5b/+3L8tCj4hTFvHru6axGKcjjV2aUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Ep7+mVF+; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=fYJdcYOCrtY52szVHROd32Y61zKELNIPF2cnxBmIFbE=; b=Ep7+mVF+gMRGYOm4rpCUmli3AI
	N9Bc6n6YMcNMDwxkLTHiL+zpIgUHFkTZbT1YRvE9BTkojh8IUXojUDYlxYYdKEYBcUuONiMa8uAcP
	AYKkG0g+FY5nQ29RqM/icWF8hE5T/NDYqvxKgTJlpXe6N3Cnp/JbtsDY3OXuzjdiN4eTUGK5JL9sj
	yPUD+Hl+oE60rQywJQ5Uqdfk6HS3LMraTIcGDAz65el2leLy/sLIch1Q5FqzWTL4cC2YDQYA8+d0n
	20/L07N7CPyO35bR+vI1uRSCqFm9uMf5emNFEwjx2oPamrueM68Gc+fgXodUq7vYha3rqXGL1kand
	aD6B3Jrw==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s7Nkr-0000000B32v-05gX;
	Wed, 15 May 2024 23:09:49 +0000
Date: Thu, 16 May 2024 00:09:48 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org,
	Hugh Dickins <hughd@google.com>, linux-mm@kvack.org,
	Mikulas Patocka <mpatocka@redhat.com>
Subject: Re: [PATCH] tmpfs: don't interrupt fallocate with EINTR
Message-ID: <ZkVAvM4J3OaXmbQj@casper.infradead.org>
References: <20240515221044.590-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240515221044.590-1-jack@suse.cz>

On Thu, May 16, 2024 at 12:10:44AM +0200, Jan Kara wrote:
> From: Mikulas Patocka <mpatocka@redhat.com>
> 
> I have a program that sets up a periodic timer with 10ms interval. When
> the program attempts to call fallocate(2) on tmpfs, it goes into an
> infinite loop. fallocate(2) takes longer than 10ms, so it gets
> interrupted by a signal and it returns EINTR. On EINTR, the fallocate
> call is restarted, going into the same loop again.
> 
> Let's change the signal_pending() check in shmem_fallocate() loop to
> fatal_signal_pending(). This solves the problem of shmem_fallocate()
> constantly restarting. Since most other filesystem's fallocate methods
> don't react to signals, it is unlikely userspace really relies on timely
> delivery of non-fatal signals while fallocate is running. Also the
> comment before the signal check:
> 
> /*
>  * Good, the fallocate(2) manpage permits EINTR: we may have
>  * been interrupted because we are using up too much memory.
>  */
> 
> indicates that the check was mainly added for OOM situations in which
> case the process will be sent a fatal signal so this change preserves
> the behavior in OOM situations.
> 
> [JK: Update changelog and comment based on upstream discussion]
> 
> Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
> Signed-off-by: Jan Kara <jack@suse.cz>

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>

