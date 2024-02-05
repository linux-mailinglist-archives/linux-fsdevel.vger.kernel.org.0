Return-Path: <linux-fsdevel+bounces-10325-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E7B6849D3B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 15:41:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B1FB2811E9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 14:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D33242C1A7;
	Mon,  5 Feb 2024 14:40:53 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.parknet.co.jp (mail.parknet.co.jp [210.171.160.6])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 971DC2C19C
	for <linux-fsdevel@vger.kernel.org>; Mon,  5 Feb 2024 14:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.171.160.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707144053; cv=none; b=HqNDiShoLdCTXosfCJvf6keIF9CC5Ld+BXVNdFsQejXyIGdYIc14N6Os6FXenG7QBPzYQHFRXuyIX+PXXYucJcSkfie2wpT5+BiOIn83xlMbcGfS8sPWwCbelvq5XKjnTvIth60bg1pkmo6mgWpiJlxpFCJt3nGCVpntrqm5rdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707144053; c=relaxed/simple;
	bh=xBbyFhl5+uDb9e7ODfWD+eWlOqug7+b6OpwziCmrqM0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Z1xf7njx2NmtJtFf1UuZ7+OQhwSxLLC4Q7ftNaMmt/nWHw79hd6rkYqOyRrExntz43AgAMkduVzdHNNDG2wS+ie7Q8mLsUw9zvstPhp93fpeVoARkLy7oVPG+5G+PWYzv4mNVD8PkBV1Lr+r+0JF6tnJap74SZ6Dt12CS22r7BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mail.parknet.co.jp; spf=pass smtp.mailfrom=parknet.co.jp; arc=none smtp.client-ip=210.171.160.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mail.parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=parknet.co.jp
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
	by mail.parknet.co.jp (Postfix) with ESMTPSA id B2BBE2051588;
	Mon,  5 Feb 2024 23:35:19 +0900 (JST)
Received: from devron.myhome.or.jp (foobar@devron.myhome.or.jp [192.168.0.3])
	by ibmpc.myhome.or.jp (8.17.2/8.17.2/Debian-1) with ESMTPS id 415EZI4u180479
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 5 Feb 2024 23:35:19 +0900
Received: from devron.myhome.or.jp (foobar@localhost [127.0.0.1])
	by devron.myhome.or.jp (8.17.2/8.17.2/Debian-1) with ESMTPS id 415EZIes891671
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 5 Feb 2024 23:35:18 +0900
Received: (from hirofumi@localhost)
	by devron.myhome.or.jp (8.17.2/8.17.2/Submit) id 415EZIJE891670;
	Mon, 5 Feb 2024 23:35:18 +0900
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jan Kara <jack@suse.cz>, <linux-fsdevel@vger.kernel.org>,
        Amir
 Goldstein <amir73il@gmail.com>,
        syzbot+3ce5dea5b1539ff36769@syzkaller.appspotmail.com
Subject: Re: [PATCH] fat: Fix uninitialized field in nostale filehandles
In-Reply-To: <20240205122626.13701-1-jack@suse.cz> (Jan Kara's message of
	"Mon, 5 Feb 2024 13:26:26 +0100")
References: <20240205122626.13701-1-jack@suse.cz>
Date: Mon, 05 Feb 2024 23:35:18 +0900
Message-ID: <87ttmnf07t.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jan Kara <jack@suse.cz> writes:

> When fat_encode_fh_nostale() encodes file handle without a parent it
> stores only first 10 bytes of the file handle. However the length of the
> file handle must be a multiple of 4 so the file handle is actually 12
> bytes long and the last two bytes remain uninitialized. This is not
> great at we potentially leak uninitialized information with the handle
> to userspace. Properly initialize the full handle length.
>
> Reported-by: syzbot+3ce5dea5b1539ff36769@syzkaller.appspotmail.com
> Fixes: ea3983ace6b7 ("fat: restructure export_operations")
> Signed-off-by: Jan Kara <jack@suse.cz>

We can clean up more though, the fix itself looks good. Thanks.

Acked-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

> ---
>  fs/fat/nfs.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/fs/fat/nfs.c b/fs/fat/nfs.c
> index c52e63e10d35..509eea96a457 100644
> --- a/fs/fat/nfs.c
> +++ b/fs/fat/nfs.c
> @@ -130,6 +130,12 @@ fat_encode_fh_nostale(struct inode *inode, __u32 *fh, int *lenp,
>  		fid->parent_i_gen = parent->i_generation;
>  		type = FILEID_FAT_WITH_PARENT;
>  		*lenp = FAT_FID_SIZE_WITH_PARENT;
> +	} else {
> +		/*
> +		 * We need to initialize this field because the fh is actually
> +		 * 12 bytes long
> +		 */
> +		fid->parent_i_pos_hi = 0;
>  	}
>  
>  	return type;

-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

