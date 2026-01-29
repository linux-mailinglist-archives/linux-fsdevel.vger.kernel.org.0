Return-Path: <linux-fsdevel+bounces-75904-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0GtSNfDLe2lHIgIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75904-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 22:06:56 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7539CB47C5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 22:06:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C6D7C3031B28
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 21:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9340335D5E3;
	Thu, 29 Jan 2026 21:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="QmxxnYP9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f195.google.com (mail-qk1-f195.google.com [209.85.222.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 417E635D603
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Jan 2026 21:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769720712; cv=none; b=oo744Qknf7QeNi3e91dDCSxEdMB9SJH/iGjc45NGjrTGobiFhWh3EBDpkjl4VUKp5Ej1QN4SEF8AOwwYNe5IYFSsiLHf5bSwXs1JOJZw3z7DmLzgYzWclRAdj3MwkDsc5tgRT6K6irlIKwMGZXcNl4AR8MF1/Sax21w44U+JmcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769720712; c=relaxed/simple;
	bh=Ysme87URA8h80dz3v+yZIs8qliOaAmjArpOmGNPSVUI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q12wH/UX6o2UtSPZJDc16FQZ2irATjI6mvGcTZmmIWdvJEhWppyHu22wYM4mlICRQ8shpIJEU1ZNXg2t27DcdWogulObUYpj3//iSogdaTFebRUdnFmR6KvBu7fHYs6Utoe0vxF8vRyI+k3AooDzgjmKXSvi223B+fhLXnpQzaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=QmxxnYP9; arc=none smtp.client-ip=209.85.222.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f195.google.com with SMTP id af79cd13be357-8c5389c3cd2so144008285a.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Jan 2026 13:05:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1769720708; x=1770325508; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2izjfMr9wFUktZXLnWxTLQ+Uf13Bf1lvXAJZzNDICcs=;
        b=QmxxnYP9qHqlX5teNx+fVssa6DDhCzWbcI8iRZ9qLS4T3A29ArWI7Yu3NRGNyq7euZ
         lqS8/NeIgmYLUmi3GxySKkroid0G1b8vXKX8PuW+mBk+QAsPcXm470wilU6yfHMowbMQ
         epubSFk+CkBbixUrXGBerZKw/U2NoQNczMzprZ3AAX5Vr4AAANFC+JxzGKEhZRtMnzyX
         3uMSJN4OYc/7dS8I08Oi6iLXveO1yZywqcVZWP8h2zJVsLGxWo5p3Y+HyIN0+nXXxCG2
         RIDF1t++cOFMIw+zzv37v6DELRkVluXfCMfnVsxP3zbA07W7t3eAL+1Sm5+JJXYZFojP
         yztg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769720708; x=1770325508;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2izjfMr9wFUktZXLnWxTLQ+Uf13Bf1lvXAJZzNDICcs=;
        b=cV+dzWDapR1gaRSSYG193vECTjMqk9d52zagUjYFMvd7S26RbzOqBSva+oU7rhCuTl
         xxuMqjJV5RE4U6I/0kdel0HsHO7Xx0B0MVRaQCDsG03D39YQUPHahghTSQdjh0PJX4PO
         kBpoGRxQ9upncjyEEIqEUhc0A9qp4Va80uYODx4MwSXiJL9dIoRuPZJo4bcQdpceY7BT
         xCXc1l5eGo9IdwGW3ymHd9ULHpNRK0oR+s8FOkW6xGJfa/P8Mj6KbxwS9EW7sq4hQC14
         PR2mas1TmN26a6zl9E07DUek7d+IQElnq5eZhdxBuQL+SeOP+gWpyIQXOYWXd5Q9RaDA
         goiw==
