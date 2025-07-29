Return-Path: <linux-fsdevel+bounces-56238-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9962B14AB6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jul 2025 11:04:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F1403A71FD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jul 2025 09:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F392286418;
	Tue, 29 Jul 2025 09:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b="Wp0EXCSe";
	dkim=permerror (0-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b="2r9yRjG+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.parknet.co.jp (mail.parknet.co.jp [210.171.160.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36841229B15;
	Tue, 29 Jul 2025 09:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.171.160.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753779839; cv=none; b=XJqHxsKmMp47uknn3biPZL2klsCw8G4sul+WzBgRArsZpRgyk9Vu+Qa7bzwygLIZ3tLc547reCdlgXqX2+bDBiIH+V/Yd+MS4AePgc3AaPQIjorr2hd5wdlzrtzePQCbOCnZSIlivcwfMCNyEhyFkJrYUd13Ox97EbtSg8DNdoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753779839; c=relaxed/simple;
	bh=bYEujS6+ByQbNceyAHHs48JKpeTbafACnL/kIdDAT3U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nZnptXQaC4gsFB5S1th5b6eCfFMSaDrX7S8NS1X8/fE8WFwdTmJLO3OO3HFqQwF4fTp5EiN2/ayo6lTols4GEWKjpzdnrjDp2u7CXP0YS8FdGu5kvIZKi0lmvwh5FSaVUhu/K9tUKjs6G42dsUaik/NKeCcdd0bkm7gNzE2Gvss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.parknet.co.jp; spf=pass smtp.mailfrom=parknet.co.jp; dkim=pass (2048-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b=Wp0EXCSe; dkim=permerror (0-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b=2r9yRjG+; arc=none smtp.client-ip=210.171.160.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=parknet.co.jp
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
	by mail.parknet.co.jp (Postfix) with ESMTPSA id D38B82096798;
	Tue, 29 Jul 2025 18:03:53 +0900 (JST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114; t=1753779834;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/rdi4WC2YoL6asxzAu+4wAbVnqNhD1V174FOP2aO1tU=;
	b=Wp0EXCSebwE99xiIPl98a+nY+B28iqUFqfAGzDNg7aUl1mY2ohTKNORqTPLSbnzr8vEOKC
	DKbsiu3wouzSoKstz/RYjZY+Lgf11ap4FWoYaA9hphYlj4AU3gPe2j2/yCrh1pn6hjMbWm
	3el+2Aw2vfGD/RITEi1msS53+5p0ECeHDW9iwf7Vp+IwfUYNMWcKjlCwApN+ZIOHGXtGV+
	3nIKIx6aZfYKeENTkzesy8IEmR40Ry+m0fiN9JCEYBx4TYq6Ru0mvFIYnOyvQJuT1sZrhv
	Q/1H2SpPAX2182OWUNkEwJv/zPzZ0w95BTneipWdRKg7xnbdq3MYtNRDsNu7hQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114-ed25519; t=1753779834;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/rdi4WC2YoL6asxzAu+4wAbVnqNhD1V174FOP2aO1tU=;
	b=2r9yRjG+DzPd6CkIZk1YMJBE+Cf+1RdZuHc8p4H8dB8v1xUKfroUAGmnuImMwtqbtjjcuU
	o1/NayP4I4HJanCw==
Received: from devron.myhome.or.jp (foobar@devron.myhome.or.jp [192.168.0.3])
	by ibmpc.myhome.or.jp (8.18.1/8.18.1/Debian-6) with ESMTPS id 56T93q1e237911
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 29 Jul 2025 18:03:53 +0900
Received: from devron.myhome.or.jp (foobar@localhost [127.0.0.1])
	by devron.myhome.or.jp (8.18.1/8.18.1/Debian-6) with ESMTPS id 56T93qtY630999
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 29 Jul 2025 18:03:52 +0900
Received: (from hirofumi@localhost)
	by devron.myhome.or.jp (8.18.1/8.18.1/Submit) id 56T93pRP630998;
	Tue, 29 Jul 2025 18:03:51 +0900
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To: Edward Adam Davis <eadavis@qq.com>
Cc: linkinjeon@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, sj1557.seo@samsung.com,
        syzbot+d3c29ed63db6ddf8406e@syzkaller.appspotmail.com,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Subject: Re: [PATCH V2] fat: Prevent the race of read/write the FAT32 entry
In-Reply-To: <tencent_24D0464B099CEEC72EFD4C95A7FB86DB9206@qq.com>
References: <tencent_341B732549BA50BB6733349E621B0D4B7A08@qq.com>
	<tencent_24D0464B099CEEC72EFD4C95A7FB86DB9206@qq.com>
Date: Tue, 29 Jul 2025 18:03:51 +0900
Message-ID: <87tt2v4bd4.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Edward Adam Davis <eadavis@qq.com> writes:

> syzbot reports data-race in fat32_ent_get/fat32_ent_put. 
>
> 	CPU0(Task A)			CPU1(Task B)
> 	====				====
> 	vfs_write
> 	new_sync_write
> 	generic_file_write_iter
> 	fat_write_begin
> 	block_write_begin		vfs_statfs
> 	fat_get_block			statfs_by_dentry
> 	fat_add_cluster			fat_statfs
> 	fat_ent_write			fat_count_free_clusters
> 	fat32_ent_put			fat32_ent_get
>
> Task A's write operation on CPU0 and Task B's read operation on CPU1 occur
> simultaneously, generating an race condition.
>
> Add READ/WRITE_ONCE to solve the race condition that occurs when accessing
> FAT32 entry.

I mentioned about READ/WRITE_ONCE though, it was about possibility. Do
we really need to add those?  Can you clarify more?

> diff --git a/fs/fat/fatent.c b/fs/fat/fatent.c
> index 1db348f8f887..a9eecd090d91 100644
> --- a/fs/fat/fatent.c
> +++ b/fs/fat/fatent.c
> @@ -146,8 +146,8 @@ static int fat16_ent_get(struct fat_entry *fatent)
>  
>  static int fat32_ent_get(struct fat_entry *fatent)
>  {
> -	int next = le32_to_cpu(*fatent->u.ent32_p) & 0x0fffffff;
> -	WARN_ON((unsigned long)fatent->u.ent32_p & (4 - 1));
> +	int next = le32_to_cpu(READ_ONCE(*fatent->u.ent32_p)) & 0x0fffffff;
> +	WARN_ON((unsigned long)READ_ONCE(fatent->u.ent32_p) & (4 - 1));

Adding READ_ONCE() for pointer is broken.

>  	if (next >= BAD_FAT32)
>  		next = FAT_ENT_EOF;
>  	return next;
> @@ -187,8 +187,8 @@ static void fat16_ent_put(struct fat_entry *fatent, int new)
>  static void fat32_ent_put(struct fat_entry *fatent, int new)
>  {
>  	WARN_ON(new & 0xf0000000);
> -	new |= le32_to_cpu(*fatent->u.ent32_p) & ~0x0fffffff;
> -	*fatent->u.ent32_p = cpu_to_le32(new);
> +	new |= le32_to_cpu(READ_ONCE(*fatent->u.ent32_p)) & ~0x0fffffff;
> +	WRITE_ONCE(*fatent->u.ent32_p, cpu_to_le32(new));
>  	mark_buffer_dirty_inode(fatent->bhs[0], fatent->fat_inode);
>  }

Also READ_ONCE() is really required here?
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

