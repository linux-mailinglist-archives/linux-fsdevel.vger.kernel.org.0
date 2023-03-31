Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 162A36D26E8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Mar 2023 19:47:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231633AbjCaRr1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 31 Mar 2023 13:47:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjCaRr0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 31 Mar 2023 13:47:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 447D61DFB8;
        Fri, 31 Mar 2023 10:47:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D67ADB8313A;
        Fri, 31 Mar 2023 17:47:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FFF4C433A1;
        Fri, 31 Mar 2023 17:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680284842;
        bh=agncQKz6RRQ+z2AndB9egaUCjOR2XStw/8eDPUmcjT8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=PYEVYWIVUH7dS32tobiqHPv8N06Ir6XV+fO/AkMI4o66gPCmRSQrPmB/62RJDCjRX
         iha1oZWcgsdLkZM/rC/W4UwfQyPsdCwFKNrqffhv/EmPvwZJeb3/ObjFsJC5MhDerl
         6Cx7gxJLQOUG+zb6KxBg5qAHVQuMVVbqwicLztbutfgto8W9OzeTQAoEfC9vYWb3/6
         WbIN0UoYXvJIMjz85vPFsRQBCcHBixj1M8VbsRnNKUNQKfu4VoW2MuoVPGJO1e3WM0
         lskThRRIawrJ3Oyv3wDs0wMu+dVhpxnIUfenisVKNRTUmEG0HLG5WxSjGzb6R+Ni/e
         jLYxlUQypWhrw==
Received: by mail-lj1-f180.google.com with SMTP id s20so3581366ljp.7;
        Fri, 31 Mar 2023 10:47:22 -0700 (PDT)
X-Gm-Message-State: AAQBX9eNOdI5SU8oi0eu7AqwZQ0viFJ/v4IDc+T2/cikMeDc7CbcvFVp
        U4EQSfamlSBSzpKAqvvrxMXBhTrqR2uZ7QFKOU4=
X-Google-Smtp-Source: AKy350YsVC49X4YKPGPcvZZvpV/eK4Pm1deoqn4/arjrTKATbsjiI11VNkB5amsOZg1wLI0Ovo0EsryvUkWIU3e100g=
X-Received: by 2002:a2e:9d16:0:b0:2a6:16b4:40a2 with SMTP id
 t22-20020a2e9d16000000b002a616b440a2mr2329769lji.5.1680284840437; Fri, 31 Mar
 2023 10:47:20 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1680172791.git.johannes.thumshirn@wdc.com> <359e6d4d77ee175e2ce7c315a3176ca360e10fbc.1680172791.git.johannes.thumshirn@wdc.com>
In-Reply-To: <359e6d4d77ee175e2ce7c315a3176ca360e10fbc.1680172791.git.johannes.thumshirn@wdc.com>
From:   Song Liu <song@kernel.org>
Date:   Fri, 31 Mar 2023 10:47:08 -0700
X-Gmail-Original-Message-ID: <CAPhsuW5twFinPtGkAORYW04fqQP3L9NJZDX++_hAbKPrLbF95g@mail.gmail.com>
Message-ID: <CAPhsuW5twFinPtGkAORYW04fqQP3L9NJZDX++_hAbKPrLbF95g@mail.gmail.com>
Subject: Re: [PATCH v2 05/19] md: use __bio_add_page to add single page
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
> The md-raid superblock writing code uses bio_add_page() to add a page to =
a
> newly created bio. bio_add_page() can fail, but the return value is never
> checked.
>
> Use __bio_add_page() as adding a single page to a newly created bio is
> guaranteed to succeed.
>
> This brings us a step closer to marking bio_add_page() as __must_check.
>
> Signed-of_-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

Acked-by: Song Liu <song@kernel.org>
