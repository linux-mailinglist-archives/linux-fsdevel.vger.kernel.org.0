Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F51D6F0289
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Apr 2023 10:28:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243091AbjD0I1n (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Apr 2023 04:27:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbjD0I1m (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Apr 2023 04:27:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 534C349D5
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Apr 2023 01:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682584017;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=l6syDLggRiYjAStI+X0+pQOosy+q7w0nb4goYRoZwCE=;
        b=FOk/g0ZhAf/spVgB2y/8N0I9bvV1LJvAQLy8Afj8UhcZ6Qlj5L2JrjOUMPmp0gEQneddc/
        PeCytoZp+rE0rCSVMlxP+rGn4GUP278c/OXWSmDkMps8hM+AXhylvo+rGP5+GwFRlElRNj
        MMS7ri3lSHriWDEAsuVLoLe0xKh32q8=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-372-dI1KEEV-NJOdULEjrzKuFQ-1; Thu, 27 Apr 2023 04:26:56 -0400
X-MC-Unique: dI1KEEV-NJOdULEjrzKuFQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CA5773C10C74;
        Thu, 27 Apr 2023 08:26:55 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.174])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0E1951121314;
        Thu, 27 Apr 2023 08:26:54 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
To:     Steve French <sfrench@samba.org>
cc:     dhowells@redhat.com, fstests@vger.kernel.org,
        linux-cifs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Weird behaviour with cifs in xfstests shutdown tests
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <971804.1682584013.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Thu, 27 Apr 2023 09:26:53 +0100
Message-ID: <971805.1682584013@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I'm seeing some failures running xfstests on cifs when it comes to tests t=
hat
do a shutdown of the filesystem, generic/392 for example:

generic/392       [failed, exit status 1]- output mismatch (see /root/xfst=
ests-dev/results//smb3/generic/392.out.bad)
    --- tests/generic/392.out   2021-05-25 13:27:50.000000000 +0100
    +++ /root/xfstests-dev/results//smb3/generic/392.out.bad    2023-04-27=
 09:07:42.402657080 +0100
    @@ -1,11 +1,67 @@
     QA output created by 392
     =3D=3D=3D=3D i_size 1024 test with fsync =3D=3D=3D=3D
    +stat: cannot statx '/xfstest.scratch/testfile': Input/output error
    +Before:  "b: 8194 s: 4195328 a: 2023-04-27 09:07:39.410675400 +0100 m=
: 2023-04-27 09:07:39.410675400 +0100 c: 2023-04-27 09:07:39.410675400 +01=
00"
    +After : =

    +rm: cannot remove '/xfstest.scratch/testfile': Input/output error
     =3D=3D=3D=3D i_size 4096 test with fsync =3D=3D=3D=3D
    ...
    (Run 'diff -u /root/xfstests-dev/tests/generic/392.out /root/xfstests-=
dev/results//smb3/generic/392.out.bad'  to see the entire diff)

The problem appears to be that the CIFS_MOUNT_SHUTDOWN persists if there's
another cifs mount from the same server present.  So in generic/392 it doe=
s:

	before=3D`stat "$stat_opt" $testfile`

	$XFS_IO_PROG -c "$sync_mode" $testfile | _filter_xfs_io
	_scratch_shutdown | tee -a $seqres.full
	_scratch_cycle_mount

	after=3D`stat "$stat_opt" $testfile`

which cycles the *scratch* mount, but leaves the test mount still mounted =
and
then the 'after' stat fails with EIO.

Testing this by hand:

  mount //192.168.6.1/scratch /xfstest.scratch/ -o user=3Dshares,pass=3D..=
.;\
  touch /xfstest.scratch/testfile; \
  stat /xfstest.scratch/testfile; \
  ./src/godown /xfstest.scratch/; \
  umount /xfstest.scratch/; \
  mount //192.168.6.1/scratch /xfstest.scratch/ -o user=3Dshares,pass=3D..=
.; \
  stat /xfstest.scratch/testfile

works, but will fail if I do:

  mount //192.168.6.1/test /xfstest.test/ -o user=3Dshares,pass=3D...;

first.

Interestingly, the two mounts have different device numbers according to s=
tat,
so they would appear to have different superblocks.

David

