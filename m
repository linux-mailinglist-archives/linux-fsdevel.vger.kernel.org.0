Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E3CE66D0A6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jan 2023 22:03:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233571AbjAPVDE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Jan 2023 16:03:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231171AbjAPVDC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Jan 2023 16:03:02 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E4F71BADD
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Jan 2023 13:03:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9WKEEi76vJhptedaWLNEvoVdr9s00xvLpcvV43SjTmo=; b=RVjIeR49+Lx0IiedP7HLQJuHAs
        UlIO7vPsAghva/+dz3sHsxnNLSpmJ9FtdWYqGPHNDHvwL5sz1tZwe+DVTohFlNE8mEuhKeHHQWkxI
        2w5uAVcva3f0X3mPpR2q+1Xzx+dsrSOMh+LmKEu+CiPMFngptd4GlHsy6FCJcf9rdyZu7SccKzk+n
        eWbr7zFIWzq135JPOjsB5H+H03BZErP1bfQityjS1ACT/IwTCaC7fiUQMBs6nMbkshyaax3x+C9h4
        MUCNC10HDFlrNUwpcDezD27bXwhXFtF8Kfd4JwTEJtIDz9EnmPXEDF+VP1Oe+IuLBHqGnH8EV+s40
        RwCrE1Pg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pHWcw-002EfX-06;
        Mon, 16 Jan 2023 21:02:46 +0000
Date:   Mon, 16 Jan 2023 21:02:45 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Evgeniy Dushistov <dushistov@mail.ru>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        ocfs2-devel@oss.oracle.com, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: remove most callers of write_one_page
Message-ID: <Y8W7dULuW5oFGm/J@ZenIV>
References: <20230116085523.2343176-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230116085523.2343176-1-hch@lst.de>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 16, 2023 at 09:55:17AM +0100, Christoph Hellwig wrote:
> Hi all,
> 
> this series removes most users of the write_one_page API.  These helpers
> internally call ->writepage which we are gradually removing from the
> kernel.
> 
> Changes since v1:
>  - drop the btrfs changes (queue up in the btrfs tree)
>  - drop the finaly move to jfs (can't be done without the btrfs patches)
>  - fix the existing minix code to properly propagate errors
> 
> Diffstat:
>  minix/dir.c          |   67 ++++++++++++++++++++++++++++++---------------------
>  minix/minix.h        |    3 +-
>  minix/namei.c        |    8 +++---
>  ocfs2/refcounttree.c |    9 +++---
>  sysv/dir.c           |   30 ++++++++++++++--------
>  ufs/dir.c            |   29 ++++++++++++++--------
>  6 files changed, 90 insertions(+), 56 deletions(-)

OK...  Mind if I grab minix/sysv/ufs into a branch in vfs.git?
There's a pile of kmap_local() stuff that that would interfere with
that and I'd rather have it in one place...
