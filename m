Return-Path: <linux-fsdevel+bounces-4999-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 104098072A6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 15:40:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95C9BB20EAF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 14:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 133473DBAC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 14:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jVISvmAW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C38241BD
	for <linux-fsdevel@vger.kernel.org>; Wed,  6 Dec 2023 04:38:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701866316;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TZQQ6BqHEI6hRsDFbv1/FW96mENZWMKFWNl0n0AGdhw=;
	b=jVISvmAWQCxftrAgR0WXMbr1r6rJPZTLPh+0On0WaSzV0TF+5AC94pV5915Rdo2BQzapDM
	cwKFcu1T5PfsT3CrbxqwW4cSxbPygJm+jUpFozoldVhTfjO06nz5gJlBir/BEgNtOezbB9
	vdN1SacXazgaHvpQo4j7FFmz7y/D3Gk=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-557-thj-CJ5vMACQz1wZWLOP9w-1; Wed,
 06 Dec 2023 07:38:31 -0500
X-MC-Unique: thj-CJ5vMACQz1wZWLOP9w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2F74F29AB3F3;
	Wed,  6 Dec 2023 12:38:31 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.161])
	by smtp.corp.redhat.com (Postfix) with ESMTP id C252E3C2E;
	Wed,  6 Dec 2023 12:38:29 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <447324.1701860432@warthog.procyon.org.uk>
References: <447324.1701860432@warthog.procyon.org.uk>
To: fstests@vger.kernel.org, samba-technical@lists.samba.org,
    linux-cifs@vger.kernel.org
Cc: dhowells@redhat.com, Steve French <sfrench@samba.org>,
    Paulo Alcantara <pc@manguebit.com>,
    Dave Chinner <david@fromorbit.com>,
    Filipe Manana <fdmanana@suse.com>,
    "Darrick J. Wong" <djwong@kernel.org>, linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: Re: Issues with FIEMAP, xfstests, Samba, ksmbd and CIFS
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <449657.1701866309.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 06 Dec 2023 12:38:29 +0000
Message-ID: <449658.1701866309@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

David Howells <dhowells@redhat.com> wrote:

> So:
> =

>  - Should Samba and ksmbd be using FALLOC_FL_ZERO_RANGE rather than
>    PUNCH_HOLE?
> =

>  - Should Samba and ksmbd be using FIEMAP rather than SEEK_DATA/HOLE?

 - Should Samba and ksmbd report 'unwritten' extents as being allocated?

>  - Should xfstests be less exacting in its FIEMAP analysis - or should t=
his be
>    skipped for cifs?  I don't want to skip generic/009 as it checks some
>    corner cases that need testing, but it may not be possible to make th=
e
>    exact extent matching work.


