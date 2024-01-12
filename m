Return-Path: <linux-fsdevel+bounces-7876-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0052382C187
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jan 2024 15:22:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 284B21C2205A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jan 2024 14:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE7476DD10;
	Fri, 12 Jan 2024 14:22:35 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A96E6DD01;
	Fri, 12 Jan 2024 14:22:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D5A3C433C7;
	Fri, 12 Jan 2024 14:22:33 +0000 (UTC)
Date: Fri, 12 Jan 2024 09:22:30 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Christian Brauner <brauner@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, Al Viro
 <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] tracefs/eventfs: Use root and instance inodes as
 default ownership
Message-ID: <20240112092230.6107bc94@rorschach.local.home>
In-Reply-To: <20240112085344.30540d10@rorschach.local.home>
References: <20240105-wegstecken-sachkenntnis-6289842d6d01@brauner>
	<20240105095954.67de63c2@gandalf.local.home>
	<20240107-getrickst-angeeignet-049cea8cad13@brauner>
	<20240107132912.71b109d8@rorschach.local.home>
	<20240108-ortsrand-ziehen-4e9a9a58e708@brauner>
	<20240108102331.7de98cab@gandalf.local.home>
	<20240110-murren-extra-cd1241aae470@brauner>
	<20240110080746.50f7767d@gandalf.local.home>
	<20240111-unzahl-gefegt-433acb8a841d@brauner>
	<20240111165319.4bb2af76@gandalf.local.home>
	<20240112-normierung-knipsen-dccb7cac7efc@brauner>
	<20240112085344.30540d10@rorschach.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 12 Jan 2024 08:53:44 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> > // We managed to open the directory so we have permission to list
> > // directory entries in "xfs".
> > fd = open("/sys/kernel/tracing/events/xfs");
> > 
> > // Remove ownership so we can't open the directory anymore
> > chown("/sys/kernel/tracing/events/xfs", 0, 0);
> > 
> > // Or just remove exec bit for the group and restrict to owner
> > chmod("/sys/kernel/tracing/events/xfs", 700);
> > 
> > // Drop caches to force an eventfs_root_lookup() on everything
> > write("/proc/sys/vm/drop_caches", "3", 1);  
> 
> This requires opening the directory, then having it's permissions
> change, and then immediately dropping the caches.
> 
> > 
> > // Returns 0 even though directory has a lot of entries and we should be
> > // able to list them
> > getdents64(fd, ...);  
> 
> And do we care?

Hmm, maybe the issue you have is with the inconsistency of the action?

For this to fail, it would require the admin to do both change the
permission and to flush caches. If you don't flush the caches then the
task with the dir open can still read it regardless. If the dentries
were already created.

In that case I'm fine if we change the creation of the dentries to not
check the permission.

But for now, it's just a weird side effect that I don't really see how
it would affect any user's workflow.

-- Steve


