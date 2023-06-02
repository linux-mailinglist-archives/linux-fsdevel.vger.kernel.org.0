Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58FAA720B43
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Jun 2023 23:53:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236470AbjFBVxT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Jun 2023 17:53:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236577AbjFBVxN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Jun 2023 17:53:13 -0400
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC85FE52
        for <linux-fsdevel@vger.kernel.org>; Fri,  2 Jun 2023 14:52:03 -0700 (PDT)
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-3f81396e435so23934911cf.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 02 Jun 2023 14:52:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685742651; x=1688334651;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UTRky113EniM0nT/xznU7UrijnGVH8CEk6F86K/tnEo=;
        b=PikFOLiwlYN/WBE23Gz1AQFHLup/ufkLxA2CuSpoM2ATd8g9YzoHsWL6UpH6143nz6
         zKHFi8N8RUC82uI8LL4EJX/z5e2otyDdGssyVSxZ7rl2EQmZnmWVEXoTqRKHtmoI3n30
         5wtK0RsqcHMGD4TiBpDBQAz+Elip1KdhX0nX3sdWKfZ1pZ1chgTytwKcC1JwRIIT4rga
         tPDDNOC2olQxEeLoI4FOH4mYwD3qspmyUHR+eNvK3vdGN4eQFQ3QLzQKUpo1OmfVfVql
         gjr9oTiSqvTl171K1dH4zd0sSxzbHYvY09LdKwDTEbFgV8O72ckftcsOS7cKgrcduisc
         la4Q==
X-Gm-Message-State: AC+VfDzrtszOnIohgzoFswWN99/Dc68YM5cRyXK+PUn8fZzUUQUqq8fJ
        FvGbiYWOi/wY6mZ/N6/B0McF
X-Google-Smtp-Source: ACHHUZ7EYtrupkurG9n+8SFwQbMMRsCnns2grd76F2kWxvjetuxx5d1DqIPs4GPppwGqt5TFKDjmsg==
X-Received: by 2002:ac8:5e11:0:b0:3f6:b017:6289 with SMTP id h17-20020ac85e11000000b003f6b0176289mr16977166qtx.10.1685742651495;
        Fri, 02 Jun 2023 14:50:51 -0700 (PDT)
Received: from localhost (pool-68-160-166-30.bstnma.fios.verizon.net. [68.160.166.30])
        by smtp.gmail.com with ESMTPSA id i2-20020ac813c2000000b003f6f83de87esm1236527qtj.92.2023.06.02.14.50.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 14:50:50 -0700 (PDT)
Date:   Fri, 2 Jun 2023 17:50:49 -0400
From:   Mike Snitzer <snitzer@kernel.org>
To:     Sarthak Kukreti <sarthakkukreti@chromium.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Joe Thornber <thornber@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Brian Foster <bfoster@redhat.com>,
        Bart Van Assche <bvanassche@google.com>,
        Dave Chinner <david@fromorbit.com>,
        linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>, dm-devel@redhat.com,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        linux-fsdevel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        linux-ext4@vger.kernel.org, Joe Thornber <ejt@redhat.com>,
        Alasdair Kergon <agk@redhat.com>
Subject: Re: [PATCH v7 0/5] Introduce provisioning primitives
Message-ID: <ZHpkOTMDdoxLD/j1@redhat.com>
References: <ZG1dAtHmbQ53aOhA@dread.disaster.area>
 <ZG+KoxDMeyogq4J0@bfoster>
 <ZHB954zGG1ag0E/t@dread.disaster.area>
 <CAJ0trDbspRaDKzTzTjFdPHdB9n0Q9unfu1cEk8giTWoNu3jP8g@mail.gmail.com>
 <ZHFEfngPyUOqlthr@dread.disaster.area>
 <CAJ0trDZJQwvAzngZLBJ1hB0XkQ1HRHQOdNQNTw9nK-U5i-0bLA@mail.gmail.com>
 <ZHYB/6l5Wi+xwkbQ@redhat.com>
 <CAJ0trDaUOevfiEpXasOESrLHTCcr=oz28ywJU+s+YOiuh7iWow@mail.gmail.com>
 <ZHYWAGmKhwwmTjW/@redhat.com>
 <CAG9=OMMnDfN++-bJP3jLmUD6O=Q_ApV5Dr392_5GqsPAi_dDkg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG9=OMMnDfN++-bJP3jLmUD6O=Q_ApV5Dr392_5GqsPAi_dDkg@mail.gmail.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 02 2023 at  2:44P -0400,
Sarthak Kukreti <sarthakkukreti@chromium.org> wrote:

