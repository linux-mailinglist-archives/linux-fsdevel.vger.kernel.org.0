Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 207E96DC90C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Apr 2023 18:06:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbjDJQGX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Apr 2023 12:06:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230220AbjDJQGW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Apr 2023 12:06:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA193E8;
        Mon, 10 Apr 2023 09:06:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3C95E614F3;
        Mon, 10 Apr 2023 16:06:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A04AC433EF;
        Mon, 10 Apr 2023 16:06:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681142780;
        bh=mwSxhzCg15RXyTCgR9LDyFgq4h2rR53nA455oB13C/U=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=uy9ZpuY0vy2vryhepr3pFQGMr8grlBUWulmlwmxtAdUIeGqBZT78A1zNPM7ZM7Pbg
         80BlDSor2Q+NUbN+Em6MmVaioJUZUyf2LJAD9cZ+T2g6nhq70CYWjg4DeSKfM2PJin
         /yuIKz9GE3XW7WgHPpfoCGqc87it9FAk84og7eiHrYZR0nUcmeXUdYrcGpIz4A+5ID
         7cVAEXwb0z7wdLObf180ptGHtrhmTtMJOYLSOjva3fYYT5jQZM0vZYSGo8dQq2ovp5
         4G0gsxRWgyHIREk2+mwCWjD0hmYsYFutawlh5pd7JCr/rKeTfdXyrsI34BbeUW0wkr
         wbbmJTsRjleyA==
Received: by mail-lj1-f178.google.com with SMTP id n22so3923469ljq.8;
        Mon, 10 Apr 2023 09:06:20 -0700 (PDT)
X-Gm-Message-State: AAQBX9f5g2ZVXNPpeUtF6UM/67NGFKNHxx7nMqf3hDry6+f+97kT/XMT
        AN5HIyazqwSvu2xTfehztDrApsfBXwJ1P7AUfkc=
X-Google-Smtp-Source: AKy350ZYTf5+tNtIInJ56xYELpkw807n6pcDQqxLzwYNn5kC/wsk/lyy0ZRj6GpVdiG1eSqStA2SCDFU3pUWbh96/vU=
X-Received: by 2002:a2e:b0e2:0:b0:2a5:fe8f:b314 with SMTP id
 h2-20020a2eb0e2000000b002a5fe8fb314mr2152243ljl.5.1681142778696; Mon, 10 Apr
 2023 09:06:18 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1680172791.git.johannes.thumshirn@wdc.com>
 <8b8a3bb2db8c5183ef36c1810f2ac776ac526327.1680172791.git.johannes.thumshirn@wdc.com>
 <CAPhsuW7a+mpn+VprfA2mC5Fc+M9BFq8i6d-y+-o5G1u5dOsk2Q@mail.gmail.com> <bbc98aa3-24f0-8ee6-9d74-483564a14f0f@kernel.org>
In-Reply-To: <bbc98aa3-24f0-8ee6-9d74-483564a14f0f@kernel.org>
From:   Song Liu <song@kernel.org>
Date:   Mon, 10 Apr 2023 09:06:06 -0700
X-Gmail-Original-Message-ID: <CAPhsuW4yQjNgHZpw4UzkhC+GkY+aAFSjC-PDQFFoL-Wg-u2r1Q@mail.gmail.com>
Message-ID: <CAPhsuW4yQjNgHZpw4UzkhC+GkY+aAFSjC-PDQFFoL-Wg-u2r1Q@mail.gmail.com>
Subject: Re: [PATCH v2 17/19] md: raid1: check if adding pages to resync bio fails
To:     Johannes Thumshirn <jth@kernel.org>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
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

On Tue, Apr 4, 2023 at 1:26=E2=80=AFAM Johannes Thumshirn <jth@kernel.org> =
wrote:
>
> On 31/03/2023 20:13, Song Liu wrote:
> > On Thu, Mar 30, 2023 at 3:44=E2=80=AFAM Johannes Thumshirn
> > <johannes.thumshirn@wdc.com> wrote:
> >>
> >> Check if adding pages to resync bio fails and if bail out.
> >>
> >> As the comment above suggests this cannot happen, WARN if it actually
> >> happens.
> >>
> >> This way we can mark bio_add_pages as __must_check.
> >>
> >> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> >> Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> >> ---
> >>   drivers/md/raid1-10.c |  7 ++++++-
> >>   drivers/md/raid10.c   | 12 ++++++++++--
> >>   2 files changed, 16 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/drivers/md/raid1-10.c b/drivers/md/raid1-10.c
> >> index e61f6cad4e08..c21b6c168751 100644
> >> --- a/drivers/md/raid1-10.c
> >> +++ b/drivers/md/raid1-10.c
> >> @@ -105,7 +105,12 @@ static void md_bio_reset_resync_pages(struct bio =
*bio, struct resync_pages *rp,
> >>                   * won't fail because the vec table is big
> >>                   * enough to hold all these pages
> >>                   */
> >
> > We know these won't fail. Shall we just use __bio_add_page?
>
> We could yes, but I kind of like the assert() style warning.
> But of cause ultimately your call.

The assert() style warning is fine. In this case, please remove the
"won't fail ..." comments.

Thanks,
Song
