Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0D764D2AEF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Mar 2022 09:52:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231521AbiCIIxG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Mar 2022 03:53:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231585AbiCIIwv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Mar 2022 03:52:51 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C26A216201C
        for <linux-fsdevel@vger.kernel.org>; Wed,  9 Mar 2022 00:51:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646815912;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TELtE/TvhBTmc9AcQH+J/FPyzAIaQTdybvoTEfYZI7Y=;
        b=X5hZQrWTY8LlbpAIJVUyymavCGqHEqnPBwHuxrfc+wVeh7aoJoWQF4XXO1Up+qZzpzH7RC
        2aAU0kr1KHgqh8YVEM1KpqbnWrWNcAwObjE3qNWzzCkPMQw13YcAZM+NZ3IXd9vAL0L/9D
        90gkZkSqwzV79n0mc5I/wN9d9H8oZko=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-483-V9um9J1zMVaV3d3evW_INQ-1; Wed, 09 Mar 2022 03:51:49 -0500
X-MC-Unique: V9um9J1zMVaV3d3evW_INQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 432A81091DA1;
        Wed,  9 Mar 2022 08:51:45 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D016083168;
        Wed,  9 Mar 2022 08:51:43 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id 2298pgJ3020462;
        Wed, 9 Mar 2022 03:51:42 -0500
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id 2298pfEp020453;
        Wed, 9 Mar 2022 03:51:41 -0500
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Wed, 9 Mar 2022 03:51:41 -0500 (EST)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Nikos Tsironis <ntsironis@arrikto.com>
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
        "tytso@mit.edu" <tytso@mit.edu>, "jack@suse.com" <jack@suse.com>
Subject: Re: [LSF/MM/BFP ATTEND] [LSF/MM/BFP TOPIC] Storage: Copy Offload
In-Reply-To: <23895da7-bcec-d092-373a-c3d961ab5c48@arrikto.com>
Message-ID: <alpine.LRH.2.02.2203090347500.17712@file01.intranet.prod.int.rdu2.redhat.com>
References: <f0e19ae4-b37a-e9a3-2be7-a5afb334a5c3@nvidia.com> <012723a9-2e9c-c638-4944-fa560e1b0df0@arrikto.com> <c4124f39-1ee9-8f34-e731-42315fee15f9@nvidia.com> <23895da7-bcec-d092-373a-c3d961ab5c48@arrikto.com>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="185206533-1881345822-1646815902=:17712"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--185206533-1881345822-1646815902=:17712
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Tue, 8 Mar 2022, Nikos Tsironis wrote:

> My work focuses mainly on improving the IOPs and latency of the
> dm-snapshot target, in order to bring the performance of short-lived
> snapshots as close as possible to bare-metal performance.
> 
> My initial performance evaluation of dm-snapshot had revealed a big
> performance drop, while the snapshot is active; a drop which is not
> justified by COW alone.
> 
> Using fio with blktrace I had noticed that the per-CPU I/O distribution
> was uneven. Although many threads were doing I/O, only a couple of the
> CPUs ended up submitting I/O requests to the underlying device.
> 
> The same issue also affects dm-clone, when doing I/O with sizes smaller
> than the target's region size, where kcopyd is used for COW.
> 
> The bottleneck here is kcopyd serializing all I/O. Users of kcopyd, such
> as dm-snapshot and dm-clone, cannot take advantage of the increased I/O
> parallelism that comes with using blk-mq in modern multi-core systems,
> because I/Os are issued only by a single CPU at a time, the one on which
> kcopyd’s thread happens to be running.
> 
> So, I experimented redesigning kcopyd to prevent I/O serialization by
> respecting thread locality for I/Os and their completions. This made the
> distribution of I/O processing uniform across CPUs.
> 
> My measurements had shown that scaling kcopyd, in combination with
> scaling dm-snapshot itself [1] [2], can lead to an eventual performance
> improvement of ~300% increase in sustained throughput and ~80% decrease
> in I/O latency for transient snapshots, over the null_blk device.
> 
> The work for scaling dm-snapshot has been merged [1], but,
> unfortunately, I haven't been able to send upstream my work on kcopyd
> yet, because I have been really busy with other things the last couple
> of years.
> 
> I haven't looked into the details of copy offload yet, but it would be
> really interesting to see how it affects the performance of random and
> sequential workloads, and to check how, and if, scaling kcopyd affects
> the performance, in combination with copy offload.
> 
> Nikos

Hi

Note that you must submit kcopyd callbacks from a single thread, otherwise 
there's a race condition in snapshot.

The snapshot code doesn't take locks in the copy_callback and it expects 
that the callbacks are serialized.

Maybe, adding the locks to copy_callback would solve it.

Mikulas
--185206533-1881345822-1646815902=:17712--

