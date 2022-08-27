Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15C375A330C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Aug 2022 02:23:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240468AbiH0AX1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Aug 2022 20:23:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231216AbiH0AX0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Aug 2022 20:23:26 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A885DB4EB7;
        Fri, 26 Aug 2022 17:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/RDyHGNnWhjfZn4OC+Zvk2NY7ZNCKphv6kh/HtlKzb0=; b=GRS97yFQmqrbt4Hi5s4d+3ZxJj
        eDqfLgG/zSdPENuaixzzfzeoHeFUbIdluk5C8h2UxqTY/puIZonD1zs748DXr4A9tQoPSD99C/SEm
        DORP6E4NFqijpbTb24xCOV05Dp3XCv1IedCr26jsSZQIK5NRLQ4K+/zl5stn+xfcSxnN1ne54QOxQ
        NIz54uTaNJ2yphgUPk7ihyDPnCi5+ALQs+PIsSf15XP5Y4ex/8D+v0zdvUlFfkWojtBmocU8cX4e2
        zXiNCkldvpAeIjisfhbwbt4UNM7e/13BvPT/w5LUaAVsl2tx87IgUzB/RtpIidYpPzZ8SHg9VFdnw
        4aJLLovA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1oRjbZ-008pLs-Vj;
        Sat, 27 Aug 2022 00:23:18 +0000
Date:   Sat, 27 Aug 2022 01:23:17 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     NeilBrown <neilb@suse.de>, Daire Byrne <daire@dneg.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 01/10] VFS: support parallel updates in the one directory.
Message-ID: <Ywlj9RnHavvCNpCd@ZenIV>
References: <166147828344.25420.13834885828450967910.stgit@noble.brown>
 <166147984370.25420.13019217727422217511.stgit@noble.brown>
 <CAHk-=wi_wwTxPTnFXsG8zdaem5YDnSd4OsCeP78yJgueQCb-1g@mail.gmail.com>
 <166155521174.27490.456427475820966571@noble.neil.brown.name>
 <CAHk-=whz69y=98udgGB5ujH6bapYuapwfHS2esWaFrKEoi9-Ow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whz69y=98udgGB5ujH6bapYuapwfHS2esWaFrKEoi9-Ow@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 26, 2022 at 05:13:38PM -0700, Linus Torvalds wrote:

> So I feel like if the VFS code cannot rely on locking *anyway* in the
> general case, and should work without it, then we really shouldn't
> have any locking around any of the VFS operations.

That's a really big if.  There's a bunch of places where we rely upon
->i_rwsem on directories and _not_ to provide exclusion for fs methods.
I'm still halfway through the Neil's patchset, but verifying correctness
won't be easy and I'm not optimistic about getting rid of those uses...
