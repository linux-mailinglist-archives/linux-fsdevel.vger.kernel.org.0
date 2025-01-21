Return-Path: <linux-fsdevel+bounces-39780-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A8BC5A17F30
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jan 2025 14:53:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D7623A54A5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jan 2025 13:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D5291F2C56;
	Tue, 21 Jan 2025 13:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="Bld4K0w5";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="Bld4K0w5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [104.223.66.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88D71494D9;
	Tue, 21 Jan 2025 13:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.223.66.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737467587; cv=none; b=UvYXugyFwYcayicnX8nMxbCkEhayokagjtBN/aOBurgcfy4Hhz2D23ffFjX0HACE6wlwcanQKl9/jVV8fXTusJNznMxqrfhDGeNZjiETqBnkBgHS34RXhc91MCoPHw4QL7WTbhFHaIdIAM9ZOnssc7KuLbD1xDQZtToqDH48Wtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737467587; c=relaxed/simple;
	bh=F0C6oJSsZEautBovLe0AbW0FFAFBf/2HLcxblOFFCnI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=L435nzj9nGIst22ybBVwwK9T/jcMuy2GRtS7lR78Uk4ggEJAx8zAazWxnqaV09zhCZ3W8MDy73Mk57OmG3hKIrn6SbvypOW179j5Ys2xXQ+LIj5jL99iqWzVmyOrKgGbODkr+4lzMRTbgCAu23kjRGZF2EnmhKxloB4+oLXAADE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=Bld4K0w5; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=Bld4K0w5; arc=none smtp.client-ip=104.223.66.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1737467584;
	bh=F0C6oJSsZEautBovLe0AbW0FFAFBf/2HLcxblOFFCnI=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=Bld4K0w5qnFwMjYulyLsWunOVcDXHvF3+Q2ZI87w6gNNmG9RCtKG21xMuUoQXt5ue
	 dU3CSIc4I82Qea8viVAmiK+6thSfNB1IIF6/udOJLWwlgdwB7yCkDclerTJ8IqKinm
	 3h/qAgQ2Yt+fFBiRF6EIkr4hOZryPM5bOHMWJKlI=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id BD6BF1286986;
	Tue, 21 Jan 2025 08:53:04 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id IZ4WgiAb53GB; Tue, 21 Jan 2025 08:53:04 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1737467584;
	bh=F0C6oJSsZEautBovLe0AbW0FFAFBf/2HLcxblOFFCnI=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=Bld4K0w5qnFwMjYulyLsWunOVcDXHvF3+Q2ZI87w6gNNmG9RCtKG21xMuUoQXt5ue
	 dU3CSIc4I82Qea8viVAmiK+6thSfNB1IIF6/udOJLWwlgdwB7yCkDclerTJ8IqKinm
	 3h/qAgQ2Yt+fFBiRF6EIkr4hOZryPM5bOHMWJKlI=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::db7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id E65531286976;
	Tue, 21 Jan 2025 08:53:03 -0500 (EST)
Message-ID: <a2a45871928362a5af391f0f0dbba00f7aa683c5.camel@HansenPartnership.com>
Subject: Re: [PATCH v3 0/8] convert efivarfs to manage object data correctly
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-efi@vger.kernel.org, Jeremy Kerr
	 <jk@ozlabs.org>, Christian Brauner <brauner@kernel.org>, Al Viro
	 <viro@zeniv.linux.org.uk>
Date: Tue, 21 Jan 2025 08:53:02 -0500
In-Reply-To: <7217bfc596e48cf228bd63aec68e4b18c64524f5.camel@HansenPartnership.com>
References: <20250119151214.23562-1-James.Bottomley@HansenPartnership.com>
	 <CAMj1kXEaWBaL2YtqFrEGD1i5tED8kjZGmc1G7bhTqwkHqTfHbg@mail.gmail.com>
	 <CAMj1kXG1L_pYiXoy+OOFKko4r8NhsPX7qLXcwzMdTTHBS1Yibw@mail.gmail.com>
	 <7217bfc596e48cf228bd63aec68e4b18c64524f5.camel@HansenPartnership.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

