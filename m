Return-Path: <linux-fsdevel+bounces-44837-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1CEBA6D09F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Mar 2025 19:50:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71698189267C
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Mar 2025 18:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13AAC19343B;
	Sun, 23 Mar 2025 18:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VCKrD1Py"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB481153800
	for <linux-fsdevel@vger.kernel.org>; Sun, 23 Mar 2025 18:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742755776; cv=none; b=PAJM1fVfpDSqUgW/JEq4484HPkpw/7DmY+YQydUO9YBWLYVQZJosxgOcogYx09402YW1SkRnua0Nllh8fOr1fyfpbePfAAQAUW6CI3wfA1uHx87DQsiVUBJQPSzedIF63l3hGzpYRbXlqXVddnlcrWRt7UlOGR6OEF3+5+HzY/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742755776; c=relaxed/simple;
	bh=Xg/yAE8d1727DDcBKSKkAadprr+hLHpZVwFQe7vn4+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k6QTcmUohQQB8s7zFTmHlC3nQrC27EAUBr8iKyuHx7DULv0ifuYWUpl69bgbSLf0ByGKxblVDqoIdpH5QpgPEbHsbsOTFubQY7jGq+3TQchkCqA3d7+HcgulVPNwQN7rmAxb1eZ3SNOLBeuhJLSS4YUMQ1W3GDL854s2/fCH8I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VCKrD1Py; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742755773;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=W9siAmY7I3iNk4H1uXzumfBakZmJG7mr6DM1yqiK9TM=;
	b=VCKrD1PymV52EWizb+6CRWAlpeyTyYQI7V028Dl/DJlvg7o/Chbrt8zchhnDprDoXr1b+S
	X1k//NE35hCxnn7sdggQoO+W1sNLDN81jPIkumY82XCPCokl+kPCmOY2DHZ0a9LiJTgXAw
	razPa61y8PxjPwygQ1RhyEWb+Ra8xT4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-691-84n91NZGOPeL27kRD4w-gg-1; Sun,
 23 Mar 2025 14:49:30 -0400
X-MC-Unique: 84n91NZGOPeL27kRD4w-gg-1
X-Mimecast-MFC-AGG-ID: 84n91NZGOPeL27kRD4w-gg_1742755768
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2E719180049D;
	Sun, 23 Mar 2025 18:49:28 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.42])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 38C8F180A801;
	Sun, 23 Mar 2025 18:49:22 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sun, 23 Mar 2025 19:48:55 +0100 (CET)
Date: Sun, 23 Mar 2025 19:48:49 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: syzbot <syzbot+62262fdc0e01d99573fc@syzkaller.appspotmail.com>
Cc: brauner@kernel.org, dhowells@redhat.com, jack@suse.cz,
	jlayton@kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, netfs@lists.linux.dev,
	syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	"Sapkal, Swapnil" <swapnil.sapkal@amd.com>,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: Re: [syzbot] [netfs?] INFO: task hung in netfs_unbuffered_write_iter
Message-ID: <20250323184848.GB14883@redhat.com>
References: <67dedd2f.050a0220.31a16b.003f.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67dedd2f.050a0220.31a16b.003f.GAE@google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On 03/22, syzbot wrote:
>
> HEAD commit:    fc444ada1310 Merge tag 'soc-fixes-6.14-2' of git://git.ker..
> git tree:       upstream
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=1397319b980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=2e330e9768b5b8ff
> dashboard link: https://syzkaller.appspot.com/bug?extid=62262fdc0e01d99573fc
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1057319b980000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10d6a44c580000
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/924e6055daef/disk-fc444ada.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/0cd40093a53e/vmlinux-fc444ada.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/7370bbe4e1b8/bzImage-fc444ada.xz
>
> The issue was bisected to:
>
> commit aaec5a95d59615523db03dd53c2052f0a87beea7
> Author: Oleg Nesterov <oleg@redhat.com>
> Date:   Thu Jan 2 14:07:15 2025 +0000
>
>     pipe_read: don't wake up the writer if the pipe is still full

OMG :/

Just to ensure it does not help,

#syz test: upstream aaec5a95d59615523db03dd53c2052f0a87beea7

diff --git a/fs/pipe.c b/fs/pipe.c
index 82fede0f2111..7e36f54d21a5 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -417,8 +417,8 @@ static inline int is_packetized(struct file *file)
 /* Done while waiting without holding the pipe lock - thus the READ_ONCE() */
 static inline bool pipe_writable(const struct pipe_inode_info *pipe)
 {
-	unsigned int head = READ_ONCE(pipe->head);
 	unsigned int tail = READ_ONCE(pipe->tail);
+	unsigned int head = READ_ONCE(pipe->head);
 	unsigned int max_usage = READ_ONCE(pipe->max_usage);
 
 	return !pipe_full(head, tail, max_usage) ||


