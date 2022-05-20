Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C78652E7CE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 May 2022 10:39:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347343AbiETIjc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 May 2022 04:39:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344602AbiETIjZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 May 2022 04:39:25 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 146F7AFAED;
        Fri, 20 May 2022 01:39:19 -0700 (PDT)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220520083916epoutp023cb1a42d725b95d6d8f1594f01295d96~ww3GiYS5L1883218832epoutp02L;
        Fri, 20 May 2022 08:39:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220520083916epoutp023cb1a42d725b95d6d8f1594f01295d96~ww3GiYS5L1883218832epoutp02L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1653035956;
        bh=UsfrS4UvuS4dFM05SqF8Ta7tbBY/QrlkptYTWqQNH+E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aia/QyHkPpm/zR9tj4Cj7Hno19svunmYHyHwsInquziQDKY6IlXghgdpNSmRLJkwO
         rMMgMNRRTwdODovo4wXmgmRKS2FfG2tsdIrmOBUT4Rusv/VF9vkaCQC3zAi4lJgly2
         CJZrPhtTbfKzpzk8glBclSgx019w9KpRKn0+ZccE=
Received: from epsmges5p3new.samsung.com (unknown [182.195.42.75]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20220520083915epcas5p4ec28bb7c4b401490d717d8b028e47e93~ww3FwITUq1733217332epcas5p44;
        Fri, 20 May 2022 08:39:15 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        5B.93.09762.3B357826; Fri, 20 May 2022 17:39:15 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20220520083805epcas5p40642f5a7f9844c61792cd3ac41ac01d3~ww2E389Eb1223812238epcas5p4E;
        Fri, 20 May 2022 08:38:05 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220520083805epsmtrp14fa161785f4b8b8d2ec9823b3eae2ad9~ww2E2p3KN0239102391epsmtrp1b;
        Fri, 20 May 2022 08:38:05 +0000 (GMT)
X-AuditID: b6c32a4b-1fdff70000002622-65-628753b319ca
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        25.08.08924.D6357826; Fri, 20 May 2022 17:38:05 +0900 (KST)
Received: from localhost.localdomain (unknown [107.109.224.44]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220520083757epsmtip233116cea119605d9acfdc1abbb98de9a~ww19d5gaj3055430554epsmtip28;
        Fri, 20 May 2022 08:37:57 +0000 (GMT)
From:   Maninder Singh <maninder1.s@samsung.com>
To:     keescook@chromium.org, pmladek@suse.com, bcain@quicinc.com,
        mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com, satishkh@cisco.com,
        sebaddel@cisco.com, kartilak@cisco.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, mcgrof@kernel.org,
        jason.wessel@windriver.com, daniel.thompson@linaro.org,
        dianders@chromium.org, naveen.n.rao@linux.ibm.com,
        anil.s.keshavamurthy@intel.com, davem@davemloft.net,
        mhiramat@kernel.org, peterz@infradead.org, mingo@redhat.com,
        will@kernel.org, longman@redhat.com, boqun.feng@gmail.com,
        rostedt@goodmis.org, senozhatsky@chromium.org,
        andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk,
        akpm@linux-foundation.org, arnd@arndb.de
Cc:     linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-modules@vger.kernel.org,
        kgdb-bugreport@lists.sourceforge.net, v.narang@samsung.com,
        onkarnath.1@samsung.com, Maninder Singh <maninder1.s@samsung.com>
Subject: [PATCH 5/5] kallsyms: remove unsed API lookup_symbol_attrs
Date:   Fri, 20 May 2022 14:07:01 +0530
Message-Id: <20220520083701.2610975-6-maninder1.s@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220520083701.2610975-1-maninder1.s@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01TfUxTVxzNfX0fBVPyBBfvIBsbC05RYc4577IJyzTL0w3nwjYzNwdFX5BI
        kbV2sI/MCgUHiGuQD2lLsZAhFgaUryDfFMdnBxaRgUAEQaHAoMigIgFW+kbmf+f8zvndc89N
        Lp/nnEi58kPDz7PicGGYB+mIVzTt2L67NOBS8BulPRTSd5hJpC4qIFFSdDqGqicGcLSS3Eyh
        kWo5jizRsTxUUHYRQ6MrBhIZp4copO6yCX/mNpLojnKRQFMaHUCjzWUYyu6rwFB/vgQZE0VI
        rjcRqKa2DUez8koS3a1Sk0imshJIoY3hocS/bLNRpYZEy9ZVAnU0t+KoKSsORzdaVjHUp3gE
        UM6Nbai74TqGymS25PyUFQrlXbYQqOB2DoVakhowtDa6QKC6X4YxZPxNBVDiswyAqvXZJMot
        +p1ChrZMgOSD+973ZpafJQNGJTPhTMqynmDKbvZjTLZZhjO3lEMUI6+7TzGleV5MTo0ZYy5P
        ywmmRBdPMoO9NSTTem0ZZxTZDYDRtH3KdF3TgmOuJxzfO82GhX7Hin18gxzPDOU9JiLGPaOm
        RzpxGYh1TwAOfEi/Be8Wl5IJwJHvTFcDqJi08DjyBEDz03qKI/MAli52gI2V9OpOjBOqALTW
        rgKO/ANg/GUFb91F0t5QV1WDr+MttJ6Ei0b/dROPHsJg4YSFWhdc6INwYCbevoDTnnCksNuO
        BbQv1K5qcC7OHWZ0W+1+B9oP9s0M4pxnM2zLGLNjns0TU66yXxzStY5wbGncVolvI4fgROPL
        3DkucLKljOKwKzT/GkdxlkhYrrjArcoBrFenkJzHD46ZtMS6h0fvgEVVPtz4JZjaXohxsU4w
        aXkM4+YCWKnZwJ5Q3l9McNgNzs/N/VeFgU2djTj3WMkAmiavkgrwivK5Osrn6ij/j74OeDrw
        IhshEYWwkn0Re8PZSG+JUCSRhod4nzonKgH2/+L1USV4OGzxNgCMDwwA8nkeWwRAJA92FpwW
        fv8DKz4XKJaGsRIDcOPjHlsF9NrFYGc6RHiePcuyEax4Q8X4Dq4y7M5tn9dFPytNBVHDn3TB
        qMBevfBI1/Fdkq+7s75ofDN2oTygZ2vl4R9Ptn9jPLLywI/EpVfLye3tj9QTA/wpjXXSY6L4
        aeCFPzpmnVJ3BmTHfGbOP/ll5M1Dqlu7Kw86bwu5EuHV66t7OzowxCUt98q8dPaA1XQ0vmTm
        SXvOzIGizHH3o0Pl8dITToJ7cWLfhb87EvZaej4//m3Fx24qg1vAqzXvXprXhavPDgZ+eCp1
        oTXNa080HZWeZk7K72kX7pfOkgmblpaC/EFmkPaBZX9oKlHUdvjhY113fWdMLFp7jR69N/fB
        rvvvuA9vOtYj1XZ+pczaOVUX+oLTTwEi44K/OmdzrQcuOSPc48UTS4T/ApmcuBOeBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0xTdxiH/Z+ec3rJGGeF4BksMqto0gHOIdub6JiJW3JiFhnRZAynrMwT
        0NHKWnGic6lYueNYwwK0FbmEi6VO65ChdIyVpbYD5bJFKLSZlZVSIIWYOCKFulK2xG9Pfs+T
        vF9eHkfYS0TzjstOsXKZJFdECvCuflFsgvRgcdab11doMA54SdDdMJBQWViDQc/MJA6ragsX
        XD0qHBYLL3HA0HkBg6lVMwmD804u6IaC4n7rryQMa/4hYK5ej2DK0olB03gXBvYOBQyWS0Fl
        HCHA9LMNhwVVNwl/3NWRoNQuEVDVeJED5WPBbUpTT4J/KUDAgMWKQ//VIhza7gUwGK9yI2hu
        2wajfQ0YdCqDlzuqV7nQXrFIgOG3Zi7cq+zD4PnUUwJ6Sx5hMNiiRVC+XIegx9hEQuuN61ww
        264gUDmS9yYy/mU1YrTKEZyp9hsJpvOaHWOavEqcuaNxchlV7wSX+bFdzDSbvBhTMa8imFv6
        UpJxPDSRjLXWjzNVTX2IqbelMUO1jeij6AzBnmNs7vHTrHxHymeCHGf7NJHniTsz73qAK9Gl
        2DLE59HULrqm5wFWhgQ8IdWN6OWGGXJdxNDPAgv4OkfQ1wIe7nr0BNG6b2uINUFSibT+rglf
        E5GUk6Sniy+HKg7lweibLitnrYqg9tGTvtIQ41Qc7fphNMRhVArdGKj/70QsXTe6xF1jPvUe
        Pe5zhHZhsLFUN5Lr/Su0re7v0M4J9hdvazlViNK8oDQvqAaE6dGrbJ5Cmi1V7Mx7S8Z+laiQ
        SBX5suzEz09Kb6HQi4nF3cikX0w0I4yHzIjmcUSRYUiqyhKGHZMUnGXlJzPl+bmswoxieLho
        Y9hwmS1TSGVLTrFfsGweK//fYjx+tBI7YTQmGeJnde6MidSi0iTVmQGXzukLXw0Pm9k6mbDP
        942sfLfk7a9lfv/RykPuHe5DHanTFbrph0eYp+fTV9Rfnk+98rtNkHM6OS7jWUG/Y/cd/i+F
        aV6zs9k6S+79fv8ndm3xhN7kOMHJlFrISiYeb4lq5be0PUpfeGfTOZ5hxZMp9tcMHNjy6eEN
        +qRsdUTlk4Vau2BMNnw7P6Fkv3nznrqX5g98cLREXdKtvhp12X/zp8dpvr9Syy6oLTHuubMH
        7wtmz/25a+z5+60bVWmvf7jJLrNu8bhFrqjtkckb3hgZSv+uaC78tcMfCzQJj1MiJrcuZhkL
        4t3e5SPvGl/uUsVtFuGKHMlOMUeukPwLrdBORtEDAAA=
X-CMS-MailID: 20220520083805epcas5p40642f5a7f9844c61792cd3ac41ac01d3
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CMS-RootMailID: 20220520083805epcas5p40642f5a7f9844c61792cd3ac41ac01d3
References: <20220520083701.2610975-1-maninder1.s@samsung.com>
        <CGME20220520083805epcas5p40642f5a7f9844c61792cd3ac41ac01d3@epcas5p4.samsung.com>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

with commit '7878c231dae0 ("slab: remove /proc/slab_allocators")'
lookup_symbol_attrs usage is removed.

Thus removing redundant API.

Signed-off-by: Maninder Singh <maninder1.s@samsung.com>
---
 include/linux/kallsyms.h |  6 ------
 include/linux/module.h   |  6 ------
 kernel/kallsyms.c        | 28 ----------------------------
 kernel/module/kallsyms.c | 28 ----------------------------
 4 files changed, 68 deletions(-)

diff --git a/include/linux/kallsyms.h b/include/linux/kallsyms.h
index 8fe535fd848a..b78e9d942a77 100644
--- a/include/linux/kallsyms.h
+++ b/include/linux/kallsyms.h
@@ -91,7 +91,6 @@ extern int sprint_backtrace(char *buffer, size_t size, unsigned long address);
 extern int sprint_backtrace_build_id(char *buffer, size_t size, unsigned long address);
 
 int lookup_symbol_name(unsigned long addr, char *symname, size_t size);
-int lookup_symbol_attrs(unsigned long addr, unsigned long *size, unsigned long *offset, char *modname, char *name);
 
 /* How and when do we show kallsyms values? */
 extern bool kallsyms_show_value(const struct cred *cred);
@@ -153,11 +152,6 @@ static inline int lookup_symbol_name(unsigned long addr, char *symname, size_t s
 	return -ERANGE;
 }
 
-static inline int lookup_symbol_attrs(unsigned long addr, unsigned long *size, unsigned long *offset, char *modname, char *name)
-{
-	return -ERANGE;
-}
-
 static inline bool kallsyms_show_value(const struct cred *cred)
 {
 	return false;
diff --git a/include/linux/module.h b/include/linux/module.h
index 9b91209d615f..4c5f8f99a252 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -658,7 +658,6 @@ const char *module_address_lookup(unsigned long addr,
 			    char **modname, const unsigned char **modbuildid,
 			    char *namebuf, size_t buf_size);
 int lookup_module_symbol_name(unsigned long addr, char *symname, size_t size);
-int lookup_module_symbol_attrs(unsigned long addr, unsigned long *size, unsigned long *offset, char *modname, char *name);
 
 int register_module_notifier(struct notifier_block *nb);
 int unregister_module_notifier(struct notifier_block *nb);
@@ -766,11 +765,6 @@ static inline int lookup_module_symbol_name(unsigned long addr, char *symname, s
 	return -ERANGE;
 }
 
-static inline int lookup_module_symbol_attrs(unsigned long addr, unsigned long *size, unsigned long *offset, char *modname, char *name)
-{
-	return -ERANGE;
-}
-
 static inline int module_get_kallsym(unsigned int symnum, unsigned long *value,
 					char *type, char *name,
 					char *module_name, int *exported)
diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
index d6efce28505d..96ad59b5b2fd 100644
--- a/kernel/kallsyms.c
+++ b/kernel/kallsyms.c
@@ -430,34 +430,6 @@ int lookup_symbol_name(unsigned long addr, char *symname, size_t size)
 	return 0;
 }
 
-int lookup_symbol_attrs(unsigned long addr, unsigned long *size,
-			unsigned long *offset, char *modname, char *name)
-{
-	int res;
-
-	name[0] = '\0';
-	name[KSYM_NAME_LEN - 1] = '\0';
-
-	if (is_ksym_addr(addr)) {
-		unsigned long pos;
-
-		pos = get_symbol_pos(addr, size, offset);
-		/* Grab name */
-		kallsyms_expand_symbol(get_symbol_offset(pos),
-				       name, KSYM_NAME_LEN);
-		modname[0] = '\0';
-		goto found;
-	}
-	/* See if it's in a module. */
-	res = lookup_module_symbol_attrs(addr, size, offset, modname, name);
-	if (res)
-		return res;
-
-found:
-	cleanup_symbol_name(name);
-	return 0;
-}
-
 /* Look up a kernel symbol and return it in a text buffer. */
 static int __sprint_symbol(char *buffer, size_t buf_size, unsigned long address,
 			   int symbol_offset, int add_offset, int add_buildid)
diff --git a/kernel/module/kallsyms.c b/kernel/module/kallsyms.c
index c982860405c6..e6f16c62a888 100644
--- a/kernel/module/kallsyms.c
+++ b/kernel/module/kallsyms.c
@@ -375,34 +375,6 @@ int lookup_module_symbol_name(unsigned long addr, char *symname, size_t size)
 	return -ERANGE;
 }
 
-int lookup_module_symbol_attrs(unsigned long addr, unsigned long *size,
-			       unsigned long *offset, char *modname, char *name)
-{
-	struct module *mod;
-
-	preempt_disable();
-	list_for_each_entry_rcu(mod, &modules, list) {
-		if (mod->state == MODULE_STATE_UNFORMED)
-			continue;
-		if (within_module(addr, mod)) {
-			const char *sym;
-
-			sym = find_kallsyms_symbol(mod, addr, size, offset);
-			if (!sym)
-				goto out;
-			if (modname)
-				strscpy(modname, mod->name, MODULE_NAME_LEN);
-			if (name)
-				strscpy(name, sym, KSYM_NAME_LEN);
-			preempt_enable();
-			return 0;
-		}
-	}
-out:
-	preempt_enable();
-	return -ERANGE;
-}
-
 int module_get_kallsym(unsigned int symnum, unsigned long *value, char *type,
 		       char *name, char *module_name, int *exported)
 {
-- 
2.17.1

