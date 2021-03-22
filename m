Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B819434384E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Mar 2021 06:23:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbhCVFWv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Mar 2021 01:22:51 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:34399 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbhCVFWN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Mar 2021 01:22:13 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20210322052211epoutp01db84d0c9fbc82590e1c253476a3a2558~ukp-UjRyt3034230342epoutp01F
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Mar 2021 05:22:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20210322052211epoutp01db84d0c9fbc82590e1c253476a3a2558~ukp-UjRyt3034230342epoutp01F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1616390531;
        bh=38EYf03zxQjlHFefWYb2NtnT7ULMpA9FLrGh3b22xZY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eapeO8TSVgCs9OCMm1RR7D4dIn5gu/wiaLD3synG7DK8UJtIZC6TQun9d6aFRBJxk
         oyrK4HsJP4KqWvMmuayj+4MNgJ2KyV1TdLQK/NDGH1uN0qElj5O27wqYGS84S/e7TT
         XXeqq684s9TcYcQvm/IPAvX4HNOwrfjZokrURLGs=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20210322052210epcas1p18fbf31271c742599afd4c972cb71bd87~ukp_l7UdE2523125231epcas1p1H;
        Mon, 22 Mar 2021 05:22:10 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.159]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4F3jYF48tcz4x9Pv; Mon, 22 Mar
        2021 05:22:09 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        15.DF.22618.08928506; Mon, 22 Mar 2021 14:22:08 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20210322052207epcas1p3f0a5bdfd2c994a849a67b465479d0721~ukp7ueKzj1871018710epcas1p3W;
        Mon, 22 Mar 2021 05:22:07 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210322052207epsmtrp1cca73de6812951e4200a55fd838ce1b0~ukp7tRAZY2013120131epsmtrp1O;
        Mon, 22 Mar 2021 05:22:07 +0000 (GMT)
