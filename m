Return-Path: <linux-fsdevel+bounces-43369-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B35AEA54FBF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Mar 2025 16:56:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E91D188FD6F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Mar 2025 15:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C747C21129A;
	Thu,  6 Mar 2025 15:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IXg6ZxML"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95867210F4D
	for <linux-fsdevel@vger.kernel.org>; Thu,  6 Mar 2025 15:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741276559; cv=none; b=ECf2vEXQmRDOKzBSquOR0BEuNVMTOVpWrRwtn0RKRJTZzKfc6wABBcKnlne01NYPZqfnbPHdkKKXty39DjgBklLiEztl+I8m+m6xEpBGzupf1SeY6Q7w72T09Om2jtH0t4u+4ubR3F1GcPoDoUuvqTuaIDDoWWzDCg7+9xc1BuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741276559; c=relaxed/simple;
	bh=kObqhbINUHnq58Ts0ynAFMe+oPoTJu0RezAjeLWYy8g=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=f3pJhn1nwTQxnVkRdzcC/1VTYTrRj/kQfnVbKtCbQfrcm8tbLXIJu2kC39MAWU5rQA30o6PSo715zMrt6R6sgsE1ClD6ds6qKTa89FhbIg9Q1HCs+W7k6OtGcxuzXsakYT8PPitYIFrN9je0xtaoQG/lFw4sDPj71eTnQK14ppY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IXg6ZxML; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741276556;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8NHhi27aZByFhZvPPNchTEignqTE3P+TbomjiQklZyg=;
	b=IXg6ZxMLGYYQ1tXJckhB4cTSaI1bKZvb9ZSc10s8lxkUj2O9gvnR4wLBv1afgcUTgNxiZN
	bafbJsDVrFxVR/GUWl0pwVn/7WyJkYYqnjelTcid1omOOqaK+TKOoq+dwmT+3PCtpXAcsF
	+bnS3UoM3o8igiYTTR5COt4J7XKhC/Y=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-683-VLCruU2AOeutzI0ShvquKw-1; Thu,
 06 Mar 2025 10:55:43 -0500
X-MC-Unique: VLCruU2AOeutzI0ShvquKw-1
X-Mimecast-MFC-AGG-ID: VLCruU2AOeutzI0ShvquKw_1741276542
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 737BF1956083;
	Thu,  6 Mar 2025 15:55:42 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.32.200])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 563571955DCE;
	Thu,  6 Mar 2025 15:55:38 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <CAO8a2Sg2b2nW6S3ctS+H0F1Owt=rAkKCyjnFW3WoRSKYD-sSDQ@mail.gmail.com>
References: <CAO8a2Sg2b2nW6S3ctS+H0F1Owt=rAkKCyjnFW3WoRSKYD-sSDQ@mail.gmail.com> <3989572.1734546794@warthog.procyon.org.uk> <4170997.1741192445@warthog.procyon.org.uk>
To: Alex Markuze <amarkuze@redhat.com>
Cc: dhowells@redhat.com, Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>,
    Ilya Dryomov <idryomov@gmail.com>, Xiubo Li <xiubli@redhat.com>,
    Jeff Layton <jlayton@kernel.org>, ceph-devel@vger.kernel.org,
    netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
    Gregory Farnum <gfarnum@redhat.com>,
    Venky Shankar <vshankar@redhat.com>,
    Patrick Donnelly <pdonnell@redhat.com>
Subject: Re: Ceph and Netfslib
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <132457.1741276536.1@warthog.procyon.org.uk>
Date: Thu, 06 Mar 2025 15:55:36 +0000
Message-ID: <132458.1741276536@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Does ceph_write_iter() actually need to drop the inode I/O lock in order to
handle EOLDSNAPC?  I'm wondering if I can deal with it in the netfs request
retry code - but that means dealing with it whilst the I/O lock is held.

David


