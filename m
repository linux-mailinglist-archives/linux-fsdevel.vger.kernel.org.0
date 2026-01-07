Return-Path: <linux-fsdevel+bounces-72661-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A891CFFC82
	for <lists+linux-fsdevel@lfdr.de>; Wed, 07 Jan 2026 20:37:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 84C97324FE7D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jan 2026 18:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A248939A80F;
	Wed,  7 Jan 2026 15:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bMuO/cKD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E6739A800
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 Jan 2026 15:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767800115; cv=none; b=I80UdVHnXkCmuDrs3xJS/8n6z6qbbllP0yHXfEKYl8QKy+kcJauV+hXsdnnPnmyyOvEJBfVfL2+AVx3ZnOnvrrjHD3IazhHPqjemotv8qQg6DZGuLym9Pd0cA+GdeapXkUaGE7M/GS4Zjin/ZgEM7AYGpp3eAb9F3+PPHSiC32c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767800115; c=relaxed/simple;
	bh=UH7UVmm/ifZMz2a7ctzEVAj9QL1YqJfv9TEsJAmqvl0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tk5kRCRy4NoDc6AzDF18+x3mytUi7N1FhEpJZbNAb0C+EPecitTEKLtE/0Dq/znH1sfzLoF7W7LbwXkU8HcsNmjjK8aMOpDqhGUXBVowV8d5HTKTGGZ+vi5jXM0h/O+5zhU8D55i4Gwf4ATvqhxAtwX7rZgQiAWeYEdv3hMoQUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bMuO/cKD; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-455af5758fdso1395305b6e.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 Jan 2026 07:35:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767800110; x=1768404910; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ezmCIUYTCpc47N9MRFviC1UdzpKfkRUPsUPtXb573Uk=;
        b=bMuO/cKDgBQ7MDSk9U5rZupNeiODJwTx7I9gFDCFydqoRNF5bb5XBxGm7iO3pn2zmN
         RJWqRTwynU8DZ/Me9oX3OL1LfaPxg14B7bdiRmWRZS4TZHssZrk3Ihp97s+ZtjHgWNh8
         YIjNdzcT0FtM+bnOwTgYOjNB8SCxhrBqERxthL0J3Mt/FA+v5wfAwF54UwLNOv5dmsA0
         EcVHjxwIK7HTCh57TbkiagniQE4U0EG04F69w+iLXXUK3kwMCPRTkYLC444XDiw9oYf5
         aXZlR7uvFrBdaNyQhR/ylbn4O75Y8KrKto8jynUQU7yvwgquWvo1bIsqDzcVZzo4TFGl
         9tBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767800110; x=1768404910;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ezmCIUYTCpc47N9MRFviC1UdzpKfkRUPsUPtXb573Uk=;
        b=LQ5kfol3t1GJ5qvwIT85eLW6LIq0yvoSt4w73rIW4zMQJztH7/gUAjV/tbtInhs0zr
         27ehTkZDPj3osrjz7u0823uQkL3n3rYXBkmOZooI/WSoqe/+yVSTKIS6ztkyZgsQGaKU
         QTjMEy23CdpJgdtmPjaszQABGMCGRY+QtS+UC1NzQOkFizfwnyHV6xHVeKUQzj52r1Rh
         jtfj+g67WYfcR74YMOqwJxverVdxkMvrnL3lQAH+6W3JJNJFjl6WNoADLP/jjg6DhL3h
         O9mVgwY0bFzsvdNktjhFmrdVTDt23ODha0S9v8HgSu+TpigRljv/qyUfcTXWVgplDTAa
         fzHw==
X-Forwarded-Encrypted: i=1; AJvYcCW5Z1Fich3efw08MJh0+IyEXPyXqGY31kNkhDSlmBDDtG5mJLI6wEmTRG+aEXxclLE2eVd1YRfKLgx3o/XY@vger.kernel.org
X-Gm-Message-State: AOJu0YxEn4potuFRkemeUnNug2HkRPhH68KS6hKcdra8DlsNO2iGGshY
	KywknYqtbkDwiDMlEU6xK5zlG6q7F14U1ZIAS3qSKcnYS4fLQSjIqYEz