X-AuditID: b6c32a38-e63ff7000001585a-33-605829807017
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        72.36.08745.F7928506; Mon, 22 Mar 2021 14:22:07 +0900 (KST)
Received: from localhost.localdomain (unknown [10.88.103.87]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210322052207epsmtip1a03c3b6a05acd1ddab15b073ec0485ca~ukp7OIDHj1797317973epsmtip1R;
        Mon, 22 Mar 2021 05:22:07 +0000 (GMT)
From:   Namjae Jeon <namjae.jeon@samsung.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-cifs@vger.kernel.org
Cc:     linux-cifsd-devel@lists.sourceforge.net, smfrench@gmail.com,
        senozhatsky@chromium.org, hyc.lee@gmail.com,
        viro@zeniv.linux.org.uk, hch@lst.de, hch@infradead.org,
        ronniesahlberg@gmail.com, aurelien.aptel@gmail.com,
        aaptel@suse.com, sandeen@sandeen.net, dan.carpenter@oracle.com,
        colin.king@canonical.com, rdunlap@infradead.org,
        Namjae Jeon <namjae.jeon@samsung.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steve French <stfrench@microsoft.com>
Subject: [PATCH 3/5] cifsd: add file operations
Date:   Mon, 22 Mar 2021 14:13:42 +0900
Message-Id: <20210322051344.1706-4-namjae.jeon@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210322051344.1706-1-namjae.jeon@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrMJsWRmVeSWpSXmKPExsWy7bCmgW6jZkSCQfNDNovGt6dZLI6//stu
        8Xt1L5vF63/TWSxOT1jEZLFy9VEmi2v337NbvPi/i9ni5//vjBZ79p5ksbi8aw6bxY/p9RZv
        7wDV9vZ9YrVovaJlsXvjIjaLtZ8fs1u8eXGYzeLWxPlsFuf/Hmd1EPGY1dDL5jG74SKLx85Z
        d9k9Nq/Q8ti94DOTx+6bDWwerTv+snt8fHqLxaNvyypGjy2LHzJ5rN9ylcXj8yY5j01P3jIF
        8Ebl2GSkJqakFimk5iXnp2TmpdsqeQfHO8ebmhkY6hpaWpgrKeQl5qbaKrn4BOi6ZeYAPauk
        UJaYUwoUCkgsLlbSt7Mpyi8tSVXIyC8usVVKLUjJKTA0KNArTswtLs1L10vOz7UyNDAwMgWq
        TMjJuHVqC2vBsuesFS3P7zE3MO69ydLFyMkhIWAisbzlDXMXIxeHkMAORokle9qZIJxPjBLX
        5/9ghXA+M0ocPficFablwdtXUFW7GCWeLzzMCNdy5+ZkIIeDg01AW+LPFlGQBhGBWIkbO16D
        7WAWuMYscXzBTEaQhLCAvsSu4z1gNouAqsT7bWeYQHp5Bawl5j1xgFgmL7F6wwFmEJtTwEZi
        2vJOFpA5EgJPOCQ29TwEq5cQcJFo+SUFUS8s8er4FnYIW0riZX8bO0RJtcTH/cwQ4Q5GiRff
        bSFsY4mb6zewgpQwC2hKrN+lDxFWlNj5ey7YYcwCfBLvvvawQkzhlehoE4IoUZXou3SYCcKW
        luhq/wC11EPiyb850ADpZ5TY2/2bcQKj3CyEDQsYGVcxiqUWFOempxYbFpggx9gmRnBq1rLY
        wTj37Qe9Q4xMHIyHGCU4mJVEeE8khyQI8aYkVlalFuXHF5XmpBYfYjQFhtxEZinR5Hxgdsgr
        iTc0NTI2NrYwMTM3MzVWEudNMngQLySQnliSmp2aWpBaBNPHxMEp1cCUX8P3/e2mxcJzax/u
        mhJdsqAjbOKkFmXvtJY/hl6TZm4vOhXtPqtFN3u1usjl6D8+68Vmf6xlvJ8yx3xDYgBX0bNV
        5W1OGirTnlo+0LST2q01V//j06AnT2LXTs+JOGyz3kMh883BbYHCJTsKUvkMV2Yudo+aKn/5
        gnXWMuv67z+nq6of/33V/XVmSnoOWz+j+YP7BSXuPnJXHhUp/PmUfDRO2Jozps/lebH0t/lc
        apaL7ncLSSVGTAhaznJrnuO1r4sP+Drc6nbfWVqsqbDyYqunytMN+3107r7h5nxz8MdGB+d7
        M3jsN1u495/7+/G42QoD8Yg526eWWgUcfD3t0u2bFcaHpvkG2lvefKSvxFKckWioxVxUnAgA
        +17PvFYEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrLLMWRmVeSWpSXmKPExsWy7bCSnG69ZkSCwYwlohaNb0+zWBx//Zfd
        4vfqXjaL1/+ms1icnrCIyWLl6qNMFtfuv2e3ePF/F7PFz//fGS327D3JYnF51xw2ix/T6y3e
        3gGq7e37xGrRekXLYvfGRWwWaz8/Zrd48+Iwm8WtifPZLM7/Pc7qIOIxq6GXzWN2w0UWj52z
        7rJ7bF6h5bF7wWcmj903G9g8Wnf8Zff4+PQWi0ffllWMHlsWP2TyWL/lKovH501yHpuevGUK
        4I3isklJzcksSy3St0vgyrh1agtrwbLnrBUtz+8xNzDuvcnSxcjJISFgIvHg7SumLkYuDiGB
        HYwSq/qnQSWkJY6dOMPcxcgBZAtLHD5cDFHzgVFi+ubVbCBxNgFtiT9bREHKRQTiJW423GYB
        qWEWeMUssWrtaSaQhLCAvsSu4z2MIDaLgKrE+21nmEB6eQWsJeY9cYBYJS+xesMBZhCbU8BG
        YtryTrAThIBKZrbeZ5rAyLeAkWEVo2RqQXFuem6xYYFRXmq5XnFibnFpXrpecn7uJkZwDGlp
        7WDcs+qD3iFGJg7GQ4wSHMxKIrwnkkMShHhTEiurUovy44tKc1KLDzFKc7AoifNe6DoZLySQ
        nliSmp2aWpBaBJNl4uCUamDasunJrtSojB9n1e6Yt57ccPZP2myJ7PIoaRv+QOGjm3K3y0XH
        VO2fMzPxkjmjtdN1Lfb8Lin5hUXlrX0vpj8zPpRyVZ9PUoJ9Fm+JtcaZ1M+HVkd2bQp77c3J
        8ulZdf/82d2+N8yjd0Vv27Xb8QaTqnFF7GZmo1LLdYIn726Wc//NVyOrYG57P+k0Ax//h0P7
        1NWm9JeqSnuKnflZ1Z+yyVL+/PXDG47HvumS73eYr3X6/5z50+9UzZ80KzTdwXfKT9V9h19s
        Ezqrk7ip9frmhIkWCkYzNA7s673V6bGbbX+zkEHow3nBFW1lC66l3r2ZnWjxbcMF05mPnQVe
        7Jspo+TdWJ4hv2rVvH8rTsopsRRnJBpqMRcVJwIAfXNCWRADAAA=
X-CMS-MailID: 20210322052207epcas1p3f0a5bdfd2c994a849a67b465479d0721
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210322052207epcas1p3f0a5bdfd2c994a849a67b465479d0721
References: <20210322051344.1706-1-namjae.jeon@samsung.com>
        <CGME20210322052207epcas1p3f0a5bdfd2c994a849a67b465479d0721@epcas1p3.samsung.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This adds file operations and buffer pool for cifsd.

Signed-off-by: Namjae Jeon <namjae.jeon@samsung.com>
Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Signed-off-by: Hyunchul Lee <hyc.lee@gmail.com>
Acked-by: Ronnie Sahlberg <lsahlber@redhat.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/cifsd/buffer_pool.c |  292 ++++++
 fs/cifsd/buffer_pool.h |   28 +
 fs/cifsd/vfs.c         | 1989 ++++++++++++++++++++++++++++++++++++++++
 fs/cifsd/vfs.h         |  314 +++++++
 fs/cifsd/vfs_cache.c   |  851 +++++++++++++++++
 fs/cifsd/vfs_cache.h   |  213 +++++
 6 files changed, 3687 insertions(+)
 create mode 100644 fs/cifsd/buffer_pool.c
 create mode 100644 fs/cifsd/buffer_pool.h
 create mode 100644 fs/cifsd/vfs.c
 create mode 100644 fs/cifsd/vfs.h
 create mode 100644 fs/cifsd/vfs_cache.c
 create mode 100644 fs/cifsd/vfs_cache.h

diff --git a/fs/cifsd/buffer_pool.c b/fs/cifsd/buffer_pool.c
new file mode 100644
index 000000000000..864fea547c68
--- /dev/null
+++ b/fs/cifsd/buffer_pool.c
@@ -0,0 +1,292 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ *   Copyright (C) 2018 Samsung Electronics Co., Ltd.
+ */
+
+#include <linux/kernel.h>
+#include <linux/wait.h>
+#include <linux/sched.h>
+#include <linux/mm.h>
+#include <linux/slab.h>
+#include <linux/vmalloc.h>
+#include <linux/rwlock.h>
+
+#include "glob.h"
+#include "buffer_pool.h"
+#include "connection.h"
+#include "mgmt/ksmbd_ida.h"
+
+static struct kmem_cache *filp_cache;
+
+struct wm {
+	struct list_head	list;
+	unsigned int		sz;
+	char			buffer[0];
+};
+
+struct wm_list {
+	struct list_head	list;
+	unsigned int		sz;
+
+	spinlock_t		wm_lock;
+	int			avail_wm;
+	struct list_head	idle_wm;
+	wait_queue_head_t	wm_wait;
+};
+
+static LIST_HEAD(wm_lists);
+static DEFINE_RWLOCK(wm_lists_lock);
+
+void *ksmbd_alloc(size_t size)
+{
+	return kvmalloc(size, GFP_KERNEL | __GFP_ZERO);
+}
+
+void ksmbd_free(void *ptr)
+{
+	kvfree(ptr);
+}
+
+static struct wm *wm_alloc(size_t sz, gfp_t flags)
+{
+	struct wm *wm;
+	size_t alloc_sz = sz + sizeof(struct wm);
+
+	wm = kvmalloc(alloc_sz, flags);
+	if (!wm)
+		return NULL;
+	wm->sz = sz;
+	return wm;
+}
+
+static int register_wm_size_class(size_t sz)
+{
+	struct wm_list *l, *nl;
+
+	nl = kvmalloc(sizeof(struct wm_list), GFP_KERNEL);
+	if (!nl)
+		return -ENOMEM;
+
+	nl->sz = sz;
+	spin_lock_init(&nl->wm_lock);
+	INIT_LIST_HEAD(&nl->idle_wm);
+	INIT_LIST_HEAD(&nl->list);
+	init_waitqueue_head(&nl->wm_wait);
+	nl->avail_wm = 0;
+
+	write_lock(&wm_lists_lock);
+	list_for_each_entry(l, &wm_lists, list) {
+		if (l->sz == sz) {
+			write_unlock(&wm_lists_lock);
+			kvfree(nl);
+			return 0;
+		}
+	}
+
+	list_add(&nl->list, &wm_lists);
+	write_unlock(&wm_lists_lock);
+	return 0;
+}
+
+static struct wm_list *match_wm_list(size_t size)
+{
+	struct wm_list *l, *rl = NULL;
+
+	read_lock(&wm_lists_lock);
+	list_for_each_entry(l, &wm_lists, list) {
+		if (l->sz == size) {
+			rl = l;
+			break;
+		}
+	}
+	read_unlock(&wm_lists_lock);
+	return rl;
+}
+
+static struct wm *find_wm(size_t size)
+{
+	struct wm_list *wm_list;
+	struct wm *wm;
+
+	wm_list = match_wm_list(size);
+	if (!wm_list) {
+		if (register_wm_size_class(size))
+			return NULL;
+		wm_list = match_wm_list(size);
+	}
+
+	if (!wm_list)
+		return NULL;
+
+	while (1) {
+		spin_lock(&wm_list->wm_lock);
+		if (!list_empty(&wm_list->idle_wm)) {
+			wm = list_entry(wm_list->idle_wm.next,
+					struct wm,
+					list);
+			list_del(&wm->list);
+			spin_unlock(&wm_list->wm_lock);
+			return wm;
+		}
+
+		if (wm_list->avail_wm > num_online_cpus()) {
+			spin_unlock(&wm_list->wm_lock);
+			wait_event(wm_list->wm_wait,
+				   !list_empty(&wm_list->idle_wm));
+			continue;
+		}
+
+		wm_list->avail_wm++;
+		spin_unlock(&wm_list->wm_lock);
+
+		wm = wm_alloc(size, GFP_KERNEL);
+		if (!wm) {
+			spin_lock(&wm_list->wm_lock);
+			wm_list->avail_wm--;
+			spin_unlock(&wm_list->wm_lock);
+			wait_event(wm_list->wm_wait,
+				   !list_empty(&wm_list->idle_wm));
+			continue;
+		}
+		break;
+	}
+
+	return wm;
+}
+
+static void release_wm(struct wm *wm, struct wm_list *wm_list)
+{
+	if (!wm)
+		return;
+
+	spin_lock(&wm_list->wm_lock);
+	if (wm_list->avail_wm <= num_online_cpus()) {
+		list_add(&wm->list, &wm_list->idle_wm);
+		spin_unlock(&wm_list->wm_lock);
+		wake_up(&wm_list->wm_wait);
+		return;
+	}
+
+	wm_list->avail_wm--;
+	spin_unlock(&wm_list->wm_lock);
+	ksmbd_free(wm);
+}
+
+static void wm_list_free(struct wm_list *l)
+{
+	struct wm *wm;
+
+	while (!list_empty(&l->idle_wm)) {
+		wm = list_entry(l->idle_wm.next, struct wm, list);
+		list_del(&wm->list);
+		kvfree(wm);
+	}
+	kvfree(l);
+}
+
+static void wm_lists_destroy(void)
+{
+	struct wm_list *l;
+
+	while (!list_empty(&wm_lists)) {
+		l = list_entry(wm_lists.next, struct wm_list, list);
+		list_del(&l->list);
+		wm_list_free(l);
+	}
+}
+
+void ksmbd_free_request(void *addr)
+{
+	kvfree(addr);
+}
+
+void *ksmbd_alloc_request(size_t size)
+{
+	return kvmalloc(size, GFP_KERNEL);
+}
+
+void ksmbd_free_response(void *buffer)
+{
+	kvfree(buffer);
+}
+
+void *ksmbd_alloc_response(size_t size)
+{
+	return kvmalloc(size, GFP_KERNEL | __GFP_ZERO);
+}
+
+void *ksmbd_find_buffer(size_t size)
+{
+	struct wm *wm;
+
+	wm = find_wm(size);
+
+	WARN_ON(!wm);
+	if (wm)
+		return wm->buffer;
+	return NULL;
+}
+
+void ksmbd_release_buffer(void *buffer)
+{
+	struct wm_list *wm_list;
+	struct wm *wm;
+
+	if (!buffer)
+		return;
+
+	wm = container_of(buffer, struct wm, buffer);
+	wm_list = match_wm_list(wm->sz);
+	WARN_ON(!wm_list);
+	if (wm_list)
+		release_wm(wm, wm_list);
+}
+
+void *ksmbd_realloc_response(void *ptr, size_t old_sz, size_t new_sz)
+{
+	size_t sz = min(old_sz, new_sz);
+	void *nptr;
+
+	nptr = ksmbd_alloc_response(new_sz);
+	if (!nptr)
+		return ptr;
+	memcpy(nptr, ptr, sz);
+	ksmbd_free_response(ptr);
+	return nptr;
+}
+
+void ksmbd_free_file_struct(void *filp)
+{
+	kmem_cache_free(filp_cache, filp);
+}
+
+void *ksmbd_alloc_file_struct(void)
+{
+	return kmem_cache_zalloc(filp_cache, GFP_KERNEL);
+}
+
+void ksmbd_destroy_buffer_pools(void)
+{
+	wm_lists_destroy();
+	ksmbd_work_pool_destroy();
+	kmem_cache_destroy(filp_cache);
+}
+
+int ksmbd_init_buffer_pools(void)
+{
+	if (ksmbd_work_pool_init())
+		goto out;
+
+	filp_cache = kmem_cache_create("ksmbd_file_cache",
+					sizeof(struct ksmbd_file), 0,
+					SLAB_HWCACHE_ALIGN, NULL);
+	if (!filp_cache)
+		goto out;
+
+	return 0;
+
+out:
+	ksmbd_err("failed to allocate memory\n");
+	ksmbd_destroy_buffer_pools();
+	return -ENOMEM;
+}
diff --git a/fs/cifsd/buffer_pool.h b/fs/cifsd/buffer_pool.h
new file mode 100644
index 000000000000..2b3d03afcf27
--- /dev/null
+++ b/fs/cifsd/buffer_pool.h
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ *   Copyright (C) 2018 Samsung Electronics Co., Ltd.
+ */
+
+#ifndef __KSMBD_BUFFER_POOL_H__
+#define __KSMBD_BUFFER_POOL_H__
+
+void *ksmbd_find_buffer(size_t size);
+void ksmbd_release_buffer(void *buffer);
+
+void *ksmbd_alloc(size_t size);
+void ksmbd_free(void *ptr);
+
+void ksmbd_free_request(void *addr);
+void *ksmbd_alloc_request(size_t size);
+void ksmbd_free_response(void *buffer);
+void *ksmbd_alloc_response(size_t size);
+
+void *ksmbd_realloc_response(void *ptr, size_t old_sz, size_t new_sz);
+
+void ksmbd_free_file_struct(void *filp);
+void *ksmbd_alloc_file_struct(void);
+
+void ksmbd_destroy_buffer_pools(void);
+int ksmbd_init_buffer_pools(void);
+
+#endif /* __KSMBD_BUFFER_POOL_H__ */
diff --git a/fs/cifsd/vfs.c b/fs/cifsd/vfs.c
new file mode 100644
index 000000000000..00f80ca45690
--- /dev/null
+++ b/fs/cifsd/vfs.c
@@ -0,0 +1,1989 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ *   Copyright (C) 2016 Namjae Jeon <linkinjeon@kernel.org>
+ *   Copyright (C) 2018 Samsung Electronics Co., Ltd.
+ */
+
+#include <linux/kernel.h>
+#include <linux/fs.h>
+#include <linux/uaccess.h>
+#include <linux/backing-dev.h>
+#include <linux/writeback.h>
+#include <linux/version.h>
+#include <linux/xattr.h>
+#include <linux/falloc.h>
+#include <linux/genhd.h>
+#include <linux/blkdev.h>
+#include <linux/fsnotify.h>
+#include <linux/dcache.h>
+#include <linux/slab.h>
+#include <linux/vmalloc.h>
+#include <linux/sched/xacct.h>
+#include <linux/crc32c.h>
+
+#include "glob.h"
+#include "oplock.h"
+#include "connection.h"
+#include "buffer_pool.h"
+#include "vfs.h"
+#include "vfs_cache.h"
+#include "smbacl.h"
+#include "ndr.h"
+#include "auth.h"
+
+#include "time_wrappers.h"
+#include "smb_common.h"
+#include "mgmt/share_config.h"
+#include "mgmt/tree_connect.h"
+#include "mgmt/user_session.h"
+#include "mgmt/user_config.h"
+
+static char *extract_last_component(char *path)
+{
+	char *p = strrchr(path, '/');
+
+	if (p && p[1] != '\0') {
+		*p = '\0';
+		p++;
+	} else {
+		p = NULL;
+		ksmbd_err("Invalid path %s\n", path);
+	}
+	return p;
+}
+
+static void rollback_path_modification(char *filename)
+{
+	if (filename) {
+		filename--;
+		*filename = '/';
+	}
+}
+
+static void ksmbd_vfs_inherit_owner(struct ksmbd_work *work,
+				    struct inode *parent_inode,
+				    struct inode *inode)
+{
+	if (!test_share_config_flag(work->tcon->share_conf,
+				   KSMBD_SHARE_FLAG_INHERIT_OWNER))
+		return;
+
+	i_uid_write(inode, i_uid_read(parent_inode));
+}
+
+static void ksmbd_vfs_inherit_smack(struct ksmbd_work *work,
+				    struct dentry *dir_dentry,
+				    struct dentry *dentry)
+{
+	char *name, *xattr_list = NULL, *smack_buf;
+	int value_len, xattr_list_len;
+
+	if (!test_share_config_flag(work->tcon->share_conf,
+				    KSMBD_SHARE_FLAG_INHERIT_SMACK))
+		return;
+
+	xattr_list_len = ksmbd_vfs_listxattr(dir_dentry, &xattr_list);
+	if (xattr_list_len < 0) {
+		goto out;
+	} else if (!xattr_list_len) {
+		ksmbd_err("no ea data in the file\n");
+		return;
+	}
+
+	for (name = xattr_list; name - xattr_list < xattr_list_len;
+			name += strlen(name) + 1) {
+		int rc;
+
+		ksmbd_debug(VFS, "%s, len %zd\n", name, strlen(name));
+		if (strcmp(name, XATTR_NAME_SMACK))
+			continue;
+
+		value_len = ksmbd_vfs_getxattr(dir_dentry, name, &smack_buf);
+		if (value_len <= 0)
+			continue;
+
+		rc = ksmbd_vfs_setxattr(dentry, XATTR_NAME_SMACK, smack_buf,
+					value_len, 0);
+		ksmbd_free(smack_buf);
+		if (rc < 0)
+			ksmbd_err("ksmbd_vfs_setxattr() failed: %d\n", rc);
+	}
+out:
+	ksmbd_vfs_xattr_free(xattr_list);
+}
+
+int ksmbd_vfs_inode_permission(struct dentry *dentry, int acc_mode, bool delete)
+{
+	int mask;
+
+	mask = 0;
+	acc_mode &= O_ACCMODE;
+
+	if (acc_mode == O_RDONLY)
+		mask = MAY_READ;
+	else if (acc_mode == O_WRONLY)
+		mask = MAY_WRITE;
+	else if (acc_mode == O_RDWR)
+		mask = MAY_READ | MAY_WRITE;
+
+	if (inode_permission(&init_user_ns, d_inode(dentry), mask | MAY_OPEN))
+		return -EACCES;
+
+	if (delete) {
+		struct dentry *parent;
+
+		parent = dget_parent(dentry);
+		if (!parent)
+			return -EINVAL;
+
+		if (inode_permission(&init_user_ns, d_inode(parent), MAY_EXEC | MAY_WRITE)) {
+			dput(parent);
+			return -EACCES;
+		}
+		dput(parent);
+	}
+	return 0;
+}
+
+int ksmbd_vfs_query_maximal_access(struct dentry *dentry, __le32 *daccess)
+{
+	struct dentry *parent;
+
+	*daccess = cpu_to_le32(FILE_READ_ATTRIBUTES | READ_CONTROL);
+
+	if (!inode_permission(&init_user_ns, d_inode(dentry), MAY_OPEN | MAY_WRITE))
+		*daccess |= cpu_to_le32(WRITE_DAC | WRITE_OWNER | SYNCHRONIZE |
+				FILE_WRITE_DATA | FILE_APPEND_DATA |
+				FILE_WRITE_EA | FILE_WRITE_ATTRIBUTES |
+				FILE_DELETE_CHILD);
+
+	if (!inode_permission(&init_user_ns, d_inode(dentry), MAY_OPEN | MAY_READ))
+		*daccess |= FILE_READ_DATA_LE | FILE_READ_EA_LE;
+
+	if (!inode_permission(&init_user_ns, d_inode(dentry), MAY_OPEN | MAY_EXEC))
+		*daccess |= FILE_EXECUTE_LE;
+
+	parent = dget_parent(dentry);
+	if (!parent)
+		return 0;
+
+	if (!inode_permission(&init_user_ns, d_inode(parent), MAY_EXEC | MAY_WRITE))
+		*daccess |= FILE_DELETE_LE;
+	dput(parent);
+	return 0;
+}
+
+
+/**
+ * ksmbd_vfs_create() - vfs helper for smb create file
+ * @work:	work
+ * @name:	file name
+ * @mode:	file create mode
+ *
+ * Return:	0 on success, otherwise error
+ */
+int ksmbd_vfs_create(struct ksmbd_work *work,
+		     const char *name,
+		     umode_t mode)
+{
+	struct path path;
+	struct dentry *dentry;
+	int err;
+
+	dentry = kern_path_create(AT_FDCWD, name, &path, 0);
+	if (IS_ERR(dentry)) {
+		err = PTR_ERR(dentry);
+		if (err != -ENOENT)
+			ksmbd_err("path create failed for %s, err %d\n",
+				name, err);
+		return err;
+	}
+
+	mode |= S_IFREG;
+	err = vfs_create(&init_user_ns, d_inode(path.dentry), dentry, mode, true);
+	if (!err) {
+		ksmbd_vfs_inherit_owner(work, d_inode(path.dentry),
+			d_inode(dentry));
+		ksmbd_vfs_inherit_smack(work, path.dentry, dentry);
+	} else {
+		ksmbd_err("File(%s): creation failed (err:%d)\n", name, err);
+	}
+	done_path_create(&path, dentry);
+	return err;
+}
+
+/**
+ * ksmbd_vfs_mkdir() - vfs helper for smb create directory
+ * @work:	work
+ * @name:	directory name
+ * @mode:	directory create mode
+ *
+ * Return:	0 on success, otherwise error
+ */
+int ksmbd_vfs_mkdir(struct ksmbd_work *work,
+		    const char *name,
+		    umode_t mode)
+{
+	struct path path;
+	struct dentry *dentry;
+	int err;
+
+	dentry = kern_path_create(AT_FDCWD, name, &path, LOOKUP_DIRECTORY);
+	if (IS_ERR(dentry)) {
+		err = PTR_ERR(dentry);
+		if (err != -EEXIST)
+			ksmbd_debug(VFS, "path create failed for %s, err %d\n",
+					name, err);
+		return err;
+	}
+
+	mode |= S_IFDIR;
+	err = vfs_mkdir(&init_user_ns, d_inode(path.dentry), dentry, mode);
+	if (!err) {
+		ksmbd_vfs_inherit_owner(work, d_inode(path.dentry),
+			d_inode(dentry));
+		ksmbd_vfs_inherit_smack(work, path.dentry, dentry);
+	} else
+		ksmbd_err("mkdir(%s): creation failed (err:%d)\n", name, err);
+
+	done_path_create(&path, dentry);
+	return err;
+}
+
+static ssize_t ksmbd_vfs_getcasexattr(struct dentry *dentry,
+				      char *attr_name,
+				      int attr_name_len,
+				      char **attr_value)
+{
+	char *name, *xattr_list = NULL;
+	ssize_t value_len = -ENOENT, xattr_list_len;
+
+	xattr_list_len = ksmbd_vfs_listxattr(dentry, &xattr_list);
+	if (xattr_list_len <= 0)
+		goto out;
+
+	for (name = xattr_list; name - xattr_list < xattr_list_len;
+			name += strlen(name) + 1) {
+		ksmbd_debug(VFS, "%s, len %zd\n", name, strlen(name));
+		if (strncasecmp(attr_name, name, attr_name_len))
+			continue;
+
+		value_len = ksmbd_vfs_getxattr(dentry,
+					       name,
+					       attr_value);
+		if (value_len < 0)
+			ksmbd_err("failed to get xattr in file\n");
+		break;
+	}
+
+out:
+	ksmbd_vfs_xattr_free(xattr_list);
+	return value_len;
+}
+
+static int ksmbd_vfs_stream_read(struct ksmbd_file *fp, char *buf, loff_t *pos,
+	size_t count)
+{
+	ssize_t v_len;
+	char *stream_buf = NULL;
+	int err;
+
+	ksmbd_debug(VFS, "read stream data pos : %llu, count : %zd\n",
+			*pos, count);
+
+	v_len = ksmbd_vfs_getcasexattr(fp->filp->f_path.dentry,
+				       fp->stream.name,
+				       fp->stream.size,
+				       &stream_buf);
+	if (v_len == -ENOENT) {
+		ksmbd_err("not found stream in xattr : %zd\n", v_len);
+		err = -ENOENT;
+		return err;
+	}
+
+	memcpy(buf, &stream_buf[*pos], count);
+	return v_len > count ? count : v_len;
+}
+
+/**
+ * check_lock_range() - vfs helper for smb byte range file locking
+ * @filp:	the file to apply the lock to
+ * @start:	lock start byte offset
+ * @end:	lock end byte offset
+ * @type:	byte range type read/write
+ *
+ * Return:	0 on success, otherwise error
+ */
+static int check_lock_range(struct file *filp,
+			    loff_t start,
+			    loff_t end,
+			    unsigned char type)
+{
+	struct file_lock *flock;
+	struct file_lock_context *ctx = file_inode(filp)->i_flctx;
+	int error = 0;
+
+	if (!ctx || list_empty_careful(&ctx->flc_posix))
+		return 0;
+
+	spin_lock(&ctx->flc_lock);
+	list_for_each_entry(flock, &ctx->flc_posix, fl_list) {
+		/* check conflict locks */
+		if (flock->fl_end >= start && end >= flock->fl_start) {
+			if (flock->fl_type == F_RDLCK) {
+				if (type == WRITE) {
+					ksmbd_err("not allow write by shared lock\n");
+					error = 1;
+					goto out;
+				}
+			} else if (flock->fl_type == F_WRLCK) {
+				/* check owner in lock */
+				if (flock->fl_file != filp) {
+					error = 1;
+					ksmbd_err("not allow rw access by exclusive lock from other opens\n");
+					goto out;
+				}
+			}
+		}
+	}
+out:
+	spin_unlock(&ctx->flc_lock);
+	return error;
+}
+
+/**
+ * ksmbd_vfs_read() - vfs helper for smb file read
+ * @work:	smb work
+ * @fid:	file id of open file
+ * @count:	read byte count
+ * @pos:	file pos
+ *
+ * Return:	number of read bytes on success, otherwise error
+ */
+int ksmbd_vfs_read(struct ksmbd_work *work,
+		 struct ksmbd_file *fp,
+		 size_t count,
+		 loff_t *pos)
+{
+	struct file *filp;
+	ssize_t nbytes = 0;
+	char *rbuf, *name;
+	struct inode *inode;
+	char namebuf[NAME_MAX];
+	int ret;
+
+	rbuf = AUX_PAYLOAD(work);
+	filp = fp->filp;
+	inode = d_inode(filp->f_path.dentry);
+	if (S_ISDIR(inode->i_mode))
+		return -EISDIR;
+
+	if (unlikely(count == 0))
+		return 0;
+
+	if (work->conn->connection_type) {
+		if (!(fp->daccess & (FILE_READ_DATA_LE | FILE_EXECUTE_LE))) {
+			ksmbd_err("no right to read(%s)\n", FP_FILENAME(fp));
+			return -EACCES;
+		}
+	}
+
+	if (ksmbd_stream_fd(fp))
+		return ksmbd_vfs_stream_read(fp, rbuf, pos, count);
+
+	ret = check_lock_range(filp, *pos, *pos + count - 1,
+			READ);
+	if (ret) {
+		ksmbd_err("unable to read due to lock\n");
+		return -EAGAIN;
+	}
+
+	nbytes = kernel_read(filp, rbuf, count, pos);
+	if (nbytes < 0) {
+		name = d_path(&filp->f_path, namebuf, sizeof(namebuf));
+		if (IS_ERR(name))
+			name = "(error)";
+		ksmbd_err("smb read failed for (%s), err = %zd\n",
+				name, nbytes);
+		return nbytes;
+	}
+
+	filp->f_pos = *pos;
+	return nbytes;
+}
+
+static int ksmbd_vfs_stream_write(struct ksmbd_file *fp, char *buf, loff_t *pos,
+	size_t count)
+{
+	char *stream_buf = NULL, *wbuf;
+	size_t size, v_len;
+	int err = 0;
+
+	ksmbd_debug(VFS, "write stream data pos : %llu, count : %zd\n",
+			*pos, count);
+
+	size = *pos + count;
+	if (size > XATTR_SIZE_MAX) {
+		size = XATTR_SIZE_MAX;
+		count = (*pos + count) - XATTR_SIZE_MAX;
+	}
+
+	v_len = ksmbd_vfs_getcasexattr(fp->filp->f_path.dentry,
+				       fp->stream.name,
+				       fp->stream.size,
+				       &stream_buf);
+	if (v_len == -ENOENT) {
+		ksmbd_err("not found stream in xattr : %zd\n", v_len);
+		err = -ENOENT;
+		goto out;
+	}
+
+	if (v_len < size) {
+		wbuf = ksmbd_alloc(size);
+		if (!wbuf) {
+			err = -ENOMEM;
+			goto out;
+		}
+
+		if (v_len > 0)
+			memcpy(wbuf, stream_buf, v_len);
+		stream_buf = wbuf;
+	}
+
+	memcpy(&stream_buf[*pos], buf, count);
+
+	err = ksmbd_vfs_setxattr(fp->filp->f_path.dentry,
+				 fp->stream.name,
+				 (void *)stream_buf,
+				 size,
+				 0);
+	if (err < 0)
+		goto out;
+
+	fp->filp->f_pos = *pos;
+	err = 0;
+out:
+	ksmbd_free(stream_buf);
+	return err;
+}
+
+/**
+ * ksmbd_vfs_write() - vfs helper for smb file write
+ * @work:	work
+ * @fid:	file id of open file
+ * @buf:	buf containing data for writing
+ * @count:	read byte count
+ * @pos:	file pos
+ * @sync:	fsync after write
+ * @written:	number of bytes written
+ *
+ * Return:	0 on success, otherwise error
+ */
+int ksmbd_vfs_write(struct ksmbd_work *work, struct ksmbd_file *fp,
+	char *buf, size_t count, loff_t *pos, bool sync, ssize_t *written)
+{
+	struct ksmbd_session *sess = work->sess;
+	struct file *filp;
+	loff_t	offset = *pos;
+	int err = 0;
+
+	if (sess->conn->connection_type) {
+		if (!(fp->daccess & FILE_WRITE_DATA_LE)) {
+			ksmbd_err("no right to write(%s)\n", FP_FILENAME(fp));
+			err = -EACCES;
+			goto out;
+		}
+	}
+
+	filp = fp->filp;
+
+	if (ksmbd_stream_fd(fp)) {
+		err = ksmbd_vfs_stream_write(fp, buf, pos, count);
+		if (!err)
+			*written = count;
+		goto out;
+	}
+
+	err = check_lock_range(filp, *pos, *pos + count - 1, WRITE);
+	if (err) {
+		ksmbd_err("unable to write due to lock\n");
+		err = -EAGAIN;
+		goto out;
+	}
+
+	/* Do we need to break any of a levelII oplock? */
+	smb_break_all_levII_oplock(work, fp, 1);
+
+	err = kernel_write(filp, buf, count, pos);
+	if (err < 0) {
+		ksmbd_debug(VFS, "smb write failed, err = %d\n", err);
+		goto out;
+	}
+
+	filp->f_pos = *pos;
+	*written = err;
+	err = 0;
+	if (sync) {
+		err = vfs_fsync_range(filp, offset, offset + *written, 0);
+		if (err < 0)
+			ksmbd_err("fsync failed for filename = %s, err = %d\n",
+					FP_FILENAME(fp), err);
+	}
+
+out:
+	return err;
+}
+
+/**
+ * ksmbd_vfs_getattr() - vfs helper for smb getattr
+ * @work:	work
+ * @fid:	file id of open file
+ * @attrs:	inode attributes
+ *
+ * Return:	0 on success, otherwise error
+ */
+int ksmbd_vfs_getattr(struct path *path, struct kstat *stat)
+{
+	int err;
+
+	err = vfs_getattr(path, stat, STATX_BTIME, AT_STATX_SYNC_AS_STAT);
+	if (err)
+		ksmbd_err("getattr failed, err %d\n", err);
+	return err;
+}
+
+/**
+ * ksmbd_vfs_fsync() - vfs helper for smb fsync
+ * @work:	work
+ * @fid:	file id of open file
+ *
+ * Return:	0 on success, otherwise error
+ */
+int ksmbd_vfs_fsync(struct ksmbd_work *work, uint64_t fid, uint64_t p_id)
+{
+	struct ksmbd_file *fp;
+	int err;
+
+	fp = ksmbd_lookup_fd_slow(work, fid, p_id);
+	if (!fp) {
+		ksmbd_err("failed to get filp for fid %llu\n", fid);
+		return -ENOENT;
+	}
+	err = vfs_fsync(fp->filp, 0);
+	if (err < 0)
+		ksmbd_err("smb fsync failed, err = %d\n", err);
+	ksmbd_fd_put(work, fp);
+	return err;
+}
+
+/**
+ * ksmbd_vfs_remove_file() - vfs helper for smb rmdir or unlink
+ * @name:	absolute directory or file name
+ *
+ * Return:	0 on success, otherwise error
+ */
+int ksmbd_vfs_remove_file(struct ksmbd_work *work, char *name)
+{
+	struct path parent;
+	struct dentry *dir, *dentry;
+	char *last;
+	int err = -ENOENT;
+
+	last = extract_last_component(name);
+	if (!last)
+		return -ENOENT;
+
+	if (ksmbd_override_fsids(work))
+		return -ENOMEM;
+
+	err = kern_path(name, LOOKUP_FOLLOW | LOOKUP_DIRECTORY, &parent);
+	if (err) {
+		ksmbd_debug(VFS, "can't get %s, err %d\n", name, err);
+		ksmbd_revert_fsids(work);
+		rollback_path_modification(last);
+		return err;
+	}
+
+	dir = parent.dentry;
+	if (!d_inode(dir))
+		goto out;
+
+	inode_lock_nested(d_inode(dir), I_MUTEX_PARENT);
+	dentry = lookup_one_len(last, dir, strlen(last));
+	if (IS_ERR(dentry)) {
+		err = PTR_ERR(dentry);
+		ksmbd_debug(VFS, "%s: lookup failed, err %d\n", last, err);
+		goto out_err;
+	}
+
+	if (!d_inode(dentry) || !d_inode(dentry)->i_nlink) {
+		dput(dentry);
+		err = -ENOENT;
+		goto out_err;
+	}
+
+	if (S_ISDIR(d_inode(dentry)->i_mode)) {
+		err = vfs_rmdir(&init_user_ns, d_inode(dir), dentry);
+		if (err && err != -ENOTEMPTY)
+			ksmbd_debug(VFS, "%s: rmdir failed, err %d\n", name,
+				err);
+	} else {
+		err = vfs_unlink(&init_user_ns, d_inode(dir), dentry, NULL);
+		if (err)
+			ksmbd_debug(VFS, "%s: unlink failed, err %d\n", name,
+				err);
+	}
+
+	dput(dentry);
+out_err:
+	inode_unlock(d_inode(dir));
+out:
+	rollback_path_modification(last);
+	path_put(&parent);
+	ksmbd_revert_fsids(work);
+	return err;
+}
+
+/**
+ * ksmbd_vfs_link() - vfs helper for creating smb hardlink
+ * @oldname:	source file name
+ * @newname:	hardlink name
+ *
+ * Return:	0 on success, otherwise error
+ */
+int ksmbd_vfs_link(struct ksmbd_work *work,
+		const char *oldname, const char *newname)
+{
+	struct path oldpath, newpath;
+	struct dentry *dentry;
+	int err;
+
+	if (ksmbd_override_fsids(work))
+		return -ENOMEM;
+
+	err = kern_path(oldname, LOOKUP_FOLLOW, &oldpath);
+	if (err) {
+		ksmbd_err("cannot get linux path for %s, err = %d\n",
+				oldname, err);
+		goto out1;
+	}
+
+	dentry = kern_path_create(AT_FDCWD, newname, &newpath,
+			LOOKUP_FOLLOW | LOOKUP_REVAL);
+	if (IS_ERR(dentry)) {
+		err = PTR_ERR(dentry);
+		ksmbd_err("path create err for %s, err %d\n", newname, err);
+		goto out2;
+	}
+
+	err = -EXDEV;
+	if (oldpath.mnt != newpath.mnt) {
+		ksmbd_err("vfs_link failed err %d\n", err);
+		goto out3;
+	}
+
+	err = vfs_link(oldpath.dentry, &init_user_ns, d_inode(newpath.dentry),
+			dentry, NULL);
+	if (err)
+		ksmbd_debug(VFS, "vfs_link failed err %d\n", err);
+
+out3:
+	done_path_create(&newpath, dentry);
+out2:
+	path_put(&oldpath);
+out1:
+	ksmbd_revert_fsids(work);
+	return err;
+}
+
+static int __ksmbd_vfs_rename(struct ksmbd_work *work,
+			      struct dentry *src_dent_parent,
+			      struct dentry *src_dent,
+			      struct dentry *dst_dent_parent,
+			      struct dentry *trap_dent,
+			      char *dst_name)
+{
+	struct dentry *dst_dent;
+	int err;
+
+	spin_lock(&src_dent->d_lock);
+	list_for_each_entry(dst_dent, &src_dent->d_subdirs, d_child) {
+		struct ksmbd_file *child_fp;
+
+		if (d_really_is_negative(dst_dent))
+			continue;
+
+		child_fp = ksmbd_lookup_fd_inode(d_inode(dst_dent));
+		if (child_fp) {
+			spin_unlock(&src_dent->d_lock);
+			ksmbd_debug(VFS, "Forbid rename, sub file/dir is in use\n");
+			return -EACCES;
+		}
+	}
+	spin_unlock(&src_dent->d_lock);
+
+	if (d_really_is_negative(src_dent_parent))
+		return -ENOENT;
+	if (d_really_is_negative(dst_dent_parent))
+		return -ENOENT;
+	if (d_really_is_negative(src_dent))
+		return -ENOENT;
+	if (src_dent == trap_dent)
+		return -EINVAL;
+
+	if (ksmbd_override_fsids(work))
+		return -ENOMEM;
+
+	dst_dent = lookup_one_len(dst_name, dst_dent_parent, strlen(dst_name));
+	err = PTR_ERR(dst_dent);
+	if (IS_ERR(dst_dent)) {
+		ksmbd_err("lookup failed %s [%d]\n", dst_name, err);
+		goto out;
+	}
+
+	err = -ENOTEMPTY;
+	if (dst_dent != trap_dent && !d_really_is_positive(dst_dent)) {
+		struct renamedata rd = {
+			.old_mnt_userns	= &init_user_ns,
+			.old_dir	= d_inode(src_dent_parent),
+			.old_dentry	= src_dent,
+			.new_mnt_userns	= &init_user_ns,
+			.new_dir	= d_inode(dst_dent_parent),
+			.new_dentry	= dst_dent,
+		};
+		err = vfs_rename(&rd);
+	}
+	if (err)
+		ksmbd_err("vfs_rename failed err %d\n", err);
+	if (dst_dent)
+		dput(dst_dent);
+out:
+	ksmbd_revert_fsids(work);
+	return err;
+}
+
+int ksmbd_vfs_fp_rename(struct ksmbd_work *work, struct ksmbd_file *fp,
+		char *newname)
+{
+	struct path dst_path;
+	struct dentry *src_dent_parent, *dst_dent_parent;
+	struct dentry *src_dent, *trap_dent;
+	char *dst_name;
+	int err;
+
+	dst_name = extract_last_component(newname);
+	if (!dst_name)
+		return -EINVAL;
+
+	src_dent_parent = dget_parent(fp->filp->f_path.dentry);
+	if (!src_dent_parent)
+		return -EINVAL;
+
+	src_dent = fp->filp->f_path.dentry;
+	dget(src_dent);
+
+	err = kern_path(newname, LOOKUP_FOLLOW | LOOKUP_DIRECTORY, &dst_path);
+	if (err) {
+		ksmbd_debug(VFS, "Cannot get path for %s [%d]\n", newname, err);
+		goto out;
+	}
+	dst_dent_parent = dst_path.dentry;
+	dget(dst_dent_parent);
+
+	trap_dent = lock_rename(src_dent_parent, dst_dent_parent);
+	err = __ksmbd_vfs_rename(work,
+				 src_dent_parent,
+				 src_dent,
+				 dst_dent_parent,
+				 trap_dent,
+				 dst_name);
+	unlock_rename(src_dent_parent, dst_dent_parent);
+	dput(dst_dent_parent);
+	path_put(&dst_path);
+out:
+	dput(src_dent);
+	dput(src_dent_parent);
+	return err;
+}
+
+/**
+ * ksmbd_vfs_truncate() - vfs helper for smb file truncate
+ * @work:	work
+ * @name:	old filename
+ * @fid:	file id of old file
+ * @size:	truncate to given size
+ *
+ * Return:	0 on success, otherwise error
+ */
+int ksmbd_vfs_truncate(struct ksmbd_work *work, const char *name,
+	struct ksmbd_file *fp, loff_t size)
+{
+	struct path path;
+	int err = 0;
+	struct inode *inode;
+
+	if (name) {
+		err = kern_path(name, 0, &path);
+		if (err) {
+			ksmbd_err("cannot get linux path for %s, err %d\n",
+					name, err);
+			return err;
+		}
+		err = vfs_truncate(&path, size);
+		if (err)
+			ksmbd_err("truncate failed for %s err %d\n",
+					name, err);
+		path_put(&path);
+	} else {
+		struct file *filp;
+
+		filp = fp->filp;
+
+		/* Do we need to break any of a levelII oplock? */
+		smb_break_all_levII_oplock(work, fp, 1);
+
+		inode = file_inode(filp);
+		if (size < inode->i_size) {
+			err = check_lock_range(filp, size,
+					inode->i_size - 1, WRITE);
+		} else {
+			err = check_lock_range(filp, inode->i_size,
+					size - 1, WRITE);
+		}
+
+		if (err) {
+			ksmbd_err("failed due to lock\n");
+			return -EAGAIN;
+		}
+
+		err = vfs_truncate(&filp->f_path, size);
+		if (err)
+			ksmbd_err("truncate failed for filename : %s err %d\n",
+					fp->filename, err);
+	}
+
+	return err;
+}
+
+/**
+ * ksmbd_vfs_listxattr() - vfs helper for smb list extended attributes
+ * @dentry:	dentry of file for listing xattrs
+ * @list:	destination buffer
+ * @size:	destination buffer length
+ *
+ * Return:	xattr list length on success, otherwise error
+ */
+ssize_t ksmbd_vfs_listxattr(struct dentry *dentry, char **list)
+{
+	ssize_t size;
+	char *vlist = NULL;
+
+	size = vfs_listxattr(dentry, NULL, 0);
+	if (size <= 0)
+		return size;
+
+	vlist = ksmbd_alloc(size);
+	if (!vlist)
+		return -ENOMEM;
+
+	*list = vlist;
+	size = vfs_listxattr(dentry, vlist, size);
+	if (size < 0) {
+		ksmbd_debug(VFS, "listxattr failed\n");
+		ksmbd_vfs_xattr_free(vlist);
+		*list = NULL;
+	}
+
+	return size;
+}
+
+static ssize_t ksmbd_vfs_xattr_len(struct dentry *dentry,
+			   char *xattr_name)
+{
+	return vfs_getxattr(&init_user_ns, dentry, xattr_name, NULL, 0);
+}
+
+/**
+ * ksmbd_vfs_getxattr() - vfs helper for smb get extended attributes value
+ * @dentry:	dentry of file for getting xattrs
+ * @xattr_name:	name of xattr name to query
+ * @xattr_buf:	destination buffer xattr value
+ *
+ * Return:	read xattr value length on success, otherwise error
+ */
+ssize_t ksmbd_vfs_getxattr(struct dentry *dentry,
+			   char *xattr_name,
+			   char **xattr_buf)
+{
+	ssize_t xattr_len;
+	char *buf;
+
+	*xattr_buf = NULL;
+	xattr_len = ksmbd_vfs_xattr_len(dentry, xattr_name);
+	if (xattr_len < 0)
+		return xattr_len;
+
+	buf = kmalloc(xattr_len + 1, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	xattr_len = vfs_getxattr(&init_user_ns, dentry, xattr_name, (void *)buf,
+			xattr_len);
+	if (xattr_len > 0)
+		*xattr_buf = buf;
+	else
+		kfree(buf);
+	return xattr_len;
+}
+
+/**
+ * ksmbd_vfs_setxattr() - vfs helper for smb set extended attributes value
+ * @dentry:	dentry to set XATTR at
+ * @name:	xattr name for setxattr
+ * @value:	xattr value to set
+ * @size:	size of xattr value
+ * @flags:	destination buffer length
+ *
+ * Return:	0 on success, otherwise error
+ */
+int ksmbd_vfs_setxattr(struct dentry *dentry,
+		       const char *attr_name,
+		       const void *attr_value,
+		       size_t attr_size,
+		       int flags)
+{
+	int err;
+
+	err = vfs_setxattr(&init_user_ns, dentry,
+			   attr_name,
+			   attr_value,
+			   attr_size,
+			   flags);
+	if (err)
+		ksmbd_debug(VFS, "setxattr failed, err %d\n", err);
+	return err;
+}
+
+/**
+ * ksmbd_vfs_set_fadvise() - convert smb IO caching options to linux options
+ * @filp:	file pointer for IO
+ * @options:	smb IO options
+ */
+void ksmbd_vfs_set_fadvise(struct file *filp, __le32 option)
+{
+	struct address_space *mapping;
+
+	mapping = filp->f_mapping;
+
+	if (!option || !mapping)
+		return;
+
+	if (option & FILE_WRITE_THROUGH_LE)
+		filp->f_flags |= O_SYNC;
+	else if (option & FILE_SEQUENTIAL_ONLY_LE) {
+		filp->f_ra.ra_pages = inode_to_bdi(mapping->host)->ra_pages * 2;
+		spin_lock(&filp->f_lock);
+		filp->f_mode &= ~FMODE_RANDOM;
+		spin_unlock(&filp->f_lock);
+	} else if (option & FILE_RANDOM_ACCESS_LE) {
+		spin_lock(&filp->f_lock);
+		filp->f_mode |= FMODE_RANDOM;
+		spin_unlock(&filp->f_lock);
+	}
+}
+
+/**
+ * ksmbd_vfs_lock() - vfs helper for smb file locking
+ * @filp:	the file to apply the lock to
+ * @cmd:	type of locking operation (F_SETLK, F_GETLK, etc.)
+ * @flock:	The lock to be applied
+ *
+ * Return:	0 on success, otherwise error
+ */
+int ksmbd_vfs_lock(struct file *filp, int cmd,
+			struct file_lock *flock)
+{
+	ksmbd_debug(VFS, "calling vfs_lock_file\n");
+	return vfs_lock_file(filp, cmd, flock, NULL);
+}
+
+int ksmbd_vfs_readdir(struct file *file, struct ksmbd_readdir_data *rdata)
+{
+	return iterate_dir(file, &rdata->ctx);
+}
+
+int ksmbd_vfs_alloc_size(struct ksmbd_work *work,
+			 struct ksmbd_file *fp,
+			 loff_t len)
+{
+	smb_break_all_levII_oplock(work, fp, 1);
+	return vfs_fallocate(fp->filp, FALLOC_FL_KEEP_SIZE, 0, len);
+}
+
+int ksmbd_vfs_zero_data(struct ksmbd_work *work,
+			 struct ksmbd_file *fp,
+			 loff_t off,
+			 loff_t len)
+{
+	smb_break_all_levII_oplock(work, fp, 1);
+	if (fp->f_ci->m_fattr & ATTR_SPARSE_FILE_LE)
+		return vfs_fallocate(fp->filp,
+			FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE, off, len);
+
+	return vfs_fallocate(fp->filp, FALLOC_FL_ZERO_RANGE, off, len);
+}
+
+int ksmbd_vfs_fqar_lseek(struct ksmbd_file *fp, loff_t start, loff_t length,
+	struct file_allocated_range_buffer *ranges,
+	int in_count, int *out_count)
+{
+	struct file *f = fp->filp;
+	struct inode *inode = FP_INODE(fp);
+	loff_t maxbytes = (u64)inode->i_sb->s_maxbytes, end;
+	loff_t extent_start, extent_end;
+	int ret = 0;
+
+	if (start > maxbytes)
+		return -EFBIG;
+
+	if (!in_count)
+		return 0;
+
+	/*
+	 * Shrink request scope to what the fs can actually handle.
+	 */
+	if (length > maxbytes || (maxbytes - length) < start)
+		length = maxbytes - start;
+
+	if (start + length > inode->i_size)
+		length = inode->i_size - start;
+
+	*out_count = 0;
+	end = start + length;
+	while (start < end && *out_count < in_count) {
+		extent_start = f->f_op->llseek(f, start, SEEK_DATA);
+		if (extent_start < 0) {
+			if (extent_start != -ENXIO)
+				ret = (int)extent_start;
+			break;
+		}
+
+		if (extent_start >= end)
+			break;
+
+		extent_end = f->f_op->llseek(f, extent_start, SEEK_HOLE);
+		if (extent_end < 0) {
+			if (extent_end != -ENXIO)
+				ret = (int)extent_end;
+			break;
+		} else if (extent_start >= extent_end)
+			break;
+
+		ranges[*out_count].file_offset = cpu_to_le64(extent_start);
+		ranges[(*out_count)++].length =
+			cpu_to_le64(min(extent_end, end) - extent_start);
+
+		start = extent_end;
+	}
+
+	return ret;
+}
+
+int ksmbd_vfs_remove_xattr(struct dentry *dentry, char *attr_name)
+{
+	return vfs_removexattr(&init_user_ns, dentry, attr_name);
+}
+
+void ksmbd_vfs_xattr_free(char *xattr)
+{
+	ksmbd_free(xattr);
+}
+
+int ksmbd_vfs_unlink(struct dentry *dir, struct dentry *dentry)
+{
+	int err = 0;
+
+	dget(dentry);
+	inode_lock_nested(d_inode(dir), I_MUTEX_PARENT);
+	if (!d_inode(dentry) || !d_inode(dentry)->i_nlink) {
+		err = -ENOENT;
+		goto out;
+	}
+
+	if (S_ISDIR(d_inode(dentry)->i_mode))
+		err = vfs_rmdir(&init_user_ns, d_inode(dir), dentry);
+	else
+		err = vfs_unlink(&init_user_ns, d_inode(dir), dentry, NULL);
+
+out:
+	inode_unlock(d_inode(dir));
+	dput(dentry);
+	if (err)
+		ksmbd_debug(VFS, "failed to delete, err %d\n", err);
+
+	return err;
+}
+
+/*
+ * ksmbd_vfs_get_logical_sector_size() - get logical sector size from inode
+ * @inode: inode
+ *
+ * Return: logical sector size
+ */
+unsigned short ksmbd_vfs_logical_sector_size(struct inode *inode)
+{
+	struct request_queue *q;
+	unsigned short ret_val = 512;
+
+	if (!inode->i_sb->s_bdev)
+		return ret_val;
+
+	q = inode->i_sb->s_bdev->bd_disk->queue;
+
+	if (q && q->limits.logical_block_size)
+		ret_val = q->limits.logical_block_size;
+
+	return ret_val;
+}
+
+/*
+ * ksmbd_vfs_get_smb2_sector_size() - get fs sector sizes
+ * @inode: inode
+ * @fs_ss: fs sector size struct
+ */
+void ksmbd_vfs_smb2_sector_size(struct inode *inode,
+	struct ksmbd_fs_sector_size *fs_ss)
+{
+	struct request_queue *q;
+
+	fs_ss->logical_sector_size = 512;
+	fs_ss->physical_sector_size = 512;
+	fs_ss->optimal_io_size = 512;
+
+	if (!inode->i_sb->s_bdev)
+		return;
+
+	q = inode->i_sb->s_bdev->bd_disk->queue;
+
+	if (q) {
+		if (q->limits.logical_block_size)
+			fs_ss->logical_sector_size =
+				q->limits.logical_block_size;
+		if (q->limits.physical_block_size)
+			fs_ss->physical_sector_size =
+				q->limits.physical_block_size;
+		if (q->limits.io_opt)
+			fs_ss->optimal_io_size = q->limits.io_opt;
+	}
+}
+
+static int __dir_empty(struct dir_context *ctx,
+				   const char *name,
+				   int namlen,
+				   loff_t offset,
+				   u64 ino,
+				   unsigned int d_type)
+{
+	struct ksmbd_readdir_data *buf;
+
+	buf = container_of(ctx, struct ksmbd_readdir_data, ctx);
+	buf->dirent_count++;
+
+	if (buf->dirent_count > 2)
+		return -ENOTEMPTY;
+	return 0;
+}
+
+/**
+ * ksmbd_vfs_empty_dir() - check for empty directory
+ * @fp:	ksmbd file pointer
+ *
+ * Return:	true if directory empty, otherwise false
+ */
+int ksmbd_vfs_empty_dir(struct ksmbd_file *fp)
+{
+	int err;
+	struct ksmbd_readdir_data readdir_data;
+
+	memset(&readdir_data, 0, sizeof(struct ksmbd_readdir_data));
+
+	set_ctx_actor(&readdir_data.ctx, __dir_empty);
+	readdir_data.dirent_count = 0;
+
+	err = ksmbd_vfs_readdir(fp->filp, &readdir_data);
+	if (readdir_data.dirent_count > 2)
+		err = -ENOTEMPTY;
+	else
+		err = 0;
+	return err;
+}
+
+static int __caseless_lookup(struct dir_context *ctx,
+			     const char *name,
+			     int namlen,
+			     loff_t offset,
+			     u64 ino,
+			     unsigned int d_type)
+{
+	struct ksmbd_readdir_data *buf;
+
+	buf = container_of(ctx, struct ksmbd_readdir_data, ctx);
+
+	if (buf->used != namlen)
+		return 0;
+	if (!strncasecmp((char *)buf->private, name, namlen)) {
+		memcpy((char *)buf->private, name, namlen);
+		buf->dirent_count = 1;
+		return -EEXIST;
+	}
+	return 0;
+}
+
+/**
+ * ksmbd_vfs_lookup_in_dir() - lookup a file in a directory
+ * @dirname:	directory name
+ * @filename:	filename to lookup
+ *
+ * Return:	0 on success, otherwise error
+ */
+static int ksmbd_vfs_lookup_in_dir(char *dirname, char *filename)
+{
+	struct path dir_path;
+	int ret;
+	struct file *dfilp;
+	int flags = O_RDONLY|O_LARGEFILE;
+	int dirnamelen = strlen(dirname);
+	struct ksmbd_readdir_data readdir_data = {
+		.ctx.actor	= __caseless_lookup,
+		.private	= filename,
+		.used		= strlen(filename),
+	};
+
+	ret = ksmbd_vfs_kern_path(dirname, 0, &dir_path, true);
+	if (ret)
+		goto error;
+
+	dfilp = dentry_open(&dir_path, flags, current_cred());
+	if (IS_ERR(dfilp)) {
+		path_put(&dir_path);
+		ksmbd_err("cannot open directory %s\n", dirname);
+		ret = -EINVAL;
+		goto error;
+	}
+
+	ret = ksmbd_vfs_readdir(dfilp, &readdir_data);
+	if (readdir_data.dirent_count > 0)
+		ret = 0;
+
+	fput(dfilp);
+	path_put(&dir_path);
+error:
+	dirname[dirnamelen] = '/';
+	return ret;
+}
+
+/**
+ * ksmbd_vfs_kern_path() - lookup a file and get path info
+ * @name:	name of file for lookup
+ * @flags:	lookup flags
+ * @path:	if lookup succeed, return path info
+ * @caseless:	caseless filename lookup
+ *
+ * Return:	0 on success, otherwise error
+ */
+int ksmbd_vfs_kern_path(char *name, unsigned int flags, struct path *path,
+		bool caseless)
+{
+	char *filename = NULL;
+	int err;
+
+	err = kern_path(name, flags, path);
+	if (!err)
+		return err;
+
+	if (caseless) {
+		filename = extract_last_component(name);
+		if (!filename)
+			goto out;
+
+		/* root reached */
+		if (strlen(name) == 0)
+			goto out;
+
+		err = ksmbd_vfs_lookup_in_dir(name, filename);
+		if (err)
+			goto out;
+		err = kern_path(name, flags, path);
+	}
+
+out:
+	rollback_path_modification(filename);
+	return err;
+}
+
+int ksmbd_vfs_remove_acl_xattrs(struct dentry *dentry)
+{
+	char *name, *xattr_list = NULL;
+	ssize_t xattr_list_len;
+	int err = 0;
+
+	xattr_list_len = ksmbd_vfs_listxattr(dentry, &xattr_list);
+	if (xattr_list_len < 0) {
+		goto out;
+	} else if (!xattr_list_len) {
+		ksmbd_debug(SMB, "empty xattr in the file\n");
+		goto out;
+	}
+
+	for (name = xattr_list; name - xattr_list < xattr_list_len;
+			name += strlen(name) + 1) {
+		ksmbd_debug(SMB, "%s, len %zd\n", name, strlen(name));
+
+		if (!strncmp(name, XATTR_NAME_POSIX_ACL_ACCESS,
+			     sizeof(XATTR_NAME_POSIX_ACL_ACCESS)-1) ||
+		    !strncmp(name, XATTR_NAME_POSIX_ACL_DEFAULT,
+			     sizeof(XATTR_NAME_POSIX_ACL_DEFAULT)-1)) {
+			err = ksmbd_vfs_remove_xattr(dentry, name);
+			if (err)
+				ksmbd_debug(SMB,
+					"remove acl xattr failed : %s\n", name);
+		}
+	}
+out:
+	ksmbd_vfs_xattr_free(xattr_list);
+	return err;
+}
+
+int ksmbd_vfs_remove_sd_xattrs(struct dentry *dentry)
+{
+	char *name, *xattr_list = NULL;
+	ssize_t xattr_list_len;
+	int err = 0;
+
+	xattr_list_len = ksmbd_vfs_listxattr(dentry, &xattr_list);
+	if (xattr_list_len < 0) {
+		goto out;
+	} else if (!xattr_list_len) {
+		ksmbd_debug(SMB, "empty xattr in the file\n");
+		goto out;
+	}
+
+	for (name = xattr_list; name - xattr_list < xattr_list_len;
+			name += strlen(name) + 1) {
+		ksmbd_debug(SMB, "%s, len %zd\n", name, strlen(name));
+
+		if (!strncmp(name, XATTR_NAME_SD, XATTR_NAME_SD_LEN)) {
+			err = ksmbd_vfs_remove_xattr(dentry, name);
+			if (err)
+				ksmbd_debug(SMB, "remove xattr failed : %s\n", name);
+		}
+	}
+out:
+	ksmbd_vfs_xattr_free(xattr_list);
+	return err;
+}
+
+static struct xattr_smb_acl *ksmbd_vfs_make_xattr_posix_acl(struct inode *inode,
+		int acl_type)
+{
+	struct xattr_smb_acl *smb_acl = NULL;
+	struct posix_acl *posix_acls;
+	struct posix_acl_entry *pa_entry;
+	struct xattr_acl_entry *xa_entry;
+	int i;
+
+	posix_acls = ksmbd_vfs_get_acl(inode, acl_type);
+	if (!posix_acls)
+		return NULL;
+
+	smb_acl = kzalloc(sizeof(struct xattr_smb_acl) +
+			  sizeof(struct xattr_acl_entry) * posix_acls->a_count,
+			  GFP_KERNEL);
+	if (!smb_acl)
+		goto out;
+
+	smb_acl->count = posix_acls->a_count;
+	pa_entry = posix_acls->a_entries;
+	xa_entry = smb_acl->entries;
+	for (i = 0; i < posix_acls->a_count; i++, pa_entry++, xa_entry++) {
+		switch (pa_entry->e_tag) {
+		case ACL_USER:
+			xa_entry->type = SMB_ACL_USER;
+			xa_entry->uid = from_kuid(&init_user_ns, pa_entry->e_uid);
+			break;
+		case ACL_USER_OBJ:
+			xa_entry->type = SMB_ACL_USER_OBJ;
+			break;
+		case ACL_GROUP:
+			xa_entry->type = SMB_ACL_GROUP;
+			xa_entry->gid = from_kgid(&init_user_ns, pa_entry->e_gid);
+			break;
+		case ACL_GROUP_OBJ:
+			xa_entry->type = SMB_ACL_GROUP_OBJ;
+			break;
+		case ACL_OTHER:
+			xa_entry->type = SMB_ACL_OTHER;
+			break;
+		case ACL_MASK:
+			xa_entry->type = SMB_ACL_MASK;
+			break;
+		default:
+			ksmbd_err("unknown type : 0x%x\n", pa_entry->e_tag);
+			goto out;
+		}
+
+		if (pa_entry->e_perm & ACL_READ)
+			xa_entry->perm |= SMB_ACL_READ;
+		if (pa_entry->e_perm & ACL_WRITE)
+			xa_entry->perm |= SMB_ACL_WRITE;
+		if (pa_entry->e_perm & ACL_EXECUTE)
+			xa_entry->perm |= SMB_ACL_EXECUTE;
+	}
+out:
+	posix_acl_release(posix_acls);
+	return smb_acl;
+}
+
+int ksmbd_vfs_set_sd_xattr(struct ksmbd_conn *conn, struct dentry *dentry,
+		struct smb_ntsd *pntsd, int len)
+{
+	int rc;
+	struct ndr sd_ndr = {0}, acl_ndr = {0};
+	struct xattr_ntacl acl = {0};
+	struct xattr_smb_acl *smb_acl, *def_smb_acl = NULL;
+	struct inode *inode = dentry->d_inode;
+
+	acl.version = 4;
+	acl.hash_type = XATTR_SD_HASH_TYPE_SHA256;
+	acl.current_time = ksmbd_UnixTimeToNT(current_time(dentry->d_inode));
+
+	memcpy(acl.desc, "posix_acl", 9);
+	acl.desc_len = 10;
+
+	pntsd->osidoffset =
+		cpu_to_le32(le32_to_cpu(pntsd->osidoffset) + NDR_NTSD_OFFSETOF);
+	pntsd->gsidoffset =
+		cpu_to_le32(le32_to_cpu(pntsd->gsidoffset) + NDR_NTSD_OFFSETOF);
+	pntsd->dacloffset =
+		cpu_to_le32(le32_to_cpu(pntsd->dacloffset) + NDR_NTSD_OFFSETOF);
+
+	acl.sd_buf = (char *)pntsd;
+	acl.sd_size = len;
+
+	rc = ksmbd_gen_sd_hash(conn, acl.sd_buf, acl.sd_size, acl.hash);
+	if (rc) {
+		ksmbd_err("failed to generate hash for ndr acl\n");
+		return rc;
+	}
+
+	smb_acl = ksmbd_vfs_make_xattr_posix_acl(dentry->d_inode, ACL_TYPE_ACCESS);
+	if (S_ISDIR(inode->i_mode))
+		def_smb_acl = ksmbd_vfs_make_xattr_posix_acl(dentry->d_inode,
+				ACL_TYPE_DEFAULT);
+
+	rc = ndr_encode_posix_acl(&acl_ndr, inode, smb_acl, def_smb_acl);
+	if (rc) {
+		ksmbd_err("failed to encode ndr to posix acl\n");
+		goto out;
+	}
+
+	rc = ksmbd_gen_sd_hash(conn, acl_ndr.data, acl_ndr.offset,
+			acl.posix_acl_hash);
+	if (rc) {
+		ksmbd_err("failed to generate hash for ndr acl\n");
+		goto out;
+	}
+
+	rc = ndr_encode_v4_ntacl(&sd_ndr, &acl);
+	if (rc) {
+		ksmbd_err("failed to encode ndr to posix acl\n");
+		goto out;
+	}
+
+	rc = ksmbd_vfs_setxattr(dentry, XATTR_NAME_SD, sd_ndr.data,
+			sd_ndr.offset, 0);
+	if (rc < 0)
+		ksmbd_err("Failed to store XATTR ntacl :%d\n", rc);
+
+	kfree(sd_ndr.data);
+out:
+	kfree(acl_ndr.data);
+	kfree(smb_acl);
+	kfree(def_smb_acl);
+	return rc;
+}
+
+int ksmbd_vfs_get_sd_xattr(struct ksmbd_conn *conn, struct dentry *dentry,
+		struct smb_ntsd **pntsd)
+{
+	int rc;
+	struct ndr n;
+
+	rc = ksmbd_vfs_getxattr(dentry, XATTR_NAME_SD, &n.data);
+	if (rc > 0) {
+		struct inode *inode = dentry->d_inode;
+		struct ndr acl_ndr = {0};
+		struct xattr_ntacl acl;
+		struct xattr_smb_acl *smb_acl = NULL, *def_smb_acl = NULL;
+		__u8 cmp_hash[XATTR_SD_HASH_SIZE] = {0};
+
+		n.length = rc;
+		rc = ndr_decode_v4_ntacl(&n, &acl);
+		if (rc)
+			return rc;
+
+		smb_acl = ksmbd_vfs_make_xattr_posix_acl(inode,
+				ACL_TYPE_ACCESS);
+		if (S_ISDIR(inode->i_mode))
+			def_smb_acl = ksmbd_vfs_make_xattr_posix_acl(inode,
+					ACL_TYPE_DEFAULT);
+
+		rc = ndr_encode_posix_acl(&acl_ndr, inode, smb_acl, def_smb_acl);
+		if (rc) {
+			ksmbd_err("failed to encode ndr to posix acl\n");
+			goto out;
+		}
+
+		rc = ksmbd_gen_sd_hash(conn, acl_ndr.data, acl_ndr.offset,
+				cmp_hash);
+		if (rc) {
+			ksmbd_err("failed to generate hash for ndr acl\n");
+			goto out;
+		}
+
+		if (memcmp(cmp_hash, acl.posix_acl_hash, XATTR_SD_HASH_SIZE)) {
+			ksmbd_err("hash value diff\n");
+			rc = -EINVAL;
+			goto out;
+		}
+
+		*pntsd = acl.sd_buf;
+		(*pntsd)->osidoffset =
+			cpu_to_le32(le32_to_cpu((*pntsd)->osidoffset) - NDR_NTSD_OFFSETOF);
+		(*pntsd)->gsidoffset =
+			cpu_to_le32(le32_to_cpu((*pntsd)->gsidoffset) - NDR_NTSD_OFFSETOF);
+		(*pntsd)->dacloffset =
+			cpu_to_le32(le32_to_cpu((*pntsd)->dacloffset) - NDR_NTSD_OFFSETOF);
+
+		rc = acl.sd_size;
+out:
+		kfree(n.data);
+		kfree(acl_ndr.data);
+		kfree(smb_acl);
+		kfree(def_smb_acl);
+	}
+
+	return rc;
+}
+
+int ksmbd_vfs_set_dos_attrib_xattr(struct dentry *dentry,
+		struct xattr_dos_attrib *da)
+{
+	struct ndr n;
+	int err;
+
+	err = ndr_encode_dos_attr(&n, da);
+	if (err)
+		return err;
+
+	err = ksmbd_vfs_setxattr(dentry,
+			XATTR_NAME_DOS_ATTRIBUTE,
+			(void *)n.data,
+			n.offset,
+			0);
+	if (err)
+		ksmbd_debug(SMB, "failed to store dos attribute in xattr\n");
+	kfree(n.data);
+
+	return err;
+}
+
+int ksmbd_vfs_get_dos_attrib_xattr(struct dentry *dentry,
+		struct xattr_dos_attrib *da)
+{
+	struct ndr n;
+	int err;
+
+	err = ksmbd_vfs_getxattr(dentry,
+			XATTR_NAME_DOS_ATTRIBUTE,
+			(char **)&n.data);
+	if (err > 0) {
+		n.length = err;
+		if (ndr_decode_dos_attr(&n, da))
+			err = -EINVAL;
+		ksmbd_free(n.data);
+	} else
+		ksmbd_debug(SMB, "failed to load dos attribute in xattr\n");
+
+	return err;
+}
+
+struct posix_acl *ksmbd_vfs_posix_acl_alloc(int count, gfp_t flags)
+{
+#if IS_ENABLED(CONFIG_FS_POSIX_ACL)
+	return posix_acl_alloc(count, flags);
+#else
+	return NULL;
+#endif
+}
+
+struct posix_acl *ksmbd_vfs_get_acl(struct inode *inode, int type)
+{
+#if IS_ENABLED(CONFIG_FS_POSIX_ACL)
+	return get_acl(inode, type);
+#else
+	return NULL;
+#endif
+}
+
+int ksmbd_vfs_set_posix_acl(struct inode *inode, int type,
+		struct posix_acl *acl)
+{
+#if IS_ENABLED(CONFIG_FS_POSIX_ACL)
+	return set_posix_acl(&init_user_ns, inode, type, acl);
+#else
+	return -EOPNOTSUPP;
+#endif
+}
+
+/**
+ * ksmbd_vfs_init_kstat() - convert unix stat information to smb stat format
+ * @p:          destination buffer
+ * @ksmbd_kstat:      ksmbd kstat wrapper
+ */
+void *ksmbd_vfs_init_kstat(char **p, struct ksmbd_kstat *ksmbd_kstat)
+{
+	struct file_directory_info *info = (struct file_directory_info *)(*p);
+	struct kstat *kstat = ksmbd_kstat->kstat;
+	u64 time;
+
+	info->FileIndex = 0;
+	info->CreationTime = cpu_to_le64(ksmbd_kstat->create_time);
+	time = ksmbd_UnixTimeToNT(kstat->atime);
+	info->LastAccessTime = cpu_to_le64(time);
+	time = ksmbd_UnixTimeToNT(kstat->mtime);
+	info->LastWriteTime = cpu_to_le64(time);
+	time = ksmbd_UnixTimeToNT(kstat->ctime);
+	info->ChangeTime = cpu_to_le64(time);
+
+	if (ksmbd_kstat->file_attributes & ATTR_DIRECTORY_LE) {
+		info->EndOfFile = 0;
+		info->AllocationSize = 0;
+	} else {
+		info->EndOfFile = cpu_to_le64(kstat->size);
+		info->AllocationSize = cpu_to_le64(kstat->blocks << 9);
+	}
+	info->ExtFileAttributes = ksmbd_kstat->file_attributes;
+
+	return info;
+}
+
+int ksmbd_vfs_fill_dentry_attrs(struct ksmbd_work *work,
+				struct dentry *dentry,
+				struct ksmbd_kstat *ksmbd_kstat)
+{
+	u64 time;
+	int rc;
+
+	generic_fillattr(&init_user_ns, d_inode(dentry), ksmbd_kstat->kstat);
+
+	time = ksmbd_UnixTimeToNT(ksmbd_kstat->kstat->ctime);
+	ksmbd_kstat->create_time = time;
+
+	/*
+	 * set default value for the case that store dos attributes is not yes
+	 * or that acl is disable in server's filesystem and the config is yes.
+	 */
+	if (S_ISDIR(ksmbd_kstat->kstat->mode))
+		ksmbd_kstat->file_attributes = ATTR_DIRECTORY_LE;
+	else
+		ksmbd_kstat->file_attributes = ATTR_ARCHIVE_LE;
+
+	if (test_share_config_flag(work->tcon->share_conf,
+	    KSMBD_SHARE_FLAG_STORE_DOS_ATTRS)) {
+		struct xattr_dos_attrib da;
+
+		rc = ksmbd_vfs_get_dos_attrib_xattr(dentry, &da);
+		if (rc > 0) {
+			ksmbd_kstat->file_attributes = cpu_to_le32(da.attr);
+			ksmbd_kstat->create_time = da.create_time;
+		} else
+			ksmbd_debug(VFS, "fail to load dos attribute.\n");
+	}
+
+	return 0;
+}
+
+ssize_t ksmbd_vfs_casexattr_len(struct dentry *dentry,
+				char *attr_name,
+				int attr_name_len)
+{
+	char *name, *xattr_list = NULL;
+	ssize_t value_len = -ENOENT, xattr_list_len;
+
+	xattr_list_len = ksmbd_vfs_listxattr(dentry, &xattr_list);
+	if (xattr_list_len <= 0)
+		goto out;
+
+	for (name = xattr_list; name - xattr_list < xattr_list_len;
+			name += strlen(name) + 1) {
+		ksmbd_debug(VFS, "%s, len %zd\n", name, strlen(name));
+		if (strncasecmp(attr_name, name, attr_name_len))
+			continue;
+
+		value_len = ksmbd_vfs_xattr_len(dentry, name);
+		break;
+	}
+
+out:
+	ksmbd_vfs_xattr_free(xattr_list);
+	return value_len;
+}
+
+int ksmbd_vfs_xattr_stream_name(char *stream_name,
+				char **xattr_stream_name,
+				size_t *xattr_stream_name_size,
+				int s_type)
+{
+	int stream_name_size;
+	char *xattr_stream_name_buf;
+	char *type;
+	int type_len;
+
+	if (s_type == DIR_STREAM)
+		type = ":$INDEX_ALLOCATION";
+	else
+		type = ":$DATA";
+
+	type_len = strlen(type);
+	stream_name_size = strlen(stream_name);
+	*xattr_stream_name_size = stream_name_size + XATTR_NAME_STREAM_LEN + 1;
+	xattr_stream_name_buf = kmalloc(*xattr_stream_name_size + type_len,
+			GFP_KERNEL);
+	if (!xattr_stream_name_buf)
+		return -ENOMEM;
+
+	memcpy(xattr_stream_name_buf,
+		XATTR_NAME_STREAM,
+		XATTR_NAME_STREAM_LEN);
+
+	if (stream_name_size) {
+		memcpy(&xattr_stream_name_buf[XATTR_NAME_STREAM_LEN],
+			stream_name,
+			stream_name_size);
+	}
+	memcpy(&xattr_stream_name_buf[*xattr_stream_name_size - 1], type, type_len);
+		*xattr_stream_name_size += type_len;
+
+	xattr_stream_name_buf[*xattr_stream_name_size - 1] = '\0';
+	*xattr_stream_name = xattr_stream_name_buf;
+
+	return 0;
+}
+
+static int ksmbd_vfs_copy_file_range(struct file *file_in, loff_t pos_in,
+				struct file *file_out, loff_t pos_out,
+				size_t len)
+{
+	struct inode *inode_in = file_inode(file_in);
+	struct inode *inode_out = file_inode(file_out);
+	int ret;
+
+	ret = vfs_copy_file_range(file_in, pos_in, file_out, pos_out, len, 0);
+	/* do splice for the copy between different file systems */
+	if (ret != -EXDEV)
+		return ret;
+
+	if (S_ISDIR(inode_in->i_mode) || S_ISDIR(inode_out->i_mode))
+		return -EISDIR;
+	if (!S_ISREG(inode_in->i_mode) || !S_ISREG(inode_out->i_mode))
+		return -EINVAL;
+
+	if (!(file_in->f_mode & FMODE_READ) ||
+	    !(file_out->f_mode & FMODE_WRITE))
+		return -EBADF;
+
+	if (len == 0)
+		return 0;
+
+	file_start_write(file_out);
+
+	/*
+	 * skip the verification of the range of data. it will be done
+	 * in do_splice_direct
+	 */
+	ret = do_splice_direct(file_in, &pos_in, file_out, &pos_out,
+			len > MAX_RW_COUNT ? MAX_RW_COUNT : len, 0);
+	if (ret > 0) {
+		fsnotify_access(file_in);
+		add_rchar(current, ret);
+		fsnotify_modify(file_out);
+		add_wchar(current, ret);
+	}
+
+	inc_syscr(current);
+	inc_syscw(current);
+
+	file_end_write(file_out);
+	return ret;
+}
+
+int ksmbd_vfs_copy_file_ranges(struct ksmbd_work *work,
+				struct ksmbd_file *src_fp,
+				struct ksmbd_file *dst_fp,
+				struct srv_copychunk *chunks,
+				unsigned int chunk_count,
+				unsigned int *chunk_count_written,
+				unsigned int *chunk_size_written,
+				loff_t *total_size_written)
+{
+	unsigned int i;
+	loff_t src_off, dst_off, src_file_size;
+	size_t len;
+	int ret;
+
+	*chunk_count_written = 0;
+	*chunk_size_written = 0;
+	*total_size_written = 0;
+
+	if (!(src_fp->daccess & (FILE_READ_DATA_LE | FILE_EXECUTE_LE))) {
+		ksmbd_err("no right to read(%s)\n", FP_FILENAME(src_fp));
+		return -EACCES;
+	}
+	if (!(dst_fp->daccess & (FILE_WRITE_DATA_LE | FILE_APPEND_DATA_LE))) {
+		ksmbd_err("no right to write(%s)\n", FP_FILENAME(dst_fp));
+		return -EACCES;
+	}
+
+	if (ksmbd_stream_fd(src_fp) || ksmbd_stream_fd(dst_fp))
+		return -EBADF;
+
+	smb_break_all_levII_oplock(work, dst_fp, 1);
+
+	for (i = 0; i < chunk_count; i++) {
+		src_off = le64_to_cpu(chunks[i].SourceOffset);
+		dst_off = le64_to_cpu(chunks[i].TargetOffset);
+		len = le32_to_cpu(chunks[i].Length);
+
+		if (check_lock_range(src_fp->filp, src_off,
+				src_off + len - 1, READ))
+			return -EAGAIN;
+		if (check_lock_range(dst_fp->filp, dst_off,
+				dst_off + len - 1, WRITE))
+			return -EAGAIN;
+	}
+
+	src_file_size = i_size_read(file_inode(src_fp->filp));
+
+	for (i = 0; i < chunk_count; i++) {
+		src_off = le64_to_cpu(chunks[i].SourceOffset);
+		dst_off = le64_to_cpu(chunks[i].TargetOffset);
+		len = le32_to_cpu(chunks[i].Length);
+
+		if (src_off + len > src_file_size)
+			return -E2BIG;
+
+		ret = ksmbd_vfs_copy_file_range(src_fp->filp, src_off,
+				dst_fp->filp, dst_off, len);
+		if (ret < 0)
+			return ret;
+
+		*chunk_count_written += 1;
+		*total_size_written += ret;
+	}
+	return 0;
+}
+
+int ksmbd_vfs_posix_lock_wait(struct file_lock *flock)
+{
+	return wait_event_interruptible(flock->fl_wait, !flock->fl_blocker);
+}
+
+int ksmbd_vfs_posix_lock_wait_timeout(struct file_lock *flock, long timeout)
+{
+	return wait_event_interruptible_timeout(flock->fl_wait,
+						!flock->fl_blocker,
+						timeout);
+}
+
+void ksmbd_vfs_posix_lock_unblock(struct file_lock *flock)
+{
+	locks_delete_block(flock);
+}
+
+int ksmbd_vfs_set_init_posix_acl(struct inode *inode)
+{
+	struct posix_acl_state acl_state;
+	struct posix_acl *acls;
+	int rc;
+
+	ksmbd_debug(SMB, "Set posix acls\n");
+	rc = init_acl_state(&acl_state, 1);
+	if (rc)
+		return rc;
+
+	/* Set default owner group */
+	acl_state.owner.allow = (inode->i_mode & 0700) >> 6;
+	acl_state.group.allow = (inode->i_mode & 0070) >> 3;
+	acl_state.other.allow = inode->i_mode & 0007;
+	acl_state.users->aces[acl_state.users->n].uid = inode->i_uid;
+	acl_state.users->aces[acl_state.users->n++].perms.allow =
+		acl_state.owner.allow;
+	acl_state.groups->aces[acl_state.groups->n].gid = inode->i_gid;
+	acl_state.groups->aces[acl_state.groups->n++].perms.allow =
+		acl_state.group.allow;
+	acl_state.mask.allow = 0x07;
+
+	acls = ksmbd_vfs_posix_acl_alloc(6, GFP_KERNEL);
+	if (!acls) {
+		free_acl_state(&acl_state);
+		return -ENOMEM;
+	}
+	posix_state_to_acl(&acl_state, acls->a_entries);
+	rc = ksmbd_vfs_set_posix_acl(inode, ACL_TYPE_ACCESS, acls);
+	if (rc < 0)
+		ksmbd_debug(SMB, "Set posix acl(ACL_TYPE_ACCESS) failed, rc : %d\n",
+				rc);
+	else if (S_ISDIR(inode->i_mode)) {
+		posix_state_to_acl(&acl_state, acls->a_entries);
+		rc = ksmbd_vfs_set_posix_acl(inode, ACL_TYPE_DEFAULT, acls);
+		if (rc < 0)
+			ksmbd_debug(SMB, "Set posix acl(ACL_TYPE_DEFAULT) failed, rc : %d\n",
+					rc);
+	}
+	free_acl_state(&acl_state);
+	posix_acl_release(acls);
+	return rc;
+}
+
+int ksmbd_vfs_inherit_posix_acl(struct inode *inode, struct inode *parent_inode)
+{
+	struct posix_acl *acls;
+	struct posix_acl_entry *pace;
+	int rc, i;
+
+	acls = ksmbd_vfs_get_acl(parent_inode, ACL_TYPE_DEFAULT);
+	if (!acls)
+		return -ENOENT;
+	pace = acls->a_entries;
+
+	for (i = 0; i < acls->a_count; i++, pace++) {
+		if (pace->e_tag == ACL_MASK) {
+			pace->e_perm = 0x07;
+			break;
+		}
+	}
+
+	rc = ksmbd_vfs_set_posix_acl(inode, ACL_TYPE_ACCESS, acls);
+	if (rc < 0)
+		ksmbd_debug(SMB, "Set posix acl(ACL_TYPE_ACCESS) failed, rc : %d\n",
+				rc);
+	if (S_ISDIR(inode->i_mode)) {
+		rc = ksmbd_vfs_set_posix_acl(inode, ACL_TYPE_DEFAULT, acls);
+		if (rc < 0)
+			ksmbd_debug(SMB, "Set posix acl(ACL_TYPE_DEFAULT) failed, rc : %d\n",
+					rc);
+	}
+	posix_acl_release(acls);
+	return rc;
+}
diff --git a/fs/cifsd/vfs.h b/fs/cifsd/vfs.h
new file mode 100644
index 000000000000..bbef5c20c146
--- /dev/null
+++ b/fs/cifsd/vfs.h
@@ -0,0 +1,314 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ *   Copyright (C) 2016 Namjae Jeon <linkinjeon@kernel.org>
+ *   Copyright (C) 2018 Samsung Electronics Co., Ltd.
+ */
+
+#ifndef __KSMBD_VFS_H__
+#define __KSMBD_VFS_H__
+
+#include <linux/file.h>
+#include <linux/fs.h>
+#include <linux/namei.h>
+#include <uapi/linux/xattr.h>
+#include <linux/posix_acl.h>
+
+#include "smbacl.h"
+
+/* STREAM XATTR PREFIX */
+#define STREAM_PREFIX			"DosStream."
+#define STREAM_PREFIX_LEN		(sizeof(STREAM_PREFIX) - 1)
+#define XATTR_NAME_STREAM		(XATTR_USER_PREFIX STREAM_PREFIX)
+#define XATTR_NAME_STREAM_LEN		(sizeof(XATTR_NAME_STREAM) - 1)
+
+enum {
+	XATTR_DOSINFO_ATTRIB		= 0x00000001,
+	XATTR_DOSINFO_EA_SIZE		= 0x00000002,
+	XATTR_DOSINFO_SIZE		= 0x00000004,
+	XATTR_DOSINFO_ALLOC_SIZE	= 0x00000008,
+	XATTR_DOSINFO_CREATE_TIME	= 0x00000010,
+	XATTR_DOSINFO_CHANGE_TIME	= 0x00000020,
+	XATTR_DOSINFO_ITIME		= 0x00000040
+};
+
+struct xattr_dos_attrib {
+	__u16	version;
+	__u32	flags;
+	__u32	attr;
+	__u32	ea_size;
+	__u64	size;
+	__u64	alloc_size;
+	__u64	create_time;
+	__u64	change_time;
+	__u64	itime;
+};
+
+/* DOS ATTRIBUITE XATTR PREFIX */
+#define DOS_ATTRIBUTE_PREFIX		"DOSATTRIB"
+#define DOS_ATTRIBUTE_PREFIX_LEN	(sizeof(DOS_ATTRIBUTE_PREFIX) - 1)
+#define XATTR_NAME_DOS_ATTRIBUTE	\
+		(XATTR_USER_PREFIX DOS_ATTRIBUTE_PREFIX)
+#define XATTR_NAME_DOS_ATTRIBUTE_LEN	\
+		(sizeof(XATTR_USER_PREFIX DOS_ATTRIBUTE_PREFIX) - 1)
+
+#define XATTR_SD_HASH_TYPE_SHA256	0x1
+#define XATTR_SD_HASH_SIZE		64
+
+#define SMB_ACL_READ			4
+#define SMB_ACL_WRITE			2
+#define SMB_ACL_EXECUTE			1
+
+enum {
+	SMB_ACL_TAG_INVALID = 0,
+	SMB_ACL_USER,
+	SMB_ACL_USER_OBJ,
+	SMB_ACL_GROUP,
+	SMB_ACL_GROUP_OBJ,
+	SMB_ACL_OTHER,
+	SMB_ACL_MASK
+};
+
+struct xattr_acl_entry {
+	int type;
+	uid_t uid;
+	gid_t gid;
+	mode_t perm;
+};
+
+struct xattr_smb_acl {
+	int count;
+	int next;
+	struct xattr_acl_entry entries[0];
+};
+
+struct xattr_ntacl {
+	__u16	version;
+	void	*sd_buf;
+	__u32	sd_size;
+	__u16	hash_type;
+	__u8	desc[10];
+	__u16	desc_len;
+	__u64	current_time;
+	__u8	hash[XATTR_SD_HASH_SIZE];
+	__u8	posix_acl_hash[XATTR_SD_HASH_SIZE];
+};
+
+/* SECURITY DESCRIPTOR XATTR PREFIX */
+#define SD_PREFIX			"NTACL"
+#define SD_PREFIX_LEN	(sizeof(SD_PREFIX) - 1)
+#define XATTR_NAME_SD	\
+		(XATTR_SECURITY_PREFIX SD_PREFIX)
+#define XATTR_NAME_SD_LEN	\
+		(sizeof(XATTR_SECURITY_PREFIX SD_PREFIX) - 1)
+
+
+/* CreateOptions */
+/* Flag is set, it must not be a file , valid for directory only */
+#define FILE_DIRECTORY_FILE_LE			cpu_to_le32(0x00000001)
+#define FILE_WRITE_THROUGH_LE			cpu_to_le32(0x00000002)
+#define FILE_SEQUENTIAL_ONLY_LE			cpu_to_le32(0x00000004)
+
+/* Should not buffer on server*/
+#define FILE_NO_INTERMEDIATE_BUFFERING_LE	cpu_to_le32(0x00000008)
+/* MBZ */
+#define FILE_SYNCHRONOUS_IO_ALERT_LE		cpu_to_le32(0x00000010)
+/* MBZ */
+#define FILE_SYNCHRONOUS_IO_NONALERT_LE		cpu_to_le32(0x00000020)
+
+/* Flaf must not be set for directory */
+#define FILE_NON_DIRECTORY_FILE_LE		cpu_to_le32(0x00000040)
+
+/* Should be zero */
+#define CREATE_TREE_CONNECTION			cpu_to_le32(0x00000080)
+#define FILE_COMPLETE_IF_OPLOCKED_LE		cpu_to_le32(0x00000100)
+#define FILE_NO_EA_KNOWLEDGE_LE			cpu_to_le32(0x00000200)
+#define FILE_OPEN_REMOTE_INSTANCE		cpu_to_le32(0x00000400)
+
+/**
+ * Doc says this is obsolete "open for recovery" flag should be zero
+ * in any case.
+ */
+#define CREATE_OPEN_FOR_RECOVERY		cpu_to_le32(0x00000400)
+#define FILE_RANDOM_ACCESS_LE			cpu_to_le32(0x00000800)
+#define FILE_DELETE_ON_CLOSE_LE			cpu_to_le32(0x00001000)
+#define FILE_OPEN_BY_FILE_ID_LE			cpu_to_le32(0x00002000)
+#define FILE_OPEN_FOR_BACKUP_INTENT_LE		cpu_to_le32(0x00004000)
+#define FILE_NO_COMPRESSION_LE			cpu_to_le32(0x00008000)
+
+/* Should be zero*/
+#define FILE_OPEN_REQUIRING_OPLOCK		cpu_to_le32(0x00010000)
+#define FILE_DISALLOW_EXCLUSIVE			cpu_to_le32(0x00020000)
+#define FILE_RESERVE_OPFILTER_LE		cpu_to_le32(0x00100000)
+#define FILE_OPEN_REPARSE_POINT_LE		cpu_to_le32(0x00200000)
+#define FILE_OPEN_NO_RECALL_LE			cpu_to_le32(0x00400000)
+
+/* Should be zero */
+#define FILE_OPEN_FOR_FREE_SPACE_QUERY_LE	cpu_to_le32(0x00800000)
+#define CREATE_OPTIONS_MASK			cpu_to_le32(0x00FFFFFF)
+#define CREATE_OPTION_READONLY			0x10000000
+/* system. NB not sent over wire */
+#define CREATE_OPTION_SPECIAL			0x20000000
+
+struct ksmbd_work;
+struct ksmbd_file;
+struct ksmbd_conn;
+
+struct ksmbd_dir_info {
+	const char	*name;
+	char		*wptr;
+	char		*rptr;
+	int		name_len;
+	int		out_buf_len;
+	int		num_entry;
+	int		data_count;
+	int		last_entry_offset;
+	bool		hide_dot_file;
+	int		flags;
+};
+
+struct ksmbd_readdir_data {
+	struct dir_context	ctx;
+	union {
+		void		*private;
+		char		*dirent;
+	};
+
+	unsigned int		used;
+	unsigned int		dirent_count;
+	unsigned int		file_attr;
+};
+
+/* ksmbd kstat wrapper to get valid create time when reading dir entry */
+struct ksmbd_kstat {
+	struct kstat		*kstat;
+	unsigned long long	create_time;
+	__le32			file_attributes;
+};
+
+struct ksmbd_fs_sector_size {
+	unsigned short	logical_sector_size;
+	unsigned int	physical_sector_size;
+	unsigned int	optimal_io_size;
+};
+
+int ksmbd_vfs_inode_permission(struct dentry *dentry, int acc_mode,
+		bool delete);
+int ksmbd_vfs_query_maximal_access(struct dentry *dentry, __le32 *daccess);
+int ksmbd_vfs_create(struct ksmbd_work *work, const char *name, umode_t mode);
+int ksmbd_vfs_mkdir(struct ksmbd_work *work, const char *name, umode_t mode);
+int ksmbd_vfs_read(struct ksmbd_work *work, struct ksmbd_file *fp,
+		 size_t count, loff_t *pos);
+int ksmbd_vfs_write(struct ksmbd_work *work, struct ksmbd_file *fp,
+	char *buf, size_t count, loff_t *pos, bool sync, ssize_t *written);
+int ksmbd_vfs_fsync(struct ksmbd_work *work, uint64_t fid, uint64_t p_id);
+int ksmbd_vfs_remove_file(struct ksmbd_work *work, char *name);
+int ksmbd_vfs_link(struct ksmbd_work *work,
+		const char *oldname, const char *newname);
+int ksmbd_vfs_getattr(struct path *path, struct kstat *stat);
+int ksmbd_vfs_symlink(const char *name, const char *symname);
+int ksmbd_vfs_readlink(struct path *path, char *buf, int lenp);
+
+int ksmbd_vfs_fp_rename(struct ksmbd_work *work, struct ksmbd_file *fp,
+		char *newname);
+int ksmbd_vfs_rename_slowpath(struct ksmbd_work *work,
+		char *oldname, char *newname);
+
+int ksmbd_vfs_truncate(struct ksmbd_work *work, const char *name,
+	struct ksmbd_file *fp, loff_t size);
+
+struct srv_copychunk;
+int ksmbd_vfs_copy_file_ranges(struct ksmbd_work *work,
+				struct ksmbd_file *src_fp,
+				struct ksmbd_file *dst_fp,
+				struct srv_copychunk *chunks,
+				unsigned int chunk_count,
+				unsigned int *chunk_count_written,
+				unsigned int *chunk_size_written,
+				loff_t  *total_size_written);
+
+struct ksmbd_file *ksmbd_vfs_dentry_open(struct ksmbd_work *work,
+					 const struct path *path,
+					 int flags,
+					 __le32 option,
+					 int fexist);
+
+ssize_t ksmbd_vfs_listxattr(struct dentry *dentry, char **list);
+ssize_t ksmbd_vfs_getxattr(struct dentry *dentry,
+			   char *xattr_name,
+			   char **xattr_buf);
+
+ssize_t ksmbd_vfs_casexattr_len(struct dentry *dentry,
+				char *attr_name,
+				int attr_name_len);
+
+int ksmbd_vfs_setxattr(struct dentry *dentry,
+		       const char *attr_name,
+		       const void *attr_value,
+		       size_t attr_size,
+		       int flags);
+
+int ksmbd_vfs_fsetxattr(const char *filename,
+			const char *attr_name,
+			const void *attr_value,
+			size_t attr_size,
+			int flags);
+
+int ksmbd_vfs_xattr_stream_name(char *stream_name,
+				char **xattr_stream_name,
+				size_t *xattr_stream_name_size,
+				int s_type);
+
+int ksmbd_vfs_truncate_xattr(struct dentry *dentry, int wo_streams);
+int ksmbd_vfs_remove_xattr(struct dentry *dentry, char *attr_name);
+void ksmbd_vfs_xattr_free(char *xattr);
+
+int ksmbd_vfs_kern_path(char *name, unsigned int flags, struct path *path,
+		bool caseless);
+int ksmbd_vfs_empty_dir(struct ksmbd_file *fp);
+void ksmbd_vfs_set_fadvise(struct file *filp, __le32 option);
+int ksmbd_vfs_lock(struct file *filp, int cmd, struct file_lock *flock);
+int ksmbd_vfs_readdir(struct file *file, struct ksmbd_readdir_data *rdata);
+int ksmbd_vfs_alloc_size(struct ksmbd_work *work,
+			 struct ksmbd_file *fp,
+			 loff_t len);
+int ksmbd_vfs_zero_data(struct ksmbd_work *work,
+			 struct ksmbd_file *fp,
+			 loff_t off,
+			 loff_t len);
+
+struct file_allocated_range_buffer;
+int ksmbd_vfs_fqar_lseek(struct ksmbd_file *fp, loff_t start, loff_t length,
+			struct file_allocated_range_buffer *ranges,
+			int in_count, int *out_count);
+int ksmbd_vfs_unlink(struct dentry *dir, struct dentry *dentry);
+unsigned short ksmbd_vfs_logical_sector_size(struct inode *inode);
+void ksmbd_vfs_smb2_sector_size(struct inode *inode,
+				struct ksmbd_fs_sector_size *fs_ss);
+void *ksmbd_vfs_init_kstat(char **p, struct ksmbd_kstat *ksmbd_kstat);
+
+int ksmbd_vfs_fill_dentry_attrs(struct ksmbd_work *work,
+				struct dentry *dentry,
+				struct ksmbd_kstat *ksmbd_kstat);
+
+int ksmbd_vfs_posix_lock_wait(struct file_lock *flock);
+int ksmbd_vfs_posix_lock_wait_timeout(struct file_lock *flock, long timeout);
+void ksmbd_vfs_posix_lock_unblock(struct file_lock *flock);
+
+int ksmbd_vfs_remove_acl_xattrs(struct dentry *dentry);
+int ksmbd_vfs_remove_sd_xattrs(struct dentry *dentry);
+int ksmbd_vfs_set_sd_xattr(struct ksmbd_conn *conn, struct dentry *dentry,
+		struct smb_ntsd *pntsd, int len);
+int ksmbd_vfs_get_sd_xattr(struct ksmbd_conn *conn, struct dentry *dentry,
+		struct smb_ntsd **pntsd);
+int ksmbd_vfs_set_dos_attrib_xattr(struct dentry *dentry,
+		struct xattr_dos_attrib *da);
+int ksmbd_vfs_get_dos_attrib_xattr(struct dentry *dentry,
+		struct xattr_dos_attrib *da);
+struct posix_acl *ksmbd_vfs_posix_acl_alloc(int count, gfp_t flags);
+struct posix_acl *ksmbd_vfs_get_acl(struct inode *inode, int type);
+int ksmbd_vfs_set_posix_acl(struct inode *inode, int type,
+		struct posix_acl *acl);
+int ksmbd_vfs_set_init_posix_acl(struct inode *inode);
+int ksmbd_vfs_inherit_posix_acl(struct inode *inode,
+		struct inode *parent_inode);
+#endif /* __KSMBD_VFS_H__ */
diff --git a/fs/cifsd/vfs_cache.c b/fs/cifsd/vfs_cache.c
new file mode 100644
index 000000000000..af92fab5b7ae
--- /dev/null
+++ b/fs/cifsd/vfs_cache.c
@@ -0,0 +1,851 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2016 Namjae Jeon <linkinjeon@kernel.org>
+ * Copyright (C) 2019 Samsung Electronics Co., Ltd.
+ */
+
+#include <linux/fs.h>
+#include <linux/slab.h>
+#include <linux/vmalloc.h>
+
+#include "glob.h"
+#include "vfs_cache.h"
+#include "buffer_pool.h"
+#include "oplock.h"
+#include "vfs.h"
+#include "connection.h"
+#include "mgmt/tree_connect.h"
+#include "mgmt/user_session.h"
+#include "smb_common.h"
+
+#define S_DEL_PENDING			1
+#define S_DEL_ON_CLS			2
+#define S_DEL_ON_CLS_STREAM		8
+
+static unsigned int inode_hash_mask __read_mostly;
+static unsigned int inode_hash_shift __read_mostly;
+static struct hlist_head *inode_hashtable __read_mostly;
+static DEFINE_RWLOCK(inode_hash_lock);
+
+static struct ksmbd_file_table global_ft;
+static atomic_long_t fd_limit;
+
+void ksmbd_set_fd_limit(unsigned long limit)
+{
+	limit = min(limit, get_max_files());
+	atomic_long_set(&fd_limit, limit);
+}
+
+static bool fd_limit_depleted(void)
+{
+	long v = atomic_long_dec_return(&fd_limit);
+
+	if (v >= 0)
+		return false;
+	atomic_long_inc(&fd_limit);
+	return true;
+}
+
+static void fd_limit_close(void)
+{
+	atomic_long_inc(&fd_limit);
+}
+
+/*
+ * INODE hash
+ */
+
+static unsigned long inode_hash(struct super_block *sb, unsigned long hashval)
+{
+	unsigned long tmp;
+
+	tmp = (hashval * (unsigned long)sb) ^ (GOLDEN_RATIO_PRIME + hashval) /
+		L1_CACHE_BYTES;
+	tmp = tmp ^ ((tmp ^ GOLDEN_RATIO_PRIME) >> inode_hash_shift);
+	return tmp & inode_hash_mask;
+}
+
+static struct ksmbd_inode *__ksmbd_inode_lookup(struct inode *inode)
+{
+	struct hlist_head *head = inode_hashtable +
+		inode_hash(inode->i_sb, inode->i_ino);
+	struct ksmbd_inode *ci = NULL, *ret_ci = NULL;
+
+	hlist_for_each_entry(ci, head, m_hash) {
+		if (ci->m_inode == inode) {
+			if (atomic_inc_not_zero(&ci->m_count))
+				ret_ci = ci;
+			break;
+		}
+	}
+	return ret_ci;
+}
+
+static struct ksmbd_inode *ksmbd_inode_lookup(struct ksmbd_file *fp)
+{
+	return __ksmbd_inode_lookup(FP_INODE(fp));
+}
+
+static struct ksmbd_inode *ksmbd_inode_lookup_by_vfsinode(struct inode *inode)
+{
+	struct ksmbd_inode *ci;
+
+	read_lock(&inode_hash_lock);
+	ci = __ksmbd_inode_lookup(inode);
+	read_unlock(&inode_hash_lock);
+	return ci;
+}
+
+int ksmbd_query_inode_status(struct inode *inode)
+{
+	struct ksmbd_inode *ci;
+	int ret = KSMBD_INODE_STATUS_UNKNOWN;
+
+	read_lock(&inode_hash_lock);
+	ci = __ksmbd_inode_lookup(inode);
+	if (ci) {
+		ret = KSMBD_INODE_STATUS_OK;
+		if (ci->m_flags & S_DEL_PENDING)
+			ret = KSMBD_INODE_STATUS_PENDING_DELETE;
+		atomic_dec(&ci->m_count);
+	}
+	read_unlock(&inode_hash_lock);
+	return ret;
+}
+
+bool ksmbd_inode_pending_delete(struct ksmbd_file *fp)
+{
+	return (fp->f_ci->m_flags & S_DEL_PENDING);
+}
+
+void ksmbd_set_inode_pending_delete(struct ksmbd_file *fp)
+{
+	fp->f_ci->m_flags |= S_DEL_PENDING;
+}
+
+void ksmbd_clear_inode_pending_delete(struct ksmbd_file *fp)
+{
+	fp->f_ci->m_flags &= ~S_DEL_PENDING;
+}
+
+void ksmbd_fd_set_delete_on_close(struct ksmbd_file *fp,
+				  int file_info)
+{
+	if (ksmbd_stream_fd(fp)) {
+		fp->f_ci->m_flags |= S_DEL_ON_CLS_STREAM;
+		return;
+	}
+
+	fp->f_ci->m_flags |= S_DEL_ON_CLS;
+}
+
+static void ksmbd_inode_hash(struct ksmbd_inode *ci)
+{
+	struct hlist_head *b = inode_hashtable +
+		inode_hash(ci->m_inode->i_sb, ci->m_inode->i_ino);
+
+	hlist_add_head(&ci->m_hash, b);
+}
+
+static void ksmbd_inode_unhash(struct ksmbd_inode *ci)
+{
+	write_lock(&inode_hash_lock);
+	hlist_del_init(&ci->m_hash);
+	write_unlock(&inode_hash_lock);
+}
+
+static int ksmbd_inode_init(struct ksmbd_inode *ci, struct ksmbd_file *fp)
+{
+	ci->m_inode = FP_INODE(fp);
+	atomic_set(&ci->m_count, 1);
+	atomic_set(&ci->op_count, 0);
+	atomic_set(&ci->sop_count, 0);
+	ci->m_flags = 0;
+	ci->m_fattr = 0;
+	INIT_LIST_HEAD(&ci->m_fp_list);
+	INIT_LIST_HEAD(&ci->m_op_list);
+	rwlock_init(&ci->m_lock);
+	return 0;
+}
+
+static struct ksmbd_inode *ksmbd_inode_get(struct ksmbd_file *fp)
+{
+	struct ksmbd_inode *ci, *tmpci;
+	int rc;
+
+	read_lock(&inode_hash_lock);
+	ci = ksmbd_inode_lookup(fp);
+	read_unlock(&inode_hash_lock);
+	if (ci)
+		return ci;
+
+	ci = kmalloc(sizeof(struct ksmbd_inode), GFP_KERNEL);
+	if (!ci)
+		return NULL;
+
+	rc = ksmbd_inode_init(ci, fp);
+	if (rc) {
+		ksmbd_err("inode initialized failed\n");
+		kfree(ci);
+		return NULL;
+	}
+
+	write_lock(&inode_hash_lock);
+	tmpci = ksmbd_inode_lookup(fp);
+	if (!tmpci) {
+		ksmbd_inode_hash(ci);
+	} else {
+		kfree(ci);
+		ci = tmpci;
+	}
+	write_unlock(&inode_hash_lock);
+	return ci;
+}
+
+static void ksmbd_inode_free(struct ksmbd_inode *ci)
+{
+	ksmbd_inode_unhash(ci);
+	kfree(ci);
+}
+
+static void ksmbd_inode_put(struct ksmbd_inode *ci)
+{
+	if (atomic_dec_and_test(&ci->m_count))
+		ksmbd_inode_free(ci);
+}
+
+int __init ksmbd_inode_hash_init(void)
+{
+	unsigned int loop;
+	unsigned long numentries = 16384;
+	unsigned long bucketsize = sizeof(struct hlist_head);
+	unsigned long size;
+
+	inode_hash_shift = ilog2(numentries);
+	inode_hash_mask = (1 << inode_hash_shift) - 1;
+
+	size = bucketsize << inode_hash_shift;
+
+	/* init master fp hash table */
+	inode_hashtable = vmalloc(size);
+	if (!inode_hashtable)
+		return -ENOMEM;
+
+	for (loop = 0; loop < (1U << inode_hash_shift); loop++)
+		INIT_HLIST_HEAD(&inode_hashtable[loop]);
+	return 0;
+}
+
+void __exit ksmbd_release_inode_hash(void)
+{
+	vfree(inode_hashtable);
+}
+
+static void __ksmbd_inode_close(struct ksmbd_file *fp)
+{
+	struct dentry *dir, *dentry;
+	struct ksmbd_inode *ci = fp->f_ci;
+	int err;
+	struct file *filp;
+
+	filp = fp->filp;
+	if (ksmbd_stream_fd(fp) && (ci->m_flags & S_DEL_ON_CLS_STREAM)) {
+		ci->m_flags &= ~S_DEL_ON_CLS_STREAM;
+		err = ksmbd_vfs_remove_xattr(filp->f_path.dentry,
+					     fp->stream.name);
+		if (err)
+			ksmbd_err("remove xattr failed : %s\n",
+				fp->stream.name);
+	}
+
+	if (atomic_dec_and_test(&ci->m_count)) {
+		write_lock(&ci->m_lock);
+		if (ci->m_flags & (S_DEL_ON_CLS | S_DEL_PENDING)) {
+			dentry = filp->f_path.dentry;
+			dir = dentry->d_parent;
+			ci->m_flags &= ~(S_DEL_ON_CLS | S_DEL_PENDING);
+			write_unlock(&ci->m_lock);
+			ksmbd_vfs_unlink(dir, dentry);
+			write_lock(&ci->m_lock);
+		}
+		write_unlock(&ci->m_lock);
+
+		ksmbd_inode_free(ci);
+	}
+}
+
+static void __ksmbd_remove_durable_fd(struct ksmbd_file *fp)
+{
+	if (!HAS_FILE_ID(fp->persistent_id))
+		return;
+
+	write_lock(&global_ft.lock);
+	idr_remove(global_ft.idr, fp->persistent_id);
+	write_unlock(&global_ft.lock);
+}
+
+static void __ksmbd_remove_fd(struct ksmbd_file_table *ft,
+			      struct ksmbd_file *fp)
+{
+	if (!HAS_FILE_ID(fp->volatile_id))
+		return;
+
+	write_lock(&fp->f_ci->m_lock);
+	list_del_init(&fp->node);
+	write_unlock(&fp->f_ci->m_lock);
+
+	write_lock(&ft->lock);
+	idr_remove(ft->idr, fp->volatile_id);
+	write_unlock(&ft->lock);
+}
+
+static void __ksmbd_close_fd(struct ksmbd_file_table *ft,
+			     struct ksmbd_file *fp)
+{
+	struct file *filp;
+
+	fd_limit_close();
+	__ksmbd_remove_durable_fd(fp);
+	__ksmbd_remove_fd(ft, fp);
+
+	close_id_del_oplock(fp);
+	filp = fp->filp;
+
+	__ksmbd_inode_close(fp);
+	if (!IS_ERR_OR_NULL(filp))
+		fput(filp);
+	kfree(fp->filename);
+	if (ksmbd_stream_fd(fp))
+		kfree(fp->stream.name);
+	ksmbd_free_file_struct(fp);
+}
+
+static struct ksmbd_file *ksmbd_fp_get(struct ksmbd_file *fp)
+{
+	if (!atomic_inc_not_zero(&fp->refcount))
+		return NULL;
+	return fp;
+}
+
+static struct ksmbd_file *__ksmbd_lookup_fd(struct ksmbd_file_table *ft,
+					    unsigned int id)
+{
+	bool unclaimed = true;
+	struct ksmbd_file *fp;
+
+	read_lock(&ft->lock);
+	fp = idr_find(ft->idr, id);
+	if (fp)
+		fp = ksmbd_fp_get(fp);
+
+	if (fp && fp->f_ci) {
+		read_lock(&fp->f_ci->m_lock);
+		unclaimed = list_empty(&fp->node);
+		read_unlock(&fp->f_ci->m_lock);
+	}
+	read_unlock(&ft->lock);
+
+	if (fp && unclaimed) {
+		atomic_dec(&fp->refcount);
+		return NULL;
+	}
+	return fp;
+}
+
+static void __put_fd_final(struct ksmbd_work *work,
+			   struct ksmbd_file *fp)
+{
+	__ksmbd_close_fd(&work->sess->file_table, fp);
+	atomic_dec(&work->conn->stats.open_files_count);
+}
+
+static void set_close_state_blocked_works(struct ksmbd_file *fp)
+{
+	struct ksmbd_work *cancel_work, *ctmp;
+
+	spin_lock(&fp->f_lock);
+	list_for_each_entry_safe(cancel_work, ctmp, &fp->blocked_works,
+			fp_entry) {
+		list_del(&cancel_work->fp_entry);
+		cancel_work->state = KSMBD_WORK_CLOSED;
+		cancel_work->cancel_fn(cancel_work->cancel_argv);
+	}
+	spin_unlock(&fp->f_lock);
+}
+
+int ksmbd_close_fd(struct ksmbd_work *work, unsigned int id)
+{
+	struct ksmbd_file	*fp;
+	struct ksmbd_file_table	*ft;
+
+	if (!HAS_FILE_ID(id))
+		return 0;
+
+	ft = &work->sess->file_table;
+	read_lock(&ft->lock);
+	fp = idr_find(ft->idr, id);
+	if (fp) {
+		set_close_state_blocked_works(fp);
+
+		if (!atomic_dec_and_test(&fp->refcount))
+			fp = NULL;
+	}
+	read_unlock(&ft->lock);
+
+	if (!fp)
+		return -EINVAL;
+
+	__put_fd_final(work, fp);
+	return 0;
+}
+
+void ksmbd_fd_put(struct ksmbd_work *work,
+		  struct ksmbd_file *fp)
+{
+	if (!fp)
+		return;
+
+	if (!atomic_dec_and_test(&fp->refcount))
+		return;
+	__put_fd_final(work, fp);
+}
+
+static bool __sanity_check(struct ksmbd_tree_connect *tcon,
+			   struct ksmbd_file *fp)
+{
+	if (!fp)
+		return false;
+	if (fp->tcon != tcon)
+		return false;
+	return true;
+}
+
+struct ksmbd_file *ksmbd_lookup_foreign_fd(struct ksmbd_work *work,
+					   unsigned int id)
+{
+	return __ksmbd_lookup_fd(&work->sess->file_table, id);
+}
+
+struct ksmbd_file *ksmbd_lookup_fd_fast(struct ksmbd_work *work,
+					unsigned int id)
+{
+	struct ksmbd_file *fp = __ksmbd_lookup_fd(&work->sess->file_table, id);
+
+	if (__sanity_check(work->tcon, fp))
+		return fp;
+
+	ksmbd_fd_put(work, fp);
+	return NULL;
+}
+
+struct ksmbd_file *ksmbd_lookup_fd_slow(struct ksmbd_work *work,
+					unsigned int id,
+					unsigned int pid)
+{
+	struct ksmbd_file *fp;
+
+	if (!HAS_FILE_ID(id)) {
+		id = work->compound_fid;
+		pid = work->compound_pfid;
+	}
+
+	if (!HAS_FILE_ID(id))
+		return NULL;
+
+	fp = __ksmbd_lookup_fd(&work->sess->file_table, id);
+	if (!__sanity_check(work->tcon, fp)) {
+		ksmbd_fd_put(work, fp);
+		return NULL;
+	}
+	if (fp->persistent_id != pid) {
+		ksmbd_fd_put(work, fp);
+		return NULL;
+	}
+	return fp;
+}
+
+struct ksmbd_file *ksmbd_lookup_durable_fd(unsigned long long id)
+{
+	return __ksmbd_lookup_fd(&global_ft, id);
+}
+
+int ksmbd_close_fd_app_id(struct ksmbd_work *work,
+			  char *app_id)
+{
+	struct ksmbd_file	*fp = NULL;
+	unsigned int		id;
+
+	read_lock(&global_ft.lock);
+	idr_for_each_entry(global_ft.idr, fp, id) {
+		if (!memcmp(fp->app_instance_id,
+			    app_id,
+			    SMB2_CREATE_GUID_SIZE)) {
+			if (!atomic_dec_and_test(&fp->refcount))
+				fp = NULL;
+			break;
+		}
+	}
+	read_unlock(&global_ft.lock);
+
+	if (!fp)
+		return -EINVAL;
+
+	__put_fd_final(work, fp);
+	return 0;
+}
+
+struct ksmbd_file *ksmbd_lookup_fd_cguid(char *cguid)
+{
+	struct ksmbd_file	*fp = NULL;
+	unsigned int		id;
+
+	read_lock(&global_ft.lock);
+	idr_for_each_entry(global_ft.idr, fp, id) {
+		if (!memcmp(fp->create_guid,
+			    cguid,
+			    SMB2_CREATE_GUID_SIZE)) {
+			fp = ksmbd_fp_get(fp);
+			break;
+		}
+	}
+	read_unlock(&global_ft.lock);
+
+	return fp;
+}
+
+struct ksmbd_file *ksmbd_lookup_fd_filename(struct ksmbd_work *work,
+					    char *filename)
+{
+	struct ksmbd_file	*fp = NULL;
+	unsigned int		id;
+
+	read_lock(&work->sess->file_table.lock);
+	idr_for_each_entry(work->sess->file_table.idr, fp, id) {
+		if (!strcmp(fp->filename, filename)) {
+			fp = ksmbd_fp_get(fp);
+			break;
+		}
+	}
+	read_unlock(&work->sess->file_table.lock);
+
+	return fp;
+}
+
+struct ksmbd_file *ksmbd_lookup_fd_inode(struct inode *inode)
+{
+	struct ksmbd_file	*lfp;
+	struct ksmbd_inode	*ci;
+	struct list_head	*cur;
+
+	ci = ksmbd_inode_lookup_by_vfsinode(inode);
+	if (!ci)
+		return NULL;
+
+	read_lock(&ci->m_lock);
+	list_for_each(cur, &ci->m_fp_list) {
+		lfp = list_entry(cur, struct ksmbd_file, node);
+		if (inode == FP_INODE(lfp)) {
+			atomic_dec(&ci->m_count);
+			read_unlock(&ci->m_lock);
+			return lfp;
+		}
+	}
+	atomic_dec(&ci->m_count);
+	read_unlock(&ci->m_lock);
+	return NULL;
+}
+
+#define OPEN_ID_TYPE_VOLATILE_ID	(0)
+#define OPEN_ID_TYPE_PERSISTENT_ID	(1)
+
+static void __open_id_set(struct ksmbd_file *fp, unsigned int id, int type)
+{
+	if (type == OPEN_ID_TYPE_VOLATILE_ID)
+		fp->volatile_id = id;
+	if (type == OPEN_ID_TYPE_PERSISTENT_ID)
+		fp->persistent_id = id;
+}
+
+static int __open_id(struct ksmbd_file_table *ft,
+		     struct ksmbd_file *fp,
+		     int type)
+{
+	unsigned int		id = 0;
+	int			ret;
+
+	if (type == OPEN_ID_TYPE_VOLATILE_ID && fd_limit_depleted()) {
+		__open_id_set(fp, KSMBD_NO_FID, type);
+		return -EMFILE;
+	}
+
+	idr_preload(GFP_KERNEL);
+	write_lock(&ft->lock);
+	ret = idr_alloc_cyclic(ft->idr, fp, 0, INT_MAX, GFP_NOWAIT);
+	if (ret >= 0) {
+		id = ret;
+		ret = 0;
+	} else {
+		id = KSMBD_NO_FID;
+		fd_limit_close();
+	}
+
+	__open_id_set(fp, id, type);
+	write_unlock(&ft->lock);
+	idr_preload_end();
+	return ret;
+}
+
+unsigned int ksmbd_open_durable_fd(struct ksmbd_file *fp)
+{
+	__open_id(&global_ft, fp, OPEN_ID_TYPE_PERSISTENT_ID);
+	return fp->persistent_id;
+}
+
+struct ksmbd_file *ksmbd_open_fd(struct ksmbd_work *work,
+				 struct file *filp)
+{
+	struct ksmbd_file	*fp;
+	int ret;
+
+	fp = ksmbd_alloc_file_struct();
+	if (!fp) {
+		ksmbd_err("Failed to allocate memory\n");
+		return ERR_PTR(-ENOMEM);
+	}
+
+	INIT_LIST_HEAD(&fp->blocked_works);
+	INIT_LIST_HEAD(&fp->node);
+	spin_lock_init(&fp->f_lock);
+	atomic_set(&fp->refcount, 1);
+
+	fp->filp		= filp;
+	fp->conn		= work->sess->conn;
+	fp->tcon		= work->tcon;
+	fp->volatile_id		= KSMBD_NO_FID;
+	fp->persistent_id	= KSMBD_NO_FID;
+	fp->f_ci		= ksmbd_inode_get(fp);
+
+	if (!fp->f_ci) {
+		ksmbd_free_file_struct(fp);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	ret = __open_id(&work->sess->file_table, fp, OPEN_ID_TYPE_VOLATILE_ID);
+	if (ret) {
+		ksmbd_inode_put(fp->f_ci);
+		ksmbd_free_file_struct(fp);
+		return ERR_PTR(ret);
+	}
+
+	atomic_inc(&work->conn->stats.open_files_count);
+	return fp;
+}
+
+static inline bool is_reconnectable(struct ksmbd_file *fp)
+{
+	struct oplock_info *opinfo = opinfo_get(fp);
+	bool reconn = false;
+
+	if (!opinfo)
+		return false;
+
+	if (opinfo->op_state != OPLOCK_STATE_NONE) {
+		opinfo_put(opinfo);
+		return false;
+	}
+
+	if (fp->is_resilient || fp->is_persistent)
+		reconn = true;
+	else if (fp->is_durable && opinfo->is_lease &&
+			opinfo->o_lease->state & SMB2_LEASE_HANDLE_CACHING_LE)
+		reconn = true;
+
+	else if (fp->is_durable && opinfo->level == SMB2_OPLOCK_LEVEL_BATCH)
+		reconn = true;
+
+	opinfo_put(opinfo);
+	return reconn;
+}
+
+static int
+__close_file_table_ids(struct ksmbd_file_table *ft,
+		       struct ksmbd_tree_connect *tcon,
+		       bool (*skip)(struct ksmbd_tree_connect *tcon,
+				    struct ksmbd_file *fp))
+{
+	unsigned int			id;
+	struct ksmbd_file		*fp;
+	int				num = 0;
+
+	idr_for_each_entry(ft->idr, fp, id) {
+		if (skip(tcon, fp))
+			continue;
+
+		set_close_state_blocked_works(fp);
+
+		if (!atomic_dec_and_test(&fp->refcount))
+			continue;
+		__ksmbd_close_fd(ft, fp);
+		num++;
+	}
+	return num;
+}
+
+static bool tree_conn_fd_check(struct ksmbd_tree_connect *tcon,
+			       struct ksmbd_file *fp)
+{
+	return fp->tcon != tcon;
+}
+
+static bool session_fd_check(struct ksmbd_tree_connect *tcon,
+			     struct ksmbd_file *fp)
+{
+	if (!is_reconnectable(fp))
+		return false;
+
+	fp->conn = NULL;
+	fp->tcon = NULL;
+	fp->volatile_id = KSMBD_NO_FID;
+	return true;
+}
+
+void ksmbd_close_tree_conn_fds(struct ksmbd_work *work)
+{
+	int num = __close_file_table_ids(&work->sess->file_table,
+					 work->tcon,
+					 tree_conn_fd_check);
+
+	atomic_sub(num, &work->conn->stats.open_files_count);
+}
+
+void ksmbd_close_session_fds(struct ksmbd_work *work)
+{
+	int num = __close_file_table_ids(&work->sess->file_table,
+					 work->tcon,
+					 session_fd_check);
+
+	atomic_sub(num, &work->conn->stats.open_files_count);
+}
+
+int ksmbd_init_global_file_table(void)
+{
+	return ksmbd_init_file_table(&global_ft);
+}
+
+void ksmbd_free_global_file_table(void)
+{
+	struct ksmbd_file	*fp = NULL;
+	unsigned int		id;
+
+	idr_for_each_entry(global_ft.idr, fp, id) {
+		__ksmbd_remove_durable_fd(fp);
+		ksmbd_free_file_struct(fp);
+	}
+
+	ksmbd_destroy_file_table(&global_ft);
+}
+
+int ksmbd_reopen_durable_fd(struct ksmbd_work *work,
+			    struct ksmbd_file *fp)
+{
+	if (!fp->is_durable || fp->conn || fp->tcon) {
+		ksmbd_err("Invalid durable fd [%p:%p]\n",
+				fp->conn, fp->tcon);
+		return -EBADF;
+	}
+
+	if (HAS_FILE_ID(fp->volatile_id)) {
+		ksmbd_err("Still in use durable fd: %u\n", fp->volatile_id);
+		return -EBADF;
+	}
+
+	fp->conn = work->sess->conn;
+	fp->tcon = work->tcon;
+
+	__open_id(&work->sess->file_table, fp, OPEN_ID_TYPE_VOLATILE_ID);
+	if (!HAS_FILE_ID(fp->volatile_id)) {
+		fp->conn = NULL;
+		fp->tcon = NULL;
+		return -EBADF;
+	}
+	return 0;
+}
+
+static void close_fd_list(struct ksmbd_work *work, struct list_head *head)
+{
+	while (!list_empty(head)) {
+		struct ksmbd_file *fp;
+
+		fp = list_first_entry(head, struct ksmbd_file, node);
+		list_del_init(&fp->node);
+
+		__ksmbd_close_fd(&work->sess->file_table, fp);
+	}
+}
+
+int ksmbd_close_inode_fds(struct ksmbd_work *work, struct inode *inode)
+{
+	struct ksmbd_inode *ci;
+	bool unlinked = true;
+	struct ksmbd_file *fp, *fptmp;
+	LIST_HEAD(dispose);
+
+	ci = ksmbd_inode_lookup_by_vfsinode(inode);
+	if (!ci)
+		return true;
+
+	if (ci->m_flags & (S_DEL_ON_CLS | S_DEL_PENDING))
+		unlinked = false;
+
+	write_lock(&ci->m_lock);
+	list_for_each_entry_safe(fp, fptmp, &ci->m_fp_list, node) {
+		if (fp->conn)
+			continue;
+
+		list_del(&fp->node);
+		list_add(&fp->node, &dispose);
+	}
+	atomic_dec(&ci->m_count);
+	write_unlock(&ci->m_lock);
+
+	close_fd_list(work, &dispose);
+	return unlinked;
+}
+
+int ksmbd_file_table_flush(struct ksmbd_work *work)
+{
+	struct ksmbd_file	*fp = NULL;
+	unsigned int		id;
+	int			ret;
+
+	read_lock(&work->sess->file_table.lock);
+	idr_for_each_entry(work->sess->file_table.idr, fp, id) {
+		ret = ksmbd_vfs_fsync(work, fp->volatile_id, KSMBD_NO_FID);
+		if (ret)
+			break;
+	}
+	read_unlock(&work->sess->file_table.lock);
+	return ret;
+}
+
+int ksmbd_init_file_table(struct ksmbd_file_table *ft)
+{
+	ft->idr = ksmbd_alloc(sizeof(struct idr));
+	if (!ft->idr)
+		return -ENOMEM;
+
+	idr_init(ft->idr);
+	rwlock_init(&ft->lock);
+	return 0;
+}
+
+void ksmbd_destroy_file_table(struct ksmbd_file_table *ft)
+{
+	if (!ft->idr)
+		return;
+
+	__close_file_table_ids(ft, NULL, session_fd_check);
+	idr_destroy(ft->idr);
+	ksmbd_free(ft->idr);
+	ft->idr = NULL;
+}
diff --git a/fs/cifsd/vfs_cache.h b/fs/cifsd/vfs_cache.h
new file mode 100644
index 000000000000..7d23657c86c6
--- /dev/null
+++ b/fs/cifsd/vfs_cache.h
@@ -0,0 +1,213 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ *   Copyright (C) 2019 Samsung Electronics Co., Ltd.
+ */
+
+#ifndef __VFS_CACHE_H__
+#define __VFS_CACHE_H__
+
+#include <linux/version.h>
+#include <linux/file.h>
+#include <linux/fs.h>
+#include <linux/rwsem.h>
+#include <linux/spinlock.h>
+#include <linux/idr.h>
+#include <linux/workqueue.h>
+
+#include "vfs.h"
+
+/* Windows style file permissions for extended response */
+#define	FILE_GENERIC_ALL	0x1F01FF
+#define	FILE_GENERIC_READ	0x120089
+#define	FILE_GENERIC_WRITE	0x120116
+#define	FILE_GENERIC_EXECUTE	0X1200a0
+
+#define KSMBD_START_FID		0
+#define KSMBD_NO_FID		(UINT_MAX)
+#define SMB2_NO_FID		(0xFFFFFFFFFFFFFFFFULL)
+
+#define FP_FILENAME(fp)		fp->filp->f_path.dentry->d_name.name
+#define FP_INODE(fp)		fp->filp->f_path.dentry->d_inode
+#define PARENT_INODE(fp)	fp->filp->f_path.dentry->d_parent->d_inode
+
+#define ATTR_FP(fp) (fp->attrib_only && \
+		(fp->cdoption != FILE_OVERWRITE_IF_LE && \
+		fp->cdoption != FILE_OVERWRITE_LE && \
+		fp->cdoption != FILE_SUPERSEDE_LE))
+
+struct ksmbd_conn;
+struct ksmbd_session;
+
+struct ksmbd_lock {
+	struct file_lock *fl;
+	struct list_head glist;
+	struct list_head llist;
+	unsigned int flags;
+	int cmd;
+	int zero_len;
+	unsigned long long start;
+	unsigned long long end;
+};
+
+struct stream {
+	char *name;
+	ssize_t size;
+};
+
+struct ksmbd_inode {
+	rwlock_t			m_lock;
+	atomic_t			m_count;
+	atomic_t			op_count;
+	/* opinfo count for streams */
+	atomic_t			sop_count;
+	struct inode			*m_inode;
+	unsigned int			m_flags;
+	struct hlist_node		m_hash;
+	struct list_head		m_fp_list;
+	struct list_head		m_op_list;
+	struct oplock_info		*m_opinfo;
+	__le32				m_fattr;
+};
+
+struct ksmbd_file {
+	struct file			*filp;
+	char				*filename;
+	unsigned int			persistent_id;
+	unsigned int			volatile_id;
+
+	spinlock_t			f_lock;
+
+	struct ksmbd_inode		*f_ci;
+	struct ksmbd_inode		*f_parent_ci;
+	struct oplock_info __rcu	*f_opinfo;
+	struct ksmbd_conn		*conn;
+	struct ksmbd_tree_connect	*tcon;
+
+	atomic_t			refcount;
+	__le32				daccess;
+	__le32				saccess;
+	__le32				coption;
+	__le32				cdoption;
+	__u64				create_time;
+	__u64				itime;
+
+	bool				is_durable;
+	bool				is_resilient;
+	bool				is_persistent;
+	bool				is_nt_open;
+	bool				attrib_only;
+
+	char				client_guid[16];
+	char				create_guid[16];
+	char				app_instance_id[16];
+
+	struct stream			stream;
+	struct list_head		node;
+	struct list_head		blocked_works;
+
+	int				durable_timeout;
+
+	/* for SMB1 */
+	int				pid;
+
+	/* conflict lock fail count for SMB1 */
+	unsigned int			cflock_cnt;
+	/* last lock failure start offset for SMB1 */
+	unsigned long long		llock_fstart;
+
+	int				dirent_offset;
+
+	/* if ls is happening on directory, below is valid*/
+	struct ksmbd_readdir_data	readdir_data;
+	int				dot_dotdot[2];
+};
+
+static inline void set_ctx_actor(struct dir_context *ctx,
+				 filldir_t actor)
+{
+	ctx->actor = actor;
+}
+
+#define KSMBD_NR_OPEN_DEFAULT BITS_PER_LONG
+
+struct ksmbd_file_table {
+	rwlock_t		lock;
+	struct idr		*idr;
+};
+
+static inline bool HAS_FILE_ID(unsigned long long req)
+{
+	unsigned int id = (unsigned int)req;
+
+	return id < KSMBD_NO_FID;
+}
+
+static inline bool ksmbd_stream_fd(struct ksmbd_file *fp)
+{
+	return fp->stream.name != NULL;
+}
+
+int ksmbd_init_file_table(struct ksmbd_file_table *ft);
+void ksmbd_destroy_file_table(struct ksmbd_file_table *ft);
+
+int ksmbd_close_fd(struct ksmbd_work *work, unsigned int id);
+
+struct ksmbd_file *ksmbd_lookup_fd_fast(struct ksmbd_work *work,
+					unsigned int id);
+struct ksmbd_file *ksmbd_lookup_foreign_fd(struct ksmbd_work *work,
+					   unsigned int id);
+struct ksmbd_file *ksmbd_lookup_fd_slow(struct ksmbd_work *work,
+					unsigned int id,
+					unsigned int pid);
+
+void ksmbd_fd_put(struct ksmbd_work *work, struct ksmbd_file *fp);
+
+int ksmbd_close_fd_app_id(struct ksmbd_work *work, char *app_id);
+struct ksmbd_file *ksmbd_lookup_durable_fd(unsigned long long id);
+struct ksmbd_file *ksmbd_lookup_fd_cguid(char *cguid);
+struct ksmbd_file *ksmbd_lookup_fd_filename(struct ksmbd_work *work,
+					    char *filename);
+struct ksmbd_file *ksmbd_lookup_fd_inode(struct inode *inode);
+
+unsigned int ksmbd_open_durable_fd(struct ksmbd_file *fp);
+
+struct ksmbd_file *ksmbd_open_fd(struct ksmbd_work *work,
+				 struct file *filp);
+
+void ksmbd_close_tree_conn_fds(struct ksmbd_work *work);
+void ksmbd_close_session_fds(struct ksmbd_work *work);
+
+int ksmbd_close_inode_fds(struct ksmbd_work *work, struct inode *inode);
+
+int ksmbd_reopen_durable_fd(struct ksmbd_work *work,
+			    struct ksmbd_file *fp);
+
+int ksmbd_init_global_file_table(void);
+void ksmbd_free_global_file_table(void);
+
+int ksmbd_file_table_flush(struct ksmbd_work *work);
+
+void ksmbd_set_fd_limit(unsigned long limit);
+
+/*
+ * INODE hash
+ */
+
+int __init ksmbd_inode_hash_init(void);
+void __exit ksmbd_release_inode_hash(void);
+
+enum KSMBD_INODE_STATUS {
+	KSMBD_INODE_STATUS_OK,
+	KSMBD_INODE_STATUS_UNKNOWN,
+	KSMBD_INODE_STATUS_PENDING_DELETE,
+};
+
+int ksmbd_query_inode_status(struct inode *inode);
+
+bool ksmbd_inode_pending_delete(struct ksmbd_file *fp);
+void ksmbd_set_inode_pending_delete(struct ksmbd_file *fp);
+void ksmbd_clear_inode_pending_delete(struct ksmbd_file *fp);
+
+void ksmbd_fd_set_delete_on_close(struct ksmbd_file *fp,
+				  int file_info);
+#endif /* __VFS_CACHE_H__ */
-- 
2.17.1

