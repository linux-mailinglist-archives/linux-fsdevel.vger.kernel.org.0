Return-Path: <linux-fsdevel+bounces-41746-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD952A36638
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Feb 2025 20:35:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2344B3AD362
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Feb 2025 19:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C049219F495;
	Fri, 14 Feb 2025 19:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JYbZIN4o"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C178196C7C;
	Fri, 14 Feb 2025 19:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739561693; cv=none; b=jtGknAjTmgaHHCOttOMY4mj5ckcISjgubZmUrI63ZoWivKv/EZnnC3lmwrFdl7UIe3FNBDy5VFdClUiCBz2USf/4JE+va++sR0In8F/3ZCcBPxvoobR4POhjOaL1U44qyTxOIQmnzcrb5DcENBgnKstVITeMwo19R6U2Z2gYvRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739561693; c=relaxed/simple;
	bh=z57VDoWOMiQtEOMMlGqG3yTeh3vaogOC9I/xY+WZOuI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b4QCpx3JetFC1kgCxfHNYYC9NrNbQtFRuz+8UvaHkvrEKznK9clvrT4NDpMNm0NP6RHe2cU3X7+zaZhY5XAO8TFouBYI0reXOE9+2WyUy41c8RvcLIq1FfU75kFIgdutFyTSYPJh4utn67cGu5aP5y8CEYC0+CepLkPH6VA89z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=JYbZIN4o; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=+0XTSmRpRpQlJLb4r9UHDYQB9d+BSqxRmaLgegz4Vv8=; b=JYbZIN4oFY/zCWbU2QjfyUmbkw
	jiZJCopJJkoE+O/p3UqWIxSIAXlYhO1ufkW0b1NYG1Z/CAjdCwkqpj9jFjFVgCdSUgiIMp5XkUye0
	azzrALRXOdrPZ5sUenZ9tWMQwtFH0+UZKTnAJj2+EZEUltIFiazm0WhYkWLgRSWbDypSEYr2K14ib
	lM7cNB1FZpDx8NOo+9XlS+cAq3vup0Ibw+OF9KqGrKxmS8yBisMCDWPiCA7QUTjSJpnf517sdgSl7
	I/Pp0DG3IMQHcj71KlfyliFY/frV6QpqDwqD5umfjnnECzOwVunJgUcYVtJhnIBSrF2oCEcCatNM0
	0WT5iI/w==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tj1Sb-0000000BxOt-0fls;
	Fri, 14 Feb 2025 19:34:49 +0000
Date: Fri, 14 Feb 2025 19:34:49 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: "idryomov@gmail.com" <idryomov@gmail.com>,
	"ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	David Howells <dhowells@redhat.com>
Subject: Re: [PATCH v2 5/7] ceph: Convert ceph_readdir_cache_control to store
 a folio
Message-ID: <Z6-a2Qml3Bb8azaG@casper.infradead.org>
References: <20250214155710.2790505-1-willy@infradead.org>
 <20250214155710.2790505-6-willy@infradead.org>
 <da997962ce076d3962948d5404f51074a6829bf8.camel@ibm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <da997962ce076d3962948d5404f51074a6829bf8.camel@ibm.com>

On Fri, Feb 14, 2025 at 07:10:26PM +0000, Viacheslav Dubeyko wrote:
> > -		cache_ctl->page = find_lock_page(&dir->i_data, ptr_pgoff);
> > -		if (!cache_ctl->page) {
> > +		cache_ctl->folio = filemap_lock_folio(&dir->i_data, ptr_pgoff);
> > +		if (IS_ERR(cache_ctl->folio)) {
> > +			cache_ctl->folio = NULL;
> >  			doutc(cl, " page %lu not found\n", ptr_pgoff);
> 
> Maybe, we need to change debug output here too?
> 
> doutc(cl, " folio %lu not found\n", ptr_pgoff);

I'm happy to make that change for the next version, or for somebody to
make that change while applying the patches.

