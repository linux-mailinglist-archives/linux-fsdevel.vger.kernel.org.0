Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A864471F250
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Jun 2023 20:47:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231883AbjFASrB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Jun 2023 14:47:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230472AbjFASrA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Jun 2023 14:47:00 -0400
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90498197
        for <linux-fsdevel@vger.kernel.org>; Thu,  1 Jun 2023 11:46:08 -0700 (PDT)
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6260f03b76dso10606216d6.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 01 Jun 2023 11:46:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685645167; x=1688237167;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OhyufVORgAPdxy2e2nylP7DQVEhvcm7KBzR049ls10E=;
        b=bNQMjXePmmunW7hXRqHMnDvSx0X6M0h0JdPCiB3jp5KEpPOdF9076XWqjpxV5GYdvk
         7/oD8P2fgxfcy1kFPJZBHiuTxqDYaSzlIIVHJ1KFISLq/7Nxt3dTGZxCGyqFOWefs+YW
         i4vEBgu5QrsePBZ6Q4iGN4RNGPhZXn28UxKNOPfohzfgbyXnftBY1gkq2yMdt7dxQTkR
         xzBTvAhcqb7P2WfRbg1lrTTlMGCaZGYD29eO8S7pIDw/tIorvMtOaniej4sfIvvBMTWK
         GPS7zbSJnDXWGFYZXBKx7DZelBNOIgzrsiW2OChgsMqfvOSr02Q6unkxsSZM/sBzSVgS
         N3bQ==
X-Gm-Message-State: AC+VfDxe4zwaG4WVozjnMFBhgcBuhZanKQ+NuCoXm8q/F1p0TlQzaQmx
        CpImccFhPNk/UY79nA/79CUF
X-Google-Smtp-Source: ACHHUZ6u3xR1YiMGmuLlFSVcpQijECu4NK+3gxplM1YXFxd6uPbdqueU4kLpHglpcsupIu+Tz62ckA==
X-Received: by 2002:a05:6214:aca:b0:625:b849:fa3 with SMTP id g10-20020a0562140aca00b00625b8490fa3mr11540334qvi.30.1685645167691;
        Thu, 01 Jun 2023 11:46:07 -0700 (PDT)
Received: from localhost (pool-68-160-166-30.bstnma.fios.verizon.net. [68.160.166.30])
        by smtp.gmail.com with ESMTPSA id y3-20020ac87c83000000b003e89e2b3c23sm7940746qtv.58.2023.06.01.11.46.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 11:46:07 -0700 (PDT)
Date:   Thu, 1 Jun 2023 14:46:06 -0400
From:   Mike Snitzer <snitzer@kernel.org>
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     "axboe @ kernel . dk" <axboe@kernel.dk>, shaggy@kernel.org,
        damien.lemoal@wdc.com, kch@nvidia.com, agruenba@redhat.com,
        song@kernel.org, Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        linux-raid@vger.kernel.org, jfs-discussion@lists.sourceforge.net,
        willy@infradead.org, ming.lei@redhat.com, cluster-devel@redhat.com,
        linux-mm@kvack.org, dm-devel@redhat.com,
        linux-block@vger.kernel.org, rpeterso@redhat.com,
        linux-fsdevel@vger.kernel.org, hch@lst.de
Subject: Re: [PATCH v5 16/20] dm-crypt: check if adding pages to clone bio
 fails
Message-ID: <ZHjnbkcpZ/yZWRsE@redhat.com>
References: <20230502101934.24901-1-johannes.thumshirn@wdc.com>
 <20230502101934.24901-17-johannes.thumshirn@wdc.com>
 <alpine.LRH.2.21.2305301045220.3943@file01.intranet.prod.int.rdu2.redhat.com>
 <ZHYbIYxGbcXbpvIK@redhat.com>
 <alpine.LRH.2.21.2305301527410.18906@file01.intranet.prod.int.rdu2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.21.2305301527410.18906@file01.intranet.prod.int.rdu2.redhat.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 30 2023 at  3:43P -0400,
Mikulas Patocka <mpatocka@redhat.com> wrote:

> 
> 
> On Tue, 30 May 2023, Mike Snitzer wrote:
> 
> > On Tue, May 30 2023 at 11:13P -0400,
> > Mikulas Patocka <mpatocka@redhat.com> wrote:
> > 
> > > Hi
> > > 
> > > I nack this. This just adds code that can't ever be executed.
> > > 
> > > dm-crypt already allocates enough entries in the vector (see "unsigned int 
> > > nr_iovecs = (size + PAGE_SIZE - 1) >> PAGE_SHIFT;"), so bio_add_page can't 
> > > fail.
> > > 
> > > If you want to add __must_check to bio_add_page, you should change the 
> > > dm-crypt code to:
> > > if (!bio_add_page(clone, page, len, 0)) {
> > > 	WARN(1, "this can't happen");
> > > 	return NULL;
> > > }
> > > and not write recovery code for a can't-happen case.
> > 
> > Thanks for the review Mikulas. But the proper way forward, in the
> > context of this patchset, is to simply change bio_add_page() to
> > __bio_add_page()
> > 
> > Subject becomes: "dm crypt: use __bio_add_page to add single page to clone bio"
> > 
> > And header can explain that "crypt_alloc_buffer() already allocates
> > enough entries in the clone bio's vector, so bio_add_page can't fail".
> > 
> > Mike
> 
> Yes, __bio_add_page would look nicer. But bio_add_page can merge adjacent 
> pages into a single bvec entry and __bio_add_page can't (I don't know how 
> often the merging happens or what is the performance implication of 
> non-merging).
> 
> I think that for the next merge window, we can apply this patch: 
> https://listman.redhat.com/archives/dm-devel/2023-May/054046.html
> which makes this discussion irrelevant. (you can change bio_add_page to 
> __bio_add_page in it)

Yes, your patch is on my TODO list.  I've rebased my dm-6.5 branch on
the latest block 6.5 branch.  I'll be reviewing/rebasing/applying your
patch soon.

Mike
