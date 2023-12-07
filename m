Return-Path: <linux-fsdevel+bounces-5274-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EA875809595
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 23:46:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79CACB20B03
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 22:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE49D5731F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 22:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="OP0+Rsf9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B24ED10DE;
	Thu,  7 Dec 2023 14:04:59 -0800 (PST)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 740E44C1D75;
	Thu,  7 Dec 2023 21:56:15 +0000 (UTC)
Received: from pdx1-sub0-mail-a206.dreamhost.com (unknown [127.0.0.6])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id C44434C1E75;
	Thu,  7 Dec 2023 21:56:12 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1701986173; a=rsa-sha256;
	cv=none;
	b=FrzBhKhi7oi2hh5/Ab2hEXkSLTK+gN7zS8lRMvn/uA6y2ff2RocuRoF3iRIe04EGSb9o5A
	hW8pbncCySgd5EvStma2upNJ0baApNsdo7+QDQyZqAo/4yeW4ZnxXWOyBA+508RnvwgCZU
	1cGVHTg2dk9P8wM8cmd00Op06dcJObHzqcN2NwETY/znSlbeLY1XfDn+CZJW1UDxOq8pEM
	p4feXEWkUyaqAEYZpx1Jqw2rzyuveWqM9okl+wMT2UhYXiA1fz/shGCximkWtioExwSf6M
	+Wcs9XYjFVaERc08j8dJL1ztrnUVFom5LOY9kJJYOWR49jyg+xY7DfQfjke0CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1701986173;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=ZFQXUxb5pGxDFp9SqTWomNtV+BmHJVuCbAFuRHJpiLo=;
	b=aJs9zHZE8/6fnJKBnUnMonnvA1jPRRICMNj4FaJFBbp48FybiaH82QJUE02OM3gjIuLcqv
	KOOxbaHfL7HWFik4CJWcaF8bSgu0IZWpEBU+KM+cUM9IhB24EVjBGQjcG27MBmxmsYwP3Y
	JKqBkVvCfJdJyH4LbksqIIQxjIBcsbIMtWQxc2CvaKlkbPJ4+Ek48tkraWNyFyUkBxB+oB
	Ee965c8lmrMpqivaL5zyFssvlgGe0P8moBkgOwT/X6fIiISTdEvFewj0nBC/mCYRNcHV0d
	T6/ME6DdT9f5MI1WAsyA+/kUAv9DtAUNZq0DxVSshcy/+HtSJURDg+zui7hZvw==
ARC-Authentication-Results: i=1;
	rspamd-d88d8bd54-9cctm;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Battle-Soft: 0d11124e0e30dae7_1701986175277_409846363
X-MC-Loop-Signature: 1701986175277:1907138347
X-MC-Ingress-Time: 1701986175277
Received: from pdx1-sub0-mail-a206.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.125.102.70 (trex/6.9.2);
	Thu, 07 Dec 2023 21:56:15 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a206.dreamhost.com (Postfix) with ESMTPSA id 4SmSlG6CW8zCb;
	Thu,  7 Dec 2023 13:56:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1701986172;
	bh=Nh2dCSqy2bPuNSUn1zPTus4eN9IQRtX4phDu3VMYX3w=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=OP0+Rsf9gPii7VoqZYcWYfH7IthslLifAefd7vbsdulQz139A+lTtfwRuFr/Glk6S
	 r5pFgCWXsQN/9dO082NMTrSsgiCcsbTVCImTesTZF9Xwys/lwI2yof5xk7ilLVS58C
	 Y0hXBTpj8Au9+j4onfzgEKpPL4ynFAZWV23SEz0sSbEu7dZD7u28zXLbapaFaY95BY
	 Q53iPmLCeBLAzRQZm6KRPIFaSo2o/Mp0hKFHLBA8vnktEO/GMPU2OVMXX1jB7oNanf
	 D0UjTUOvjS4lofM/CHx5S0Vj6YZSq/4BA5NqYz+xE9yMRM2qeuAi/g7uQrM9l9tvAg
	 M3afLawtxCxxA==
