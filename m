Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACC184A50C4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Jan 2022 22:06:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350833AbiAaVGW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Jan 2022 16:06:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:43705 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231445AbiAaVGW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Jan 2022 16:06:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643663181;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=hdMceCbdyxfSFbfoQzYV4Lhi860JugC7zvgsldD2nz4=;
        b=TpoRXLfzN9h6PNiRNFLvAuyoqx+dtCCumYMh+Y67n8b5n+ZsTYl1+Ldosv+s4epIdCrsP4
        2bavpmhpoPTIwXOC5t1aSvESCyGYOKXafI6psEsxuoiqY0uDqvHYYGEue+HpMGmmaBMILl
        +1tOl8TfvBJNoM3PoxWl7KG9n+isbzg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-599-oWLouDiTNk-R9qbMrqBTLQ-1; Mon, 31 Jan 2022 16:06:16 -0500
X-MC-Unique: oWLouDiTNk-R9qbMrqBTLQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F305914754;
        Mon, 31 Jan 2022 21:06:14 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.26])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 213755F714;
        Mon, 31 Jan 2022 21:06:13 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
To:     lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org
cc:     dhowells@redhat.com, jlayton@kernel.org
Subject: [LSF/MM/BPF TOPIC] Netfs support library
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2571704.1643663173.1@warthog.procyon.org.uk>
Date:   Mon, 31 Jan 2022 21:06:13 +0000
Message-ID: <2571706.1643663173@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I've been working on a library (in fs/netfs/) to provide network filesystem
support services, with help particularly from Jeff Layton.  The idea is to
move the common features of the VM interface, including request splitting,
operation retrying, local caching, content encryption, bounce buffering and
compression into one place so that various filesystems can share it.

This also intersects with the folios topic as one of the reasons for this now
is to hide as much of the existence of folios/pages from the filesystem,
instead giving it persistent iov iterators to describe the buffers available
to it.

It could be useful to get various network filesystem maintainers together to
discuss it and how to do parts of it and how to roll it out into more
filesystems if it suits them.  This might qualify more for a BoF session than
a full FS track session.

Further, discussion of designing a more effective cache backend could be
useful.  I'm thinking along the lines of something that can store its data on
a single file (or a raw blockdev) with indexing along the lines of what
filesystem drivers such as openafs do.

David

