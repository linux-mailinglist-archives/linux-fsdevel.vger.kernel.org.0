Return-Path: <linux-fsdevel+bounces-42117-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4260BA3C92E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2025 20:52:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1225B178DDA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2025 19:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7EDB22CBCC;
	Wed, 19 Feb 2025 19:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B+nvF/kz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BEB522B8A2;
	Wed, 19 Feb 2025 19:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739994737; cv=none; b=OYtl77p1zRnqfoi3Zn0v2gds8Wugidd76n+YOw9TF5bHqOvB50CrPuh8HH6KoYeI3LJRnahxgGTQA9ZaxYx5vaxSllZogEnTO8IV63ByFqxedY7h9ryc5Bum7pNJALnkv+GiMSF4Q5HT57pmuyshVGDApJlPPjnn3ndJbzgSqcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739994737; c=relaxed/simple;
	bh=DOLQO1RhmFhLWn7hxDgAwrHM0OygQR57BvyDe/z/2wI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RhaB/yg8s7lUcEc5UIn1M7KQJAEC2NFou5g3yfDr+pC6HLx7mnGyJi4u/aXmHRlaBkAT3MKLnhwFJ00hGwokC8v8QlOfusBY8ks7Whgnd4rlkkw/zn/IfkPHEiZfIMH40P0hm8p4V2JoJCCYa+8cJhsArc5rZ+wNAStuj0G+Upg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B+nvF/kz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5D99C4CED1;
	Wed, 19 Feb 2025 19:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739994734;
	bh=DOLQO1RhmFhLWn7hxDgAwrHM0OygQR57BvyDe/z/2wI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B+nvF/kzUx8ChqdNJGi4mLE5l7ace1wA4FRzx2E0rnuH98fibIN30MigbxOXBGOOS
	 7HiekgYP6+Rn3tqCwgOWIvRfGwzvTxQPLfrLfNotoHBEjop2kGVs8C4T1098tm+UGu
	 wnjLKRz3NbY5b5mL0vhn4/s2ev10wIbZ3Htq0sBijZc15A9hn1bIO9gL+Lju8usPbR
	 jjqWZyY8sNs6aQBOTFKXebmpFKuwtzQxbbSOeoOX8YlKTl0ddB7cOHGgVAPvCHhk0u
	 fYGZoBSBE1lSU79SMxq+EjZtJYpYunCpCaWJZrbuZJq/q1pX9KXzw/dWTpdW6aD31W
	 QgHfoUx6KDaXw==
Date: Wed, 19 Feb 2025 11:52:11 -0800
From: Kees Cook <kees@kernel.org>
To: Jan Kara <jack@suse.cz>, Michael Stapelberg <michael@stapelberg.ch>,
	Brian Mak <makb@juniper.net>
Cc: Christian Brauner <brauner@kernel.org>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v3] binfmt_elf: Dump smaller VMAs first in ELF cores
Message-ID: <202502191134.CC80931AC9@keescook>
References: <036CD6AE-C560-4FC7-9B02-ADD08E380DC9@juniper.net>
 <20250218085407.61126-1-michael@stapelberg.de>
 <39FC2866-DFF3-43C9-9D40-E8FF30A218BD@juniper.net>
 <a3owf3zywbnntq4h4eytraeb6x7f77lpajszzmsy5d7zumg3tk@utzxmomx6iri>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a3owf3zywbnntq4h4eytraeb6x7f77lpajszzmsy5d7zumg3tk@utzxmomx6iri>

