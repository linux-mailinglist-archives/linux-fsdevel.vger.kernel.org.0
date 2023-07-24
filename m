Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F8A775F5B4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jul 2023 14:13:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbjGXMNR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jul 2023 08:13:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjGXMNQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jul 2023 08:13:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57F791BF;
        Mon, 24 Jul 2023 05:13:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CF7266111F;
        Mon, 24 Jul 2023 12:13:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 391B9C433C8;
        Mon, 24 Jul 2023 12:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690200794;
        bh=5lARTRlkcLkwGHmez9f9aPfhEdGhUKlUDQvXf3fnxUs=;
        h=From:Date:Subject:To:Cc:From;
        b=SgkOYSbsypxENA7qLIE42GPi9QQvDn8kOXcpBs79FktLXUKABXbRW5Rp0VaUuWdpr
         G+VwtwKT/iDQ0hWPf2bNTb/xYVk07Ch+4ssYK44I7Xul9htnH76ar4YvwczNlZMa0d
         binvBO7joXNFSYEWB4+AQAHyf+I6XNerocP/F7xczKsZQA9HA1554fSP2JnVolErqG
         FtPjo7eD7zAPUuapTl0wsfyEaxUwPXAZhGlzRWyq4mWo7TSLzt5Acg5f5qFvAX8x10
         ZrXj+LWb0/bepQMTJXeoxtsbRrM3TyaaSmVlFPZR/9Nr8c8+oVk2TkBHldqptLDw+A
         3ejBpJ3E34LKQ==
From:   Jeff Layton <jlayton@kernel.org>
Date:   Mon, 24 Jul 2023 08:13:05 -0400
Subject: [PATCH v2] nfsd: inherit required unset default acls from
 effective set
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230724-nfsd-acl-v2-1-1cfaac973498@kernel.org>
X-B4-Tracking: v=1; b=H4sIANBqvmQC/23Myw6CMBCF4Vchs3ZML0KDK9/DsCh0ChNJMa1pN
 KTvbmXt8j85+XZIFJkSXJsdImVOvIUa6tTAtNgwE7KrDUooLYzsMfjk0E4rtnbsZKsNXaiDen9
 G8vw+qPtQe+H02uLnkLP8rX+QLFEijcJbr53qpbk9KAZaz1ucYSilfAEAo/veoQAAAA==
To:     Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Ondrej Valousek <ondrej.valousek@diasemi.com>,
        Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=5550; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=5lARTRlkcLkwGHmez9f9aPfhEdGhUKlUDQvXf3fnxUs=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBkvmrY2NPF3xcpJD5VmN8da0rZmazOFfAGJk/vF
 3yCe0PvzwGJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZL5q2AAKCRAADmhBGVaC
 FYz2D/9avmrWR7g+tY4C0l/iG/c6BSsASRhbPCfBfaCtCFD0HI54YZPjqG7rxh5sE75gOd4l8ht
 sdzNc2qew/AleCsn4e8lIN1+hFvGRh2VTSuiE36GdudaU5qrW9J/9jm3F/Af7vT3PDtes5RxQBZ
 1sNYi++smIz+NS/h+TWZndRTH/Psgm0M7X7yeH5n1yELqmkAC1z5uRJUPdsDifNY4gyUq1f72QZ
 IKeeWuUlB1ppts9Gl76SGKoZqLOs7hvr4jrSC/98eAEvJ23DVYvEwwFC7wWRGfbP5r0urBF/CD0
 2NdG6AHIGfeBuCHhJc6bswZEEX+9FiEMrrMgCpcAFfKcgjbNzd9FkHPE7IcQJFNUfBXbIu5vnM0
 NIWm3Ht95ciJtsxsdf8ajF9r+vW5lW+KI3jlNXbqDBibyFgKacg0NLQhaeBAkJsqko4vnDo/Vug
 sc7IA1sv576yblWC8YkYB1snbg1cedQ/RiYnh5AEllHmJyK0vchlqxYu/DlH+rTKZRVD4mEqocO
 5jG58cJ1LCVBvLDpZvVsZcYrQQz0Q6DU/qiD4nAl+mse223g2p1FNgvLwamAL5AO6hYOrZdsE9Z
 sPeRRAEnxz+9OsYuLdgovKQv8iWUSjGy2CXwgfVZazrvX/mN+hdw8PAASaAdlXYdV3sNbMwSkZG
 iZNZKz0dPL7Lqsw==
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

