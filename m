Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC18A66B2B4
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Jan 2023 18:01:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231381AbjAORB3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 15 Jan 2023 12:01:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231356AbjAORB1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 15 Jan 2023 12:01:27 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7501EC63;
        Sun, 15 Jan 2023 09:01:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7DBB4B80B88;
        Sun, 15 Jan 2023 17:01:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B724C433F0;
        Sun, 15 Jan 2023 17:01:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673802083;
        bh=nm20lFRKKc6XWXsbu7enzGnNJtA20g3rsePVT32eB4E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=arS7eNFYyrrPNVCfshIxQnCZlqWjtByG3mWM+t9r1SIRcZQNDQ+sAjlL5eDCJL38L
         umLKf3S0QodgIrV+acG2lo10aLFsw1WnhZnK0+6c+nf5yiciwPKXiPDDyhyiMi/9D9
         W98Jr0WtFvJdFOeXPsx2m9zBnikOgWgBnQVmg0hhMsOBTnmowpwUzbRtCcU8CTnVmE
         OdY0x0ukh92zILzKOvx/gymehWetx9GZMUVpPkWckOGgv8RFLu9J/5LUod5gBvYFu1
         vHttD/PpfDM88yyQz945s8MxxE1BQ6jOYLOsHjVE1j7lngK5BrjdeXNpQVdDQHF9/d
         BOeH4+nCXOAEw==
Date:   Sun, 15 Jan 2023 09:01:22 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Dave Chinner <dchinner@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, cluster-devel@redhat.com,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [RFC v6 04/10] iomap: Add iomap_get_folio helper
Message-ID: <Y8QxYjy+4Kjg05rB@magnolia>
References: <20230108213305.GO1971568@dread.disaster.area>
 <20230108194034.1444764-1-agruenba@redhat.com>
 <20230108194034.1444764-5-agruenba@redhat.com>
 <20230109124642.1663842-1-agruenba@redhat.com>
 <Y70l9ZZXpERjPqFT@infradead.org>
 <Y71pWJ0JHwGrJ/iv@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y71pWJ0JHwGrJ/iv@casper.infradead.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 10, 2023 at 01:34:16PM +0000, Matthew Wilcox wrote:
> On Tue, Jan 10, 2023 at 12:46:45AM -0800, Christoph Hellwig wrote:
> > On Mon, Jan 09, 2023 at 01:46:42PM +0100, Andreas Gruenbacher wrote:
> > > We can handle that by adding a new IOMAP_NOCREATE iterator flag and
> > > checking for that in iomap_get_folio().  Your patch then turns into
> > > the below.
> > 
> > Exactly.  And as I already pointed out in reply to Dave's original
> > patch what we really should be doing is returning an ERR_PTR from
> > __filemap_get_folio instead of reverse-engineering the expected
> > error code.
> 
> Ouch, we have a nasty problem.
> 
> If somebody passes FGP_ENTRY, we can return a shadow entry.  And the
> encodings for shadow entries overlap with the encodings for ERR_PTR,
> meaning that some shadow entries will look like errors.  The way I
> solved this in the XArray code is by shifting the error values by
> two bits and encoding errors as XA_ERROR(-ENOMEM) (for example).
> 
> I don't _object_ to introducing XA_ERROR() / xa_err() into the VFS,
> but so far we haven't, and I'd like to make that decision intentionally.

Sorry, I'm not following this at all -- where in buffered-io.c does
anyone pass FGP_ENTRY?  Andreas' code doesn't seem to introduce it
either...?

--D
