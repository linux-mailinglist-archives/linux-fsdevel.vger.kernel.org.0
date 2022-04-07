Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D44C4F7467
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Apr 2022 06:11:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234225AbiDGENg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Apr 2022 00:13:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232256AbiDGENf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Apr 2022 00:13:35 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29FD116D8FC;
        Wed,  6 Apr 2022 21:11:35 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 735BC21122;
        Thu,  7 Apr 2022 04:11:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1649304694; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Sg3W/fQqWey2t7e/ZGF7hNUHXAhIw938UOc/ir5nbJs=;
        b=R/9ik6gz6+gm1FbUonPeE8vgAvNemRWnxXGYQz2Cb1b7qccJq79T/GNO8WfJ5Hxqxo29bw
        MQd0sYqZ0Us84Kr7BR5aBvB05oAfwZsPUQ0rAyPo3apKjMlUCag9SdH5zE4GZaYLkYOUol
        IIN/Fr2vkx6dT4bKg0zvii7uUlxr9bk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1649304694;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Sg3W/fQqWey2t7e/ZGF7hNUHXAhIw938UOc/ir5nbJs=;
        b=oDd7Mu2vKwzc+mEdQz5z1ICvJTSYXwmlF5daqrLULtnT7LJQ11bWCaJrwROgFHj9p4icBU
        MUCP2CaHCQ0NdTDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7B776139F5;
        Thu,  7 Apr 2022 04:11:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id LI2iDXRkTmIiLwAAMHmgww
        (envelope-from <neilb@suse.de>); Thu, 07 Apr 2022 04:11:32 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Trond Myklebust" <trondmy@hammerspace.com>
Cc:     "david@fromorbit.com" <david@fromorbit.com>,
        "bfields@fieldses.org" <bfields@fieldses.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
Subject: Re: sporadic hangs on generic/186
In-reply-to: <b282c5b98c4518952f62662ea3ba1d4e6ef85f26.camel@hammerspace.com>
References: <20220406195424.GA1242@fieldses.org>,
 <20220407001453.GE1609613@dread.disaster.area>,
 <164929126156.10985.11316778982526844125@noble.neil.brown.name>,
 <164929437439.10985.5253499040284089154@noble.neil.brown.name>,
 <b282c5b98c4518952f62662ea3ba1d4e6ef85f26.camel@hammerspace.com>
Date:   Thu, 07 Apr 2022 14:11:28 +1000
Message-id: <164930468885.10985.9905950866720150663@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 07 Apr 2022, Trond Myklebust wrote:
> On Thu, 2022-04-07 at 11:19 +1000, NeilBrown wrote:
> > On Thu, 07 Apr 2022, NeilBrown wrote:
> > > On Thu, 07 Apr 2022, Dave Chinner wrote:
> > > > On Wed, Apr 06, 2022 at 03:54:24PM -0400, J. Bruce Fields wrote:
> > > > > In the last couple days I've started getting hangs on xfstests
> > > > > generic/186 on upstream.=C2=A0 I also notice the test completes
> > > > > after 10+
> > > > > hours (usually it takes about 5 minutes).=C2=A0 Sometimes this is
> > > > > accompanied
> > > > > by "nfs: RPC call returned error 12" on the client.
> > > >=20
> > > > #define ENOMEM=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
12=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Out of memory */
> > > >=20
> > > > So either the client or the server is running out of memory
> > > > somewhere?
> > >=20
> > > Probably the client.=C2=A0 There are a bunch of changes recently which
> > > add
> > > __GFP_NORETRY to memory allocations from PF_WQ_WORKERs because that
> > > can
> > > result in deadlocks when swapping over NFS.
> > > This means that kmalloc request that previously never failed
> > > (because
> > > GFP_KERNEL never fails for kernel threads I think) can now fail.=C2=A0
> > > This
> > > has tickled one bug that I know of.=C2=A0 There are likely to be more.
> > >=20
> > > The RPC code should simply retry these allocations after a short
> > > delay.=20
> > > HZ/4 is the number that is used in a couple of places.=C2=A0 Possibly
> > > there
> > > are more places that need to handle -ENOMEM with rpc_delay().
> >=20
> > I had a look through the various places where alloc can now fail.
> >=20
> > I think xdr_alloc_bvec() in xprt_sent_pagedata() is the most likely
> > cause of a problem here.=C2=A0 I don't think an -ENOMEM from there is
> > caught,
> > so it could likely filter up to NFS and result in the message you
> > got.
> >=20
> > I don't think we can easily handle failure there.=C2=A0 We need to stay
> > with
> > GFP_KERNEL rely on PF_MEMALLOC to make forward progress for
> > swap-over-NFS.
> >=20
> > Bruce: can you change that one line back to GFP_KERNEL and see if the
> > problem goes away?
> >=20
>=20
> Can we please just move the call to xdr_alloc_bvec() out of
> xprt_send_pagedata()? Move the client side allocation into
> xs_stream_prepare_request() and xs_udp_send_request(), then move the
> server side allocation into svc_udp_sendto().
>=20
> That makes it possible to handle errors.

