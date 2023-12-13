Return-Path: <linux-fsdevel+bounces-5883-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24907811391
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 14:52:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48B971C21158
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 13:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 231772EAF7;
	Wed, 13 Dec 2023 13:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RPankqSk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D32A128
	for <linux-fsdevel@vger.kernel.org>; Wed, 13 Dec 2023 05:50:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702475449;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GcWGCKLyPfse4wDaE+KAhQsj0lGRfM8k4vhEemK4IBQ=;
	b=RPankqSkLXSqZycfUlMXfLrYgAQuutuowZgNqKQlrZKYfetUkK3tINCtcC6+yaEImiKvL/
	RSbQRWc1dQCXNgOpw2vI5eRUzb2xMOXIg+Bq2q44vgYR4CjsyIwPSyyw+wxgbel3JkmP1z
	bEKYD3pG3Z4q9ZGeWGJCgE5FdL2KpZk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-519-J_A65qURMsmMFdRPvp7ULw-1; Wed, 13 Dec 2023 08:50:45 -0500
X-MC-Unique: J_A65qURMsmMFdRPvp7ULw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 45A2F101A551;
	Wed, 13 Dec 2023 13:50:45 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.2])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 5EB123C25;
	Wed, 13 Dec 2023 13:50:44 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Marc Dionne <marc.dionne@auristor.com>
Cc: David Howells <dhowells@redhat.com>,
	linux-afs@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 24/40] afs: Provide a way to configure address priorities
Date: Wed, 13 Dec 2023 13:49:46 +0000
Message-ID: <20231213135003.367397-25-dhowells@redhat.com>
In-Reply-To: <20231213135003.367397-1-dhowells@redhat.com>
References: <20231213135003.367397-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

AFS servers may have multiple addresses, but the client can't easily judge
between them as to which one is best.  For instance, an address that has a
larger RTT might actually have a better bandwidth because it goes through a
switch rather than being directly connected - but we can't work this out
dynamically unless we push through sufficient data that we can measure it.

To allow the administrator to configure this, add a list of preference
weightings for server addresses by IPv4/IPv6 address or subnet and allow
this to be viewed through a procfile and altered by writing text commands
to that same file.  Preference rules can be added/updated by:

	echo "add <proto> <addr>[/<subnet>] <prior>" >/proc/fs/afs/addr_prefs
	echo "add udp 1.2.3.4 1000" >/proc/fs/afs/addr_prefs
	echo "add udp 192.168.0.0/16 3000" >/proc/fs/afs/addr_prefs
	echo "add udp 1001:2002:0:6::/64 4000" >/proc/fs/afs/addr_prefs

and removed by:

	echo "del <proto> <addr>[/<subnet>]" >/proc/fs/afs/addr_prefs
	echo "del udp 1.2.3.4" >/proc/fs/afs/addr_prefs

where the priority is a number between 0 and 65535.

The list is split between IPv4 and IPv6 addresses and each sublist is kept
in numerical order, with rules that would otherwise match but have
different subnet masking being ordered with the most specific submatch
first.

A subsequent patch will apply these rules.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
---
 fs/afs/Makefile     |   1 +
 fs/afs/addr_prefs.c | 449 ++++++++++++++++++++++++++++++++++++++++++++
 fs/afs/internal.h   |  29 +++
 fs/afs/main.c       |   1 +
 fs/afs/proc.c       |  55 +++++-
 5 files changed, 534 insertions(+), 1 deletion(-)
 create mode 100644 fs/afs/addr_prefs.c

diff --git a/fs/afs/Makefile b/fs/afs/Makefile
index e8956b65d7ff..b3849bea0553 100644
--- a/fs/afs/Makefile
+++ b/fs/afs/Makefile
@@ -5,6 +5,7 @@
 
 kafs-y := \
 	addr_list.o \
+	addr_prefs.o \
 	callback.o \
 	cell.o \
 	cmservice.o \
