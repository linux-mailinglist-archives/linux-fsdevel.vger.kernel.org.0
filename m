Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2CB210F4EF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Dec 2019 03:24:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726319AbfLCCX7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Dec 2019 21:23:59 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53811 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725954AbfLCCX7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Dec 2019 21:23:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575339838;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=O0EX3vVcvGDZXblDe7Rv/FsS5mhTO0YUbuVmRSPhwMA=;
        b=JOfNcYP+tQLdE4QsiUXNjjhhJ7qei9NVmFOCzyJuMMcCkN+TkDyY8K/L3poDUxkNMXUvHc
        L4oRMqPqH3LjuKwO5FUijqMNUi1si1oT1BdE54gRE9dnPP5AgTpzEBGGtWu10WdSliG0xV
        eyAyQQ83IIACz6AjGPGCt9AJqFVx8CI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-368-2M_xvtKyM3isUt9S-04QCw-1; Mon, 02 Dec 2019 21:23:55 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7833CDB62;
        Tue,  3 Dec 2019 02:23:52 +0000 (UTC)
Received: from ming.t460p (ovpn-8-19.pek2.redhat.com [10.72.8.19])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9E10B10016DA;
        Tue,  3 Dec 2019 02:23:41 +0000 (UTC)
Date:   Tue, 3 Dec 2019 10:23:37 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Andrea Vai <andrea.vai@unipv.it>
Cc:     "Schmid, Carsten" <Carsten_Schmid@mentor.com>,
        Finn Thain <fthain@telegraphics.com.au>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Jens Axboe <axboe@kernel.dk>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        USB list <linux-usb@vger.kernel.org>,
        SCSI development list <linux-scsi@vger.kernel.org>,
        Himanshu Madhani <himanshu.madhani@cavium.com>,
        Hannes Reinecke <hare@suse.com>,
        Omar Sandoval <osandov@fb.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Hans Holmberg <Hans.Holmberg@wdc.com>,
        Kernel development list <linux-kernel@vger.kernel.org>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Theodore Ts'o <tytso@mit.edu>
Subject: Re: AW: Slow I/O on USB media after commit
 f664a3cc17b7d0a2bc3b3ab96181e1029b0ec0e6
Message-ID: <20191203022337.GE25002@ming.t460p>
References: <20191126023253.GA24501@ming.t460p>
 <0598fe2754bf0717d81f7e72d3e9b3230c608cc6.camel@unipv.it>
 <alpine.LNX.2.21.1.1911271055200.8@nippy.intranet>
 <cb6e84781c4542229a3f31572cef19ab@SVR-IES-MBX-03.mgc.mentorg.com>
 <c1358b840b3a4971aa35a25d8495c2c8953403ea.camel@unipv.it>
 <20191128091712.GD15549@ming.t460p>
 <f82fd5129e3dcacae703a689be60b20a7fedadf6.camel@unipv.it>
 <20191129005734.GB1829@ming.t460p>
 <20191129023555.GA8620@ming.t460p>
 <320b315b9c87543d4fb919ecbdf841596c8fbcea.camel@unipv.it>
MIME-Version: 1.0
In-Reply-To: <320b315b9c87543d4fb919ecbdf841596c8fbcea.camel@unipv.it>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: 2M_xvtKyM3isUt9S-04QCw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 29, 2019 at 03:41:01PM +0100, Andrea Vai wrote:
> Il giorno ven, 29/11/2019 alle 10.35 +0800, Ming Lei ha scritto:
> > On Fri, Nov 29, 2019 at 08:57:34AM +0800, Ming Lei wrote:
> >=20
> > > [...]
> >=20
> > > Andrea, can you collect the following log when running the test
> > > on current new(bad) kernel?
> > >=20
> > > =09/usr/share/bcc/tools/stackcount  -K blk_mq_make_request
> >=20
> > Instead, please run the following trace, given insert may be
> > called from other paths, such as flush plug:
> >=20
> > =09/usr/share/bcc/tools/stackcount -K t:block:block_rq_insert
>=20
> Attached, for new (patched) bad kernel.
>=20
> Produced by: start the trace script (with the pendrive already
> plugged), wait some seconds, run the test (1 trial, 1 GB), wait for
> the test to finish, stop the trace.
>=20
> The copy took ~1700 seconds.

See the two path[1][2] of inserting request, and path[1] is triggered
4358 times, and the path[2] is triggered 5763 times.

The path[2] is expected behaviour. Not sure path [1] is correct, given
ext4_release_file() is supposed to be called when this inode is
released. That means the file is closed 4358 times during 1GB file
copying to usb storage.

Cc filesystem list.


[1] insert requests when returning to user mode from syscall

  b'blk_mq_sched_request_inserted'
  b'blk_mq_sched_request_inserted'
  b'dd_insert_requests'
  b'blk_mq_sched_insert_requests'
  b'blk_mq_flush_plug_list'
  b'blk_flush_plug_list'
  b'io_schedule_prepare'
  b'io_schedule'
  b'rq_qos_wait'
  b'wbt_wait'
  b'__rq_qos_throttle'
  b'blk_mq_make_request'
  b'generic_make_request'
  b'submit_bio'
  b'ext4_io_submit'
  b'ext4_writepages'
  b'do_writepages'
  b'__filemap_fdatawrite_range'
  b'ext4_release_file'
  b'__fput'
  b'task_work_run'
  b'exit_to_usermode_loop'
  b'do_syscall_64'
  b'entry_SYSCALL_64_after_hwframe'
    4358

[2] insert requests from writeback wq context

  b'blk_mq_sched_request_inserted'
  b'blk_mq_sched_request_inserted'
  b'dd_insert_requests'
  b'blk_mq_sched_insert_requests'
  b'blk_mq_flush_plug_list'
  b'blk_flush_plug_list'
  b'io_schedule_prepare'
  b'io_schedule'
  b'rq_qos_wait'
  b'wbt_wait'
  b'__rq_qos_throttle'
  b'blk_mq_make_request'
  b'generic_make_request'
  b'submit_bio'
  b'ext4_io_submit'
  b'ext4_bio_write_page'
  b'mpage_submit_page'
  b'mpage_process_page_bufs'
  b'mpage_prepare_extent_to_map'
  b'ext4_writepages'
  b'do_writepages'
  b'__writeback_single_inode'
  b'writeback_sb_inodes'
  b'__writeback_inodes_wb'
  b'wb_writeback'
  b'wb_workfn'
  b'process_one_work'
  b'worker_thread'
  b'kthread'
  b'ret_from_fork'
    5763

Thanks,
Ming

