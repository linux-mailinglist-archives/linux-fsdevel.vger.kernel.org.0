Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 283894F70F7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Apr 2022 03:22:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238508AbiDGBX1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Apr 2022 21:23:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239108AbiDGBWg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Apr 2022 21:22:36 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 400765D18C;
        Wed,  6 Apr 2022 18:19:46 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id BE1C6210EF;
        Thu,  7 Apr 2022 01:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1649294384; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hSOa6bR/GWqCtiQwZrRySxoVBsyfYQuY8z/QQSW6wI4=;
        b=EWO9+yQG8FZdMGlTrUQLdsWIdFX1uTGYuSXPLdyNuMF6Xng2rz3RDtMpvckW52UVMilFOg
        iuaq3KQYAYIBNUHqmsgE9JBdxbIrtZZ1sRLH2qwzaCEdDg6gZRiIpK2HdPQgWjOtSRMbD9
        86PS2Eg4jO7H3rVxPx9OkmRNiaL2RgQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1649294384;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hSOa6bR/GWqCtiQwZrRySxoVBsyfYQuY8z/QQSW6wI4=;
        b=JN3y31g6yBiZtk7KZ4Z+8k7yqDz/SorKWUd2Tegg+M5+vLLyI4XqtL+CWZ2+vkImf3JFZV
        T7C5x9hnK04i8uBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BECC5139F5;
        Thu,  7 Apr 2022 01:19:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 1z7SHS48TmIsfgAAMHmgww
        (envelope-from <neilb@suse.de>); Thu, 07 Apr 2022 01:19:42 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Dave Chinner" <david@fromorbit.com>,
        "Trond Myklebust" <trondmy@hammerspace.com>
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        "Chuck Lever" <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: sporadic hangs on generic/186
In-reply-to: <164929126156.10985.11316778982526844125@noble.neil.brown.name>
References: <20220406195424.GA1242@fieldses.org>,
 <20220407001453.GE1609613@dread.disaster.area>,
 <164929126156.10985.11316778982526844125@noble.neil.brown.name>
Date:   Thu, 07 Apr 2022 11:19:34 +1000
Message-id: <164929437439.10985.5253499040284089154@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 07 Apr 2022, NeilBrown wrote:
> On Thu, 07 Apr 2022, Dave Chinner wrote:
> > On Wed, Apr 06, 2022 at 03:54:24PM -0400, J. Bruce Fields wrote:
> > > In the last couple days I've started getting hangs on xfstests
> > > generic/186 on upstream.  I also notice the test completes after 10+
> > > hours (usually it takes about 5 minutes).  Sometimes this is accompanied
> > > by "nfs: RPC call returned error 12" on the client.
> > 
> > #define ENOMEM          12      /* Out of memory */
> > 
> > So either the client or the server is running out of memory
> > somewhere?
> 
> Probably the client.  There are a bunch of changes recently which add
> __GFP_NORETRY to memory allocations from PF_WQ_WORKERs because that can
> result in deadlocks when swapping over NFS.
> This means that kmalloc request that previously never failed (because
> GFP_KERNEL never fails for kernel threads I think) can now fail.  This
> has tickled one bug that I know of.  There are likely to be more.
> 
> The RPC code should simply retry these allocations after a short delay. 
> HZ/4 is the number that is used in a couple of places.  Possibly there
> are more places that need to handle -ENOMEM with rpc_delay().

I had a look through the various places where alloc can now fail.

I think xdr_alloc_bvec() in xprt_sent_pagedata() is the most likely
cause of a problem here.  I don't think an -ENOMEM from there is caught,
so it could likely filter up to NFS and result in the message you got.

I don't think we can easily handle failure there.  We need to stay with
GFP_KERNEL rely on PF_MEMALLOC to make forward progress for
swap-over-NFS.

Bruce: can you change that one line back to GFP_KERNEL and see if the
problem goes away?

The other problem I found is that rpc_alloc_task() can now fail, but
rpc_new_task assumes that it never will.  If it does, then we get a NULL
deref.

I don't think rpc_new_task() can ever be called from the rpciod work
queue, so it is safe to just use a mempool with GFP_KERNEL like we did
before. 

NeilBrown
