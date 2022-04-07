Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BABE4F7484
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Apr 2022 06:23:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236211AbiDGEZL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Apr 2022 00:25:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbiDGEZJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Apr 2022 00:25:09 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 353F3764D;
        Wed,  6 Apr 2022 21:23:06 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 795DD1F859;
        Thu,  7 Apr 2022 04:23:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1649305385; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2LjY7E5WI6EGhhDKTioLFymIZP0/l0i8h3H4GhAFZcA=;
        b=F64T87FE/B/zTRK/zeGFkzYbcOYEpfk4hnza8TqQk86fb0axJLHNv5/xh8kYqv7ft0gVH8
        E4jSlVrvNZLiNrz++QdRHQVn4EEJ3zqlEuJI9tcsOmTRHuGjgqtqrGC/4B5bZ34jlQ6VpB
        ORtNpbLkZm7a0/adFulXHuY/VjPvj+4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1649305385;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2LjY7E5WI6EGhhDKTioLFymIZP0/l0i8h3H4GhAFZcA=;
        b=Pe5uAttmH0M6hNr5cKECyxYRW/m61uJ8W+AceMtxNsBGpXkrDfnp8bTpIjeKsG1ZJmKxAd
        U4XNi9Yd5S2L5nCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 820D313A66;
        Thu,  7 Apr 2022 04:23:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id OHErDydnTmImMgAAMHmgww
        (envelope-from <neilb@suse.de>); Thu, 07 Apr 2022 04:23:03 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     "Dave Chinner" <david@fromorbit.com>,
        "Trond Myklebust" <trondmy@hammerspace.com>,
        "Chuck Lever" <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: sporadic hangs on generic/186
In-reply-to: <20220407014939.GC1242@fieldses.org>
References: <20220406195424.GA1242@fieldses.org>,
 <20220407001453.GE1609613@dread.disaster.area>,
 <164929126156.10985.11316778982526844125@noble.neil.brown.name>,
 <164929437439.10985.5253499040284089154@noble.neil.brown.name>,
 <20220407014939.GC1242@fieldses.org>
Date:   Thu, 07 Apr 2022 14:23:00 +1000
Message-id: <164930538057.10985.13909676315036428067@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 07 Apr 2022, J. Bruce Fields wrote:
> On Thu, Apr 07, 2022 at 11:19:34AM +1000, NeilBrown wrote:
> > I had a look through the various places where alloc can now fail.
> >=20
> > I think xdr_alloc_bvec() in xprt_sent_pagedata() is the most likely
> > cause of a problem here.  I don't think an -ENOMEM from there is caught,
> > so it could likely filter up to NFS and result in the message you got.
> >=20
> > I don't think we can easily handle failure there.  We need to stay with
> > GFP_KERNEL rely on PF_MEMALLOC to make forward progress for
> > swap-over-NFS.
> >=20
> > Bruce: can you change that one line back to GFP_KERNEL and see if the
> > problem goes away?
>=20
> Like this?  Sure--might take me a day or two to run the tests and get
> results back.--b.
>=20
> diff --git a/net/sunrpc/socklib.c b/net/sunrpc/socklib.c
> index 05b38bf68316..506627dc9a0f 100644
> --- a/net/sunrpc/socklib.c
> +++ b/net/sunrpc/socklib.c
> @@ -223,7 +223,7 @@ static int xprt_send_pagedata(struct socket *sock, stru=
ct msghdr *msg,
>  {
>  	int err;
> =20
> -	err =3D xdr_alloc_bvec(xdr, rpc_task_gfp_mask());
> +	err =3D xdr_alloc_bvec(xdr, GFP_KERNEL);
>  	if (err < 0)
>  		return err;
> =20
>=20

That looks right.

I instrumented my kernel to deliberately fail 10% of the time, and I got
lots of

nfs: RPC call returned error 12

so I'm fairly sure this explains that message.
But you say the hangs were only occasionally accompanied by the message,
so it probably doesn't explain the hangs.

NeilBrown
