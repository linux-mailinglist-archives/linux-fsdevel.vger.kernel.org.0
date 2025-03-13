Return-Path: <linux-fsdevel+bounces-43986-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB4FDA60623
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Mar 2025 00:48:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D51C170CAF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Mar 2025 23:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D37FB1F9A8B;
	Thu, 13 Mar 2025 23:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hf0A/lP0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6671F428D
	for <linux-fsdevel@vger.kernel.org>; Thu, 13 Mar 2025 23:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741909682; cv=none; b=h21QwRoA/n8hfvMWq+p4ceA3RvPjPlQDxM9yP5CE4lhGsmiHeTUcT7RnqACLbR5ss6njICFKpUeXEN7gluPAIDbqnphEtiJbRcS4SYRg0E/e6kPS6oSKUrpvR526UaptVQzJAtesa+GSQyeEpvXvHgovM0NxKNLxFK3241EeKxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741909682; c=relaxed/simple;
	bh=c/R2eWJN73OAnf+cDH4VbIwlHouaueamUjPiMOGohzM=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=VEYjipYQs+bqOV+jp9FCRdUxsUxJEgkx8BI8HeFCcUQu8a8Oyl4dCtAyEiUdLdN3cJWb8uKVQQjaKxlqqgEK0T8Wk3tPmvGZ+pTRPDBSzo/M8P3hAWcaIrIBg3IpsDjkZ6YlfxNOyf9SmncVOmg2rgGZP+NM56Z7G0Djc0AbIaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hf0A/lP0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741909679;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=U3KTQtb9P2zqOVNlWFWZBPZQ1STkKHL1APVS4Ih5ZuI=;
	b=hf0A/lP0WoAC0WpNysA+N33sbbv0opzpo6aTf1lysLAAogF6Io9j9adCI+E8odr2AguVbQ
	PNGmTWIiIHepzp8cwpRFvS9BGVCAro2LSuNZdmA4cdZqwSujha4g9zh5xCj70T/oBeS0aT
	xwJJ13AeVOrAq7DhctsNlVZKC8K5TKQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-610-FQYqVqO2OfW_o6Tm_0aJ9g-1; Thu,
 13 Mar 2025 19:47:56 -0400
X-MC-Unique: FQYqVqO2OfW_o6Tm_0aJ9g-1
X-Mimecast-MFC-AGG-ID: FQYqVqO2OfW_o6Tm_0aJ9g_1741909675
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 03CFA1801A00;
	Thu, 13 Mar 2025 23:47:55 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.61])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2B756300376F;
	Thu, 13 Mar 2025 23:47:51 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <afeb9082273098f47b26371a7e252381d1268c8e.camel@ibm.com>
References: <afeb9082273098f47b26371a7e252381d1268c8e.camel@ibm.com> <3cc1ac78a01be069f79dcf82e2f3e9bfe28d9a4b.camel@dubeyko.com> <1385372.1741861062@warthog.procyon.org.uk> <1468676.1741898867@warthog.procyon.org.uk>
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: dhowells@redhat.com, "slava@dubeyko.com" <slava@dubeyko.com>,
    Xiubo Li <xiubli@redhat.com>,
    "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
    "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
    "brauner@kernel.org" <brauner@kernel.org>,
    "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
    Alex Markuze <amarkuze@redhat.com>,
    "jlayton@kernel.org" <jlayton@kernel.org>,
    "idryomov@gmail.com" <idryomov@gmail.com>,
    "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>
Subject: Re: Does ceph_fill_inode() mishandle I_NEW?
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1675857.1741909671.1@warthog.procyon.org.uk>
Date: Thu, 13 Mar 2025 23:47:51 +0000
Message-ID: <1675858.1741909671@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Viacheslav Dubeyko <Slava.Dubeyko@ibm.com> wrote:

> As far as I can see, ceph_fill_inode() has comment: "Populate an inode based
> on info from mds. May be called on new or existing inodes". It sounds to me
> that particular CephFS kernel client could have obsolete state of inode
> compared with MDS's state. And we need to "re-new" the existing inode with
> the actual state that we received from MDS side. My vision is that we need
> to take into account the distributed nature of Ceph and inode metadata can
> be updated from multiple CephFS kernel client instances. Am I right here?

As I mentioned in my reply to Jeff, I'm thinking of what happens in the event
that we have a file that has hard links in several directories in a situation
where several of those links are looked up simultaneously.  Can we end up with
ceph_fill_inode() being run in parallel on several threads on the same inode?

Actually, the use of ci->i_ceph_lock looks like it should make it safe, now
that I look at it again.

David


