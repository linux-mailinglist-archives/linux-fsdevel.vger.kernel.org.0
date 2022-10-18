Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2488B602553
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Oct 2022 09:17:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbiJRHRc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Oct 2022 03:17:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbiJRHRa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Oct 2022 03:17:30 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C25C2736
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Oct 2022 00:17:29 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id i6so12971064pli.12
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Oct 2022 00:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+WPhMYfNHJ7IkVsrnLKCMI0knahjH/ILooZWa3gsnak=;
        b=AmW4E1j4T7QfPNnh9U/FRHyDVB+LaUhI1xOg81gtwVTbvpoocoLxgq7zX/jEU20pv5
         Y/9n4N8KVrAzaWYS96wbeS7fj2oIDMGSBJi3M7OL/SXoou2qh49F6dHqxWCWwGTCX1st
         pfWGKfn8pROfh3m0U5u4COYdcn5UjZFQb2oMM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+WPhMYfNHJ7IkVsrnLKCMI0knahjH/ILooZWa3gsnak=;
        b=7iLAG368it/gNSx5c9nXQmQOuOQTibO0ZyaTdHxsEj2SH8W8AAeD4k5CzloPvuK8K0
         X0/B5hfLuZq5D6l2XynEPJT5RqmvMdavVe5GUssuzDOwa5g6DS4jbGNSZFlibfhx5fo0
         xEmQ74A2PK1TVn1cFESNVIgDYe7pAfadYnf4QfYR7dMc7GpwZJMPRH5dYti9YwYaIbMD
         xcCQL1ALq/eI+oAR2auOioafupSrFzxLEKYVytnez/BMTUYBKHpnl/c0OmswTkp2I66O
         AB31ytvlxzONgrkvJC+SugBaQ0AGEAgsM9cJ1ECpJrncneEMKckJFaEG/ASRM+jXe+xP
         Uxdg==
X-Gm-Message-State: ACrzQf3eL0dssH1wPqCL/Kn0wWSMnW+RM8/BoHSMIDfqTgdA/cQviGkt
        JLf2eshTl9OSfn4SSKYL8poihQ==
X-Google-Smtp-Source: AMsMyM7xr6hwP8NO4ur8MkkcpcspVQKhsLOgY6G/7SFFF36Kni+LmOb4oMRL+cv3iCHdxCD2vcC1Gg==
X-Received: by 2002:a17:903:246:b0:179:96b5:1ad2 with SMTP id j6-20020a170903024600b0017996b51ad2mr1689962plh.37.1666077448997;
        Tue, 18 Oct 2022 00:17:28 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 1-20020a620601000000b005626a1c77c8sm8334879pfg.80.2022.10.18.00.17.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 00:17:28 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Eric Biederman <ebiederm@xmission.com>
Cc:     Kees Cook <keescook@chromium.org>, linux-fsdevel@vger.kernel.org,
        Jann Horn <jannh@google.com>,
        Christian Brauner <brauner@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        David Laight <David.Laight@ACULAB.COM>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH] exec: Add comments on check_unsafe_exec() fs counting
Date:   Tue, 18 Oct 2022 00:17:24 -0700
Message-Id: <20221018071537.never.662-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1688; h=from:subject:message-id; bh=2swpYsczlaIuQF3JhkoEYj/apHe5tfn1etEA/2Jg8CE=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjTlMDiVTpJfOh2CK4GfTNinAtSvCBsM52w9sFjjLW slnuGpSJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCY05TAwAKCRCJcvTf3G3AJqwyD/ 40TMoaejoCKGnR0OBHDCsxwwCOSAb+WJZWQgT2n89vfSQ5UK5FFm/rdx7Xyk5nu+g4m5Ov61Q7ob2p 91gck3XKFRrxkCMPOCZhh639pC8lcB/871uLLTU+NFNAfHrlfsyXnyNMG7DS4uDSR+Qo8Vqc21aigo /2EHaVg7aZPSYXpUliPxWtMHzKOdFP9om159xQyZD/9CawmpEtcr03tFl/wzzoMuJYArTLBjpNbn11 D2aubvDJS+eHIIv7cJ59SR7q8FsJaLR8VB/9XcuY+QsVp9hEnVr/f/MwwXw3k/tEH6W/3RVSCJ05pJ LLFvfX4E/pqe9q+Deagysf1pX6gjtv6qH5uSPlZwWoZnyxgfOh2awSeDDNXtQzzDIT+xKjyMk4TG/h aXu5njuWMceTFT1GvOZtHLL4Uhceb23khZvpWaK+J1/bYBXMP++c4hqpxJPwkj6GzPG5e1W7ENG+Az hMae9jAPSuYhCyK09uqcBXS49HkOro7dcZib8IopcbrKcDIa4hdu8SiZP9t42Ipq8Polo36ZqqVoU7 eRCIHsNnWfxO8TNnE/2EuN0EjVGDtWsKXjGMPwx1qNjXruJIdPzCbPUnbMEoLz0VoxKi0Oaln2m2Ne gyaK4NFHYR3MjftTXWC08z6eK3Y/CJcKuhnnl38a0dMpPIaSRfplM3wp5jbQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add some comments about what the fs counting is doing in
check_unsafe_exec() and how it relates to the call graph.
Specifically, we can't force an unshare of the fs because
of at least Chrome:
https://lore.kernel.org/lkml/86CE201B-5632-4BB7-BCF6-7CB2C2895409@chromium.org/

Cc: Eric Biederman <ebiederm@xmission.com>
Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/exec.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/fs/exec.c b/fs/exec.c
index 902bce45b116..01659c2ac7d8 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1571,6 +1571,12 @@ static void check_unsafe_exec(struct linux_binprm *bprm)
 	if (task_no_new_privs(current))
 		bprm->unsafe |= LSM_UNSAFE_NO_NEW_PRIVS;
 
+	/*
+	 * If another task is sharing our fs, we cannot safely
+	 * suid exec because the differently privileged task
+	 * will be able to manipulate the current directory, etc.
+	 * It would be nice to force an unshare instead...
+	 */
 	t = p;
 	n_fs = 1;
 	spin_lock(&p->fs->lock);
@@ -1752,6 +1758,7 @@ static int search_binary_handler(struct linux_binprm *bprm)
 	return retval;
 }
 
+/* binfmt handlers will call back into begin_new_exec() on success. */
 static int exec_binprm(struct linux_binprm *bprm)
 {
 	pid_t old_pid, old_vpid;
@@ -1810,6 +1817,11 @@ static int bprm_execve(struct linux_binprm *bprm,
 	if (retval)
 		return retval;
 
+	/*
+	 * Check for unsafe execution states before exec_binprm(), which
+	 * will call back into begin_new_exec(), into bprm_creds_from_file(),
+	 * where setuid-ness is evaluated.
+	 */
 	check_unsafe_exec(bprm);
 	current->in_execve = 1;
 
-- 
2.34.1

