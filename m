Return-Path: <linux-fsdevel+bounces-6578-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C57C0819C2C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Dec 2023 11:09:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02FB41C259CF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Dec 2023 10:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E574238DD8;
	Wed, 20 Dec 2023 10:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yv+RQcju"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A70A121103
	for <linux-fsdevel@vger.kernel.org>; Wed, 20 Dec 2023 10:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703066674;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fIGeUN2dP3Kfk2DN6cUDjpJQQIxLf4/llr+ahmqgJ9o=;
	b=Yv+RQcjuLb2BJamig3paboquwHlChBpfeW31UR7j/WCEqrwgHMAGwOhCTN1glOPiDNqtzL
	w7OLuAWOR/Hkiub+S7MBKxApBBdbPI46WVzX0Yv+Ev+1PnDf6cfHSi4ox9eze9PcvnUt2z
	umtpBWB5njpDo7phX01ewvr427F1dOY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-371-MZjr-7LVPD-4eoRcMCQdwA-1; Wed, 20 Dec 2023 05:04:31 -0500
X-MC-Unique: MZjr-7LVPD-4eoRcMCQdwA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 86329101A52A;
	Wed, 20 Dec 2023 10:04:30 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.39.195.169])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 8BFAB51D5;
	Wed, 20 Dec 2023 10:04:27 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <ZXxUx_nh4HNTaDJx@codewreck.org>
References: <ZXxUx_nh4HNTaDJx@codewreck.org> <20231213152350.431591-1-dhowells@redhat.com> <20231215-einziehen-landen-94a63dd17637@brauner>
To: Dominique Martinet <asmadeus@codewreck.org>
Cc: dhowells@redhat.com, Christian Brauner <brauner@kernel.org>,
    Jeff Layton <jlayton@kernel.org>, Steve French <smfrench@gmail.com>,
    Matthew Wilcox <willy@infradead.org>,
    Marc Dionne <marc.dionne@auristor.com>,
    Paulo Alcantara <pc@manguebit.com>,
    Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>,
    Eric Van Hensbergen <ericvh@kernel.org>,
    Ilya Dryomov <idryomov@gmail.com>, linux-cachefs@redhat.com,
    linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org,
    linux-nfs@vger.kernel.org, ceph-devel@vger.kernel.org,
    v9fs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
    linux-mm@kvack.org, netdev@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 00/39] netfs, afs, 9p: Delegate high-level I/O to netfslib
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1384978.1703066666.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 20 Dec 2023 10:04:26 +0000
Message-ID: <1384979.1703066666@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

Dominique Martinet <asmadeus@codewreck.org> wrote:

> I'll go back to dhowell's tree to finally test 9p a bit,
> sorry for lack of involvement just low on time all around.

I've rebased my tree on -rc6 rather than linux-next for Christian to pull.

Ganesha keeps falling over:

[root@carina build]# valgrind ./ganesha.nfsd -L /var/log/ganesha/ganesha.l=
og -f /etc/ganesha/ganesha.conf -N NIV_EVENT -F
=3D=3D38960=3D=3D Memcheck, a memory error detector
=3D=3D38960=3D=3D Copyright (C) 2002-2022, and GNU GPL'd, by Julian Seward=
 et al.
=3D=3D38960=3D=3D Using Valgrind-3.22.0 and LibVEX; rerun with -h for copy=
right info
=3D=3D38960=3D=3D Command: ./ganesha.nfsd -L /var/log/ganesha/ganesha.log =
-f /etc/ganesha/ganesha.conf -N NIV_EVENT -F
=3D=3D38960=3D=3D =

=3D=3D38960=3D=3D Thread 138:
=3D=3D38960=3D=3D Invalid read of size 4
=3D=3D38960=3D=3D    at 0x4DC32D6: pthread_cond_signal@@GLIBC_2.3.2 (pthre=
ad_cond_signal.c:41)
=3D=3D38960=3D=3D    by 0x489700C: sync_cb (fsal_helper.c:1837)
=3D=3D38960=3D=3D    by 0x49D79DF: mdc_read_super_cb (mdcache_file.c:559)
=3D=3D38960=3D=3D    by 0x49D7AC5: mdc_read_cb (mdcache_file.c:582)
=3D=3D38960=3D=3D    by 0x7B4B81F: vfs_read2 (file.c:1317)
=3D=3D38960=3D=3D    by 0x49D7BCF: mdcache_read2 (mdcache_file.c:617)
=3D=3D38960=3D=3D    by 0x4897173: fsal_read (fsal_helper.c:1849)
=3D=3D38960=3D=3D    by 0x4A10FD4: _9p_read (9p_read.c:134)
=3D=3D38960=3D=3D    by 0x4A0A024: _9p_process_buffer (9p_interpreter.c:18=
1)
=3D=3D38960=3D=3D    by 0x4A09DCB: _9p_tcp_process_request (9p_interpreter=
.c:133)
=3D=3D38960=3D=3D    by 0x48CE182: _9p_execute (9p_dispatcher.c:315)
=3D=3D38960=3D=3D    by 0x48CE508: _9p_worker_run (9p_dispatcher.c:412)
=3D=3D38960=3D=3D  Address 0x24 is not stack'd, malloc'd or (recently) fre=
e'd
=3D=3D38960=3D=3D =

=3D=3D38960=3D=3D =

=3D=3D38960=3D=3D Process terminating with default action of signal 11 (SI=
GSEGV): dumping core
=3D=3D38960=3D=3D  Access not within mapped region at address 0x24
=3D=3D38960=3D=3D    at 0x4DC32D6: pthread_cond_signal@@GLIBC_2.3.2 (pthre=
ad_cond_signal.c:41)
=3D=3D38960=3D=3D    by 0x489700C: sync_cb (fsal_helper.c:1837)
=3D=3D38960=3D=3D    by 0x49D79DF: mdc_read_super_cb (mdcache_file.c:559)
=3D=3D38960=3D=3D    by 0x49D7AC5: mdc_read_cb (mdcache_file.c:582)
=3D=3D38960=3D=3D    by 0x7B4B81F: vfs_read2 (file.c:1317)
=3D=3D38960=3D=3D    by 0x49D7BCF: mdcache_read2 (mdcache_file.c:617)
=3D=3D38960=3D=3D    by 0x4897173: fsal_read (fsal_helper.c:1849)
=3D=3D38960=3D=3D    by 0x4A10FD4: _9p_read (9p_read.c:134)
=3D=3D38960=3D=3D    by 0x4A0A024: _9p_process_buffer (9p_interpreter.c:18=
1)
=3D=3D38960=3D=3D    by 0x4A09DCB: _9p_tcp_process_request (9p_interpreter=
.c:133)
=3D=3D38960=3D=3D    by 0x48CE182: _9p_execute (9p_dispatcher.c:315)
=3D=3D38960=3D=3D    by 0x48CE508: _9p_worker_run (9p_dispatcher.c:412)

David


