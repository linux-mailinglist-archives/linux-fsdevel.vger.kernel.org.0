Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF2A111D242
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2019 17:27:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729881AbfLLQ1o (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Dec 2019 11:27:44 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:51748 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729762AbfLLQ1o (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Dec 2019 11:27:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=IgVkNZGYYb9ycoy4soM2AlB3WTlIqOyojMWaymh04yw=; b=TvUkz5ifFQk0sY/MKMPhzbCvw
        sDSWJywp1g/bG3Yqvkr3a3T6Gu2STfYzcopwE6DKn5X7MVeg9VUhuY9rXdmTA9CCcOftkIq3fI2rs
        hbwck73m0kvEJAouG0rlZyUdOwc2hBOk4i8Qy8WlMVvmIzNUoOqKaPxqlCNTou3d1mXFVBfYTeVtZ
        cYyfV5FRa3yNSyqk5bOIF4qjM8Tk+5tzQ9iYYRM8WfiaGTwC0v5J8OMgjlUVnBKeQAxLVr74+4NRk
        Kb9mktlcAXxvU3xrz5q9GLc7DDXKrMOGH92mOxPoy3CBbHA7lduUADCZ8uJK3ozOUCEWHFcPF3b9w
        fhp0EgPmQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ifRJJ-0004WW-2W; Thu, 12 Dec 2019 16:27:29 +0000
Date:   Thu, 12 Dec 2019 08:27:29 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, Jens Axboe <axboe@kernel.dk>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jason Wang <jasowang@redhat.com>,
        Doug Gilbert <dgilbert@interlog.com>,
        Kai =?iso-8859-1?Q?M=E4kisara?= <Kai.Makisara@kolumbus.fi>,
        linux-kernel@vger.kernel.org, y2038@lists.linaro.org,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        John Garry <john.garry@huawei.com>,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 15/24] compat_ioctl: scsi: move ioctl handling into
 drivers
Message-ID: <20191212162729.GB27991@infradead.org>
References: <20191211204306.1207817-1-arnd@arndb.de>
 <20191211204306.1207817-16-arnd@arndb.de>
 <20191211180155-mutt-send-email-mst@kernel.org>
 <858768fb-5f79-8259-eb6a-a26f18fb0e04@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <858768fb-5f79-8259-eb6a-a26f18fb0e04@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 12, 2019 at 01:28:08AM +0100, Paolo Bonzini wrote:
> I think it's because the only ioctl for virtio-blk is SG_IO.  It makes
> sense to lump it in with scsi, but I wouldn't mind getting rid of
> CONFIG_VIRTIO_BLK_SCSI altogether.

CONFIG_VIRTIO_BLK_SCSI has been broken for about two years, as it
never set the QUEUE_FLAG_SCSI_PASSTHROUGH flag after that was
introduced.  I actually have a patch that I plan to send to remove
this support as it was a really idea to start with (speaking as
the person who had that idea back in the day).
