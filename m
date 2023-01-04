Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF6AE65DB3A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jan 2023 18:25:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235189AbjADRZo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Jan 2023 12:25:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234990AbjADRZi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Jan 2023 12:25:38 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58A7A373B7
        for <linux-fsdevel@vger.kernel.org>; Wed,  4 Jan 2023 09:25:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D707961563
        for <linux-fsdevel@vger.kernel.org>; Wed,  4 Jan 2023 17:25:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 320C5C43392;
        Wed,  4 Jan 2023 17:25:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672853136;
        bh=lYS3R8w5uLlsxtddW7pfXENApotOQRXQEER6a8aUa9M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=unzBaz8r4u2Y2mYiNkYz5KLBrXUzqGMRWoJf6IN2YMWoKJMkvN+MJOrPJAuFg07rn
         Uh8VFKuIHK+pJ+1e1iLif8b+jp2FkkAoCAXI4DPLURJt17MXiyiBReYWhhyEMi3yL3
         BUI8c49ItG/tosBSu9Kmz5dJgFs4wD1ipLBRbzgo6XK8fIJLhrdICsVxka9ciGcEoV
         VNGT83N9ex8O3D4ViOTpGdbEKi/JTvAEgyUpuQ+TNncJDe9LH58xcthoFmEA+pEyJz
         K9MeqmkMlDkeKFxoxdRAWX9vAK5Rm9q1B57NmCwdRFH4mww/nbF5ht0RCVXaJntKm7
         UkYrGrQZ17gNw==
Date:   Wed, 4 Jan 2023 09:25:35 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Zbigniew Halas <zhalas@gmail.com>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Filipe Manana <fdmanana@kernel.org>, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org
Subject: Re: FIDEDUPERANGE claims to succeed for non-identical files
Message-ID: <Y7W2j0yFT3Y0GLR2@magnolia>
References: <CAPr0N2i3mo=SP+AdpMz=qHXejsKWs+JLTPaJVGwrzopaWOfVdA@mail.gmail.com>
 <CAOQ4uxh8c1=eBVihamhzCCAvRr38j0HCmth9ke3bo_nKsv62=A@mail.gmail.com>
 <CAPr0N2gtz79Z1fNmOc_UHjQrZfqUwzx2rJ7+4X0jFbMAAoh3-Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPr0N2gtz79Z1fNmOc_UHjQrZfqUwzx2rJ7+4X0jFbMAAoh3-Q@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 22, 2022 at 03:41:30PM +0100, Zbigniew Halas wrote:
> On Thu, Dec 22, 2022 at 9:25 AM Amir Goldstein <amir73il@gmail.com> wrote:
> >
> > Thanks for the analysis.
> > Would you be interested in trying to fix the bug and writing a test?
> > I can help if you would like.
> 
> I can give it a try unless it turns out that some deep VFS changes are
> required, but let's try to narrow down the reasonable API semantics
> first.
> 
> > It's hard to follow all the changes since
> > 54dbc1517237 ("vfs: hoist the btrfs deduplication ioctl to the vfs")
> > in v4.5, but it *looks* like this behavior might have been in btrfs,
> > before the ioctl was promoted to vfs.. not sure.
> >
> > We have fstests coverage for the "good" case of same size src/dst
> > (generic/136), but I didn't find a test for the non-same size src/dst.
> >
> > In any case, vfs_dedupe_file_range_one() and ->remap_file_range()
> > do not even have an interface to return the actual bytes_deduped,

The number of bytes remapped is passed back via the loff_t return value
of ->remap_file_range.  If CAN_SHORTEN is set, the VFS and the fs
implementation are allowed to reduce the @len parameter as much as they
want.  TBH I'm mystified why the original btrfs dedupe ioctl wouldn't
allow deduplication of common prefixes, which means that len only gets
shortened to avoid weird problems when dealing with eof being in the
middle of a block.

(Or not, since there's clearly a bug.)

> > so I do not see how any of the REMAP_FILE_CAN_SHORTEN cases
> > are valid, regardless of EOF.
> 
> Not sure about this, it looks to me that they are actually returning
> the number of bytes deduped, but the value is not used, but maybe I'm
> missing something.
> Anyway I think there are valid cases when REMAP_FILE_CAN_SHORTEN makes sense.
> For example if a source file content is a prefix of a destination file
> content and we want to dedup the whole range of the source file
> without REMAP_FILE_CAN_SHORTEN,
> then the ioctl will only succeed when the end of the source file is at
> the block boundary, otherwise it will just fail. This will render the
> API very inconsistent.

<nod> I'll try to figure out where the len adjusting went wrong here and
report back.

--D

> Cheers,
> Zbigniew
