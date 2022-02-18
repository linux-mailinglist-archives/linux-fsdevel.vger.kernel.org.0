Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB2E34BBD92
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Feb 2022 17:32:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234356AbiBRQc4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Feb 2022 11:32:56 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231140AbiBRQcz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Feb 2022 11:32:55 -0500
X-Greylist: delayed 1453 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 18 Feb 2022 08:32:38 PST
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEBBD1C65D4
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Feb 2022 08:32:38 -0800 (PST)
Received: from in02.mta.xmission.com ([166.70.13.52]:45600)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nL5ny-00Ec5Y-Ia; Fri, 18 Feb 2022 09:08:22 -0700
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:50354 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nL5np-000aMm-18; Fri, 18 Feb 2022 09:08:22 -0700
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Rik van Riel <riel@surriel.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Chris Mason <clm@fb.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        linux-fsdevel@vger.kernel.org,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>
References: <20220217153620.4607bc28@imladris.surriel.com>
Date:   Fri, 18 Feb 2022 10:08:05 -0600
In-Reply-To: <20220217153620.4607bc28@imladris.surriel.com> (Rik van Riel's
        message of "Thu, 17 Feb 2022 15:36:20 -0500")
Message-ID: <87iltcf996.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1nL5np-000aMm-18;;;mid=<87iltcf996.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19gVp8M02CqpqJfjbQxgIt7XAaL04EJRws=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-DCC: ; 
X-Spam-Combo: *;Rik van Riel <riel@surriel.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 8812 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 11 (0.1%), b_tie_ro: 10 (0.1%), parse: 0.99
        (0.0%), extract_message_metadata: 3.0 (0.0%), get_uri_detail_list:
        0.84 (0.0%), tests_pri_-1000: 3.8 (0.0%), tests_pri_-950: 1.29 (0.0%),
        tests_pri_-900: 1.05 (0.0%), tests_pri_-90: 61 (0.7%), check_bayes: 60
        (0.7%), b_tokenize: 6 (0.1%), b_tok_get_all: 4.9 (0.1%), b_comp_prob:
        1.62 (0.0%), b_tok_touch_all: 45 (0.5%), b_finish: 0.80 (0.0%),
        tests_pri_0: 8701 (98.7%), check_dkim_signature: 1.04 (0.0%),
        check_dkim_adsp: 2.8 (0.0%), poll_dns_idle: 0.70 (0.0%), tests_pri_10:
        4.0 (0.0%), tests_pri_500: 15 (0.2%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH][RFC] ipc,fs: use rcu_work to free struct ipc_namespace
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Maybe I am reading the lifetimes wrong but is there
any chance the code can just do something like the diff below?

AKA have a special version of kern_umount that does the call_rcu?

Looking at rcu_reclaim_tiny I think this use of mnt_rcu is valid.
AKA reusing the rcu_head in the rcu callback.


diff --git a/fs/namespace.c b/fs/namespace.c
index 40b994a29e90..7d7aaef1592e 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -4395,6 +4395,22 @@ void kern_unmount(struct vfsmount *mnt)
 }
 EXPORT_SYMBOL(kern_unmount);
 
+static void rcu_mntput(struct rcu_head *head)
+{
+       struct mount *mnt = container_of(head, struct mount, mnt_rcu);
+       mntput(&mnt->mnt);
+}
+
+void kern_rcu_unmount(struct vfsmount *mnt)
+{
+       /* release long term mount so mount point can be released */
+       if (!IS_ERR_OR_NULL(mnt)) {
+               struct mount *m = real_mount(mnt);
+               m->mnt_ns = NULL;
+               call_rcu(&m->mnt_rcu, rcu_mntput);
+       }
+}
+
 void kern_unmount_array(struct vfsmount *mnt[], unsigned int num)
 {
        unsigned int i;
diff --git a/ipc/mqueue.c b/ipc/mqueue.c
index 5becca9be867..e54742f82e7d 100644
--- a/ipc/mqueue.c
+++ b/ipc/mqueue.c
@@ -1700,7 +1700,7 @@ void mq_clear_sbinfo(struct ipc_namespace *ns)
 
 void mq_put_mnt(struct ipc_namespace *ns)
 {
-       kern_unmount(ns->mq_mnt);
+       kern_rcu_unmount(ns->mq_mnt);
 }
 
 static int __init init_mqueue_fs(void)

Eric