> On Tue, May 30, 2023 at 8:28 AM Mike Snitzer <snitzer@kernel.org> wrote:
> >
> > On Tue, May 30 2023 at 10:55P -0400,
> > Joe Thornber <thornber@redhat.com> wrote:
> >
> > > On Tue, May 30, 2023 at 3:02 PM Mike Snitzer <snitzer@kernel.org> wrote:
> > >
> > > >
> > > > Also Joe, for you proposed dm-thinp design where you distinquish
> > > > between "provision" and "reserve": Would it make sense for REQ_META
> > > > (e.g. all XFS metadata) with REQ_PROVISION to be treated as an
> > > > LBA-specific hard request?  Whereas REQ_PROVISION on its own provides
> > > > more freedom to just reserve the length of blocks? (e.g. for XFS
> > > > delalloc where LBA range is unknown, but dm-thinp can be asked to
> > > > reserve space to accomodate it).
> > > >
> > >
> > > My proposal only involves 'reserve'.  Provisioning will be done as part of
> > > the usual io path.
> >
> > OK, I think we'd do well to pin down the top-level block interfaces in
> > question. Because this patchset's block interface patch (2/5) header
> > says:
> >
> > "This patch also adds the capability to call fallocate() in mode 0
> > on block devices, which will send REQ_OP_PROVISION to the block
> > device for the specified range,"
> >
> > So it wires up blkdev_fallocate() to call blkdev_issue_provision(). A
> > user of XFS could then use fallocate() for user data -- which would
> > cause thinp's reserve to _not_ be used for critical metadata.
> >
> > The only way to distinquish the caller (between on-behalf of user data
> > vs XFS metadata) would be REQ_META?
> >
> > So should dm-thinp have a REQ_META-based distinction? Or just treat
> > all REQ_OP_PROVISION the same?
> >
> I'm in favor of a REQ_META-based distinction. Does that imply that
> REQ_META also needs to be passed through the block/filesystem stack
> (eg. REQ_OP_PROVION + REQ_META on a loop device translates to a
> fallocate(<insert meta flag name>) to the underlying file)?

Unclear, I was thinking your REQ_UNSHARE (tied to fallocate) might be
a means to translate REQ_OP_PROVISION + REQ_META to fallocate and have
it perform the LBA-specific provisioning of Joe's design (referenced
below).

> <bikeshed>
> I think that might have applications beyond just provisioning:
> currently, for stacked filesystems (eg filesystems residing in a file
> on top of another filesystem), even if the upper filesystem issues
> read/write requests with REQ_META | REQ_PRIO, these flags are lost in
> translation at the loop device layer.  A flag like the above would
> allow the prioritization of stacked filesystem metadata requests.
> </bikeshed>

Yes, it could prove useful.

> Bringing the discussion back to this series for a bit, I'm still
> waiting on feedback from the Block maintainers before sending out v8
> (which at the moment, only have a
> s/EXPORT_SYMBOL/EXPORT_SYMBOL_GPL/g). I believe from the conversation
> most of the above is follow up work, but please let me know if you'd
> prefer I add some of this to the current series!

I need a bit more time to work through various aspects of the broader
requirements and the resulting interfaces that fall out.

Joe's design is pretty compelling because it will properly handle
snapshot thin devices:
https://listman.redhat.com/archives/dm-devel/2023-May/054351.html

Here is my latest status:
- Focused on prototype for thinp block reservation (XFS metadata, XFS
  delalloc, fallocate)
- Decided the "dynamic" (non-LBA specific) reservation stuff (old
  prototype code) is best left independent from Joe's design.  SO 2
  classes of thinp reservation.
  - Forward-ported the old prototype code that Brian Foster, Joe
    Thornber and I worked on years ago.  It needs more careful review
    (and very likely will need fixes from Brian and myself).  The XFS
    changes are pretty intrusive and likely up for serious debate (as
    to whether we even care to handle reservations for user data).
- REQ_OP_PROVISION bio’s with REQ_META will use Joe’s design,
  otherwise data (XFS data and fallocate) will use “dynamic”
  reservation.
  - "dynamic" name is due to the reservation being generic (non-LBA:
    not in terms of an LBA range). Also, in-core only; so the associated
    “dynamic_reserve_count” accounting is reset to 0 every activation. 
  - Fallocate may require stronger guarantees in the end (in which
    case we’ll add a REQ_UNSHARE flag that is selectable from the
    fallocate interface) 
- Will try to share common code, but just sorting out highlevel
  interface(s) still...

I'll try to get a git tree together early next week.  It will be the
forward ported "dynamic" prototype code and your latest v7 code with
some additional work to branch accordingly for each class of thinp
reservation.  And I'll use your v7 code as a crude stub for Joe's
approach (branch taken if REQ_META set).

Lastly, here are some additional TODOs I've noted in code earlier in
my review process:

diff --git a/drivers/md/dm-thin.c b/drivers/md/dm-thin.c
index 0d9301802609..43a6702f9efe 100644
--- a/drivers/md/dm-thin.c
+++ b/drivers/md/dm-thin.c
@@ -1964,6 +1964,26 @@ static void process_provision_bio(struct thin_c *tc, struct bio *bio)
 	struct dm_cell_key key;
 	struct dm_thin_lookup_result lookup_result;
 
+	/*
+	 * FIXME:
+	 * Joe's elegant reservation design is detailed here:
+	 * https://listman.redhat.com/archives/dm-devel/2023-May/054351.html
+	 * - this design, with associated thinp metadata updates,
+	 *   is how provision bios should be handled.
+	 *
+	 * FIXME: add thin-pool flag "ignore_provision"
+	 *
+	 * FIXME: needs provision_passdown support
+	 *        (needs thinp flag "no_provision_passdown")
+	 */
+
+	/*
+	 * FIXME: require REQ_META (or REQ_UNSHARE?) to allow deeper
+	 *        provisioning code that follows? (so that thinp
+	 *        block _is_ fully provisioned upon return)
+	 *        (or just remove all below code entirely?)
+	 */
+
 	/*
 	 * If cell is already occupied, then the block is already
 	 * being provisioned so we have nothing further to do here.

