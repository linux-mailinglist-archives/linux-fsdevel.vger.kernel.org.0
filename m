Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FE4F5A336E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Aug 2022 03:22:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244814AbiH0BVZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Aug 2022 21:21:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230416AbiH0BVY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Aug 2022 21:21:24 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81931E42F0;
        Fri, 26 Aug 2022 18:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ZASlgiaYVcXmZuWHYLlAifB7Jl2t5z03ci8JKpJlphc=; b=iubq/OY2mnqYT6clYoEo3Vmj/Y
        /W5hvBJ+gKvXiWyxElb86XOVk+SIEex7KG819Esq8FP+J545g3z1AnDxkc8jiNIECW8lMcD70M6LA
        TLZxv/WDbu/xClT1GK/9zmGj+AN5XcsfuuJ1gPF8jwOcni1U+JQ8siMXu9uT+bji4pVyCrzOQFvTf
        QXC7N0lMPbx9tH/htXd6evA1THuJJ2mJgYtEJw1yWe0c4TLNdZv39zZHicJhiycLW7G5OT1WHeaMd
        8nIqfC3ovsfWmvWr+/52hNl3iyvl8zN4FeI5cRDC5xvEn86NVvv+yOgB60oGSk1ElAaKwqa2OZqj3
        7mxUtPQw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1oRkVc-008q0K-SU;
        Sat, 27 Aug 2022 01:21:12 +0000
Date:   Sat, 27 Aug 2022 02:21:12 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     NeilBrown <neilb@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daire Byrne <daire@dneg.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 09/10] VFS: add LOOKUP_SILLY_RENAME
Message-ID: <YwlxiCt3TvzdEhUl@ZenIV>
References: <166147828344.25420.13834885828450967910.stgit@noble.brown>
 <166147984377.25420.5747334898411663007.stgit@noble.brown>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <166147984377.25420.5747334898411663007.stgit@noble.brown>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 26, 2022 at 12:10:43PM +1000, NeilBrown wrote:
> When performing a "silly rename" to avoid removing a file that is still
> open, we need to perform a lookup in a directory that is already locked.
> 
> In order to allow common functions to be used for this lookup, introduce
> LOOKUP_SILLY_RENAME which affirms that the directory is already locked
> and that the vfsmnt is already writable.
> 
> When LOOKUP_SILLY_RENAME is set, path->mnt can be NULL.  As
> i_op->rename() doesn't make the vfsmnt available, this is unavoidable.
> So we ensure that a NULL ->mnt isn't fatal.

This one is really disgusting.  Flag-dependent locking is a pretty much
guaranteed source of PITA and "magical" struct path is, again, asking for
trouble.

You seem to be trying for simpler call graph and you end up paying with
control flow that is much harder to reason about.
