Return-Path: <linux-fsdevel+bounces-35215-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43BF09D294E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Nov 2024 16:13:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F22D11F215AA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Nov 2024 15:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B6811CEAA6;
	Tue, 19 Nov 2024 15:12:24 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.parknet.co.jp (mail.parknet.co.jp [210.171.160.6])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E5B21CF5D6;
	Tue, 19 Nov 2024 15:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.171.160.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732029144; cv=none; b=FXGzGw67KsEdVtlYfz4iuSUEP9Vybppm/DLZhs4q05tj5djVQMRYRwTVBJPMtjpRrDdGf8o+2QC4IJpwnGISxC8ziHtePQsOLRX1Oi2y6A111OP2l2wFtA0zW+JtdkZoog03oyqV3vUx2NKi4AMgsq1P+4WN2+ltQnpcVJwVfXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732029144; c=relaxed/simple;
	bh=qP+ppEYzE0hD2XGm6HUz8fTiAIY4I/lHu4wc0iQkMmI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lc4nkKrZoWaaFUuBTy4M4lbd16+shs6A8zN5gm3gmL9BvTxHb9Z9WyfmYS7zY6GbZLRGoXPLD2AfMCgoKU4LziUoPndQ9Rb+86/OOwlArUsugIgw3yq27gvUAMMG15Ob5XG14gCjIsdpi6YHRldGJ9HRIxMZEn2gsTH8fVB1Uto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mail.parknet.co.jp; spf=pass smtp.mailfrom=parknet.co.jp; arc=none smtp.client-ip=210.171.160.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mail.parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=parknet.co.jp
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
	by mail.parknet.co.jp (Postfix) with ESMTPSA id 1FBF9205158C;
	Wed, 20 Nov 2024 00:12:21 +0900 (JST)
Received: from devron.myhome.or.jp (foobar@devron.myhome.or.jp [192.168.0.3])
	by ibmpc.myhome.or.jp (8.18.1/8.18.1/Debian-6) with ESMTPS id 4AJFCJQP057124
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 20 Nov 2024 00:12:20 +0900
Received: from devron.myhome.or.jp (foobar@localhost [127.0.0.1])
	by devron.myhome.or.jp (8.18.1/8.18.1/Debian-6) with ESMTPS id 4AJFCJq1358096
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 20 Nov 2024 00:12:19 +0900
Received: (from hirofumi@localhost)
	by devron.myhome.or.jp (8.18.1/8.18.1/Submit) id 4AJFCJRd358095;
	Wed, 20 Nov 2024 00:12:19 +0900
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To: Jens Axboe <axboe@kernel.dk>
Cc: Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
        syzbot
 <syzbot+a5d8c609c02f508672cc@syzkaller.appspotmail.com>,
        linkinjeon@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, sj1557.seo@samsung.com,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [exfat?] possible deadlock in fat_count_free_clusters
In-Reply-To: <85d1c1bf-623e-4b93-9e60-453c0bfa7305@kernel.dk> (Jens Axboe's
	message of "Tue, 19 Nov 2024 07:55:50 -0700")
References: <67313d9e.050a0220.138bd5.0054.GAE@google.com>
	<8734jxsyuu.fsf@mail.parknet.co.jp>
	<CAFj5m9+FmQLLQkO7EUKnuuj+mpSUOY3EeUxSpXjJUvWtKfz26w@mail.gmail.com>
	<74141e63-d946-421a-be4e-4823944dd8c9@kernel.dk>
	<87wmgz8enq.fsf@mail.parknet.co.jp>
	<85d1c1bf-623e-4b93-9e60-453c0bfa7305@kernel.dk>
Date: Wed, 20 Nov 2024 00:12:19 +0900
Message-ID: <87mshv8dgs.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jens Axboe <axboe@kernel.dk> writes:

> FWIW, your outgoing mailer is mangling patches. I fixed it up manually,
> but probably something you want to get sorted. Download the raw one from
> lore and you can see what I mean.

Looks like at Ming Lei's reply, unicode "NARROW NO-BREAK SPACE" was
included in ">>>> On Tue, Nov 12, 2024 at 12:44?AM OGAWA Hirofumi" line?
So my mailer may be encoded as utf-8, not raw.

I'll take more care next time if possible. However, this mistake (utf-8
whitespace) may hard to prevent without machinery check somehow.

Thanks.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