diff --git a/fs/afs/addr_prefs.c b/fs/afs/addr_prefs.c
new file mode 100644
index 000000000000..c6dcff4f8aa1
--- /dev/null
+++ b/fs/afs/addr_prefs.c
@@ -0,0 +1,449 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* Address preferences management
+ *
+ * Copyright (C) 2023 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": addr_prefs: " fmt
+#include <linux/slab.h>
+#include <linux/ctype.h>
+#include <linux/inet.h>
+#include <linux/seq_file.h>
+#include <keys/rxrpc-type.h>
+#include "internal.h"
+
+static inline struct afs_net *afs_seq2net_single(struct seq_file *m)
+{
+	return afs_net(seq_file_single_net(m));
+}
+
+/*
+ * Split a NUL-terminated string up to the first newline around spaces.  The
+ * source string will be modified to have NUL-terminations inserted.
+ */
+static int afs_split_string(char **pbuf, char *strv[], unsigned int maxstrv)
+{
+	unsigned int count = 0;
+	char *p = *pbuf;
+
+	maxstrv--; /* Allow for terminal NULL */
+	for (;;) {
+		/* Skip over spaces */
+		while (isspace(*p)) {
+			if (*p == '\n') {
+				p++;
+				break;
+			}
+			p++;
+		}
+		if (!*p)
+			break;
+
+		/* Mark start of word */
+		if (count >= maxstrv) {
+			pr_warn("Too many elements in string\n");
+			return -EINVAL;
+		}
+		strv[count++] = p;
+
+		/* Skip over word */
+		while (!isspace(*p))
+			p++;
+		if (!*p)
+			break;
+
+		/* Mark end of word */
+		if (*p == '\n') {
+			*p++ = 0;
+			break;
+		}
+		*p++ = 0;
+	}
+
+	*pbuf = p;
+	strv[count] = NULL;
+	return count;
+}
+
+/*
+ * Parse an address with an optional subnet mask.
+ */
+static int afs_parse_address(char *p, struct afs_addr_preference *pref)
+{
+	const char *stop;
+	unsigned long mask, tmp;
+	char *end = p + strlen(p);
+	bool bracket = false;
+
+	if (*p == '[') {
+		p++;
+		bracket = true;
+	}
+
+#if 0
+	if (*p == '[') {
+		p++;
+		q = memchr(p, ']', end - p);
+		if (!q) {
+			pr_warn("Can't find closing ']'\n");
+			return -EINVAL;
+		}
+	} else {
+		for (q = p; q < end; q++)
+			if (*q == '/')
+				break;
+	}
+#endif
+
+	if (in4_pton(p, end - p, (u8 *)&pref->ipv4_addr, -1, &stop)) {
+		pref->family = AF_INET;
+		mask = 32;
+	} else if (in6_pton(p, end - p, (u8 *)&pref->ipv6_addr, -1, &stop)) {
+		pref->family = AF_INET6;
+		mask = 128;
+	} else {
+		pr_warn("Can't determine address family\n");
+		return -EINVAL;
+	}
+
+	p = (char *)stop;
+	if (bracket) {
+		if (*p != ']') {
+			pr_warn("Can't find closing ']'\n");
+			return -EINVAL;
+		}
+		p++;
+	}
+
+	if (*p == '/') {
+		p++;
+		tmp = simple_strtoul(p, &p, 10);
+		if (tmp > mask) {
+			pr_warn("Subnet mask too large\n");
+			return -EINVAL;
+		}
+		if (tmp == 0) {
+			pr_warn("Subnet mask too small\n");
+			return -EINVAL;
+		}
+		mask = tmp;
+	}
+
+	if (*p) {
+		pr_warn("Invalid address\n");
+		return -EINVAL;
+	}
+
+	pref->subnet_mask = mask;
+	return 0;
+}
+
+enum cmp_ret {
+	CONTINUE_SEARCH,
+	INSERT_HERE,
+	EXACT_MATCH,
+	SUBNET_MATCH,
+};
+
+/*
+ * See if a candidate address matches a listed address.
+ */
+static enum cmp_ret afs_cmp_address_pref(const struct afs_addr_preference *a,
+					 const struct afs_addr_preference *b)
+{
+	int subnet = min(a->subnet_mask, b->subnet_mask);
+	const __be32 *pa, *pb;
+	u32 mask, na, nb;
+	int diff;
+
+	if (a->family != b->family)
+		return INSERT_HERE;
+
+	switch (a->family) {
+	case AF_INET6:
+		pa = a->ipv6_addr.s6_addr32;
+		pb = b->ipv6_addr.s6_addr32;
+		break;
+	case AF_INET:
+		pa = &a->ipv4_addr.s_addr;
+		pb = &b->ipv4_addr.s_addr;
+		break;
+	}
+
+	while (subnet > 32) {
+		diff = ntohl(*pa++) - ntohl(*pb++);
+		if (diff < 0)
+			return INSERT_HERE; /* a<b */
+		if (diff > 0)
+			return CONTINUE_SEARCH; /* a>b */
+		subnet -= 32;
+	}
+
+	if (subnet == 0)
+		return EXACT_MATCH;
+
+	mask = 0xffffffffU << (32 - subnet);
+	na = ntohl(*pa);
+	nb = ntohl(*pb);
+	diff = (na & mask) - (nb & mask);
+	//kdebug("diff %08x %08x %08x %d", na, nb, mask, diff);
+	if (diff < 0)
+		return INSERT_HERE; /* a<b */
+	if (diff > 0)
+		return CONTINUE_SEARCH; /* a>b */
+	if (a->subnet_mask == b->subnet_mask)
+		return EXACT_MATCH;
+	if (a->subnet_mask > b->subnet_mask)
+		return SUBNET_MATCH; /* a binds tighter than b */
+	return CONTINUE_SEARCH; /* b binds tighter than a */
+}
+
+/*
+ * Insert an address preference.
+ */
+static int afs_insert_address_pref(struct afs_addr_preference_list **_preflist,
+				   struct afs_addr_preference *pref,
+				   int index)
+{
+	struct afs_addr_preference_list *preflist = *_preflist, *old = preflist;
+	size_t size, max_prefs;
+
+	_enter("{%u/%u/%u},%u", preflist->ipv6_off, preflist->nr, preflist->max_prefs, index);
+
+	if (preflist->nr == 255)
+		return -ENOSPC;
+	if (preflist->nr >= preflist->max_prefs) {
+		max_prefs = preflist->max_prefs + 1;
+		size = struct_size(preflist, prefs, max_prefs);
+		size = roundup_pow_of_two(size);
+		max_prefs = min_t(size_t, (size - sizeof(*preflist)) / sizeof(*pref), 255);
+		preflist = kmalloc(size, GFP_KERNEL);
+		if (!preflist)
+			return -ENOMEM;
+		*preflist = **_preflist;
+		preflist->max_prefs = max_prefs;
+		*_preflist = preflist;
+
+		if (index < preflist->nr)
+			memcpy(preflist->prefs + index + 1, old->prefs + index,
+			       sizeof(*pref) * (preflist->nr - index));
+		if (index > 0)
+			memcpy(preflist->prefs, old->prefs, sizeof(*pref) * index);
+	} else {
+		if (index < preflist->nr)
+			memmove(preflist->prefs + index + 1, preflist->prefs + index,
+			       sizeof(*pref) * (preflist->nr - index));
+	}
+
+	preflist->prefs[index] = *pref;
+	preflist->nr++;
+	if (pref->family == AF_INET)
+		preflist->ipv6_off++;
+	return 0;
+}
+
+/*
+ * Add an address preference.
+ *	echo "add <proto> <IP>[/<mask>] <prior>" >/proc/fs/afs/addr_prefs
+ */
+static int afs_add_address_pref(struct afs_net *net, struct afs_addr_preference_list **_preflist,
+				int argc, char **argv)
+{
+	struct afs_addr_preference_list *preflist = *_preflist;
+	struct afs_addr_preference pref;
+	enum cmp_ret cmp;
+	int ret, i, stop;
+
+	if (argc != 3) {
+		pr_warn("Wrong number of params\n");
+		return -EINVAL;
+	}
+
+	if (strcmp(argv[0], "udp") != 0) {
+		pr_warn("Unsupported protocol\n");
+		return -EINVAL;
+	}
+
+	ret = afs_parse_address(argv[1], &pref);
+	if (ret < 0)
+		return ret;
+
+	ret = kstrtou16(argv[2], 10, &pref.prio);
+	if (ret < 0) {
+		pr_warn("Invalid priority\n");
+		return ret;
+	}
+
+	if (pref.family == AF_INET) {
+		i = 0;
+		stop = preflist->ipv6_off;
+	} else {
+		i = preflist->ipv6_off;
+		stop = preflist->nr;
+	}
+
+	for (; i < stop; i++) {
+		cmp = afs_cmp_address_pref(&pref, &preflist->prefs[i]);
+		switch (cmp) {
+		case CONTINUE_SEARCH:
+			continue;
+		case INSERT_HERE:
+		case SUBNET_MATCH:
+			return afs_insert_address_pref(_preflist, &pref, i);
+		case EXACT_MATCH:
+			preflist->prefs[i].prio = pref.prio;
+			return 0;
+		}
+	}
+
+	return afs_insert_address_pref(_preflist, &pref, i);
+}
+
+/*
+ * Delete an address preference.
+ */
+static int afs_delete_address_pref(struct afs_addr_preference_list **_preflist,
+				   int index)
+{
+	struct afs_addr_preference_list *preflist = *_preflist;
+
+	_enter("{%u/%u/%u},%u", preflist->ipv6_off, preflist->nr, preflist->max_prefs, index);
+
+	if (preflist->nr == 0)
+		return -ENOENT;
+
+	if (index < preflist->nr - 1)
+		memmove(preflist->prefs + index, preflist->prefs + index + 1,
+			sizeof(preflist->prefs[0]) * (preflist->nr - index - 1));
+
+	if (index < preflist->ipv6_off)
+		preflist->ipv6_off--;
+	preflist->nr--;
+	return 0;
+}
+
+/*
+ * Delete an address preference.
+ *	echo "del <proto> <IP>[/<mask>]" >/proc/fs/afs/addr_prefs
+ */
+static int afs_del_address_pref(struct afs_net *net, struct afs_addr_preference_list **_preflist,
+				int argc, char **argv)
+{
+	struct afs_addr_preference_list *preflist = *_preflist;
+	struct afs_addr_preference pref;
+	enum cmp_ret cmp;
+	int ret, i, stop;
+
+	if (argc != 2) {
+		pr_warn("Wrong number of params\n");
+		return -EINVAL;
+	}
+
+	if (strcmp(argv[0], "udp") != 0) {
+		pr_warn("Unsupported protocol\n");
+		return -EINVAL;
+	}
+
+	ret = afs_parse_address(argv[1], &pref);
+	if (ret < 0)
+		return ret;
+
+	if (pref.family == AF_INET) {
+		i = 0;
+		stop = preflist->ipv6_off;
+	} else {
+		i = preflist->ipv6_off;
+		stop = preflist->nr;
+	}
+
+	for (; i < stop; i++) {
+		cmp = afs_cmp_address_pref(&pref, &preflist->prefs[i]);
+		switch (cmp) {
+		case CONTINUE_SEARCH:
+			continue;
+		case INSERT_HERE:
+		case SUBNET_MATCH:
+			return 0;
+		case EXACT_MATCH:
+			return afs_delete_address_pref(_preflist, i);
+		}
+	}
+
+	return -ENOANO;
+}
+
+/*
+ * Handle writes to /proc/fs/afs/addr_prefs
+ */
+int afs_proc_addr_prefs_write(struct file *file, char *buf, size_t size)
+{
+	struct afs_addr_preference_list *preflist, *old;
+	struct seq_file *m = file->private_data;
+	struct afs_net *net = afs_seq2net_single(m);
+	size_t psize;
+	char *argv[5];
+	int ret, argc, max_prefs;
+
+	inode_lock(file_inode(file));
+
+	/* Allocate a candidate new list and initialise it from the old. */
+	old = rcu_dereference_protected(net->address_prefs,
+					lockdep_is_held(&file_inode(file)->i_rwsem));
+
+	if (old)
+		max_prefs = old->nr + 1;
+	else
+		max_prefs = 1;
+
+	psize = struct_size(old, prefs, max_prefs);
+	psize = roundup_pow_of_two(psize);
+	max_prefs = min_t(size_t, (psize - sizeof(*old)) / sizeof(old->prefs[0]), 255);
+
+	ret = -ENOMEM;
+	preflist = kmalloc(struct_size(preflist, prefs, max_prefs), GFP_KERNEL);
+	if (!preflist)
+		goto done;
+
+	if (old)
+		memcpy(preflist, old, struct_size(preflist, prefs, old->nr));
+	else
+		memset(preflist, 0, sizeof(*preflist));
+	preflist->max_prefs = max_prefs;
+
+	do {
+		argc = afs_split_string(&buf, argv, ARRAY_SIZE(argv));
+		if (argc < 0)
+			return argc;
+		if (argc < 2)
+			goto inval;
+
+		if (strcmp(argv[0], "add") == 0)
+			ret = afs_add_address_pref(net, &preflist, argc - 1, argv + 1);
+		else if (strcmp(argv[0], "del") == 0)
+			ret = afs_del_address_pref(net, &preflist, argc - 1, argv + 1);
+		else
+			goto inval;
+		if (ret < 0)
+			goto done;
+	} while (*buf);
+
+	preflist->version++;
+	rcu_assign_pointer(net->address_prefs, preflist);
+	/* Store prefs before version */
+	smp_store_release(&net->address_pref_version, preflist->version);
+	kfree_rcu(old, rcu);
+	preflist = NULL;
+	ret = 0;
+
+done:
+	kfree(preflist);
+	inode_unlock(file_inode(file));
+	_leave(" = %d", ret);
+	return ret;
+
+inval:
+	pr_warn("Invalid Command\n");
+	ret = -EINVAL;
+	goto done;
+}
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index ae33dd8ae49b..4445c734cdcd 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -72,6 +72,28 @@ enum afs_call_state {
 	AFS_CALL_COMPLETE,		/* Completed or failed */
 };
 
