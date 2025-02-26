Return-Path: <linux-fsdevel+bounces-42669-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 752CCA458A4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2025 09:42:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0DC887A1E4F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2025 08:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A415D1E1DEB;
	Wed, 26 Feb 2025 08:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CkF2Txtv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934D9258CEA
	for <linux-fsdevel@vger.kernel.org>; Wed, 26 Feb 2025 08:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740559337; cv=none; b=eCy5/Tj3uwXvL8teRAFhDkVGBzNE1MCsT0LaC+zMPueumIlF/kgjzX7L474SBYGEeYodMnWTVHarh95Fa52wjilCkx3z9fmCSY0UBbSr278teMWZoGbOFcFCwykthZjcmi0WR1pShPmgRNtGMKggSoeHoDIAUrX1gxGb68st0Lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740559337; c=relaxed/simple;
	bh=VySbfspT8q3IADkrqy5ww7YiUotekiO84ixAdu+cxEw=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=JmNwx4cR7oNY//0IaOsrybsknnHuAdyxiLur0XGYMtCtOVhU3FyPaebA1J7Eao6sB9RlW4Qiq50Y93IG+AaN8gkWoHZzDwlyetOxGxg+JCCBVFhoxulXo8dbsEZf2ZuKFc5dxjd5+ARV4gsOqyl3I1izru+JFpnryhJBrqy/awQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CkF2Txtv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740559334;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r3AeLd5JHJ0TZ4SyB2Oq2egGVMkfzRaqrDVyFKebSRY=;
	b=CkF2TxtvmXvBvoJsT9KMw7FXTiBwD6TdJZbI8xdTWJj0hJd1R8zjxIHYmsypfVyJ66CH4D
	Z8V0XdDJKLwnQOxFeZq1AnJFGgwji8ql4ZQyoTPojgNT4RmQvBR+vkE8LfTJuuNEaHzEbi
	yI1YHnZnsmhtrRqFZAcRYShE39U8VTo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-621-BQiK5_sCOgGsUYUV686Vng-1; Wed,
 26 Feb 2025 03:42:07 -0500
X-MC-Unique: BQiK5_sCOgGsUYUV686Vng-1
X-Mimecast-MFC-AGG-ID: BQiK5_sCOgGsUYUV686Vng_1740559317
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3D2201800877;
	Wed, 26 Feb 2025 08:41:57 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.9])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CF6C31800352;
	Wed, 26 Feb 2025 08:41:54 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <67b75198.050a0220.14d86d.02e2.GAE@google.com>
References: <67b75198.050a0220.14d86d.02e2.GAE@google.com>
To: syzbot <syzbot+c0dc46208750f063d0e0@syzkaller.appspotmail.com>
Cc: dhowells@redhat.com, Dominique Martinet <asmadeus@codewreck.org>,
    jlayton@kernel.org, linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org, netfs@lists.linux.dev,
    syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [netfs?] kernel BUG in folio_unlock (3)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2453210.1740559313.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 26 Feb 2025 08:41:53 +0000
Message-ID: <2453211.1740559313@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

syzbot <syzbot+c0dc46208750f063d0e0@syzkaller.appspotmail.com> wrote:

> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D141b4ba45800=
00

I'm not sure how this would even work.

  memcpy((void*)0x4000000001c0, "syz\000", 4);
  memcpy((void*)0x400000000480, "./file0\000", 8);
  memcpy((void*)0x4000000004c0, "9p\000", 3);
  memcpy((void*)0x400000000c00,
         "\x56\xc7\x8e\x3c\x73\x3d\x76\x69\x72\x74\x69\x6f\x2c\x6e\x6f\x65=
\x78"
         "\x74\x65\x6e\x64\x2c\x61\x63\x63\x81\x73\x73\x3d\x61\x6e\x79\x2c=
\x63"
         "\x61\x63\x68\x65\x3d\x66\x73\x63\x61\x63\x68\x65\x2c\x76\x65\x72=
\x73"
         "\x69\x6f\x6e\x3d\x39\x70\x32\x30\x30\x30\x2e\x75",
         63);
  syscall(__NR_mount, /*src=3D*/0x4000000001c0ul, /*dst=3D*/0x400000000480=
ul,
          /*type=3D*/0x4000000004c0ul, /*flags=3D*/0ul, /*opts=3D*/0x40000=
0000c00ul);

The options string is rubbish:

[pid  8084] mount("syz", "./file0", "9p", 0, "V\307\216<s=3Dvirtio,noexten=
d,acc\201ss=3Dany,cache=3Dfscache,version=3D9p2000.u") =3D -1 EINVAL (Inva=
lid argument)

David


