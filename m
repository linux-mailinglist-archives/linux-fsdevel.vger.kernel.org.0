Return-Path: <linux-fsdevel+bounces-44586-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 84533A6A7EC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 15:07:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E9FC170C07
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 14:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2B18221579;
	Thu, 20 Mar 2025 14:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XmqSEx0e"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0199B65C
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Mar 2025 14:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742479500; cv=none; b=OiBtxTxXscK/aZBd2uVBdWNMUzcK88+cTBT1leNoxpaJAAMBrSwEksyzz78DZYDNhQVX9Rv5rlmXuu9tJKiky0EV8jsrEHGc6wGRHMnY1nQRw6wgObwH/WCDAXFXcOYtnIZL7E6QIVcfvdytO1Cvg30U77nH6+sR325rZN3UbbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742479500; c=relaxed/simple;
	bh=XDULgroMUvUU3j8Wr5RA8fyDZq/uwMLnQq9aIlty9JA=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=c6Zj5NWc0LQ+GoOrH/FR3sC1sRi8fpce0NQb2tVOsDxZY3/hFq2PLFXcnHctO1gc96YiOWZqc0RaoLNt6YRoFzg6N7yc5+iAfHT3XUR4W9ciS8dde+gAF3w9tz00NrUxgrT3dJVXho5IyZLcp9x3P5riTjuGIOoQGnDrnnhz4w8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XmqSEx0e; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742479497;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=btUkWu1ncXCsNFem2XFocy6A3pII+7ssUPnWyb31aMs=;
	b=XmqSEx0ekWyiEY8wav1v+JlF+7vlnHT9z8ZIFqvA2h/pWrK1eJCun6Lr791ZmJevVRtxwV
	aA1VwTIHNQGG1u565g2ApVJ5Msm4bM051QFRWJmtWQTGDbDM+2JYF6OwWtnIz2iHyZuZAa
	fXgRwBpNCR7z1lVk5VuuxZGoZkrWLto=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-97-72OSsSbtO4KsID3Dzapgmw-1; Thu,
 20 Mar 2025 10:04:55 -0400
X-MC-Unique: 72OSsSbtO4KsID3Dzapgmw-1
X-Mimecast-MFC-AGG-ID: 72OSsSbtO4KsID3Dzapgmw_1742479494
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 89F121801A06;
	Thu, 20 Mar 2025 14:04:53 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.61])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C60E93001D21;
	Thu, 20 Mar 2025 14:04:50 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20250319031545.2999807-2-neil@brown.name>
References: <20250319031545.2999807-2-neil@brown.name> <20250319031545.2999807-1-neil@brown.name>
To: NeilBrown <neil@brown.name>
Cc: dhowells@redhat.com, Alexander Viro <viro@zeniv.linux.org.uk>,
    Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
    Chuck Lever <chuck.lever@oracle.com>,
    Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
    netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/6] VFS: improve interface for lookup_one functions
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3170777.1742479489.1@warthog.procyon.org.uk>
Date: Thu, 20 Mar 2025 14:04:49 +0000
Message-ID: <3170778.1742479489@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

NeilBrown <neil@brown.name> wrote:

> Also the path component name is passed as "name" and "len" which are
> (confusingly?) separate by the "base".  In some cases the len in simply
> "strlen" and so passing a qstr using QSTR() would make the calling
> clearer.
> Other callers do pass separate name and len which are stored in a
> struct.  Sometimes these are already stored in a qstr, other times it
> easily could be.
> 
> So this patch changes these three functions to receive a 'struct qstr',
> and improves the documentation.

You did want 'struct qstr' not 'struct qstr *' right?  I think there are
arches where this will cause the compiler to skip a register argument or two
if it's the second argument or third argument - i386 for example.  Plus you
have an 8-byte alignment requirement because of the u64 in it that may suck if
passed through several layers of function.

David


