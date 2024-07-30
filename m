Return-Path: <linux-fsdevel+bounces-24594-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4234D940F04
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2024 12:26:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F222A2839F8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2024 10:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C511198858;
	Tue, 30 Jul 2024 10:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="NsxVSu12";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uGBOL5ZI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09403197A91;
	Tue, 30 Jul 2024 10:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722335158; cv=none; b=QnjqFGeJHa26+/M7TP6PwQ6ij/YJN9IW/xmeQMhKvYMJbr64ANRGc1is9DfEBhxpLD1pq25boyJtH5V1gHA2SDy6/aEvpGkdojaGU2eJUMKVKTCHW4il9N4iZaiCB8qGNNS8lGoFYLFFiXYLVT+0AjhilcENyATcafrL+sAFCYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722335158; c=relaxed/simple;
	bh=lsUauNdqqcjFMUOwmtWcaFnEWgE4LZAVlR9C4pPEIuY=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=JXIsqcJfugoJa50AV6c3FlneRb0aCO2Vgkhj0QRC8eHybCmO0UGY0nA0OuDJKbKEcDVaVqJZBdWhzc/vboJ/TpvAH1NZMHT/lDx8K8wYCCtEpPlIr681BmD0iEd6OkPm4ZSdltjFlnYLOZVyA1ZCjItfRapaUVJxUQcC9A4kkAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=NsxVSu12; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uGBOL5ZI; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id 038C613807C6;
	Tue, 30 Jul 2024 06:25:54 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute4.internal (MEProxy); Tue, 30 Jul 2024 06:25:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1722335153;
	 x=1722421553; bh=oT9XhROxtHoG+7NkQnEhnEe3uof2BS2XSiBJG3DkfAE=; b=
	NsxVSu12TMWQRjBUxUry6bTQNN9Jwc2HCUnD4svtyW5TflgQZVZ0YWdaVb5B2KvS
	emEyibUQXNr+6OIe9vGeGwFaJQqVJJKmCIP9v6dacLd349LUhXENV9rEmYE3x7VT
	8t0rU/JSYFJhDkfM50fJGghkQO3Fmw8/NKz1VOpUPUhumtc6BQ6Y0pt2HxpihQWQ
	EnY/rkEcDiDvr9R34AftwcWmDXmubI1qM79lylfkPBIX369dfO5vXkxec5BkyQX1
	kNI9+I7k+bR0aXjPG69Mak5VLe0y71+JGAmsQ1Bw6SYfzDzg3KkUN+BXHKnBx4JR
	XLqq2k9ymWveyrUZiOICrQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1722335153; x=
	1722421553; bh=oT9XhROxtHoG+7NkQnEhnEe3uof2BS2XSiBJG3DkfAE=; b=u
	GBOL5ZIwiGH+5IaZ6l8zOVjwX+agBc1oY038xqiKO/DilD4qxQfIUag6TgztYCqD
	4w6xwRmNIa++3IXXcqYgDxdlMWNHt8pUk+/lUxvgO+S51ysXm5B6gqUkYjuL18Qd
	FzVi7QR9hobkAjlxyJLbt52ScVnqboot92qhOcfWp4MpRJFdk66GFclUpwxP1BKI
	mtcb6Dgv6P658BjiTlYKQuuuSSAlHzExvlVSPEfOVYjN598LIh3RXKlbxnNu5zmP
	hWgksP7lFbFRK3zUpkw4Hs/C23tT+clDg3zdtMAsVBgDP8V1h7trhWRqueK5v87J
	Vgh+o9YZkCRvrlREcXxAQ==
