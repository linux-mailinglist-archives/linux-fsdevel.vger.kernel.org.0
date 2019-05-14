Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1A211E4E7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 May 2019 00:20:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbfENWT2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 May 2019 18:19:28 -0400
Received: from mail-ot1-f74.google.com ([209.85.210.74]:44391 "EHLO
        mail-ot1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726964AbfENWT0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 May 2019 18:19:26 -0400
Received: by mail-ot1-f74.google.com with SMTP id w3so241859otg.11
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 May 2019 15:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=C+B/znn2xCbaQTRx3uLG/wRZpJaaIzcATU86mE89dF0=;
        b=KZqZr3lJJtqf6drwilaN8+Qd3/kHfcGFkyhkxDPGHKZYJ7qw/GBBFkvx8PrHUoTncU
         Thtz8xl7lzBl9En9tIzbm6rU4pgPjGbsXqBduRnwijs7PhxdfCesJYUaL7tpqh504PDH
         92mGncslrh+CGIa4qohTJIHzz0rkVEP12ERm796s+hfhpUMJzPIBSd6BzrHONxYXn9jd
         M1wO63sWulR3bPubYVApzwiojaSyCWxc4EXRwE1S0bp9bj80QaGd439LlCzG5qlslKg4
         qmfXsqu8trk3aTOG1bT/o/YkHzgKMvTdMgh5MerVSOKfUEh9qxcV15UaorWPtmF+aHMU
         H/hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=C+B/znn2xCbaQTRx3uLG/wRZpJaaIzcATU86mE89dF0=;
        b=KnUbMdUjJWbOoZF68JlOpF8QW+2PzNf+PXIQzoj2co1H/KPnEta59y4xUxPyVXabdM
         4WW0OWU0PVSa7x3UX4KEEL/A2Fpr2nrlhnI6Nm0stU1iyH5qTwl9qRM2+I2anz4gFh9D
         FD53qr4ceW2sp+TTqUg40IVRatMym6yiT/9mFaLD6Y74Sbvks1i2mdmYF78h9r2kS2LK
         49awNoAgNVenssk6P8B1DzqKJzaWs38Ltph4CVvcriBZcrFX4tvnBiiXXWniCyqSwQhG
         sPlSjRero+8dP3B9Nbpw9G9dD5a/pBtJYT8WcZN12HL8RIplDB97zqK82z8nbkdAEfcq
         rBMQ==
X-Gm-Message-State: APjAAAV5pb8mEbChg2Lu0QhGC8LZD0JXNaK5LO3viExuJUKhERXcJs+9
        iwK64pKnGnjp/UTjnBxInlo3xjjynxS3bhCRNecnMw==
X-Google-Smtp-Source: APXvYqx9s2bR7pacahcexVoDt6m9k6990nkI+KYawuMcyuA8nA8j3+DMq22oOkB7b7lvRpVKYe5UwdiK69WeI66mQQbBoQ==
X-Received: by 2002:aca:674a:: with SMTP id b10mr233347oiy.167.1557872364852;
 Tue, 14 May 2019 15:19:24 -0700 (PDT)
Date:   Tue, 14 May 2019 15:17:06 -0700
In-Reply-To: <20190514221711.248228-1-brendanhiggins@google.com>
Message-Id: <20190514221711.248228-14-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20190514221711.248228-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
Subject: [PATCH v4 13/18] kunit: tool: add Python wrappers for running KUnit tests
From:   Brendan Higgins <brendanhiggins@google.com>
To:     frowand.list@gmail.com, gregkh@linuxfoundation.org,
        jpoimboe@redhat.com, keescook@google.com,
        kieran.bingham@ideasonboard.com, mcgrof@kernel.org,
        peterz@infradead.org, robh@kernel.org, sboyd@kernel.org,
        shuah@kernel.org, tytso@mit.edu, yamada.masahiro@socionext.com
Cc:     devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        kunit-dev@googlegroups.com, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-um@lists.infradead.org,
        Alexander.Levin@microsoft.com, Tim.Bird@sony.com,
        amir73il@gmail.com, dan.carpenter@oracle.com, daniel@ffwll.ch,
        jdike@addtoit.com, joel@jms.id.au, julia.lawall@lip6.fr,
        khilman@baylibre.com, knut.omang@oracle.com, logang@deltatee.com,
        mpe@ellerman.id.au, pmladek@suse.com, rdunlap@infradead.org,
        richard@nod.at, rientjes@google.com, rostedt@goodmis.org,
        wfg@linux.intel.com, Felix Guo <felixguoxiuping@gmail.com>,
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
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
---
 tools/testing/kunit/.gitignore                |   3 +
 tools/testing/kunit/kunit.py                  | 116 +++++++
 tools/testing/kunit/kunit_config.py           |  66 ++++
 tools/testing/kunit/kunit_kernel.py           | 148 +++++++++
 tools/testing/kunit/kunit_parser.py           | 290 ++++++++++++++++++
 tools/testing/kunit/kunit_tool_test.py        | 206 +++++++++++++
 .../test_is_test_passed-all_passed.log        |  32 ++
 .../test_data/test_is_test_passed-crash.log   |  69 +++++
 .../test_data/test_is_test_passed-failure.log |  36 +++
 .../test_is_test_passed-no_tests_run.log      |  75 +++++
 .../test_output_isolated_correctly.log        | 106 +++++++
 .../test_data/test_read_from_file.kconfig     |  17 +
 12 files changed, 1164 insertions(+)
 create mode 100644 tools/testing/kunit/.gitignore
 create mode 100755 tools/testing/kunit/kunit.py
 create mode 100644 tools/testing/kunit/kunit_config.py
 create mode 100644 tools/testing/kunit/kunit_kernel.py
 create mode 100644 tools/testing/kunit/kunit_parser.py
 create mode 100755 tools/testing/kunit/kunit_tool_test.py
 create mode 100644 tools/testing/kunit/test_data/test_is_test_passed-all_passed.log
 create mode 100644 tools/testing/kunit/test_data/test_is_test_passed-crash.log
 create mode 100644 tools/testing/kunit/test_data/test_is_test_passed-failure.log
 create mode 100644 tools/testing/kunit/test_data/test_is_test_passed-no_tests_run.log
 create mode 100644 tools/testing/kunit/test_data/test_output_isolated_correctly.log
 create mode 100644 tools/testing/kunit/test_data/test_read_from_file.kconfig

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
index 0000000000000..85ed1c32a6c48
--- /dev/null
+++ b/tools/testing/kunit/kunit.py
@@ -0,0 +1,116 @@
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
+from collections import namedtuple
+from enum import Enum, auto
+
+import kunit_config
+import kunit_kernel
+import kunit_parser
+
+KunitResult = namedtuple('KunitResult', ['status','result'])
+
+KunitRequest = namedtuple('KunitRequest', ['raw_output','timeout', 'jobs', 'build_dir'])
+
+class KunitStatus(Enum):
+	SUCCESS = auto()
+	CONFIG_FAILURE = auto()
+	BUILD_FAILURE = auto()
+	TEST_FAILURE = auto()
+
+def run_tests(linux: kunit_kernel.LinuxSourceTree,
+	      request: KunitRequest) -> KunitResult:
+	config_start = time.time()
+	success = linux.build_reconfig(request.build_dir)
+	config_end = time.time()
+	if not success:
+		return KunitResult(KunitStatus.CONFIG_FAILURE, 'could not configure kernel')
+
+	kunit_parser.print_with_timestamp('Building KUnit Kernel ...')
+
+	build_start = time.time()
+	success = linux.build_um_kernel(request.jobs, request.build_dir)
+	build_end = time.time()
+	if not success:
+		return KunitResult(KunitStatus.BUILD_FAILURE, 'could not build kernel')
+
+	kunit_parser.print_with_timestamp('Starting KUnit Kernel ...')
+	test_start = time.time()
+
+	test_result = kunit_parser.TestResult(kunit_parser.TestStatus.SUCCESS,
+					      [],
+					      'Tests not Parsed.')
+	if request.raw_output:
+		kunit_parser.raw_output(
+			linux.run_kernel(timeout=request.timeout))
+	else:
+		kunit_output = linux.run_kernel(timeout=request.timeout)
+		test_result = kunit_parser.parse_run_tests(kunit_output)
+	test_end = time.time()
+
+	kunit_parser.print_with_timestamp((
+		'Elapsed time: %.3fs total, %.3fs configuring, %.3fs ' +
+		'building, %.3fs running.\n') % (
+				test_end - config_start,
+				config_end - config_start,
+				build_end - build_start,
+				test_end - test_start))
+
+	if test_result.status != kunit_parser.TestStatus.SUCCESS:
+		return KunitResult(KunitStatus.TEST_FAILURE, test_result)
+	else:
+		return KunitResult(KunitStatus.SUCCESS, test_result)
+
+def main(argv, linux):
+	parser = argparse.ArgumentParser(
+			description='Helps writing and running KUnit tests.')
+	subparser = parser.add_subparsers(dest='subcommand')
+
+	run_parser = subparser.add_parser('run', help='Runs KUnit tests.')
+	run_parser.add_argument('--raw_output', help='don\'t format output from kernel',
+				action='store_true')
+
+	run_parser.add_argument('--timeout',
+				help='maximum number of seconds to allow for all tests '
+				'to run. This does not include time taken to build the '
+				'tests.',
+				type=int,
+				default=300,
+				metavar='timeout')
+
+	run_parser.add_argument('--jobs',
+				help='As in the make command, "Specifies  the number of '
+				'jobs (commands) to run simultaneously."',
+				type=int, default=8, metavar='jobs')
+
+	run_parser.add_argument('--build_dir',
+				help='As in the make command, it specifies the build '
+				'directory.',
+				type=str, default=None, metavar='build_dir')
+
+	cli_args = parser.parse_args(argv)
+
+	if cli_args.subcommand == 'run':
+		request = KunitRequest(cli_args.raw_output,
+				       cli_args.timeout,
+				       cli_args.jobs,
+				       cli_args.build_dir)
+		result = run_tests(linux, request)
+		if result.status != KunitStatus.SUCCESS:
+			sys.exit(1)
+	else:
+		parser.print_help()
+
+if __name__ == '__main__':
+	main(sys.argv[1:], kunit_kernel.LinuxSourceTree())
diff --git a/tools/testing/kunit/kunit_config.py b/tools/testing/kunit/kunit_config.py
new file mode 100644
index 0000000000000..ebf3942b23f51
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
+	def is_subset_of(self, other: 'Kconfig') -> bool:
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
index 0000000000000..31c634e4202b1
--- /dev/null
+++ b/tools/testing/kunit/kunit_parser.py
@@ -0,0 +1,290 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Parses test results from a kernel dmesg log.
+#
+# Copyright (C) 2019, Google LLC.
+# Author: Felix Guo <felixguoxiuping@gmail.com>
+# Author: Brendan Higgins <brendanhiggins@google.com>
+
+import re
+
+from collections import namedtuple
+from datetime import datetime
+from enum import Enum, auto
+from functools import reduce
+from typing import List
+
+TestResult = namedtuple('TestResult', ['status','modules','log'])
+
+class TestModule(object):
+	def __init__(self):
+		self.status = None
+		self.name = None
+		self.cases = []
+
+	def __str__(self):
+		return 'TestModule(' + self.status + ',' + self.name + ',' + str(self.cases) + ')'
+
+	def __repr__(self):
+		return str(self)
+
+class TestCase(object):
+	def __init__(self):
+		self.status = None
+		self.name = ''
+		self.log = []
+
+	def __str__(self):
+		return 'TestCase(' + self.status + ',' + self.name + ',' + str(self.log) + ')'
+
+	def __repr__(self):
+		return str(self)
+
+class TestStatus(Enum):
+	SUCCESS = auto()
+	FAILURE = auto()
+	TEST_CRASHED = auto()
+	NO_TESTS = auto()
+
+kunit_start_re = re.compile(r'^TAP version [0-9]+$')
+kunit_end_re = re.compile('List of all partitions:')
+
+def isolate_kunit_output(kernel_output):
+	started = False
+	for line in kernel_output:
+		if kunit_start_re.match(line):
+			started = True
+			yield line
+		elif kunit_end_re.match(line):
+			break
+		elif started:
+			yield line
+
+def raw_output(kernel_output):
+	for line in kernel_output:
+		print(line)
+
+DIVIDER = '=' * 60
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
+def format_module_divider(message):
+	return '======== ' + message + ' ========'
+
+def print_module_divider(message):
+	print_with_timestamp(DIVIDER)
+	print_with_timestamp(format_module_divider(message))
+
+def print_log(log):
+	for m in log:
+		print_with_timestamp(m)
+
+TAP_ENTRIES = re.compile(r'^(TAP|\t?ok|\t?not ok|\t?[0-9]+\.\.[0-9]+|\t?#).*$')
+
+def consume_non_diagnositic(lines: List[str]) -> None:
+	while not TAP_ENTRIES.match(lines[0]):
+		lines.pop(0)
+
+def save_non_diagnositic(lines: List[str], test_case: TestCase) -> None:
+	while not TAP_ENTRIES.match(lines[0]):
+		test_case.log.append(lines[0])
+		lines.pop(0)
+
+OkNotOkResult = namedtuple('OkNotOkResult', ['is_ok','description', 'text'])
+
+OK_NOT_OK_SUBTEST = re.compile(r'^\t(ok|not ok) [0-9]+ - (.*)$')
+
+OK_NOT_OK_MODULE = re.compile(r'^(ok|not ok) [0-9]+ - (.*)$')
+
+def parse_ok_not_ok_test_case(lines: List[str], test_case: TestCase) -> bool:
+	save_non_diagnositic(lines, test_case)
+	line = lines[0]
+	match = OK_NOT_OK_SUBTEST.match(line)
+	if match:
+		test_case.log.append(lines.pop(0))
+		test_case.name = match.group(2)
+		if test_case.status == TestStatus.TEST_CRASHED:
+			return True
+		if match.group(1) == 'ok':
+			test_case.status = TestStatus.SUCCESS
+		else:
+			test_case.status = TestStatus.FAILURE
+		return True
+	else:
+		return False
+
+SUBTEST_DIAGNOSTIC = re.compile(r'^\t# .*?: (.*)$')
+DIAGNOSTIC_CRASH_MESSAGE = 'kunit test case crashed!'
+
+def parse_diagnostic(lines: List[str], test_case: TestCase) -> bool:
+	save_non_diagnositic(lines, test_case)
+	line = lines[0]
+	match = SUBTEST_DIAGNOSTIC.match(line)
+	if match:
+		test_case.log.append(lines.pop(0))
+		if match.group(1) == DIAGNOSTIC_CRASH_MESSAGE:
+			test_case.status = TestStatus.TEST_CRASHED
+		return True
+	else:
+		return False
+
+def parse_test_case(lines: List[str]) -> TestCase:
+	test_case = TestCase()
+	save_non_diagnositic(lines, test_case)
+	while parse_diagnostic(lines, test_case):
+		pass
+	if parse_ok_not_ok_test_case(lines, test_case):
+		return test_case
+	else:
+		return None
+
+SUBTEST_HEADER = re.compile(r'^\t# Subtest: (.*)$')
+
+def parse_subtest_header(lines: List[str]) -> str:
+	consume_non_diagnositic(lines)
+	match = SUBTEST_HEADER.match(lines[0])
+	if match:
+		lines.pop(0)
+		return match.group(1)
+	else:
+		return None
+
+SUBTEST_PLAN = re.compile(r'\t[0-9]+\.\.([0-9]+)')
+
+def parse_subtest_plan(lines: List[str]) -> int:
+	consume_non_diagnositic(lines)
+	match = SUBTEST_PLAN.match(lines[0])
+	if match:
+		lines.pop(0)
+		return match.group(1)
+	else:
+		return None
+
+def max_status(left: TestStatus, right: TestStatus) -> TestStatus:
+	if left == TestStatus.TEST_CRASHED or right == TestStatus.TEST_CRASHED:
+		return TestStatus.TEST_CRASHED
+	elif left == TestStatus.FAILURE or right == TestStatus.FAILURE:
+		return TestStatus.FAILURE
+	elif left != TestStatus.SUCCESS:
+		return left
+	elif right != TestStatus.SUCCESS:
+		return right
+	else:
+		return TestStatus.SUCCESS
+
+def parse_ok_not_ok_test_module(lines: List[str], test_module: TestModule) -> bool:
+	consume_non_diagnositic(lines)
+	line = lines[0]
+	match = OK_NOT_OK_MODULE.match(line)
+	if match:
+		lines.pop(0)
+		if match.group(1) == 'ok':
+			test_module.status = TestStatus.SUCCESS
+		else:
+			test_module.status = TestStatus.FAILURE
+		return True
+	else:
+		return False
+
+def bubble_up_errors(to_status, status_container_list) -> TestStatus:
+	status_list = map(to_status, status_container_list)
+	return reduce(max_status, status_list, TestStatus.SUCCESS)
+
+def bubble_up_test_case_errors(test_module: TestModule) -> TestStatus:
+	max_test_case_status = bubble_up_errors(lambda x: x.status, test_module.cases)
+	return max_status(max_test_case_status, test_module.status)
+
+def parse_test_module(lines: List[str]) -> TestModule:
+	if not lines:
+		return None
+	consume_non_diagnositic(lines)
+	test_module = TestModule()
+	test_module.status = TestStatus.SUCCESS
+	name = parse_subtest_header(lines)
+	if not name:
+		return None
+	test_module.name = name
+	test_case_num = parse_subtest_plan(lines)
+	if not test_case_num:
+		return None
+	test_case = parse_test_case(lines)
+	while test_case:
+		test_module.cases.append(test_case)
+		test_case = parse_test_case(lines)
+	if parse_ok_not_ok_test_module(lines, test_module):
+		test_module.status = bubble_up_test_case_errors(test_module)
+		return test_module
+	else:
+		print('failed to parse end of module' + lines[0])
+		return None
+
+TAP_HEADER = re.compile(r'^TAP version 14$')
+
+def parse_tap_header(lines: List[str]) -> bool:
+	consume_non_diagnositic(lines)
+	if TAP_HEADER.match(lines[0]):
+		lines.pop(0)
+		return True
+	else:
+		return False
+
+def bubble_up_module_errors(test_module_list: List[TestModule]) -> TestStatus:
+	return bubble_up_errors(lambda x: x.status, test_module_list)
+
+def parse_test_result(lines: List[str]) -> TestResult:
+	if not lines:
+		return TestResult(TestStatus.NO_TESTS, [], lines)
+	consume_non_diagnositic(lines)
+	if not parse_tap_header(lines):
+		return None
+	test_modules = []
+	test_module = parse_test_module(lines)
+	while test_module:
+		test_modules.append(test_module)
+		test_module = parse_test_module(lines)
+	return TestResult(bubble_up_module_errors(test_modules), test_modules, lines)
+
+def parse_run_tests(kernel_output) -> TestResult:
+	total_tests = 0
+	failed_tests = 0
+	crashed_tests = 0
+	test_result = parse_test_result(list(isolate_kunit_output(kernel_output)))
+	for test_module in test_result.modules:
+		if test_module.status == TestStatus.SUCCESS:
+			print_module_divider(green('[PASSED] ') + test_module.name)
+		elif test_module.status == TestStatus.TEST_CRASHED:
+			print_module_divider(red('[CRASHED] ' + test_module.name))
+		else:
+			print_module_divider(red('[FAILED] ') + test_module.name)
+		for test_case in test_module.cases:
+			total_tests += 1
+			if test_case.status == TestStatus.SUCCESS:
+				print_with_timestamp(green('[PASSED] ') + test_case.name)
+			elif test_case.status == TestStatus.TEST_CRASHED:
+				crashed_tests += 1
+				print_with_timestamp(red('[CRASHED] ' + test_case.name))
+				print_log(map(yellow, test_case.log))
+				print_with_timestamp('')
+			else:
+				failed_tests += 1
+				print_with_timestamp(red('[FAILED] ') + test_case.name)
+				print_log(map(yellow, test_case.log))
+				print_with_timestamp('')
+	print_with_timestamp(DIVIDER)
+	fmt = green if test_result.status == TestStatus.SUCCESS else red
+	print_with_timestamp(
+		fmt('Testing complete. %d tests run. %d failed. %d crashed.' %
+		    (total_tests, failed_tests, crashed_tests)))
+	return test_result
diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
new file mode 100755
index 0000000000000..50c3ed3108a6e
--- /dev/null
+++ b/tools/testing/kunit/kunit_tool_test.py
@@ -0,0 +1,206 @@
+#!/usr/bin/python3
+# SPDX-License-Identifier: GPL-2.0
+#
+# A collection of tests for tools/testing/kunit/kunit.py
+#
+# Copyright (C) 2019, Google LLC.
+# Author: Brendan Higgins <brendanhiggins@google.com>
+
+import unittest
+from unittest import mock
+
+import tempfile, shutil # Handling test_tmpdir
+
+import os
+
+import kunit_config
+import kunit_parser
+import kunit_kernel
+import kunit
+
+test_tmpdir = ''
+
+def setUpModule():
+	global test_tmpdir
+	test_tmpdir = tempfile.mkdtemp()
+
+def tearDownModule():
+	shutil.rmtree(test_tmpdir)
+
+def get_absolute_path(path):
+	return os.path.join(os.path.dirname(__file__), path)
+
+class KconfigTest(unittest.TestCase):
+
+	def test_is_subset_of(self):
+		kconfig0 = kunit_config.Kconfig()
+		self.assertTrue(kconfig0.is_subset_of(kconfig0))
+
+		kconfig1 = kunit_config.Kconfig()
+		kconfig1.add_entry(kunit_config.KconfigEntry('CONFIG_TEST=y'))
+		self.assertTrue(kconfig1.is_subset_of(kconfig1))
+		self.assertTrue(kconfig0.is_subset_of(kconfig1))
+		self.assertFalse(kconfig1.is_subset_of(kconfig0))
+
+	def test_read_from_file(self):
+		kconfig = kunit_config.Kconfig()
+		kconfig_path = get_absolute_path(
+			'test_data/test_read_from_file.kconfig')
+
+		kconfig.read_from_file(kconfig_path)
+
+		expected_kconfig = kunit_config.Kconfig()
+		expected_kconfig.add_entry(
+			kunit_config.KconfigEntry('CONFIG_UML=y'))
+		expected_kconfig.add_entry(
+			kunit_config.KconfigEntry('CONFIG_MMU=y'))
+		expected_kconfig.add_entry(
+			kunit_config.KconfigEntry('CONFIG_TEST=y'))
+		expected_kconfig.add_entry(
+			kunit_config.KconfigEntry('CONFIG_EXAMPLE_TEST=y'))
+		expected_kconfig.add_entry(
+			kunit_config.KconfigEntry('# CONFIG_MK8 is not set'))
+
+		self.assertEqual(kconfig.entries(), expected_kconfig.entries())
+
+	def test_write_to_file(self):
+		kconfig_path = os.path.join(test_tmpdir, '.config')
+
+		expected_kconfig = kunit_config.Kconfig()
+		expected_kconfig.add_entry(
+			kunit_config.KconfigEntry('CONFIG_UML=y'))
+		expected_kconfig.add_entry(
+			kunit_config.KconfigEntry('CONFIG_MMU=y'))
+		expected_kconfig.add_entry(
+			kunit_config.KconfigEntry('CONFIG_TEST=y'))
+		expected_kconfig.add_entry(
+			kunit_config.KconfigEntry('CONFIG_EXAMPLE_TEST=y'))
+		expected_kconfig.add_entry(
+			kunit_config.KconfigEntry('# CONFIG_MK8 is not set'))
+
+		expected_kconfig.write_to_file(kconfig_path)
+
+		actual_kconfig = kunit_config.Kconfig()
+		actual_kconfig.read_from_file(kconfig_path)
+
+		self.assertEqual(actual_kconfig.entries(),
+				 expected_kconfig.entries())
+
+class KUnitParserTest(unittest.TestCase):
+
+	def assertContains(self, needle, haystack):
+		for line in haystack:
+			if needle in line:
+				return
+		raise AssertionError('"' +
+			str(needle) + '" not found in "' + str(haystack) + '"!')
+
+	def test_output_isolated_correctly(self):
+		log_path = get_absolute_path(
+			'test_data/test_output_isolated_correctly.log')
+		file = open(log_path)
+		result = kunit_parser.isolate_kunit_output(file.readlines())
+		self.assertContains('TAP version 14\n', result)
+		self.assertContains('	# Subtest: example', result)
+		self.assertContains('	1..2', result)
+		self.assertContains('	ok 1 - example_simple_test', result)
+		self.assertContains('	ok 2 - example_mock_test', result)
+		self.assertContains('ok 1 - example', result)
+		file.close()
+
+	def test_parse_successful_test_log(self):
+		all_passed_log = get_absolute_path(
+			'test_data/test_is_test_passed-all_passed.log')
+		file = open(all_passed_log)
+		result = kunit_parser.parse_run_tests(file.readlines())
+		self.assertEqual(
+			kunit_parser.TestStatus.SUCCESS,
+			result.status)
+		file.close()
+
+	def test_parse_failed_test_log(self):
+		failed_log = get_absolute_path(
+			'test_data/test_is_test_passed-failure.log')
+		file = open(failed_log)
+		result = kunit_parser.parse_run_tests(file.readlines())
+		self.assertEqual(
+			kunit_parser.TestStatus.FAILURE,
+			result.status)
+		file.close()
+
+	def test_no_tests(self):
+		empty_log = get_absolute_path(
+			'test_data/test_is_test_passed-no_tests_run.log')
+		file = open(empty_log)
+		result = kunit_parser.parse_run_tests(
+			kunit_parser.isolate_kunit_output(file.readlines()))
+		self.assertEqual(0, len(result.modules))
+		self.assertEqual(
+			kunit_parser.TestStatus.NO_TESTS,
+			result.status)
+		file.close()
+
+	def test_crashed_test(self):
+		crashed_log = get_absolute_path(
+			'test_data/test_is_test_passed-crash.log')
+		file = open(crashed_log)
+		result = kunit_parser.parse_run_tests(file.readlines())
+		self.assertEqual(
+			kunit_parser.TestStatus.TEST_CRASHED,
+			result.status)
+		file.close()
+
+class StrContains(str):
+	def __eq__(self, other):
+		return self in other
+
+class KUnitMainTest(unittest.TestCase):
+	def setUp(self):
+		path = get_absolute_path('test_data/test_is_test_passed-all_passed.log')
+		file = open(path)
+		all_passed_log = file.readlines()
+		self.print_patch = mock.patch('builtins.print')
+		self.print_mock = self.print_patch.start()
+		self.linux_source_mock = mock.Mock()
+		self.linux_source_mock.build_reconfig = mock.Mock(return_value=True)
+		self.linux_source_mock.build_um_kernel = mock.Mock(return_value=True)
+		self.linux_source_mock.run_kernel = mock.Mock(return_value=all_passed_log)
+
+	def tearDown(self):
+		self.print_patch.stop()
+		pass
+
+	def test_run_passes_args_pass(self):
+		kunit.main(['run'], self.linux_source_mock)
+		assert self.linux_source_mock.build_reconfig.call_count == 1
+		assert self.linux_source_mock.run_kernel.call_count == 1
+		self.print_mock.assert_any_call(StrContains('Testing complete.'))
+
+	def test_run_passes_args_fail(self):
+		self.linux_source_mock.run_kernel = mock.Mock(return_value=[])
+		with self.assertRaises(SystemExit) as e:
+			kunit.main(['run'], self.linux_source_mock)
+		assert type(e.exception) == SystemExit
+		assert e.exception.code == 1
+		assert self.linux_source_mock.build_reconfig.call_count == 1
+		assert self.linux_source_mock.run_kernel.call_count == 1
+		self.print_mock.assert_any_call(StrContains(' 0 tests run'))
+
+	def test_run_raw_output(self):
+		self.linux_source_mock.run_kernel = mock.Mock(return_value=[])
+		kunit.main(['run', '--raw_output'], self.linux_source_mock)
+		assert self.linux_source_mock.build_reconfig.call_count == 1
+		assert self.linux_source_mock.run_kernel.call_count == 1
+		for kall in self.print_mock.call_args_list:
+			assert kall != mock.call(StrContains('Testing complete.'))
+			assert kall != mock.call(StrContains(' 0 tests run'))
+
+	def test_run_timeout(self):
+		timeout = 3453
+		kunit.main(['run', '--timeout', str(timeout)], self.linux_source_mock)
+		assert self.linux_source_mock.build_reconfig.call_count == 1
+		self.linux_source_mock.run_kernel.assert_called_once_with(timeout=timeout)
+		self.print_mock.assert_any_call(StrContains('Testing complete.'))
+
+if __name__ == '__main__':
+	unittest.main()
diff --git a/tools/testing/kunit/test_data/test_is_test_passed-all_passed.log b/tools/testing/kunit/test_data/test_is_test_passed-all_passed.log
new file mode 100644
index 0000000000000..8b5aa2f0cb498
--- /dev/null
+++ b/tools/testing/kunit/test_data/test_is_test_passed-all_passed.log
@@ -0,0 +1,32 @@
+TAP version 14
+	# Subtest: sysctl_test
+	1..8
+	# sysctl_test_dointvec_null_tbl_data: sysctl_test_dointvec_null_tbl_data passed
+	ok 1 - sysctl_test_dointvec_null_tbl_data
+	# sysctl_test_dointvec_table_maxlen_unset: sysctl_test_dointvec_table_maxlen_unset passed
+	ok 2 - sysctl_test_dointvec_table_maxlen_unset
+	# sysctl_test_dointvec_table_len_is_zero: sysctl_test_dointvec_table_len_is_zero passed
+	ok 3 - sysctl_test_dointvec_table_len_is_zero
+	# sysctl_test_dointvec_table_read_but_position_set: sysctl_test_dointvec_table_read_but_position_set passed
+	ok 4 - sysctl_test_dointvec_table_read_but_position_set
+	# sysctl_test_dointvec_happy_single_positive: sysctl_test_dointvec_happy_single_positive passed
+	ok 5 - sysctl_test_dointvec_happy_single_positive
+	# sysctl_test_dointvec_happy_single_negative: sysctl_test_dointvec_happy_single_negative passed
+	ok 6 - sysctl_test_dointvec_happy_single_negative
+	# sysctl_test_dointvec_single_less_int_min: sysctl_test_dointvec_single_less_int_min passed
+	ok 7 - sysctl_test_dointvec_single_less_int_min
+	# sysctl_test_dointvec_single_greater_int_max: sysctl_test_dointvec_single_greater_int_max passed
+	ok 8 - sysctl_test_dointvec_single_greater_int_max
+kunit sysctl_test: all tests passed
+ok 1 - sysctl_test
+	# Subtest: example
+	1..2
+init_module
+	# example_simple_test: initializing
+	# example_simple_test: example_simple_test passed
+	ok 1 - example_simple_test
+	# example_mock_test: initializing
+	# example_mock_test: example_mock_test passed
+	ok 2 - example_mock_test
+kunit example: all tests passed
+ok 2 - example
diff --git a/tools/testing/kunit/test_data/test_is_test_passed-crash.log b/tools/testing/kunit/test_data/test_is_test_passed-crash.log
new file mode 100644
index 0000000000000..9ea558882d524
--- /dev/null
+++ b/tools/testing/kunit/test_data/test_is_test_passed-crash.log
@@ -0,0 +1,69 @@
+printk: console [tty0] enabled
+printk: console [mc-1] enabled
+TAP version 14
+	# Subtest: sysctl_test
+	1..8
+	# sysctl_test_dointvec_null_tbl_data: sysctl_test_dointvec_null_tbl_data passed
+	ok 1 - sysctl_test_dointvec_null_tbl_data
+	# sysctl_test_dointvec_table_maxlen_unset: sysctl_test_dointvec_table_maxlen_unset passed
+	ok 2 - sysctl_test_dointvec_table_maxlen_unset
+	# sysctl_test_dointvec_table_len_is_zero: sysctl_test_dointvec_table_len_is_zero passed
+	ok 3 - sysctl_test_dointvec_table_len_is_zero
+	# sysctl_test_dointvec_table_read_but_position_set: sysctl_test_dointvec_table_read_but_position_set passed
+	ok 4 - sysctl_test_dointvec_table_read_but_position_set
+	# sysctl_test_dointvec_happy_single_positive: sysctl_test_dointvec_happy_single_positive passed
+	ok 5 - sysctl_test_dointvec_happy_single_positive
+	# sysctl_test_dointvec_happy_single_negative: sysctl_test_dointvec_happy_single_negative passed
+	ok 6 - sysctl_test_dointvec_happy_single_negative
+	# sysctl_test_dointvec_single_less_int_min: sysctl_test_dointvec_single_less_int_min passed
+	ok 7 - sysctl_test_dointvec_single_less_int_min
+	# sysctl_test_dointvec_single_greater_int_max: sysctl_test_dointvec_single_greater_int_max passed
+	ok 8 - sysctl_test_dointvec_single_greater_int_max
+kunit sysctl_test: all tests passed
+ok 1 - sysctl_test
+	# Subtest: example
+	1..2
+init_module
+	# example_simple_test: initializing
+Stack:
+ 6016f7db 6f81bd30 6f81bdd0 60021450
+ 6024b0e8 60021440 60018bbe 16f81bdc0
+ 00000001 6f81bd30 6f81bd20 6f81bdd0
+Call Trace:
+ [<6016f7db>] ? kunit_try_run_case+0xab/0xf0
+ [<60021450>] ? set_signals+0x0/0x60
+ [<60021440>] ? get_signals+0x0/0x10
+ [<60018bbe>] ? kunit_um_run_try_catch+0x5e/0xc0
+ [<60021450>] ? set_signals+0x0/0x60
+ [<60021440>] ? get_signals+0x0/0x10
+ [<60018bb3>] ? kunit_um_run_try_catch+0x53/0xc0
+ [<6016f321>] ? kunit_run_case_catch_errors+0x121/0x1a0
+ [<60018b60>] ? kunit_um_run_try_catch+0x0/0xc0
+ [<600189e0>] ? kunit_um_throw+0x0/0x180
+ [<6016f730>] ? kunit_try_run_case+0x0/0xf0
+ [<6016f600>] ? kunit_catch_run_case+0x0/0x130
+ [<6016edd0>] ? kunit_vprintk+0x0/0x30
+ [<6016ece0>] ? kunit_fail+0x0/0x40
+ [<6016eca0>] ? kunit_abort+0x0/0x40
+ [<6016ed20>] ? kunit_printk_emit+0x0/0xb0
+ [<6016f200>] ? kunit_run_case_catch_errors+0x0/0x1a0
+ [<6016f46e>] ? kunit_run_tests+0xce/0x260
+ [<6005b390>] ? unregister_console+0x0/0x190
+ [<60175b70>] ? module_kunit_initexample_test_module+0x0/0x20
+ [<60001cbb>] ? do_one_initcall+0x0/0x197
+ [<60001d47>] ? do_one_initcall+0x8c/0x197
+ [<6005cd20>] ? irq_to_desc+0x0/0x30
+ [<60002005>] ? kernel_init_freeable+0x1b3/0x272
+ [<6005c5ec>] ? printk+0x0/0x9b
+ [<601c0086>] ? kernel_init+0x26/0x160
+ [<60014442>] ? new_thread_handler+0x82/0xc0
+
+	# example_simple_test: kunit test case crashed!
+	# example_simple_test: example_simple_test failed
+	not ok 1 - example_simple_test
+	# example_mock_test: initializing
+	# example_mock_test: example_mock_test passed
+	ok 2 - example_mock_test
+kunit example: one or more tests failed
+not ok 2 - example
+List of all partitions:
diff --git a/tools/testing/kunit/test_data/test_is_test_passed-failure.log b/tools/testing/kunit/test_data/test_is_test_passed-failure.log
new file mode 100644
index 0000000000000..73ed8730b76b2
--- /dev/null
+++ b/tools/testing/kunit/test_data/test_is_test_passed-failure.log
@@ -0,0 +1,36 @@
+TAP version 14
+	# Subtest: sysctl_test
+	1..8
+	# sysctl_test_dointvec_null_tbl_data: sysctl_test_dointvec_null_tbl_data passed
+	ok 1 - sysctl_test_dointvec_null_tbl_data
+	# sysctl_test_dointvec_table_maxlen_unset: sysctl_test_dointvec_table_maxlen_unset passed
+	ok 2 - sysctl_test_dointvec_table_maxlen_unset
+	# sysctl_test_dointvec_table_len_is_zero: sysctl_test_dointvec_table_len_is_zero passed
+	ok 3 - sysctl_test_dointvec_table_len_is_zero
+	# sysctl_test_dointvec_table_read_but_position_set: sysctl_test_dointvec_table_read_but_position_set passed
+	ok 4 - sysctl_test_dointvec_table_read_but_position_set
+	# sysctl_test_dointvec_happy_single_positive: sysctl_test_dointvec_happy_single_positive passed
+	ok 5 - sysctl_test_dointvec_happy_single_positive
+	# sysctl_test_dointvec_happy_single_negative: sysctl_test_dointvec_happy_single_negative passed
+	ok 6 - sysctl_test_dointvec_happy_single_negative
+	# sysctl_test_dointvec_single_less_int_min: sysctl_test_dointvec_single_less_int_min passed
+	ok 7 - sysctl_test_dointvec_single_less_int_min
+	# sysctl_test_dointvec_single_greater_int_max: sysctl_test_dointvec_single_greater_int_max passed
+	ok 8 - sysctl_test_dointvec_single_greater_int_max
+kunit sysctl_test: all tests passed
+ok 1 - sysctl_test
+	# Subtest: example
+	1..2
+init_module
+	# example_simple_test: initializing
+	# example_simple_test: EXPECTATION FAILED at kunit/example-test.c:30
+	Expected 1 + 1 == 3, but
+		1 + 1 == 2
+		3 == 3
+	# example_simple_test: example_simple_test failed
+	not ok 1 - example_simple_test
+	# example_mock_test: initializing
+	# example_mock_test: example_mock_test passed
+	ok 2 - example_mock_test
+kunit example: one or more tests failed
+not ok 2 - example
diff --git a/tools/testing/kunit/test_data/test_is_test_passed-no_tests_run.log b/tools/testing/kunit/test_data/test_is_test_passed-no_tests_run.log
new file mode 100644
index 0000000000000..ba69f5c94b75f
--- /dev/null
+++ b/tools/testing/kunit/test_data/test_is_test_passed-no_tests_run.log
@@ -0,0 +1,75 @@
+Core dump limits :
+	soft - 0
+	hard - NONE
+Checking environment variables for a tempdir...none found
+Checking if /dev/shm is on tmpfs...OK
+Checking PROT_EXEC mmap in /dev/shm...OK
+Adding 24743936 bytes to physical memory to account for exec-shield gap
+Linux version 4.12.0-rc3-00010-g7319eb35f493-dirty (brendanhiggins@mactruck.svl.corp.google.com) (gcc version 7.3.0 (Debian 7.3.0-5) ) #29 Thu Mar 15 14:57:19 PDT 2018
+Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 14038
+Kernel command line: root=98:0
+PID hash table entries: 256 (order: -1, 2048 bytes)
+Dentry cache hash table entries: 8192 (order: 4, 65536 bytes)
+Inode-cache hash table entries: 4096 (order: 3, 32768 bytes)
+Memory: 27868K/56932K available (1681K kernel code, 480K rwdata, 400K rodata, 89K init, 205K bss, 29064K reserved, 0K cma-reserved)
+SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
+NR_IRQS:15
+clocksource: timer: mask: 0xffffffffffffffff max_cycles: 0x1cd42e205, max_idle_ns: 881590404426 ns
+Calibrating delay loop... 7384.26 BogoMIPS (lpj=36921344)
+pid_max: default: 32768 minimum: 301
+Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
+Mountpoint-cache hash table entries: 512 (order: 0, 4096 bytes)
+Checking that host ptys support output SIGIO...Yes
+Checking that host ptys support SIGIO on close...No, enabling workaround
+Using 2.6 host AIO
+clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
+futex hash table entries: 256 (order: 0, 6144 bytes)
+clocksource: Switched to clocksource timer
+console [stderr0] disabled
+mconsole (version 2) initialized on /usr/local/google/home/brendanhiggins/.uml/6Ijecl/mconsole
+Checking host MADV_REMOVE support...OK
+workingset: timestamp_bits=62 max_order=13 bucket_order=0
+Block layer SCSI generic (bsg) driver version 0.4 loaded (major 254)
+io scheduler noop registered
+io scheduler deadline registered
+io scheduler cfq registered (default)
+io scheduler mq-deadline registered
+io scheduler kyber registered
+Initialized stdio console driver
+Using a channel type which is configured out of UML
+setup_one_line failed for device 1 : Configuration failed
+Using a channel type which is configured out of UML
+setup_one_line failed for device 2 : Configuration failed
+Using a channel type which is configured out of UML
+setup_one_line failed for device 3 : Configuration failed
+Using a channel type which is configured out of UML
+setup_one_line failed for device 4 : Configuration failed
+Using a channel type which is configured out of UML
+setup_one_line failed for device 5 : Configuration failed
+Using a channel type which is configured out of UML
+setup_one_line failed for device 6 : Configuration failed
+Using a channel type which is configured out of UML
+setup_one_line failed for device 7 : Configuration failed
+Using a channel type which is configured out of UML
+setup_one_line failed for device 8 : Configuration failed
+Using a channel type which is configured out of UML
+setup_one_line failed for device 9 : Configuration failed
+Using a channel type which is configured out of UML
+setup_one_line failed for device 10 : Configuration failed
+Using a channel type which is configured out of UML
+setup_one_line failed for device 11 : Configuration failed
+Using a channel type which is configured out of UML
+setup_one_line failed for device 12 : Configuration failed
+Using a channel type which is configured out of UML
+setup_one_line failed for device 13 : Configuration failed
+Using a channel type which is configured out of UML
+setup_one_line failed for device 14 : Configuration failed
+Using a channel type which is configured out of UML
+setup_one_line failed for device 15 : Configuration failed
+Console initialized on /dev/tty0
+console [tty0] enabled
+console [mc-1] enabled
+List of all partitions:
+No filesystem could mount root, tried:
+
+Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(98,0)
diff --git a/tools/testing/kunit/test_data/test_output_isolated_correctly.log b/tools/testing/kunit/test_data/test_output_isolated_correctly.log
new file mode 100644
index 0000000000000..6e92bc7e28041
--- /dev/null
+++ b/tools/testing/kunit/test_data/test_output_isolated_correctly.log
@@ -0,0 +1,106 @@
+Linux version 5.1.0-rc7-00061-g04652f1cb4aa0 (brendanhiggins@mactruck.svl.corp.google.com) (gcc version 7.3.0 (Debian 7.3.0-18)) #163 Wed May 8 16:18:20 PDT 2019
+Built 1 zonelists, mobility grouping on.  Total pages: 69906
+Kernel command line: mem=256M root=98:0
+Dentry cache hash table entries: 65536 (order: 7, 524288 bytes)
+Inode-cache hash table entries: 32768 (order: 6, 262144 bytes)
+Memory: 254468K/283500K available (1734K kernel code, 489K rwdata, 396K rodata, 85K init, 216K bss, 29032K reserved, 0K cma-reserved)
+SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
+NR_IRQS: 15
+clocksource: timer: mask: 0xffffffffffffffff max_cycles: 0x1cd42e205, max_idle_ns: 881590404426 ns
+------------[ cut here ]------------
+WARNING: CPU: 0 PID: 0 at kernel/time/clockevents.c:458 clockevents_register_device+0x143/0x160
+posix-timer cpumask == cpu_all_mask, using cpu_possible_mask instead
+CPU: 0 PID: 0 Comm: swapper Not tainted 5.1.0-rc7-00061-g04652f1cb4aa0 #163
+Stack:
+ 6005cc00 60233e18 60233e60 60233e18
+ 60233e60 00000009 00000000 6002a1b4
+ 1ca00000000 60071c23 60233e78 100000000000062
+Call Trace:
+ [<600214c5>] ? os_is_signal_stack+0x15/0x30
+ [<6005c5ec>] ? printk+0x0/0x9b
+ [<6001597e>] ? show_stack+0xbe/0x1c0
+ [<6005cc00>] ? __printk_safe_exit+0x0/0x40
+ [<6002a1b4>] ? __warn+0x144/0x170
+ [<60071c23>] ? clockevents_register_device+0x143/0x160
+ [<60021440>] ? get_signals+0x0/0x10
+ [<6005c5ec>] ? printk+0x0/0x9b
+ [<6002a27b>] ? warn_slowpath_fmt+0x9b/0xb0
+ [<6005c5ec>] ? printk+0x0/0x9b
+ [<6002a1e0>] ? warn_slowpath_fmt+0x0/0xb0
+ [<6005c5ec>] ? printk+0x0/0x9b
+ [<60021440>] ? get_signals+0x0/0x10
+ [<600213f0>] ? block_signals+0x0/0x20
+ [<60071c23>] ? clockevents_register_device+0x143/0x160
+ [<60021440>] ? get_signals+0x0/0x10
+ [<600213f0>] ? block_signals+0x0/0x20
+ [<6005c5ec>] ? printk+0x0/0x9b
+ [<60001bc8>] ? start_kernel+0x477/0x56a
+ [<600036f1>] ? start_kernel_proc+0x46/0x4d
+ [<60014442>] ? new_thread_handler+0x82/0xc0
+
+random: get_random_bytes called from print_oops_end_marker+0x4c/0x60 with crng_init=0
+---[ end trace c83434852b3702d3 ]---
+Calibrating delay loop... 6958.28 BogoMIPS (lpj=34791424)
+pid_max: default: 32768 minimum: 301
+Mount-cache hash table entries: 1024 (order: 1, 8192 bytes)
+Mountpoint-cache hash table entries: 1024 (order: 1, 8192 bytes)
+*** VALIDATE proc ***
+Checking that host ptys support output SIGIO...Yes
+Checking that host ptys support SIGIO on close...No, enabling workaround
+clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
+futex hash table entries: 256 (order: 0, 6144 bytes)
+clocksource: Switched to clocksource timer
+printk: console [stderr0] disabled
+mconsole (version 2) initialized on /usr/local/google/home/brendanhiggins/.uml/VZ2qMm/mconsole
+Checking host MADV_REMOVE support...OK
+workingset: timestamp_bits=62 max_order=16 bucket_order=0
+Block layer SCSI generic (bsg) driver version 0.4 loaded (major 254)
+io scheduler mq-deadline registered
+io scheduler kyber registered
+Initialized stdio console driver
+Using a channel type which is configured out of UML
+setup_one_line failed for device 1 : Configuration failed
+Using a channel type which is configured out of UML
+setup_one_line failed for device 2 : Configuration failed
+Using a channel type which is configured out of UML
+setup_one_line failed for device 3 : Configuration failed
+Using a channel type which is configured out of UML
+setup_one_line failed for device 4 : Configuration failed
+Using a channel type which is configured out of UML
+setup_one_line failed for device 5 : Configuration failed
+Using a channel type which is configured out of UML
+setup_one_line failed for device 6 : Configuration failed
+Using a channel type which is configured out of UML
+setup_one_line failed for device 7 : Configuration failed
+Using a channel type which is configured out of UML
+setup_one_line failed for device 8 : Configuration failed
+Using a channel type which is configured out of UML
+setup_one_line failed for device 9 : Configuration failed
+Using a channel type which is configured out of UML
+setup_one_line failed for device 10 : Configuration failed
+Using a channel type which is configured out of UML
+setup_one_line failed for device 11 : Configuration failed
+Using a channel type which is configured out of UML
+setup_one_line failed for device 12 : Configuration failed
+Using a channel type which is configured out of UML
+setup_one_line failed for device 13 : Configuration failed
+Using a channel type which is configured out of UML
+setup_one_line failed for device 14 : Configuration failed
+Using a channel type which is configured out of UML
+setup_one_line failed for device 15 : Configuration failed
+Console initialized on /dev/tty0
+printk: console [tty0] enabled
+printk: console [mc-1] enabled
+TAP version 14
+	# Subtest: example
+	1..2
+init_module
+	# example_simple_test: initializing
+	# example_simple_test: example_simple_test passed
+	ok 1 - example_simple_test
+	# example_mock_test: initializing
+	# example_mock_test: example_mock_test passed
+	ok 2 - example_mock_test
+kunit example: all tests passed
+ok 1 - example
+List of all partitions:
diff --git a/tools/testing/kunit/test_data/test_read_from_file.kconfig b/tools/testing/kunit/test_data/test_read_from_file.kconfig
new file mode 100644
index 0000000000000..d2a4928ac773b
--- /dev/null
+++ b/tools/testing/kunit/test_data/test_read_from_file.kconfig
@@ -0,0 +1,17 @@
+#
+# Automatically generated file; DO NOT EDIT.
+# User Mode Linux/x86 4.12.0-rc3 Kernel Configuration
+#
+CONFIG_UML=y
+CONFIG_MMU=y
+
+#
+# UML-specific options
+#
+
+#
+# Host processor type and features
+#
+# CONFIG_MK8 is not set
+CONFIG_TEST=y
+CONFIG_EXAMPLE_TEST=y
-- 
2.21.0.1020.gf2820cf01a-goog

