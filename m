Return-Path: <linux-fsdevel+bounces-73679-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A037DD1E96E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 12:57:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 374633049530
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 11:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAE54396D39;
	Wed, 14 Jan 2026 11:48:34 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D53839C649;
	Wed, 14 Jan 2026 11:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768391314; cv=none; b=MW7aNBDnYYw3MDZGJy1f+CX8h/j9HcQCJZppsuPyz8DO+Dzp0duogAqJ5krw5UawbXhJO2hqeXreFRDZNPk5D497nQLD9yCYEFoACAzyxdCFhuyV1XKEFQgNEe2dIGP3NSisymzrf+QTn6iO/cXwYH4ZsmZO3jSH/XiElHFszoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768391314; c=relaxed/simple;
	bh=wAAYAlIO0UmFZi/Es8txwA5DsgG9TK3GwB1vMaYxHnw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=umz0APclOPZp0luJmLbXw/Z6zEH4tCLO+JPackF+N9PLwwKoSI+42sEdVuZOlTL/D/1UZQifavQ2hj8E3qz0yIGI2iBxNvaCSS8eSxJF08+Rw4MO9ISPezHFKvELMxxX0hLi/GnGNa9LVukZnoZemCaAdFclkmhyA2+KDe2Jepw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D927E1424;
	Wed, 14 Jan 2026 03:48:19 -0800 (PST)