X-ME-Sender: <xms:sb-oZj_vjQkTW931k5PM_eRFJDxP4E3zzEx-wtIjNjr6E_xXEp2LZg>
    <xme:sb-oZvuTaw6oJQjE4i-uaVVRUPGFzMPsh2VRMvxYasdzGXKmmSQ9EhMog4Y-Fy5Gj
    1FRJAj6q-8QMoAPYIE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrjeeggddvkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpefhtdfhvddtfeehudekteeggffghfejgeegteefgffgvedugeduveelvdekhfdv
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggvpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:sb-oZhDchddcaEJQnsdR0vSOtYf3unSD5Fb86jehkLHqY68olWy94A>
    <xmx:sb-oZvd-WAvM0SumV7dBSoQOP01v-SXEtpgyrQzFWcemjdgF2qO9Mw>
    <xmx:sb-oZoO9t9AQFI_Og0tl6kNseiPRBZelL0yA3K9Cb-tDbNIivcxUHQ>
    <xmx:sb-oZhn_KcIUPTuO3Sq1zWEMlSNn_Cp_QOXxgNwPLcG1VBX-iXYTTA>
    <xmx:sb-oZvcSnqDydXqk-dmPQhVMsnJinZb2uRDS6GxqTwU_1tNLm3hlSeNK>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id E1642B6008D; Tue, 30 Jul 2024 06:25:52 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 30 Jul 2024 12:25:31 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 zhangjiao2 <zhangjiao2@cmss.chinamobile.com>
Cc: linux-kernel@vger.kernel.org, trivial@kernel.org,
 linux-fsdevel@vger.kernel.org, "Christoph Hellwig" <hch@infradead.org>,
 "Hans de Goede" <hdegoede@redhat.com>, "David Howells" <dhowells@redhat.com>
Message-Id: <fa989a00-4b64-4cbe-9e21-d7fc0aadd9da@app.fastmail.com>
In-Reply-To: <2024073029-zippy-bats-ca30@gregkh>
References: <2024073042-observer-overflow-cd04@gregkh>
 <20240730083158.3583-1-zhangjiao2@cmss.chinamobile.com>
 <2024073029-zippy-bats-ca30@gregkh>
Subject: Re: [PATCH v2] char: misc: add missing #ifdef CONFIG_PROC_FS
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Jul 30, 2024, at 11:11, Greg KH wrote:
> On Tue, Jul 30, 2024 at 04:31:58PM +0800, zhangjiao2 wrote:
>> From: Zhang Jiao <zhangjiao2@cmss.chinamobile.com>
>> 
>> Since misc_seq_ops is defined under CONFIG_PROC_FS in this file,
>> it also need under CONFIG_PROC_FS when use. 
>> 
>> >Again, why is a #ifdef ok in this .c file?  What changed to suddenly
>> >require this?
>> There is another #ifdef in this file, in there "misc_seq_ops" is defined.
>> If CONFIG_PROC_FS is not defined, proc_create_seq is using an 
>> undefined variable "misc_seq_ops", this may cause compile error.
>> 
>
> Why is this in the changelog text?
>
> And what changed to suddenly require this proposed patch?  What commit
> id does it fix?

I suspect this happened with either out-of-tree patches to
clean up include/linux/proc_fs.h, or from a script that
misinterprets how the procfs interfaces work.

To be fair, the way we handle these interfaces makes no sense,
since proc_create_seq() uses an macro stub that requires the
'proc_ops' to be in an #ifdef block for CONFIG_PROC_FS=n, but
proc_create_seq() is an inline function that requires the
corresponding 'seq_ops' to *not* use an #ifdef.

I actually have a patch to address this by making all
the stubs use inline functions and remove a lot of the
#ifdef checks, see below. Adding a few people to Cc
that last touched those declarations.

    Arnd

 arch/powerpc/kernel/eeh.c                 |  2 -
 arch/powerpc/platforms/cell/spufs/sched.c |  2 -
 arch/x86/kernel/apm_32.c                  |  2 -
 drivers/char/misc.c                       |  2 -
 drivers/macintosh/via-pmu.c               |  3 --
 drivers/mtd/mtdcore.c                     |  3 --
 drivers/net/hamradio/scc.c                |  4 --
 drivers/net/hamradio/yam.c                |  3 --
 drivers/net/ppp/pppoe.c                   |  2 -
 drivers/parisc/sba_iommu.c                |  2 -
 fs/netfs/main.c                           |  4 ++
 include/linux/proc_fs.h                   | 63 +++++++++++++++++++++++++------
 net/ax25/af_ax25.c                        |  3 --
 net/ipv4/arp.c                            |  2 -
 net/l2tp/l2tp_ppp.c                       |  3 --
 net/netrom/af_netrom.c                    |  3 --
 net/rose/af_rose.c                        |  2 -
 17 files changed, 55 insertions(+), 50 deletions(-)

diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
index d03f17987fca..434f0e931bf6 100644
--- a/arch/powerpc/kernel/eeh.c
+++ b/arch/powerpc/kernel/eeh.c
@@ -1549,7 +1549,6 @@ int eeh_pe_inject_err(struct eeh_pe *pe, int type, int func,
 }
 EXPORT_SYMBOL_GPL(eeh_pe_inject_err);
 
-#ifdef CONFIG_PROC_FS
 static int proc_eeh_show(struct seq_file *m, void *v)
 {
 	if (!eeh_enabled()) {
@@ -1576,7 +1575,6 @@ static int proc_eeh_show(struct seq_file *m, void *v)
 
 	return 0;
 }
-#endif /* CONFIG_PROC_FS */
 
 #ifdef CONFIG_DEBUG_FS
 
diff --git a/arch/powerpc/platforms/cell/spufs/sched.c b/arch/powerpc/platforms/cell/spufs/sched.c
index 610ca8570682..13334436529c 100644
--- a/arch/powerpc/platforms/cell/spufs/sched.c
+++ b/arch/powerpc/platforms/cell/spufs/sched.c
@@ -1052,7 +1052,6 @@ void spuctx_switch_state(struct spu_context *ctx,
 	}
 }
 
-#ifdef CONFIG_PROC_FS
 static int show_spu_loadavg(struct seq_file *s, void *private)
 {
 	int a, b, c;
@@ -1075,7 +1074,6 @@ static int show_spu_loadavg(struct seq_file *s, void *private)
 		idr_get_cursor(&task_active_pid_ns(current)->idr) - 1);
 	return 0;
 }
-#endif
 
 int __init spu_sched_init(void)
 {
diff --git a/arch/x86/kernel/apm_32.c b/arch/x86/kernel/apm_32.c
index b37ab1095707..d6cb01bcfe79 100644
--- a/arch/x86/kernel/apm_32.c
+++ b/arch/x86/kernel/apm_32.c
@@ -1603,7 +1603,6 @@ static int do_open(struct inode *inode, struct file *filp)
 	return 0;
 }
 
-#ifdef CONFIG_PROC_FS
 static int proc_apm_show(struct seq_file *m, void *v)
 {
 	unsigned short	bx;
@@ -1683,7 +1682,6 @@ static int proc_apm_show(struct seq_file *m, void *v)
 		   units);
 	return 0;
 }
-#endif
 
 static int apm(void *unused)
 {
diff --git a/drivers/char/misc.c b/drivers/char/misc.c
index 541edc26ec89..ded2050eb0f8 100644
--- a/drivers/char/misc.c
+++ b/drivers/char/misc.c
@@ -85,7 +85,6 @@ static void misc_minor_free(int minor)
 		ida_free(&misc_minors_ida, minor);
 }
 
