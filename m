Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8148C759CCD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Jul 2023 19:49:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbjGSRt3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Jul 2023 13:49:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjGSRt2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Jul 2023 13:49:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E92F71BFC;
        Wed, 19 Jul 2023 10:49:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7A475617DA;
        Wed, 19 Jul 2023 17:49:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED892C433CC;
        Wed, 19 Jul 2023 17:49:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689788965;
        bh=TofL5mVzu4C/L4DjUgcoScJUatOY9WWJm39F2sRjLVA=;
        h=From:Date:Subject:To:Cc:From;
        b=M034Za2FpW+3EVQIYQV9e+UNrwnzM0OFEBHI5xZM8XNf10pNn2jgVmpspUcSED7k1
         gE2BR2p/q/amX6xVJgiJx6jxye3buwriRegJSeOdaynSyyqbZYyAjDBR+v2tKorAhP
         Mj8K9J3zDDNljla4lTfzi+CrTxfn2YD6HBOjMtjuqiKP4PJPG89iRWsydRnQklHYQI
         LdR4M5flasvqCmrhHiQ6GnYmTILyCotCz5Dgce0s/0SdtU2hG/eB1PDFDFqFeUHsuH
         Rqa2NFkjch9MTNH30iJ0uHYD4z3DFHtR/0TYZ+mRGmex8Ka3P9h3e/POO18iGJji1s
         NsUEcpTuxfX8w==
From:   Jeff Layton <jlayton@kernel.org>
Date:   Wed, 19 Jul 2023 13:49:11 -0400
Subject: [PATCH] nfsd: inherit required unset default acls from effective
 set
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230719-nfsd-acl-v1-1-eb0faf3d2917@kernel.org>
X-B4-Tracking: v=1; b=H4sIABYiuGQC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2MDc0NL3by04hTdxOQcXdPEJDNDU2PzVJNUMyWg8oKi1LTMCrBR0bG1tQD
 Py8EXWgAAAA==
To:     Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>
Cc:     linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Ondrej Valousek <ondrej.valousek@diasemi.com>,
        Andreas Gruenbacher <agruen@redhat.com>,
        Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=5602; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=TofL5mVzu4C/L4DjUgcoScJUatOY9WWJm39F2sRjLVA=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBkuCIksAhStJp5YfqvzC4PrwHM8Qp/38l9X3ORH
 c5w6CCYOrqJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZLgiJAAKCRAADmhBGVaC
 FeCeEACTdAWKldLHFGC/yGeQFZ8WJx+2V7YcLBlfOiS7Y+U4xHAjdwHWQgNGaCClL1z4mjC6gfg
 fpQluIPRHsLSQdVEKOMPdets7mNlJYuRs+q53TJMWb/qBoYjV1cpw02MQjsswbivKPGM/YHlMJx
 NM+wCOg0Id0Rd770SP6WRgCe3X2rPN003Yki674T4qn0JYCx62sTxHOUnbIVkE/g8BrRxGu2cdp
 bIEOJjbp3ggOUdIHhQ89gsh55F3SSq7Ci1Yd3sYiRGetOJPXsruucizMpAZFqrlRFrTG9bBysFj
 /xNfJhX0naXnDdHckj3gR0mKFNaGgaB+J0X//LiOFLJPEjFeNkD4MeP+Vu0AjkxlLq+kFq735SF
 OSEmXHFTjbDLnrx//U6UJu6gVI3ltvOCYkveFvRf99V8uKUS/XIRT+3EjfN40zaBElvZCkkj+tm
 0noYmTiz1G+/5dzh47YC5umCNWaeIiivrUW0OmLvorHZhSYx156WUMaTikDOD/lmThwTEEDsu0u
 l78MSXWSzSkd8SRcWU5kNCJ7uf20ex1MyzHE+L+dH76YVMPRSc6jCCyzuzEh+X5Yg3Lg7vXeE7q
 tgEZVl/VljXgS71CM9wiilSQR5x0NTWzaAsLCTQp/tgGMauKBCBJbJH4l49bd32kxyawG1Rh23l
 a3CWFCJZeTMdEhw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

A well-formed NFSv4 ACL will always contain OWNER@/GROUP@/EVERYONE@
ACEs, but there is no requirement for inheritable entries for those
entities. POSIX ACLs must always have owner/group/other entries, even for a
default ACL.

nfsd builds the default ACL from inheritable ACEs, but the current code
just leaves any unspecified ACEs zeroed out. The result is that adding a
default user or group ACE to an inode can leave it with unwanted deny
entries.

For instance, a newly created directory with no acl will look something
like this:

	# NFSv4 translation by server
	A::OWNER@:rwaDxtTcCy
	A::GROUP@:rxtcy
	A::EVERYONE@:rxtcy

	# POSIX ACL of underlying file
	user::rwx
	group::r-x
	other::r-x

...if I then add new v4 ACE:

	nfs4_setfacl -a A:fd:1000:rwx /mnt/local/test

...I end up with a result like this today:

	user::rwx
	user:1000:rwx
	group::r-x
	mask::rwx
	other::r-x
	default:user::---
	default:user:1000:rwx
	default:group::---
	default:mask::rwx
	default:other::---

	A::OWNER@:rwaDxtTcCy
	A::1000:rwaDxtcy
	A::GROUP@:rxtcy
	A::EVERYONE@:rxtcy
	D:fdi:OWNER@:rwaDx
	A:fdi:OWNER@:tTcCy
	A:fdi:1000:rwaDxtcy
	A:fdi:GROUP@:tcy
	A:fdi:EVERYONE@:tcy

