Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9769710FFD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 May 2019 01:05:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726229AbfEAXEn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 May 2019 19:04:43 -0400
Received: from mail-ot1-f74.google.com ([209.85.210.74]:43245 "EHLO
        mail-ot1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbfEAXEf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 May 2019 19:04:35 -0400
Received: by mail-ot1-f74.google.com with SMTP id q23so295814otk.10
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 May 2019 16:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=2w5xfu9GjviUjmXUiGL3y5UBmpKTNTw//vQlQgl2ho0=;
        b=aPhp4K7Ppw2uScWyrHYIcTzDgEoUszftPdVVA9a2w+upJnoB681LBPoHg2s0RrLbB0
         E+zIbzzmAk8ElUsZTQZ0UuySBbdQ0cWlk43efUiq01/SV+9jXrLapAocH9jrN3kqC/2k
         jhupUv/3SweTHXV7iGSHIU4gHqXerCIyln6KuCbCRv1WxerOUxnmi8MaOA2E/SU+MpEn
         PvVPGrkKk8eI3pLOxoW9dQhsVRjSSiKDdxKVu6pHBn0xoo6//BO+GJ1HySq1Xfy22P+4
         8xiSgxU1fqNIXnjiOOAHkdZgusoTSYtpfDrR1JvqjD5uuPqEajAJG+D5PUavkjRdjLEL
         MLuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=2w5xfu9GjviUjmXUiGL3y5UBmpKTNTw//vQlQgl2ho0=;
        b=rpcSk4lX5iURxhkVs14Y06cAzRrEvM7q8vouvh3WKgEPJ3UfpEf5FCvhN95/kJKYeR
         GtSzI75u1rI9UXXTm/lAMD+T2oWdc0J0eyergjetgFHy/SmvAPNXYmDiE/D5VsnAo7AY
         nJm/Wc0qcWw1HIsxbVfwnwwT3kyEtaMAcqD/JueUNaVI8ntiOcfdaT+8+iRyRMoQT+Qc
         p1YA0IXCcMvS6YuUtClDibTly5lLqqViWk9UwziMuC9zFJGmfsGohAJBQzuIelNrzwnz
         lT7dCWZerDFUkOLRpvxQ/DIqguEWqaeYPf9ic9Rs2aP7imC9KG1+RVoGdlHH7EOxzIVU
         LKXw==
X-Gm-Message-State: APjAAAVCR6cdjnPXq8zsLuH2IlZZHn9ByAuLJ1aBXY2beBlr8xHHTMTZ
        SQJo9bO49zQ+6dhRKJ2TSxk7HP/tyyeVPKKzJ7vSwA==
X-Google-Smtp-Source: APXvYqxJxPO6GlZz4/bAGqvwWNxlwLQ0kC05vzwzyt72esVI2M3tr11TsCRGVwL3AImQYpA1YthLZLN/JqdKDdr96Su2yw==
X-Received: by 2002:a05:6830:1449:: with SMTP id w9mr382814otp.276.1556751874971;
 Wed, 01 May 2019 16:04:34 -0700 (PDT)
Date:   Wed,  1 May 2019 16:01:21 -0700
In-Reply-To: <20190501230126.229218-1-brendanhiggins@google.com>
Message-Id: <20190501230126.229218-13-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20190501230126.229218-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.21.0.593.g511ec345e18-goog
Subject: [PATCH v2 12/17] kunit: tool: add Python wrappers for running KUnit tests
From:   Brendan Higgins <brendanhiggins@google.com>
To:     frowand.list@gmail.com, gregkh@linuxfoundation.org,
        keescook@google.com, kieran.bingham@ideasonboard.com,
        mcgrof@kernel.org, robh@kernel.org, sboyd@kernel.org,
        shuah@kernel.org
Cc:     devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        kunit-dev@googlegroups.com, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-um@lists.infradead.org,
        Alexander.Levin@microsoft.com, Tim.Bird@sony.com,
        amir73il@gmail.com, dan.carpenter@oracle.com,
        dan.j.williams@intel.com, daniel@ffwll.ch, jdike@addtoit.com,
        joel@jms.id.au, julia.lawall@lip6.fr, khilman@baylibre.com,
        knut.omang@oracle.com, logang@deltatee.com, mpe@ellerman.id.au,
        pmladek@suse.com, richard@nod.at, rientjes@google.com,
        rostedt@goodmis.org, wfg@linux.intel.com,
        Felix Guo <felixguoxiuping@gmail.com>,
        Brendan Higgins <brendanhiggins@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Felix Guo <felixguoxiuping@gmail.com>

The ultimate goal is to create minimal isolated test binaries; in the
meantime we are using UML to provide the infrastructure to run tests, so
define an abstract way to configure and run tests that allow us to
change the context in which tests are built without affecting the user.
This also makes pretty and dynamic error reporting, and a lot of other
nice features easier.

kunit_config.py:
  - parse .config and Kconfig files.

kunit_kernel.py: provides helper functions to:
  - configure the kernel using kunitconfig.
  - build the kernel with the appropriate configuration.
  - provide function to invoke the kernel and stream the output back.

Signed-off-by: Felix Guo <felixguoxiuping@gmail.com>
Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
---
 tools/testing/kunit/.gitignore      |   3 +
 tools/testing/kunit/kunit.py        |  78 +++++++++++++++
 tools/testing/kunit/kunit_config.py |  66 +++++++++++++
 tools/testing/kunit/kunit_kernel.py | 148 ++++++++++++++++++++++++++++
 tools/testing/kunit/kunit_parser.py | 119 ++++++++++++++++++++++
 5 files changed, 414 insertions(+)
 create mode 100644 tools/testing/kunit/.gitignore
 create mode 100755 tools/testing/kunit/kunit.py
 create mode 100644 tools/testing/kunit/kunit_config.py
 create mode 100644 tools/testing/kunit/kunit_kernel.py
 create mode 100644 tools/testing/kunit/kunit_parser.py

diff --git a/tools/testing/kunit/.gitignore b/tools/testing/kunit/.gitignore
new file mode 100644
index 0000000000000..c791ff59a37a9
--- /dev/null
+++ b/tools/testing/kunit/.gitignore
@@ -0,0 +1,3 @@
+# Byte-compiled / optimized / DLL files
+__pycache__/
+*.py[cod]
\ No newline at end of file
diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
new file mode 100755
index 0000000000000..7413ec7351a20
--- /dev/null
+++ b/tools/testing/kunit/kunit.py
@@ -0,0 +1,78 @@
+#!/usr/bin/python3
+# SPDX-License-Identifier: GPL-2.0
+#
+# A thin wrapper on top of the KUnit Kernel
+#
+# Copyright (C) 2019, Google LLC.
+# Author: Felix Guo <felixguoxiuping@gmail.com>
+# Author: Brendan Higgins <brendanhiggins@google.com>
+
+import argparse
+import sys
+import os
+import time
+
+import kunit_config
+import kunit_kernel
+import kunit_parser
+
+parser = argparse.ArgumentParser(description='Runs KUnit tests.')
+
+parser.add_argument('--raw_output', help='don\'t format output from kernel',
+		    action='store_true')
+
+parser.add_argument('--timeout', help='maximum number of seconds to allow for '
+		    'all tests to run. This does not include time taken to '
+		    'build the tests.', type=int, default=300,
+		    metavar='timeout')
+
+parser.add_argument('--jobs',
+		    help='As in the make command, "Specifies  the number of '
+		    'jobs (commands) to run simultaneously."',
+		    type=int, default=8, metavar='jobs')
+
+parser.add_argument('--build_dir',
+		    help='As in the make command, it specifies the build '
+		    'directory.',
+		    type=str, default=None, metavar='build_dir')
+
+cli_args = parser.parse_args()
+
+linux = kunit_kernel.LinuxSourceTree()
+
+build_dir = None
+if cli_args.build_dir:
+	build_dir = cli_args.build_dir
+
+config_start = time.time()
+success = linux.build_reconfig(build_dir)
+config_end = time.time()
+if not success:
+	quit()
+
+kunit_parser.print_with_timestamp('Building KUnit Kernel ...')
+
+build_start = time.time()
+
+success = linux.build_um_kernel(jobs=cli_args.jobs, build_dir=build_dir)
+build_end = time.time()
+if not success:
+	quit()
+
+kunit_parser.print_with_timestamp('Starting KUnit Kernel ...')
+test_start = time.time()
+
+if cli_args.raw_output:
+	kunit_parser.raw_output(linux.run_kernel(timeout=cli_args.timeout,
+						 build_dir=build_dir))
+else:
+	kunit_parser.parse_run_tests(linux.run_kernel(timeout=cli_args.timeout,
+						      build_dir=build_dir))
+
+test_end = time.time()
+
+kunit_parser.print_with_timestamp((
+	"Elapsed time: %.3fs total, %.3fs configuring, %.3fs " +
+	"building, %.3fs running.\n") % (test_end - config_start,
+	config_end - config_start, build_end - build_start,
+	test_end - test_start))
diff --git a/tools/testing/kunit/kunit_config.py b/tools/testing/kunit/kunit_config.py
new file mode 100644
index 0000000000000..167f47d9ab8e4
--- /dev/null
+++ b/tools/testing/kunit/kunit_config.py
@@ -0,0 +1,66 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Builds a .config from a kunitconfig.
+#
+# Copyright (C) 2019, Google LLC.
+# Author: Felix Guo <felixguoxiuping@gmail.com>
+# Author: Brendan Higgins <brendanhiggins@google.com>
+
+import collections
+import re
+
+CONFIG_IS_NOT_SET_PATTERN = r'^# CONFIG_\w+ is not set$'
+CONFIG_PATTERN = r'^CONFIG_\w+=\S+$'
+
+KconfigEntryBase = collections.namedtuple('KconfigEntry', ['raw_entry'])
+
+
+class KconfigEntry(KconfigEntryBase):
+
+	def __str__(self) -> str:
+		return self.raw_entry
+
+
+class KconfigParseError(Exception):
+	"""Error parsing Kconfig defconfig or .config."""
+
+
+class Kconfig(object):
+	"""Represents defconfig or .config specified using the Kconfig language."""
+
+	def __init__(self):
+		self._entries = []
+
+	def entries(self):
+		return set(self._entries)
+
+	def add_entry(self, entry: KconfigEntry) -> None:
+		self._entries.append(entry)
+
+	def is_subset_of(self, other: "Kconfig") -> bool:
+		return self.entries().issubset(other.entries())
+
+	def write_to_file(self, path: str) -> None:
+		with open(path, 'w') as f:
+			for entry in self.entries():
+				f.write(str(entry) + '\n')
+
+	def parse_from_string(self, blob: str) -> None:
+		"""Parses a string containing KconfigEntrys and populates this Kconfig."""
+		self._entries = []
+		is_not_set_matcher = re.compile(CONFIG_IS_NOT_SET_PATTERN)
+		config_matcher = re.compile(CONFIG_PATTERN)
+		for line in blob.split('\n'):
+			line = line.strip()
+			if not line:
+				continue
+			elif config_matcher.match(line) or is_not_set_matcher.match(line):
+				self._entries.append(KconfigEntry(line))
+			elif line[0] == '#':
+				continue
+			else:
+				raise KconfigParseError('Failed to parse: ' + line)
+
+	def read_from_file(self, path: str) -> None:
+		with open(path, 'r') as f:
+			self.parse_from_string(f.read())
diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
new file mode 100644
index 0000000000000..07c0abf2f47df
--- /dev/null
+++ b/tools/testing/kunit/kunit_kernel.py
@@ -0,0 +1,148 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Runs UML kernel, collects output, and handles errors.
+#
+# Copyright (C) 2019, Google LLC.
+# Author: Felix Guo <felixguoxiuping@gmail.com>
+# Author: Brendan Higgins <brendanhiggins@google.com>
+
+
+import logging
+import subprocess
+import os
+
+import kunit_config
+
+KCONFIG_PATH = '.config'
+
+class ConfigError(Exception):
+	"""Represents an error trying to configure the Linux kernel."""
+
+
+class BuildError(Exception):
+	"""Represents an error trying to build the Linux kernel."""
+
+
+class LinuxSourceTreeOperations(object):
+	"""An abstraction over command line operations performed on a source tree."""
+
+	def make_mrproper(self):
+		try:
+			subprocess.check_output(['make', 'mrproper'])
+		except OSError as e:
+			raise ConfigError('Could not call make command: ' + e)
+		except subprocess.CalledProcessError as e:
+			raise ConfigError(e.output)
+
+	def make_olddefconfig(self, build_dir):
+		command = ['make', 'ARCH=um', 'olddefconfig']
+		if build_dir:
+			command += ['O=' + build_dir]
+		try:
+			subprocess.check_output(command)
+		except OSError as e:
+			raise ConfigError('Could not call make command: ' + e)
+		except subprocess.CalledProcessError as e:
+			raise ConfigError(e.output)
+
+	def make(self, jobs, build_dir):
+		command = ['make', 'ARCH=um', '--jobs=' + str(jobs)]
+		if build_dir:
+			command += ['O=' + build_dir]
+		try:
+			subprocess.check_output(command)
+		except OSError as e:
+			raise BuildError('Could not call execute make: ' + e)
+		except subprocess.CalledProcessError as e:
+			raise BuildError(e.output)
+
+	def linux_bin(self, params, timeout, build_dir):
+		"""Runs the Linux UML binary. Must be named 'linux'."""
+		linux_bin = './linux'
+		if build_dir:
+			linux_bin = os.path.join(build_dir, 'linux')
+		process = subprocess.Popen(
+			[linux_bin] + params,
+			stdin=subprocess.PIPE,
+			stdout=subprocess.PIPE,
+			stderr=subprocess.PIPE)
+		process.wait(timeout=timeout)
+		return process
+
+
+def get_kconfig_path(build_dir):
+	kconfig_path = KCONFIG_PATH
+	if build_dir:
+		kconfig_path = os.path.join(build_dir, KCONFIG_PATH)
+	return kconfig_path
+
+class LinuxSourceTree(object):
+	"""Represents a Linux kernel source tree with KUnit tests."""
+
+	def __init__(self):
+		self._kconfig = kunit_config.Kconfig()
+		self._kconfig.read_from_file('kunitconfig')
+		self._ops = LinuxSourceTreeOperations()
+
+	def clean(self):
+		try:
+			self._ops.make_mrproper()
+		except ConfigError as e:
+			logging.error(e)
+			return False
+		return True
+
+	def build_config(self, build_dir):
+		kconfig_path = get_kconfig_path(build_dir)
+		if build_dir and not os.path.exists(build_dir):
+			os.mkdir(build_dir)
+		self._kconfig.write_to_file(kconfig_path)
+		try:
+			self._ops.make_olddefconfig(build_dir)
+		except ConfigError as e:
+			logging.error(e)
+			return False
+		validated_kconfig = kunit_config.Kconfig()
+		validated_kconfig.read_from_file(kconfig_path)
+		if not self._kconfig.is_subset_of(validated_kconfig):
+			logging.error('Provided Kconfig is not contained in validated .config!')
+			return False
+		return True
+
+	def build_reconfig(self, build_dir):
+		"""Creates a new .config if it is not a subset of the kunitconfig."""
+		kconfig_path = get_kconfig_path(build_dir)
+		if os.path.exists(kconfig_path):
+			existing_kconfig = kunit_config.Kconfig()
+			existing_kconfig.read_from_file(kconfig_path)
+			if not self._kconfig.is_subset_of(existing_kconfig):
+				print('Regenerating .config ...')
+				os.remove(kconfig_path)
+				return self.build_config(build_dir)
+			else:
+				return True
+		else:
+			print('Generating .config ...')
+			return self.build_config(build_dir)
+
+	def build_um_kernel(self, jobs, build_dir):
+		try:
+			self._ops.make_olddefconfig(build_dir)
+			self._ops.make(jobs, build_dir)
+		except (ConfigError, BuildError) as e:
+			logging.error(e)
+			return False
+		used_kconfig = kunit_config.Kconfig()
+		used_kconfig.read_from_file(get_kconfig_path(build_dir))
+		if not self._kconfig.is_subset_of(used_kconfig):
+			logging.error('Provided Kconfig is not contained in final config!')
+			return False
+		return True
+
+	def run_kernel(self, args=[], timeout=None, build_dir=None):
+		args.extend(['mem=256M'])
+		process = self._ops.linux_bin(args, timeout, build_dir)
+		with open('test.log', 'w') as f:
+			for line in process.stdout:
+				f.write(line.rstrip().decode('ascii') + '\n')
+				yield line.rstrip().decode('ascii')
diff --git a/tools/testing/kunit/kunit_parser.py b/tools/testing/kunit/kunit_parser.py
new file mode 100644
index 0000000000000..6c81d4dcfabb5
--- /dev/null
+++ b/tools/testing/kunit/kunit_parser.py
@@ -0,0 +1,119 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Parses test results from a kernel dmesg log.
+#
+# Copyright (C) 2019, Google LLC.
+# Author: Felix Guo <felixguoxiuping@gmail.com>
+# Author: Brendan Higgins <brendanhiggins@google.com>
+
+import re
+from datetime import datetime
+
+kunit_start_re = re.compile('printk: console .* enabled')
+kunit_end_re = re.compile('List of all partitions:')
+
+def isolate_kunit_output(kernel_output):
+	started = False
+	for line in kernel_output:
+		if kunit_start_re.match(line):
+			started = True
+		elif kunit_end_re.match(line):
+			break
+		elif started:
+			yield line
+
+def raw_output(kernel_output):
+	for line in kernel_output:
+		print(line)
+
+DIVIDER = "=" * 30
+
+RESET = '\033[0;0m'
+
+def red(text):
+	return '\033[1;31m' + text + RESET
+
+def yellow(text):
+	return '\033[1;33m' + text + RESET
+
+def green(text):
+	return '\033[1;32m' + text + RESET
+
+def print_with_timestamp(message):
+	print('[%s] %s' % (datetime.now().strftime('%H:%M:%S'), message))
+
+def print_log(log):
+	for m in log:
+		print_with_timestamp(m)
+
+def parse_run_tests(kernel_output):
+	test_case_output = re.compile('^kunit .*?: (.*)$')
+
+	test_module_success = re.compile('^kunit .*: all tests passed')
+	test_module_fail = re.compile('^kunit .*: one or more tests failed')
+
+	test_case_success = re.compile('^kunit (.*): (.*) passed')
+	test_case_fail = re.compile('^kunit (.*): (.*) failed')
+	test_case_crash = re.compile('^kunit (.*): (.*) crashed')
+
+	total_tests = set()
+	failed_tests = set()
+	crashed_tests = set()
+
+	def get_test_name(match):
+		return match.group(1) + ":" + match.group(2)
+
+	current_case_log = []
+	def end_one_test(match, log):
+		log.clear()
+		total_tests.add(get_test_name(match))
+
+	print_with_timestamp(DIVIDER)
+	for line in isolate_kunit_output(kernel_output):
+		# Ignore module output:
+		if (test_module_success.match(line) or
+		    test_module_fail.match(line)):
+			print_with_timestamp(DIVIDER)
+			continue
+
+		match = re.match(test_case_success, line)
+		if match:
+			print_with_timestamp(green("[PASSED] ") +
+					     get_test_name(match))
+			end_one_test(match, current_case_log)
+			continue
+
+		match = re.match(test_case_fail, line)
+		# Crashed tests will report as both failed and crashed. We only
+		# want to show and count it once.
+		if match and get_test_name(match) not in crashed_tests:
+			failed_tests.add(get_test_name(match))
+			print_with_timestamp(red("[FAILED] " +
+						 get_test_name(match)))
+			print_log(map(yellow, current_case_log))
+			print_with_timestamp("")
+			end_one_test(match, current_case_log)
+			continue
+
+		match = re.match(test_case_crash, line)
+		if match:
+			crashed_tests.add(get_test_name(match))
+			print_with_timestamp(yellow("[CRASH] " +
+						    get_test_name(match)))
+			print_log(current_case_log)
+			print_with_timestamp("")
+			end_one_test(match, current_case_log)
+			continue
+
+		# Strip off the `kunit module-name:` prefix
+		match = re.match(test_case_output, line)
+		if match:
+			current_case_log.append(match.group(1))
+		else:
+			current_case_log.append(line)
+
+	fmt = green if (len(failed_tests) + len(crashed_tests) == 0) else red
+	print_with_timestamp(
+		fmt("Testing complete. %d tests run. %d failed. %d crashed." %
+		    (len(total_tests), len(failed_tests), len(crashed_tests))))
+
-- 
2.21.0.593.g511ec345e18-goog

