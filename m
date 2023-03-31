Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E8836D26ED
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Mar 2023 19:47:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231886AbjCaRr4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 31 Mar 2023 13:47:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjCaRry (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 31 Mar 2023 13:47:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B65922212;
        Fri, 31 Mar 2023 10:47:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BA53B62AE9;
        Fri, 31 Mar 2023 17:47:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24B97C433A0;
        Fri, 31 Mar 2023 17:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680284873;
        bh=DVCRJporzTiaASWUNIxQBYcRCs7BLYHGkjpMzyytTv4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=nLzpxrFZz13vPyy4wFw7JKbhrcPZW3g6rdIX41hBr3Eg6FG3bgP7km2dAypgYhdp2
         lDiE7j0An9C7oaBzG0F+m68NEEVH1Fi1Pf3o0UztN/japdLLMr2GmGKwewbkRcaQFX
         8ylFn9mD1FkZkrOqv43jBKheX/KwBLCPQXGvmrH3lCZuGUSpBmvavRq9pZVgb9ix22
         A+wYQL6lbQ79BoCWJRvPHDrqktAFEA1lS7EpSfk4C+VxltkB4D1kYH0uKubgv5Ahz8
         5JPbUJFZE53oIUF+tma0ByYlj+M8H3WcsdUe0Kym2sp2z1OyPxLHARRYH+84+fdO1v
         cZjt17X8Iaymg==
Received: by mail-lf1-f45.google.com with SMTP id bi9so29888299lfb.12;
        Fri, 31 Mar 2023 10:47:53 -0700 (PDT)
X-Gm-Message-State: AAQBX9dG8ghNZEbAzp8m6uk64/VWxyUNCq+Q3XjkidixscMnN2wYhVHo
        ALNowlY0WK0QjsT/1hGrG7viI6DERrGnz29DviA=
X-Google-Smtp-Source: AKy350aTqP2YrCOlXYcmu46Ms0g6qdRMyCTAq79Tt/w62oXAGnJ0At25MIChWLEF5VS5bhZp5mINAfnbMMsd5bIOwyY=
X-Received: by 2002:a05:6512:102b:b0:4ea:f9d4:9393 with SMTP id
 r11-20020a056512102b00b004eaf9d49393mr8226521lfr.3.1680284871209; Fri, 31 Mar
 2023 10:47:51 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1680172791.git.johannes.thumshirn@wdc.com> <d406d7e205f7c7e701275674f77c7e21b93ae7a5.1680172791.git.johannes.thumshirn@wdc.com>
In-Reply-To: <d406d7e205f7c7e701275674f77c7e21b93ae7a5.1680172791.git.johannes.thumshirn@wdc.com>
From:   Song Liu <song@kernel.org>
Date:   Fri, 31 Mar 2023 10:47:37 -0700
X-Gmail-Original-Message-ID: <CAPhsuW6WUKpMawtw-RE_PsfTcPCtUeTEF5YOEwmVNT+wM7OofQ@mail.gmail.com>
Message-ID: <CAPhsuW6WUKpMawtw-RE_PsfTcPCtUeTEF5YOEwmVNT+wM7OofQ@mail.gmail.com>
Subject: Re: [PATCH v2 06/19] md: raid5-log: use __bio_add_page to add single page
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
> The raid5 log metadata submission code uses bio_add_page() to add a page
> to a newly created bio. bio_add_page() can fail, but the return value is
> never checked.
>
> Use __bio_add_page() as adding a single page to a newly created bio is
> guaranteed to succeed.
>
> This brings us a step closer to marking bio_add_page() as __must_check.
>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

Acked-by: Song Liu <song@kernel.org>
