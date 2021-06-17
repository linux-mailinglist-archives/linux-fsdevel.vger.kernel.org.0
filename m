Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A7543AB05C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jun 2021 11:53:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231910AbhFQJzm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Jun 2021 05:55:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231613AbhFQJzl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Jun 2021 05:55:41 -0400
Received: from mail-ed1-x549.google.com (mail-ed1-x549.google.com [IPv6:2a00:1450:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65A91C06175F
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Jun 2021 02:53:33 -0700 (PDT)
Received: by mail-ed1-x549.google.com with SMTP id z5-20020a05640235c5b0290393974bcf7eso1214521edc.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Jun 2021 02:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=a+zdbgiBb9ArM5mcAv9PP3FFuftdHwNPy6WG5ezhuhg=;
        b=qxObvzoX4JdSGrxQ3ZuyPpBkDeRxJZg+BzJtMUVId5XO7aYRatSQFvH6BaFR5n1YYT
         ozu0EXR9FPJfKda227z7e6mgME/Njuw/mhM3Sqj0NDlnTfs3mOf7Zfqqunthk+Zi+Tpi
         3IFpuIYt7INLA9ujbK7GVHPR7irOutzijhzx2zywr+/kktXLCZk/yS0JJLFK8ct66m/6
         PRlsCJVmqVCYYUiZBNM0OKjvm6XcdSdQnpwQIy1Hz/MbzkgKHUvn3fC1fkph7vlazrFY
         Uh7euAWtna3Lk7mdeg6VNymy6MUoH5sF3CYu5Bj99IvKSlgMReTolU+nHXHVKLk3g2mq
         xT7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=a+zdbgiBb9ArM5mcAv9PP3FFuftdHwNPy6WG5ezhuhg=;
        b=CdcwmEENpj85WRFOzW/XjsgqZ3kzu+DHXxgSwdChPnEj7fyAao/7FyWWg2iNwFTOR6
         c6rdcus03XXPUISjsM2IIixYx/U8wi9uod2aDCjJ3s+++EAJliIa3R1tL0gE8Gqc4BG+
         YOCmOXP6eRNq0D7SxDPA4ZFtmyD3zdMbhehaf697aDmwtLPNZMkUsOkL98MM3Q4SlU1Z
         zSsgSFIEM7YgLw5dch0JaS1rO8+AHWp26LQeWXsqxUhp76uSch62Kqi6WUARq8Tc3jc6
         c72G56PWzmJXDQD2hcr8Uyvw96BVu7htJ3aopoobttaSKh5U8Bd5BAJxyomtUaqHuYXz
         0t1g==
X-Gm-Message-State: AOAM5312cY5vHPptKq7/c3iiC7IYCkPVaKN8ncRe1gKZX9pXEHFTUKZ3
        7Njhe5Eu2ZTvbj2Hi4uROwisOoOqFl0y3Dkk
X-Google-Smtp-Source: ABdhPJx+PI0fe7iUwOHHvsHwzw9nummcEoOdT9cgCgSTBXi6D0g39LHeXPVGfIyF2IUCTYY0OhGKjTEw6YgI+NNU
X-Received: from mklencke.zrh.corp.google.com ([2a00:79e0:48:202:aed9:dffa:ca7e:ac4d])
 (user=stapelberg job=sendgmr) by 2002:aa7:c547:: with SMTP id
 s7mr5202848edr.239.1623923611816; Thu, 17 Jun 2021 02:53:31 -0700 (PDT)
Date:   Thu, 17 Jun 2021 11:53:03 +0200
Message-Id: <20210617095309.3542373-1-stapelberg+linux@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.288.g62a8d224e6-goog
Subject: [PATCH] backing_dev_info: introduce min_bw/max_bw limits
From:   Michael Stapelberg <stapelberg+linux@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Michael Stapelberg <stapelberg+linux@google.com>,
        Tejun Heo <tj@kernel.org>, Dennis Zhou <dennis@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Roman Gushchin <guro@fb.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Jan Kara <jack@suse.cz>, Song Liu <song@kernel.org>,
        David Sterba <dsterba@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

These new knobs allow e.g. FUSE file systems to guide kernel memory
writeback bandwidth throttling.

Background:

When using mmap(2) to read/write files, the page-writeback code tries to
measure how quick file system backing devices (BDI) are able to write data,
so that it can throttle processes accordingly.

Unfortunately, certain usage patterns, such as linkers (tested with GCC,
but also the Go linker) seem to hit an unfortunate corner case when writing
their large executable output files: the kernel only ever measures
the (non-representative) rising slope of the starting bulk write, but the
whole file write is already over before the kernel could possibly measure
the representative steady-state.

As a consequence, with each program invocation hitting this corner case,
the FUSE write bandwidth steadily sinks in a downward spiral, until it
eventually reaches 0 (!). This results in the kernel heavily throttling
page dirtying in programs trying to write to FUSE, which in turn manifests
itself in slow or even entirely stalled linker processes.

Change:

This commit adds 2 knobs which allow avoiding this situation entirely on a
per-file-system basis by restricting the minimum/maximum bandwidth.

There are no negative effects expected from applying this patch.

At Google, we have been running this patch for about 1 year on many
thousands of developer PCs without observing any issues. Our in-house FUSE
filesystems pin the BDI write rate at its default setting of 100 MB/s,
which successfully prevents the bug described above.

Usage:

To inspect the measured bandwidth, check the BdiWriteBandwidth field in
e.g. /sys/kernel/debug/bdi/0:93/stats.

To pin the measured bandwidth to its default of 100 MB/s, use:

    echo 25600 > /sys/class/bdi/0:42/min_bw
    echo 25600 > /sys/class/bdi/0:42/max_bw

Notes:

For more discussion, including a test program for reproducing the issue,
see the following discussion thread on the Linux Kernel Mailing List:

https://lore.kernel.org/linux-fsdevel/CANnVG6n=3DySfe1gOr=3D0ituQidp56idGAR=
DKHzP0hv=3DERedeMrMA@mail.gmail.com/

Why introduce these knobs instead of trying to tweak the
throttling/measurement algorithm? The effort required to systematically
analyze, improve and land such an algorithm change exceeds the time budget
I have available. For comparison, check out this quote about the original
patch set from 2011: =E2=80=9CFengguang said he draw more than 10K performa=
nce
graphs and read even more in the past year.=E2=80=9D (from
http://bardofschool.blogspot.com/2011/). Given that nobody else has stepped
up, despite the problem being known since 2016, my suggestion is to add the
knobs until someone can spend significant time on a revision to the
algorithm.

Signed-off-by: Michael Stapelberg <stapelberg+linux@google.com>
---
 include/linux/backing-dev-defs.h |  2 ++
 include/linux/backing-dev.h      |  3 +++
 mm/backing-dev.c                 | 40 ++++++++++++++++++++++++++++++++
 mm/page-writeback.c              | 28 ++++++++++++++++++++++
 4 files changed, 73 insertions(+)

diff --git a/include/linux/backing-dev-defs.h b/include/linux/backing-dev-d=
efs.h
index 1d7edad9914f..e34797bb62a1 100644
--- a/include/linux/backing-dev-defs.h
+++ b/include/linux/backing-dev-defs.h
@@ -175,6 +175,8 @@ struct backing_dev_info {
 	unsigned int capabilities; /* Device capabilities */
 	unsigned int min_ratio;
 	unsigned int max_ratio, max_prop_frac;
+	u64 min_bw;
+	u64 max_bw;
=20
 	/*
 	 * Sum of avg_write_bw of wbs with dirty inodes.  > 0 if there are
diff --git a/include/linux/backing-dev.h b/include/linux/backing-dev.h
index 44df4fcef65c..bb812a4df3a1 100644
--- a/include/linux/backing-dev.h
+++ b/include/linux/backing-dev.h
@@ -107,6 +107,9 @@ static inline unsigned long wb_stat_error(void)
 int bdi_set_min_ratio(struct backing_dev_info *bdi, unsigned int min_ratio=
);
 int bdi_set_max_ratio(struct backing_dev_info *bdi, unsigned int max_ratio=
);
=20
+int bdi_set_min_bw(struct backing_dev_info *bdi, u64 min_bw);
+int bdi_set_max_bw(struct backing_dev_info *bdi, u64 max_bw);
+
 /*
  * Flags in backing_dev_info::capability
  *
diff --git a/mm/backing-dev.c b/mm/backing-dev.c
index 271f2ca862c8..0201345d41f2 100644
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -197,6 +197,44 @@ static ssize_t max_ratio_store(struct device *dev,
 }
 BDI_SHOW(max_ratio, bdi->max_ratio)
=20
+static ssize_t min_bw_store(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t count)
+{
+	struct backing_dev_info *bdi =3D dev_get_drvdata(dev);
+	unsigned long long limit;
+	ssize_t ret;
+
+	ret =3D kstrtoull(buf, 10, &limit);
+	if (ret < 0)
+		return ret;
+
+	ret =3D bdi_set_min_bw(bdi, limit);
+	if (!ret)
+		ret =3D count;
+
+	return ret;
+}
+BDI_SHOW(min_bw, bdi->min_bw)
+
+static ssize_t max_bw_store(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t count)
+{
+	struct backing_dev_info *bdi =3D dev_get_drvdata(dev);
+	unsigned long long limit;
+	ssize_t ret;
+
+	ret =3D kstrtoull(buf, 10, &limit);
+	if (ret < 0)
+		return ret;
+
+	ret =3D bdi_set_max_bw(bdi, limit);
+	if (!ret)
+		ret =3D count;
+
+	return ret;
+}
+BDI_SHOW(max_bw, bdi->max_bw)
+
 static ssize_t stable_pages_required_show(struct device *dev,
 					  struct device_attribute *attr,
 					  char *buf)
@@ -211,6 +249,8 @@ static struct attribute *bdi_dev_attrs[] =3D {
 	&dev_attr_read_ahead_kb.attr,
 	&dev_attr_min_ratio.attr,
 	&dev_attr_max_ratio.attr,
+	&dev_attr_min_bw.attr,
+	&dev_attr_max_bw.attr,
 	&dev_attr_stable_pages_required.attr,
 	NULL,
 };
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 9f63548f247c..1ee9636e6088 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -701,6 +701,22 @@ int bdi_set_max_ratio(struct backing_dev_info *bdi, un=
signed max_ratio)
 }
 EXPORT_SYMBOL(bdi_set_max_ratio);
=20
+int bdi_set_min_bw(struct backing_dev_info *bdi, u64 min_bw)
+{
+	spin_lock_bh(&bdi_lock);
+	bdi->min_bw =3D min_bw;
+	spin_unlock_bh(&bdi_lock);
+	return 0;
+}
+
+int bdi_set_max_bw(struct backing_dev_info *bdi, u64 max_bw)
+{
+	spin_lock_bh(&bdi_lock);
+	bdi->max_bw =3D max_bw;
+	spin_unlock_bh(&bdi_lock);
+	return 0;
+}
+
 static unsigned long dirty_freerun_ceiling(unsigned long thresh,
 					   unsigned long bg_thresh)
 {
@@ -1068,6 +1084,15 @@ static void wb_position_ratio(struct dirty_throttle_=
control *dtc)
 	dtc->pos_ratio =3D pos_ratio;
 }
=20
+static u64 clamp_bw(struct backing_dev_info *bdi, u64 bw)
+{
+	if (bdi->min_bw > 0 && bw < bdi->min_bw)
+		bw =3D bdi->min_bw;
+	if (bdi->max_bw > 0 && bw > bdi->max_bw)
+		bw =3D bdi->max_bw;
+	return bw;
+}
+
 static void wb_update_write_bandwidth(struct bdi_writeback *wb,
 				      unsigned long elapsed,
 				      unsigned long written)
@@ -1091,12 +1116,15 @@ static void wb_update_write_bandwidth(struct bdi_wr=
iteback *wb,
 	bw *=3D HZ;
 	if (unlikely(elapsed > period)) {
 		bw =3D div64_ul(bw, elapsed);
+		bw =3D clamp_bw(wb->bdi, bw);
 		avg =3D bw;
 		goto out;
 	}
 	bw +=3D (u64)wb->write_bandwidth * (period - elapsed);
 	bw >>=3D ilog2(period);
=20
+	bw =3D clamp_bw(wb->bdi, bw);
+
 	/*
 	 * one more level of smoothing, for filtering out sudden spikes
 	 */
--=20
2.32.0.288.g62a8d224e6-goog

