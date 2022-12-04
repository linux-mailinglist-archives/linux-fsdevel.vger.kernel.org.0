Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93838641F8B
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Dec 2022 21:30:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230385AbiLDUaG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 4 Dec 2022 15:30:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbiLDUaA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 4 Dec 2022 15:30:00 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FB061403A;
        Sun,  4 Dec 2022 12:29:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EA72EB80B94;
        Sun,  4 Dec 2022 20:29:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDF49C433D6;
        Sun,  4 Dec 2022 20:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670185796;
        bh=7pr8hVZJ6Hx+FhaG0oa2FI+IrcOdsDHZDzij5USkQBU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MFvp8AzxAXsyTBEEXEMbXnCLpf+zYijfGRBH4KHkeeX2G2mBh37L/+578ilVGPD2l
         PoVAvjiI26kfkHkt8OMgVk4Gcs/8dC5RSBWLzBHfqNYgo5G0NBWpG0J+R7pMesASJ7
         cvXULRwUdPgnjgPO+WBWoIUGv+y34BnD1BPDy2U3s9U22/QodgTeLHge8CCx2NzKcF
         LUxs/vaZBRj3PAH644643/uG7BM0fmwvDKbjvZsv307Hx5MsEsRI3Ru/J+oAqoXXcv
         ngbINzNer5vFsz2CdyEfCVtl2K0roS/mneQVhFN8E1djrf9eboEcFlTQVLvmyoWPs+
         8inCg7btm82Uw==
Date:   Sun, 4 Dec 2022 20:29:44 +0000
From:   Keith Busch <kbusch@kernel.org>
To:     Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier@javigon.com>
Cc:     Hannes Reinecke <hare@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        linux-block@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        axboe@kernel.dk, djwong@kernel.org, hch@lst.de, sagi@grimberg.me,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        Johannes.Thumshirn@wdc.com, bvanassche@acm.org,
        dongli.zhang@oracle.com, jefflexu@linux.alibaba.com,
        josef@toxicpanda.com, clm@fb.com, dsterba@suse.com, jack@suse.com,
        tytso@mit.edu, adilger.kernel@dilger.ca, jlayton@kernel.org,
        idryomov@gmail.com, danil.kipnis@cloud.ionos.com,
        ebiggers@google.com, jinpu.wang@cloud.ionos.com
Subject: Re: [PATCH 0/6] block: add support for REQ_OP_VERIFY
Message-ID: <Y40DOJ+7WlqIwkbD@kbusch-mbp>
References: <Y4oSiPH0ENFktioQ@kbusch-mbp.dhcp.thefacebook.com>
 <4F15C752-AE73-4F10-B5DD-C37353782111@javigon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4F15C752-AE73-4F10-B5DD-C37353782111@javigon.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Dec 03, 2022 at 07:19:17AM +0300, Javier González wrote:
> 
> > On 2 Dec 2022, at 17.58, Keith Busch <kbusch@kernel.org> wrote:
> > 
> > ﻿On Fri, Dec 02, 2022 at 08:16:30AM +0100, Hannes Reinecke wrote:
> >>> On 12/1/22 20:39, Matthew Wilcox wrote:
> >>> On Thu, Dec 01, 2022 at 06:12:46PM +0000, Chaitanya Kulkarni wrote:
> >>>> So nobody can get away with a lie.
> >>> 
> >>> And yet devices do exist which lie.  I'm not surprised that vendors
> >>> vehemently claim that they don't, or "nobody would get away with it".
> >>> But, of course, they do.  And there's no way for us to find out if
> >>> they're lying!
> >>> 
> >> But we'll never be able to figure that out unless we try.
> >> 
> >> Once we've tried we will have proof either way.
> > 
> > As long as the protocols don't provide proof-of-work, trying this
> > doesn't really prove anything with respect to this concern.
> 
> Is this something we should bring to NVMe? Seems like the main disagreement can be addressed there. 

Yeah, proof for the host appears to require a new feature, so we'd need
to bring this to the TWG. I can draft a TPAR if there's interest and
have ideas on how the feature could be implemented, but I currently
don't have enough skin in this game to sponser it.