X-Gm-Gg: AY/fxX7hbZhcIPX9baoY+BhlSZIaMGm5S5EY9nBwNN2hXqT4IT/zdG5zR9BBvwVmKAd
	rVC30DF+0WK7G+JmmADpBt0WYmCvu9PUIIGdArXlrfVFOGOmb8YUB43M/itkWUW6UJAinItRBLb
	sgn3QQAAY9Irb2dlSOeREri8FBo32ZrJOktuqExFrsFRi2ZF7XF+VqrBzhOCaMLWF7Xlld4Lhn1
	1xJ6tG871u0bU7BnEjWxQ9laoEnIfjCetSH+XPuONJ2uDSsrvkSpg74XMn5B8p23VMilkTrOm01
	4ogz9YHY3aIUMYz39JWtYOOJz69vQEwkjJEBr0JRR/CV+agAdE0SENX2eUuSzbxnd6yLTAE2NKh
	oBBCZsG/BMLjo7B1m5YzoiZYx/56MIr2pm4YzNqqCL/EG7sbO2vYkvit4+Mgf1vC6z8Jegy729n
	1v2H8K2hDvAvbcuXTWWTqEuCm2ck5bGyB/vZEnEzNqEx6p
X-Google-Smtp-Source: AGHT+IHvJerAp0F2qVu0ANwUQaq5jdMW03NUN3RN1p6cxOBwInFyFNG7vh1+02TkB75u28LmDWlVDQ==
X-Received: by 2002:a05:6808:2208:b0:459:bcff:a9ff with SMTP id 5614622812f47-45a6be8b053mr1272252b6e.34.1767800109996;
        Wed, 07 Jan 2026 07:35:09 -0800 (PST)
Received: from localhost.localdomain ([2603:8080:1500:3d89:a917:5124:7300:7cef])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-45a5e183cd4sm2415499b6e.1.2026.01.07.07.35.07
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 07 Jan 2026 07:35:09 -0800 (PST)
Sender: John Groves <grovesaustin@gmail.com>
From: John Groves <John@Groves.net>
X-Google-Original-From: John Groves <john@groves.net>
To: John Groves <John@Groves.net>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Dan Williams <dan.j.williams@intel.com>,
	Bernd Schubert <bschubert@ddn.com>,
	Alison Schofield <alison.schofield@intel.com>
Cc: John Groves <jgroves@micron.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Matthew Wilcox <willy@infradead.org>,
	Jan Kara <jack@suse.cz>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	David Hildenbrand <david@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Jeff Layton <jlayton@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Stefan Hajnoczi <shajnocz@redhat.com>,
	Joanne Koong <joannelkoong@gmail.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Chen Linxuan <chenlinxuan@uniontech.com>,
	James Morse <james.morse@arm.com>,
	Fuad Tabba <tabba@google.com>,
	Sean Christopherson <seanjc@google.com>,
	Shivank Garg <shivankg@amd.com>,
	Ackerley Tng <ackerleytng@google.com>,
	Gregory Price <gourry@gourry.net>,
	Aravind Ramesh <arramesh@micron.com>,
	Ajay Joshi <ajayjoshi@micron.com>,
	venkataravis@micron.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nvdimm@lists.linux.dev,
	linux-cxl@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	John Groves <john@groves.net>
Subject: [PATCH 2/2] Add test/daxctl-famfs.sh to test famfs mode transitions:
Date: Wed,  7 Jan 2026 09:34:59 -0600
Message-ID: <20260107153459.64821-3-john@groves.net>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260107153459.64821-1-john@groves.net>
References: <20260107153244.64703-1-john@groves.net>
 <20260107153459.64821-1-john@groves.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: John Groves <John@Groves.net>

- devdax <-> famfs mode switches
- Verify famfs -> system-ram is rejected (must go via devdax)
- Test JSON output shows correct mode
- Test error handling for invalid modes

The test is added to the destructive test suite since it
modifies device modes.

Signed-off-by: John Groves <john@groves.net>
---
 test/daxctl-famfs.sh | 253 +++++++++++++++++++++++++++++++++++++++++++
 test/meson.build     |   2 +
 2 files changed, 255 insertions(+)
 create mode 100755 test/daxctl-famfs.sh

