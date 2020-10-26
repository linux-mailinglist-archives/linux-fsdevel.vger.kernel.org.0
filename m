Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD2B6298F38
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Oct 2020 15:26:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1781234AbgJZO0k (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Oct 2020 10:26:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51726 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1781114AbgJZO0i (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Oct 2020 10:26:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603722397;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xfE6+y8FI3nXMcbyiEy/OA7HElfZ92oyXvEkZ8IqGL0=;
        b=Y15rpl9QaBLPQNha2Uc9mhwRkKJP088XEHdOuSWRn6PK7MP576MRk57zRY2xH6DArU03Z2
        qXyaat4klXFqhTPMyM2El5gz1hzmx/Bb2ghPi8pVA2tmD55SEacFTh8eVgQUAUAzt9d7ux
        zn00crBBav2r+1zGy4xi7Jb/7QkDsgk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-585-tdYJWIHFMa-ZhfWBH1vsNw-1; Mon, 26 Oct 2020 10:26:30 -0400
X-MC-Unique: tdYJWIHFMa-ZhfWBH1vsNw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A9CDB803F4B;
        Mon, 26 Oct 2020 14:26:28 +0000 (UTC)
Received: from ovpn-113-173.rdu2.redhat.com (ovpn-113-173.rdu2.redhat.com [10.10.113.173])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5A0E85C629;
        Mon, 26 Oct 2020 14:26:27 +0000 (UTC)
Message-ID: <aa3dfe1f9705f02197f9a75b60d4c28cc97ddff4.camel@redhat.com>
Subject: Re: kernel BUG at mm/page-writeback.c:2241 [
 BUG_ON(PageWriteback(page); ]
From:   Qian Cai <cai@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, Matthew Wilcox <willy@infradead.org>,
        Jan Kara <jack@suse.cz>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Date:   Mon, 26 Oct 2020 10:26:26 -0400
In-Reply-To: <d06d3d2a-7032-91da-35fa-a9dee4440a14@kernel.dk>
References: <645a3f332f37e09057c10bc32f4f298ce56049bb.camel@lca.pw>
         <20201022004906.GQ20115@casper.infradead.org>
         <20201026094948.GA29758@quack2.suse.cz>
         <20201026131353.GP20115@casper.infradead.org>
         <d06d3d2a-7032-91da-35fa-a9dee4440a14@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2020-10-26 at 07:55 -0600, Jens Axboe wrote:
> I've tried to reproduce this as well, to no avail. Qian, could you perhaps
> detail the setup? What kind of storage, kernel config, compiler, etc.
> 

So far I have only been able to reproduce on this Intel platform:

HPE DL560 gen10
Intel(R) Xeon(R) Gold 6154 CPU @ 3.00GHz
131072 MB memory, 1000 GB disk space (smartpqi nvme)

It was running some CPU and memory hotplug, KVM and then LTP workloads
(syscalls, mm, and fs). Finally, it was always this LTP test case to trigger it:

# export LTPROOT; rwtest -N iogen01 -i 120s -s read,write -Da -Dv -n 2 500b:$TMPDIR/doio.f1.$$ 1000b:$TMPDIR/doio.f2.$$
https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/fs/doio/rwtest

gcc-8.3.1-5.1.el8.x86_64
.config: https://git.code.tencent.com/cail/linux-mm/blob/master/x86.config


== storage information == 
[   46.131150] smartpqi 0000:23:00.0: Online Firmware Activation enabled
[   46.138495] smartpqi 0000:23:00.0: Serial Management Protocol enabled
[   46.145701] smartpqi 0000:23:00.0: New Soft Reset Handshake enabled
[   46.152705] smartpqi 0000:23:00.0: RAID IU Timeout enabled
[   46.158934] smartpqi 0000:23:00.0: TMF IU Timeout enabled
[   46.168740] scsi host0: smartpqi
[   47.750425] nvme nvme1: 31/0/0 default/read/poll queues
[   47.826211] scsi 0:0:0:0: Direct-Access     ATA      MM1000GEFQV      HPG8 PQ: 0 ANSI: 6
[   47.841752] smartpqi 0000:23:00.0: added 0:0:0:0 0000000000000000 Direct-Access     ATA      MM1000GEFQV      AIO+ qd=32    
[   47.941249]  nvme1n1: p1
[   47.943078] scsi 0:0:1:0: Enclosure         HPE      Smart Adapter    2.62 PQ: 0 ANSI: 5
[   47.958506] smartpqi 0000:23:00.0: added 0:0:1:0 51402ec001f36448 Enclosure         HPE      Smart Adapter    AIO-
[   47.962844] nvme nvme0: 31/0/0 default/read/poll queues
[   48.015511] scsi 0:2:0:0: RAID              HPE      P408i-a SR Gen10 2.62 PQ: 0 ANSI: 5
[   48.029736] smartpqi 0000:23:00.0: added 0:2:0:0 0000000000000000 RAID              HPE      P408i-a SR Gen10 
[   48.042711] smartpqi 0000:4e:00.0: Microsemi Smart Family Controller found
[   48.149820]  nvme0n1: p1
[   48.956194] smartpqi 0000:4e:00.0: Online Firmware Activation enabled
[   48.963399] smartpqi 0000:4e:00.0: Serial Management Protocol enabled
[   48.970625] smartpqi 0000:4e:00.0: New Soft Reset Handshake enabled
[   48.977645] smartpqi 0000:4e:00.0: RAID IU Timeout enabled
[   48.983873] smartpqi 0000:4e:00.0: TMF IU Timeout enabled
[   48.994687] scsi host1: smartpqi
[   50.612955] scsi 1:0:0:0: Enclosure         HPE      Smart Adapter    2.62 PQ: 0 ANSI: 5
[   50.628219] smartpqi 0000:4e:00.0: added 1:0:0:0 51402ec01040ffc8 Enclosure         HPE      Smart Adapter    AIO-
[   50.681859] scsi 1:2:0:0: RAID              HPE      E208i-p SR Gen10 2.62 PQ: 0 ANSI: 5
[   50.695843] smartpqi 0000:4e:00.0: added 1:2:0:0 0000000000000000 RAID              HPE      E208i-p SR Gen10 
[   50.856683] sd 0:0:0:0: [sda] 1953525168 512-byte logical blocks: (1.00 TB/932 GiB)
[   50.865195] sd 0:0:0:0: [sda] 4096-byte physical blocks
[   50.871354] sd 0:0:0:0: [sda] Write Protect is off
[   50.876956] sd 0:0:0:0: [sda] Mode Sense: 46 00 10 08
[   50.877299] sd 0:0:0:0: [sda] Write cache: disabled, read cache: enabled, supports DPO and FUA
[   50.898824]  sda: sda1 sda2 sda3
[   50.943835] sd 0:0:0:0: [sda] Attached SCSI disk