-#ifdef CONFIG_PROC_FS
 static void *misc_seq_start(struct seq_file *seq, loff_t *pos)
 {
 	mutex_lock(&misc_mtx);
@@ -117,7 +116,6 @@ static const struct seq_operations misc_seq_ops = {
 	.stop  = misc_seq_stop,
 	.show  = misc_seq_show,
 };
-#endif
 
 static int misc_open(struct inode *inode, struct file *file)
 {
diff --git a/drivers/macintosh/via-pmu.c b/drivers/macintosh/via-pmu.c
index 9d5703b60937..96574fce5de6 100644
--- a/drivers/macintosh/via-pmu.c
+++ b/drivers/macintosh/via-pmu.c
@@ -203,11 +203,9 @@ static int init_pmu(void);
 static void pmu_start(void);
 static irqreturn_t via_pmu_interrupt(int irq, void *arg);
 static irqreturn_t gpio1_interrupt(int irq, void *arg);
-#ifdef CONFIG_PROC_FS
 static int pmu_info_proc_show(struct seq_file *m, void *v);
 static int pmu_irqstats_proc_show(struct seq_file *m, void *v);
 static int pmu_battery_proc_show(struct seq_file *m, void *v);
-#endif
 static void pmu_pass_intr(unsigned char *data, int len);
 static const struct proc_ops pmu_options_proc_ops;
 
@@ -847,7 +845,6 @@ query_battery_state(void)
 			2, PMU_SMART_BATTERY_STATE, pmu_cur_battery+1);
 }
 
-#ifdef CONFIG_PROC_FS
 static int pmu_info_proc_show(struct seq_file *m, void *v)
 {
 	seq_printf(m, "PMU driver version     : %d\n", PMU_DRIVER_VERSION);
diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
index 70df6d8b6017..862938168bc5 100644
--- a/drivers/mtd/mtdcore.c
+++ b/drivers/mtd/mtdcore.c
@@ -2468,8 +2468,6 @@ void *mtd_kmalloc_up_to(const struct mtd_info *mtd, size_t *size)
 }
 EXPORT_SYMBOL_GPL(mtd_kmalloc_up_to);
 
-#ifdef CONFIG_PROC_FS
-
 /*====================================================================*/
 /* Support for /proc/mtd */
 
@@ -2487,7 +2485,6 @@ static int mtd_proc_show(struct seq_file *m, void *v)
 	mutex_unlock(&mtd_table_mutex);
 	return 0;
 }
-#endif /* CONFIG_PROC_FS */
 
 /*====================================================================*/
 /* Init code */
diff --git a/drivers/net/hamradio/scc.c b/drivers/net/hamradio/scc.c
index a9184a78650b..046cb993058f 100644
--- a/drivers/net/hamradio/scc.c
+++ b/drivers/net/hamradio/scc.c
@@ -1972,9 +1972,6 @@ static struct net_device_stats *scc_net_get_stats(struct net_device *dev)
 /* ******************************************************************** */
 /* *		dump statistics to /proc/net/z8530drv		      * */
 /* ******************************************************************** */
-
-#ifdef CONFIG_PROC_FS
-
 static inline struct scc_channel *scc_net_seq_idx(loff_t pos)
 {
 	int k;
@@ -2087,7 +2084,6 @@ static const struct seq_operations scc_net_seq_ops = {
 	.stop   = scc_net_seq_stop,
 	.show   = scc_net_seq_show,
 };
-#endif /* CONFIG_PROC_FS */
 
  
 /* ******************************************************************** */
diff --git a/drivers/net/hamradio/yam.c b/drivers/net/hamradio/yam.c
index 2ed2f836f09a..f0b3c02d0f90 100644
--- a/drivers/net/hamradio/yam.c
+++ b/drivers/net/hamradio/yam.c
@@ -776,8 +776,6 @@ static irqreturn_t yam_interrupt(int irq, void *dev_id)
 	return IRQ_RETVAL(handled);
 }
 
