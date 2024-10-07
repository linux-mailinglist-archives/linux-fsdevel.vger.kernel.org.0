Return-Path: <linux-fsdevel+bounces-31255-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 315C8993836
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 22:28:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAE701F2217F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 20:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13D111DE885;
	Mon,  7 Oct 2024 20:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L4coOals"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD5C81DE4EE
	for <linux-fsdevel@vger.kernel.org>; Mon,  7 Oct 2024 20:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728332888; cv=none; b=YyhmjGFPV2imVZ95HZ+UnQ5HkJPLSnqozsl0QwQeck90o9vqPYaRhSExNQAjvuZPSEkoGkG1gp4W8lYdVPwYqBXOFDdw6RrhySdNFPo79ETVZ12j6Oqz8j4jGKqILtaPNiKcW6qFaPtezMj/331o/oZeuzxRhYp3qaYsX1j+QIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728332888; c=relaxed/simple;
	bh=lFATey50dXtS9PQrNILwMtPc5G4caMsohzKY0ft8MzE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=DHOJFt/9UbhSRp/02ZPrtOSXWFc3f8Vzk3ZPbEcGPy0/jYytnJBLlqVaRD4ntaWvVz+n4nlKPqZ+IUGmSGTG0sOAdnItFLQv/BBrLRfxlZBj2INS8dIqq0/X8iL6/TCBWAw2SeL5f7jfirrN+bMdRdG2w61R9x/xmHFSMBKK0kY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L4coOals; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728332885;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4B4glB5DjDUk8NiG4IJ2tdcRgXmWk2aBSKv4B5a3gzA=;
	b=L4coOals5FOPwCQd8nahFoQi0lG+N7owMiWPMbF5PM1UdxVrW8m3AeSP+zIRHP9uv30Cre
	LDq05NpnCJXii9GQj/GXW5G6wi/xhEZBKskIhsA2pCfdrZ7QKpPWrUeGz4YgnXFnZGiLoS
	FfZELtRUAAz8P7s8cBfhkzJX63rm+jw=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-75-pcmfxxLbOFKZ2rzS44o3OA-1; Mon, 07 Oct 2024 16:28:04 -0400
X-MC-Unique: pcmfxxLbOFKZ2rzS44o3OA-1
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-82aa467836eso869581539f.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 07 Oct 2024 13:28:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728332884; x=1728937684;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4B4glB5DjDUk8NiG4IJ2tdcRgXmWk2aBSKv4B5a3gzA=;
        b=aATkWAS9rQ6ZvdQNx/u1Clhzkisb8cUrLaEfiUuilaq9W547sIgeYIHl7bIYyrSnYJ
         nS9FEOXiVKvboQc5K+GKUGRbhdXQfrvWxW4BbrSrM9vrPMirnxa/iBmZxQMqiCUtkagS
         +PgIyMJj0vUnY7HI1pgFlbitogK1C0PNIW7uFYKUvoZjV+e99G7lgesLKhNwMqD1ZUvH
         l2Ow3iknU8B993SaSzic3klwZvHDUWt+bDaC8q0kDS5XIFZuNIf91ifDcnmNitIIZ6El
         2HgUPvj+hyBxie21/3Cm5oJ37qOjyHTeeIUyoWNneIDDaPthnb1hjGS68gDSLaiPJybj
         Sfbg==
X-Forwarded-Encrypted: i=1; AJvYcCUmQJ+Vpg1DbdS8YLW6ls16GfhpxqaM7BCHJzjdXzBOAYcJnX0SImXuedafYVtEzYHkYmBT/U9pBgTMkz1r@vger.kernel.org
X-Gm-Message-State: AOJu0Yxiu5+STvr8rBFu9B2aujQKFFNJINMub2vxCa6SaA+Msw7NiiJG
	j9cnZzXXkpVy67R4zCVOGEhZv9HStfXfIO1w1Xib0ADbnWQn1OEQvxHrvxM+dBRJs8sDIXtVAKf
	5WgCjSLcRB3+lGPywP+KfgovDezuCJIf8BiBKBKL0wmHPE9nqtbTb5Y3DT02+vIyz13eeNzmbtw
	==
X-Received: by 2002:a05:6e02:13a7:b0:3a0:8edc:d133 with SMTP id e9e14a558f8ab-3a375999ec7mr110742035ab.9.1728332883843;
        Mon, 07 Oct 2024 13:28:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEBmRzjnCd//uRIldrVNUB+pEl5NkIv81VplPeLwdKtLvMVnjarQoTS1mbY8SY7c7SWCayFCA==
X-Received: by 2002:a05:6e02:13a7:b0:3a0:8edc:d133 with SMTP id e9e14a558f8ab-3a375999ec7mr110741895ab.9.1728332883548;
        Mon, 07 Oct 2024 13:28:03 -0700 (PDT)
Received: from [10.0.0.71] (67-4-202-127.mpls.qwest.net. [67.4.202.127])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4db884f47edsm575830173.111.2024.10.07.13.28.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Oct 2024 13:28:02 -0700 (PDT)
Message-ID: <5c31f6f0-b68e-4ee6-80ae-e57799177f6c@redhat.com>
Date: Mon, 7 Oct 2024 15:28:01 -0500
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [hfs?] general protection fault in hfs_mdb_commit
To: syzbot <syzbot+5cfa9ffce7cc5744fe24@syzkaller.appspotmail.com>,
 brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <67011a15.050a0220.49194.04bc.GAE@google.com>
Content-Language: en-US
From: Eric Sandeen <sandeen@redhat.com>
In-Reply-To: <67011a15.050a0220.49194.04bc.GAE@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/5/24 5:51 AM, syzbot wrote:
> syzbot has bisected this issue to:
> 
> commit c87d1f1aa91c2e54234672c728e0e117d2bff756
> Author: Eric Sandeen <sandeen@redhat.com>
> Date:   Mon Sep 16 17:26:21 2024 +0000
> 
>     hfs: convert hfs to use the new mount api
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17b2bbd0580000
> start commit:   c02d24a5af66 Add linux-next specific files for 20241003
> git tree:       linux-next
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=1472bbd0580000
> console output: https://syzkaller.appspot.com/x/log.txt?x=1072bbd0580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=94f9caf16c0af42d
> dashboard link: https://syzkaller.appspot.com/bug?extid=5cfa9ffce7cc5744fe24
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=114be307980000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16bef527980000
> 
> Reported-by: syzbot+5cfa9ffce7cc5744fe24@syzkaller.appspotmail.com
> Fixes: c87d1f1aa91c ("hfs: convert hfs to use the new mount api")
> 
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection

#syz test 

diff --git a/fs/hfs/super.c b/fs/hfs/super.c
index ee314f3e39f8..3bee9b5dba5e 100644
--- a/fs/hfs/super.c
+++ b/fs/hfs/super.c
@@ -328,6 +328,7 @@ static int hfs_fill_super(struct super_block *sb, struct fs_context *fc)
 	spin_lock_init(&sbi->work_lock);
 	INIT_DELAYED_WORK(&sbi->mdb_work, flush_mdb);
 
+	sbi->sb = sb;
 	sb->s_op = &hfs_super_operations;
 	sb->s_xattr = hfs_xattr_handlers;
 	sb->s_flags |= SB_NODIRATIME;



