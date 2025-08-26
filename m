Return-Path: <linux-fsdevel+bounces-59328-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D890B374CA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Aug 2025 00:12:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B3801BA3810
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 22:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B6D0298CDC;
	Tue, 26 Aug 2025 22:12:06 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from swift.blarg.de (swift.blarg.de [138.201.185.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A131285066;
	Tue, 26 Aug 2025 22:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=138.201.185.127
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756246325; cv=none; b=cfYRByg98ZtegSFPUxNV7hCIbczAXqEclECFQzEAVLG15mIc+TSowTCln8eh41Zadfy60QnBVlxe/KeeA/mZNmf5dc0IKTLT66jJVXOcHSYULU+He9m90ljlDmuY3WUDb/NpK799rwq6tIIf9hEuMWBoaB4aNk4nDySHOAGcUWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756246325; c=relaxed/simple;
	bh=axbDgC6TZ/6iD0rUF1v3+UsDg26wluzCTmRO4qKZKsc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cN8wPFX1JK2lrVS75FAagr8qbh6iquAC4l28wuPan9icvgW8veqzT3ecK+qvHh+XrbVIAaafETlVYuRO0UFZTZhvhqKwiiFy7XPP6YQ8Akfd8UE8v1Q4kSFPnup0lS57k9BSE/BfHI0ZuBV8zlVgHlZPbxHV32KntYin5hcmtDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blarg.de; spf=pass smtp.mailfrom=blarg.de; arc=none smtp.client-ip=138.201.185.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blarg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=blarg.de
Received: from swift.blarg.de (swift.blarg.de [IPv6:2a01:4f8:c17:52a8::2])
	(Authenticated sender: max)
	by swift.blarg.de (Postfix) with ESMTPSA id 24830402D4;
	Wed, 27 Aug 2025 00:06:33 +0200 (CEST)
Date: Wed, 27 Aug 2025 00:06:31 +0200
From: Max Kellermann <max@blarg.de>
To: Matthew Wilcox <willy@infradead.org>, brauner@kernel.org
Cc: Viacheslav Dubeyko <slava@dubeyko.com>, ceph-devel@vger.kernel.org,
	idryomov@gmail.com, dhowells@redhat.com,
	linux-fsdevel@vger.kernel.org, pdonnell@redhat.com,
	amarkuze@redhat.com, Slava.Dubeyko@ibm.com,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 3/4] ceph: introduce ceph_submit_write() method
Message-ID: <aK4v548CId5GIKG1@swift.blarg.de>
Mail-Followup-To: Matthew Wilcox <willy@infradead.org>, brauner@kernel.org,
	Viacheslav Dubeyko <slava@dubeyko.com>, ceph-devel@vger.kernel.org,
	idryomov@gmail.com, dhowells@redhat.com,
	linux-fsdevel@vger.kernel.org, pdonnell@redhat.com,
	amarkuze@redhat.com, Slava.Dubeyko@ibm.com,
	linux-kernel@vger.kernel.org
References: <20250205000249.123054-1-slava@dubeyko.com>
 <20250205000249.123054-4-slava@dubeyko.com>
 <Z6-xg-p_mi3I1aMq@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6-xg-p_mi3I1aMq@casper.infradead.org>

On 2025/02/14 22:11, Matthew Wilcox <willy@infradead.org> wrote:
> On Tue, Feb 04, 2025 at 04:02:48PM -0800, Viacheslav Dubeyko wrote:
> > This patch implements refactoring of ceph_submit_write()
> > and also it solves the second issue.
> > 
> > Signed-off-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
> 
> This kind of giant refactoring to solve a bug is a really bad idea.
> First, it's going to need to be backported to older kernels.  How far
> back?  You need to identify that with a Fixes: line.
> 
> It's also really hard to review and know whether it's right.  You might
> have introduced several new bugs while doing it.  In general, bugfixes
> first, refactor later.  I *think* this means we can do without 1/7 of
> the patches I resent earlier today, but it's really hard to be sure.

I'm very disappointed that nobody has listened to Matthew's complaint.
Viacheslav has only hand-waved it away with a lazy non-argument.

From Documentation/process/submitting-patches.rst:

 "you should not modify the moved code at all in the same patch which
 moves it"

Obviously, this patch set violates this rule.  There are lots of
semantic/behavior changes in the patches that move code around.

In the end, Christian Brauner has merged this into Linux 6.15 and that
merge has wreaked havoc in our production clusters.  We have been
testing 6.15 for a month with no problems (after David Howells had
fixed yet-another netfs regression that was stable-backported to 6.15,
ugh!), but when we updated a production clusters, all servers had
crashed after a few hours, and our ops team had a very bad night.

This patch set is obviously bad.  It pretends to fix a bug, but really
rewrites almost everything in two patches documented as "introduce XY
method" with no real explanation for why Viacheslav has decided to do
it, instead of just fixing the bug (as Matthew asked him to).

Look at this line modified by patch "ceph: extend ceph_writeback_ctl
for ceph_writepages_start() refactoring":

> +             ceph_wbc.fbatch.folios[i] = NULL;

This sets a folio_batch element to NULL, which will, of course, crash
in folios_put_refs() (but only if the global huge zero page has
already been created).  Fortunately, there's code that removes all
NULL elements from the folio_batch array.  That is code that already
existed before Viacheslav's patch set (code which I already dislike
because it's a fragile mess that is just waiting to crash), and the
code was only being moved around.

Did I mention that I think this is a fragile mess?  Fast-forward to
Viacheslav's patch "ceph: introduce ceph_process_folio_batch() method"
which moves the NULL-setting loop to ceph_process_folio_batch().  Look
at this (untouched) piece of code after the ceph_process_folio_batch()
call:

>   if (i) {
>        unsigned j, n = 0;
>        /* shift unused page to beginning of fbatch */

Shifting only happens if at least one folio has been processed ("i"
was incremented).  But does it really happen?

No, the loop was moved to ceph_process_folio_batch(), and nobody ever
increments "i" anymore.  Voila, crash due to NULL pointer dereference:

 BUG: kernel NULL pointer dereference, address: 0000000000000034
 #PF: supervisor write access in kernel mode
 #PF: error_code(0x0002) - not-present page
 PGD 0 P4D 0 
 Oops: Oops: 0002 [#1] SMP NOPTI
 CPU: 172 UID: 0 PID: 2342707 Comm: kworker/u778:8 Not tainted 6.15.10-cm4all1-es #714 NONE 
 Hardware name: Dell Inc. PowerEdge R7615/0G9DHV, BIOS 1.6.10 12/08/2023
 Workqueue: writeback wb_workfn (flush-ceph-1)
 RIP: 0010:folios_put_refs+0x85/0x140
 Code: 83 c5 01 39 e8 7e 76 48 63 c5 49 8b 5c c4 08 b8 01 00 00 00 4d 85 ed 74 05 41 8b 44 ad 00 48 8b 15 b0 >
 RSP: 0018:ffffb880af8db778 EFLAGS: 00010207
 RAX: 0000000000000001 RBX: 0000000000000000 RCX: 0000000000000003
 RDX: ffffe377cc3b0000 RSI: 0000000000000000 RDI: ffffb880af8db8c0
 RBP: 0000000000000000 R08: 000000000000007d R09: 000000000102b86f
 R10: 0000000000000001 R11: 00000000000000ac R12: ffffb880af8db8c0
 R13: 0000000000000000 R14: 0000000000000000 R15: ffff9bd262c97000
 FS:  0000000000000000(0000) GS:ffff9c8efc303000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 0000000000000034 CR3: 0000000160958004 CR4: 0000000000770ef0
 PKRU: 55555554
 Call Trace:
  <TASK>
  ceph_writepages_start+0xeb9/0x1410

Viacheslav's third patch "ceph: introduce ceph_submit_write() method"
messes up the logic a bit more and makes it more fragile by hiding the
shifting code behind more conditions:

- if ceph_process_folio_batch() fails, shifting never happens

- if ceph_move_dirty_page_in_page_array() was never called (because
  ceph_process_folio_batch() has returned early for some of various
  reasons), shifting never happens

- if processed_in_fbatch is zero (because ceph_process_folio_batch()
  has returned early for some of the reasons mentioned above or
  because ceph_move_dirty_page_in_page_array() has failed), shifting
  never happens

If shifting doesn't happen, then the kernel crashes (unless
huge-zero-page doesn't exist, see above).  Obviously, nobody has ever
looked closely enough at the code.  I'm still new to Linux memory
management and file systems, but these problems were obvious when I
first saw this patch set (which was my candidate for the other 6.15
crashes which then turned out to be netfs regressions, not Ceph).

This whole patch set is a huge mess and has caused my team a good
amount of pain.  This could and should have been avoided, had only
somebody listened to Matthew.

(Also look at all those "checkpatch.pl" complaints on all patches in
this patch set.  There are many coding style violations.)

Can we please revert the whole patch set?  I don't think it's possible
to fix all the weird undocumented side effects that may cause more
crashes once we fix this one.  Refactoring the Ceph code sure is
necessary, it's not in a good shape, but it should be done more
carefully.  Some people (like me) depend on Ceph's stability, and this
mess is doing a disservice to Ceph's reputation.

Max

