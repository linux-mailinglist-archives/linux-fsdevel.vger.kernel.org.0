Return-Path: <linux-fsdevel+bounces-37304-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74E5A9F0E76
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 15:05:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AF6C161CD3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 14:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 628C51E1C26;
	Fri, 13 Dec 2024 14:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GvpBbhdJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E58911E0DFE
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Dec 2024 14:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734098680; cv=none; b=BSbHIyhe6uEV7neFXj8iDXDiVdW9w98IUtPE6dQIA18RGxVaF3vZ8DEGpXUi/DQF9KjmACGf3kWGSWWx/M6NNFEznjxJOhV8BkLZgMhKln02spgJ8SkNPjLAEiz45/20HvQn8OIdAuXUpX4CdRmbuj9kSlGmtPzVx50Eg/OyygE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734098680; c=relaxed/simple;
	bh=BLcmeVJ5U4DYQzHKAiQZlh7Ak2tSTMDloMiK5se3BJg=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=JS9Z/YE1ON06q0CNpkowf4/yNqfbez3F6Tb/Fe6YTNY+MIWM552PNUs5FU54eHH3BV+WYiq/AAiPy5bp9BH26MaQNOlyPFNG/46wfyGCvN/SEMtgSmL66+FsHc8x0kYaLb1Upb2sdYQdjh5T664YySWtXy6qAdyJz5yIM+8jkjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GvpBbhdJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734098677;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BMjJh3rNwqJWG/q45S190yCaLe7IaLUoUOyUtTRrI4M=;
	b=GvpBbhdJxHLTTk7tEp+GrG/hgYqBCPd4kPoQuAMbQOt5cprpaETz7whqcUONxLZW3Ed8q1
	hOC9JW56Isx4kO8QHtMb/czvH7FVwTfoyZhnSvYhcTpIOPBPtDDERUfoJ9wi9DhH3hW1U3
	L6iyPynqFBzBi5lCPaA9Wu+6UhhPYdI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-528-A8uEA95lOSGhAgZJarh21Q-1; Fri,
 13 Dec 2024 09:04:32 -0500
X-MC-Unique: A8uEA95lOSGhAgZJarh21Q-1
X-Mimecast-MFC-AGG-ID: A8uEA95lOSGhAgZJarh21Q
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BCB9F1955E9A;
	Fri, 13 Dec 2024 14:04:29 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.48])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9948F195605A;
	Fri, 13 Dec 2024 14:04:25 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20241213135013.2964079-1-dhowells@redhat.com>
References: <20241213135013.2964079-1-dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
    Ilya Dryomov <idryomov@gmail.com>
Cc: dhowells@redhat.com, Max Kellermann <max.kellermann@ionos.com>,
    Xiubo Li <xiubli@redhat.com>, Trond Myklebust <trondmy@kernel.org>,
    Jeff Layton <jlayton@kernel.org>,
    Matthew Wilcox <willy@infradead.org>, netfs@lists.linux.dev,
    linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org,
    linux-nfs@vger.kernel.org, ceph-devel@vger.kernel.org,
    v9fs@lists.linux.dev, linux-erofs@lists.ozlabs.org,
    linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
    linux-kernel@vger.kernel.org
Subject: ceph xfstests failures [was Re: [PATCH 00/10] netfs, ceph, nfs, cachefiles: Miscellaneous fixes/changes]
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2964552.1734098664.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Dec 2024 14:04:24 +0000
Message-ID: <2964553.1734098664@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

David Howells <dhowells@redhat.com> wrote:

> With these patches, I can run xfstest -g quick to completion on ceph wit=
h a
> local cache.

I should qualify that.  The thing completes and doesn't hang, but I get 6
failures:

    Failures: generic/604 generic/633 generic/645 generic/696 generic/697 =
generic/732

Though these don't appear to be anything to do with netfslib (see attached=
).
There are two cases where the mount is busy and the rest seems to be due t=
o
id-mapped mounts and/or user namespaces.

The xfstest local.config file looks something like:

    export FSTYP=3Dceph
    export TEST_DEV=3D<ipaddr>:/test
    export TEST_DIR=3D/xfstest.test
    TEST_FS_MOUNT_OPTS=3D'-o name=3Dadmin,mds_namespace=3Dtest,fs=3Dtest,f=
sc'
    export SCRATCH_DEV=3D<ipaddr>:/scratch
    export SCRATCH_MNT=3D/xfstest.scratch
    export MOUNT_OPTIONS=3D'-o name=3Dadmin,mds_namespace=3Dscratch,fs=3Ds=
cratch,fsc=3Dscratch'

David
---
# ./check -E .exclude generic/604 generic/633 generic/645 generic/696 gene=
ric/697 generic/732
FSTYP         -- ceph
PLATFORM      -- Linux/x86_64 andromeda 6.13.0-rc2-build3+ #5311 SMP Fri D=
ec 13 09:03:34 GMT 2024
MKFS_OPTIONS  -- <ipaddr>:/scratch
MOUNT_OPTIONS -- -o name=3Dadmin,mds_namespace=3Dscratch,fs=3Dscratch,fsc=3D=
scratch -o context=3Dsystem_u:object_r:root_t:s0 <ipaddr>:/scratch /xfstes=
t.scratch

