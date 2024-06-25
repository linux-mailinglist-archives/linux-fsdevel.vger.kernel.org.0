Return-Path: <linux-fsdevel+bounces-22424-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 955FE916FDB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 20:07:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FA97287D18
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 18:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3358417A92C;
	Tue, 25 Jun 2024 18:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="Vwv4/oEO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD5A179206;
	Tue, 25 Jun 2024 18:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719338780; cv=none; b=ZnzCcxdpeDblpOW3LqX/LH8nKlcnRYiSHg4jn5ssfr5feS7MH8oT/zRAO29vk7UI9nJa1Yqhjxckosb0kmZB7tn1cmdYrqP04U3ZCJN5Plz7sSCvzKNrxjwcQ6bYt7j9/9knGwYUxrnQc69UlftqGGy/fTerATAcfna4xKzUML8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719338780; c=relaxed/simple;
	bh=DyLxMMi4sw1+gTyy1GIMo7DSloLJMC0PD/Y0wAu8P0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OsaPg8W8UwBrcUHXAUdEyg+xXIpmU9eNZML6PH8In04PW7vWYGaE7rDRoOjkQMZ+KaiNth0JlWZXVyqYCMNb1RhiTbYwZlZ/+kNNsm15EIqbrk0pcY5UaPFpDzf59uqAyakFr7NGlndjRQ7mwlmCkNzZxaa3A7eqsh5adiIgabk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=Vwv4/oEO; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4W7t7B3wwXz9scR;
	Tue, 25 Jun 2024 20:06:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1719338774;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8cLTdC1JjfjD0aicUlYHFelZAUVGhDwe+oxU99OeiD0=;
	b=Vwv4/oEO17MkAKBJYU1LN9CPGtx8VtlGI2h5rBL5CmfOAVCQBQ3/XJ5k/+Tg/vTqPfQTY0
	YlgpfglA5syMu8H73dNRAtUhay22YPiBOACiSYfvajJcosbu9ANx4eglZKTv5EeEmlKr41
	9XWfTNYOS21Qdig+1SNBPZx2AJ0sEDp6DT6C+7M7hnf0+UH3KCxyaioT6tN+Qo+i000VeE
	rsslKK4S8F0fyoKFPotmbfwf7zeAg/EW8L6MhP8EVItdVa+kn3YHQ00V3sc8ct8gUfqt4B
	6jTznTHwuEOEhmNp0dQdpQ1XpFx3B4c7yUiwqeGjgGRTN6oTWVEgEBNx4ccbcA==
Date: Tue, 25 Jun 2024 18:06:09 +0000
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: david@fromorbit.com, chandan.babu@oracle.com, djwong@kernel.org,
	brauner@kernel.org, akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org, yang@os.amperecomputing.com,
	linux-mm@kvack.org, john.g.garry@oracle.com,
	linux-fsdevel@vger.kernel.org, hare@suse.de, p.raghav@samsung.com,
	mcgrof@kernel.org, gost.dev@samsung.com, cl@os.amperecomputing.com,
	linux-xfs@vger.kernel.org, hch@lst.de, Zi Yan <zi.yan@sent.com>
Subject: Re: [PATCH v8 02/10] filemap: allocate mapping_min_order folios in
 the page cache
Message-ID: <20240625180609.z4prikqk7eufl6bi@quentin>
References: <20240625114420.719014-1-kernel@pankajraghav.com>
 <20240625114420.719014-3-kernel@pankajraghav.com>
 <ZnrnozlE0EggQ_w3@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZnrnozlE0EggQ_w3@casper.infradead.org>
X-Rspamd-Queue-Id: 4W7t7B3wwXz9scR

On Tue, Jun 25, 2024 at 04:52:03PM +0100, Matthew Wilcox wrote:
> On Tue, Jun 25, 2024 at 11:44:12AM +0000, Pankaj Raghav (Samsung) wrote:
> > Co-developed-by: Luis Chamberlain <mcgrof@kernel.org>
> > Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> > Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> > Reviewed-by: Hannes Reinecke <hare@suse.de>
> > Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> 
> Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Thanks!
> 
> after fixing the nits below
> 
> > +/**
> > + * mapping_align_index() - Align index based on the min
> > + * folio order of the page cache.
> 
> + * mapping_align_index - Align index for this mapping.
> 
> > @@ -1165,7 +1186,7 @@ static inline vm_fault_t folio_lock_or_retry(struct folio *folio,
> >  void folio_wait_bit(struct folio *folio, int bit_nr);
> >  int folio_wait_bit_killable(struct folio *folio, int bit_nr);
> >  
> > -/* 
> > +/*
> >   * Wait for a folio to be unlocked.
> >   *
> >   * This must be called with the caller "holding" the folio,
> 
> Unnecessary whitespace change
> 

