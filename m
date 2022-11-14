Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 029C5627B81
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Nov 2022 12:07:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236644AbiKNLH1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Nov 2022 06:07:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236619AbiKNLHL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Nov 2022 06:07:11 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2600C1F9F9;
        Mon, 14 Nov 2022 03:07:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B755260FC6;
        Mon, 14 Nov 2022 11:07:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B6FAC433C1;
        Mon, 14 Nov 2022 11:07:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668424030;
        bh=BBQzIyZZF5rlbBw98y1P4gBlWGiyde5VKcuft9ToRAY=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=A/TWlCEXkE5eooKrE2sEkXhKTjGb3+uPZCt/nWSjrS0c0XadKDRzxeuS7AKBK/yPt
         T1mF7ErfYbnVFTcUAffc67ZaVM1VXjUavuw9Jh8RXHmQC5lLEJP2rm8+f9O8GxbMlS
         glXGyBrF6446yghIoXpRloUtXLUSmptRJNSdEtSPc2DnqXKONFWlsmDPs5YwmYYtKa
         xquA2tJgsHbSwtj78bz+6VAJKxQ9YGL2dXhsWmZXZLAOq14M76EVTsaJnGJlR8Vdux
         5jT8m1WsqQkVlcD3jEadQzW3SVWoMOasaECwL1e1swUImgx7WnD0qQWyLAujTGgMk5
         bGdUN6zX46vGQ==
Received: by mail-oo1-f50.google.com with SMTP id e11-20020a4ab14b000000b0049be568062bso1527106ooo.4;
        Mon, 14 Nov 2022 03:07:10 -0800 (PST)
X-Gm-Message-State: ANoB5pk0zpydysJme4Orkqfsh5n+dGtHICl7DHcvYt4XyfCkb3NX/pKM
        YhFUhFnTdblRamrrEpQ+3aLtMbtjpJgnEAIrmpo=
X-Google-Smtp-Source: AA0mqf7wDQwPA3pTOSPVjMBQXValCRkcy0eZQuDEsbG8KDjXL393R4wvF7iCYv59B/mzoOk4MhJydooBoEVZepSGpZ0=
X-Received: by 2002:a4a:b582:0:b0:49d:d7ad:4195 with SMTP id
 t2-20020a4ab582000000b0049dd7ad4195mr5275628ooo.44.1668424029332; Mon, 14 Nov
 2022 03:07:09 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6839:1a4e:0:0:0:0 with HTTP; Mon, 14 Nov 2022 03:07:08
 -0800 (PST)
In-Reply-To: <20221113162902.883850-2-hch@lst.de>
References: <20221113162902.883850-1-hch@lst.de> <20221113162902.883850-2-hch@lst.de>
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Mon, 14 Nov 2022 20:07:08 +0900
X-Gmail-Original-Message-ID: <CAKYAXd97CmO5AvKPzziaKiqtUManSgXzFQatynGojTNzaBk9gw@mail.gmail.com>
Message-ID: <CAKYAXd97CmO5AvKPzziaKiqtUManSgXzFQatynGojTNzaBk9gw@mail.gmail.com>
Subject: Re: [PATCH 1/9] extfat: remove ->writepage
To:     Christoph Hellwig <hch@lst.de>
Cc:     Sungjong Seo <sj1557.seo@samsung.com>, Jan Kara <jack@suse.com>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
        Dave Kleikamp <shaggy@kernel.org>,
        Bob Copeland <me@bobcopeland.com>,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        jfs-discussion@lists.sourceforge.net,
        linux-karma-devel@lists.sourceforge.net, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

2022-11-14 1:28 GMT+09:00, Christoph Hellwig <hch@lst.de>:
> ->writepage is a very inefficient method to write back data, and only
> used through write_cache_pages or a a fallback when no ->migrate_folio
> method is present.
>
> Set ->migrate_folio to the generic buffer_head based helper, and remove
> the ->writepage implementation.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>

Thanks!