...which is not at all expected. Adding a single inheritable allow ACE
should not result in everyone else losing access.

The setfacl command solves a silimar issue by copying owner/group/other
entries from the effective ACL when none of them are set:

    "If a Default ACL entry is created, and the  Default  ACL  contains  no
     owner,  owning group,  or  others  entry,  a  copy of the ACL owner,
     owning group, or others entry is added to the Default ACL.

Having nfsd do the same provides a more sane result (with no deny ACEs
in the resulting set):

	user::rwx
	user:1000:rwx
	group::r-x
	mask::rwx
	other::r-x
	default:user::rwx
	default:user:1000:rwx
	default:group::r-x
	default:mask::rwx
	default:other::r-x

	A::OWNER@:rwaDxtTcCy
	A::1000:rwaDxtcy
	A::GROUP@:rxtcy
	A::EVERYONE@:rxtcy
	A:fdi:OWNER@:rwaDxtTcCy
	A:fdi:1000:rwaDxtcy
	A:fdi:GROUP@:rxtcy
	A:fdi:EVERYONE@:rxtcy

Link: https://bugzilla.redhat.com/show_bug.cgi?id=2136452
Reported-by: Ondrej Valousek <ondrej.valousek@diasemi.com>
Suggested-by: Andreas Gruenbacher <agruen@redhat.com>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4acl.c | 32 +++++++++++++++++++++++++++++---
 1 file changed, 29 insertions(+), 3 deletions(-)

diff --git a/fs/nfsd/nfs4acl.c b/fs/nfsd/nfs4acl.c
index 518203821790..64e45551d1b6 100644
--- a/fs/nfsd/nfs4acl.c
+++ b/fs/nfsd/nfs4acl.c
@@ -441,7 +441,8 @@ struct posix_ace_state_array {
  * calculated so far: */
 
 struct posix_acl_state {
-	int empty;
+	bool empty;
+	unsigned char valid;
 	struct posix_ace_state owner;
 	struct posix_ace_state group;
 	struct posix_ace_state other;
@@ -457,7 +458,7 @@ init_state(struct posix_acl_state *state, int cnt)
 	int alloc;
 
 	memset(state, 0, sizeof(struct posix_acl_state));
-	state->empty = 1;
+	state->empty = true;
 	/*
 	 * In the worst case, each individual acl could be for a distinct
 	 * named user or group, but we don't know which, so we allocate
@@ -624,7 +625,7 @@ static void process_one_v4_ace(struct posix_acl_state *state,
 	u32 mask = ace->access_mask;
 	int i;
 
-	state->empty = 0;
+	state->empty = false;
 
 	switch (ace2type(ace)) {
 	case ACL_USER_OBJ:
@@ -633,6 +634,7 @@ static void process_one_v4_ace(struct posix_acl_state *state,
 		} else {
 			deny_bits(&state->owner, mask);
 		}
+		state->valid |= ACL_USER_OBJ;
 		break;
 	case ACL_USER:
 		i = find_uid(state, ace->who_uid);
@@ -655,6 +657,7 @@ static void process_one_v4_ace(struct posix_acl_state *state,
 			deny_bits_array(state->users, mask);
 			deny_bits_array(state->groups, mask);
 		}
+		state->valid |= ACL_GROUP_OBJ;
 		break;
 	case ACL_GROUP:
 		i = find_gid(state, ace->who_gid);
@@ -686,6 +689,7 @@ static void process_one_v4_ace(struct posix_acl_state *state,
 			deny_bits_array(state->users, mask);
 			deny_bits_array(state->groups, mask);
 		}
+		state->valid |= ACL_OTHER;
 	}
 }
 
@@ -726,6 +730,28 @@ static int nfs4_acl_nfsv4_to_posix(struct nfs4_acl *acl,
 		if (!(ace->flag & NFS4_ACE_INHERIT_ONLY_ACE))
 			process_one_v4_ace(&effective_acl_state, ace);
 	}
+
+	/*
+	 * At this point, the default ACL may have zeroed-out entries for owner,
+	 * group and other. That usually results in a non-sensical resulting ACL
+	 * that denies all access except to any ACE that was explicitly added.
+	 *
+	 * The setfacl command solves a similar problem with this logic:
+	 *
+	 * "If  a  Default  ACL  entry is created, and the Default ACL contains
+	 *  no owner, owning group, or others entry,  a  copy of  the  ACL
+	 *  owner, owning group, or others entry is added to the Default ACL."
+	 *
+	 * If none of the requisite ACEs were set, and some explicit user or group
+	 * ACEs were, copy the requisite entries from the effective set.
+	 */
+	if (!default_acl_state.valid &&
+	    (default_acl_state.users->n || default_acl_state.groups->n)) {
+		default_acl_state.owner = effective_acl_state.owner;
+		default_acl_state.group = effective_acl_state.group;
+		default_acl_state.other = effective_acl_state.other;
+	}
+
 	*pacl = posix_state_to_acl(&effective_acl_state, flags);
 	if (IS_ERR(*pacl)) {
 		ret = PTR_ERR(*pacl);

---
base-commit: 9d985ab8ed33176c3c0380b7de589ea2ae51a48d
change-id: 20230719-nfsd-acl-5ab61537e4e6

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>

