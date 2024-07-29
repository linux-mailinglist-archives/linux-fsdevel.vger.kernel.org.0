Return-Path: <linux-fsdevel+bounces-24504-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C629093FDA8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2024 20:44:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 520B9B20C90
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2024 18:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC865187350;
	Mon, 29 Jul 2024 18:44:36 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A5518732F
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Jul 2024 18:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722278676; cv=none; b=uKVgUTblRIaoUQ1Tdghy38PnUSFfTlgP5rFwUhoA+84bcwOCibPbE+QOm2xoJrUkpFDDMVZNVrnPno9b8SMJmsklFVlp0LkQTPKVcoshNH+yzVgB8wztaFwDW6hDVM/cqxFtD2RM63eQm7Tu2AMeek6L5rF6bzZFfHDfBWww/po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722278676; c=relaxed/simple;
	bh=ih5aFlsov6WTxCJHs7pewZAn4AIYJ+b3L00dJZq19DU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E2qXmGPCEayRhys9K68EP43C5oUq5oTc8YFLKaYX8EOF/gvgbOwniEUjiRTTxk2RoDb+PjTG25ACtAx2ig6OnUqpAEZi4J5Pn3Ba32RFHbGmYSzIwW9FMKhYyiqxW51BwEtGtmqxgl6wL1TOPo0WNrDtx96k1HghID0fH2j5+RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3681E68B05; Mon, 29 Jul 2024 20:44:30 +0200 (CEST)
Date: Mon, 29 Jul 2024 20:44:30 +0200
From: Christoph Hellwig <hch@lst.de>
To: Florian Weimer <fweimer@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, libc-alpha@sourceware.org,
	linux-fsdevel@vger.kernel.org,
	Trond Myklebust <trondmy@hammerspace.com>
Subject: Re: posix_fallocate behavior in glibc
Message-ID: <20240729184430.GA1010@lst.de>
References: <20240729160951.GA30183@lst.de> <87a5i0krml.fsf@oldenburg.str.redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a5i0krml.fsf@oldenburg.str.redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Jul 29, 2024 at 07:57:54PM +0200, Florian Weimer wrote:
> When does the kernel return EOPNOTSUPP these days?

In common code whenever the file system does not implement the
fallocate file operation, and various file systems can also
return it from inside the method if the feature is not actually
supported for the particular file system or file it is called on.

> Last time I looked at this I concluded that it does not make sense to
> push this write loop from glibc to the applications.  That's what would
> happen if we had a new version of posix_fallocate that didn't do those
> writes.  We also updated the manual:

That assumes that the loop is the right thing to do for file systems not
supporting fallocate.  That's is generally the wrong thing to do, and
spectacularly wrong for file systems that write out of place.

> As mentioned, if an application doesn't want fallback behavior, it can
> call fallocate directly.

The applications might not know about glibc/Linux implementation details
and expect posix_fallocate to either fail if can't be supported or
actually give the guarantees it is supposed to provide, which this
"fallback" doesn't actually do for the not entirely uncommon case of a 
file system that is writing out of place.


