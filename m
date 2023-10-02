Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85B827B5121
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Oct 2023 13:24:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236637AbjJBLYx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Oct 2023 07:24:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231290AbjJBLYw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Oct 2023 07:24:52 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76B6493;
        Mon,  2 Oct 2023 04:24:49 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 150841F747;
        Mon,  2 Oct 2023 11:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1696245888; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UETf0HnSrYrHffzzDaQE3QI/XIRNycdg/wMl5wFYBxk=;
        b=jod2GzS9xClNnguLkyhnWMa1FAQb+eWHBJZZU6+C7Fy85SVZVL1al/umKrSFjsyZgbmq6O
        i5didEvHntFhC3e/mkwlsfjRfT5TRtZfLE1buaGgsFn+PkrrrFk3X5B6F4ZpOOn4/2AgNm
        HsFYnI/hvd7E2IqLJSa01T5DHUBiTMg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1696245888;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UETf0HnSrYrHffzzDaQE3QI/XIRNycdg/wMl5wFYBxk=;
        b=bayjhQINgaDk3ugerAs9Ixox0YVDMjKvzpn9kaObrN3m8MD2mQvqWBRBL3rxEZ6/FbIw/c
        w7yN+frmnAyntjAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 01F8C13456;
        Mon,  2 Oct 2023 11:24:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id PHNyAICoGmVNAwAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 02 Oct 2023 11:24:48 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 80327A07C9; Mon,  2 Oct 2023 13:24:47 +0200 (CEST)
Date:   Mon, 2 Oct 2023 13:24:47 +0200
From:   Jan Kara <jack@suse.cz>
To:     Stefan Haberland <sth@linux.ibm.com>
Cc:     Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        linux-s390@vger.kernel.org,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Christoph Hellwig <hch@lst.de>,
        Jan Hoeppner <hoeppner@linux.ibm.com>
Subject: Re: [PATCH 14/29] s390/dasd: Convert to bdev_open_by_path()
Message-ID: <20231002112447.aecbad2w6lh4p3fp@quack3>
References: <20230818123232.2269-1-jack@suse.cz>
 <20230823104857.11437-14-jack@suse.cz>
 <51e1e42a-2ed8-a664-f26f-bc5bc1762884@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51e1e42a-2ed8-a664-f26f-bc5bc1762884@linux.ibm.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 27-09-23 23:43:44, Stefan Haberland wrote:
> Am 23.08.23 um 12:48 schrieb Jan Kara:
> > Convert dasd to use bdev_open_by_path() and pass the handle around.
> > 
> > CC: linux-s390@vger.kernel.org
> > CC: Christian Borntraeger <borntraeger@linux.ibm.com>
> > CC: Sven Schnelle <svens@linux.ibm.com>
> > Acked-by: Christoph Hellwig <hch@lst.de>
> > Signed-off-by: Jan Kara <jack@suse.cz>
> > ---
> 
> The DASD part does not compile. please see below.
> 
> Beside of this the patch looks OK to me.
> 
> with the error fixed:
> Acked-by: Stefan Haberland <sth@linux.ibm.com>

Thanks for noticing. I can see Christian has already fixed up the problem
in his tree. I guess he'll pick up your ack once he returns from vacation.

								Honza

> 
> >   drivers/s390/block/dasd.c       | 12 +++++----
> >   drivers/s390/block/dasd_genhd.c | 45 ++++++++++++++++-----------------
> >   drivers/s390/block/dasd_int.h   |  2 +-
> >   drivers/s390/block/dasd_ioctl.c |  2 +-
> >   4 files changed, 31 insertions(+), 30 deletions(-)
> > 
> > diff --git a/drivers/s390/block/dasd.c b/drivers/s390/block/dasd.c
> > index 215597f73be4..16a2d631a169 100644
> > --- a/drivers/s390/block/dasd.c
> > +++ b/drivers/s390/block/dasd.c
> > @@ -412,7 +412,8 @@ dasd_state_ready_to_online(struct dasd_device * device)
> >   					KOBJ_CHANGE);
> >   			return 0;
> >   		}
> > -		disk_uevent(device->block->bdev->bd_disk, KOBJ_CHANGE);
> > +		disk_uevent(device->block->bdev_handle->bdev->bd_disk,
> > +			    KOBJ_CHANGE);
> >   	}
> >   	return 0;
> >   }
> > @@ -432,7 +433,8 @@ static int dasd_state_online_to_ready(struct dasd_device *device)
> >   	device->state = DASD_STATE_READY;
> >   	if (device->block && !(device->features & DASD_FEATURE_USERAW))
> > -		disk_uevent(device->block->bdev->bd_disk, KOBJ_CHANGE);
> > +		disk_uevent(device->block->bdev_handle->bdev->bd_disk,
> > +			    KOBJ_CHANGE);
> >   	return 0;
> >   }
> > @@ -3590,7 +3592,7 @@ int dasd_generic_set_offline(struct ccw_device *cdev)
> >   	 * in the other openers.
> >   	 */
> >   	if (device->block) {
> > -		max_count = device->block->bdev ? 0 : -1;
> > +		max_count = device->block->bdev_handle ? 0 : -1;
> >   		open_count = atomic_read(&device->block->open_count);
> >   		if (open_count > max_count) {
> >   			if (open_count > 0)
> > @@ -3636,8 +3638,8 @@ int dasd_generic_set_offline(struct ccw_device *cdev)
> >   		 * so sync bdev first and then wait for our queues to become
> >   		 * empty
> >   		 */
> > -		if (device->block)
> > -			bdev_mark_dead(device->block->bdev, false);
> > +		if (device->block && device->block->bdev_handle) {
> 
> the brace is not needed here and there is no matching right brace.
> 
> > +			bdev_mark_dead(device->block->bdev_handle->bdev, false);
> >   		dasd_schedule_device_bh(device);
> >   		rc = wait_event_interruptible(shutdown_waitq,
> >   					      _wait_for_empty_queues(device));
> > 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
