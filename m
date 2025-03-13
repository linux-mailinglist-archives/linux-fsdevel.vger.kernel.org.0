Return-Path: <linux-fsdevel+bounces-43984-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA74DA60611
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Mar 2025 00:46:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09ECA17B052
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Mar 2025 23:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A04321FECC5;
	Thu, 13 Mar 2025 23:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TKN/tD/s"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E8851FBC92
	for <linux-fsdevel@vger.kernel.org>; Thu, 13 Mar 2025 23:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741909070; cv=none; b=Q5FUOpNL58t4LKjz4W14Sd3kM3NdtFD9SV2EP7XswzRXzcg7dSjrFZKf1yi0cUy43YqveXzQhj/AnfInI7nvZGdGGmQL4wieHkl1bgTeSljBNYLnXwaX8N2B378DuDQdzQvIGPeWFU5M5tZeso/exec2t130vpsZDxKHlMth+ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741909070; c=relaxed/simple;
	bh=2GsUSaYmaoLRbFEciljwa2mCFWQ4cSDvmrFWJ/xZA64=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=EubPjoNJ+xFDDXqCnsdPitecxdMIYRC4RnhLcrZ/BNI3DWw6djJbA/I1XiD5RXWLWpq27+Mz0nMhhB6HyVwREQ8QN4GJdEc3bMvq4kuIDosX7l/duj+bt0r4gGhm0t02RBvHNN3QOYFCnQL9oTrT+Gqzm8+jAQq7ZVSlWY/1nEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TKN/tD/s; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741909067;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xBD7a+UasP1I2w1kgH35J+2aChRyv9wNX5h+9iuQ3JU=;
	b=TKN/tD/sqqTMDo+Kr2Ags2vNbYqlu6tpPZFfQnhynIWfAab7A41etk8M1NXf8fN2Htk9rF
	p03gNcGLPDlKznX45Sx3CfY03sljkmv+UPnegfjDFidbCpx7d9SbFXexs6rJoLafyaIgb6
	YbPzN4d703gXit4PUYZnvYC6NaiRclk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-280-AqL3zhagOWmuehWFIDOjqA-1; Thu,
 13 Mar 2025 19:37:40 -0400
X-MC-Unique: AqL3zhagOWmuehWFIDOjqA-1
X-Mimecast-MFC-AGG-ID: AqL3zhagOWmuehWFIDOjqA_1741909058
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8D900180AF4C;
	Thu, 13 Mar 2025 23:37:38 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.61])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EE68218001F6;
	Thu, 13 Mar 2025 23:37:35 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <756af030a5085152f923e41b84746930b464af5d.camel@kernel.org>
References: <756af030a5085152f923e41b84746930b464af5d.camel@kernel.org> <3cc1ac78a01be069f79dcf82e2f3e9bfe28d9a4b.camel@dubeyko.com> <1385372.1741861062@warthog.procyon.org.uk> <1468676.1741898867@warthog.procyon.org.uk>
To: Jeff Layton <jlayton@kernel.org>
Cc: dhowells@redhat.com, slava@dubeyko.com,
    Alex Markuze <amarkuze@redhat.com>, Xiubo Li <xiubli@redhat.com>,
    Ilya Dryomov <idryomov@gmail.com>,
    Alexander Viro <viro@zeniv.linux.org.uk>,
    Christian Brauner <brauner@kernel.org>, ceph-devel@vger.kernel.org,
    linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
    Slava.Dubeyko@ibm.com
Subject: Re: Does ceph_fill_inode() mishandle I_NEW?
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1675538.1741909054.1@warthog.procyon.org.uk>
Date: Thu, 13 Mar 2025 23:37:35 +0000
Message-ID: <1675539.1741909055@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Jeff Layton <jlayton@kernel.org> wrote:

> I don't think that can happen. An I_NEW inode hasn't been properly
> hashed yet, so nothing should be able to find it until
> unlock_new_inode() is called.

That's not where the issue lies.  I'm talking about *after* I_NEW has been
cleared.

Imagine you have a file that has hard links in several directories.  Can
simultaneous lookup on a number of those hard links result in you going
through ceph_fill_inode() a number of times in parallel?

David


