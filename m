Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 762ED58B560
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Aug 2022 14:24:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231481AbiHFMYL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 6 Aug 2022 08:24:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbiHFMYK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 6 Aug 2022 08:24:10 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 234351054B;
        Sat,  6 Aug 2022 05:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1659788630;
        bh=EmdUhqjuBaZoiK7nIBlB85Ojty7fJP5lc36LTjVWwVI=;
        h=X-UI-Sender-Class:From:To:Subject:Date:In-Reply-To:References;
        b=PPFrNoZ3mW1wYAYBzxqTIHuPp7ljFxHiGSxS6WoYP3mu1RFO4RUsDrm3XmC9Dvs8F
         t86wmDY5iBi+l/Te5FcTUsGhRwdYfsQsqtlE8Kkmf+N7qqpQ9Gi/jyOp9pUzyb5JrE
         +iwLmbo+qNpj5y9IbkbnE1dACSlBXJUabP53vok8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from p100.fritz.box ([92.116.170.46]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MFsZ3-1oCKlN2yp5-00HPpY; Sat, 06
 Aug 2022 14:23:50 +0200
From:   Helge Deller <deller@gmx.de>
To:     linux-s390@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        Josh Triplett <josh@joshtriplett.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 1/3] proc: Add get_task_cmdline_kernel() function
Date:   Sat,  6 Aug 2022 14:23:46 +0200
Message-Id: <20220806122348.82584-2-deller@gmx.de>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220806122348.82584-1-deller@gmx.de>
References: <20220806122348.82584-1-deller@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KkbEYe0kghWlFwQzjNuZb5/phQrAfDs2/UGiW7nK7hjXneYtmzA
 Tcmc4lEn26oFet83nGaNCsUOemp/lO74ocP4iy6dotsrngi6iHJIBhVQCe0Ex75F4MuvMIo
 6wQo7U57hTdwN+EY+AMxpSbEsO2XQI+9BGBdiWoby5I3yP7hu0hEybBTdkkJqLNQ/RUI5B/
 FAQ5+TXjSTjV/7By+RY8g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:sgsA1z+8BhA=:uYgI3h2+qGCqUH7/aNn82K
 F1a2C7EaZPgLQjPqegtkVYLiInLCTUtG8wD3MTLzSPemwz5IVfHZINjg0Ox5Zbe76D831rADw
 +Q9ILY1R/5/s0OVfWJ45cFHAwrSEUOcvtiQhBF0qzQmBetfsJ7NHV3cH3UDKHcZaVKLZ5JruN
 rz65uiAMa8YpAFBatczUd/XrFgtraZrBy1YAMW4O1y8MRcDDsBFufs2e4o/YQUGM8z/mcTqKb
 /FffqifiStutTk0yt4dTLzeGQJkNbhZsaxos/VWHdCg7tjPBV8X4p/kSSehswhkLpLqsJXF5Y
 Qp0lHlUVMGjCOwbDJVmmRRGu2Lh8fiwbsBuujGSw7vrvKtLjpMP+VVXdNxQGpQDuJegM6U4pA
 aP/PswH/PeT1JH1/qBa323PwIgRsfd/+xOOl/ncEp9bwTkkkCkDWczoJxUadZ+qLC+fZM5SZT
 ogA/6/JUY8xqFEHXcuMuyj6XuvirGk5Kg06ZyWXh6qpkMpTCFYDS1TcBp7wn4H5O0X8S3bNfx
 vD8HYjH+79yA4O1RpW+dQmx5/T6EaDO14/1OY2cS1EkefNenwmcD8zik1x7nXIoCSogDbatQ+
 a9NHIwPJKf75GuNk8nwZ5YaR1o9uSXDPVZm2g/9PUd3AU9PHawKYOFVyUueUU70+1WW+bbyRz
 +z2OM2OPMhVAnUIT89YEU5WpHw3OJkyu1Iih9uz3ulQACWMFbtmMDnpq35D6cszBwDyF0HRHG
 x2JmSN5E5JMVX0h4XmSHtcEyfzlBgamABMyxryQsmZx+B4nXM33VngieS2iysPMgRDg+BGpMg
 zok7O6C1WR+0euQABwJCz4dkDqM51hzBvpV0iJGvMtKau0mQNOg8l9zrw6eHrqfd0UfYCeFto
 aE58LeGrWT/HyxbkBl5+nCcjt8O+wFeU5Q/fBRjdQUXmpxXFB2Rn672uDoxTifP/mS6F4pUXq
 5vmVbbs3Kt0UoxGCn5a3LgP0cvfZGA37hG3ZIefnlVRVKPuqeaSwWc6OeMMgmPR2Kgym8rzHg
 y4voZYaAYS9OURChdJsr3/B/qtlS7usEICg5My2dYfFDahdZ1V6RTLpXRxpzv7/RmZaFpB8rP
 ihSIfoKxSxnHFUZyZ9kxtDYWQIROhmUgNbMNtfo7lTWQh9UixCfuapEQQ==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a new function get_task_cmdline_kernel() which reads the command
