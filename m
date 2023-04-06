Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C2B26DA57E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Apr 2023 00:04:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237384AbjDFWEm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Apr 2023 18:04:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjDFWEl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Apr 2023 18:04:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B23419C;
        Thu,  6 Apr 2023 15:04:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 07E86640B5;
        Thu,  6 Apr 2023 22:04:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6297CC433EF;
        Thu,  6 Apr 2023 22:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680818679;
        bh=gSv31GXqMspT4cw2rDvjQ58dEwU++jU7Uf5w2hKIDIQ=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Zs8u9d/ojedGJk01+HASjYKXelYWBgu3u+CEGAmkQv35fERbfydvkqh7RCGWdV7Xh
         97MILzLCOj7pCPyrZ7Zq4rry6E82uJHErr/Rh9KzA2emgaWmSNFcvi+eXkiKn3Dqu3
         lgVRuBGh2ofgiE1ujPNuJAL2v+rvUw+Uh4uWTb/GGqyVC4VX8FmdIdGV4QpY8e/z8J
         PxBU53QrGSQv3SlAQChdu4IEA4PtL/cAMqSExpm3mNXMOwRhbSwDJu0/Yh3PIlQg0/
         bbH/cPZd3jhHqpxQ6ntRROv5r1ZqhO+yRsyLDU+Jd6j8AZX1ySZTqqyp20sAe1/W5D
         RG0lcTKhHWgzg==
Message-ID: <7d8f05e26dc7152dfad771dfc867dec145aa054b.camel@kernel.org>
Subject: Re: [PATCH] overlayfs: Trigger file re-evaluation by IMA / EVM
 after writes
From:   Jeff Layton <jlayton@kernel.org>
To:     Stefan Berger <stefanb@linux.ibm.com>,
        Christian Brauner <brauner@kernel.org>,
        Paul Moore <paul@paul-moore.com>
Cc:     zohar@linux.ibm.com, linux-integrity@vger.kernel.org,
        miklos@szeredi.hu, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        amir73il@gmail.com
Date:   Thu, 06 Apr 2023 18:04:36 -0400
In-Reply-To: <4f739cc6847975991874d56ef9b9716c82cf62a3.camel@kernel.org>
References: <20230405171449.4064321-1-stefanb@linux.ibm.com>
         <20230406-diffamieren-langhaarig-87511897e77d@brauner>
         <CAHC9VhQsnkLzT7eTwVr-3SvUs+mcEircwztfaRtA+4ZaAh+zow@mail.gmail.com>
         <a6c6e0e4-047f-444b-3343-28b71ddae7ae@linux.ibm.com>
         <CAHC9VhQyWa1OnsOvoOzD37EmDnESfo4Rxt2eCSUgu+9U8po-CA@mail.gmail.com>
         <20230406-wasser-zwanzig-791bc0bf416c@brauner>
         <546145ecbf514c4c1a997abade5f74e65e5b1726.camel@kernel.org>
         <45a9c575-0b7e-f66a-4765-884865d14b72@linux.ibm.com>
         <60339e3bd08a18358ac8c8a16dc67c74eb8ba756.camel@kernel.org>
         <d61ed13b-0fd2-0283-96d2-0ff9c5e0a2f9@linux.ibm.com>
         <4f739cc6847975991874d56ef9b9716c82cf62a3.camel@kernel.org>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 2023-04-06 at 17:24 -0400, Jeff Layton wrote:
> On Thu, 2023-04-06 at 16:22 -0400, Stefan Berger wrote:
> >=20
> > On 4/6/23 15:37, Jeff Layton wrote:
> > > On Thu, 2023-04-06 at 15:11 -0400, Stefan Berger wrote:
> > > >=20
> > > > On 4/6/23 14:46, Jeff Layton wrote:
> > > > > On Thu, 2023-04-06 at 17:01 +0200, Christian Brauner wrote:
> > > > > > On Thu, Apr 06, 2023 at 10:36:41AM -0400, Paul Moore wrote:
> > > >=20
> > > > >=20
> > > > > Correct. As long as IMA is also measuring the upper inode then it=
 seems
> > > > > like you shouldn't need to do anything special here.
> > > >=20
> > > > Unfortunately IMA does not notice the changes. With the patch provi=
ded in the other email IMA works as expected.
> > > >=20
> > >=20
> > >=20
> > > It looks like remeasurement is usually done in ima_check_last_writer.
> > > That gets called from __fput which is called when we're releasing the
> > > last reference to the struct file.
> > >=20
> > > You've hooked into the ->release op, which gets called whenever
> > > filp_close is called, which happens when we're disassociating the fil=
e
> > > from the file descriptor table.
> > >=20
> > > So...I don't get it. Is ima_file_free not getting called on your file
> > > for some reason when you go to close it? It seems like that should be
> > > handling this.
> >=20
> > I would ditch the original proposal in favor of this 2-line patch shown=
 here:
