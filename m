Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 246FA77D1AB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Aug 2023 20:22:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239044AbjHOSVx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Aug 2023 14:21:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239018AbjHOSVX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Aug 2023 14:21:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A0091BC3;
        Tue, 15 Aug 2023 11:21:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 289AB64A63;
        Tue, 15 Aug 2023 18:21:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84FB7C433C7;
        Tue, 15 Aug 2023 18:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692123681;
        bh=fKF+2PCMKnno8nH7qPTTbfIaqiCSsM9f+2zvVbfY8eU=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=R3J0foj9xewEMjplkVcROv3AAVbIh1XveOy5hmCECKFCBYNnhFpwnVgeFcIsWK4CQ
         99H2RAuAwiQPwWsPHBRV4eLmv6UIQTPLoxF4pCxOoJdjSErdF+OPKZa4ghX3sZepzm
         0UvuQw6YZeS+sUmD5EP+40fXl5/aKNWmH1wQwuad1ww64edARdV+lZBxR7VPneGwGI
         p86qdllbNpSSMGTRtp0nwhKfoaJb+Ze+r/bWVOkOy7FcldK8heyjYCn3F5kQ987chG
         56lxeYSVH2cKcRR17g8JOpgVzdzV6t9RfeAF4jZXJmQP0pCG0dKHNWoVIOSaIl6JaD
         J03O2TeYobWIA==
Message-ID: <350395c8906f46ec4634392adb8a9e3927763ef1.camel@kernel.org>
Subject: Re: [RFCv2 1/7] lockd: fix race in async lock request handling
From:   Jeff Layton <jlayton@kernel.org>
To:     Alexander Aring <aahringo@redhat.com>, linux-nfs@vger.kernel.org
Cc:     cluster-devel@redhat.com, ocfs2-devel@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, teigland@redhat.com,
        rpeterso@redhat.com, agruenba@redhat.com,
        trond.myklebust@hammerspace.com, anna@kernel.org,
        chuck.lever@oracle.com
Date:   Tue, 15 Aug 2023 14:21:19 -0400
In-Reply-To: <c049f33344990f74c2b88cc3279a913f6ff6f498.camel@kernel.org>
References: <20230814211116.3224759-1-aahringo@redhat.com>
         <20230814211116.3224759-2-aahringo@redhat.com>
         <c049f33344990f74c2b88cc3279a913f6ff6f498.camel@kernel.org>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 2023-08-15 at 13:49 -0400, Jeff Layton wrote:
> On Mon, 2023-08-14 at 17:11 -0400, Alexander Aring wrote:
> > This patch fixes a race in async lock request handling between adding
> > the relevant struct nlm_block to nlm_blocked list after the request was
> > sent by vfs_lock_file() and nlmsvc_grant_deferred() does a lookup of th=
e
> > nlm_block in the nlm_blocked list. It could be that the async request i=
s
> > completed before the nlm_block was added to the list. This would end
> > in a -ENOENT and a kernel log message of "lockd: grant for unknown
> > block".
> >=20
> > To solve this issue we add the nlm_block before the vfs_lock_file() cal=
l
> > to be sure it has been added when a possible nlmsvc_grant_deferred() is
> > called. If the vfs_lock_file() results in an case when it wouldn't be
> > added to nlm_blocked list, the nlm_block struct will be removed from
> > this list again.
> >=20
> > The introducing of the new B_PENDING_CALLBACK nlm_block flag will handl=
e
> > async lock requests on a pending lock requests as a retry on the caller
> > level to hit the -EAGAIN case.
> >=20
> > Signed-off-by: Alexander Aring <aahringo@redhat.com>
> > ---
> >  fs/lockd/svclock.c          | 100 ++++++++++++++++++++++++++----------
> >  include/linux/lockd/lockd.h |   2 +
> >  2 files changed, 74 insertions(+), 28 deletions(-)
> >=20
> >=20

[...]

