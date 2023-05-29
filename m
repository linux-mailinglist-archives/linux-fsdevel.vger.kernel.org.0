Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FB1A7150D0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 May 2023 23:00:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbjE2VAi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 May 2023 17:00:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjE2VAg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 May 2023 17:00:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 882FCCF
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 May 2023 13:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685393984;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=TG7jU4+XGYQuL0XuBiCQmMRoFx4/ZFsSetkTfBuHth4=;
        b=WmyiVOuRmPqGAXqV62jrKu05BokXHjBAbPad/nuKBUOJc5NtBLagRAleNCnujLDCMgQHRh
        ABzOcKD12kaN4ytW73uPgPjyTd9hZCOLkV7lDaO42BrSMMiQ9SlgYW1pilbVbQgQKnZ7s9
        jNWwetO6+iua/6EKvhs43/pJWeoR//Y=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-313-MfwVcm-sO6SEtJtRQMzV_Q-1; Mon, 29 May 2023 16:59:41 -0400
X-MC-Unique: MfwVcm-sO6SEtJtRQMzV_Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 183991C06EC8;
        Mon, 29 May 2023 20:59:41 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0CD1B112132C;
        Mon, 29 May 2023 20:59:41 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id 34TKxeFj026289;
        Mon, 29 May 2023 16:59:40 -0400
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id 34TKxe2E026285;
        Mon, 29 May 2023 16:59:40 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Mon, 29 May 2023 16:59:40 -0400 (EDT)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Kent Overstreet <kent.overstreet@linux.dev>
cc:     linux-bcachefs@vger.kernel.org, dm-devel@redhat.com,
        linux-fsdevel@vger.kernel.org
Subject: fuzzing bcachefs with dm-flakey
Message-ID: <alpine.LRH.2.21.2305260915400.12513@file01.intranet.prod.int.rdu2.redhat.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi

I improved the dm-flakey device mapper target, so that it can do random 
corruption of read and write bios - I uploaded it here: 
https://people.redhat.com/~mpatocka/testcases/bcachefs/dm-flakey.c

I set up dm-flakey, so that it corrupts 10% of read bios and 10% of write 
bios with this command:
dmsetup create flakey --table "0 `blockdev --getsize /dev/ram0` flakey /dev/ram0 0 0 1 4 random_write_corrupt 100000000 random_read_corrupt 100000000"


I created a bcachefs volume on a single disk (metadata and data checksums 
were turned off) and mounted it on dm-flakey. I got:

crash: https://people.redhat.com/~mpatocka/testcases/bcachefs/crash1.txt
deadlock: https://people.redhat.com/~mpatocka/testcases/bcachefs/crash2.txt
infinite loop: https://people.redhat.com/~mpatocka/testcases/bcachefs/crash3.txt

Here I uploaded an image that causes infnite loop when we run bcachefs 
fsck on it or when we attempt mount it:
https://people.redhat.com/~mpatocka/testcases/bcachefs/inf-loop.gz


I tried to run bcachefs on two block devices and fuzzing just one of them 
(checksums and replication were turned on - so bcachefs shold correct the 
corrupted data) - in this scenario, bcachefs doesn't return invalid data, 
but it sometimes returns errors and sometimes crashes.

This script will trigger an oops on unmount:
	https://people.redhat.com/~mpatocka/testcases/bcachefs/crash4.txt
or nonsensical errors returned to userspace:
	rm: cannot remove '/mnt/test/test/cmd_migrate.c': Unknown error 2206
or I/O errors returned to userspace:
	diff: /mnt/test/test/rust-src/target/release/.fingerprint/bch_bindgen-f0bad16858ff0019/lib-bch_bindgen.json: Input/output error

#!/bin/sh -ex
umount /mnt/test || true
dmsetup remove_all || true
rmmod brd || true
SRC=/usr/src/git/bcachefs-tools
while true; do
        modprobe brd rd_size=1048576
        bcachefs format --replicas=2 /dev/ram0 /dev/ram1
        dmsetup create flakey --table "0 `blockdev --getsize /dev/ram0` linear /dev/ram0 0"
        mount -t bcachefs /dev/mapper/flakey:/dev/ram1 /mnt/test
        dmsetup load flakey --table "0 `blockdev --getsize /dev/ram0` flakey /dev/ram0 0 0 1 4 random_write_corrupt 100000000 random_read_corrupt 100000000"
        dmsetup suspend flakey
        dmsetup resume flakey
        cp -a "$SRC" /mnt/test/test
        diff -r "$SRC" /mnt/test/test
        echo 3 >/proc/sys/vm/drop_caches
        diff -r "$SRC" /mnt/test/test
        echo 3 >/proc/sys/vm/drop_caches
        diff -r "$SRC" /mnt/test/test
        echo 3 >/proc/sys/vm/drop_caches
        rm -rf /mnt/test/test
        echo 3 >/proc/sys/vm/drop_caches
        cp -a "$SRC" /mnt/test/test
        echo 3 >/proc/sys/vm/drop_caches
        diff -r "$SRC" /mnt/test/test
        umount /mnt/test
        dmsetup remove flakey
        rmmod brd
done

The oops happens in set_btree_iter_dontneed and it is caused by the fact 
that iter->path is NULL. The code in try_alloc_bucket is buggy because it 
sets "struct btree_iter iter = { NULL };" and then jumps to the "err" 
label that tries to dereference values in "iter".


Bcachefs gives not much usefull error messages, like "Fatal error: Unknown 
error 2184" or "Error in recovery: cannot allocate memory" or "mount(2) 
system call failed: Unknown error 2186." or "rm: cannot remove 
'/mnt/test/xfstests-dev/tools/fs-walk': Unknown error 2206".

Mikulas

