Return-Path: <linux-fsdevel+bounces-2924-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 737447ED763
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Nov 2023 23:39:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E0932811DA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Nov 2023 22:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22FAC43AA1;
	Wed, 15 Nov 2023 22:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="GJBh0WvP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6982F3C47C
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Nov 2023 22:39:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC0A6C433C7;
	Wed, 15 Nov 2023 22:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1700087958;
	bh=Bc5QhrR2eaIlIZFKVsskxjM9tSbZCZUwJZ8vcOKwJMw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GJBh0WvPEs1GIJ2oTeRVZ0zcB6JPHJN5iz2KbLkXe9Ap8LGrvwe08UX+Vv88g/kJa
	 3dQ4qxGh+0XhnPR0qBviHIEOs+AtQUSrFCkOb5k4I1syNBCwMb7LV1zvQt0F3mAFZM
	 w5WMXpCCdprdxFmFu1iB9wr8sKE4xlAPDFvLsecc=
Date: Wed, 15 Nov 2023 14:39:17 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Edward Adam Davis <eadavis@qq.com>
Cc: syzbot+604424eb051c2f696163@syzkaller.appspotmail.com,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 phillip@squashfs.org.uk, squashfs-devel@lists.sourceforge.net,
 syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] squashfs: fix oob in squashfs_readahead
Message-Id: <20231115143917.fdec61135bf3436fc15d2d2c@linux-foundation.org>
In-Reply-To: <tencent_35864B36740976B766CA3CC936A496AA3609@qq.com>
References: <000000000000b1fda20609ede0d1@google.com>
	<tencent_35864B36740976B766CA3CC936A496AA3609@qq.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 15 Nov 2023 12:05:35 +0800 Edward Adam Davis <eadavis@qq.com> wrote:

> Before performing a read ahead operation in squashfs_read_folio() and 
> squashfs_readahead(), check if i_size is not 0 before continuing.

I'll merge this for testing, pending Phillip's review.  One thing:

> --- a/fs/squashfs/block.c
> +++ b/fs/squashfs/block.c
> @@ -323,7 +323,7 @@ int squashfs_read_data(struct super_block *sb, u64 index, int length,
>  	}
>  	if (length < 0 || length > output->length ||
>  			(index + length) > msblk->bytes_used) {
> -		res = -EIO;
> +		res = length < 0 ? -EIO : -EFBIG;
>  		goto out;
>  	}

Seems a bit ugly to test `length' twice for the same thing.  How about

	if (length < 0) {
		res = -EIO;
		got out;
	}
	if (length > output->length || (index + length) > msblk->bytes_used) {
		res = -EFBIG;
		goto out;
	}

?


