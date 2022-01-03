Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC0E84836E0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jan 2022 19:34:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235653AbiACSex (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Jan 2022 13:34:53 -0500
Received: from drummond.us ([74.95.14.229]:40377 "EHLO
        talisker.home.drummond.us" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S235630AbiACSew (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Jan 2022 13:34:52 -0500
X-Greylist: delayed 855 seconds by postgrey-1.27 at vger.kernel.org; Mon, 03 Jan 2022 13:34:52 EST
Received: from talisker.home.drummond.us (localhost [127.0.0.1])
        by talisker.home.drummond.us (8.15.2/8.15.2/Debian-20) with ESMTP id 203IKaKh983549;
        Mon, 3 Jan 2022 10:20:36 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=home.drummond.us;
        s=default; t=1641234036;
        bh=tcvbk+9VbbAZwyAhc2AeyqHOfFE/HG33YA2bGuUxl2o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H85IFCpE7rk1qXyLi3eaoYaNJR1MoGL/vqGeRkPGhH9BwaQmH+6ASvagbGKVUTtOq
         J8FxaTD1KLLDOj0konlyRv5x5se+kqTKCQOOIyp1KFgJRk15Tmt8XvIKsM2VzNShuQ
         wqoc6oz5SbWarhxqj/m5XRmIRB4oy+xGciUkCMXiieWlmWKFlP4/JRLhRN+gBLyP7Q
         35xsO/Nnw0BwCXQ9jGk7sQxrRPkrIUPsmwzFgE9QCraMavcxiS8unaK2YZyM92Gryr
         GxgvW5KAPSlPjKY+ceWlY3fpsIHIIV36rFYl9hvo+VL0JZmfFU/CAvtXaSJKqqg7aT
         ua5nH2t0MxLcQ==
Received: (from walt@localhost)
        by talisker.home.drummond.us (8.15.2/8.15.2/Submit) id 203IKa5I983548;
        Mon, 3 Jan 2022 10:20:36 -0800
From:   Walt Drummond <walt@drummond.us>
Cc:     linux-kernel@vger.kernel.org, Walt Drummond <walt@drummond.us>,
        linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH 5/8] signals: Better support cases where _NSIG_WORDS is greater than 2
Date:   Mon,  3 Jan 2022 10:19:53 -0800
Message-Id: <20220103181956.983342-6-walt@drummond.us>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220103181956.983342-1-walt@drummond.us>
References: <20220103181956.983342-1-walt@drummond.us>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Directly handle the now more common cases where _NSIG_WORDS could be 3
or 4.

Signed-off-by: Walt Drummond <walt@drummond.us>
---
 fs/proc/array.c        |  3 +-
 include/linux/signal.h | 74 +++++++++++++++++++++++++++---------------
 kernel/signal.c        |  5 +++
 3 files changed, 55 insertions(+), 27 deletions(-)

diff --git a/fs/proc/array.c b/fs/proc/array.c
index 49be8c8ef555..f37c03077b58 100644
--- a/fs/proc/array.c
+++ b/fs/proc/array.c
@@ -223,7 +223,8 @@ void render_sigset_t(struct seq_file *m, const char *header,
 
 	seq_puts(m, header);
 
-	i = _NSIG;
+	/* Round up when _NSIG isn't a multiple of 4 */
+	i = (_NSIG + 3) & ~0x03;
 	do {
 		int x = 0;
 
diff --git a/include/linux/signal.h b/include/linux/signal.h
index eaf7991fffee..4084b765a6cc 100644
--- a/include/linux/signal.h
+++ b/include/linux/signal.h
@@ -168,18 +168,22 @@ do {					        \
 static inline int sigequalsets(const sigset_t *set1, const sigset_t *set2)
 {
 	switch (_NSIG_WORDS) {
+	default:
+		return memcmp(set1, set2, sizeof(sigset_t)) == 0;
 	case 4:
 		return	(set1->sig[3] == set2->sig[3]) &&
 			(set1->sig[2] == set2->sig[2]) &&
 			(set1->sig[1] == set2->sig[1]) &&
 			(set1->sig[0] == set2->sig[0]);
+	case 3:
+		return  (set1->sig[2] == set2->sig[2]) &&
+			(set1->sig[1] == set2->sig[1]) &&
+			(set1->sig[0] == set2->sig[0]);
 	case 2:
 		return	(set1->sig[1] == set2->sig[1]) &&
 			(set1->sig[0] == set2->sig[0]);
 	case 1:
 		return	set1->sig[0] == set2->sig[0];
-	default:
-		return memcmp(set1, set2, sizeof(sigset_t)) == 0;
 	}
 	return 0;
 }
@@ -197,27 +201,24 @@ static inline int sigisemptyset(sigset_t *set)
 #define _SIG_SET_BINOP(name, op)					\
 static inline void name(sigset_t *r, const sigset_t *a, const sigset_t *b) \
 {									\
-	unsigned long a0, a1, a2, a3, b0, b1, b2, b3;			\
 	int i;								\
 									\
 	switch (_NSIG_WORDS) {						\
+	default:							\
+		for (i = 0; i < _NSIG_WORDS; i++)			\
+			r->sig[i] = op(a->sig[i], b->sig[i]);		\
+		break;							\
 	case 4:								\
-		a3 = a->sig[3]; a2 = a->sig[2];				\
-		b3 = b->sig[3]; b2 = b->sig[2];				\
-		r->sig[3] = op(a3, b3);					\
-		r->sig[2] = op(a2, b2);					\
+		r->sig[3] = op(a->sig[3], b->sig[3]);			\
+		fallthrough;						\
+	case 3:								\
+		r->sig[2] = op(a->sig[2], b->sig[2]);			\
 		fallthrough;						\
 	case 2:								\
-		a1 = a->sig[1]; b1 = b->sig[1];				\
-		r->sig[1] = op(a1, b1);					\
+		r->sig[1] = op(a->sig[1], b->sig[1]);			\
 		fallthrough;						\
 	case 1:								\
-		a0 = a->sig[0]; b0 = b->sig[0];				\
-		r->sig[0] = op(a0, b0);					\
-		break;							\
-	default:							\
-		for (i = 0; i < _NSIG_WORDS; i++)			\
-			r->sig[i] = op(a->sig[i], b->sig[i]);		\
+		r->sig[0] = op(a->sig[0], b->sig[0]);			\
 		break;							\
 	}								\
 }
@@ -242,17 +243,22 @@ static inline void name(sigset_t *set)					\
 	int i;								\
 									\
 	switch (_NSIG_WORDS) {						\
-	case 4:	set->sig[3] = op(set->sig[3]);				\
-		set->sig[2] = op(set->sig[2]);				\
-		fallthrough;						\
-	case 2:	set->sig[1] = op(set->sig[1]);				\
-		fallthrough;						\
-	case 1:	set->sig[0] = op(set->sig[0]);				\
-		    break;						\
 	default:							\
 		for (i = 0; i < _NSIG_WORDS; i++)			\
 			set->sig[i] = op(set->sig[i]);			\
 		break;							\
+	case 4:								\
+		set->sig[3] = op(set->sig[3]);				\
+		fallthrough;						\
+	case 3:								\
+		set->sig[2] = op(set->sig[2]);				\
+		fallthrough;						\
+	case 2:								\
+		set->sig[1] = op(set->sig[1]);				\
+		fallthrough;						\
+	case 1:								\
+		set->sig[0] = op(set->sig[0]);				\
+		break;							\
 	}								\
 }
 
@@ -268,9 +274,17 @@ static inline void sigemptyset(sigset_t *set)
 	default:
 		memset(set, 0, sizeof(sigset_t));
 		break;
-	case 2: set->sig[1] = 0;
+	case 4:
+		set->sig[3] = 0;
+		fallthrough;
+	case 3:
+		set->sig[2] = 0;
 		fallthrough;
-	case 1:	set->sig[0] = 0;
+	case 2:
+		set->sig[1] = 0;
+		fallthrough;
+	case 1:
+		set->sig[0] = 0;
 		break;
 	}
 }
@@ -281,9 +295,17 @@ static inline void sigfillset(sigset_t *set)
 	default:
 		memset(set, -1, sizeof(sigset_t));
 		break;
-	case 2: set->sig[1] = -1;
+	case 4:
+		set->sig[3] = -1;
 		fallthrough;
-	case 1:	set->sig[0] = -1;
+	case 3:
+		set->sig[2] = -1;
+		fallthrough;
+	case 2:
+		set->sig[1] = -1;
+		fallthrough;
+	case 1:
+		set->sig[0] = -1;
 		break;
 	}
 }
diff --git a/kernel/signal.c b/kernel/signal.c
index 9421f1112b20..9c846a017201 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -143,6 +143,11 @@ static inline bool has_pending_signals(sigset_t *signal, sigset_t *blocked)
 		ready |= signal->sig[0] &~ blocked->sig[0];
 		break;
 
+	case 3: ready  = signal->sig[2] &~ blocked->sig[2];
+		ready |= signal->sig[1] &~ blocked->sig[1];
+		ready |= signal->sig[0] &~ blocked->sig[0];
+		break;
+
 	case 2: ready  = signal->sig[1] &~ blocked->sig[1];
 		ready |= signal->sig[0] &~ blocked->sig[0];
 		break;
-- 
2.30.2