X-Forwarded-Encrypted: i=1; AJvYcCWGSFtRnBPLHA+LC7ddkPQLTymILVDHkLljBJAVEfXnoWbTZqcpCsgSUWWOBsBMI0BYnK/deAfCxvSWjx/X@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/cRVZWfWijXtb5lDN0mf5jZ59iJPGyEO15YFP3eRuhpoTsC3y
	eIp//Qf4g9mF0n8QxYwGViwavHB6JgzlCgHOQaJm4Lqlq+OXYABGGR0a3ncoqF/1ET1pwSZ7g6q
	b427gfen5OA==
X-Gm-Gg: AZuq6aLI9qog2Zua36yeEQ0s3NRdVLt/NUq8OetDpI/Dn/j8O4ionI0IVhuN/wTu1as
	xs7Ri9FJ+PcH4mxwlUg6Yd3Ppc0UnAGPQlpbgeQWjR6SRaUrhUbkVJ1XjL7cn5JN3MT2Xnon98e
	ZNu3N+4oEYBf6SS4MkcoJfs0r6HLuXn/S9zsOotE3lwkMAuUsSYe+SuaRR6IJq3gLjQpyYuL8/o
	pgOCP9zVaFgbh2SeKnQlDkl8nGTtC9LRkbIYmv0s1drN3/BN0pXCGEQxhRMDUmLfyVNP8XsGKgH
	HwLm0kv+Pv9hAiDTHjmlHQv0G3A36BS9/9C8AFk5CI0vJPCxD6sUczqt+A11pj4Loue8+AML3yq
	YcTwkuA2sg01T60inANX8SYUB0LzYPX0lP8ZKMsx1+NTPNOfSYij/iOjErs83SauS6dM0l3SNGU
	JNLmuop8gZ68tKExNaKJjBSgW+UjAgxsc3+bqoqKuoCkPBgFj2KyOGI8VddmTMlY55lFan1UlG6
	ST64X6lXbPGmA==
