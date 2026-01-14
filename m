Return-Path: <linux-fsdevel+bounces-73648-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 927F8D1D944
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 10:36:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1AC3B30621C0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 09:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89D2038944F;
	Wed, 14 Jan 2026 09:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MpBNp8dg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B066C3876B1
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Jan 2026 09:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768382968; cv=none; b=ubfHew8P9qkc0I3zzAJbDwisg8l1FghZL9upONdWvhHni8IecPscdRs7O7VshnAKvKM2soVlfuFe3Dw1hU6y0vedhf8/g9pv0MbflWRjENiF0kZyQX18QB/hCfsN1l0tslTI6vvmI2Co3CTyAE8jtLfK0GI7Oh7fMUNhsDknsw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768382968; c=relaxed/simple;
	bh=0RuxCL5zBIFguHb39hXEQugp5yp37Ntj6FG3EuUOzZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aLXTkkGMzNaa3yzwz1Mtv1abQVrja9awa6v/g/Z0LjbZqbFI6q3GLaCBUb2JROEf/wD+Yo7MVBvi6+9tP+H5gsFIJKPFEhTjGquTJgIyCz7d1D9FQXZD5oRhEEzjhc9+3sy4ohvjkWGizVZRxmGg86EvyLvgUlrM5PchcOC3Bp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MpBNp8dg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768382965;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=egitCqoPWwid8Fe+BOBcmLWtnyZdRr835gW8BnU1y3A=;
	b=MpBNp8dgFnkVsC05f7kPeWRCk9ta7DGlcptJ+mNrGbg+u71EdFrLZoPE2VVA93PCHcmiQt
	GE5SifCHKt+MPjaRuzWZirX1lB8eGMNAcOQpxRSNLMtPff3nNCX++vOqV+bpYocXJwUtnI
	lwDecfC4iYC6wUX4qeErvoih684PCAw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-498-vA5---oWMBaXRDGHR0yfNA-1; Wed,
 14 Jan 2026 04:29:22 -0500
X-MC-Unique: vA5---oWMBaXRDGHR0yfNA-1
X-Mimecast-MFC-AGG-ID: vA5---oWMBaXRDGHR0yfNA_1768382961
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D7DE619560A5;
	Wed, 14 Jan 2026 09:29:20 +0000 (UTC)
Received: from ws (unknown [10.44.33.173])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1D6B81956048;
	Wed, 14 Jan 2026 09:29:17 +0000 (UTC)
Date: Wed, 14 Jan 2026 10:29:14 +0100
From: Karel Zak <kzak@redhat.com>
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: "slava@dubeyko.com" <slava@dubeyko.com>, 
	Alex Markuze <amarkuze@redhat.com>, "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>, 
	"ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"idryomov@gmail.com" <idryomov@gmail.com>, Pavan Rallabhandi <Pavan.Rallabhandi@ibm.com>, 
	Patrick Donnelly <pdonnell@redhat.com>
Subject: Re: [PATCH] mount: (manpage) add CephFS kernel client mount options
Message-ID: <urbvcc5r4fc6rsvwhikem73tbdmapvyy6mtrqbbl7vsdvoeis6@upwfm2u5jk3t>
References: <20260112205837.975869-2-slava@dubeyko.com>
 <binwryzqlbprj2t3ybxb5kychdeenhtmadbe23hov44urszvn5@kpbbv3qks47c>
 <c15ce83bf9ee6c5c37db193c33a77b52f0594564.camel@ibm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c15ce83bf9ee6c5c37db193c33a77b52f0594564.camel@ibm.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Tue, Jan 13, 2026 at 07:29:00PM +0000, Viacheslav Dubeyko wrote:
> My assumption was that if other file systems have description of specific mount
> options in this man page, then CephFS should have too. :) 

Unfortunately, some filesystems lack specific man pages, so mount.8
serves as a fallback solution for them. In an ideal world, mount.8
would not include filesystem-specific mount options.

I have added a link to mount.ceph in mount.8
https://github.com/util-linux/util-linux/commit/de7973f9906da09b86f221b030ec836c1e91fd22

Thank you for the suggestion!

 Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com


