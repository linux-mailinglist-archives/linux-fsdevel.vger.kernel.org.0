Return-Path: <linux-fsdevel+bounces-75312-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OE26FQ/cc2mbzAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75312-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 21:37:35 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C38D97A9C8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 21:37:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CFDFC3030119
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 20:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6206C2EC08C;
	Fri, 23 Jan 2026 20:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rMzzr48Z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 379382E8B9F;
	Fri, 23 Jan 2026 20:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769200641; cv=none; b=YJ7wzdfElkzGgpa8wms7rv8qHVhyZPRUbyNROP4PkKnaxRHaoWpMma3Sy9vxLanGFOR4gvFzAxOUNjIQo604p8lNwMFRV7WNEZg+DK/h2/zHwWaHocddCTE2g1sVyRKYx287ytVeH1InUuoLv4slEGkh8+DDTTE0jw+YdujUUR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769200641; c=relaxed/simple;
	bh=J3uIrIsI3rDKrre8O5bOnE8gVqwa7R70GzDdw+6sFgc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gWA0PHf2ubTGvmiMe2YsfboMZY7uU4p7uDaHTqLpe8LOeGdc/eIYr1P0dlVltY13oQymD/6krdQ5On11iaxXJcpL9Ju1dN/SsUbalKjiaGcYWOQ+6Rsq7oKgl3Wcfdg6iWlGQLjm26sA936O4UqQ10spkaEpqUm1DTM4DVCw5vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=rMzzr48Z; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=jIvepI9acMMMk9EyKKutMt3xnmNKtmyd0L+HCslVMZQ=; b=rMzzr48ZEZwxWMtRrKDYd5siJh
	aH5MXe97U3+/lggnM1s+cCvnK5QyDgtQqX/Ou9/z0+/TICygzTWr316AA58osp/yT8PJnYjsni60L
	HKyMZEwSibLYWoIbObsv1RVKbPMn9eGPjhxH7lXyrtcCq9H7cHIaS9WteSwHg+XjouAhHvn9JQZS8
	yCQLEhyl7ZGPx3NS8rQWO7WrSxTAM7+vbpu+v8sKpOwUmzk0X/GX8ofdd4hXTVGqStFeJ11wXrcY2
	mqTA9SJF3XAKqI4Gn757O/GLxH8ZaSzJaG/Yqs85MAyL2mgXCKSgXiLIAdqqga5ylsEpiLGQn4Osc
	EXBZEEqQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vjNu6-00000002Fay-1Ftx;
	Fri, 23 Jan 2026 20:37:14 +0000
Date: Fri, 23 Jan 2026 20:37:14 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: "qian01.li@samsung.com" <qian01.li@samsung.com>,
	"a.manzanares@samsung.com" <a.manzanares@samsung.com>,
	"lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
	"javier.gonz@samsung.com" <javier.gonz@samsung.com>,
	Patrick Donnelly <pdonnell@ibm.com>,
	"ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"slava@dubeyko.com" <slava@dubeyko.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	Pavan Rallabhandi <Pavan.Rallabhandi@ibm.com>
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Data placement policy for FDP SSD in
 Ceph and other distributed file systems
Message-ID: <aXPb-tehcuOvSC9V@casper.infradead.org>
References: <b4bbba0993d4c1abd6566d8d508bbb47aacd7671.camel@ibm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b4bbba0993d4c1abd6566d8d508bbb47aacd7671.camel@ibm.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=casper.20170209];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-75312-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[infradead.org:+];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willy@infradead.org,linux-fsdevel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	FORGED_SENDER_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: C38D97A9C8
X-Rspamd-Action: no action

On Fri, Jan 23, 2026 at 08:13:49PM +0000, Viacheslav Dubeyko via Lsf-pc wrote:
> I think we need to elaborate much better approach for FDP SSDs in the case of
> distributed file systems. I believe that it needs to execute accurate
> benchmarking of above mentioned use-cases with analysis of peculiarities of
> distributed file systems case. Finally, we will be able to analyze these results
> and to elaborate a vision of proper solution for distributed file system case
> (like Ceph, for example).
> 
> So, I suggest to meet at LSF/MM/BPF and to discuss the benchmarking results and
> potential vision of the solution.

Is this proposal for an I/O track discussion, an FS track discussion or
both?  (I see nothing in this proposal that would suggest that MM or BPF
people should be involved).

