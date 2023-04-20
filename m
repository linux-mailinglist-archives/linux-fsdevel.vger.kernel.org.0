Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 531786E892D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Apr 2023 06:40:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233637AbjDTEkF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Apr 2023 00:40:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233502AbjDTEkC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Apr 2023 00:40:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27F1840D7;
        Wed, 19 Apr 2023 21:39:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B23EE642A4;
        Thu, 20 Apr 2023 04:39:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17FB0C433A8;
        Thu, 20 Apr 2023 04:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681965598;
        bh=e2kMjxLw00pT2+EDznrCtqL7waGns3hQPtXSEb5TvkE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=OZ9xegZ7ko8U1oo6qnsJk+3Pue6KDnodVJn0JAIQi6gTJIo4nyPvSZDS93d7D+vr6
         HIgyAvgojEeu4pt/P44ll5AqnZwiJHnbs6iMDCEqQSt7HwVSMWRrf4HqNSdo0BrgOs
         xe60XU9lC7sT4MIUWnPe+q4M56UlazdoGKbSZgDHhV2toutGfHKEiW2zHkBf82rtwg
         jZ1Ep03Bk3ysAlufjJiB3rHHPBUJanT/0EGQIb6R1EQpNOJRGLVX8GXOxyThgYx9dE
         LsZTtGjje+HVmrDl5lhNSNKWHgqslD5QxmtOpsTAaT5taPjWTrBab4k4khEjZkh+si
         KFUa9x5OVGXTA==
Received: by mail-lj1-f177.google.com with SMTP id x34so1433755ljq.1;
        Wed, 19 Apr 2023 21:39:57 -0700 (PDT)
X-Gm-Message-State: AAQBX9crgvlbT6zSJObHBAnv+dhQ+qzNfhVfg2PH3X7CcsnPVlDYcI+E
        xyhSr0RY+G7SncMTMqAnVFSSjosM5loxwX7h/S4=
X-Google-Smtp-Source: AKy350brjGRI86LwVWGkzPXSEalUdCI4Td6YNPTTcnNRSEuyUW/eSnxVnpWQ0bvhloD205Vvr5DEOhYwggyQMmUmPfI=
X-Received: by 2002:a2e:a313:0:b0:2a8:928d:2e2e with SMTP id
 l19-20020a2ea313000000b002a8928d2e2emr2679277lje.5.1681965595968; Wed, 19 Apr
 2023 21:39:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230419140929.5924-1-jth@kernel.org> <20230419140929.5924-18-jth@kernel.org>
In-Reply-To: <20230419140929.5924-18-jth@kernel.org>
From:   Song Liu <song@kernel.org>
Date:   Wed, 19 Apr 2023 21:39:44 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7n5Gb68+br0Cf47J5wu25FtTzfBs0cSihg49f2tSY8jA@mail.gmail.com>
Message-ID: <CAPhsuW7n5Gb68+br0Cf47J5wu25FtTzfBs0cSihg49f2tSY8jA@mail.gmail.com>
Subject: Re: [PATCH v3 17/19] md: raid1: check if adding pages to resync bio fails
To:     Johannes Thumshirn <jth@kernel.org>
Cc:     axboe@kernel.dk, johannes.thumshirn@wdc.com, agruenba@redhat.com,
        cluster-devel@redhat.com, damien.lemoal@wdc.com,
        dm-devel@redhat.com, dsterba@suse.com, hare@suse.de, hch@lst.de,
        jfs-discussion@lists.sourceforge.net, kch@nvidia.com,
        linux-block@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-raid@vger.kernel.org, ming.lei@redhat.com,
        rpeterso@redhat.com, shaggy@kernel.org, snitzer@kernel.org,
        willy@infradead.org,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 19, 2023 at 7:11=E2=80=AFAM Johannes Thumshirn <jth@kernel.org>=
 wrote:
>
> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>
> Check if adding pages to resync bio fails and if bail out.
>
> As the comment above suggests this cannot happen, WARN if it actually
> happens.
>
> This way we can mark bio_add_pages as __must_check.
>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

Acked-by: Song Liu <song@kernel.org>

Thanks!
