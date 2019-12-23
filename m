Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43DD01298A9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Dec 2019 17:26:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbfLWQ0r (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Dec 2019 11:26:47 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:56982 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726744AbfLWQ0r (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Dec 2019 11:26:47 -0500
Received: from callcc.thunk.org (guestnat-104-133-0-111.corp.google.com [104.133.0.111] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id xBNGQJ8k010341
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Dec 2019 11:26:20 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 4BCF9420822; Mon, 23 Dec 2019 11:26:19 -0500 (EST)
Date:   Mon, 23 Dec 2019 11:26:19 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Andrea Vai <andrea.vai@unipv.it>,
        "Schmid, Carsten" <Carsten_Schmid@mentor.com>,
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
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: AW: Slow I/O on USB media after commit
 f664a3cc17b7d0a2bc3b3ab96181e1029b0ec0e6
Message-ID: <20191223162619.GA3282@mit.edu>
References: <8196b014b1a4d91169bf3b0d68905109aeaf2191.camel@unipv.it>
 <20191210080550.GA5699@ming.t460p>
 <20191211024137.GB61323@mit.edu>
 <20191211040058.GC6864@ming.t460p>
 <20191211160745.GA129186@mit.edu>
 <20191211213316.GA14983@ming.t460p>
 <f38db337cf26390f7c7488a0bc2076633737775b.camel@unipv.it>
 <20191218094830.GB30602@ming.t460p>
 <b1b6a0e9d690ecd9432025acd2db4ac09f834040.camel@unipv.it>
 <20191223130828.GA25948@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191223130828.GA25948@ming.t460p>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Dec 23, 2019 at 09:08:28PM +0800, Ming Lei wrote:
> 
> From the above trace:
> 
>   b'blk_mq_sched_request_inserted'
>   b'blk_mq_sched_request_inserted'
>   b'dd_insert_requests'
>   b'blk_mq_sched_insert_requests'
>   b'blk_mq_flush_plug_list'
>   b'blk_flush_plug_list'
>   b'io_schedule_prepare'
>   b'io_schedule'
>   b'rq_qos_wait'
>   b'wbt_wait'
>   b'__rq_qos_throttle'
>   b'blk_mq_make_request'
>   b'generic_make_request'
>   b'submit_bio'
>   b'ext4_io_submit'
>   b'ext4_writepages'
>   b'do_writepages'
>   b'__filemap_fdatawrite_range'
>   b'ext4_release_file'
>   b'__fput'
>   b'task_work_run'
>   b'exit_to_usermode_loop'
>   b'do_syscall_64'
>   b'entry_SYSCALL_64_after_hwframe'
>     b'cp' [19863]
>     4400
> 
> So this write is clearly from 'cp' process, and it should be one
> ext4 fs issue.

We need a system call trace of the cp process, to understand what
system call is resulting in fput, (eg., I assume it's close(2) but
let's be sure), and often it's calling that system call.

What cp process is it?  Is it from shellutils?  Is it from busybox?

     		   	      	   		- Ted
