Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7110E308D53
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Jan 2021 20:26:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232644AbhA2T0V (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Jan 2021 14:26:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232816AbhA2T0N (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Jan 2021 14:26:13 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BC8EC061574;
        Fri, 29 Jan 2021 11:25:33 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id A2DD64163; Fri, 29 Jan 2021 14:25:32 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org A2DD64163
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1611948332;
        bh=2OXpG3Hcaog/fSQGoGDbfK1ZRo4tNm//iS7itlsCAXU=;
        h=Date:To:Cc:Subject:References:In-Reply-To:From:From;
        b=Ms0I1PAVUulw+5Of3gVNHQjPBLf6g5kfOO3v6cpmOPM1c7mAaPwYII1B9a5by5tYX
         svK2R+2iGtJcrIT2Q1Y3zlpEz7d49qKZElpWECRcgIoAkFPWEsMzl7A7Mf3IUMJ8nv
         QE5Itbk+s43nJrtw0cpDCtyavWRXnklN8T1dlg5o=
Date:   Fri, 29 Jan 2021 14:25:32 -0500
To:     Christoph Hellwig <hch@infradead.org>
Cc:     "J. Bruce Fields" <bfields@redhat.com>, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <schumakeranna@gmail.com>,
        Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH 2/3] nfsd: move change attribute generation to filesystem
Message-ID: <20210129192532.GB8033@fieldses.org>
References: <1611084297-27352-1-git-send-email-bfields@redhat.com>
 <1611084297-27352-3-git-send-email-bfields@redhat.com>
 <20210120084638.GA3678536@infradead.org>
 <20210121202756.GA13298@pick.fieldses.org>
 <20210122082059.GA119852@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210122082059.GA119852@infradead.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 22, 2021 at 08:20:59AM +0000, Christoph Hellwig wrote:
> On Thu, Jan 21, 2021 at 03:27:56PM -0500, J. Bruce Fields wrote:
> > > Another indirect call just to fetch the change attribute (which happens
> > > a lot IIRC) does not seem very optimal to me.
> > 
> > In the next patch we're removing an fh_getattr (vfs_getattr) in the case
> > we call the new op, so that's typically a net decrease in indirect
> > calls.
> > 
> > Though maybe we could use a flag here and do without either.
> > 
> > > And the fact that we need three duplicate implementations also is not
> > > very nice.
> > 
> > Ext4 and xfs are identical, btrfs is a little different since it doesn't
> > consult I_VERSION.  (And then there's nfs, which uses the origin
> > server's i_version if it can.)
> 
> I'd much prefer to just keep consulting the I_VERSION flag and only
> add the new op as an override for the NFS export.

OK, sorry for the delay, I'm not wedded to that second patch; I can just
replace the test for the new export op by a test for either that or
SB_I_VERSION, and it ends up being the same.  Will follow up in a
moment.....

--b.
