Return-Path: <linux-fsdevel+bounces-66141-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A90B2C17DD1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 02:23:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 53BCD4F555B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 01:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F3992DC336;
	Wed, 29 Oct 2025 01:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eNRZ7vrG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77CF62D8388;
	Wed, 29 Oct 2025 01:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761700873; cv=none; b=rT9cV3aTYq0bKgg7N5BzDGnaz+PBWSHlZGyKxipU2qgbPF0VIeBZL6R16v6rhK5K+VN7fgkEykYw2sNW37g8PHJje59lzRXFZsCYAiIR9KMdYThXWqKuv4cJdBzHIvCf3NSTYmom6/iWp9rNJLxucLDyRfLiSK/f8q/cargNolM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761700873; c=relaxed/simple;
	bh=QRJ1SPXvNlRLC7kF9RT+of34ldzcqeaeOxSpT142nns=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lhyzwAdtv8t08l9hQETClWy7tcUT9sPakc+XpCMiq+XWjYojvH+u4nwm+f7L47K0Qave8Oq5csPi0LGz14kJyqSP+sGbX0ekeEZfgfHCo79zMzV/6tcxDNq8w6NdlzfZgVI1of+IbqA/Z4Vm/TWP1+6ZrrUTSpVqxPgH7aCKSOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eNRZ7vrG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 515BCC4CEE7;
	Wed, 29 Oct 2025 01:21:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761700873;
	bh=QRJ1SPXvNlRLC7kF9RT+of34ldzcqeaeOxSpT142nns=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=eNRZ7vrG4ZDXfXIA6iUSzWXt2Y6CsGwg2ziowS07BZQh/v/QtMwafdsBqC+I708nm
	 nktuQJtbC4l4NBGFc7an5TO9nEDuKQAhhA8+HhOTzT+JmA5O3JwGNSv/M5sBr+q+1Z
	 g5L/vq0oMVzInpRe8T9QdBnFEP6xXbBlUYhnmLt6EZZE6iQdr1j8MKLTs8b5pYfF2N
	 /9nB3tN6cQ74fUOK5OvDrg72ooTmz0EY4mQjg416TjTpE/fWDc+WCs8mTuEANBSh29
	 ouUszKFMc0PcI7pWSK7cuUk6F/X32OKDDqv94uZa24MZvp20b+ake+Nknn5vW2pdx4
	 l9BTybh1/0rwg==
Date: Tue, 28 Oct 2025 18:21:12 -0700
Subject: [PATCH 03/33] ext/052: use popdir.pl for much faster directory
 creation
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, zlang@redhat.com
Cc: neal@gompa.dev, fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, joannelkoong@gmail.com, bernd@bsbernd.com
Message-ID: <176169820032.1433624.6179702780762580279.stgit@frogsfrogsfrogs>
In-Reply-To: <176169819804.1433624.11241650941850700038.stgit@frogsfrogsfrogs>
References: <176169819804.1433624.11241650941850700038.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

This program wants to create a large directory htree index, and it
doesn't care what the children are.  Reduce the runtime of this program
by 2/3 by using hardlinks when possible instead of allocating 400,000
new child files.  This is an even bigger win for fuse2fs, which has a
runtime of 6.5h.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 src/popdir.pl  |    9 ++++++++-
 tests/ext4/052 |    4 +++-
 2 files changed, 11 insertions(+), 2 deletions(-)


diff --git a/src/popdir.pl b/src/popdir.pl
index 0104957a3c941e..251500c2255f33 100755
--- a/src/popdir.pl
+++ b/src/popdir.pl
@@ -72,7 +72,14 @@ for ($i = $start; $i <= $end; $i += $incr) {
 	} elsif ($hardlink && $i > $start) {
 		# hardlink everything after the first file
 		$verbose && print "ln $link_fname $fname\n";
-		link $link_fname, $fname;
+		if (not link $link_fname, $fname) {
+			# if hardlink fails, create a new file in case the old
+			# file reached maximum link count
+			$verbose && print "touch $fname\n";
+			open(DONTCARE, ">$fname") or die("touch $fname");
+			close(DONTCARE);
+			$link_fname = $fname;
+		}
 	} elsif (($i % 100) < $file_pct) {
 		# create a file
 		$verbose && print "touch $fname\n";
diff --git a/tests/ext4/052 b/tests/ext4/052
index 0df8a651383ec7..18b2599f43c7ba 100755
--- a/tests/ext4/052
+++ b/tests/ext4/052
@@ -56,7 +56,9 @@ mkdir -p $loop_mnt
 _mount -o loop $fs_img $loop_mnt > /dev/null  2>&1 || \
 	_fail "Couldn't do initial mount"
 
-if ! $here/src/dirstress -c -d $loop_mnt -p 1 -f 400000 -C >$tmp.out 2>&1
+# popdir.pl is much faster than creating 400k file with dirstress
+mkdir "${loop_mnt}/stress.0"
+if ! $here/src/popdir.pl --dir "${loop_mnt}/stress.0" --end 400000 --hardlink --format "XXXXXXXXXXXX.%ld" > $tmp.out 2>&1
 then
     echo "    dirstress failed"
     cat $tmp.out >> $seqres.full