Reported-by: Ondrej Valousek <ondrej.valousek@diasemi.com>
Closes: https://bugzilla.redhat.com/show_bug.cgi?id=2136452
Suggested-by: Andreas Gruenbacher <agruenba@redhat.com>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
Changes in v2:
- always set missing ACEs whenever default ACL has any ACEs that are
  explicitly set. This better conforms to how setfacl works.
- drop now-unneeded "empty" boolean
- Link to v1: https://lore.kernel.org/r/20230719-nfsd-acl-v1-1-eb0faf3d2917@kernel.org
---
 fs/nfsd/nfs4acl.c | 32 ++++++++++++++++++++++++++++----
 1 file changed, 28 insertions(+), 4 deletions(-)

diff --git a/fs/nfsd/nfs4acl.c b/fs/nfsd/nfs4acl.c
index 518203821790..b931d4383517 100644
--- a/fs/nfsd/nfs4acl.c
+++ b/fs/nfsd/nfs4acl.c
@@ -441,7 +441,7 @@ struct posix_ace_state_array {
  * calculated so far: */
 
 struct posix_acl_state {
-	int empty;
+	unsigned char valid;
 	struct posix_ace_state owner;
 	struct posix_ace_state group;
 	struct posix_ace_state other;
@@ -457,7 +457,6 @@ init_state(struct posix_acl_state *state, int cnt)
 	int alloc;
 
 	memset(state, 0, sizeof(struct posix_acl_state));
-	state->empty = 1;
 	/*
 	 * In the worst case, each individual acl could be for a distinct
 	 * named user or group, but we don't know which, so we allocate
@@ -500,7 +499,7 @@ posix_state_to_acl(struct posix_acl_state *state, unsigned int flags)
 	 * and effective cases: when there are no inheritable ACEs,
 	 * calls ->set_acl with a NULL ACL structure.
 	 */
-	if (state->empty && (flags & NFS4_ACL_TYPE_DEFAULT))
+	if (!state->valid && (flags & NFS4_ACL_TYPE_DEFAULT))
 		return NULL;
 
 	/*
@@ -622,9 +621,10 @@ static void process_one_v4_ace(struct posix_acl_state *state,
 				struct nfs4_ace *ace)
 {
 	u32 mask = ace->access_mask;
+	short type = ace2type(ace);
 	int i;
 
-	state->empty = 0;
+	state->valid |= type;
 
 	switch (ace2type(ace)) {
 	case ACL_USER_OBJ:
@@ -726,6 +726,30 @@ static int nfs4_acl_nfsv4_to_posix(struct nfs4_acl *acl,
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
+	 * Copy any missing ACEs from the effective set, if any ACEs were
+	 * explicitly set.
+	 */
+	if (default_acl_state.valid) {
+		if (!(default_acl_state.valid & ACL_USER_OBJ))
+			default_acl_state.owner = effective_acl_state.owner;
+		if (!(default_acl_state.valid & ACL_GROUP_OBJ))
+			default_acl_state.group = effective_acl_state.group;
+		if (!(default_acl_state.valid & ACL_OTHER))
+			default_acl_state.other = effective_acl_state.other;
+	}
+
 	*pacl = posix_state_to_acl(&effective_acl_state, flags);
 	if (IS_ERR(*pacl)) {
 		ret = PTR_ERR(*pacl);

---
base-commit: 7bfb36a2ee1d329a501ba4781db4145dc951c798
change-id: 20230719-nfsd-acl-5ab61537e4e6

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>

