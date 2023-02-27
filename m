Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E1B16A35D2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Feb 2023 01:10:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbjB0AKQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 26 Feb 2023 19:10:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjB0AKP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 26 Feb 2023 19:10:15 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9F98AD19
        for <linux-fsdevel@vger.kernel.org>; Sun, 26 Feb 2023 16:10:14 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id n6so3644227plf.5
        for <linux-fsdevel@vger.kernel.org>; Sun, 26 Feb 2023 16:10:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/Eh6e29MTS78inc95RvxVitPn9VdWzVoZiaCQdVbhYo=;
        b=JOGsZ10SsnvSukmoee6jALBvstX1SQgePYtUnAOjtDLvLRTgaFawICRQ4/MiGmsHRx
         45Spk52leH3Ug+e3AqYF3zIHdVWx9GUBHNvQzDfX5kgVnW3lpVX3GRWNbS257/A/5fkE
         a5IsZ9UwoJkr4oFQkYmcCzyCcQIgmWiYKCXc2aSfrVMQWDLrcAG7CfJ9fY0mvvy8/Wlg
         lf20pyBNjjPLXQK1EUFNrv/FlllGuoVbGXI08KqCuzu7hs4rdFcpAWKFnPdUNgy2i/hn
         uh+JQyHLLTARDZX8MWoJEJ+oyypRknVcElBnb48ioFuPbynEZSdMXIzX/uMvOJfOGLP1
         K+og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Eh6e29MTS78inc95RvxVitPn9VdWzVoZiaCQdVbhYo=;
        b=DTbLX13M2+Zfa7spHj0m9RWJlEoh/VZJAAAyV47M9+87WOQMdJccrBju1ecfJHa/tf
         Xg9pM3A7w31Q174CfyISFDAWiw2gtBn+G8zerutcxFwR8VA0eDyGp+5ruCKGrrxpMXOh
         4dsRF+QuiVx1s2pn/xp/uomNQ7ldBV1hvur6SjlQJTIqo2WoW5/aj65ccU5inBc2pCTk
         WtvHNoRa6saqRC1Z5VRvW90+ZxtVXrFdit75GKCiUn7MqA5+ZtIgPsEKpJujFlzDJntw
         j12Hy5dpKQJ840YwxCb0ULX38jVAasmddJwt+LNOkPaEvXflcisfiaQdM3ZENKxWtpvg
         6GRw==
X-Gm-Message-State: AO0yUKWzK12ogJcVQ+Zj19yWnnF+dIj2n+4uG+X8SxLPA7Po+2ybTh0U
        HqWT9PadvZS1xZTbboH9D8o+Dw==
X-Google-Smtp-Source: AK7set+TykWH+l1unKzzABA9py4+gsulnqRqI3O1SU/B80svYu66Eklz4Hn7YvMNEGdZ4mrX4s0NYg==
X-Received: by 2002:a17:903:41cd:b0:19c:171a:d342 with SMTP id u13-20020a17090341cd00b0019c171ad342mr26570878ple.37.1677456614311;
        Sun, 26 Feb 2023 16:10:14 -0800 (PST)
Received: from dread.disaster.area (pa49-186-4-237.pa.vic.optusnet.com.au. [49.186.4.237])
        by smtp.gmail.com with ESMTPSA id a11-20020a170902900b00b0019a9637b2d3sm3150610plp.279.2023.02.26.16.10.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Feb 2023 16:10:13 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1pWR5n-002Wz2-9C; Mon, 27 Feb 2023 11:10:11 +1100
Date:   Mon, 27 Feb 2023 11:10:11 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Aravinda Herle <araherle@in.ibm.com>
Subject: Re: [RFCv3 3/3] iomap: Support subpage size dirty tracking to
 improve write performance
Message-ID: <20230227001011.GA360264@dread.disaster.area>
References: <cover.1677428794.git.ritesh.list@gmail.com>
 <9650ef88e09c6227b99bb5793eef2b8e47994c7d.1677428795.git.ritesh.list@gmail.com>
 <20230226234814.GX360264@dread.disaster.area>
 <Y/vxlVUJ31PZYaRa@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y/vxlVUJ31PZYaRa@casper.infradead.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Feb 26, 2023 at 11:56:05PM +0000, Matthew Wilcox wrote:
> On Mon, Feb 27, 2023 at 10:48:14AM +1100, Dave Chinner wrote:
> > > +static void iomap_iop_set_range_dirty(struct folio *folio,
> > > +		struct iomap_page *iop, size_t off, size_t len)
> > > +{
> > > +	struct inode *inode = folio->mapping->host;
> > > +	unsigned int nr_blocks = i_blocks_per_folio(inode, folio);
> > > +	unsigned first = (off >> inode->i_blkbits);
> > > +	unsigned last = ((off + len - 1) >> inode->i_blkbits);
> > 
> > first_bit, last_bit if we are leaving this code unchanged.
> 
> first_blk, last_blk, surely?

Probably.

And that's entirely my point - the variable names need to
describe what they contain...

-Dave.
-- 
Dave Chinner
david@fromorbit.com