+/*
+ * Address preferences.
+ */
+struct afs_addr_preference {
+	union {
+		struct in_addr	ipv4_addr;	/* AF_INET address to compare against */
+		struct in6_addr	ipv6_addr;	/* AF_INET6 address to compare against */
+	};
+	sa_family_t		family;		/* Which address to use */
+	u16			prio;		/* Priority */
+	u8			subnet_mask;	/* How many bits to compare */
+};
+
+struct afs_addr_preference_list {
+	struct rcu_head		rcu;
+	u16			version;	/* Incremented when prefs list changes */
+	u8			ipv6_off;	/* Offset of IPv6 addresses */
+	u8			nr;		/* Number of addresses in total */
+	u8			max_prefs;	/* Number of prefs allocated */
+	struct afs_addr_preference prefs[] __counted_by(max_prefs);
+};
+
 struct afs_address {
 	struct rxrpc_peer	*peer;
 	short			last_error;	/* Last error from this address */
@@ -315,6 +337,8 @@ struct afs_net {
 	struct proc_dir_entry	*proc_afs;	/* /proc/net/afs directory */
 	struct afs_sysnames	*sysnames;
 	rwlock_t		sysnames_lock;
+	struct afs_addr_preference_list __rcu *address_prefs;
+	u16			address_pref_version;
 
 	/* Statistics counters */
 	atomic_t		n_lookup;	/* Number of lookups done */
@@ -982,6 +1006,11 @@ extern int afs_merge_fs_addr4(struct afs_net *net, struct afs_addr_list *addr,
 extern int afs_merge_fs_addr6(struct afs_net *net, struct afs_addr_list *addr,
 			      __be32 *xdr, u16 port);
 
+/*
+ * addr_prefs.c
+ */
+int afs_proc_addr_prefs_write(struct file *file, char *buf, size_t size);
+
 /*
  * callback.c
  */
diff --git a/fs/afs/main.c b/fs/afs/main.c
index 6425c81d07de..1b3bd21c168a 100644
--- a/fs/afs/main.c
+++ b/fs/afs/main.c
@@ -156,6 +156,7 @@ static void __net_exit afs_net_exit(struct net *net_ns)
 	afs_close_socket(net);
 	afs_proc_cleanup(net);
 	afs_put_sysnames(net->sysnames);
+	kfree_rcu(rcu_access_pointer(net->address_prefs), rcu);
 }
 
 static struct pernet_operations afs_net_ops = {
diff --git a/fs/afs/proc.c b/fs/afs/proc.c
index 0b43bb9b0260..2e63c99a4f1e 100644
--- a/fs/afs/proc.c
+++ b/fs/afs/proc.c
@@ -146,6 +146,55 @@ static int afs_proc_cells_write(struct file *file, char *buf, size_t size)
 	goto done;
 }
 
+/*
+ * Display the list of addr_prefs known to the namespace.
+ */
+static int afs_proc_addr_prefs_show(struct seq_file *m, void *v)
+{
+	struct afs_addr_preference_list *preflist;
+	struct afs_addr_preference *pref;
+	struct afs_net *net = afs_seq2net_single(m);
+	union {
+		struct sockaddr_in sin;
+		struct sockaddr_in6 sin6;
+	} addr;
+	unsigned int i;
+	char buf[44]; /* Maximum ipv6 + max subnet is 43 */
+
+	rcu_read_lock();
+	preflist = rcu_dereference(net->address_prefs);
+
+	if (!preflist) {
+		seq_puts(m, "NO PREFS\n");
+		return 0;
+	}
+
+	seq_printf(m, "PROT SUBNET                                      PRIOR (v=%u n=%u/%u/%u)\n",
+		   preflist->version, preflist->ipv6_off, preflist->nr, preflist->max_prefs);
+
+	memset(&addr, 0, sizeof(addr));
+
+	for (i = 0; i < preflist->nr; i++) {
+		pref = &preflist->prefs[i];
+
+		addr.sin.sin_family = pref->family;
+		if (pref->family == AF_INET) {
+			memcpy(&addr.sin.sin_addr, &pref->ipv4_addr,
+			       sizeof(addr.sin.sin_addr));
+			snprintf(buf, sizeof(buf), "%pISc/%u", &addr.sin, pref->subnet_mask);
+			seq_printf(m, "UDP  %-43.43s %5u\n", buf, pref->prio);
+		} else {
+			memcpy(&addr.sin6.sin6_addr, &pref->ipv6_addr,
+			       sizeof(addr.sin6.sin6_addr));
+			snprintf(buf, sizeof(buf), "%pISc/%u", &addr.sin6, pref->subnet_mask);
+			seq_printf(m, "UDP  %-43.43s %5u\n", buf, pref->prio);
+		}
+	}
+
+	rcu_read_lock();
+	return 0;
+}
+
 /*
  * Display the name of the current workstation cell.
  */
@@ -690,7 +739,11 @@ int afs_proc_init(struct afs_net *net)
 					&afs_proc_sysname_ops,
 					afs_proc_sysname_write,
 					sizeof(struct seq_net_private),
-					NULL))
+					NULL) ||
+	    !proc_create_net_single_write("addr_prefs", 0644, p,
+					  afs_proc_addr_prefs_show,
+					  afs_proc_addr_prefs_write,
+					  NULL))
 		goto error_tree;
 
 	net->proc_afs = p;


