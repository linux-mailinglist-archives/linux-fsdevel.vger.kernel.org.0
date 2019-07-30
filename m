Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44CF47B569
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jul 2019 00:01:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387915AbfG3WBG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Jul 2019 18:01:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47280 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387630AbfG3WBG (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Jul 2019 18:01:06 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1E44D4E8AC;
        Tue, 30 Jul 2019 22:01:06 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 667E719724;
        Tue, 30 Jul 2019 22:01:03 +0000 (UTC)
Date:   Tue, 30 Jul 2019 18:01:02 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Pankaj Gupta <pagupta@redhat.com>,
        device-mapper development <dm-devel@redhat.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alasdair Kergon <agk@redhat.com>, jencce.kernel@gmail.com
Subject: Re: dm: fix dax_dev NULL dereference
Message-ID: <20190730220102.GA15604@redhat.com>
References: <20190730113708.14660-1-pagupta@redhat.com>
 <2030283543.5419072.1564486701158.JavaMail.zimbra@redhat.com>
 <20190730190737.GA14873@redhat.com>
 <CAPcyv4i10K3QdSwa3EF9t8pS-QrB9YcBEMy49N1PnYQzCkBJCw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4i10K3QdSwa3EF9t8pS-QrB9YcBEMy49N1PnYQzCkBJCw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Tue, 30 Jul 2019 22:01:06 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 30 2019 at  5:38pm -0400,
Dan Williams <dan.j.williams@intel.com> wrote:

> On Tue, Jul 30, 2019 at 12:07 PM Mike Snitzer <snitzer@redhat.com> wrote:
> >
> > I staged the fix (which I tweaked) here:
> > https://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git/commit/?h=dm-5.3&id=95b9ebb78c4c733f8912a195fbd0bc19960e726e
> 
> Thanks for picking this up Mike, but I'd prefer to just teach
> dax_synchronous() to return false if the passed in dax_dev is NULL.
> Thoughts?

I considered that too but I moved away from it because I'm so used to
the various block interfaces requiring the caller pass a non-NULL
pointer (e.g. request_queue):

$ grep -ri return drivers/md/dm-table.c | grep \&\&
drivers/md/dm-table.c:        return dev->dax_dev && dax_synchronous(dev->dax_dev);
drivers/md/dm-table.c:        return q && blk_queue_zoned_model(q) == *zoned_model;
drivers/md/dm-table.c:        return q && blk_queue_zone_sectors(q) == *zone_sectors;
drivers/md/dm-table.c:        return q && (q->queue_flags & flush);
drivers/md/dm-table.c:        return q && blk_queue_nonrot(q);
drivers/md/dm-table.c:        return q && !blk_queue_add_random(q);
drivers/md/dm-table.c:        return q && !q->limits.max_write_same_sectors;
drivers/md/dm-table.c:        return q && !q->limits.max_write_zeroes_sectors;
drivers/md/dm-table.c:        return q && !blk_queue_discard(q);
drivers/md/dm-table.c:        return q && !blk_queue_secure_erase(q);
drivers/md/dm-table.c:        return q && bdi_cap_stable_pages_required(q->backing_dev_info);

I'm fine with however you'd like to skin this cat though.

Just let me know and I'll keep/drop this patch accordingly.

Thanks,
Mike