Received: from pluto.fritz.box (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2306F3F59E;
	Wed, 14 Jan 2026 03:48:22 -0800 (PST)
From: Cristian Marussi <cristian.marussi@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	arm-scmi@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: sudeep.holla@arm.com,
	james.quinlan@broadcom.com,
	f.fainelli@gmail.com,
	vincent.guittot@linaro.org,
	etienne.carriere@st.com,
	peng.fan@oss.nxp.com,
	michal.simek@amd.com,
	dan.carpenter@linaro.org,
	d-gole@ti.com,
	jonathan.cameron@huawei.com,
	elif.topuz@arm.com,
	lukasz.luba@arm.com,
	philip.radford@arm.com,
	souvik.chakravarty@arm.com,
	Cristian Marussi <cristian.marussi@arm.com>
Subject: [PATCH v2 17/17] [RFC] tools/scmi: Add SCMI Telemetry testing tool
Date: Wed, 14 Jan 2026 11:46:21 +0000
Message-ID: <20260114114638.2290765-18-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260114114638.2290765-1-cristian.marussi@arm.com>
References: <20260114114638.2290765-1-cristian.marussi@arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a testing tool that exercises the SCMI ioctls UAPI interface: as of
now the tool simply queries the initial state of the SCMI Telemetry
subsystem, tries to enable all the existent Data Events and dumps all
the Telemetry data.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
Basic implementation just to exercise a few IOCTls: to be refined and
extended to support a more interactive usage.
---
 tools/testing/scmi/Makefile |  25 +++
 tools/testing/scmi/stlm.c   | 385 ++++++++++++++++++++++++++++++++++++
 2 files changed, 410 insertions(+)
 create mode 100644 tools/testing/scmi/Makefile
 create mode 100644 tools/testing/scmi/stlm.c

diff --git a/tools/testing/scmi/Makefile b/tools/testing/scmi/Makefile
new file mode 100644
index 000000000000..a6a101f8398b
--- /dev/null
+++ b/tools/testing/scmi/Makefile
@@ -0,0 +1,25 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+CC?=$(CROSS_COMPILE)gcc
+OBJS = stlm.o
+
+CFLAGS=-Wall -static -std=gnu11 -I ../../../include/uapi/
+ifneq ($(DEBUG), )
+	CFLAGS+=-O0 -g -ggdb
+else
+	CFLAGS+=-static
+endif
+
+all: stlm
+
+stlm: $(OBJS)
+	$(CC) $(CFLAGS) $^ -o $@
+
+%.o: %.c
+	$(CC) $(CFLAGS) -c $<
+
+clean:
+	rm -f *.o
+	rm -f stlm
+
+.PHONY: clean
diff --git a/tools/testing/scmi/stlm.c b/tools/testing/scmi/stlm.c
new file mode 100644
index 000000000000..137ef278d1dd
--- /dev/null
+++ b/tools/testing/scmi/stlm.c
@@ -0,0 +1,385 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <errno.h>
+#include <fcntl.h>
+#include <stddef.h>
+#include <stdint.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/ioctl.h>
+
+#include <unistd.h>
+
+#include <linux/scmi.h>
+
+#define SLEEP_MS	3000
+#define DEF_TLM_ROOT	"/sys/fs/arm_telemetry/"
+
+#define IOCTL_ERR_STR(_ioctl)	"IOCTL:" #_ioctl
+
+struct tlm_de {
+	struct scmi_tlm_de_info *info;
+	struct scmi_tlm_de_config cfg;
+	struct scmi_tlm_de_sample sample;
+};
+
+struct tlm_group {
+	int fd;
+	struct scmi_tlm_grp_info *info;
+	struct scmi_tlm_grp_desc *desc;
+	struct scmi_tlm_intervals *ivs;
+};
+
+struct tlm_state {
+	int dfd;
+	int fd;
+	int g_dfd;
+	const char *path;
+	struct scmi_tlm_base_info info;
+	struct scmi_tlm_config cfg;
+	struct scmi_tlm_intervals *ivs;
+	unsigned int num_des;
+	struct tlm_de *des;
+	unsigned int num_groups;
+	struct tlm_group *grps;
+};
+
+static inline void dump_state(struct tlm_state *st)
+{
+	uint32_t *uuid32 = st->info.de_impl_version;
+	uint16_t *uuid16 = (uint16_t *)&st->info.de_impl_version[1];
+
+	fprintf(stdout, "- SYSTEM TELEMETRY @instance: %s\n\n", st->path);
+	fprintf(stdout, "+ Version: 0x%08X\n", st->info.version);
+	fprintf(stdout, "+ DEs#: %d\n", st->info.num_des);
+	fprintf(stdout, "+ GRPS#: %d\n", st->info.num_groups);
+	fprintf(stdout, "+ INTRV#: %d\n", st->info.num_intervals);
+
+	fprintf(stdout, "+ UUID: ");
+	fprintf(stdout, "%X-", uuid32[0]);
+	fprintf(stdout, "%X-", uuid16[0]);
+	fprintf(stdout, "%X-", uuid16[1]);
+	fprintf(stdout, "%X", uuid16[2]);
+	fprintf(stdout, "%X\n", uuid32[3]);
+
+	fprintf(stdout, "\n+ TLM_ENABLED: %d\n", st->cfg.enable);
+	fprintf(stdout, "+ CURRENT_UPDATE_INTERVAL: %d\n",
+		st->cfg.current_update_interval);
+
+	fprintf(stdout, "+ Found #%u Global Update Intervals\n",
+		st->info.num_intervals);
+	for (int i = 0; i < st->ivs->num; i++)
+		fprintf(stdout, "\t[%d]::%u\n", i, st->ivs->update_intervals[i]);
+
+	if (st->info.num_des != st->num_des) {
+		fprintf(stdout, "\n++++++ DES NOT FULLY_ENUMERATED ++++++\n");
+		fprintf(stdout, "+++ DECLARED:%u  ENUMERATED:%u +++\n",
+			st->info.num_des, st->num_des);
+	}
+
+	fprintf(stdout, "\n+ Found #%d DEs:\n", st->num_des);
+	for (int i = 0; i < st->num_des; i++)
+		fprintf(stdout, "\t0x%08X %s %s -- TS:%16llu %016llX\n",
+			st->des[i].info->id,
+			st->des[i].cfg.enable ? "ON" : "--",
+			st->des[i].cfg.t_enable ? "TS_ON" : "-----",
+			st->des[i].sample.tstamp, st->des[i].sample.val);
+	fprintf(stdout, "\n");
+
+	fprintf(stdout, "+ Found %d GRPs: ", st->num_groups);
+	for (int i = 0; i < st->num_groups; i++) {
+		fprintf(stdout, "\n\tGRP_ID:%d  DES#:%d  INTRVS#:%d\n",
+			st->grps[i].info->id, st->grps[i].info->num_des,
+			st->grps[i].info->num_intervals);
+
+		fprintf(stdout, "\tCOMPOSING_DES:");
+		for (int j = 0; j < st->grps[i].desc->num_des; j++)
+			fprintf(stdout, "0x%08X ",
+				st->grps[i].desc->composing_des[j]);
+		fprintf(stdout, "\n");
+	}
+}
+
+static int discover_base_info(int fd, struct scmi_tlm_base_info *info)
+{
+	int ret;
+
+	ret = ioctl(fd, SCMI_TLM_GET_INFO, info);
+	if (ret) {
+		perror(IOCTL_ERR_STR(SCMI_TLM_GET_INFO));
+		return ret;
+	}
+
+	return ret;
+}
+
+static struct scmi_tlm_des_list *scmi_get_des_list(int fd, int num_des)
+{
+	struct scmi_tlm_des_list *dsl;
+	size_t size = sizeof(*dsl) + num_des * sizeof(dsl->des[0]);
+	int ret;
+
+	dsl = malloc(size);
+	if (!dsl)
+		return NULL;
+
+	bzero(dsl, size);
+	dsl->num_des = num_des;
+	ret = ioctl(fd, SCMI_TLM_GET_DE_LIST, dsl);
+	if (ret) {
+		perror(IOCTL_ERR_STR(SCMI_TLM_GET_DE_LIST));
+		return NULL;
+	}
+
+	return dsl;
+}
+
+static struct tlm_de *enumerate_des(struct tlm_state *st)
+{
+	struct scmi_tlm_des_list *dsl;
+	struct tlm_de *des;
+
+	dsl = scmi_get_des_list(st->fd, st->info.num_des);
+	if (!dsl)
+		return NULL;
+
+	st->num_des = dsl->num_des;
+	des = malloc(sizeof(*des) * st->num_des);
+	if (!des)
+		return NULL;
+
+	bzero(des, sizeof(*des) * st->num_des);
+	for (int i = 0; i < st->num_des; i++) {
+		struct tlm_de *de = &des[i];
+		int ret;
+
+		de->info = &dsl->des[i];
+		de->cfg.id = de->info->id;
+		ret = ioctl(st->fd, SCMI_TLM_GET_DE_CFG, &de->cfg);
+		if (ret) {
+			perror(IOCTL_ERR_STR(SCMI_TLM_GET_DE_CFG));
+			continue;
+		}
+
+		if (!de->cfg.enable)
+			continue;
+
+		/* Collect initial sample */
+		de->sample.id = de->info->id;
+		ret = ioctl(st->fd, SCMI_TLM_GET_DE_VALUE, &de->sample);
+		if (ret) {
+			perror(IOCTL_ERR_STR(SCMI_TLM_GET_DE_VALUE));
+			continue;
+		}
+	}
+
+	return des;
+}
+
+static int get_current_config(int fd, struct scmi_tlm_config *cfg)
+{
+	int ret;
+
+	ret = ioctl(fd, SCMI_TLM_GET_CFG, cfg);
+	if (ret) {
+		perror(IOCTL_ERR_STR(SCMI_TLM_GET_CFG));
+		return ret;
+	}
+
+	return ret;
+}
+
+static struct scmi_tlm_grps_list *scmi_get_grps_list(int fd, int num_groups)
+{
+	struct scmi_tlm_grps_list *gsl;
+	size_t size = sizeof(*gsl) + num_groups * sizeof(gsl->grps[0]);
+	int ret;
+
+	gsl = malloc(size);
+	if (!gsl)
+		return NULL;
+
+	bzero(gsl, size);
+	gsl->num_grps = num_groups;
+	ret = ioctl(fd, SCMI_TLM_GET_GRP_LIST, gsl);
+	if (ret) {
+		perror(IOCTL_ERR_STR(SCMI_TLM_GET_GRP_LIST));
+		return NULL;
+	}
+
+	return gsl;
+}
+
+static struct scmi_tlm_intervals *enumerate_intervals(int fd, int num_intervals)
+{
+	struct scmi_tlm_intervals *ivs;
+	size_t sz;
+	int ret;
+
+	sz = sizeof(*ivs) + sizeof(*ivs->update_intervals) * num_intervals;
+	ivs = malloc(sz);
+	if (!ivs)
+		return NULL;
+
+	memset(ivs, 0, sz);
+
+	ivs->num = num_intervals;
+	ret = ioctl(fd, SCMI_TLM_GET_INTRVS, ivs);
+	if (ret) {
+		perror(IOCTL_ERR_STR(SCMI_TLM_GET_INTRVS));
+		free(ivs);
+		return NULL;
+	}
+
+	return ivs;
+}
+
+static struct tlm_group *enumerate_groups(struct tlm_state *st)
+{
+	struct scmi_tlm_grps_list *gsl;
+	struct tlm_group *grps;
+
+	gsl = scmi_get_grps_list(st->fd, st->info.num_groups);
+	if (!gsl)
+		return NULL;
+
+	st->g_dfd = openat(st->dfd, "groups", O_RDONLY);
+	if (st->g_dfd < 0)
+		return NULL;
+
+	st->num_groups = gsl->num_grps;
+	grps = malloc(sizeof(*grps) * st->num_groups);
+	if (!grps)
+		return NULL;
+
+	bzero(grps, sizeof(*grps) * st->num_groups);
+	for (int i = 0; i < st->num_groups; i++) {
+		struct tlm_group *grp = &grps[i];
+		char gctrl[32];
+		size_t size;
+		int ret;
+
+		snprintf(gctrl, 32, "%d/control", i);
+		grp->fd = openat(st->g_dfd, gctrl, O_RDWR);
+		if (grp->fd < 0)
+			return NULL;
+
+		grp->info = &gsl->grps[i];
+		size = sizeof(*grp->desc) + sizeof(uint32_t) * grp->info->num_des;
+		grp->desc = malloc(size);
+		if (!grp->desc)
+			return NULL;
+
+		bzero(grp->desc, size);
+		grp->desc->num_des = grp->info->num_des;
+		ret = ioctl(grp->fd, SCMI_TLM_GET_GRP_DESC, grp->desc);
+		if (ret) {
+			perror(IOCTL_ERR_STR(SCMI_TLM_GET_GRP_DESC));
+			continue;
+		}
+
+		grp->ivs = enumerate_intervals(grp->fd, grp->info->num_intervals);
+	}
+
+	return grps;
+}
+
+static int get_tlm_state(const char *path, struct tlm_state *st)
+{
+	int ret;
+
+	st->dfd = open(path, O_RDONLY);
+	if (st->dfd < 0) {
+		perror("open");
+		return st->dfd;
+	}
+
+	st->fd = openat(st->dfd, "control", O_RDWR);
+	if (st->fd < 0) {
+		perror("openat");
+		return st->fd;
+	}
+
+	ret = discover_base_info(st->fd, &st->info);
+	if (ret)
+		return ret;
+
+	st->ivs = enumerate_intervals(st->fd, st->info.num_intervals);
+	if (!st->ivs)
+		return -1;
+
+	ret = get_current_config(st->fd, &st->cfg);
+	if (ret)
+		return ret;
+
+	if (st->info.num_des)
+		st->des = enumerate_des(st);
+
+	if (st->info.num_groups)
+		st->grps = enumerate_groups(st);
+
+	st->path = path;
+
+	return 0;
+}
+
+int main(int argc, char **argv)
+{
+	const char *tlm_root_instance = DEF_TLM_ROOT "tlm_0/";
+	struct scmi_tlm_data_read *bulk;
+	struct scmi_tlm_de_config de_cfg = {};
+	struct tlm_state st = {};
+	size_t bulk_sz;
+	int ret;
+
+	ret = get_tlm_state(tlm_root_instance, &st);
+	if (ret)
+		return ret;
+
+	dump_state(&st);
+
+	bulk_sz = sizeof(*bulk) + sizeof(bulk->samples[0]) * st.info.num_des;
+	bulk = malloc(bulk_sz);
+	if (!bulk)
+		return -1;
+
+	bzero(bulk, bulk_sz);
+	bulk->num_samples = st.info.num_des;
+	ret = ioctl(st.fd, SCMI_TLM_SINGLE_SAMPLE, bulk);
+	if (ret) {
+		perror(IOCTL_ERR_STR(SCMI_TLM_SINGLE_SAMPLE));
+		return -1;
+	}
+
+	fprintf(stdout, "\n--- Enabling ALL DEs with timestamp...\n");
+	de_cfg.enable = 1;
+	de_cfg.t_enable = 1;
+	ret = ioctl(st.fd, SCMI_TLM_SET_ALL_CFG, &de_cfg);
+	if (ret) {
+		perror(IOCTL_ERR_STR(SCMI_TLM_SET_ALL_CFG));
+		return ret;
+	}
+
+	fprintf(stdout, "\n- Single ASYNC read -\n-------------------\n");
+	for (int i = 0; i < bulk->num_samples; i++)
+		fprintf(stdout, "0x%08X %016llu %016llX\n",
+			bulk->samples[i].id, bulk->samples[i].tstamp,
+			bulk->samples[i].val);
+
+	bzero(bulk, bulk_sz);
+	bulk->num_samples = st.info.num_des;
+	ret = ioctl(st.fd, SCMI_TLM_BULK_READ, bulk);
+	if (ret) {
+		perror(IOCTL_ERR_STR(SCMI_TLM_BULK_READ));
+		return -1;
+	}
+
+	fprintf(stdout, "\n- BULK read -\n-------------------\n");
+	for (int i = 0; i < bulk->num_samples; i++)
+		fprintf(stdout, "0x%08X %016llu %016llX\n",
+			bulk->samples[i].id, bulk->samples[i].tstamp,
+			bulk->samples[i].val);
+
+	return 0;
+}
-- 
2.52.0