X-Received: by 2002:a05:620a:2845:b0:8a4:e7f6:bf57 with SMTP id af79cd13be357-8c9eb258c5dmr134323385a.5.1769720708025;
        Thu, 29 Jan 2026 13:05:08 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F.lan (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c71b859eaesm282041685a.46.2026.01.29.13.05.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 13:05:07 -0800 (PST)
From: Gregory Price <gourry@gourry.net>
To: linux-mm@kvack.org
Cc: linux-cxl@vger.kernel.org,
	nvdimm@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	kernel-team@meta.com,
	dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	willy@infradead.org,
	jack@suse.cz,
	terry.bowman@amd.com,
	john@jagalactic.com
Subject: [PATCH 9/9] Documentation/driver-api/cxl: add dax and sysram driver documentation
Date: Thu, 29 Jan 2026 16:04:42 -0500
Message-ID: <20260129210442.3951412-10-gourry@gourry.net>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260129210442.3951412-1-gourry@gourry.net>
References: <20260129210442.3951412-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gourry.net:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gourry.net:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[gourry.net];
	TAGGED_FROM(0.00)[bounces-75904-lists,linux-fsdevel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gourry@gourry.net,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gourry.net:email,gourry.net:dkim,gourry.net:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7539CB47C5
X-Rspamd-Action: no action

Explain the binding process for sysram and daxdev regions which are
explicit about which dax driver to use during region creation.

Jonathan Corbet <corbet@lwn.net> 
Signed-off-by: Gregory Price <gourry@gourry.net>
---
 .../driver-api/cxl/linux/cxl-driver.rst       | 43 +++++++++++++++++++
 .../driver-api/cxl/linux/dax-driver.rst       | 29 +++++++++++++
 2 files changed, 72 insertions(+)

diff --git a/Documentation/driver-api/cxl/linux/cxl-driver.rst b/Documentation/driver-api/cxl/linux/cxl-driver.rst
index dd6dd17dc536..1f857345e896 100644
--- a/Documentation/driver-api/cxl/linux/cxl-driver.rst
+++ b/Documentation/driver-api/cxl/linux/cxl-driver.rst
@@ -445,6 +445,49 @@ for more details. ::
     dax0.0      devtype  modalias   uevent
     dax_region  driver   subsystem
 
+DAX regions are created when a CXL RAM region is bound to one of the
+following drivers:
+
+* :code:`cxl_devdax_region` - Creates a dax_region for device_dax mode.
+  The resulting DAX device provides direct userspace access via
+  :code:`/dev/daxN.Y`.
+
+* :code:`cxl_dax_kmem_region` - Creates a dax_region for kmem mode via a
+  sysram_region intermediate device.  See `Sysram Region`_ below.
+
+Sysram Region
+~~~~~~~~~~~~~
+A `Sysram Region` is an intermediate device between a CXL `Memory Region`
+and a `DAX Region` for kmem mode.  It is created when a CXL RAM region is
+bound to the :code:`cxl_sysram_region` driver.
+
+The sysram_region device provides an interposition point where users can
+configure memory hotplug policy before the underlying dax_region is created
+and memory is hotplugged to the system.
+
+The device hierarchy for kmem mode is::
+
+  regionX -> sysram_regionX -> dax_regionX -> daxX.Y
+
+The sysram_region exposes an :code:`online_type` attribute that controls
+how memory will be onlined when the dax_kmem driver binds:
+
+* :code:`invalid` - Not configured (default). Blocks driver binding.
+* :code:`offline` - Memory will not be onlined automatically.
+* :code:`online` - Memory will be onlined in ZONE_NORMAL.
+* :code:`online_movable` - Memory will be onlined in ZONE_MOVABLE.
+
+Example two-stage binding process::
+
+  # Bind region to sysram_region driver
+  echo region0 > /sys/bus/cxl/drivers/cxl_sysram_region/bind
+
+  # Configure memory online type
+  echo online_movable > /sys/bus/cxl/devices/sysram_region0/online_type
+
+  # Bind sysram_region to dax_kmem_region driver
+  echo sysram_region0 > /sys/bus/cxl/drivers/cxl_dax_kmem_region/bind
+
 Mailbox Interfaces
 ------------------
 A mailbox command interface for each device is exposed in ::
diff --git a/Documentation/driver-api/cxl/linux/dax-driver.rst b/Documentation/driver-api/cxl/linux/dax-driver.rst
index 10d953a2167b..2b8e21736292 100644
--- a/Documentation/driver-api/cxl/linux/dax-driver.rst
+++ b/Documentation/driver-api/cxl/linux/dax-driver.rst
@@ -17,6 +17,35 @@ The DAX subsystem exposes this ability through the `cxl_dax_region` driver.
 A `dax_region` provides the translation between a CXL `memory_region` and
 a `DAX Device`.
 
+CXL DAX Region Drivers
+======================
+CXL provides multiple drivers for creating DAX regions, each suited for
+different use cases:
+
+cxl_devdax_region
+-----------------
+The :code:`cxl_devdax_region` driver creates a dax_region configured for
+device_dax mode.  When a CXL RAM region is bound to this driver, the
+resulting DAX device provides direct userspace access via :code:`/dev/daxN.Y`.
+
+Device hierarchy::
+
+  regionX -> dax_regionX -> daxX.Y
+
+This is the simplest path for applications that want to manage CXL memory
+directly from userspace.
+
+cxl_dax_kmem_region
+-------------------
+For kmem mode, CXL provides a two-stage binding process that allows users
+to configure memory hotplug policy before memory is added to the system.
+
+The :code:`cxl_dax_kmem_region` driver then binds a sysram_region
+device and creates a dax_region configured for kmem mode.
+
+The :code:`online_type` policy will be passed from sysram_region to
+the dax kmem driver for use when hotplugging the memory.
+
 DAX Device
 ==========
 A `DAX Device` is a file-like interface exposed in :code:`/dev/daxN.Y`. A
-- 
2.52.0


