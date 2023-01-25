Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B68767AC7F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jan 2023 09:42:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235306AbjAYImU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Jan 2023 03:42:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235454AbjAYIkP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Jan 2023 03:40:15 -0500
Received: from mail-ot1-x34a.google.com (mail-ot1-x34a.google.com [IPv6:2607:f8b0:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69A7B4F379
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Jan 2023 00:39:40 -0800 (PST)
Received: by mail-ot1-x34a.google.com with SMTP id c13-20020a9d784d000000b006866230a44aso8868821otm.15
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Jan 2023 00:39:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ralp0YsbeintaJ1+3rV0BJxcsbdnu/jVKuNhvnt0T5Y=;
        b=FpW3ZfeoZ58NaZWfySIfB+f4+MM7GrKuq9uCXe+gfhjrC0bvKaL2kAypJ/pJdIrezU
         Ru0cU0KNklRfuYrJ3SKXkdPgNjMfodaxcsFUMH2z2VP+LqiGmmBZi4WNjYcaaYQLe2mC
         v6uAPWcErh2g6vXcpQB3pwh9XmkkPfWLDi2bI5mgZlrfFBGfjeQ9Wv8iIQeddGuuYJGy
         vGYSJIu//+24XGZjzB+Q3VYOxZ5pJZ/HCGoJ5h7l6e1K0sxINKIjiYRXApyFQ3GXR7xJ
         ZclVjCWVjm/7Pu3pZxJbkPLxrnDwpix1sMzuU+AEqB9vICm+UZCWtOUOt5GLju8+nccL
         rTTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ralp0YsbeintaJ1+3rV0BJxcsbdnu/jVKuNhvnt0T5Y=;
        b=WQqkzuUeHWFkSqDf+02TOd92Yii82PLPpwpqnYoBnSIBXeV7Y5mmv6Xq2O4Bs1QHbo
         EL1KnfFdD7/OaRhxd0GJC9XeR0MD15VMQTz7HE16A/LQK9C5ko4PtLPa/K6eyX9J/0P9
         Tp9Rwh4Xh4MjHwijvA9jansNnwnq1uBuu8/hB4so7s7noymkj+6/Olk9iGTB6QTK2QwP
         3a2ER64A4rVdE/s2bUzoghH5fQtd3gd3UcehoB3G0uCb5cxkgSXVnXp2qhT6vu2Rm4h1
         gRxWF+rPMd8JtIfsK9g6TSP6ITkJr6Wm93TxlV+Ci2JZ/8hteDgXeCY3aZFEyrwJ3uwV
         clDA==
X-Gm-Message-State: AFqh2kqX96caEYBhpXJQdIlMHSG4yM400P7+E7gPY3HFWik56xqK/2Yn
        ivWtG9nHV6RlehY7xgQgftS2itSrQUE=
X-Google-Smtp-Source: AK7set8/stQqnGGz4OB/vqyDOBLoBX54VTTeagu3mMK0HzymWEEvjI0ujOzPLr/zvAsu1DJMDE0YK80W9/s=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:f7b0:20e8:ce66:f98])
 (user=surenb job=sendgmr) by 2002:a81:3e07:0:b0:506:6185:4fad with SMTP id
 l7-20020a813e07000000b0050661854fadmr450398ywa.451.1674635938431; Wed, 25 Jan
 2023 00:38:58 -0800 (PST)
