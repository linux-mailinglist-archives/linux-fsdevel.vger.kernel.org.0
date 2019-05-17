Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9FA721378
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 May 2019 07:36:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727867AbfEQFgA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 May 2019 01:36:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51660 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727317AbfEQFgA (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 May 2019 01:36:00 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7DB4D81DE6;
        Fri, 17 May 2019 05:35:59 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 58AE01001DD2;
        Fri, 17 May 2019 05:35:59 +0000 (UTC)
Received: from zmail21.collab.prod.int.phx2.redhat.com (zmail21.collab.prod.int.phx2.redhat.com [10.5.83.24])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id 0AB9A1806B10;
        Fri, 17 May 2019 05:35:59 +0000 (UTC)
Date:   Fri, 17 May 2019 01:35:58 -0400 (EDT)
From:   Pankaj Gupta <pagupta@redhat.com>
To:     Jakub =?utf-8?Q?Staro=C5=84?= <jstaron@google.com>
Cc:     linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, kvm@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-acpi@vger.kernel.org,
        qemu-devel@nongnu.org, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, jack@suse.cz, mst@redhat.com,
        jasowang@redhat.com, david@fromorbit.com, lcapitulino@redhat.com,
        adilger kernel <adilger.kernel@dilger.ca>, smbarber@google.com,
        zwisler@kernel.org, aarcange@redhat.com,
        dave jiang <dave.jiang@intel.com>,
        darrick wong <darrick.wong@oracle.com>,
        vishal l verma <vishal.l.verma@intel.com>, david@redhat.com,
        willy@infradead.org, hch@infradead.org, jmoyer@redhat.com,
        nilal@redhat.com, lenb@kernel.org, kilobyte@angband.pl,
        riel@surriel.com, yuval shaia <yuval.shaia@oracle.com>,
        stefanha@redhat.com, pbonzini@redhat.com,
        dan j williams <dan.j.williams@intel.com>, kwolf@redhat.com,
        tytso@mit.edu, xiaoguangrong eric <xiaoguangrong.eric@gmail.com>,
        cohuck@redhat.com, rjw@rjwysocki.net, imammedo@redhat.com
Message-ID: <1954162775.29408078.1558071358974.JavaMail.zimbra@redhat.com>
In-Reply-To: <c06514fd-8675-ba74-4b7b-ff0eb4a91605@google.com>
References: <20190514145422.16923-1-pagupta@redhat.com> <20190514145422.16923-3-pagupta@redhat.com> <c06514fd-8675-ba74-4b7b-ff0eb4a91605@google.com>
Subject: Re: [Qemu-devel] [PATCH v9 2/7] virtio-pmem: Add virtio pmem driver
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.116.188, 10.4.195.1]
Thread-Topic: virtio-pmem: Add virtio pmem driver
Thread-Index: Jfq72a6Lppgn6G/na6kHvdhmTQkM6g==
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Fri, 17 May 2019 05:35:59 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



Hi Jakub,

> 
> On 5/14/19 7:54 AM, Pankaj Gupta wrote:
> > +		if (!list_empty(&vpmem->req_list)) {
> > +			req_buf = list_first_entry(&vpmem->req_list,
> > +					struct virtio_pmem_request, list);
> > +			req_buf->wq_buf_avail = true;
> > +			wake_up(&req_buf->wq_buf);
> > +			list_del(&req_buf->list);
> Yes, this change is the right one, thank you!

Thank you for the confirmation.

> 
> > +	 /*
> > +	  * If virtqueue_add_sgs returns -ENOSPC then req_vq virtual
> > +	  * queue does not have free descriptor. We add the request
> > +	  * to req_list and wait for host_ack to wake us up when free
> > +	  * slots are available.
> > +	  */
> > +	while ((err = virtqueue_add_sgs(vpmem->req_vq, sgs, 1, 1, req,
> > +					GFP_ATOMIC)) == -ENOSPC) {
> > +
> > +		dev_err(&vdev->dev, "failed to send command to virtio pmem" \
> > +			"device, no free slots in the virtqueue\n");
> > +		req->wq_buf_avail = false;
> > +		list_add_tail(&req->list, &vpmem->req_list);
> > +		spin_unlock_irqrestore(&vpmem->pmem_lock, flags);
> > +
> > +		/* A host response results in "host_ack" getting called */
> > +		wait_event(req->wq_buf, req->wq_buf_avail);
> > +		spin_lock_irqsave(&vpmem->pmem_lock, flags);
> > +	}
> > +	err1 = virtqueue_kick(vpmem->req_vq);
> > +	spin_unlock_irqrestore(&vpmem->pmem_lock, flags);
> > +
> > +	/*
> > +	 * virtqueue_add_sgs failed with error different than -ENOSPC, we can't
> > +	 * do anything about that.
> > +	 */
> > +	if (err || !err1) {
> > +		dev_info(&vdev->dev, "failed to send command to virtio pmem device\n");
> > +		err = -EIO;
> > +	} else {
> > +		/* A host repsonse results in "host_ack" getting called */
> > +		wait_event(req->host_acked, req->done);
> > +		err = req->ret;
> > +I confirm that the failures I was facing with the `-ENOSPC` error path are
> > not present in v9.

Can I take it your reviewed/acked-by? or tested-by tag? for the virtio patch :)

Thank you,
Pankaj

> 
> Best,
> Jakub Staron
> 
> 