> > diff --git a/include/linux/lockd/lockd.h b/include/linux/lockd/lockd.h
> > index f42594a9efe0..91f55458f5fc 100644
> > --- a/include/linux/lockd/lockd.h
> > +++ b/include/linux/lockd/lockd.h
> > @@ -185,10 +185,12 @@ struct nlm_block {
> >  	struct nlm_file *	b_file;		/* file in question */
> >  	struct cache_req *	b_cache_req;	/* deferred request handling */
> >  	struct cache_deferred_req * b_deferred_req
> > +	struct mutex		b_cb_mutex;	/* callback mutex */
>=20
> There is no mention at all of this new mutex in the changelog or
> comments. It's not at all clear to me what this is intended to protect.
> In general, with lockd being a single-threaded service, we want to avoid
> sleeping locks. This will need some clear justification.
>=20
> At a glance, it looks like you're trying to use this to hold
> B_PENDING_CALLBACK steady while a lock request is being handled. That
> suggests that you're using this mutex to serialize access to a section
> of code and not one or more specific data structures. We usually like to
> avoid that sort of thing, since locks that protect arbitrary sections of
> code become difficult to work with over time.
>=20
> I'm going to go out on a limb here though and suggest that there is
> probably a way to solve this problem that doesn't involve adding new
> locks.
>=20
> >  	unsigned int		b_flags;	/* block flags */
> >  #define B_QUEUED		1	/* lock queued */
> >  #define B_GOT_CALLBACK		2	/* got lock or conflicting lock */
> >  #define B_TIMED_OUT		4	/* filesystem too slow to respond */
> > +#define B_PENDING_CALLBACK	8	/* pending callback for lock request */
> >  };
> > =20
> >  /*
>=20
> Do we need this new flag at all? It seems redundant. If we have a block
> on the list, then it is sort of by definition "pending callback". If
> it's not on the list anymore, then it's not. No?
>=20

Do we need anything more than a patch along these lines? Note that this
is untested, so RFC:

---------------------8<-----------------------

[RFC PATCH] lockd: alternate fix for race between deferred lock and grant

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/lockd/svclock.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/lockd/svclock.c b/fs/lockd/svclock.c
index c43ccdf28ed9..e9a84363c26e 100644
--- a/fs/lockd/svclock.c
+++ b/fs/lockd/svclock.c
@@ -446,6 +446,8 @@ nlmsvc_defer_lock_rqst(struct svc_rqst *rqstp, struct n=
lm_block *block)
=20
 	block->b_flags |=3D B_QUEUED;
=20
+	/* FIXME: remove and reinsert w/o dropping spinlock */
+	nlmsvc_remove_block(block);
 	nlmsvc_insert_block(block, NLM_TIMEOUT);
=20
 	block->b_cache_req =3D &rqstp->rq_chandle;
@@ -535,6 +537,9 @@ nlmsvc_lock(struct svc_rqst *rqstp, struct nlm_file *fi=
le,
 	if (!wait)
 		lock->fl.fl_flags &=3D ~FL_SLEEP;
 	mode =3D lock_to_openmode(&lock->fl);
+
+	/* Append to list of blocked */
+	nlmsvc_insert_block(block, NLM_NEVER);
 	error =3D vfs_lock_file(file->f_file[mode], F_SETLK, &lock->fl, NULL);
 	lock->fl.fl_flags &=3D ~FL_SLEEP;
=20
@@ -542,6 +547,7 @@ nlmsvc_lock(struct svc_rqst *rqstp, struct nlm_file *fi=
le,
 	switch (error) {
 		case 0:
 			ret =3D nlm_granted;
+			nlmsvc_remove_block(block);
 			goto out;
 		case -EAGAIN:
 			/*
@@ -552,6 +558,7 @@ nlmsvc_lock(struct svc_rqst *rqstp, struct nlm_file *fi=
le,
 			if (wait)
 				break;
 			ret =3D async_block ? nlm_lck_blocked : nlm_lck_denied;
+			nlmsvc_remove_block(block);
 			goto out;
 		case FILE_LOCK_DEFERRED:
 			if (wait)
@@ -570,8 +577,6 @@ nlmsvc_lock(struct svc_rqst *rqstp, struct nlm_file *fi=
le,
=20
 	ret =3D nlm_lck_blocked;
=20
-	/* Append to list of blocked */
-	nlmsvc_insert_block(block, NLM_NEVER);
 out:
 	mutex_unlock(&file->f_mutex);
 	nlmsvc_release_block(block);
--=20
2.41.0


