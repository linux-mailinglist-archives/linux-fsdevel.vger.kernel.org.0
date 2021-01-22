Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CFAC2FFE0F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Jan 2021 09:23:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726131AbhAVIV6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Jan 2021 03:21:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725899AbhAVIV4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Jan 2021 03:21:56 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B312C06174A;
        Fri, 22 Jan 2021 00:21:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=7CD4ZZi1efsWWfKaFweeXsHDSTYWlbR5PIt/BwEj2Ko=; b=ZkLsjDUEmLcYukb/nMYBE7JSZV
        A8nUGRdJ/5PTDyLFRpwFPIKGNUfL46FOFokRwR7du9q927Oob8IdfezCMVG9hQqbb4FsKgF10ugnT
        vSDBhFvQhxN5fuG+11D7f7USI/RwKt5m9r9S2thBbNp85FbQQPKFbcJHLoKeh0E2RZbd6YCHnRLIP
        Hvwj6DIW0ZNqaOEWbMKxRobuK3R5lhViw/tOZOyzzKmv05J35BSR3sb3EtLCbsKJpodGc+Ha1+9tg
        ozIWvE08QrwNQPx1YGPHgx52qnawGjW9+eFEU0qzXci6y6/jbFmx/aFpgM8z/1a+CWcsBHPhaGgCa
        nK7ZKOqg==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l2rgh-000VNc-Py; Fri, 22 Jan 2021 08:21:03 +0000
Date:   Fri, 22 Jan 2021 08:20:59 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     "J. Bruce Fields" <bfields@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <schumakeranna@gmail.com>,
        Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH 2/3] nfsd: move change attribute generation to filesystem
Message-ID: <20210122082059.GA119852@infradead.org>
References: <1611084297-27352-1-git-send-email-bfields@redhat.com>
 <1611084297-27352-3-git-send-email-bfields@redhat.com>
 <20210120084638.GA3678536@infradead.org>
 <20210121202756.GA13298@pick.fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210121202756.GA13298@pick.fieldses.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 21, 2021 at 03:27:56PM -0500, J. Bruce Fields wrote:
> > Another indirect call just to fetch the change attribute (which happens
> > a lot IIRC) does not seem very optimal to me.
> 
> In the next patch we're removing an fh_getattr (vfs_getattr) in the case
> we call the new op, so that's typically a net decrease in indirect
> calls.
> 
> Though maybe we could use a flag here and do without either.
> 
> > And the fact that we need three duplicate implementations also is not
> > very nice.
> 
> Ext4 and xfs are identical, btrfs is a little different since it doesn't
> consult I_VERSION.  (And then there's nfs, which uses the origin
> server's i_version if it can.)

I'd much prefer to just keep consulting the I_VERSION flag and only
add the new op as an override for the NFS export.

> 
> I also have a vague idea that some filesystem-specific improvements
> might be possible.  (E.g., if a filesystem had some kind of boot count
> in the superblock, maybe that would be a better way to prevent the
> change attribute from going backwards on reboot than the thing
> generic_fetch_iversion is currently doing with ctime.  But I have no
> concrete plan there, maybe I'm dreaming.)

Even without the ctime i_version never goes backward, what is the
problem here?
