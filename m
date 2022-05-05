Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF4F951C52F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 May 2022 18:32:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382033AbiEEQgC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 May 2022 12:36:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236527AbiEEQgB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 May 2022 12:36:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D2E45C74B;
        Thu,  5 May 2022 09:32:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EC4E861CDF;
        Thu,  5 May 2022 16:32:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 506F5C385A4;
        Thu,  5 May 2022 16:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651768340;
        bh=01N9RnHIiUqZhzaB+Vv4O/x0uUxnJ2KaPYw53Dmy5WA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eIcUqPz4RzIr9nflOKdEk7MaXOBmu7WibAvqIFXJ6B+KWwgG/vyRgf/cS7m95H2Ax
         BfhhGVc+Hbe1Q5GW0PbdR/79WD7d3D5gsKlFiQkCp7XAvfwvTcnrzIJeYujKy00DgE
         6rSzqaaJeszSYII5acPVQM0mF4AweQsoCBaeYf5z7uc5YrFwIBzYrMMTpXqcgPT0Me
         sIj8yTepmJtK/F8l+VuPoz/b5HLOIJGToptY4McBt1JsYm6BgUQwHSXsU/SCgsAn8m
         r2OoXzZqIEVw/Cmm5BtQpd3eh9etF2WkVnGKZge4h3hk6wzWwpHUh4DDAtAhYH2jeX
         AEl1Fd5MnzxJA==
Date:   Thu, 5 May 2022 09:32:19 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/5] iomap: add per-iomap_iter private data
Message-ID: <20220505163219.GJ27195@magnolia>
References: <20220504162342.573651-1-hch@lst.de>
 <20220504162342.573651-3-hch@lst.de>
 <20220505154126.GB27155@magnolia>
 <20220505154557.GA22763@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220505154557.GA22763@lst.de>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 05, 2022 at 05:45:57PM +0200, Christoph Hellwig wrote:
> On Thu, May 05, 2022 at 08:41:26AM -0700, Darrick J. Wong wrote:
> > > +	 */
> > > +	iomi.private = iocb->private;
> > > +	WRITE_ONCE(iocb->private, NULL);
> > 
> > Do we need to transfer it back after the bio completes?  Or is it a
> > feature that iocb->private changes to the bio?
> 
> No need to transfer it back.  It ist just a creative way to pass private
> data in.  Initially I just added yet another argument to iomap_dio_rw,
> and maybe I should just go back to that to make the things easier to
> follow.

Hmm.  Who owns iocb->private?  AFAICT there are two users of it -- the
directio code uses it to store bios for polling; and then there's ocfs2,
which apparently uses it for iocb lock state(!) flags.

Getting back to iomap, I think the comment before __iomap_dio_rw should
state that iocb->private will be transferred to iter->private to make
that relationship more obvious, in case ocfs2 ever stumbles into iomap
and explodes on impact.

--D
