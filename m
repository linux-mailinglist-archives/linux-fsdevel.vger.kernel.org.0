Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 358DD52CA1D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 May 2022 05:12:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbiESDMo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 May 2022 23:12:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbiESDMl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 May 2022 23:12:41 -0400
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED95F47540;
        Wed, 18 May 2022 20:12:40 -0700 (PDT)
Received: by mail-pg1-f178.google.com with SMTP id c22so3883432pgu.2;
        Wed, 18 May 2022 20:12:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9JN0fB16G2C30bXw00o2rKWge5ToDKtDbnbvpwNdZkI=;
        b=qBa5S3cilpX9Sq52HTio/pIwxayAm8tzmzCBATKHbM+RkDyNpih22/vbDkPtOyIiKo
         45VyYxGdQRf/FotsEmBq0A3fpRjP7qVlM5dbO7EIoVIUD/WnfLfZjW6lwo5v5KnDWTK0
         dZM+iQuttRJOim9M3hDLO3HovrT84rvJqFGump6OWT7kDWgD+IEZTOSICalsOnLg3BG0
         1p8ocu+fxQCUlcMc5KJ+iKuWdGswNj/g9kRiCOx6g8VJ5zKD20HQm98c8+vEgK4OuF2G
         bukWJGJ0tKuFP0hoeYE6gGMBsMfWj9y2WeWpaBfk2ump/fByPWoktoAW2Wiyuiuf6m1S
         Jscw==
X-Gm-Message-State: AOAM530xiao3JrlHF6Ox5a8BT3W2bfKqAVlknjD5ZMKGvfoy42sMqRNm
        QN48BDbNg9jXzuV9Frw0y4U=
X-Google-Smtp-Source: ABdhPJyrgMJtrLlwQnNIwf+NjlQjBMAO/19qfMKeveD8EoHEa/Q7M6uMkO2ILqaysBSDyiNbhhYuDQ==
X-Received: by 2002:a63:1050:0:b0:3c2:2f7c:cc78 with SMTP id 16-20020a631050000000b003c22f7ccc78mr2222093pgq.238.1652929960314;
        Wed, 18 May 2022 20:12:40 -0700 (PDT)
Received: from garbanzo (136-24-173-63.cab.webpass.net. [136.24.173.63])
        by smtp.gmail.com with ESMTPSA id h8-20020a654048000000b003f26c2f583asm2231364pgp.61.2022.05.18.20.12.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 May 2022 20:12:39 -0700 (PDT)
Date:   Wed, 18 May 2022 20:12:37 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Theodore Ts'o <tytso@mit.edu>, Christoph Hellwig <hch@lst.de>,
        Pankaj Raghav <p.raghav@samsung.com>, axboe@kernel.dk,
        pankydev8@gmail.com, gost.dev@samsung.com,
        jiangbo.365@bytedance.com, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, dm-devel@redhat.com,
        dsterba@suse.com, linux-btrfs@vger.kernel.org
Subject: Re: [dm-devel] [PATCH v4 00/13] support non power of 2 zoned devices
Message-ID: <20220519031237.sw45lvzrydrm7fpb@garbanzo>
References: <CGME20220516165418eucas1p2be592d9cd4b35f6b71d39ccbe87f3fef@eucas1p2.samsung.com>
 <20220516165416.171196-1-p.raghav@samsung.com>
 <20220517081048.GA13947@lst.de>
 <YoPAnj9ufkt5nh1G@mit.edu>
 <7f9cb19b-621b-75ea-7273-2d2769237851@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7f9cb19b-621b-75ea-7273-2d2769237851@opensource.wdc.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 19, 2022 at 12:08:26PM +0900, Damien Le Moal wrote:
> On 5/18/22 00:34, Theodore Ts'o wrote:
> > On Tue, May 17, 2022 at 10:10:48AM +0200, Christoph Hellwig wrote:
> >> I'm a little surprised about all this activity.
> >>
> >> I though the conclusion at LSF/MM was that for Linux itself there
> >> is very little benefit in supporting this scheme.  It will massively
> >> fragment the supported based of devices and applications, while only
> >> having the benefit of supporting some Samsung legacy devices.
> > 
> > FWIW,
> > 
> > That wasn't my impression from that LSF/MM session, but once the
> > videos become available, folks can decide for themselves.
> 
> There was no real discussion about zone size constraint on the zone
> storage BoF. Many discussions happened in the hallway track though.

Right so no direct clear blockers mentioned at all during the BoF.

  Luis
