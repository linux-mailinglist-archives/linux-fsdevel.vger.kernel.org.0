Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75209700A6C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 May 2023 16:35:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241268AbjELOfZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 May 2023 10:35:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241288AbjELOfY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 May 2023 10:35:24 -0400
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FC4530C0
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 May 2023 07:34:34 -0700 (PDT)
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-3f3faefc92cso32666511cf.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 May 2023 07:34:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683902073; x=1686494073;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3NI8PblGX09aXcegfRrsRbp5Rk8EB7aSb1Q3zVJjhig=;
        b=fxXuTpN1g5xeiCXxFKxxbz4ZFtX/WXIQBVfAvMSZlxjfs0Ok6UzrMTcy0xtCctWDSy
         6FJ6dqAkMytdPnGPAn40mXLcPwDAQdgmu9YXrrdxXAjk1DKZx+trJzdAOyPWbMMyfcE/
         w2SP3JJzNEMS7sTJt4+dyeHUhxd8/mmPZeIDvFBeGZK4XS3Gc5bsPd2EoyOqZivPH9+i
         LPz8IHU4DWdupuLiUel5CxRJwdU3oMRRURpAJlHlRtm9nK/YLvXgC0n+Xe8iMnmVVQUQ
         NCqSROYi6knpUzFjCllFiYpotkFtt+5MefgKWtPFdxPeBHbnMnBaDWzhwnYCr4CxCJU6
         DzVg==
X-Gm-Message-State: AC+VfDzS8u9M+QRV10y2lwMLcmvamAies5+MjWJYIO8B8pRwQ+3x6dEI
        eHe1bq3S4hC8nmkZKUqm9DVH
X-Google-Smtp-Source: ACHHUZ4M++aZz9x/idwKRxoZtFqzxE+KBfxysydbhwDNajJOH3TAbWPaBDcqWbbuEGec9dZSQIGwHA==
X-Received: by 2002:ac8:5787:0:b0:3f3:91bd:a46d with SMTP id v7-20020ac85787000000b003f391bda46dmr24764787qta.8.1683902073426;
        Fri, 12 May 2023 07:34:33 -0700 (PDT)
Received: from localhost (pool-68-160-166-30.bstnma.fios.verizon.net. [68.160.166.30])
        by smtp.gmail.com with ESMTPSA id f8-20020ae9ea08000000b0074d3233487dsm5387535qkg.114.2023.05.12.07.34.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 07:34:32 -0700 (PDT)
Date:   Fri, 12 May 2023 10:34:31 -0400
From:   Mike Snitzer <snitzer@kernel.org>
To:     Sarthak Kukreti <sarthakkukreti@chromium.org>,
        Jens Axboe <axboe@kernel.dk>,
        Brian Foster <bfoster@redhat.com>,
        "Darrick J. Wong" <djwong@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Theodore Ts'o <tytso@mit.edu>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Bart Van Assche <bvanassche@google.com>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        dm-devel@redhat.com, Andreas Dilger <adilger.kernel@dilger.ca>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        Alasdair Kergon <agk@redhat.com>
Subject: Re: [PATCH v6 4/5] dm-thin: Add REQ_OP_PROVISION support
Message-ID: <ZF5Od6GY4rsq82qM@redhat.com>
References: <20230420004850.297045-1-sarthakkukreti@chromium.org>
 <20230506062909.74601-1-sarthakkukreti@chromium.org>
 <20230506062909.74601-5-sarthakkukreti@chromium.org>
 <ZFp7ykxGFUbPG1ON@redhat.com>
 <CAG9=OMOMrFcy6UdL8-3wZGwOr1nqLm1bpvL+G1g2dvBhJWU2Kw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG9=OMOMrFcy6UdL8-3wZGwOr1nqLm1bpvL+G1g2dvBhJWU2Kw@mail.gmail.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 11 2023 at  4:03P -0400,
Sarthak Kukreti <sarthakkukreti@chromium.org> wrote:

> On Tue, May 9, 2023 at 9:58 AM Mike Snitzer <snitzer@kernel.org> wrote:
> >
> > On Sat, May 06 2023 at  2:29P -0400,
> > Sarthak Kukreti <sarthakkukreti@chromium.org> wrote:
> >
> > > dm-thinpool uses the provision request to provision
> > > blocks for a dm-thin device. dm-thinpool currently does not
> > > pass through REQ_OP_PROVISION to underlying devices.
> > >
> > > For shared blocks, provision requests will break sharing and copy the
> > > contents of the entire block. Additionally, if 'skip_block_zeroing'
> > > is not set, dm-thin will opt to zero out the entire range as a part
> > > of provisioning.
> > >
> > > Signed-off-by: Sarthak Kukreti <sarthakkukreti@chromium.org>
> > > ---
> > >  drivers/md/dm-thin.c | 70 +++++++++++++++++++++++++++++++++++++++++---
> > >  1 file changed, 66 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/drivers/md/dm-thin.c b/drivers/md/dm-thin.c
> > > index 2b13c949bd72..3f94f53ac956 100644
> > > --- a/drivers/md/dm-thin.c
> > > +++ b/drivers/md/dm-thin.c
> > > @@ -4288,6 +4347,9 @@ static int thin_ctr(struct dm_target *ti, unsigned int argc, char **argv)
> > >               ti->max_discard_granularity = true;
> > >       }
> > >
> > > +     ti->num_provision_bios = 1;
> > > +     ti->provision_supported = true;
> > > +
> >
> > We need this in thin_ctr: ti->max_provision_granularity = true;
> >
> > More needed in the thin target than thin-pool; otherwise provision bio
> > issued to thin devices won't be split appropriately.  But I do think
> > its fine to set in both thin_ctr and pool_ctr.
> >
> > Otherwise, looks good.
> >
> Thanks! I'll add it to the next iteration (in addition to any other
> feedback that's added to v6).

OK. I'll begin basing dm-thinp's WRITE_ZEROES support ontop of this
series.
 
> Given that this series covers multiple subsystems, would there be a
> preferred way of queueing this for merge?

I think it'd be OK for Jens to pick this series up and I'll rebase
my corresponding DM tree once he does.

In addition to Jens; Brian, Darrick and/or others: any chance you
could review the block core changes in this series to ensure you're
cool with them?

Would be nice to get Sarthak review feedback so that hopefully his v7
can be the final revision.

Thanks,
Mike