Date:   Wed, 25 Jan 2023 00:38:46 -0800
In-Reply-To: <20230125083851.27759-1-surenb@google.com>
Mime-Version: 1.0
References: <20230125083851.27759-1-surenb@google.com>
X-Mailer: git-send-email 2.39.1.405.gd4c25cc71f-goog
Message-ID: <20230125083851.27759-2-surenb@google.com>
Subject: [PATCH v2 1/6] mm: introduce vma->vm_flags modifier functions
From:   Suren Baghdasaryan <surenb@google.com>
To:     akpm@linux-foundation.org
Cc:     michel@lespinasse.org, jglisse@google.com, mhocko@suse.com,
        vbabka@suse.cz, hannes@cmpxchg.org, mgorman@techsingularity.net,
        dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com,
        peterz@infradead.org, ldufour@linux.ibm.com, paulmck@kernel.org,
        luto@kernel.org, songliubraving@fb.com, peterx@redhat.com,
        david@redhat.com, dhowells@redhat.com, hughd@google.com,
        bigeasy@linutronix.de, kent.overstreet@linux.dev,
        punit.agrawal@bytedance.com, lstoakes@gmail.com,
        peterjung1337@gmail.com, rientjes@google.com,
        axelrasmussen@google.com, joelaf@google.com, minchan@google.com,
        jannh@google.com, shakeelb@google.com, tatashin@google.com,
        edumazet@google.com, gthelen@google.com, gurua@google.com,
        arjunroy@google.com, soheil@google.com, hughlynch@google.com,
        leewalsh@google.com, posk@google.com, will@kernel.org,
        aneesh.kumar@linux.ibm.com, npiggin@gmail.com,
        chenhuacai@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, richard@nod.at,
        anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net,
        qianweili@huawei.com, wangzhou1@hisilicon.com,
        herbert@gondor.apana.org.au, davem@davemloft.net, vkoul@kernel.org,
        airlied@gmail.com, daniel@ffwll.ch,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, l.stach@pengutronix.de,
        krzysztof.kozlowski@linaro.org, patrik.r.jakobsson@gmail.com,
        matthias.bgg@gmail.com, robdclark@gmail.com,
        quic_abhinavk@quicinc.com, dmitry.baryshkov@linaro.org,
        tomba@kernel.org, hjc@rock-chips.com, heiko@sntech.de,
        ray.huang@amd.com, kraxel@redhat.com, sre@kernel.org,
        mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
        tfiga@chromium.org, m.szyprowski@samsung.com, mchehab@kernel.org,
        dimitri.sivanich@hpe.com, zhangfei.gao@linaro.org,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        dgilbert@interlog.com, hdegoede@redhat.com, mst@redhat.com,
        jasowang@redhat.com, alex.williamson@redhat.com, deller@gmx.de,
        jayalk@intworks.biz, viro@zeniv.linux.org.uk, nico@fluxnic.net,
        xiang@kernel.org, chao@kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, miklos@szeredi.hu,
        mike.kravetz@oracle.com, muchun.song@linux.dev, bhe@redhat.com,
        andrii@kernel.org, yoshfuji@linux-ipv6.org, dsahern@kernel.org,
        kuba@kernel.org, pabeni@redhat.com, perex@perex.cz, tiwai@suse.com,
        haojian.zhuang@gmail.com, robert.jarzmik@free.fr,
        linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-graphics-maintainer@vmware.com,
        linux-ia64@vger.kernel.org, linux-arch@vger.kernel.org,
        loongarch@lists.linux.dev, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-sgx@vger.kernel.org,
        linux-um@lists.infradead.org, linux-acpi@vger.kernel.org,
        linux-crypto@vger.kernel.org, nvdimm@lists.linux.dev,
        dmaengine@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, etnaviv@lists.freedesktop.org,
        linux-samsung-soc@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org,
        linux-rockchip@lists.infradead.org, linux-tegra@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        xen-devel@lists.xenproject.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-rdma@vger.kernel.org, linux-media@vger.kernel.org,
        linux-accelerators@lists.ozlabs.org, sparclinux@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-staging@lists.linux.dev,
        target-devel@vger.kernel.org, linux-usb@vger.kernel.org,
        netdev@vger.kernel.org, linux-fbdev@vger.kernel.org,
        linux-aio@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
        devel@lists.orangefs.org, kexec@lists.infradead.org,
        linux-xfs@vger.kernel.org, bpf@vger.kernel.org,
        linux-perf-users@vger.kernel.org, kasan-dev@googlegroups.com,
        selinux@vger.kernel.org, alsa-devel@alsa-project.org,
        kernel-team@android.com, surenb@google.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

vm_flags are among VMA attributes which affect decisions like VMA merging
and splitting. Therefore all vm_flags modifications are performed after
taking exclusive mmap_lock to prevent vm_flags updates racing with such
operations. Introduce modifier functions for vm_flags to be used whenever
flags are updated. This way we can better check and control correct
locking behavior during these updates.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 include/linux/mm.h       | 37 +++++++++++++++++++++++++++++++++++++
 include/linux/mm_types.h |  8 +++++++-
 2 files changed, 44 insertions(+), 1 deletion(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index c2f62bdce134..b71f2809caac 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -627,6 +627,43 @@ static inline void vma_init(struct vm_area_struct *vma, struct mm_struct *mm)
 	INIT_LIST_HEAD(&vma->anon_vma_chain);
 }
 
+/* Use when VMA is not part of the VMA tree and needs no locking */
+static inline void init_vm_flags(struct vm_area_struct *vma,
+				 unsigned long flags)
+{
+	vma->vm_flags = flags;
+}
+
+/* Use when VMA is part of the VMA tree and modifications need coordination */
+static inline void reset_vm_flags(struct vm_area_struct *vma,
+				  unsigned long flags)
+{
+	mmap_assert_write_locked(vma->vm_mm);
+	init_vm_flags(vma, flags);
+}
+
+static inline void set_vm_flags(struct vm_area_struct *vma,
+				unsigned long flags)
+{
+	mmap_assert_write_locked(vma->vm_mm);
+	vma->vm_flags |= flags;
+}
+
+static inline void clear_vm_flags(struct vm_area_struct *vma,
+				  unsigned long flags)
+{
+	mmap_assert_write_locked(vma->vm_mm);
+	vma->vm_flags &= ~flags;
+}
+
+static inline void mod_vm_flags(struct vm_area_struct *vma,
+				unsigned long set, unsigned long clear)
+{
+	mmap_assert_write_locked(vma->vm_mm);
+	vma->vm_flags |= set;
+	vma->vm_flags &= ~clear;
+}
+
 static inline void vma_set_anonymous(struct vm_area_struct *vma)
 {
 	vma->vm_ops = NULL;
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 2d6d790d9bed..6c7c70bf50dd 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -491,7 +491,13 @@ struct vm_area_struct {
 	 * See vmf_insert_mixed_prot() for discussion.
 	 */
 	pgprot_t vm_page_prot;
-	unsigned long vm_flags;		/* Flags, see mm.h. */
+
+	/*
+	 * Flags, see mm.h.
+	 * WARNING! Do not modify directly.
+	 * Use {init|reset|set|clear|mod}_vm_flags() functions instead.
+	 */
+	unsigned long vm_flags;
 
 	/*
 	 * For areas with an address space and backing store,
-- 
2.39.1

