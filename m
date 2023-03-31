Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D60E46D26EF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Mar 2023 19:48:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229483AbjCaRsM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 31 Mar 2023 13:48:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232021AbjCaRsK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 31 Mar 2023 13:48:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1323386B5;
        Fri, 31 Mar 2023 10:48:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A35CC62AAA;
        Fri, 31 Mar 2023 17:48:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 135B4C4339B;
        Fri, 31 Mar 2023 17:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680284889;
        bh=74+LZlMHcYsg/Kzq6hhnAAWL6JxtgVVZqUzMUNQ+9TU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=UNa2dSd/YJ3OWEt3ocKdwXDSECZsjwAF+sgSOAj6rFRP2uU2VTSgrqv+37/KyZX0R
         Oa1rtE+HdXQ57EsXLRKHed0PUtcB3r+HUl/slAbr9KmCT64nkPp9C+L1muC7g3AYko
         x0HBD6mpFklhLAfXpr0SD/mHaJE60Egn1Ycyil95DM5uvLwv9pThyu4kj7cYW1NKJF
         2wC/BMl/Rt3SgA7s4BBVRPvEoNk6D0IGSJ+LyklyB5bOM8Dyygz3S3NAt75B2Yz5Vj
         FQihqGTii7u0idc33UB7apbMcdVFciTSFoYsqCVC8+voSaZG1pMqDFFi0B8kda72KB
         7Vx6VY6n2wEGA==
Received: by mail-lf1-f42.google.com with SMTP id x17so29954460lfu.5;
        Fri, 31 Mar 2023 10:48:08 -0700 (PDT)
X-Gm-Message-State: AAQBX9emNXqW9x2+wlan4pGD9Hnhwxo+6IZH0J7sfPjzsFdkjFColwXt
        RWB8Rf3xBqFx4rrO5nagN7ioSbFAqqkOKFj7bpI=
X-Google-Smtp-Source: AKy350aGmAaw8YhQDsMHFPqOZHOf0YFrm6+Qrmu1o39ibtrUhRAoJ2hJNrBTR72DBPR1w52lhQ7Kxsz8Es6oFrG/it4=
X-Received: by 2002:ac2:5d72:0:b0:4ea:e296:fead with SMTP id
 h18-20020ac25d72000000b004eae296feadmr8226352lft.3.1680284887179; Fri, 31 Mar
 2023 10:48:07 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1680172791.git.johannes.thumshirn@wdc.com> <29a2488aa641319199c597d1dc1151c700e32430.1680172791.git.johannes.thumshirn@wdc.com>
In-Reply-To: <29a2488aa641319199c597d1dc1151c700e32430.1680172791.git.johannes.thumshirn@wdc.com>
From:   Song Liu <song@kernel.org>
Date:   Fri, 31 Mar 2023 10:47:55 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7HoY_0fW12egZuirTX22LTQJvBw49MEaT5_sh4ty+xCw@mail.gmail.com>
Message-ID: <CAPhsuW7HoY_0fW12egZuirTX22LTQJvBw49MEaT5_sh4ty+xCw@mail.gmail.com>
Subject: Re: [PATCH v2 07/19] md: raid5: use __bio_add_page to add single page
 to new bio
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Hannes Reinecke <hare@suse.de>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        dm-devel@redhat.com, linux-raid@vger.kernel.org,
        Mike Snitzer <snitzer@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Dave Kleikamp <shaggy@kernel.org>,
        jfs-discussion@lists.sourceforge.net, cluster-devel@redhat.com,
        Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 30, 2023 at 3:44=E2=80=AFAM Johannes Thumshirn
<johannes.thumshirn@wdc.com> wrote:
>
> The raid5-ppl submission code uses bio_add_page() to add a page to a
> newly created bio. bio_add_page() can fail, but the return value is never
> checked. For adding consecutive pages, the return is actually checked and
> a new bio is allocated if adding the page fails.
>
> Use __bio_add_page() as adding a single page to a newly created bio is
> guaranteed to succeed.
>
> This brings us a step closer to marking bio_add_page() as __must_check.
>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

Acked-by: Song Liu <song@kernel.org>
