Return-Path: <linux-fsdevel+bounces-44599-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4E4BA6A8EE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 15:46:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D8551776AE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 14:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A65191E2853;
	Thu, 20 Mar 2025 14:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M0rsfSwD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D5A91E1A05
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Mar 2025 14:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742481869; cv=none; b=SbNlbTS4WSH2tHVKEf011j2RCBcJTDmN2iYQUKXJj3oGKt3C1sFEvT05X9yr3RxSvlR9E0a1f/WxFSNyInqzXdRfVofG9ZRyZHnDsokMu0b+u+KlMIJQPH3jksBQdpi2s6AgD8g7x+gBOWhAL6SJVxPIFXheRS2qVi9hvc/H3+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742481869; c=relaxed/simple;
	bh=zJ2N5Sje1TsFpx1txcvkGVs9M1jCDKPalNO6wcsqJzA=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=Dqwnam7HqauDSiinNRCM1DYekuQLegwlwLULuvcjR5I4VLSCYItV3dnw8S0mBQVvZ0VIElH76foeVrXG2IgpPoQg/j62ACZnj9BdIgzsm6dDSJHE9aoIGk029vrMSf31L+YexNfM1CgFoBdwD77KwRhAIgLZDeVveSAXqoisLjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M0rsfSwD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742481866;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EL9f1EpuEC79rGyi/SbJ4e42e9KhE2EM/hh13H42cIk=;
	b=M0rsfSwDuuNcwmfyNEG1dgLZMOL6Is3dcJYPIspDJux8+hCIGQmnv6oV81X3797rwNX69k
	64/8zCz1H6Y306I3qyz4j9WV3rQns1FFbcyLrcS77taYRO5/5fpHrgNc75pOlFLQV4Hq3U
	E6mhUwwUF5hFXZeXkIDZyyMj+O+g3LA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-617-kjbRVno5Nfm19xQJikLQEg-1; Thu,
 20 Mar 2025 10:44:22 -0400
X-MC-Unique: kjbRVno5Nfm19xQJikLQEg-1
X-Mimecast-MFC-AGG-ID: kjbRVno5Nfm19xQJikLQEg_1742481861
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 09E731800266;
	Thu, 20 Mar 2025 14:44:21 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.61])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A473218001D4;
	Thu, 20 Mar 2025 14:44:17 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <b1108a2b01c693430abb4566b1bd644a5985ecf6.camel@ibm.com>
References: <b1108a2b01c693430abb4566b1bd644a5985ecf6.camel@ibm.com> <20250313233341.1675324-1-dhowells@redhat.com> <20250313233341.1675324-23-dhowells@redhat.com>
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: dhowells@redhat.com, Alex Markuze <amarkuze@redhat.com>,
    "slava@dubeyko.com" <slava@dubeyko.com>,
    "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
    "idryomov@gmail.com" <idryomov@gmail.com>,
    "jlayton@kernel.org" <jlayton@kernel.org>,
    "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
    "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
    "dongsheng.yang@easystack.cn" <dongsheng.yang@easystack.cn>,
    "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 22/35] libceph, rbd: Convert ceph_osdc_notify() reply to ceph_databuf
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3172345.1742481855.1@warthog.procyon.org.uk>
Date: Thu, 20 Mar 2025 14:44:15 +0000
Message-ID: <3172346.1742481855@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Viacheslav Dubeyko <Slava.Dubeyko@ibm.com> wrote:

> >  		} else if (!completion_done(&lreq->notify_finish_wait)) {
> > -			struct ceph_msg_data *data =
> > -			    msg->num_data_items ? &msg->data[0] : NULL;
> > -
> > -			if (data) {
> > -				if (lreq->preply_pages) {
> > -					WARN_ON(data->type !=
> > -							CEPH_MSG_DATA_PAGES);
> > -					*lreq->preply_pages = data->pages;
> > -					*lreq->preply_len = data->length;
> > -					data->own_pages = false;
> > -				}
> > +			if (msg->num_data_items && lreq->reply) {
> > +				struct ceph_msg_data *data = &msg->data[0];
> 
> This low-level access slightly worry me. I don't see any real problem
> here. But, maybe, we need to hide this access into some iterator-like
> function? However, it could be not feasible for the scope of this patchset.

Yeah.  This is something that precedes my changes and I think it needs fixing
apart from it.

David


