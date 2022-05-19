Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E52EF52DB8A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 May 2022 19:44:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242968AbiESRnP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 May 2022 13:43:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233298AbiESRnO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 May 2022 13:43:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EF3266ACB;
        Thu, 19 May 2022 10:43:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ACAC4618A8;
        Thu, 19 May 2022 17:43:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64D97C385AA;
        Thu, 19 May 2022 17:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652982193;
        bh=w0vM6llzlBWvcQuMIhQ7/Nhu4fqdoSodIqG/xxpKXGs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IMoqCW50z17khpKaWyeceg4CvENAXlhw/3ezwPkAdv5o5kVui7TLZtEqKFeju7E1k
         ePjSzFMGgOkl+ZlO+LSTWa/WnQrDx4S/914RGQuwu4IXKdZ2gLCXJbr3PqBfSceuKz
         e+7kd7g6OUf1mwzd1QK31EHHPyg3iID8Vs78kZBKKNnw/bLqAYgCASsp3EyrGBX/iu
         aDGnSTWRUYJ2Ey55Ee5dBmE8+Xoc4etr9BrvkzYqzB+76ykjiuCNCX+0nrY5P+sl7F
         khhyoxnPRSlA2tWOKPxWOFgdBtLswv5GMK14VJbLEVw5NkjhYXZ8v2g9+CDozaIFNg
         91i5sxM3Vza2Q==
Date:   Thu, 19 May 2022 11:43:09 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Keith Busch <kbusch@fb.com>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, axboe@kernel.dk,
        Kernel Team <Kernel-team@fb.com>, hch@lst.de,
        bvanassche@acm.org, damien.lemoal@opensource.wdc.com
Subject: Re: [PATCHv2 3/3] block: relax direct io memory alignment
Message-ID: <YoaBrQSTJeDMYFOO@kbusch-mbp.dhcp.thefacebook.com>
References: <YoWL+T8JiIO5Ln3h@sol.localdomain>
 <YoWWtwsiKGqoTbVU@kbusch-mbp.dhcp.thefacebook.com>
 <YoWjBxmKDQC1mCIz@sol.localdomain>
 <YoWkiCdduzyQxHR+@kbusch-mbp.dhcp.thefacebook.com>
 <YoWmi0mvoIk3CfQN@sol.localdomain>
 <YoWqlqIzBcYGkcnu@kbusch-mbp.dhcp.thefacebook.com>
 <YoW5Iy+Vbk4Rv3zT@sol.localdomain>
 <YoXN5CpSGGe7+OJs@kbusch-mbp.dhcp.thefacebook.com>
 <YoZ30XROoiFleT16@kbusch-mbp.dhcp.thefacebook.com>
 <YoZ96LBMOiNwFhRZ@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YoZ96LBMOiNwFhRZ@sol.localdomain>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 19, 2022 at 10:27:04AM -0700, Eric Biggers wrote:
> On Thu, May 19, 2022 at 11:01:05AM -0600, Keith Busch wrote:
> > On Wed, May 18, 2022 at 10:56:04PM -0600, Keith Busch wrote:
> > > On Wed, May 18, 2022 at 08:27:31PM -0700, Eric Biggers wrote:
> > > > Note, there's also lots of code that assumes that bio_vec::bv_len is a multiple
> > > > of 512.  
> > > 
> > > Could you point me to some examples?
> > 
> > Just to answer my own question, blk-crypto and blk-merge appear to have these
> > 512 byte bv_len assumptions.
> 
> blk_bio_segment_split() and bio_advance_iter() are two more examples.

I agree about blk_bio_segment_split(), but bio_advance_iter() looks fine. That
just assumes the entire length is a multiple of 512, not any particular bvec.

Anyway, I accept your point that some existing code has this assumption, and
will address these before the next revision.
