Return-Path: <linux-fsdevel+bounces-39621-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40D79A1628D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Jan 2025 16:15:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F4767A2DB0
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Jan 2025 15:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FE181DF26A;
	Sun, 19 Jan 2025 15:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="qo48mERn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [104.223.66.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3218F1401C;
	Sun, 19 Jan 2025 15:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.223.66.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737299749; cv=none; b=F/VHUf1C63Y+kfrClIkl1dMBe7aYyNeXVXrLOYxpCt1E9OPPzvSxpAeKyPTkvwsSp1Vj3leVMOll9lXXiPwManul/Eu0V0/7zw7YH5TpGITKOTmjqAgMTHX2FG6+MdiAqNaXdvHTHpH1V7VLSMAX5zAIDv2VKCafgSIXYHIqOCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737299749; c=relaxed/simple;
	bh=aTXkvWtNPTWphz69PgMRfYO//YWs6Qr/ccLbO6weQqc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mjykGfkAIKh2uf2VZ9NmIk5p7p+y0Ud9C2J8LHExwxtVjFfjOm+qdVM7pxvZwzzzctTPjkcBJFZh2NTWUzQfYdk7LMvRSpEPNBbpQx/nPzs3iC8ezDzih5OQFqg4OZ2MNnuyGmhYtD5vJ1abC4wJnXHm7s9fFjTa4Yeg9FQnAso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=qo48mERn; arc=none smtp.client-ip=104.223.66.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1737299747;
	bh=aTXkvWtNPTWphz69PgMRfYO//YWs6Qr/ccLbO6weQqc=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:From;
	b=qo48mERnchIGgNG9E4o92dQXzWzXSETCCYKQCe3ooigp3CvCps40ThXVKPLYWl6tf
	 AC39g2elGHMZD0070Fy/9fjJWxu2bE2sV84O2OXkZjWWZF7gCOfVl4dvWjPkoOzi5q
	 V2tN/kkzcBXbSTD1/vaF8+OK5d3ovsP7zNRBxzQs=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 61A03128694C;
	Sun, 19 Jan 2025 10:15:47 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id LXqHuufayWZO; Sun, 19 Jan 2025 10:15:47 -0500 (EST)
Received: from lingrow.int.hansenpartnership.com (unknown [153.66.160.227])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 90A251286946;
	Sun, 19 Jan 2025 10:15:46 -0500 (EST)
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: linux-fsdevel@vger.kernel.org,
	linux-efi@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>,
	Jeremy Kerr <jk@ozlabs.org>,
	Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH v3 8/8] selftests/efivarfs: add concurrent update tests
Date: Sun, 19 Jan 2025 10:12:14 -0500
Message-Id: <20250119151214.23562-9-James.Bottomley@HansenPartnership.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250119151214.23562-1-James.Bottomley@HansenPartnership.com>
References: <20250119151214.23562-1-James.Bottomley@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The delete on last close functionality can now only be tested properly
by using multiple threads to hold open the variable files and testing
what happens as they complete.

Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
---
 tools/testing/selftests/efivarfs/efivarfs.sh | 114 +++++++++++++++++++
 1 file changed, 114 insertions(+)

diff --git a/tools/testing/selftests/efivarfs/efivarfs.sh b/tools/testing/selftests/efivarfs/efivarfs.sh
index 4a84a810dc2c..69b77bbf146d 100755
--- a/tools/testing/selftests/efivarfs/efivarfs.sh
+++ b/tools/testing/selftests/efivarfs/efivarfs.sh
@@ -227,6 +227,116 @@ test_no_set_size()
 	exit $ret
 }
 
+setup_test_multiple()
+{
+	##
+	# we're going to do multi-threaded tests, so create a couple
+	# of pipes for synchronization
+	##
+
+	# empty is because arrays number from 0 but jobs number from 1
+	p=("" /tmp/efivarfs_pipe1 /tmp/efivarfs_pipe2 /tmp/efivarfs_pipe3)
+	# create but ignore failure
+	mknod ${p[1]} p
+	mknod ${p[2]} p
+	mknod ${p[3]} p
+
+	declare -g var=$efivarfs_mount/test_multiple-$test_guid
+
+	cleanup() {
+		for f in ${p[@]}; do
+			rm -f ${f}
+		done
+		if [ -e $var ]; then
+			file_cleanup $var
+		fi
+	}
+	trap cleanup exit
+
+	waitpipe() {
+		cat ${p[$1]} > /dev/null
+	}
+
+	endjob() {
+		echo 1 > ${p[$1]}
+		while jobs %${1}; do true; done > /dev/null 2>&1
+	}
+}
+
+test_multiple_zero_size()
+{
+	##
+	# check for remove on last close, set up three threads all
+	# holding the variable (one write and two reads) and then
+	# close them sequentially (waiting for completion) and check
+	# the state of the variable
+	##
+
+	{ waitpipe 1; echo 1; } > $var 2> /dev/null &
+	# zero length file should exist
+	[ -e $var ] || exit 1
+	# second and third delayed close
+	{ waitpipe 2; } < $var &
+	{ waitpipe 3; } < $var &
+	# close first fd
+	endjob 1
+	# var should only be deleted on last close
+	[ -e $var ] || exit 1
+	# close second fd
+	endjob 2
+	[ -e $var ] || exit 1
+	# file should go on last close
+	endjob 3
+	[ ! -e $var ] || exit 1
+}
+
+test_multiple_create()
+{
+	##
+	# set multiple threads to access the variable but delay
+	# the final write to check the close of 2 and 3.  The
+	# final write should succeed in creating the variable
+	##
+	{ waitpipe 1; printf '\x07\x00\x00\x00\x54'; } > $var &
+	[ -e $var -a ! -s $var ] || exit 1
+	{ waitpipe 2; } < $var &
+	{ waitpipe 3; } < $var &
+	# close second and third fds
+	endjob 2
+	# var should only be created (have size) on last close
+	[ -e $var -a ! -s $var ] || exit 1
+	endjob 3
+	[ -e $var -a ! -s $var ] || exit 1
+	# close first fd
+	endjob 1
+	# variable should still exist
+	[ -s $var ] || exit 1
+	file_cleanup $var
+}
+
+test_multiple_delete_on_write() {
+	##
+	# delete the variable on final write; seqencing similar
+	# to test_multiple_create()
+	##
+	printf '\x07\x00\x00\x00\x54' > $var
+	chattr -i $var
+	{ waitpipe 1; printf '\x07\x00\x00\x00'; } > $var &
+	[ -e $var -a -s $var ] || exit 1
+	{ waitpipe 2; } < $var &
+	{ waitpipe 3; } < $var &
+	# close first fd; write should set variable size to zero
+	endjob 1
+	# var should only be deleted on last close
+	[ -e $var -a ! -s $var ] || exit 1
+	endjob 2
+	[ -e $var ] || exit 1
+	# close last fd
+	endjob 3
+	# variable should now be removed
+	[ ! -e $var ] || exit 1
+}
+
 check_prereqs
 
 rc=0
@@ -240,5 +350,9 @@ run_test test_open_unlink
 run_test test_valid_filenames
 run_test test_invalid_filenames
 run_test test_no_set_size
+setup_test_multiple
+run_test test_multiple_zero_size
+run_test test_multiple_create
+run_test test_multiple_delete_on_write
 
 exit $rc
-- 
2.35.3


