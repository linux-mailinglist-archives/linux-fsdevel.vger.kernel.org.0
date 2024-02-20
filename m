Return-Path: <linux-fsdevel+bounces-12072-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E113B85B021
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Feb 2024 01:48:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FAE61F2145B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Feb 2024 00:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AA2E8F5A;
	Tue, 20 Feb 2024 00:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OuycNWj2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4766B3C24
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 Feb 2024 00:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708390107; cv=none; b=owh1d4btzjv0eYn8SbqZRt4jDEIky3z+o7eZZIhhkAJJ2eI9oquHpqnXdNNV7Yz24WRj5RmwJihMq1GXDgb1srtwGs14Fs+w1dAJbBohRnOlEPvPoj1IuTomfDsUFfsaGBrSeQmlD+4NbJpTFQY5ypEc6jIOQw6V+o8tz7xlEwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708390107; c=relaxed/simple;
	bh=cHHpzZ1dCm8DvbVFkXtkHNQbnTRJAprvYMMTP0RFhJs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hqM5EsnxDodmvoADNL569xM8ume9PvvzrosYuv6Xu6f3T74WKc7Oe9Khk3gZhWwULCRyk9BVFG2feW650bNaF15DrSL8D2vuvH8xEfVs7cItn61MfgXAqdaOuRzCg3qpDc2D1q2NJVORKeBxwSI8Ntci8xy0W1kKZ/htMmWOVgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OuycNWj2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708390103;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pDrxmnjvMkurOVEmHNcVzZPFQliOI9ywQHl3efXv/b0=;
	b=OuycNWj2c/afdcHRm4LmSock8BO2fMDPwOsw1JfqlgWxgDU/bVw2NMg9NbAMfDFeqXL4At
	0j+GVLJoTbhQHQXckh/9kUq8ERl2p4DVMYxqd57w04Zk8jg7rO08cSlECsEhN3Vnkngux6
	eUZaURLN9EytAXlJ3T12n+h909a1lq0=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-79-e35beYICMViVkVK1ONYJiw-1; Mon,
 19 Feb 2024 19:48:21 -0500
X-MC-Unique: e35beYICMViVkVK1ONYJiw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DCE9328C976D;
	Tue, 20 Feb 2024 00:48:20 +0000 (UTC)
Received: from redhat.com (unknown [10.22.33.227])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 9F5A64038F2F;
	Tue, 20 Feb 2024 00:48:20 +0000 (UTC)
Date: Mon, 19 Feb 2024 18:48:19 -0600
From: Bill O'Donnell <bodonnel@redhat.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, brauner@kernel.org
Subject: Re: [PATCH] efs: convert efs to use the new mount api
Message-ID: <ZdP209Z3C_Qqw5PP@redhat.com>
References: <20240220003318.166143-1-bodonnel@redhat.com>
 <ZdP2a9VZ_GOcABY6@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZdP2a9VZ_GOcABY6@casper.infradead.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

On Tue, Feb 20, 2024 at 12:46:35AM +0000, Matthew Wilcox wrote:
> On Mon, Feb 19, 2024 at 06:33:18PM -0600, Bill O'Donnell wrote:
> > Convert the efs filesystem to use the new mount API.
> 
> Hey Bill, what testing were you able to do for this?  I found some EFS
> images, but they didn't have any symlinks in them, so I wasn't able to
> test my rewrite of the symlink handling code.  Do you have a source of
> EFS images?
> 
https://archive.org/details/indigo-irix-4-0-5-datapartition.-7z


