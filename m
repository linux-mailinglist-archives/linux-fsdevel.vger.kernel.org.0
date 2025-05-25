Return-Path: <linux-fsdevel+bounces-49814-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3603AC3280
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 May 2025 07:36:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA24B3B9834
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 May 2025 05:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C883D1624EA;
	Sun, 25 May 2025 05:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D2dLAZP9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E653595A
	for <linux-fsdevel@vger.kernel.org>; Sun, 25 May 2025 05:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748151376; cv=none; b=IsAKuheEQ0j/eIAjDDt9CHntNXPiRyxUqnVyrJVkdzBTt87dLuWDFFM6iBWDbQSko29+92X8R3oN8Rsei6OINQbu5WvKdNnD04yubz/VXFmY9wW9kx2Y+ep2FrwAhVbgHMa1eS6lPHHiiMDsbuOpnSGU+rR7W/DmNFAuHk9QDOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748151376; c=relaxed/simple;
	bh=OirI05qR7ck3OFB26hMON/z/D2766a98LkF/Eb6ntbY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f5bKcN1O9GmjNt6wZwImPqp9Tn+TCUrLPR9p7rLud++FsVljVsQ38+6iKL1LJ5gqGlNxEf2KdmqYshE5p9t3w/ap9ldW2fdJXP//5TU9zZF3iQTYOPuVuImQ0znH40g5Zx6cAne1r2qhclwUjITrZ9bGNGIq60luQ+uS3+j2zW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D2dLAZP9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748151373;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jOSluJwjmK7UyYxNHzzRZbBEhS7j+uYg9GZHFodmdfE=;
	b=D2dLAZP9xly81Kc+Ofb4tdLYhRQJBzvnDEeI1NmRoX/xQ/A0xvTG7r+Ube2TsLeJGmyKDt
	R53pr2BtoxzfphpVyrqmJ9Je7vOwrgouX+A2UjmWJrt+RFLAXirzBk5FnYsInwR+bDlp7L
	nhDeGIBg1rUtzKqOvZ9lT+IHiDTWG1U=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-671-s5jGDmAUMBOpAxfEXBXqgQ-1; Sun, 25 May 2025 01:36:11 -0400
X-MC-Unique: s5jGDmAUMBOpAxfEXBXqgQ-1
X-Mimecast-MFC-AGG-ID: s5jGDmAUMBOpAxfEXBXqgQ_1748151371
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b26e33ae9d5so1397716a12.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 24 May 2025 22:36:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748151370; x=1748756170;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jOSluJwjmK7UyYxNHzzRZbBEhS7j+uYg9GZHFodmdfE=;
        b=svP5Rm2qTaL7thFyQCx5gRoSp4UZjHhFU1uUc6qAmJQJMvM6UD6UkCV16hhHwQgNcn
         hm9m+olrZeJWrUBb+uJECZkU8cxTpdzUoIoqa9Naczi7zOcONKi/OZsLRRa/fDjoF0/K
         DpCfdHt/vNM/bSW/QcAp0Z2cqn4wS6oaveAeNUgtFXZ8T2rXxJeXCSBxwmBiFCBYUwyQ
         UtSKkoicQnMRJOn3H5s7NxD/pgBfkc091YoK1ZSiAoYGc+PJiAuJUaf7pc5Yaw0R+lej
         e5f034WVbQi43YAJRO7hmvQHIrY46RmObEFzUkhkEb135PCHFbWerPJjR5ujaRm/+WnI
         QXAg==
X-Forwarded-Encrypted: i=1; AJvYcCXeO6guQZljjv032wlv2KOIl8KpwW9HvqRvEZBRgxJNnwCQir4S1n2S1nUFuguTrT70xQeuTXn/DJzBqjw5@vger.kernel.org
X-Gm-Message-State: AOJu0YwbeNyO/eddDk8u8ls/H07doruwOx6WurXoNqL368veYgKrE4I8
	7SczLLquiHZPLrlq7NEF/8TUUt/itFIFtL74xC/iPxCokKgBc1sSgOGhFkkXfkEMxJDaz7vdfkw
	oFooo92wGLa+RyMSQxsTrvAETrDWkdBhOonrZPW2j2a6UbXq2KgKc/JGueeQJBEG5DJM=
X-Gm-Gg: ASbGncvVDe/dO2HMyOpsfqXThiAs3yezWnE6I4/IBPGD5EnUcO+cLP7TckjtiYDyUE9
	wWh0xb2dv75Nk2BdRmrrRuetdWXE9YTzETiIrp8DuTAL8dqhUo4hNGhwniIuHGLjBLbVMDY0ZS+
	lZ9oleDqabaSTuOY/Mf17Z6Z2buDqD8JMKrK+GaUJTVz1T6vOIqfsRO+O1R7MisTNNWGWu/a4hU
	hP6uLuTN4mn3gmKye4Bg26pAR0Sq9g9sgJRYv2B/nGyjAKbCtoz1D5alO9lTVxKKGVTqHcpOffO
	SSZRcusuVRtwzeUYENasWQlFx/CkHQwuFwKEhpVlUDK5f3GtkQJI
X-Received: by 2002:a17:903:4b30:b0:231:d16c:7f55 with SMTP id d9443c01a7336-23414ea1745mr77248205ad.0.1748151370630;
        Sat, 24 May 2025 22:36:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHazE7+HZjBc2mKepljRO5it6kl6W1fcjqaVldXUGvejX6NK+ouRmImXIudkxA7rOXas01AdQ==
X-Received: by 2002:a17:903:4b30:b0:231:d16c:7f55 with SMTP id d9443c01a7336-23414ea1745mr77248005ad.0.1748151370252;
        Sat, 24 May 2025 22:36:10 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2344990db47sm2582475ad.62.2025.05.24.22.36.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 May 2025 22:36:09 -0700 (PDT)
