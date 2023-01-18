Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 298A5672A80
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jan 2023 22:30:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbjARVaT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Jan 2023 16:30:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbjARVaS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Jan 2023 16:30:18 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C937218ABC
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Jan 2023 13:29:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674077372;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Sgrplrrtl/JeKkdAn9eoyBLOdhX4O8ZNOPv4rP/Tf+8=;
        b=UnhrUfiRda5aWw/t8m536rY/M9Ow6CAzDsTRfayklWBVo5MPbQpZZgT2gO3EgS9SECMHpu
        7M397N83abRely1AGmkyCVcLNaawtK9Qi+wjpRiKke6lcH2Ci1NWUXymvrwPwQz6AePD8P
        r87SS8lu0neuYBO0rmnbQhvLvM66gS8=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-127-CQ_zTcfMPrGZ7c_L4SmUaw-1; Wed, 18 Jan 2023 16:29:31 -0500
X-MC-Unique: CQ_zTcfMPrGZ7c_L4SmUaw-1
Received: by mail-pg1-f199.google.com with SMTP id k16-20020a635a50000000b0042986056df6so15906910pgm.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Jan 2023 13:29:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Sgrplrrtl/JeKkdAn9eoyBLOdhX4O8ZNOPv4rP/Tf+8=;
        b=YXE4oFptqfN7b1X9lYFi7EU6zZ9KgsJzYgic0PMCHpoQXB+ULfvtueGijex1ukABWU
         HAXzE1345wQH2qsrfMYUMtmGgG2vdSoV20WsIyyu4zKhGpxbclIMy9HDtv4w4Xs3CmtH
         vFJe2Q/nIt46bC6ilKcBjUnjiUu9N8tVltZAb818c5Y7n2pz14kOSQF80O4Dkkqx50+f
         qxVqHvnKSmxT0AXZNsJzn5UTsU/nqP0uFC6l4MsDf8SPemVOglEg9gvAj43g1mAX6Mlt
         W284R+sN3eXM7UPoD7v3Qv7DEAF8DZbn8nyaLGqY9Yc3hYIOTf9ml32mUSrKkUGr6iUu
         WiRQ==
X-Gm-Message-State: AFqh2kpd7YiNM2wFiOPAkHyYdhrFC53FFSNE6spvGSdFtkielqyh4GlY
        gclesb3+IKm78UqLZ6kbzazg6dUFlN5EyhOL5k6kZnpTFBbdu2YXf+qZmQXsO51XzSj5KwillQ1
        tUi/VC1aKNppAyauTFJLMppdproUTaqwq4mN9Q9/zzg==
X-Received: by 2002:a17:902:f7d6:b0:189:7bfe:1eb5 with SMTP id h22-20020a170902f7d600b001897bfe1eb5mr917419plw.9.1674077370837;
        Wed, 18 Jan 2023 13:29:30 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtt8Vh026otGCgJCUSMBcM83glTyjDfkf6G3KKQhFlnMIb8gayL+YQjl2rTZdZ5Cg6bVwzX68lSAO8FECFB4bA=
X-Received: by 2002:a17:902:f7d6:b0:189:7bfe:1eb5 with SMTP id
 h22-20020a170902f7d600b001897bfe1eb5mr917417plw.9.1674077370613; Wed, 18 Jan
 2023 13:29:30 -0800 (PST)
MIME-Version: 1.0
References: <167406781753.2327912.4817970864551606145.stg-ugh@magnolia>
In-Reply-To: <167406781753.2327912.4817970864551606145.stg-ugh@magnolia>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Wed, 18 Jan 2023 22:29:19 +0100
Message-ID: <CAHc6FU4UQuxayGxkfwuU2PAXP+ho=jy+xHA2wFXWfb3C7TKOOQ@mail.gmail.com>
Subject: Re: [ANNOUNCE] xfs-linux: iomap-for-next updated to 471859f57d42
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     david@fromorbit.com, hch@lst.de, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 18, 2023 at 8:01 PM Darrick J. Wong <djwong@kernel.org> wrote:
> Hi folks,
>
> The iomap-for-next branch of the xfs-linux repository at:
>
> git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git
>
> has just been updated.
>
> Patches often get missed, so please check if your outstanding patches
> were in this update. If they have not been in this update, please
> resubmit them to linux-xfs@vger.kernel.org so they can be picked up in
> the next update.
>
> Just so everyone knows -- I've been summoned for local jury duty
> service, which means that I will be out starting January 30th until
> further notice.  "Further notice" could mean February 1st, or it could
> mean March 1st.  Hopefully there won't be any other iomap changes
> necessary for 6.3; I'll post here again when I figure out what the
> backup plan is.  It is likely that I will be summoned *again* for
> federal service before the end of 2023.
>
> The new head of the iomap-for-next branch is commit:
>
> 471859f57d42 iomap: Rename page_ops to folio_ops
>
> 8 new commits:
>
> Andreas Gruenbacher (8):
> [7a70a5085ed0] iomap: Add __iomap_put_folio helper
> [80baab88bb93] iomap/gfs2: Unlock and put folio in page_done handler
> [40405dddd98a] iomap: Rename page_done handler to put_folio
> [98321b5139f9] iomap: Add iomap_get_folio helper
> [9060bc4d3aca] iomap/gfs2: Get page in page_prepare handler
> [07c22b56685d] iomap: Add __iomap_get_folio helper
> [c82abc239464] iomap: Rename page_prepare handler to get_folio
> [471859f57d42] iomap: Rename page_ops to folio_ops
>
> Code Diffstat:
>
> fs/gfs2/bmap.c         | 38 ++++++++++++++-------
> fs/iomap/buffered-io.c | 91 +++++++++++++++++++++++++++++++++-----------------
> fs/xfs/xfs_iomap.c     |  4 +--
> include/linux/iomap.h  | 27 ++++++++-------
> 4 files changed, 103 insertions(+), 57 deletions(-)

Thanks, Darrick.

Andreas