On Mon, 2025-01-20 at 13:57 -0500, James Bottomley wrote:
> On Mon, 2025-01-20 at 17:31 +0100, Ard Biesheuvel wrote:
> > On Sun, 19 Jan 2025 at 17:59, Ard Biesheuvel <ardb@kernel.org>
> > wrote:
> > > 
> > > On Sun, 19 Jan 2025 at 16:12, James Bottomley
> > > <James.Bottomley@hansenpartnership.com> wrote:
> > > > 
> > ...
> > > 
> > > Thanks James. I've queued up this version now, so we'll get some
> > > coverage from the robots. I'll redo my own testing tomorrow, but
> > > I'll omit these changes from my initial PR to Linus. If we're
> > > confident that things are sound, I'll send another PR during the
> > > second half of the merge window.
> > 
> > I'm hitting the failure cases below. The first one appears to hit
> > the same 'Operation not permitted' condition on the write, the
> > error message is just hidden by the /dev/null redirect.
> > 
> > I'm running the make command from a root shell. Using printf from
> > the command line works happily so I suspect there is some issue
> > with the concurrency and the subshells?
> 
> It could be that the file isn't opened until the subshell is spawned.
> I can probably use the pipe to wait for the subshell to start; I'll
> try to code that up.

OK, this is what I came up with.  It works for me (but then so did the
other script ... I think my testing VM is probably a little slow).

Regards,

James

--->8>8>8<8<8<8---

From: James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: [PATCH] selftests/efivarfs: add concurrent update tests

The delete on last close functionality can now only be tested properly
by using multiple threads to hold open the variable files and testing
what happens as they complete.

Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>

---

diff --git a/tools/testing/selftests/efivarfs/efivarfs.sh b/tools/testing/selftests/efivarfs/efivarfs.sh
index 4a84a810dc2c..57e2e151b8d9 100755
--- a/tools/testing/selftests/efivarfs/efivarfs.sh
+++ b/tools/testing/selftests/efivarfs/efivarfs.sh
@@ -227,6 +227,136 @@ test_no_set_size()
 	exit $ret
 }
 
+setup_test_multiple()
+{
+	##
+	# we're going to do multi-threaded tests, so create a set of
+	# pipes for synchronization.  We use pipes 1..3 to start the
+	# stalled shell job and pipes 4..6 as indicators that the job
+	# has started.  If you need more than 3 jobs the two +3's below
+	# need increasing
+	##
+
+	declare -ag p
+
+	# empty is because arrays number from 0 but jobs number from 1
+	p[0]=""
+
+	for f in 1 2 3 4 5 6; do
+		p[$f]=/tmp/efivarfs_pipe${f}
+		mknod ${p[$f]} p
+	done
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
+	waitstart() {
+		cat ${p[$[$1+3]]} > /dev/null
+	}
+
+	waitpipe() {
+		echo 1 > ${p[$[$1+3]]}
+		cat ${p[$1]} > /dev/null
+	}
+
+	endjob() {
+		echo 1 > ${p[$1]}
+		wait -n %$1
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
+	waitstart 1
+	# zero length file should exist
+	[ -e $var ] || exit 1
+	# second and third delayed close
+	{ waitpipe 2; } < $var &
+	waitstart 2
+	{ waitpipe 3; } < $var &
+	waitstart 3
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
+	waitstart 1
+	[ -e $var -a ! -s $var ] || exit 1
+	{ waitpipe 2; } < $var &
+	waitstart 2
+	{ waitpipe 3; } < $var &
+	waitstart 3
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
+	waitstart 1
+	[ -e $var -a -s $var ] || exit 1
+	{ waitpipe 2; } < $var &
+	waitstart 2
+	{ waitpipe 3; } < $var &
+	waitstart 3
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
@@ -240,5 +370,9 @@ run_test test_open_unlink
 run_test test_valid_filenames
 run_test test_invalid_filenames
 run_test test_no_set_size
+setup_test_multiple
+run_test test_multiple_zero_size
+run_test test_multiple_create
+run_test test_multiple_delete_on_write
 
 exit $rc