Date: Thu, 7 Dec 2023 13:56:07 -0800
From: Davidlohr Bueso <dave@stgolabs.net>
To: Gregory Price <gourry.memverge@gmail.com>
Cc: linux-mm@kvack.org, jgroves@micron.com, ravis.opensrc@micron.com, 
	sthanneeru@micron.com, emirakhur@micron.com, Hasan.Maruf@amd.com, 
	linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, akpm@linux-foundation.org, 
	arnd@arndb.de, tglx@linutronix.de, luto@kernel.org, mingo@redhat.com, 
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	mhocko@kernel.org, tj@kernel.org, ying.huang@intel.com, gregory.price@memverge.com, 
	corbet@lwn.net, rakie.kim@sk.com, hyeongtak.ji@sk.com, honggyu.kim@sk.com, 
	vtavarespetr@micron.com, peterz@infradead.org
Subject: Re: [RFC PATCH 01/11] mm/mempolicy: implement the sysfs-based
 weighted_interleave interface
Message-ID: <uxqkbmqbvcvx6wc3g2h6vhkutv5flrq6rslwdfs7pa6kknupwh@a245pbtfqfgj>
Mail-Followup-To: Gregory Price <gourry.memverge@gmail.com>, 
	linux-mm@kvack.org, jgroves@micron.com, ravis.opensrc@micron.com, 
	sthanneeru@micron.com, emirakhur@micron.com, Hasan.Maruf@amd.com, 
	linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, akpm@linux-foundation.org, 
	arnd@arndb.de, tglx@linutronix.de, luto@kernel.org, mingo@redhat.com, 
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	mhocko@kernel.org, tj@kernel.org, ying.huang@intel.com, gregory.price@memverge.com, 
	corbet@lwn.net, rakie.kim@sk.com, hyeongtak.ji@sk.com, honggyu.kim@sk.com, 
	vtavarespetr@micron.com, peterz@infradead.org
References: <20231207002759.51418-1-gregory.price@memverge.com>
 <20231207002759.51418-2-gregory.price@memverge.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20231207002759.51418-2-gregory.price@memverge.com>
User-Agent: NeoMutt/20231006

On Wed, 06 Dec 2023, Gregory Price wrote:

>Signed-off-by: Rakie Kim <rakie.kim@sk.com>
>Signed-off-by: Honggyu Kim <honggyu.kim@sk.com>
>Co-developed-by: Gregory Price <gregory.price@memverge.com>
>Signed-off-by: Gregory Price <gregory.price@memverge.com>
>Co-developed-by: Hyeongtak Ji <hyeongtak.ji@sk.com>
>Signed-off-by: Hyeongtak Ji <hyeongtak.ji@sk.com>

fyi Rakie's tag needs to be last, per the From.

...

>+What:		/sys/kernel/mm/mempolicy/weighted_interleave/
>+Date:		December 2023
>+Contact:	Linux memory management mailing list <linux-mm@kvack.org>
>+Description:	Configuration Interface for the Weighted Interleave policy
>+
>+What:		/sys/kernel/mm/mempolicy/weighted_interleave/nodeN/
>+Date:		December 2023
>+Contact:	Linux memory management mailing list <linux-mm@kvack.org>
>+Description:	Configuration interface for accesses initiated from nodeN
>+
>+		The directory to configure access initiator weights for nodeN.
>+
>+		Possible numa nodes which have not been marked as a CPU node
>+		at boot will not have a nodeN directory made for them at boot.

This could be better rephrased without the negation. ie:

"Only numa nodes with CPUs (compute) will have a nodeN directory."

>+		Hotplug for CPU nodes is not supported.

Can this even happen? Hot-adding a previously offlined CPU won't change/add a
new numa node. So just rm the line altogether?

