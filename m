Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0DF64D5AA3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Mar 2022 06:32:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346380AbiCKFdI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Mar 2022 00:33:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234001AbiCKFdE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Mar 2022 00:33:04 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D9111AC287;
        Thu, 10 Mar 2022 21:32:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0BD32B82A83;
        Fri, 11 Mar 2022 05:31:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E1FDC340EC;
        Fri, 11 Mar 2022 05:31:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646976717;
        bh=WZxaV6Pf7jSxcq9QhrqU6a6XmApG4E+JJxhTiL/TA4o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ob5ZHIgSUc7ffS1WUTii9bnVJtzk8WPUoL3UEGmI8LA/pPfuNB7aJAOSKJzkWpSQi
         6LyEO8syF9aVEj5/kWXYkHf64UtKZowR1dt+yzXVzuHt8QOILVdmvn14AWZfemWF8Z
         gRioblA5Yz3SMTchKuF0GTeIOFpHmvK2xP0Mt+8Racw4eelPzbjPuQLoTUM9PoLYpb
         lOoPGvSqe3ouw9n3e/szesfGwcLH1zHCJEA3pyUnIMcJq/RMLFZ79HFRQCQJf92kuL
         uu20kCmRhPJKE+nq/8Zu1kvu65ugM6zpbwbC3JAuQP+nEoBNPld58rMB3p3IbgSHYE
         ls+X6siohQP0A==
Date:   Thu, 10 Mar 2022 21:31:55 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     "Bean Huo (beanhuo)" <beanhuo@micron.com>,
        Jens Axboe <axboe@kernel.dk>,
        "Luca Porzio (lporzio)" <lporzio@micron.com>,
        Manjong Lee <mj0123.lee@samsung.com>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "hch@lst.de" <hch@lst.de>, "kbusch@kernel.org" <kbusch@kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "song@kernel.org" <song@kernel.org>,
        "seunghwan.hyun@samsung.com" <seunghwan.hyun@samsung.com>,
        "sookwan7.kim@samsung.com" <sookwan7.kim@samsung.com>,
        "nanich.lee@samsung.com" <nanich.lee@samsung.com>,
        "woosung2.lee@samsung.com" <woosung2.lee@samsung.com>,
        "yt0928.kim@samsung.com" <yt0928.kim@samsung.com>,
        "junho89.kim@samsung.com" <junho89.kim@samsung.com>,
        "jisoo2146.oh@samsung.com" <jisoo2146.oh@samsung.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [EXT] Re: [PATCH 2/2] block: remove the per-bio/request write
 hint.
Message-ID: <YireyyQvUnC7cik+@sol.localdomain>
References: <20220306231727.GP3927073@dread.disaster.area>
 <CGME20220309042324epcas1p111312e20f4429dc3a17172458284a923@epcas1p1.samsung.com>
 <20220309133119.6915-1-mj0123.lee@samsung.com>
 <CO3PR08MB797524ACBF04B861D48AF612DC0B9@CO3PR08MB7975.namprd08.prod.outlook.com>
 <e98948ae-1709-32ef-e1e4-063be38609b1@kernel.dk>
 <CO3PR08MB797562AAE72BC201EB951C6CDC0B9@CO3PR08MB7975.namprd08.prod.outlook.com>
 <d477c7bf-f3a7-ccca-5472-f9cbb05b83c1@kernel.dk>
 <c27a5ec3-f683-d2a7-d5e7-fd54d2baa278@acm.org>
 <PH0PR08MB7889642784B2E1FC1799A828DB0B9@PH0PR08MB7889.namprd08.prod.outlook.com>
 <9d645cf0-1685-437a-23e4-b2a01553bba5@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9d645cf0-1685-437a-23e4-b2a01553bba5@acm.org>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 10, 2022 at 02:18:19PM -0800, Bart Van Assche wrote:
> On 3/10/22 13:52, Bean Huo (beanhuo) wrote:
> > Yes, in upstream linux and upstream android, there is no such code. But as we know,
> > mobile customers have used bio->bi_write_hint in their products for years. And the
> > group ID is set according to bio->bi_write_hint before passing the CDB to UFS.
> > 
> > 
> > 	lrbp = &hba->lrb[tag];
> >                WARN_ON(lrbp->cmd);
> >               + if(cmd->cmnd[0] == WRITE_10)
> >                +{
> >                  +             cmd->cmnd[6] = (0x1f& cmd->request->bio->bi_write_hint);
> >                +}
> >                lrbp->cmd = cmd;
> >                lrbp->sense_bufflen = UFS_SENSE_SIZE;
> >                lrbp->sense_buffer = cmd->sense_buffer;
> > 
> > I don't know why they don't push these changes to the community, maybe
> > it's because changes across the file system and block layers are unacceptable to the
> > block layer and FS. but for sure we should now warn them to push to the
> > community as soon as possible.
> 
> Thanks Bean for having shared this information. I think the above code sets the GROUP
> NUMBER information in the WRITE(10) command and also that the following text from the
> UFS specification applies to that information:
> <quote>
> GROUP NUMBER: Notifies the Target device that the data linked to a ContextID:
>  -----------------------------------------------------------------------------------------
>     GROUP NUMBER Value     |  Function
>  -----------------------------------------------------------------------------------------
>  00000b                    | Default, no Context ID is associated with the read operation.
>  00001b to 01111b (0XXXXb) | Context ID. (XXXX I from 0001b to 1111b ‐ Context ID value)
>  10000b                    | Data has System Data characteristics
>  10001b to 11111b          | Reserved
>  -----------------------------------------------------------------------------------------
> 
> In case the GROUP NUMBER is set to a reserved value, the operation shall fail and a status
> response of CHECK CONDITION will be returned along with the sense key set to ILLEGAL REQUEST.
> </quote>
> 
> Since there is a desire to remove the write hint information from struct bio, is there
> any other information the "system data characteristics" information can be derived from?
> How about e.g. deriving that information from request flags like REQ_SYNC, REQ_META and/or
> REQ_IDLE?
> 

[+Cc linux-f2fs-devel]

I think the f2fs developers will need to chime in here, as it looks like f2fs
uses the write hints for different data categories like hot/cold/warm.  I'm not
sure those can be fully represented by other bio flags.

Either way, the good news is that it sounds like this "GROUP NUMBER" thing is
part of the UFS standard.  So whatever the best way to support it is, it can
just be submitted upstream like any other standard UFS feature.  Why hasn't that
been done?

- Eric