Date: Sun, 25 May 2025 13:36:04 +0800
From: Zorro Lang <zlang@redhat.com>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Aleksa Sarai <cyphar@cyphar.com>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>, fstests@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] Tests for AT_HANDLE_CONNECTABLE
Message-ID: <20250525053604.k466kgfcumw2s2qx@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250509170033.538130-1-amir73il@gmail.com>
 <CAOQ4uxht8zPuVn11Xfj4B-t8RF2VuSiK3xDJiXkX8zQs7BuxxA@mail.gmail.com>
 <20250523145028.ydcei4rs5djf2qec@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <CAOQ4uxhxvHpfrd5BVKLFYr3D8=v4z1js-XkcODRhXtr0-tsecw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxhxvHpfrd5BVKLFYr3D8=v4z1js-XkcODRhXtr0-tsecw@mail.gmail.com>

On Fri, May 23, 2025 at 07:11:23PM +0200, Amir Goldstein wrote:
> On Fri, May 23, 2025 at 4:50 PM Zorro Lang <zlang@redhat.com> wrote:
> >
> > On Fri, May 23, 2025 at 04:20:29PM +0200, Amir Goldstein wrote:
> > > Hi Zorro.
> > >
> > > Ping.
> >
> > Sure Amir, don't worry, this patchset is already in my testing list.
> > I'll merge it after testing passed :)
> >
> 
> Thanks!

Hi Amir,

Although the v2 test passed on tmpfs, but it still fails on nfsv4.2, the
diff output as [1]. Is that as your expected? Anyway I think this's not
a big issue, so we still can merge this test case at first (as it's blocked
long time), then fix this failure later :)

Thanks,
Zorro


[1]
--- /dev/fd/63	2025-05-23 17:25:52.283688434 -0400
+++ generic/777.out.bad	2025-05-23 17:25:51.955645147 -0400
@@ -1,4 +1,34 @@
 QA output created by 777
 test_file_handles after cycle mount
+open_by_handle(/mnt/xfstests/test/nfs-client/file000000) returned 116 incorrectly on a linked file!
+open_by_handle(/mnt/xfstests/test/nfs-client/file000001) returned 116 incorrectly on a linked file!
+open_by_handle(/mnt/xfstests/test/nfs-client/file000002) returned 116 incorrectly on a linked file!
+open_by_handle(/mnt/xfstests/test/nfs-client/file000003) returned 116 incorrectly on a linked file!
+open_by_handle(/mnt/xfstests/test/nfs-client/file000004) returned 116 incorrectly on a linked file!
+open_by_handle(/mnt/xfstests/test/nfs-client/file000005) returned 116 incorrectly on a linked file!
+open_by_handle(/mnt/xfstests/test/nfs-client/file000006) returned 116 incorrectly on a linked file!
+open_by_handle(/mnt/xfstests/test/nfs-client/file000007) returned 116 incorrectly on a linked file!
+open_by_handle(/mnt/xfstests/test/nfs-client/file000008) returned 116 incorrectly on a linked file!
+open_by_handle(/mnt/xfstests/test/nfs-client/file000009) returned 116 incorrectly on a linked file!
 test_file_handles after rename parent
+open_by_handle(/mnt/xfstests/test/nfs-client/file000000) returned 116 incorrectly on a linked file!
+open_by_handle(/mnt/xfstests/test/nfs-client/file000001) returned 116 incorrectly on a linked file!
+open_by_handle(/mnt/xfstests/test/nfs-client/file000002) returned 116 incorrectly on a linked file!
+open_by_handle(/mnt/xfstests/test/nfs-client/file000003) returned 116 incorrectly on a linked file!
+open_by_handle(/mnt/xfstests/test/nfs-client/file000004) returned 116 incorrectly on a linked file!
+open_by_handle(/mnt/xfstests/test/nfs-client/file000005) returned 116 incorrectly on a linked file!
+open_by_handle(/mnt/xfstests/test/nfs-client/file000006) returned 116 incorrectly on a linked file!
+open_by_handle(/mnt/xfstests/test/nfs-client/file000007) returned 116 incorrectly on a linked file!
+open_by_handle(/mnt/xfstests/test/nfs-client/file000008) returned 116 incorrectly on a linked file!
+open_by_handle(/mnt/xfstests/test/nfs-client/file000009) returned 116 incorrectly on a linked file!
 test_file_handles after rename grandparent
+open_by_handle(/mnt/xfstests/test/nfs-client/file000000) returned 116 incorrectly on a linked file!
+open_by_handle(/mnt/xfstests/test/nfs-client/file000001) returned 116 incorrectly on a linked file!
+open_by_handle(/mnt/xfstests/test/nfs-client/file000002) returned 116 incorrectly on a linked file!
+open_by_handle(/mnt/xfstests/test/nfs-client/file000003) returned 116 incorrectly on a linked file!
+open_by_handle(/mnt/xfstests/test/nfs-client/file000004) returned 116 incorrectly on a linked file!
+open_by_handle(/mnt/xfstests/test/nfs-client/file000005) returned 116 incorrectly on a linked file!
+open_by_handle(/mnt/xfstests/test/nfs-client/file000006) returned 116 incorrectly on a linked file!
+open_by_handle(/mnt/xfstests/test/nfs-client/file000007) returned 116 incorrectly on a linked file!
+open_by_handle(/mnt/xfstests/test/nfs-client/file000008) returned 116 incorrectly on a linked file!
+open_by_handle(/mnt/xfstests/test/nfs-client/file000009) returned 116 incorrectly on a linked file!

> 


