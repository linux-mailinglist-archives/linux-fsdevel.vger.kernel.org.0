Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E44D15B2AD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2020 22:21:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728447AbgBLVVa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Feb 2020 16:21:30 -0500
Received: from freki.datenkhaos.de ([81.7.17.101]:38118 "EHLO
        freki.datenkhaos.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727548AbgBLVV3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Feb 2020 16:21:29 -0500
X-Greylist: delayed 385 seconds by postgrey-1.27 at vger.kernel.org; Wed, 12 Feb 2020 16:21:27 EST
Received: from localhost (localhost [127.0.0.1])
        by freki.datenkhaos.de (Postfix) with ESMTP id 7666A22882CB;
        Wed, 12 Feb 2020 22:15:01 +0100 (CET)
Received: from freki.datenkhaos.de ([127.0.0.1])
        by localhost (freki.datenkhaos.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id bCFkDBKXADtd; Wed, 12 Feb 2020 22:14:57 +0100 (CET)
Received: from latitude (x4e367a0e.dyn.telefonica.de [78.54.122.14])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by freki.datenkhaos.de (Postfix) with ESMTPSA;
        Wed, 12 Feb 2020 22:14:57 +0100 (CET)
Date:   Wed, 12 Feb 2020 22:14:52 +0100
From:   Johannes Hirte <johannes.hirte@datenkhaos.de>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        Doug Gilbert <dgilbert@interlog.com>,
        Kai =?utf-8?B?TcOka2lzYXJh?= <Kai.Makisara@kolumbus.fi>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Dongli Zhang <dongli.zhang@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        John Garry <john.garry@huawei.com>,
        Martin Wilck <mwilck@suse.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Ira Weiny <ira.weiny@intel.com>, Iustin Pop <iustin@k1024.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 13/22] compat_ioctl: scsi: move ioctl handling into
 drivers
Message-ID: <20200212211452.GA5726@latitude>
References: <20200102145552.1853992-1-arnd@arndb.de>
 <20200102145552.1853992-14-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200102145552.1853992-14-arnd@arndb.de>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020 Jan 02, Arnd Bergmann wrote:
> Each driver calling scsi_ioctl() gets an equivalent compat_ioctl()
> handler that implements the same commands by calling scsi_compat_ioctl().
> 
> The scsi_cmd_ioctl() and scsi_cmd_blk_ioctl() functions are compatible
> at this point, so any driver that calls those can do so for both native
> and compat mode, with the argument passed through compat_ptr().
> 
> With this, we can remove the entries from fs/compat_ioctl.c.  The new
> code is larger, but should be easier to maintain and keep updated with
> newly added commands.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/block/virtio_blk.c |   3 +
>  drivers/scsi/ch.c          |   9 ++-
>  drivers/scsi/sd.c          |  50 ++++++--------
>  drivers/scsi/sg.c          |  44 ++++++++-----
>  drivers/scsi/sr.c          |  57 ++++++++++++++--
>  drivers/scsi/st.c          |  51 ++++++++------
>  fs/compat_ioctl.c          | 132 +------------------------------------
>  7 files changed, 142 insertions(+), 204 deletions(-)
> 

This breaks libcdio. cd-info now results in:

cd-info version 2.1.0 x86_64-pc-linux-gnu
Copyright (c) 2003-2005, 2007-2008, 2011-2015, 2017 R. Bernstein
This is free software; see the source for copying conditions.
There is NO warranty; not even for MERCHANTABILITY or FITNESS FOR A
PARTICULAR PURPOSE.
CD location   : /dev/cdrom
CD driver name: GNU/Linux
   access mode: IOCTL

Error in getting drive hardware properties
Error in getting drive reading properties
Error in getting drive writing properties
__________________________________

Disc mode is listed as: CD-DA
++ WARN: error in ioctl CDROMREADTOCHDR: Bad address

cd-info: Can't get first track number. I give up.


-- 
Regards,
  Johannes Hirte

