Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 842BD72FA31
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jun 2023 12:13:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235967AbjFNKNB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Jun 2023 06:13:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234949AbjFNKM7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Jun 2023 06:12:59 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75CA3E5;
        Wed, 14 Jun 2023 03:12:58 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id CFF3C21866;
        Wed, 14 Jun 2023 10:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1686737576; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RcnMyCGQSVLPr1665FLwoANm07JPi2RGJjuXELBzg4Q=;
        b=l37pL87Tk9c1i+d/d6Ijbo+3GH7yR27y5d3LA7xZaumX/bUQzD0TnCDi/VvmZnoCCAyvSW
        1HYoiThlXEI7MiQt1XbitAEbzXTC4SYpVhEgTuBpSzzSFZVVrmMYJcJTFlLBOn/g3spppF
        Iekw4MEXdtUUqzzesdl9ENLeVwDK8wI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1686737576;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RcnMyCGQSVLPr1665FLwoANm07JPi2RGJjuXELBzg4Q=;
        b=JwvYAcS2nur+2SMuqTxIzt06k6S+8oPtkLXBbdm+BHrYvTgQj7lHlb9jorV81WO01LMo6z
        2+yVf1b0slvabWBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C1B861391E;
        Wed, 14 Jun 2023 10:12:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id +bZUL6iSiWTUcQAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 14 Jun 2023 10:12:56 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 467C5A0755; Wed, 14 Jun 2023 12:12:56 +0200 (CEST)
Date:   Wed, 14 Jun 2023 12:12:56 +0200
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jan Kara <jack@suse.cz>, Colin Walters <walters@verbum.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Dmitry Vyukov <dvyukov@google.com>,
        Theodore Ts'o <tytso@mit.edu>, yebin <yebin@huaweicloud.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] block: Add config option to not allow writing to mounted
 devices
Message-ID: <20230614101256.kgnui242k72lmp4e@quack3>
References: <20230612161614.10302-1-jack@suse.cz>
 <20230612162545.frpr3oqlqydsksle@quack3>
 <2f629dc3-fe39-624f-a2fe-d29eee1d2b82@acm.org>
 <a6c355f7-8c60-4aab-8f0c-5c6310f9c2a8@betaapp.fastmail.com>
 <20230613113448.5txw46hvmdjvuoif@quack3>
 <ZIln4s7//kjlApI0@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZIln4s7//kjlApI0@infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 14-06-23 00:10:26, Christoph Hellwig wrote:
> On Tue, Jun 13, 2023 at 01:34:48PM +0200, Jan Kara wrote:
> > > It's not just syzbot here; at least once in my life I accidentally did
> > > `dd if=/path/to/foo.iso of=/dev/sda` when `/dev/sda` was my booted disk
> > > and not the target USB device.  I know I'm not alone =)
> > 
> > Yeah, so I'm not sure we are going to protect against this particular case.
> > I mean it is not *that* uncommon to alter partition table of /dev/sda while
> > /dev/sda1 is mounted. And for the kernel it is difficult to distinguish
> > this and your mishap.
> 
> I think it is actually very easy to distinguish, because the partition
> table is not mapped to any partition and certainly not an exclusively
> opened one.

Well, OK, I have not been precise :). Modifying a partition table (or LVM
description block) is impossible to distinguish from clobbering a
filesystem on open(2) time. Once we decide we implement arbitration of each
individual write(2), we can obviously stop writes to area covered by some
exclusively open partition. But then you are getting at the complexity
level of tracking used ranges of block devices which Darrick has suggested
and you didn't seem to like that (and neither do I). Furthermore the
protection is never going to be perfect as soon as loopback devices, device
mapper, and similar come into the mix (or it gets really really complex).
So I'd really prefer to stick with whatever arbitration we can perform on
open(2).

> > 1) If user can write some image and make kernel mount it.
> > 2) If user can modify device content while mounted (but not buffer cache
> > of the device).
> > 3) If user can modify buffer cache of the device while mounted.
> > 
> > 3) is the most problematic and effectively equivalent to full machine
> > control (executing arbitrary code in kernel mode) these days.
> 
> If a corrupted image can trigger arbitrary code execution that also
> means the file system code does not do proper input validation.

I agree. But case 3) is not about corrupted image - it is about userspace's
ability to corrupt data stored in the buffer cache *after* it has been
loaded from the image and verified. This is not a problem for XFS which has
its private block device cache incoherent with the buffer cache you access
when opening the bdev but basically every other filesystem suffers from
this problem.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