> >=20
> > https://lore.kernel.org/linux-integrity/a95f62ed-8b8a-38e5-e468-ecbde3b=
221af@linux.ibm.com/T/#m3bd047c6e5c8200df1d273c0ad551c645dd43232
> >=20
> >=20
>=20
> Ok, I think I get it. IMA is trying to use the i_version from the
> overlayfs inode.
>=20
> I suspect that the real problem here is that IMA is just doing a bare
> inode_query_iversion. Really, we ought to make IMA call
> vfs_getattr_nosec (or something like it) to query the getattr routine in
> the upper layer. Then overlayfs could just propagate the results from
> the upper layer in its response.
>=20
> That sort of design may also eventually help IMA work properly with more
> exotic filesystems, like NFS or Ceph.
>=20
>=20
>=20

Maybe something like this? It builds for me but I haven't tested it. It
looks like overlayfs already should report the upper layer's i_version
in getattr, though I haven't tested that either:

-----------------------8<---------------------------

[PATCH] IMA: use vfs_getattr_nosec to get the i_version

IMA currently accesses the i_version out of the inode directly when it
does a measurement. This is fine for most simple filesystems, but can be
problematic with more complex setups (e.g. overlayfs).

Make IMA instead call vfs_getattr_nosec to get this info. This allows
the filesystem to determine whether and how to report the i_version, and
should allow IMA to work properly with a broader class of filesystems in
the future.

Reported-by: Stefan Berger <stefanb@linux.ibm.com>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 security/integrity/ima/ima_api.c  |  9 ++++++---
 security/integrity/ima/ima_main.c | 12 ++++++++----
 2 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_=
api.c
index d3662f4acadc..c45902e72044 100644
--- a/security/integrity/ima/ima_api.c
+++ b/security/integrity/ima/ima_api.c
@@ -13,7 +13,6 @@
 #include <linux/fs.h>
 #include <linux/xattr.h>
 #include <linux/evm.h>
-#include <linux/iversion.h>
 #include <linux/fsverity.h>
=20
 #include "ima.h"
@@ -246,10 +245,11 @@ int ima_collect_measurement(struct integrity_iint_cac=
he *iint,
 	struct inode *inode =3D file_inode(file);
 	const char *filename =3D file->f_path.dentry->d_name.name;
 	struct ima_max_digest_data hash;
+	struct kstat stat;
 	int result =3D 0;
 	int length;
 	void *tmpbuf;
-	u64 i_version;
+	u64 i_version =3D 0;
=20
 	/*
 	 * Always collect the modsig, because IMA might have already collected
@@ -268,7 +268,10 @@ int ima_collect_measurement(struct integrity_iint_cach=
e *iint,
 	 * to an initial measurement/appraisal/audit, but was modified to
 	 * assume the file changed.
 	 */
-	i_version =3D inode_query_iversion(inode);
+	result =3D vfs_getattr_nosec(&file->f_path, &stat, STATX_CHANGE_COOKIE,
+				   AT_STATX_SYNC_AS_STAT);
+	if (!result && (stat.result_mask & STATX_CHANGE_COOKIE))
+		i_version =3D stat.change_cookie;
 	hash.hdr.algo =3D algo;
 	hash.hdr.length =3D hash_digest_size[algo];
=20
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima=
_main.c
index d66a0a36415e..365db0e43d7c 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -24,7 +24,6 @@
 #include <linux/slab.h>
 #include <linux/xattr.h>
 #include <linux/ima.h>
-#include <linux/iversion.h>
 #include <linux/fs.h>
=20
 #include "ima.h"
@@ -164,11 +163,16 @@ static void ima_check_last_writer(struct integrity_ii=
nt_cache *iint,
=20
 	mutex_lock(&iint->mutex);
 	if (atomic_read(&inode->i_writecount) =3D=3D 1) {
+		struct kstat stat;
+
 		update =3D test_and_clear_bit(IMA_UPDATE_XATTR,
 					    &iint->atomic_flags);
-		if (!IS_I_VERSION(inode) ||
-		    !inode_eq_iversion(inode, iint->version) ||
-		    (iint->flags & IMA_NEW_FILE)) {
+		if ((iint->flags & IMA_NEW_FILE) ||
+		    vfs_getattr_nosec(&file->f_path, &stat,
+				      STATX_CHANGE_COOKIE,
+				      AT_STATX_SYNC_AS_STAT) ||
+		    !(stat.result_mask & STATX_CHANGE_COOKIE) ||
+		    stat.change_cookie !=3D iint->version) {
 			iint->flags &=3D ~(IMA_DONE_MASK | IMA_NEW_FILE);
 			iint->measured_pcrs =3D 0;
 			if (update)
--=20
2.39.2


