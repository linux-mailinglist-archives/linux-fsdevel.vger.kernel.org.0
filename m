Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E7A56D276F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Mar 2023 20:01:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233067AbjCaSBB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 31 Mar 2023 14:01:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232607AbjCaSAi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 31 Mar 2023 14:00:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3492023B67;
        Fri, 31 Mar 2023 11:00:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C21BB62B01;
        Fri, 31 Mar 2023 18:00:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C3E2C4339B;
        Fri, 31 Mar 2023 18:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680285611;
        bh=9tXVcu579pVEe31v3uq18Kz/aIIJc6OZT76XuWimyYY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=YgNZHmOLXZ1VOoy/QrY5pCHfzk02sSFrQTFY8GMr48v+dR8Qt80AuSqjMT9CMiyQP
         ysZNr5rNQY3tgaZGR4Y4E1KmqnncUybRBlI9djM6dnMAKa0tGiX2HdStla1bqU8Rui
         SX81lbv3qxEedlQfzWSfKo2BQGXsCELkmxicunMqhmL9LK/7cwUaFfqONAQAgbsMka
         lq0p/rO2GGulMBtdSYkbfCG6qYULmX+4wfIogx/OKsjD4vMqSwXtkoGVEEvklS8Xlc
         lwmpE8dJGYL0g76IAqUKiRhYvDAfDoXONYgDuBSUCv3CEfs4DoVFQS7aOkePgsQ0J5
         lFU05B2XGayvg==
Received: by mail-lj1-f173.google.com with SMTP id h9so23934671ljq.2;
        Fri, 31 Mar 2023 11:00:11 -0700 (PDT)
X-Gm-Message-State: AAQBX9ez3i9uLcd7FRlo1TlPyn0LkWVnPKum46Tb6ws1Aq1n0WckI5nw
        3GQEOHRE5nw+ipDHLEB++sVkHtQPbu2onHm9Ij8=
X-Google-Smtp-Source: AKy350ZgbNojOjOEEz2nHphY2xJCW9wwsXYrrgwE3PRrjnKQvmDG5MKMnwlOL72DBVmaW0fPmBMmrb5gTNKFPGLQqzY=
X-Received: by 2002:a2e:a556:0:b0:29b:d43f:f68f with SMTP id
 e22-20020a2ea556000000b0029bd43ff68fmr5465915ljn.5.1680285609272; Fri, 31 Mar
 2023 11:00:09 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1680172791.git.johannes.thumshirn@wdc.com> <4c9eaedd34f80d3477a5049f49610a8da8859744.1680172791.git.johannes.thumshirn@wdc.com>
In-Reply-To: <4c9eaedd34f80d3477a5049f49610a8da8859744.1680172791.git.johannes.thumshirn@wdc.com>
From:   Song Liu <song@kernel.org>
Date:   Fri, 31 Mar 2023 10:59:57 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7AAKXuPtvfjR-UBq=QCbHOkqCQQk=GTAWZH0ysVxhECQ@mail.gmail.com>
Message-ID: <CAPhsuW7AAKXuPtvfjR-UBq=QCbHOkqCQQk=GTAWZH0ysVxhECQ@mail.gmail.com>
Subject: Re: [PATCH v2 16/19] md: raid1: use __bio_add_page for adding single
 page to bio
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
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 30, 2023 at 3:44=E2=80=AFAM Johannes Thumshirn
<johannes.thumshirn@wdc.com> wrote:
>
> The sync request code uses bio_add_page() to add a page to a newly create=
d bio.
> bio_add_page() can fail, but the return value is never checked.
>
> Use __bio_add_page() as adding a single page to a newly created bio is
> guaranteed to succeed.
>
> This brings us a step closer to marking bio_add_page() as __must_check.
>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

Acked-by: Song Liu <song@kernel.org>

Thanks!