On Wed, Feb 19, 2025 at 05:20:17PM +0100, Jan Kara wrote:
> On Tue 18-02-25 19:53:51, Brian Mak wrote:
> > On Feb 18, 2025, at 12:54 AM, Michael Stapelberg <michael@stapelberg.ch> wrote:
> > 
> > > I think in your testing, you probably did not try the eu-stack tool
> > > from the elfutils package, because I think I found a bug:
> > 
> > Hi Michael,
> > 
> > Thanks for the report. I can confirm that this issue does seem to be
> > from this commit. I tested it with Juniper's Linux kernel with and
> > without the changes.
> > 
> > You're correct that the original testing done did not include the
> > eu-stack tool.
> > 
> > > Current elfutils cannot symbolize core dumps created by Linux 6.12+.
> > > I noticed this because systemd-coredump(8) uses elfutils, and when
> > > a program crashed on my machine, syslog did not show function names.
> > > 
> > > I reported this issue with elfutils at:
> > > https://urldefense.com/v3/__https://sourceware.org/bugzilla/show_bug.cgi?id=32713__;!!NEt6yMaO-gk!DbttKuHxkBdrV4Cj9axM3ED6mlBHXeQGY3NVzvfDlthl-K39e9QIrZcwT8iCXLRu0OivWRGgficcD-aCuus$
> > > …but figured it would be good to give a heads-up here, too.
> > > 
> > > Is this breakage sufficient reason to revert the commit?
> > > Or are we saying userspace just needs to be updated to cope?
> > 
> > The way I see it is that, as long as we're in compliance with the
> > applicable ELF specifications, then the issue lies with userspace apps
> > to ensure that they are not making additional erroneous assumptions.
> > 
> > However, Eric mentioned a while ago in v1 of this patch that he believes
> > that the ELF specification requires program headers be written in memory
> > order. Digging through the ELF specifications, I found that any loadable
> > segment entries in the program header table must be sorted on the
> > virtual address of the first byte of which the segment resides in
> > memory.
> > 
> > This indicates that we have deviated from the ELF specification with
> > this commit. One thing we can do to remedy this is to have program
> > headers sorted according to the specification, but then continue dumping
> > in VMA size ordering. This would make the dumping logic significantly
> > more complex though.
> > 
> > Seeing how most popular userspace apps, with the exception of eu-stack,
> > seem to work, we could also just leave it, and tell userspace apps to
> > fix it on their end.
> 
> Well, it does not seem eu-stack is that unpopular and we really try hard to
> avoid user visible regressions. So I think we should revert the change. Also
> the fact that the patch breaks ELF spec is an indication there may be other
> tools that would get confused by this and another reason for a revert...

Yeah, I think we need to make this a tunable. Updating the kernel breaks
elftools, which isn't some weird custom corner case. :P

So, while it took a few months, here is a report of breakage that I said
we'd need to watch for[1]. :)

Is anyone able to test this patch? And Brian will setting a sysctl be
okay for your use-case?


diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
index a43b78b4b646..35d5d86cff69 100644
--- a/Documentation/admin-guide/sysctl/kernel.rst
+++ b/Documentation/admin-guide/sysctl/kernel.rst
@@ -222,6 +222,17 @@ and ``core_uses_pid`` is set, then .PID will be appended to
 the filename.
 
 
+core_sort_vma
+=============
+
+The default coredump writes VMAs in address order. By setting
+``core_sort_vma`` to 1, VMAs will be written from smallest size
+to largest size. This is known to break at least elfutils, but
+can be handy when dealing with very large (and truncated)
+coredumps where the more useful debugging details are included
+in the smaller VMAs.
+
+
 ctrl-alt-del
 ============
 
diff --git a/fs/coredump.c b/fs/coredump.c
index 591700e1b2ce..4375c70144d0 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -63,6 +63,7 @@ static void free_vma_snapshot(struct coredump_params *cprm);
 
 static int core_uses_pid;
 static unsigned int core_pipe_limit;
+static unsigned int core_sort_vma;
 static char core_pattern[CORENAME_MAX_SIZE] = "core";
 static int core_name_size = CORENAME_MAX_SIZE;
 unsigned int core_file_note_size_limit = CORE_FILE_NOTE_SIZE_DEFAULT;
@@ -1026,6 +1027,15 @@ static const struct ctl_table coredump_sysctls[] = {
 		.extra1		= (unsigned int *)&core_file_note_size_min,
 		.extra2		= (unsigned int *)&core_file_note_size_max,
 	},
+	{
+		.procname	= "core_sort_vma",
+		.data		= &core_sort_vma,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= proc_douintvec_minmax,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_ONE,
+	},
 };
 
 static int __init init_fs_coredump_sysctls(void)
@@ -1256,8 +1266,9 @@ static bool dump_vma_snapshot(struct coredump_params *cprm)
 		cprm->vma_data_size += m->dump_size;
 	}
 
-	sort(cprm->vma_meta, cprm->vma_count, sizeof(*cprm->vma_meta),
-		cmp_vma_size, NULL);
+	if (core_sort_vma)
+		sort(cprm->vma_meta, cprm->vma_count, sizeof(*cprm->vma_meta),
+		     cmp_vma_size, NULL);
 
 	return true;
 }



-Kees

[1] https://lore.kernel.org/all/202408092104.FCE51021@keescook/

-- 
Kees Cook

