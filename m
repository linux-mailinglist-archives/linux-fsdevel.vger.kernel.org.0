Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE0B84F71B4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Apr 2022 03:49:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbiDGBvq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Apr 2022 21:51:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbiDGBvn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Apr 2022 21:51:43 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56C0916DB79;
        Wed,  6 Apr 2022 18:49:40 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id C3923685B; Wed,  6 Apr 2022 21:49:39 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org C3923685B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1649296179;
        bh=SKTCmJeHffhfBD0bd5Ikkj/Vxo4gt7j66RyaJMQUM+o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OzXkNbyAu9Npq0rQx+2UHJCbcFbJUG504MgILRuSNcBFwQWmPGn5hY+JWdN/Q5MHM
         Dt60Xnb+XeTBIOQg1Nd/Er3hrPnvJariy5aby/P5USHJU3DILIygRDfOy1ADoHHZV8
         c1KeR+fhUdbUZizzcb851U5nlNEehjIHza0QAAEE=
Date:   Wed, 6 Apr 2022 21:49:39 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     NeilBrown <neilb@suse.de>
Cc:     Dave Chinner <david@fromorbit.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: sporadic hangs on generic/186
Message-ID: <20220407014939.GC1242@fieldses.org>
References: <20220406195424.GA1242@fieldses.org>
 <20220407001453.GE1609613@dread.disaster.area>
 <164929126156.10985.11316778982526844125@noble.neil.brown.name>
 <164929437439.10985.5253499040284089154@noble.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <164929437439.10985.5253499040284089154@noble.neil.brown.name>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 07, 2022 at 11:19:34AM +1000, NeilBrown wrote:
> I had a look through the various places where alloc can now fail.
> 
> I think xdr_alloc_bvec() in xprt_sent_pagedata() is the most likely
> cause of a problem here.  I don't think an -ENOMEM from there is caught,
> so it could likely filter up to NFS and result in the message you got.
> 
> I don't think we can easily handle failure there.  We need to stay with
> GFP_KERNEL rely on PF_MEMALLOC to make forward progress for
> swap-over-NFS.
> 
> Bruce: can you change that one line back to GFP_KERNEL and see if the
> problem goes away?

Like this?  Sure--might take me a day or two to run the tests and get
results back.--b.

diff --git a/net/sunrpc/socklib.c b/net/sunrpc/socklib.c
index 05b38bf68316..506627dc9a0f 100644
--- a/net/sunrpc/socklib.c
+++ b/net/sunrpc/socklib.c
@@ -223,7 +223,7 @@ static int xprt_send_pagedata(struct socket *sock, struct msghdr *msg,
 {
 	int err;
 
-	err = xdr_alloc_bvec(xdr, rpc_task_gfp_mask());
+	err = xdr_alloc_bvec(xdr, GFP_KERNEL);
 	if (err < 0)
 		return err;
 
