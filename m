Return-Path: <linux-fsdevel+bounces-53330-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47B76AEDCFB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 14:36:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2E8F1886F37
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 12:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AACF0286D55;
	Mon, 30 Jun 2025 12:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b3VlHKsl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A04A2701DC
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Jun 2025 12:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751286949; cv=none; b=rlb1KgC9L3iTIxaOkQR8Qd8uiGgMh99WnD/h1eEXubYpEtWV/LsKdY2Xtl69bDuHO3fv8Re/cBaFmHJQG1XdwBbZrTHwqvFVK7WtHeku+KPB/ZLE88aK6TbKESqoi9PZqv5GjxXW8A7gFMbOCRohvNMBdmo/4pk+GK+5Q8rNC4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751286949; c=relaxed/simple;
	bh=26sNKR6wEfMyhROW4BBekBUidJAz8jHJII1OVvImDkc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QnO8ojZgclx6RQeP2XX0WVnsFMsi8Onobq4s0qam1km+x9DTLOqlHwpntrOOSKuolJLwq4t7JcsmEMqPqZMRVB5LyFnY5ZmFMypT8W/bAM/Z3+QauabTnRXc2nfLR0VDYL5S4OxgGVNgKa+mhant9Oedplz5sC0jJ37W4K3fpao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b3VlHKsl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751286946;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bTnzgPM0dpIXyHgyu+1irqiMxmekrJg7dmLLPllBDn8=;
	b=b3VlHKslmwePB4qzube0Wolo7Vt1UwWeIpDiy1NnU2JZkgwyb0IXlhz5rGVdd3NDfNIud2
	OFJkRw//zEHtmc30odJQgWpLrmNYdEzTDUbGHbWcmy1CieJQOeOWAKpjBgNiDdTVlS05DI
	7nk7kfGlyssUaWbep7iGGDTSUZ6r6nU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-403-uo3GGbkSOge3oIcb_1vwTQ-1; Mon,
 30 Jun 2025 08:35:42 -0400
X-MC-Unique: uo3GGbkSOge3oIcb_1vwTQ-1
X-Mimecast-MFC-AGG-ID: uo3GGbkSOge3oIcb_1vwTQ_1751286941
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B468B180120B;
	Mon, 30 Jun 2025 12:35:40 +0000 (UTC)
Received: from bfoster (unknown [10.22.64.142])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F023118003FC;
	Mon, 30 Jun 2025 12:35:38 +0000 (UTC)
Date: Mon, 30 Jun 2025 08:39:16 -0400
From: Brian Foster <bfoster@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Joanne Koong <joannelkoong@gmail.com>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-block@vger.kernel.org, gfs2@lists.linux.dev
Subject: Re: [PATCH 03/12] iomap: refactor the writeback interface
Message-ID: <aGKFdAagQFimoiXx@bfoster>
References: <20250627070328.975394-1-hch@lst.de>
 <20250627070328.975394-4-hch@lst.de>
 <aF61PZEb5ndROI6z@bfoster>
 <20250630054233.GA28532@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250630054233.GA28532@lst.de>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Mon, Jun 30, 2025 at 07:42:33AM +0200, Christoph Hellwig wrote:
> On Fri, Jun 27, 2025 at 11:14:05AM -0400, Brian Foster wrote:
> > >   struct iomap_writeback_ops {
> > > -     int (*map_blocks)(struct iomap_writeback_ctx *wpc, struct inode *inode,
> > > -                       loff_t offset, unsigned len);
> > > -     int (*submit_ioend)(struct iomap_writeback_ctx *wpc, int status);
> > > -     void (*discard_folio)(struct folio *folio, loff_t pos);
> > > +    int (*writeback_range)(struct iomap_writeback_ctx *wpc,
> > > +    		struct folio *folio, u64 pos, unsigned int len, u64 end_pos);
> > 
> > Whitespace damage on the above line.
> 
> Without this the vim syntax highlighting is confused for the rest of the
> file unfortunately.  Not sure how to deal with it, the RST formatting
> keeps driving me crazy.  As does this document, which really should
> not duplicate the type information, but folks really wanted this
> annoyingly redundant information that is a huge pain to maintain for no
> gain at all :(
> 

Ok NBD, just pointing out the tab/whitespace mix.

Brian