Like the below I guess.  Seems sensible, but I don't know the code well
enough to really review it.

>=20
> > The other problem I found is that rpc_alloc_task() can now fail, but
> > rpc_new_task assumes that it never will.=C2=A0 If it does, then we get a
> > NULL
> > deref.
> >=20
> > I don't think rpc_new_task() can ever be called from the rpciod work
> > queue, so it is safe to just use a mempool with GFP_KERNEL like we
> > did
> > before.=20
> >=20
> No. We shouldn't ever use mempools with GFP_KERNEL.

Why not?  mempools with GFP_KERNEL make perfect sense outside of the
rpciod and nfsiod threads.

>=20
> Most, if not all of the callers of rpc_run_task() are still capable of
> dealing with errors, and ditto for the callers of rpc_run_bc_task().

Yes, they can deal with errors.  But in many cases that do so by passing
the error up the call stack so we could start getting ENOMEM for
systemcalls like stat().  I don't think that is a good idea.

Thanks,
NeilBrown


>=20
> --=20
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com
>=20
>=20
>=20

diff --git a/net/sunrpc/socklib.c b/net/sunrpc/socklib.c
index 05b38bf68316..71ba4cf513bc 100644
--- a/net/sunrpc/socklib.c
+++ b/net/sunrpc/socklib.c
@@ -221,12 +221,6 @@ static int xprt_send_kvec(struct socket *sock, struct ms=
ghdr *msg,
 static int xprt_send_pagedata(struct socket *sock, struct msghdr *msg,
 			      struct xdr_buf *xdr, size_t base)
 {
-	int err;
-
-	err =3D xdr_alloc_bvec(xdr, rpc_task_gfp_mask());
-	if (err < 0)
-		return err;
-
 	iov_iter_bvec(&msg->msg_iter, WRITE, xdr->bvec, xdr_buf_pagecount(xdr),
 		      xdr->page_len + xdr->page_base);
 	return xprt_sendmsg(sock, msg, base + xdr->page_base);
diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
index 78af7518f263..2661828f7a85 100644
--- a/net/sunrpc/xprtsock.c
+++ b/net/sunrpc/xprtsock.c
@@ -828,6 +828,9 @@ xs_stream_prepare_request(struct rpc_rqst *req)
 	xdr_free_bvec(&req->rq_rcv_buf);
 	req->rq_task->tk_status =3D xdr_alloc_bvec(
 		&req->rq_rcv_buf, GFP_KERNEL | __GFP_NORETRY | __GFP_NOWARN);
+	if (req->rq_task->tk_status =3D=3D 0)
+	req->rq_task->tk_status =3D xdr_alloc_bvec(
+		&req->rq_snd_buf, GFP_KERNEL | __GFP_NORETRY | __GFP_NOWARN);
 }
=20
 /*