diff --git a/test/daxctl-famfs.sh b/test/daxctl-famfs.sh
new file mode 100755
index 0000000..12fbfef
--- /dev/null
+++ b/test/daxctl-famfs.sh
@@ -0,0 +1,253 @@
+#!/bin/bash -Ex
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2025 Micron Technology, Inc. All rights reserved.
+#
+# Test daxctl famfs mode transitions and mode detection
+
+rc=77
+. $(dirname $0)/common
+
+trap 'cleanup $LINENO' ERR
+
+daxdev=""
+original_mode=""
+
+cleanup()
+{
+	printf "Error at line %d\n" "$1"
+	# Try to restore to original mode if we know it
+	if [[ $daxdev && $original_mode ]]; then
+		"$DAXCTL" reconfigure-device -f -m "$original_mode" "$daxdev" 2>/dev/null || true
+	fi
+	exit $rc
+}
+
+# Check if fsdev_dax module is available
+check_fsdev_dax()
+{
+	if modinfo fsdev_dax &>/dev/null; then
+		return 0
+	fi
+	if grep -qF "fsdev_dax" "/lib/modules/$(uname -r)/modules.builtin" 2>/dev/null; then
+		return 0
+	fi
+	printf "fsdev_dax module not available, skipping\n"
+	exit 77
+}
+
+# Check if kmem module is available (needed for system-ram mode tests)
+check_kmem()
+{
+	if modinfo kmem &>/dev/null; then
+		return 0
+	fi
+	if grep -qF "kmem" "/lib/modules/$(uname -r)/modules.builtin" 2>/dev/null; then
+		return 0
+	fi
+	printf "kmem module not available, skipping system-ram tests\n"
+	return 1
+}
+
+# Find an existing dax device to test with
+find_daxdev()
+{
+	# Look for any available dax device
+	daxdev=$("$DAXCTL" list | jq -er '.[0].chardev // empty' 2>/dev/null) || true
+
+	if [[ ! $daxdev ]]; then
+		printf "No dax device found, skipping\n"
+		exit 77
+	fi
+
+	# Save the original mode so we can restore it
+	original_mode=$("$DAXCTL" list -d "$daxdev" | jq -er '.[].mode')
+
+	printf "Found dax device: %s (current mode: %s)\n" "$daxdev" "$original_mode"
+}
+
+daxctl_get_mode()
+{
+	"$DAXCTL" list -d "$1" | jq -er '.[].mode'
+}
+
+# Ensure device is in devdax mode for testing
+ensure_devdax_mode()
+{
+	local mode
+	mode=$(daxctl_get_mode "$daxdev")
+
+	if [[ "$mode" == "devdax" ]]; then
+		return 0
+	fi
+
+	if [[ "$mode" == "system-ram" ]]; then
+		printf "Device is in system-ram mode, attempting to convert to devdax...\n"
+		"$DAXCTL" reconfigure-device -f -m devdax "$daxdev"
+	elif [[ "$mode" == "famfs" ]]; then
+		printf "Device is in famfs mode, converting to devdax...\n"
+		"$DAXCTL" reconfigure-device -m devdax "$daxdev"
+	else
+		printf "Device is in unknown mode: %s\n" "$mode"
+		return 1
+	fi
+
+	[[ $(daxctl_get_mode "$daxdev") == "devdax" ]]
+}
+
+#
+# Test basic mode transitions involving famfs
+#
+test_famfs_mode_transitions()
+{
+	printf "\n=== Testing famfs mode transitions ===\n"
+
+	# Ensure starting in devdax mode
+	ensure_devdax_mode
+	[[ $(daxctl_get_mode "$daxdev") == "devdax" ]]
+	printf "Initial mode: devdax - OK\n"
+
+	# Test: devdax -> famfs
+	printf "Testing devdax -> famfs... "
+	"$DAXCTL" reconfigure-device -m famfs "$daxdev"
+	[[ $(daxctl_get_mode "$daxdev") == "famfs" ]]
+	printf "OK\n"
+
+	# Test: famfs -> famfs (re-enable in same mode)
+	printf "Testing famfs -> famfs (re-enable)... "
+	"$DAXCTL" reconfigure-device -m famfs "$daxdev"
+	[[ $(daxctl_get_mode "$daxdev") == "famfs" ]]
+	printf "OK\n"
+
+	# Test: famfs -> devdax
+	printf "Testing famfs -> devdax... "
+	"$DAXCTL" reconfigure-device -m devdax "$daxdev"
+	[[ $(daxctl_get_mode "$daxdev") == "devdax" ]]
+	printf "OK\n"
+
+	# Test: devdax -> devdax (re-enable in same mode)
+	printf "Testing devdax -> devdax (re-enable)... "
+	"$DAXCTL" reconfigure-device -m devdax "$daxdev"
+	[[ $(daxctl_get_mode "$daxdev") == "devdax" ]]
+	printf "OK\n"
+}
+
+#
+# Test mode transitions with system-ram (requires kmem)
+#
+test_system_ram_transitions()
+{
+	printf "\n=== Testing system-ram transitions with famfs ===\n"
+
+	# Ensure we start in devdax mode
+	ensure_devdax_mode
+	[[ $(daxctl_get_mode "$daxdev") == "devdax" ]]
+
+	# Test: devdax -> system-ram
+	printf "Testing devdax -> system-ram... "
+	"$DAXCTL" reconfigure-device -N -m system-ram "$daxdev"
+	[[ $(daxctl_get_mode "$daxdev") == "system-ram" ]]
+	printf "OK\n"
+
+	# Test: system-ram -> famfs should fail
+	printf "Testing system-ram -> famfs (should fail)... "
+	if "$DAXCTL" reconfigure-device -m famfs "$daxdev" 2>/dev/null; then
+		printf "FAILED - should have been rejected\n"
+		return 1
+	fi
+	printf "OK (correctly rejected)\n"
+
+	# Test: system-ram -> devdax -> famfs (proper path)
+	printf "Testing system-ram -> devdax -> famfs... "
+	"$DAXCTL" reconfigure-device -f -m devdax "$daxdev"
+	[[ $(daxctl_get_mode "$daxdev") == "devdax" ]]
+	"$DAXCTL" reconfigure-device -m famfs "$daxdev"
+	[[ $(daxctl_get_mode "$daxdev") == "famfs" ]]
+	printf "OK\n"
+
+	# Restore to devdax for subsequent tests
+	"$DAXCTL" reconfigure-device -m devdax "$daxdev"
+}
+
+#
+# Test JSON output shows correct mode
+#
+test_json_output()
+{
+	printf "\n=== Testing JSON output for mode field ===\n"
+
+	# Test devdax mode in JSON
+	ensure_devdax_mode
+	printf "Testing JSON output for devdax mode... "
+	mode=$("$DAXCTL" list -d "$daxdev" | jq -er '.[].mode')
+	[[ "$mode" == "devdax" ]]
+	printf "OK\n"
+
+	# Test famfs mode in JSON
+	"$DAXCTL" reconfigure-device -m famfs "$daxdev"
+	printf "Testing JSON output for famfs mode... "
+	mode=$("$DAXCTL" list -d "$daxdev" | jq -er '.[].mode')
+	[[ "$mode" == "famfs" ]]
+	printf "OK\n"
+
+	# Restore to devdax
+	"$DAXCTL" reconfigure-device -m devdax "$daxdev"
+}
+
+#
+# Test error messages for invalid transitions
+#
+test_error_handling()
+{
+	printf "\n=== Testing error handling ===\n"
+
+	# Ensure we're in famfs mode
+	"$DAXCTL" reconfigure-device -m famfs "$daxdev"
+
+	# Test that invalid mode is rejected
+	printf "Testing invalid mode rejection... "
+	if "$DAXCTL" reconfigure-device -m invalidmode "$daxdev" 2>/dev/null; then
+		printf "FAILED - invalid mode should be rejected\n"
+		return 1
+	fi
+	printf "OK (correctly rejected)\n"
+
+	# Restore to devdax
+	"$DAXCTL" reconfigure-device -m devdax "$daxdev"
+}
+
+#
+# Main test sequence
+#
+main()
+{
+	check_fsdev_dax
+	find_daxdev
+
+	rc=1  # From here on, failures are real failures
+
+	test_famfs_mode_transitions
+	test_json_output
+	test_error_handling
+
+	# System-ram tests require kmem module
+	if check_kmem; then
+		# Save and disable online policy for system-ram tests
+		saved_policy="$(cat /sys/devices/system/memory/auto_online_blocks)"
+		echo "offline" > /sys/devices/system/memory/auto_online_blocks
+
+		test_system_ram_transitions
+
+		# Restore online policy
+		echo "$saved_policy" > /sys/devices/system/memory/auto_online_blocks
+	fi
+
+	# Restore original mode
+	printf "\nRestoring device to original mode: %s\n" "$original_mode"
+	"$DAXCTL" reconfigure-device -f -m "$original_mode" "$daxdev"
+
+	printf "\n=== All famfs tests passed ===\n"
+
+	exit 0
+}
+
+main
diff --git a/test/meson.build b/test/meson.build
index 615376e..ad1d393 100644
--- a/test/meson.build
+++ b/test/meson.build
@@ -209,6 +209,7 @@ if get_option('destructive').enabled()
   device_dax_fio = find_program('device-dax-fio.sh')
   daxctl_devices = find_program('daxctl-devices.sh')
   daxctl_create = find_program('daxctl-create.sh')
+  daxctl_famfs = find_program('daxctl-famfs.sh')
   dm = find_program('dm.sh')
   mmap_test = find_program('mmap.sh')
 
@@ -226,6 +227,7 @@ if get_option('destructive').enabled()
     [ 'device-dax-fio.sh', device_dax_fio, 'dax'   ],
     [ 'daxctl-devices.sh', daxctl_devices, 'dax'   ],
     [ 'daxctl-create.sh',  daxctl_create,  'dax'   ],
+    [ 'daxctl-famfs.sh',   daxctl_famfs,   'dax'   ],
     [ 'dm.sh',             dm,		   'dax'   ],
     [ 'mmap.sh',           mmap_test,	   'dax'   ],
   ]
-- 
2.49.0


