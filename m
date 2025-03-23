Return-Path: <linux-fsdevel+bounces-44848-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 456F6A6D123
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Mar 2025 22:03:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1E853B1917
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Mar 2025 21:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 170911A257D;
	Sun, 23 Mar 2025 21:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WhA2nw0c"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB2EE4D8C8
	for <linux-fsdevel@vger.kernel.org>; Sun, 23 Mar 2025 21:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742763826; cv=none; b=i7zT9wQbD5k8LPYZsfdEakhJ/jd8FuL3QY20qlFTG4NJf88Tf9WvrKqUdbyWhxajfhE1qBwPkpZQK49G3SrchJNFg1IjuR6cUelR2bH2hvuda/WawsEVfarCZpnI0ZA9Fm0YJng/bfhRrnI8GXtKOHhQ2BF6XGqPsDe//l67D2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742763826; c=relaxed/simple;
	bh=3JIOq5ochZh3ws1s6lkhbkBuciyTNdAoIUvUlBxhw4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UYTbCUHcae7CtEDbFAupjHZswMR37Zv03B2vqKehcZPY90thiFbS6OdYsTI9UaRCKY6iTEmMP7NiIe2IQAl3PNAri7Lx+WaBl1z2pk/NWeHeIB/9TQ2jPG6fTsSNIbY14r5aoaKLb0RDnMT2Nn/4irG7bUn8q81cp/+sx5KPiH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WhA2nw0c; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742763824;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5vpBGKmNly8SWNcuxVYwn8ZTG+u+mEvCdgvHyTuKsXM=;
	b=WhA2nw0coodqe47hmw/wk9TZGynTMbYwdhmUEf/04N3h/7qU1z1hQoQ3s17L8Ui454eLFn
	cxrVp6ZdjWOpLPQO7oWNFj42ogwXWNCQwfYm3D2k64Ku3zhPPfJmAaDlcNZRnQIxclpM01
	1PVZtYWfvLJmPHmYCGrBW1DHGhjSihg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-594-n1SnNG9dOo-weTbTFX0LEw-1; Sun,
 23 Mar 2025 17:03:34 -0400
X-MC-Unique: n1SnNG9dOo-weTbTFX0LEw-1
X-Mimecast-MFC-AGG-ID: n1SnNG9dOo-weTbTFX0LEw_1742763812
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BA2F01801A12;
	Sun, 23 Mar 2025 21:03:31 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.42])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id A60EE180A803;
	Sun, 23 Mar 2025 21:03:26 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sun, 23 Mar 2025 22:02:58 +0100 (CET)
Date: Sun, 23 Mar 2025 22:02:52 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: syzbot <syzbot+62262fdc0e01d99573fc@syzkaller.appspotmail.com>,
	brauner@kernel.org, dhowells@redhat.com, jack@suse.cz,
	jlayton@kernel.org, kprateek.nayak@amd.com,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	netfs@lists.linux.dev, swapnil.sapkal@amd.com,
	syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Subject: Re: [syzbot] [netfs?] INFO: task hung in netfs_unbuffered_write_iter
Message-ID: <20250323210251.GD14883@redhat.com>
References: <20250323184848.GB14883@redhat.com>
 <67e05e30.050a0220.21942d.0003.GAE@google.com>
 <20250323194701.GC14883@redhat.com>
 <CAGudoHHmvU54MU8dsZy422A4+ZzWTVs7LFevP7NpKzwZ1YOqgg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGudoHHmvU54MU8dsZy422A4+ZzWTVs7LFevP7NpKzwZ1YOqgg@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Prateek, Mateusz, thanks for your participation!

On 03/23, Mateusz Guzik wrote:
>
> On Sun, Mar 23, 2025 at 8:47 PM Oleg Nesterov <oleg@redhat.com> wrote:
> >
> > OK, as expected.
> >
> > Dear syzbot, thank you.
> >
> > So far I think this is another problem revealed by aaec5a95d59615523db03dd5
> > ("pipe_read: don't wake up the writer if the pipe is still full").
> >
> > I am going to forget about this report for now and return to it later, when
> > all the pending pipe-related changes in vfs.git are merged.
> >
>
> How do you ask syzbot for all stacks?

Heh, I don't know.

> The reproducer *does* use pipes, but it is unclear to me if they play
> any role here

please see the reproducer,

	https://syzkaller.appspot.com/x/repro.c?x=10d6a44c580000

  res = syscall(__NR_pipe2, /*pipefd=*/0x400000001900ul, /*flags=*/0ul);
  if (res != -1) {
    r[2] = *(uint32_t*)0x400000001900;
    r[3] = *(uint32_t*)0x400000001904;
  }

then

  res = syscall(__NR_dup, /*oldfd=*/r[3]);
  if (res != -1)
    r[4] = res;

so r[2] and r[4] are the read/write fd's.

then later

   memcpy((void*)0x400000000280, "trans=fd,", 9);
   ...
   memcpy((void*)0x400000000289, "rfdno", 5);
   ...
   sprintf((char*)0x40000000028f, "0x%016llx", (long long)r[2]);
   ...
   memcpy((void*)0x4000000002a2, "wfdno", 5);
   ...
   sprintf((char*)0x4000000002a8, "0x%016llx", (long long)r[4]);
   ...
   syscall(__NR_mount, /*src=*/0ul, /*dst=*/0x400000000000ul,
           /*type=*/0x400000000040ul, /*flags=*/0ul, /*opts=*/0x400000000280ul);

so this pipe is actually used as "trans=fd".

> -- and notably we don't know if there is someone stuck
> in pipe code, resulting in not waking up the reported thread.

Yes, I am not familiar with 9p or netfs, so I don't know either.

Oleg.


