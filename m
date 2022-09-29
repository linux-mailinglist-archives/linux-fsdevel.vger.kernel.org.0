Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 992495EF950
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Sep 2022 17:42:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234778AbiI2Pmt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Sep 2022 11:42:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230349AbiI2PmV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Sep 2022 11:42:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19A6D4D178
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Sep 2022 08:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664466093;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=d6dmokZDm5kVDQlkFm4C1MuGfv3oJNgAvYSSmFlb+ok=;
        b=Imz2NuKirHnSfdm+N5Z1DRh8cz6YxteEtUlg2aqKzeOWOiJJtN/RN0DmiDSu+NzUSH2IAV
        cQNdA6n7kvt/yTW5t1kgpNRZ2tuiBz8elG5eBO7AqHPeYglOdbZbclFTStWytGGMurAN2Y
        DjR4/5xijKcpMsLWdN3gWK/FXzc7LOQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-403-pYZ6JNfZPDaQr7OC8gPKcw-1; Thu, 29 Sep 2022 11:41:30 -0400
X-MC-Unique: pYZ6JNfZPDaQr7OC8gPKcw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F0D10801231;
        Thu, 29 Sep 2022 15:41:26 +0000 (UTC)
Received: from starship (unknown [10.40.193.233])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 210062166B2D;
        Thu, 29 Sep 2022 15:41:24 +0000 (UTC)
Message-ID: <fb869c88bd48ea9018e1cc349918aa7cdd524931.camel@redhat.com>
Subject: Commit 'iomap: add support for dma aligned direct-io' causes
 qemu/KVM boot failures
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>, qemu-devel@nongnu.org,
        kvm@vger.kernel.org
Date:   Thu, 29 Sep 2022 18:41:23 +0300
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi!
 
Recently I noticed that this commit broke the boot of some of the VMs that I run on my dev machine.
 
It seems that I am not the first to notice this but in my case it is a bit different
 
https://lore.kernel.org/all/e0038866ac54176beeac944c9116f7a9bdec7019.camel@linux.ibm.com/
 
My VM is a normal x86 VM, and it uses virtio-blk in the guest to access the virtual disk,
which is a qcow2 file stored on ext4 filesystem which is stored on NVME drive with 4K sectors.
(however I was also able to reproduce this on a raw file)
 
It seems that the only two things that is needed to reproduce the issue are:
 
1. The qcow2/raw file has to be located on a drive which has 4K hardware block size.
2. Qemu needs to use direct IO (both aio and 'threads' reproduce this). 
 
I did some debugging and I isolated the kernel change in behavior from qemu point of view:
 
 
Qemu, when using direct IO, 'probes' the underlying file.
 
It probes two things:
 
1. It probes the minimum block size it can read.
   It does so by trying to read 1, 512, 1024, 2048 and 4096 bytes at offset 0,
   using a 4096 bytes aligned buffer, and notes the first read that works as the hardware block size.
 
   (The relevant function is 'raw_probe_alignment' in src/block/file-posix.c in qemu source code).
 
 
2. It probes the buffer alignment by reading 4096 bytes also at file offset 0,
   this time using a buffer that is 1, 512, 1024, 2048 and 4096 aligned
   (this is done by allocating a buffer which is 4K aligned and adding 1/512 and so on to its address)
 
   First successful read is saved as the required buffer alignment. 
 
 
Before the patch, both probes would yield 4096 and everything would work fine.
(The file in question is stored on 4K block device)
 
 
After the patch the buffer alignment probe succeeds at 512 bytes.
This means that the kernel now allows to read 4K of data at file offset 0 with a buffer that
is only 512 bytes aligned. 
 
It is worth to note that the probe was done using 'pread' syscall.
 
 
Later on, qemu likely reads the 1st 512 sector of the drive.
 
It uses preadv with 2 io vectors:
 
First one is for 512 bytes and it seems to have 0xC00 offset into page 
(likely depends on debug session but seems to be consistent)
 
Second one is for 3584 bytes and also has a buffer that is not 4K aligned.
(0x200 page offset this time)
 
This means that the qemu does respect the 4K block size but only respects 512 bytes buffer alignment,
which is consistent with the result of the probing.
 
And that preadv fails with -EINVAL
 
Forcing qemu to use 4K buffer size fixes the issue, as well as reverting the offending commit.
 
Any patches, suggestions are welcome.

I use 6.0-rc7, using mainline master branch as yesterday.
 
Best regards,
	Maxim Levitsky