>+
>+What:		/sys/kernel/mm/mempolicy/weighted_interleave/nodeN/nodeM
>+		/sys/kernel/mm/mempolicy/weighted_interleave/nodeN/nodeM/weight
>+Date:		December 2023
>+Contact:	Linux memory management mailing list <linux-mm@kvack.org>
>+Description:	Configuration interface for target nodes accessed from nodeNN
>+
>+		The interleave weight for a memory node (M) from initiating
>+		node (N). These weights are utilized by processes which have set
>+		the mempolicy to MPOL_WEIGHTED_INTERLEAVE and have opted into
>+		global weights by omitting a task-local weight array.
>+
>+		These weights only affect new allocations, and changes at runtime
>+		will not cause migrations on already allocated pages.
>+
>+		If the weight of 0 is desired, the appropriate way to do this is
>+		by removing the node from the weighted interleave nodemask.
>+
>+		Minimum weight: 1
>+		Maximum weight: 255
>diff --git a/mm/mempolicy.c b/mm/mempolicy.c
>index 10a590ee1c89..ce332b5e7a03 100644
>--- a/mm/mempolicy.c
>+++ b/mm/mempolicy.c
>@@ -131,6 +131,11 @@ static struct mempolicy default_policy = {
>
> static struct mempolicy preferred_node_policy[MAX_NUMNODES];
>
>+struct interleave_weight_table {
>+	unsigned char weights[MAX_NUMNODES];
>+};
>+static struct interleave_weight_table *iw_table;
>+
> /**
>  * numa_nearest_node - Find nearest node by state
>  * @node: Node id to start the search
>@@ -3067,3 +3072,224 @@ void mpol_to_str(char *buffer, int maxlen, struct mempolicy *pol)
>		p += scnprintf(p, buffer + maxlen - p, ":%*pbl",
>			       nodemask_pr_args(&nodes));
> }
>+
>+struct iw_node_info {
>+	struct kobject kobj;
>+	int src;
>+	int dst;
>+};
>+
>+static ssize_t node_weight_show(struct kobject *kobj,
>+				struct kobj_attribute *attr, char *buf)
>+{
>+	struct iw_node_info *node_info = container_of(kobj, struct iw_node_info,
>+						      kobj);
>+	return sysfs_emit(buf, "%d\n",
>+			  iw_table[node_info->src].weights[node_info->dst]);
>+}
>+
>+static ssize_t node_weight_store(struct kobject *kobj,
>+				 struct kobj_attribute *attr,
>+				 const char *buf, size_t count)
>+{
>+	unsigned char weight = 0;
>+	struct iw_node_info *node_info = NULL;
>+
>+	node_info = container_of(kobj, struct iw_node_info, kobj);
>+
>+	if (kstrtou8(buf, 0, &weight) || !weight)
>+		return -EINVAL;
>+
>+	iw_table[node_info->src].weights[node_info->dst] = weight;
>+
>+	return count;
>+}

iw_table will need some (basic) form of serialization.

...

>+static int __init mempolicy_sysfs_init(void)
>+{
>+	int err, nid;
>+	int cpunodes = 0;
>+	struct kobject *root_kobj;
>+
>+	for_each_node_state(nid, N_CPU)
>+		cpunodes += 1;
>+	iw_table = kmalloc_array(cpunodes, sizeof(*iw_table), GFP_KERNEL);
>+	if (!iw_table) {
>+		pr_err("failed to create interleave weight table\n");
>+		err = -ENOMEM;
>+		goto fail_obj;

No ref here yet, just return -ENOMEM.

>+	}
>+	memset(iw_table, 1, cpunodes * sizeof(*iw_table));
>+
>+	root_kobj = kzalloc(sizeof(struct kobject), GFP_KERNEL);
>+	if (!root_kobj)
>+		return -ENOMEM;
>+
>+	kobject_init(root_kobj, &mempolicy_kobj_ktype);
>+	err = kobject_add(root_kobj, mm_kobj, "mempolicy");
>+	if (err) {
>+		pr_err("failed to add kobject to the system\n");
>+		goto fail_obj;
>+	}
>+
>+	err = sysfs_create_group(root_kobj, &mempolicy_attr_group);
>+	if (err) {
>+		pr_err("failed to register mempolicy group\n");
>+		goto fail_obj;
>+	}
>+
>+	err = add_weighted_interleave_group(root_kobj);
>+fail_obj:
>+	if (err)
>+		kobject_put(root_kobj);
>+	return err;
>+
>+}
>+late_initcall(mempolicy_sysfs_init);
>--
>2.39.1
>
>

