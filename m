Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FEE85A3301
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Aug 2022 02:17:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233267AbiH0ARR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Aug 2022 20:17:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231216AbiH0ARQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Aug 2022 20:17:16 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F359E97C0;
        Fri, 26 Aug 2022 17:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=elUyDUEpUZc5zZUiyve6rs+voBg4NqVM2gvYNPvkZzU=; b=Ye8MO/hmGUIdcSgg050O6RuQTQ
        POXYfBXFkoFGeo3GnyFSzHxcFzc1A115KMrG8Qcxm/q4N/wHGN/UnzyVJZyZEoIypaRKD3VUfY5WD
        qTn67HVQ9ns+S0jujgZimUi7CwI6HTCh512cH4x46fvTxNshw/PweE+bGF68FH4bitF7ZdhNaIWhY
        MGqmwes0mMuUUNqSBi4Nw1qULPSLQzcyxGoFPpqvw/jYeZJO+JOF5Bjs93b1X5F6UKj+B/TZ5yCMp
        5fdT+PR4aZ4GRBLebPDOFjEqAZ2JDzDHV0vEZEcGjyJu+8FhjzvBqx19ktNAyfy1qBpgBednyALIu
        EI4EeTTA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1oRjVV-008pH8-Qv;
        Sat, 27 Aug 2022 00:17:01 +0000
Date:   Sat, 27 Aug 2022 01:17:01 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     NeilBrown <neilb@suse.de>, Daire Byrne <daire@dneg.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 01/10] VFS: support parallel updates in the one directory.
Message-ID: <YwlifYSJYzovBKGB@ZenIV>
References: <166147828344.25420.13834885828450967910.stgit@noble.brown>
 <166147984370.25420.13019217727422217511.stgit@noble.brown>
 <CAHk-=wi_wwTxPTnFXsG8zdaem5YDnSd4OsCeP78yJgueQCb-1g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wi_wwTxPTnFXsG8zdaem5YDnSd4OsCeP78yJgueQCb-1g@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 26, 2022 at 12:06:55PM -0700, Linus Torvalds wrote:

> Because right now I think the main reason we cannot move the lock into
> the filesystem is literally that we've made the lock cover not just
> the filesystem part, but the "lookup and create dentry" part too.

How about rename loop prevention?  mount vs. rmdir?  d_splice_alias()
fun on tree reconnects?

> But once you have that "DCACHE_PAR_LOOKUP" bit and the
> d_alloc_parallel() logic to serialize a _particular_ dentry being
> created (as opposed to serializing all the sleeping ops to that
> directly), I really think we should strive to move the locking - that
> no longer helps the VFS dcache layer - closer to the filesystem call
> and eventually into it.

See above.
