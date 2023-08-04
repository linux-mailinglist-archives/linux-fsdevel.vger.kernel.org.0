Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24E0176F951
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Aug 2023 07:09:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233558AbjHDFJT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Aug 2023 01:09:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233797AbjHDFHp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Aug 2023 01:07:45 -0400
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0EC949F9;
        Thu,  3 Aug 2023 22:04:38 -0700 (PDT)
Received: by mail-ua1-x92e.google.com with SMTP id a1e0cc1a2514c-79a0b4c6314so1790145241.1;
        Thu, 03 Aug 2023 22:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691125478; x=1691730278;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gvHhQK58HED/Jid4BEU/8KSn5E/19+2WUDX2YX8J0Ko=;
        b=o9IkCnlJqf9fY5gy5fVwkiUJZ8iZ9Aas2C2/zh0DiHTx4LpNqcMZlkdMxITlOzTPD8
         2aRncGgbqPq91v/0LtcDvDi9gSK5UqbQjqaSIuz68NJB/TywdgsRaiusrFpo5ZDNJvM3
         5Q2bxAOzGs+xNKN49s1hCYbX+xnxEd8ZbVc1Jez05IsR8AxvQmPIBU6pIgVMqeIS/Olq
         ejkIH4vD76wZSX62Gg4NUPpx7pu+YIgWaArL5J1SZywhq143O42TygZ+nNZqRNUpyLEu
         qJ2IGSXe3NrAMJVgKZOHexBd+lqWhCoMuA0va/s2sFUTqGuRkjyQQthZd2zAjAwqTyny
         EDLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691125478; x=1691730278;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gvHhQK58HED/Jid4BEU/8KSn5E/19+2WUDX2YX8J0Ko=;
        b=dZQnb8jfICl06X6wauK2Ihc9Fj5H3T/RbnjsXoPdQPPNzVDwLt26uWYKiXZrpSktCo
         +l5fvDZhsxDSC5LYd7c5pzjmqq7SzQEl9CCzecCA7bbIDZuJPK1Ftw8vWgSs2m/Bfr/7
         ab1sa4t3vRJaMoXZgGQOvYB9o/QGFx+fijVvjwSN4GMm0aWk7FslsFRX41U3ZiwWDHZ4
         NQmMoukLcNCIvoihG8pEI7+0Ydfs9V6FHrpjWFLMykCy6o3m485w++9R3ZU3p1E+cDEz
         4iFx7JkRGMeKG+hMBDmVle9P8E9dy7MXIjfq583wlVjqGjNj4POlmo9RJTkK8Vv2ya+q
         S1zg==
X-Gm-Message-State: AOJu0YzbPK8vyTvEuFf1uPo0ApLHW9mRdP1005EKbChxDF0bhGt8uBfu
        o+X7YZ7g1f5MD82nqzo8tdOTapgrojvBEFNxQ5k=
X-Google-Smtp-Source: AGHT+IHNlmuDpCynSERah/vCquBxetRq9r7u42oTgr/VU7wlUccU2TExBBmj/xqkyTsCXU4NxoOZF0G4gs/bioVSm0c=
X-Received: by 2002:a05:6102:3d08:b0:43f:619a:f05e with SMTP id
 i8-20020a0561023d0800b0043f619af05emr265046vsv.0.1691125477868; Thu, 03 Aug
 2023 22:04:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230802154131.2221419-1-hch@lst.de> <20230802154131.2221419-3-hch@lst.de>
In-Reply-To: <20230802154131.2221419-3-hch@lst.de>
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date:   Fri, 4 Aug 2023 14:04:21 +0900
Message-ID: <CAKFNMok5+MeOWcRg6o8W0tKjW=dTupXdwyqivou+RydZP423fw@mail.gmail.com>
Subject: Re: [PATCH 02/12] nilfs2: use setup_bdev_super to de-duplicate the
 mount code
To:     Christoph Hellwig <hch@lst.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Jan Kara <jack@suse.cz>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, linux-btrfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-nilfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 3, 2023 at 12:41=E2=80=AFAM Christoph Hellwig wrote:
>
> Use the generic setup_bdev_super helper to open the main block device
> and do various bits of superblock setup instead of duplicating the
> logic.  This includes moving to the new scheme implemented in common
> code that only opens the block device after the superblock has allocated.
>
> It does not yet convert nilfs2 to the new mount API, but doing so will
> become a bit simpler after this first step.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>

This patch itself looks to properly convert nilfs_mount etc.  Thank you so =
much.

Regards,
Ryusuke Konishi
