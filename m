Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE4BC522B0C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 May 2022 06:35:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232507AbiEKEfD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 May 2022 00:35:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbiEKEfC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 May 2022 00:35:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E2A29B197;
        Tue, 10 May 2022 21:35:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A379760C68;
        Wed, 11 May 2022 04:35:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F343EC385A7;
        Wed, 11 May 2022 04:34:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652243700;
        bh=dsj+ZDTdOyjl2nvx/T0s5GUG3Qqs3v13r9iZnNk3GeY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N95KQ47yLpZzoliJWy9obyTC849N1Xz9FDYl+C7cJS839jR2C5nSPFk69RrlJLmQp
         /S3cSpg4Sv8s3Sp1HilGh6Uv8ej1uLrsXOFvJxKqUShCThFhawkxkGc39/3fgqB3kv
         fpahe7Bfdrrm5Sp5Fg7L8ogOtgrTH1HzYRbRc4HCViPi6SJGY/IGarG0t2ujwjt/CQ
         qSfcknioaPlNReFlFqj1x8oiTV8OKMTsxnxHWMIR2cCUPA07m6zYBUly4JR4cNYP1t
         WAApWiAgvus4Ttds3v2CTWTu2qG0ErRKQlVhf9/usvzRhrUHcLh90n9psUAjQa3J0Q
         FG2HPPH3Cr3eg==
Date:   Tue, 10 May 2022 21:34:59 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dave Chinner <david@fromorbit.com>,
        Shiyang Ruan <ruansy.fnst@fujitsu.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        Linux MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Jane Chu <jane.chu@oracle.com>,
        Goldwyn Rodrigues <rgoldwyn@suse.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>, linmiaohe@huawei.com
Subject: Re: [PATCHSETS] v14 fsdax-rmap + v11 fsdax-reflink
Message-ID: <20220511043459.GE27195@magnolia>
References: <20220508143620.1775214-1-ruansy.fnst@fujitsu.com>
 <20220511000352.GY27195@magnolia>
 <20220511014818.GE1098723@dread.disaster.area>
 <CAPcyv4h0a3aT3XH9qCBW3nbT4K3EwQvBSD_oX5W=55_x24-wFA@mail.gmail.com>
 <20220510192853.410ea7587f04694038cd01de@linux-foundation.org>
 <CAPcyv4ip6N6jvdb3LRjPnVr6xaFjiVg1OCE95pu9RiMG5_VNPw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4ip6N6jvdb3LRjPnVr6xaFjiVg1OCE95pu9RiMG5_VNPw@mail.gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 10, 2022 at 09:20:57PM -0700, Dan Williams wrote:
> On Tue, May 10, 2022 at 7:29 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> >
> > On Tue, 10 May 2022 18:55:50 -0700 Dan Williams <dan.j.williams@intel.com> wrote:
> >
> > > > It'll need to be a stable branch somewhere, but I don't think it
> > > > really matters where al long as it's merged into the xfs for-next
> > > > tree so it gets filesystem test coverage...
> > >
> > > So how about let the notify_failure() bits go through -mm this cycle,
> > > if Andrew will have it, and then the reflnk work has a clean v5.19-rc1
> > > baseline to build from?
> >
> > What are we referring to here?  I think a minimal thing would be the
> > memremap.h and memory-failure.c changes from
> > https://lkml.kernel.org/r/20220508143620.1775214-4-ruansy.fnst@fujitsu.com ?
> 
> Latest is here:
> https://lore.kernel.org/all/20220508143620.1775214-1-ruansy.fnst@fujitsu.com/
> 
> > Sure, I can scoot that into 5.19-rc1 if you think that's best.  It
> > would probably be straining things to slip it into 5.19.
> 
> Hmm, if it's straining things and XFS will also target v5.20 I think
> the best course for all involved is just wait. Let some of the current
> conflicts in -mm land in v5.19 and then I can merge the DAX baseline
> and publish a stable branch for XFS and BTRFS to build upon for v5.20.

Sounds good to /me...

--D

> > The use of EOPNOTSUPP is a bit suspect, btw.  It *sounds* like the
> > right thing, but it's a networking errno.  I suppose livable with if it
> > never escapes the kernel, but if it can get back to userspace then a
> > user would be justified in wondering how the heck a filesystem
> > operation generated a networking errno?