generic/604 2s ... [failed, exit status 1]- output mismatch (see /root/xfs=
tests-dev/results//generic/604.out.bad)
    --- tests/generic/604.out   2024-09-12 12:36:14.187441830 +0100
    +++ /root/xfstests-dev/results//generic/604.out.bad 2024-12-13 13:18:5=
1.910900871 +0000
    @@ -1,2 +1,4 @@
     QA output created by 604
    -Silence is golden
    +mount error 16 =3D Device or resource busy
    +mount -o name=3Dadmin,mds_namespace=3Dscratch,fs=3Dscratch,fsc=3Dscra=
tch -o context=3Dsystem_u:object_r:root_t:s0 <ipaddr>:/scratch /xfstest.sc=
ratch failed
    +(see /root/xfstests-dev/results//generic/604.full for details)
    ...
    (Run 'diff -u /root/xfstests-dev/tests/generic/604.out /root/xfstests-=
dev/results//generic/604.out.bad'  to see the entire diff)
generic/633       [failed, exit status 1]- output mismatch (see /root/xfst=
ests-dev/results//generic/633.out.bad)
    --- tests/generic/633.out   2024-09-12 12:36:14.187441830 +0100
    +++ /root/xfstests-dev/results//generic/633.out.bad 2024-12-13 13:18:5=
5.958979531 +0000
    @@ -1,2 +1,4 @@
     QA output created by 633
     Silence is golden
    +idmapped-mounts.c: 307: tcore_create_in_userns - Input/output error -=
 failure: open file
    +vfstest.c: 2418: run_test - Success - failure: create operations in u=
ser namespace
    ...
    (Run 'diff -u /root/xfstests-dev/tests/generic/633.out /root/xfstests-=
dev/results//generic/633.out.bad'  to see the entire diff)
generic/645       [failed, exit status 1]- output mismatch (see /root/xfst=
ests-dev/results//generic/645.out.bad)
    --- tests/generic/645.out   2024-09-12 12:36:14.191441810 +0100
    +++ /root/xfstests-dev/results//generic/645.out.bad 2024-12-13 13:19:2=
5.526908024 +0000
    @@ -1,2 +1,4 @@
     QA output created by 645
     Silence is golden
    +idmapped-mounts.c: 6671: nested_userns - Invalid argument - failure: =
sys_mount_setattr
    +vfstest.c: 2418: run_test - Invalid argument - failure: test that nes=
ted user namespaces behave correctly when attached to idmapped mounts
    ...
    (Run 'diff -u /root/xfstests-dev/tests/generic/645.out /root/xfstests-=
dev/results//generic/645.out.bad'  to see the entire diff)
generic/696       - output mismatch (see /root/xfstests-dev/results//gener=
ic/696.out.bad)
    --- tests/generic/696.out   2024-09-12 12:36:14.195441791 +0100
    +++ /root/xfstests-dev/results//generic/696.out.bad 2024-12-13 13:19:3=
0.254804087 +0000
    @@ -1,2 +1,6 @@
     QA output created by 696
    +idmapped-mounts.c: 7763: setgid_create_umask_idmapped - Input/output =
error - failure: create
    +vfstest.c: 2418: run_test - Success - failure: create operations by u=
sing umask in directories with setgid bit set on idmapped mount
    +idmapped-mounts.c: 7763: setgid_create_umask_idmapped - Input/output =
error - failure: create
    +vfstest.c: 2418: run_test - Success - failure: create operations by u=
sing umask in directories with setgid bit set on idmapped mount
     Silence is golden
    ...
    (Run 'diff -u /root/xfstests-dev/tests/generic/696.out /root/xfstests-=
dev/results//generic/696.out.bad'  to see the entire diff)

HINT: You _MAY_ be missing kernel fix:
      ac6800e279a2 fs: Add missing umask strip in vfs_tmpfile 1639a49ccdce=
 fs: move S_ISGID stripping into the vfs_*() helpers

generic/697       - output mismatch (see /root/xfstests-dev/results//gener=
ic/697.out.bad)
    --- tests/generic/697.out   2024-09-12 12:36:14.195441791 +0100
    +++ /root/xfstests-dev/results//generic/697.out.bad 2024-12-13 13:19:3=
1.749225548 +0000
    @@ -1,2 +1,4 @@
     QA output created by 697
    +idmapped-mounts.c: 8218: setgid_create_acl_idmapped - Input/output er=
ror - failure: create
    +vfstest.c: 2418: run_test - Success - failure: create operations by u=
sing acl in directories with setgid bit set on idmapped mount
     Silence is golden
    ...
    (Run 'diff -u /root/xfstests-dev/tests/generic/697.out /root/xfstests-=
dev/results//generic/697.out.bad'  to see the entire diff)

HINT: You _MAY_ be missing kernel fix:
      1639a49ccdce fs: move S_ISGID stripping into the vfs_*() helpers

generic/732 1s ... [failed, exit status 1]- output mismatch (see /root/xfs=
tests-dev/results//generic/732.out.bad)
    --- tests/generic/732.out   2024-09-12 12:36:14.195441791 +0100
    +++ /root/xfstests-dev/results//generic/732.out.bad 2024-12-13 13:19:3=
4.482858235 +0000
    @@ -1,2 +1,5 @@
     QA output created by 732
     Silence is golden
    +mount error 16 =3D Device or resource busy
    +mount -o name=3Dadmin,mds_namespace=3Dscratch,fs=3Dscratch,fsc=3Dscra=
tch -o context=3Dsystem_u:object_r:root_t:s0 <ipaddr>:/scratch /xfstest.te=
st/mountpoint2-732 failed
    +(see /root/xfstests-dev/results//generic/732.full for details)
    ...
    (Run 'diff -u /root/xfstests-dev/tests/generic/732.out /root/xfstests-=
dev/results//generic/732.out.bad'  to see the entire diff)
Ran: generic/604 generic/633 generic/645 generic/696 generic/697 generic/7=
32
Failures: generic/604 generic/633 generic/645 generic/696 generic/697 gene=
ric/732
Failed 6 of 6 tests