line of a process into a kernel buffer. This command line can then be
dumped by arch code to give additional debug info via the parameters
with which a faulting process was started.

The new function re-uses the existing code which provides the cmdline
for the procfs. For that the existing functions were modified so that
the buffer page is allocated outside of get_mm_proctitle() and
get_mm_cmdline() and instead provided as parameter.

Signed-off-by: Helge Deller <deller@gmx.de>
=2D--
 fs/proc/base.c          | 68 +++++++++++++++++++++++++++--------------
 include/linux/proc_fs.h |  5 +++
 2 files changed, 50 insertions(+), 23 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index 8dfa36a99c74..4da9a8b3c7d1 100644
=2D-- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -217,20 +217,17 @@ static int proc_root_link(struct dentry *dentry, str=
uct path *path)
  */
 static ssize_t get_mm_proctitle(struct mm_struct *mm, char __user *buf,
 				size_t count, unsigned long pos,
-				unsigned long arg_start)
+				unsigned long arg_start, char *page)
 {
-	char *page;
 	int ret, got;
+	size_t size;

-	if (pos >=3D PAGE_SIZE)
+	size =3D min_t(size_t, PAGE_SIZE, count);
+	if (pos >=3D size)
 		return 0;

-	page =3D (char *)__get_free_page(GFP_KERNEL);
-	if (!page)
-		return -ENOMEM;
-
 	ret =3D 0;
-	got =3D access_remote_vm(mm, arg_start, page, PAGE_SIZE, FOLL_ANON);
+	got =3D access_remote_vm(mm, arg_start, page, size, FOLL_ANON);
 	if (got > 0) {
 		int len =3D strnlen(page, got);

@@ -238,7 +235,9 @@ static ssize_t get_mm_proctitle(struct mm_struct *mm, =
char __user *buf,
 		if (len < got)
 			len++;

-		if (len > pos) {
+		if (!buf)
+			ret =3D len;
+		else if (len > pos) {
 			len -=3D pos;
 			if (len > count)
 				len =3D count;
@@ -248,16 +247,15 @@ static ssize_t get_mm_proctitle(struct mm_struct *mm=
, char __user *buf,
 			ret =3D len;
 		}
 	}
-	free_page((unsigned long)page);
 	return ret;
 }

 static ssize_t get_mm_cmdline(struct mm_struct *mm, char __user *buf,
-			      size_t count, loff_t *ppos)
+			      size_t count, loff_t *ppos, char *page)
 {
 	unsigned long arg_start, arg_end, env_start, env_end;
 	unsigned long pos, len;
-	char *page, c;
+	char c;

 	/* Check if process spawned far enough to have cmdline. */
 	if (!mm->env_end)
@@ -283,7 +281,7 @@ static ssize_t get_mm_cmdline(struct mm_struct *mm, ch=
ar __user *buf,
 	len =3D env_end - arg_start;

 	/* We're not going to care if "*ppos" has high bits set */
-	pos =3D *ppos;
+	pos =3D ppos ? *ppos : 0;
 	if (pos >=3D len)
 		return 0;
 	if (count > len - pos)
@@ -299,7 +297,7 @@ static ssize_t get_mm_cmdline(struct mm_struct *mm, ch=
ar __user *buf,
 	 * pos is 0, and set a flag in the 'struct file'.
 	 */
 	if (access_remote_vm(mm, arg_end-1, &c, 1, FOLL_ANON) =3D=3D 1 && c)
-		return get_mm_proctitle(mm, buf, count, pos, arg_start);
+		return get_mm_proctitle(mm, buf, count, pos, arg_start, page);

 	/*
 	 * For the non-setproctitle() case we limit things strictly
@@ -311,10 +309,6 @@ static ssize_t get_mm_cmdline(struct mm_struct *mm, c=
har __user *buf,
 	if (count > arg_end - pos)
 		count =3D arg_end - pos;

-	page =3D (char *)__get_free_page(GFP_KERNEL);
-	if (!page)
-		return -ENOMEM;
-
 	len =3D 0;
 	while (count) {
 		int got;
@@ -323,7 +317,8 @@ static ssize_t get_mm_cmdline(struct mm_struct *mm, ch=
ar __user *buf,
 		got =3D access_remote_vm(mm, pos, page, size, FOLL_ANON);
 		if (got <=3D 0)
 			break;
-		got -=3D copy_to_user(buf, page, got);
+		if (buf)
+			got -=3D copy_to_user(buf, page, got);
 		if (unlikely(!got)) {
 			if (!len)
 				len =3D -EFAULT;
@@ -335,12 +330,11 @@ static ssize_t get_mm_cmdline(struct mm_struct *mm, =
char __user *buf,
 		count -=3D got;
 	}

-	free_page((unsigned long)page);
 	return len;
 }

 static ssize_t get_task_cmdline(struct task_struct *tsk, char __user *buf=
,
-				size_t count, loff_t *pos)
+				size_t count, loff_t *pos, char *page)
 {
 	struct mm_struct *mm;
 	ssize_t ret;
@@ -349,23 +343,51 @@ static ssize_t get_task_cmdline(struct task_struct *=
tsk, char __user *buf,
 	if (!mm)
 		return 0;

-	ret =3D get_mm_cmdline(mm, buf, count, pos);
+	ret =3D get_mm_cmdline(mm, buf, count, pos, page);
 	mmput(mm);
 	return ret;
 }

+/*
+ * Place up to maxcount chars of the command line of the process into the
+ * cmdline buffer.
+ */
+void get_task_cmdline_kernel(struct task_struct *tsk,
+			char *cmdline, size_t maxcount)
+{
+	int i;
+
+	memset(cmdline, 0, maxcount);
+	get_task_cmdline(tsk, NULL, maxcount - 1, NULL, cmdline);
+
+	/* remove NULs between parameters */
+	for (i =3D 0; i < maxcount - 2; i++) {
+		if (cmdline[i])
+			continue;
+		if (cmdline[i+1] =3D=3D 0)
+			break;
+		cmdline[i] =3D ' ';
+	}
+}
+
 static ssize_t proc_pid_cmdline_read(struct file *file, char __user *buf,
 				     size_t count, loff_t *pos)
 {
 	struct task_struct *tsk;
 	ssize_t ret;
+	char *page;

 	BUG_ON(*pos < 0);

 	tsk =3D get_proc_task(file_inode(file));
 	if (!tsk)
 		return -ESRCH;
-	ret =3D get_task_cmdline(tsk, buf, count, pos);
+	page =3D (char *)__get_free_page(GFP_KERNEL);
+	if (page) {
+		ret =3D get_task_cmdline(tsk, buf, count, pos, page);
+		free_page((unsigned long)page);
+	} else
+		ret =3D -ENOMEM;
 	put_task_struct(tsk);
 	if (ret > 0)
 		*pos +=3D ret;
diff --git a/include/linux/proc_fs.h b/include/linux/proc_fs.h
index 81d6e4ec2294..9a256e86205c 100644
=2D-- a/include/linux/proc_fs.h
+++ b/include/linux/proc_fs.h
@@ -158,6 +158,9 @@ int proc_pid_arch_status(struct seq_file *m, struct pi=
d_namespace *ns,
 			struct pid *pid, struct task_struct *task);
 #endif /* CONFIG_PROC_PID_ARCH_STATUS */

+void get_task_cmdline_kernel(struct task_struct *tsk,
+			char *cmdline, size_t maxcount);
+
 #else /* CONFIG_PROC_FS */

 static inline void proc_root_init(void)
@@ -216,6 +219,8 @@ static inline struct pid *tgid_pidfd_to_pid(const stru=
ct file *file)
 	return ERR_PTR(-EBADF);
 }

+static inline void get_task_cmdline_kernel(struct task_struct *, char *, =
size_t) { }
+
 #endif /* CONFIG_PROC_FS */

 struct net;
=2D-
2.37.1

