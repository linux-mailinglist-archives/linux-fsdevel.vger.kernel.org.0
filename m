Return-Path: <linux-fsdevel+bounces-35114-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 292029D1705
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Nov 2024 18:21:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3E5828386E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Nov 2024 17:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D7971C1F11;
	Mon, 18 Nov 2024 17:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PkvuyAmD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 377C51C1AB1
	for <linux-fsdevel@vger.kernel.org>; Mon, 18 Nov 2024 17:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731950427; cv=none; b=urxoyJFPzF3wCVT1HP2DOBYdGwBDBjDyvmSNnOan9flLw1MhTRr+2k50WPbgH5diE2Gpc/Y+wYRN8/ZYaGO71oo/YwJXHdh8zTBiUvak3nubsPNTWvx0M5XHcTJM+AEQzSOxUbsapRKa4kBZ/zgTRBMES6S4pCqTVKgTFLGRlQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731950427; c=relaxed/simple;
	bh=QvW2+t11JE5qZYQ/utYmcrFzR4tFb8NbOkxwQxklLRY=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=dHunQk99CAAYpIAJnI/PbzBye4iDyRTTNQyryJwxlDLQ35O2/E+asCAR7IWP+UJuqCUIjbzzut7PpT5cPwGcyC+kEnjrAn7krp48cidD6gqGQugXN+hlHnbr4Gk8S8RPjSl4IE4SXyeXP9SdJhX1enQqsq199hU7Cqoq7m1iOx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PkvuyAmD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731950425;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FHIXshzU7B/fw7mP4ANo81ZSu1pvlr9VA+iMyEA9kz8=;
	b=PkvuyAmDP/lS+z4Vli408Dy/08wbevlFxTRj0W/L3Flkt/ZglkUhypkcGn3hCjSDlYt9r4
	Yibm0/5ianRmwd75mKkpkwERyY+JJa8CsL/Ys4zIsszZuqQB/iXOn6ze3rMQJIf/zFWxdk
	sIeFmrrxD4WnemuuHRvRHzh7jxfqdpw=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-152-eXuZijuZMpiG0ZJ9iVPEIQ-1; Mon,
 18 Nov 2024 12:20:22 -0500
X-MC-Unique: eXuZijuZMpiG0ZJ9iVPEIQ-1
X-Mimecast-MFC-AGG-ID: eXuZijuZMpiG0ZJ9iVPEIQ
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A67371955D62;
	Mon, 18 Nov 2024 17:20:16 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.207])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 261D5195DF81;
	Mon, 18 Nov 2024 17:20:08 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20241114163931.GA1928968@thelio-3990X>
References: <20241114163931.GA1928968@thelio-3990X> <20241108173236.1382366-1-dhowells@redhat.com> <20241108173236.1382366-29-dhowells@redhat.com>
To: Nathan Chancellor <nathan@kernel.org>
Cc: dhowells@redhat.com, Christian Brauner <brauner@kernel.org>,
    Steve French <smfrench@gmail.com>,
    Matthew Wilcox <willy@infradead.org>,
    Jeff Layton <jlayton@kernel.org>,
    Gao Xiang <hsiangkao@linux.alibaba.com>,
    Dominique Martinet <asmadeus@codewreck.org>,
    Marc Dionne <marc.dionne@auristor.com>,
    Paulo Alcantara <pc@manguebit.com>,
    Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>,
    Eric Van Hensbergen <ericvh@kernel.org>,
    Ilya Dryomov <idryomov@gmail.com>, netfs@lists.linux.dev,
    linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org,
    linux-nfs@vger.kernel.org, ceph-devel@vger.kernel.org,
    v9fs@lists.linux.dev, linux-erofs@lists.ozlabs.org,
    linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
    netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 28/33] netfs: Change the read result collector to only use one work item
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <948807.1731950408.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 18 Nov 2024 17:20:08 +0000
Message-ID: <948808.1731950408@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Nathan Chancellor <nathan@kernel.org> wrote:

> This change as commit 1bd9011ee163 ("netfs: Change the read result
> collector to only use one work item") in next-20241114 causes a clang
> warning:
> =

>   fs/netfs/read_retry.c:235:20: error: variable 'subreq' is uninitialize=
d when used here [-Werror,-Wuninitialized]
>     235 |         if (list_is_last(&subreq->rreq_link, &stream->subreque=
sts))
>         |                           ^~~~~~
>   fs/netfs/read_retry.c:28:36: note: initialize the variable 'subreq' to=
 silence this warning
>      28 |         struct netfs_io_subrequest *subreq;
>         |                                           ^
>         |                                            =3D NULL
> =

> May be a shadowing issue, as adding KCFLAGS=3D-Wshadow shows:

Yep.  I'll remove both shadowing variables (there's also one at line 45 in=
 the
bit that deals with the non-renegotiation case) and use the outermost one.

Thanks,
David


