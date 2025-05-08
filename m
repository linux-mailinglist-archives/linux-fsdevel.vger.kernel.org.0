Return-Path: <linux-fsdevel+bounces-48484-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 093ACAAFC4A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 May 2025 16:03:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DA164A467F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 May 2025 14:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 923E622D9F1;
	Thu,  8 May 2025 14:02:50 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A2D24B1E5C;
	Thu,  8 May 2025 14:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746712970; cv=none; b=etoCNvoJ4TBkLnT/GI+Xi9Bp3Nx/gsjpRcpRGM8RO0Jq5Cu2222gBbJv4x65YfiIoTKUl8YDKjQGG5gn/d7RafB9bvuf/AuXK7/QC6toRWzsvJUDg5n9s26OkKGl7/fnKpWlQ/A9YXFuNv92/pQUJqK6Y8zdygzmR5qWxez0lE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746712970; c=relaxed/simple;
	bh=0apuCMA1Sidjb3J3yeNoUIRz4VC95W7lpWJMIzhlHi8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vwy3/YL6iwAhLozekyL4qAbHvdLl7Mahd5tW4hv5txIZ1G7FIX11QdSq+XMIREzz8J5Lfo6SCHDgNLrLxb8RvtYIegi3CMQq7tQ9p8eBFIol/eltVjyE7H720tgqzcmPBCAS+P0uDD51HmvwfGw+JkVB07Lj+oCAhqpo3rD+tLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83C04C4CEE7;
	Thu,  8 May 2025 14:02:46 +0000 (UTC)
Date: Thu, 8 May 2025 10:02:58 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Bhupesh Sharma <bhsharma@igalia.com>
Cc: Petr Mladek <pmladek@suse.com>, akpm@linux-foundation.org,
 kernel-dev@igalia.com, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-perf-users@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, oliver.sang@intel.com, lkp@intel.com,
 laoar.shao@gmail.com, mathieu.desnoyers@efficios.com,
 arnaldo.melo@gmail.com, alexei.starovoitov@gmail.com,
 andrii.nakryiko@gmail.com, mirq-linux@rere.qmqm.pl, peterz@infradead.org,
 willy@infradead.org, david@redhat.com, viro@zeniv.linux.org.uk,
 keescook@chromium.org, ebiederm@xmission.com, brauner@kernel.org,
 jack@suse.cz, mingo@redhat.com, juri.lelli@redhat.com, bsegall@google.com,
 mgorman@suse.de, vschneid@redhat.com
Subject: Re: [PATCH v3 2/3] treewide: Switch memcpy() users of 'task->comm'
 to a more safer implementation
Message-ID: <20250508100258.5ea70831@gandalf.local.home>
In-Reply-To: <3fd1dd03-ce1c-37e5-98aa-a91ab5d210b3@igalia.com>
References: <20250507110444.963779-1-bhupesh@igalia.com>
	<20250507110444.963779-3-bhupesh@igalia.com>
	<aBtSK5dFmtFXUaOE@pathway.suse.cz>
	<4af48ad5-1aa7-46d0-bfca-7779294e355c@igalia.com>
	<3fd1dd03-ce1c-37e5-98aa-a91ab5d210b3@igalia.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 8 May 2025 13:52:01 +0530
Bhupesh Sharma <bhsharma@igalia.com> wrote:

> > [1].=20
> > https://lore.kernel.org/linux-trace-kernel/20250507133458.51bafd95@gand=
alf.local.home/
> > =20
>=20
> Sorry, pressed the send button too quickly :D
>=20
> I instead meant - "I plan to=C2=A0 rebase my v4 on top of Steven's RFC, w=
hich=20
> might mean that this patch would no longer need to address the trace=20
> events, but would still need to handle other places where tsk->comm=20
> directly in memcpy() and replace it with 'get_task_comm()' instead".

Note I didn't switch all the events, just most of the sched events.

This may affect user space that parses the raw events and may expect a hard
coded string instead of a dynamic one (as the sched_switch and sched_waking
events do).

We will need to investigate before we make these changes, which is why I
posted it as a RFC.

-- Steve

