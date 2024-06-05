Return-Path: <linux-fsdevel+bounces-21013-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8206E8FC2C8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jun 2024 06:40:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3246B1F234B0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jun 2024 04:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 368B213174B;
	Wed,  5 Jun 2024 04:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="2HSz4Kn6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 439B763B;
	Wed,  5 Jun 2024 04:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717562416; cv=none; b=d8F2q1f69dCy/rgds/XWQsyKM320c7Xe3+TY7H275a3B8oZ4YAqjtqUO7cu37CQiIMmi3wxgrDJGzs+Wn2/2EP8Rox1j1MkITT9n5GdlAlu/0y5bQOJMA4PWiFOHZcHeHw3tRnxa30i8wCzkEgbrCqzTtHOu7c/5Bpje3cuOlSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717562416; c=relaxed/simple;
	bh=AVUfjlLwVnQ0CECSvBpFLm+c0d5jJ6Iru1bWLKrFg4E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u924SAiA1jN7gIvKdDu18oXtoXZJBRDZw7AjB/4lszOCD1URM0//tenINKjrYToMxqZEXKDbcbtRr8MFibZrdq1vhrMyVGxWfQloKRbaYcpfRr/1pwVnaXsGTIUXl2zU/Y2UDkvL7YzeH2ufrzTYI6A6880tPVcV753Dz9dFIp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=2HSz4Kn6; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=4+RhDLjh6yEreRQNES552FEFK/q+qcWReXS2Og5cmdA=; b=2HSz4Kn6w95poRktsjf0iZPfEn
	CdCppI66zSzHxZXsEGyMpM+zcGm/l9JamH3E0s3NYNbp2gYcFdg0QVd35oPEyc8RfMRpPj0kUTDCj
	SNQtQ6goo9D3UzQ5L6jiZ+hlpMoMGP+I3AXvbHAAYlkcCfBiRhhn7TP8M3G3gGkTM9U9aIsAtyXQ4
	dFbXOkjtGL21+dg27DCiLz0VIQ2gCuyggsWZoAPqedmcoELE8fag8Iol3AwnVEoc4niyOjQlqtXL+
	PAvwagMsjfPiTzMEHedP2dPgCQmn8MmK4HKyh70wsdVzIRI63knR7P/lL/5ZNxVsl3kzFeX5a4t+c
	iuVElBbA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEiRZ-00000004cSL-0Mqe;
	Wed, 05 Jun 2024 04:40:13 +0000
Date: Tue, 4 Jun 2024 21:40:13 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: "Darrick J. Wong" <djwong@kernel.org>, da.gomez@samsung.com
Cc: fstests@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	willy@infradead.org, p.raghav@samsung.com, hare@suse.de,
	john.g.garry@oracle.com, linux-xfs@vger.kernel.org,
	patches@lists.linux.dev
Subject: Re: [RFC] fstests: add mmap page boundary tests
Message-ID: <Zl_sLbUlHu_RiMPY@bombadil.infradead.org>
References: <20240415081054.1782715-1-mcgrof@kernel.org>
 <20240415155825.GC11948@frogsfrogsfrogs>
 <ZlZYG7-9-3NR4tdv@bombadil.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZlZYG7-9-3NR4tdv@bombadil.infradead.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>

On Tue, May 28, 2024 at 03:18:03PM -0700, Luis Chamberlain wrote:
> On Mon, Apr 15, 2024 at 08:58:25AM -0700, Darrick J. Wong wrote:
> > On Mon, Apr 15, 2024 at 01:10:54AM -0700, Luis Chamberlain wrote:
> > > +	#    This is not true for tmpfs.
> > 
> > Er... is this file size change a bug?
> 
> There is no filesize bug, the comment about tmpfs always ensuring seeing
> the actual data since, well, there its kind of write-through. Since we
> share the same filemap_map_pages() I'd expect the rest should behave the
> same with tmpfs, but since I didn't test that the test skips it for now.
> 
> We'll test it, with all the patch "filemap: cap PTE range to be             
> created to allowed zero fill in folio_map_range()" on tmpfs, and see if
> we can just enable this test there too. Might as well as we're driving
> by and sprinkling large folios there too.

Turns out our patch "filemap: cap PTE range to be created to allowed
zero fill in folio_map_range()" ends up fixing this on tmpfs for huge
pages. So consider this now tested on tmpfs as well, I'll adjust the
test for that.

  Luis

