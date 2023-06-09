Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E589F72A5A1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jun 2023 23:54:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232642AbjFIVyo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Jun 2023 17:54:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232406AbjFIVyn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Jun 2023 17:54:43 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F75235BE
        for <linux-fsdevel@vger.kernel.org>; Fri,  9 Jun 2023 14:54:41 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-65242634690so1855433b3a.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 09 Jun 2023 14:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20221208.gappssmtp.com; s=20221208; t=1686347680; x=1688939680;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XPZ0YqKq/WukCdmDJhCk3d2gnOJ/ZDLhdj7edRPgO8w=;
        b=XHHFqA3tiwTZUVmH7k9BBAvuQvOWW75TqAUVUB/G39E6gqX/g7gOjIpPYpkEosbzqX
         LwLiArJqyjpFU/RGWoqqTb/uI5O2alZ87zLySjRx+AjMNcqtx3KWHuBhrdJ63zObXRoc
         V52RNIciwCIc8yNLHDOwMpnU16UZkYNfzdka6VBL1ZsdMrR6ZsaJVOOmeTmZWfq1FU59
         lvvFcK20p51KgbAP2ynIseP8j1AEJSRLDv20I1cvNEAMPv48n0VQfSq41bL9C8WWwB8x
         qKQdmwuoSRhkmFjEl+NQHTvy4fKBOo+hu4PUWS2xdqcXB0ugiPYzQGHuWh27OuXZ8Jyt
         YgIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686347680; x=1688939680;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XPZ0YqKq/WukCdmDJhCk3d2gnOJ/ZDLhdj7edRPgO8w=;
        b=SuZjQFEZ7/Aqf1jgELUgLQPZ0m37pseuL5f2is+Rxpb9ibZRvoRIvR5BFgHBta1bym
         PP6KTgEpe+7x0NA70uUSGRI+fgxRqkIItbYWbY81KZCnIUiS3//wfa/HAm0iNpaqVHlj
         b9X8qteb2X96Q0QnRBLFmD8QK7gKkO/Jv1di/RBe7Gr3P5TMSz0/+NYOURi0AshBnPxi
         U92L3w92ZAFoMvPQv22hM80PYkCTGy2ohzeNBHLAKyInaezhzl6viljBo46AShJFQlP7
         YCOBawhFbYxebtsE6xm/DUhmnyGNLN10X6OUZJgiXvrufQrjdRUD38v59CHJ+H6easDE
         qlyA==
X-Gm-Message-State: AC+VfDwe3IUETsPCiSobZKKdVb3ctrUtIa3zIanASYS89GcQWSpMCgOc
        UY3WQQPUNwqI2VkH3XfSm/3Cjw==
X-Google-Smtp-Source: ACHHUZ7+SuqJnp9//p1l5K264TTrLPu0q5rjuOaTTocEpZo7EWHXy5jYhcLfVXBXsWNsGfhXyK1I1w==
X-Received: by 2002:a05:6a20:c183:b0:10c:7c72:bdf9 with SMTP id bg3-20020a056a20c18300b0010c7c72bdf9mr1976311pzb.29.1686347680562;
        Fri, 09 Jun 2023 14:54:40 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-79-151.pa.nsw.optusnet.com.au. [49.179.79.151])
        by smtp.gmail.com with ESMTPSA id u5-20020aa78385000000b0064d4d11b8bfsm3064066pfm.59.2023.06.09.14.54.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 14:54:40 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1q7k44-009qQ3-0w;
        Sat, 10 Jun 2023 07:54:36 +1000
Date:   Sat, 10 Jun 2023 07:54:36 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     Sarthak Kukreti <sarthakkukreti@chromium.org>,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Joe Thornber <thornber@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Jason Wang <jasowang@redhat.com>,
        Bart Van Assche <bvanassche@google.com>,
        linux-kernel@vger.kernel.org, Joe Thornber <ejt@redhat.com>,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        linux-fsdevel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        linux-ext4@vger.kernel.org, Brian Foster <bfoster@redhat.com>,
        Alasdair Kergon <agk@redhat.com>
Subject: Re: [PATCH v7 0/5] Introduce provisioning primitives
Message-ID: <ZIOfnPFucQMpQAJ/@dread.disaster.area>
References: <CAJ0trDZJQwvAzngZLBJ1hB0XkQ1HRHQOdNQNTw9nK-U5i-0bLA@mail.gmail.com>
 <ZHYB/6l5Wi+xwkbQ@redhat.com>
 <CAJ0trDaUOevfiEpXasOESrLHTCcr=oz28ywJU+s+YOiuh7iWow@mail.gmail.com>
 <ZHYWAGmKhwwmTjW/@redhat.com>
 <CAG9=OMMnDfN++-bJP3jLmUD6O=Q_ApV5Dr392_5GqsPAi_dDkg@mail.gmail.com>
 <ZHqOvq3ORETQB31m@dread.disaster.area>
 <ZHti/MLnX5xGw9b7@redhat.com>
 <CAG9=OMNv80fOyVixEY01XESnOFzYyfj9j8etHMq_Ap52z4UWNQ@mail.gmail.com>
 <ZIESXNF5anyvJEjm@redhat.com>
 <ZIOMLfMjugGf4C2T@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZIOMLfMjugGf4C2T@redhat.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 09, 2023 at 04:31:41PM -0400, Mike Snitzer wrote:
> On Wed, Jun 07 2023 at  7:27P -0400,
> Mike Snitzer <snitzer@kernel.org> wrote:
> 
> > On Mon, Jun 05 2023 at  5:14P -0400,
> > Sarthak Kukreti <sarthakkukreti@chromium.org> wrote:
> > 
> > > On Sat, Jun 3, 2023 at 8:57 AM Mike Snitzer <snitzer@kernel.org> wrote:
> > > >
> > > > We all just need to focus on your proposal and Joe's dm-thin
> > > > reservation design...
> > > >
> > > > [Sarthak: FYI, this implies that it doesn't really make sense to add
> > > > dm-thinp support before Joe's design is implemented.  Otherwise we'll
> > > > have 2 different responses to REQ_OP_PROVISION.  The one that is
> > > > captured in your patchset isn't adequate to properly handle ensuring
> > > > upper layer (like XFS) can depend on the space being available across
> > > > snapshot boundaries.]
> > > >
> > > Ack. Would it be premature for the rest of the series to go through
> > > (REQ_OP_PROVISION + support for loop and non-dm-thinp device-mapper
> > > targets)? I'd like to start using this as a reference to suggest
> > > additions to the virtio-spec for virtio-blk support and start looking
> > > at what an ext4 implementation would look like.
> > 
> > Please drop the dm-thin.c and dm-snap.c changes.  dm-snap.c would need
> > more work to provide the type of guarantee XFS requires across
> > snapshot boundaries. I'm inclined to _not_ add dm-snap.c support
> > because it is best to just use dm-thin.
> > 
> > And FYI even your dm-thin patch will be the starting point for the
> > dm-thin support (we'll keep attribution to you for all the code in a
> > separate patch).
> > 
> > > Fair points, I certainly don't want to derail this conversation; I'd
> > > be happy to see this work merged sooner rather than later.
> > 
> > Once those dm target changes are dropped I think the rest of the
> > series is fine to go upstream now.  Feel free to post a v8.
> 
> FYI, I've made my latest code available in this
> 'dm-6.5-provision-support' branch (based on 'dm-6.5'):
> https://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git/log/?h=dm-6.5-provision-support
> 
> It's what v8 should be plus the 2 dm-thin patches (that I don't think
> should go upstream yet, but are theoretically useful for Dave and
> Joe).
> 
> The "dm thin: complete interface for REQ_OP_PROVISION support" commit
> establishes all the dm-thin interface I think is needed.  The FIXME in
> process_provision_bio() (and the patch header) cautions against upper
> layers like XFS using this dm-thinp support quite yet.
> 
> Otherwise we'll have the issue where dm-thinp's REQ_OP_PROVISION
> support initially doesn't provide the guarantee that XFS needs across
> snapshots (which is: snapshots inherit all previous REQ_OP_PROVISION).

Just tag it with EXPERIMENTAL on recpetion of the first
REQ_OP_PROVISION for the device (i.e. dump a log warning), like I'll
end up doing with XFS when it detects provisioning support at mount
time.

We do this all the time to allow merging new features before they
are fully production ready - EXPERIMENTAL means you can expect it to
mostly work, except when it doesn't, and you know that when it
breaks you get to report the bug, help triage it and as a bonus you
get to keep the broken bits!

$ git grep EXPERIMENTAL fs/xfs
fs/xfs/Kconfig:   This feature is considered EXPERIMENTAL.  Use with caution!
fs/xfs/Kconfig:   This feature is considered EXPERIMENTAL.  Use with caution!
fs/xfs/scrub/scrub.c: "EXPERIMENTAL online scrub feature in use. Use at your own risk!");
fs/xfs/xfs_fsops.c:     "EXPERIMENTAL online shrink feature in use. Use at your own risk!");
fs/xfs/xfs_super.c:     xfs_warn(mp, "DAX enabled. Warning: EXPERIMENTAL, use at your own risk");
fs/xfs/xfs_super.c:     "EXPERIMENTAL Large extent counts feature in use. Use at your own risk!");
fs/xfs/xfs_xattr.c: "EXPERIMENTAL logged extended attributes feature in use. Use at your own risk!");
$

IOWs, I'll be adding a:

"EXPERIMENTAL block device provisioning in use. Use at your own risk!"

warning to XFS, and it won't get removed until both the XFS and
dm-thinp support is solid and production ready....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