-#ifdef CONFIG_PROC_FS
-
 static void *yam_seq_start(struct seq_file *seq, loff_t *pos)
 {
 	return (*pos < NR_PORTS) ? yam_devs[*pos] : NULL;
@@ -826,7 +824,6 @@ static const struct seq_operations yam_seqops = {
 	.stop = yam_seq_stop,
 	.show = yam_seq_show,
 };
-#endif
 
 
 /* --------------------------------------------------------------------- */
diff --git a/drivers/net/ppp/pppoe.c b/drivers/net/ppp/pppoe.c
index 2ea4f4890d23..0a3822e98f65 100644
--- a/drivers/net/ppp/pppoe.c
+++ b/drivers/net/ppp/pppoe.c
@@ -1025,7 +1025,6 @@ static int pppoe_recvmsg(struct socket *sock, struct msghdr *m,
 	return error;
 }
 
-#ifdef CONFIG_PROC_FS
 static int pppoe_seq_show(struct seq_file *seq, void *v)
 {
 	struct pppox_sock *po;
@@ -1114,7 +1113,6 @@ static const struct seq_operations pppoe_seq_ops = {
 	.stop		= pppoe_seq_stop,
 	.show		= pppoe_seq_show,
 };
-#endif /* CONFIG_PROC_FS */
 
 static const struct proto_ops pppoe_ops = {
 	.family		= AF_PPPOX,
diff --git a/drivers/parisc/sba_iommu.c b/drivers/parisc/sba_iommu.c
index fc3863c09f83..594c582a8aca 100644
--- a/drivers/parisc/sba_iommu.c
+++ b/drivers/parisc/sba_iommu.c
@@ -1783,7 +1783,6 @@ sba_common_init(struct sba_device *sba_dev)
 #endif
 }
 
-#ifdef CONFIG_PROC_FS
 static int sba_proc_info(struct seq_file *m, void *p)
 {
 	struct sba_device *sba_dev = sba_list;
@@ -1866,7 +1865,6 @@ sba_proc_bitmap_info(struct seq_file *m, void *p)
 
 	return 0;
 }
-#endif /* CONFIG_PROC_FS */
 
 static const struct parisc_device_id sba_tbl[] __initconst = {
 	{ HPHW_IOA, HVERSION_REV_ANY_ID, ASTRO_RUNWAY_PORT, 0xb },
diff --git a/fs/netfs/main.c b/fs/netfs/main.c
index 5f0f438e5d21..624f36838279 100644
--- a/fs/netfs/main.c
+++ b/fs/netfs/main.c
@@ -124,11 +124,13 @@ static int __init netfs_init(void)
 	if (mempool_init_slab_pool(&netfs_subrequest_pool, 100, netfs_subrequest_slab) < 0)
 		goto error_subreqpool;
 
+#ifdef CONFIG_PROC_FS
 	if (!proc_mkdir("fs/netfs", NULL))
 		goto error_proc;
 	if (!proc_create_seq("fs/netfs/requests", S_IFREG | 0444, NULL,
 			     &netfs_requests_seq_ops))
 		goto error_procfile;
+#endif
 #ifdef CONFIG_FSCACHE_STATS
 	if (!proc_create_single("fs/netfs/stats", S_IFREG | 0444, NULL,
 				netfs_stats_show))
@@ -141,9 +143,11 @@ static int __init netfs_init(void)
 	return 0;
 
 error_fscache:
+#ifdef CONFIG_PROC_FS
 error_procfile:
 	remove_proc_entry("fs/netfs", NULL);
 error_proc:
+#endif
 	mempool_exit(&netfs_subrequest_pool);
 error_subreqpool:
 	kmem_cache_destroy(netfs_subrequest_slab);
diff --git a/include/linux/proc_fs.h b/include/linux/proc_fs.h
index 0b2a89854440..6df409eb485d 100644
--- a/include/linux/proc_fs.h
+++ b/include/linux/proc_fs.h
@@ -73,10 +73,10 @@ static inline struct proc_fs_info *proc_sb_info(struct super_block *sb)
 	return sb->s_fs_info;
 }
 
-#ifdef CONFIG_PROC_FS
-
 typedef int (*proc_write_t)(struct file *, char *, size_t);
 
+#ifdef CONFIG_PROC_FS
+
 extern void proc_root_init(void);
 extern void proc_flush_pid(struct pid *);
 
@@ -186,11 +186,25 @@ static inline struct proc_dir_entry *proc_mkdir_data(const char *name,
 	umode_t mode, struct proc_dir_entry *parent, void *data) { return NULL; }
 static inline struct proc_dir_entry *proc_mkdir_mode(const char *name,
 	umode_t mode, struct proc_dir_entry *parent) { return NULL; }
-#define proc_create_seq_private(name, mode, parent, ops, size, data) ({NULL;})
-#define proc_create_seq_data(name, mode, parent, ops, data) ({NULL;})
-#define proc_create_seq(name, mode, parent, ops) ({NULL;})
-#define proc_create_single(name, mode, parent, show) ({NULL;})
-#define proc_create_single_data(name, mode, parent, show, data) ({NULL;})
+static inline struct proc_dir_entry *proc_create_seq_private(const char *name,
+		umode_t mode, struct proc_dir_entry *parent,
+		const struct seq_operations *ops,
+		unsigned int state_size, void *data)
+{
+	return NULL;
+}
+#define proc_create_seq_data(name, mode, parent, ops, data) \
+	proc_create_seq_private(name, mode, parent, ops, 0, data)
+#define proc_create_seq(name, mode, parent, ops) \
+	proc_create_seq_private(name, mode, parent, ops, 0, NULL)
+static inline struct proc_dir_entry *proc_create_single_data(const char *name,
+		umode_t mode, struct proc_dir_entry *parent,
+		int (*show)(struct seq_file *, void *), void *data)
+{
+	return NULL;
+}
+#define proc_create_single(name, mode, parent, show) \
+	proc_create_single_data(name, mode, parent, show, NULL)
 
 static inline struct proc_dir_entry *
 proc_create(const char *name, umode_t mode, struct proc_dir_entry *parent,
@@ -211,11 +225,36 @@ static inline void proc_remove(struct proc_dir_entry *de) {}
 #define remove_proc_entry(name, parent) do {} while (0)
 static inline int remove_proc_subtree(const char *name, struct proc_dir_entry *parent) { return 0; }
 
-#define proc_create_net_data(name, mode, parent, ops, state_size, data) ({NULL;})
-#define proc_create_net_data_write(name, mode, parent, ops, write, state_size, data) ({NULL;})
-#define proc_create_net(name, mode, parent, state_size, ops) ({NULL;})
-#define proc_create_net_single(name, mode, parent, show, data) ({NULL;})
-#define proc_create_net_single_write(name, mode, parent, show, write, data) ({NULL;})
+static inline struct proc_dir_entry *proc_create_net_data(const char *name, umode_t mode,
+		struct proc_dir_entry *parent, const struct seq_operations *ops,
+		unsigned int state_size, void *data)
+{
+	return NULL;
+}
+#define proc_create_net(name, mode, parent, ops, state_size) \
+	proc_create_net_data(name, mode, parent, ops, state_size, NULL)
+static inline struct proc_dir_entry *proc_create_net_single(const char *name, umode_t mode,
+		struct proc_dir_entry *parent,
+		int (*show)(struct seq_file *, void *), void *data)
+{
+	return NULL;
+}
+static inline struct proc_dir_entry *proc_create_net_data_write(const char *name, umode_t mode,
+						  struct proc_dir_entry *parent,
+						  const struct seq_operations *ops,
+						  proc_write_t write,
+						  unsigned int state_size, void *data)
+{
+	return NULL;
+}
+static inline struct proc_dir_entry *proc_create_net_single_write(const char *name, umode_t mode,
+						    struct proc_dir_entry *parent,
+						    int (*show)(struct seq_file *, void *),
+						    proc_write_t write,
+						    void *data)
+{
+	return NULL;
+}
 
 static inline struct pid *tgid_pidfd_to_pid(const struct file *file)
 {
diff --git a/net/ax25/af_ax25.c b/net/ax25/af_ax25.c
index d6f9fae06a9d..162e4e6e526e 100644
--- a/net/ax25/af_ax25.c
+++ b/net/ax25/af_ax25.c
@@ -1926,8 +1926,6 @@ static int ax25_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg)
 	return res;
 }
 
-#ifdef CONFIG_PROC_FS
-
 static void *ax25_info_start(struct seq_file *seq, loff_t *pos)
 	__acquires(ax25_list_lock)
 {
@@ -2001,7 +1999,6 @@ static const struct seq_operations ax25_info_seqops = {
 	.stop = ax25_info_stop,
 	.show = ax25_info_show,
 };
-#endif
 
 static const struct net_proto_family ax25_family_ops = {
 	.family =	PF_AX25,
diff --git a/net/ipv4/arp.c b/net/ipv4/arp.c
index 11c1519b3699..95745d724e5a 100644
--- a/net/ipv4/arp.c
+++ b/net/ipv4/arp.c
@@ -1372,7 +1372,6 @@ static struct packet_type arp_packet_type __read_mostly = {
 	.func =	arp_rcv,
 };
 
-#ifdef CONFIG_PROC_FS
 #if IS_ENABLED(CONFIG_AX25)
 
 /*
@@ -1486,7 +1485,6 @@ static const struct seq_operations arp_seq_ops = {
 	.stop	= neigh_seq_stop,
 	.show	= arp_seq_show,
 };
-#endif /* CONFIG_PROC_FS */
 
 static int __net_init arp_net_init(struct net *net)
 {
diff --git a/net/l2tp/l2tp_ppp.c b/net/l2tp/l2tp_ppp.c
index 3596290047b2..e48f3bee3ff6 100644
--- a/net/l2tp/l2tp_ppp.c
+++ b/net/l2tp/l2tp_ppp.c
@@ -1408,8 +1408,6 @@ static int pppol2tp_getsockopt(struct socket *sock, int level, int optname,
 
 static unsigned int pppol2tp_net_id;
 
-#ifdef CONFIG_PROC_FS
-
 struct pppol2tp_seq_data {
 	struct seq_net_private p;
 	int tunnel_idx;			/* current tunnel */
@@ -1611,7 +1609,6 @@ static const struct seq_operations pppol2tp_seq_ops = {
 	.stop		= pppol2tp_seq_stop,
 	.show		= pppol2tp_seq_show,
 };
-#endif /* CONFIG_PROC_FS */
 
 /*****************************************************************************
  * Network namespace
diff --git a/net/netrom/af_netrom.c b/net/netrom/af_netrom.c
index 6ee148f0e6d0..946fe0169945 100644
--- a/net/netrom/af_netrom.c
+++ b/net/netrom/af_netrom.c
@@ -1260,8 +1260,6 @@ static int nr_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg)
 	return 0;
 }
 
-#ifdef CONFIG_PROC_FS
-
 static void *nr_info_start(struct seq_file *seq, loff_t *pos)
 	__acquires(&nr_list_lock)
 {
@@ -1342,7 +1340,6 @@ static const struct seq_operations nr_info_seqops = {
 	.stop = nr_info_stop,
 	.show = nr_info_show,
 };
-#endif	/* CONFIG_PROC_FS */
 
 static const struct net_proto_family nr_family_ops = {
 	.family		=	PF_NETROM,
diff --git a/net/rose/af_rose.c b/net/rose/af_rose.c
index 59050caab65c..0c18b593966b 100644
--- a/net/rose/af_rose.c
+++ b/net/rose/af_rose.c
@@ -1421,7 +1421,6 @@ static int rose_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg)
 	return 0;
 }
 
-#ifdef CONFIG_PROC_FS
 static void *rose_info_start(struct seq_file *seq, loff_t *pos)
 	__acquires(rose_list_lock)
 {
@@ -1500,7 +1499,6 @@ static const struct seq_operations rose_info_seqops = {
 	.stop = rose_info_stop,
 	.show = rose_info_show,
 };
-#endif	/* CONFIG_PROC_FS */
 
 static const struct net_proto_family rose_family_ops = {
 	.family		=	PF_ROSE,

