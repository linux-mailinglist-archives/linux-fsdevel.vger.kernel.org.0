Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A47E64A63DF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Feb 2022 19:33:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237999AbiBAScQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Feb 2022 13:32:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:48574 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233106AbiBAScP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Feb 2022 13:32:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643740335;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TZGPu0c4d8zM+GPEdhVnS2gfnUOmYVJ4nIlDhy1/n6A=;
        b=i9qm8iN/taRdnfPDsgjB54DeUy5lJnjIAlg5rCJ1WwXEJeCkMeprLHc4Mfh469SoMLj3vs
        3yFBVbvFQyTIs55g0EVJkgnVxNIoTFJxtEpGlTP13lu11HMnelwtXFLwd0M+VDzv3VUntM
        cbmDpkS+zPL82PMT0GCJReDDrlg4a24=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-451-_BYmkupWO1qxJJWnnqHHaw-1; Tue, 01 Feb 2022 13:32:12 -0500
X-MC-Unique: _BYmkupWO1qxJJWnnqHHaw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7A8E82F7DF;
        Tue,  1 Feb 2022 18:32:07 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A93EA798D8;
        Tue,  1 Feb 2022 18:31:52 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id 211IVqOM019366;
        Tue, 1 Feb 2022 13:31:52 -0500
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id 211IVpQx019362;
        Tue, 1 Feb 2022 13:31:51 -0500
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Tue, 1 Feb 2022 13:31:51 -0500 (EST)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     =?ISO-8859-15?Q?Javier_Gonz=E1lez?= <javier@javigon.com>
cc:     Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        "msnitzer@redhat.com >> msnitzer@redhat.com" <msnitzer@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "martin.petersen@oracle.com >> Martin K. Petersen" 
        <martin.petersen@oracle.com>,
        "roland@purestorage.com" <roland@purestorage.com>,
        Hannes Reinecke <hare@suse.de>,
        "kbus @imap.gmail.com>> Keith Busch" <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        "Frederick.Knight@netapp.com" <Frederick.Knight@netapp.com>,
        "zach.brown@ni.com" <zach.brown@ni.com>,
        "osandov@fb.com" <osandov@fb.com>,
        "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "clm@fb.com" <clm@fb.com>, "dsterba@suse.com" <dsterba@suse.com>,
        "tytso@mit.edu" <tytso@mit.edu>, "jack@suse.com" <jack@suse.com>,
        Kanchan Joshi <joshi.k@samsung.com>
Subject: [RFC PATCH 0/3] NVMe copy offload patches
In-Reply-To: <20220201102122.4okwj2gipjbvuyux@mpHalley-2>
Message-ID: <alpine.LRH.2.02.2202011327350.22481@file01.intranet.prod.int.rdu2.redhat.com>
References: <f0e19ae4-b37a-e9a3-2be7-a5afb334a5c3@nvidia.com> <20220201102122.4okwj2gipjbvuyux@mpHalley-2>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi

Here I'm submitting the first version of NVMe copy offload patches as a
request for comment. They use the token-based approach as we discussed on
the phone call.

The first patch adds generic copy offload support to the block layer - it
adds two new bio types (REQ_OP_COPY_READ_TOKEN and
REQ_OP_COPY_WRITE_TOKEN) and a new ioctl BLKCOPY and a kernel function
blkdev_issue_copy.

The second patch adds copy offload support to the NVMe subsystem.

The third patch implements a "nvme-debug" driver - it is similar to
"scsi-debug", it simulates a nvme host controller, it keeps data in memory
and it supports copy offload according to NVMe Command Set Specification
1.0a. (there are no hardware or software implementations supporting copy
offload so far, so I implemented it in nvme-debug)

TODO:
* implement copy offload in device mapper linear target
* implement copy offload in software NVMe target driver
* make it possible to complete REQ_OP_COPY_WRITE_TOKEN bios asynchronously
* should we use copy_file_range instead of a new ioctl?

How to test this:
* apply the three patches
* select CONFIG_NVME_DEBUG
* compile the kernel
* modprobe nvme-debug; nvme connect -t debug -a 123 -n 456
* issue the BLKCOPY ioctl on /dev/nvme0n1, for example, you can use this
  program:
  http://people.redhat.com/~mpatocka/patches/kernel/xcopy/example/blkcopy.c

Mikulas

