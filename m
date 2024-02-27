Return-Path: <linux-fsdevel+bounces-13024-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11D3886A3FA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 00:55:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E72B1C23596
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Feb 2024 23:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D20C5675D;
	Tue, 27 Feb 2024 23:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ORCMuF2n"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EBDC56479
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Feb 2024 23:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709078095; cv=none; b=bWKpf9x9NeakPiocjJVYs3VzhpbBXXJB9qjGfqvorI13SgKSSHxmfioLWOTZvXTnlGL6t9FDoNqqYx5WBSvvWsLOiLzFmO9zQxTSwe2VFPZa9eDY1/cS9FQ8tGwL/RjAOUMt86YUsyEsX/0RK7ilTEQI7C3OVtQNTxoztB5H28s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709078095; c=relaxed/simple;
	bh=tsXx+M0mrBJ3hPdsJ3u9SmrQpDA3WC0U+6Pu2p8FsFU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QJMLRHxaOBM51rktjf6BIePQK3zaIt5xTuH8X63xzaD4D5gkGK5RdObMXYqYB5nYMH8Vq1ujQrabQagWQdNgpOaPjBIJPOa64L18zuQUT5fGEufMx0IAHDA/nhghklV23H23DDgnAWMUWl7IgyhLB2drzZoCDsQfzDlxwCjI7tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ORCMuF2n; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709078093;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6ieIkgxO8ZJU/Zmuo85tnRkeB2F1kySozlBOjrq93nM=;
	b=ORCMuF2nfI9jXpJGXMbBKpIB+vjboYswUTmM8BMC6jqxATeWzAHqhj23hJMemvaBDwKQJC
	J6AEaSYZJBhUlDGPlL/YVAIvkWKcxgO5b40reWZghli7sW3yCwrdUjeEoLBQsfpNeAIBK2
	Vlo5ebieiVAzYmjAFDd3fagbRx5okvY=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-30-hxhsz1veOd2YT74xxrdCVQ-1; Tue, 27 Feb 2024 18:54:52 -0500
X-MC-Unique: hxhsz1veOd2YT74xxrdCVQ-1
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-36527824ab9so42106605ab.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Feb 2024 15:54:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709078090; x=1709682890;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6ieIkgxO8ZJU/Zmuo85tnRkeB2F1kySozlBOjrq93nM=;
        b=R2H9PwTZRFZwnQPIU7liqX0qbs4ce1UxYy7igncCclzuzP2059Jkx1wgPp2v1p84RO
         nNtHYpKxQdfTtnhLkg9Koj+a/QkpVl1O4Df7n5d50zHNtmBFFrvpMuY0QhwbBxat5grr
         Ca97VyG/EpIkWkIZxIuE643NVVdbAboE6jJugdOC8n1QlU/7A3O72KtYGvqq7TpKNQsf
         R1XYh1tXCp8+JcOk2O99gV02fg3aJ3w9DxoR6SCVLF96h4niCrox3Ph0Wdx4YTr0l4B/
         IqmG0Vche67s+eCeLOA+bW2kdInDs7qBN8xYH+6/Zafwy5RplTA97OsToudpCrWM6yVI
         TRhw==
X-Gm-Message-State: AOJu0YzpF/L56t4l5TZlV3ZY2Ea9RK5xxLfuISqzBvlB3soQOBZ9AakW
	2TMUEDQz8VwjP/Hu/7bgrr00ZDVRcYOYdFWsATJMfrMypUW86qf0fCk7bav3/PpSlPedoDYM6zV
	dg3m1AcGZNn2AQ/LxwlB71eagC2Lz8eJV7phy5vPrO6X9qefOqvN6nWTuBtsfJIlVpH6ou50=
X-Received: by 2002:a05:6e02:1d02:b0:365:1b67:205f with SMTP id i2-20020a056e021d0200b003651b67205fmr14621239ila.13.1709078090609;
        Tue, 27 Feb 2024 15:54:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGB8GbY1aZC4U+oy6RKvvWO8aViIFjQf7QCfnwIVSvQ7jaICbxvN/fuK4tlCF740/lyObEEbQ==
X-Received: by 2002:a05:6e02:1d02:b0:365:1b67:205f with SMTP id i2-20020a056e021d0200b003651b67205fmr14621224ila.13.1709078090304;
        Tue, 27 Feb 2024 15:54:50 -0800 (PST)
Received: from [10.0.0.71] (sandeen.net. [63.231.237.45])
        by smtp.gmail.com with ESMTPSA id o7-20020a92d4c7000000b0036576880ffcsm2430093ilm.85.2024.02.27.15.54.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Feb 2024 15:54:50 -0800 (PST)
Message-ID: <e06870bc-8dd1-481d-9552-a85e00d22fea@redhat.com>
Date: Tue, 27 Feb 2024 17:54:48 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] qnx4: convert qnx4 to use the new mount api
Content-Language: en-US
To: Christian Brauner <brauner@kernel.org>,
 Bill O'Donnell <bodonnel@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, al@alarsen.net
References: <20240226224628.710547-1-bodonnel@redhat.com>
 <20240227-infrage-imperativ-53428d23802c@brauner>
From: Eric Sandeen <sandeen@redhat.com>
In-Reply-To: <20240227-infrage-imperativ-53428d23802c@brauner>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/27/24 6:26 AM, Christian Brauner wrote:
> On Mon, Feb 26, 2024 at 04:46:28PM -0600, Bill O'Donnell wrote:
>> Convert the qnx4 filesystem to use the new mount API.
>>
>> Tested mount, umount, and remount using a qnx4 boot image.
>>
>> Signed-off-by: Bill O'Donnell <bodonnel@redhat.com>
>> ---
>>  fs/qnx4/inode.c | 49 +++++++++++++++++++++++++++++++------------------
>>  1 file changed, 31 insertions(+), 18 deletions(-)
>>
>> diff --git a/fs/qnx4/inode.c b/fs/qnx4/inode.c
>> index 6eb9bb369b57..c36fbe45a0e9 100644
>> --- a/fs/qnx4/inode.c
>> +++ b/fs/qnx4/inode.c
>> @@ -21,6 +21,7 @@
>>  #include <linux/buffer_head.h>
>>  #include <linux/writeback.h>
>>  #include <linux/statfs.h>
>> +#include <linux/fs_context.h>
>>  #include "qnx4.h"
>>  
>>  #define QNX4_VERSION  4
>> @@ -30,28 +31,33 @@ static const struct super_operations qnx4_sops;
>>  
>>  static struct inode *qnx4_alloc_inode(struct super_block *sb);
>>  static void qnx4_free_inode(struct inode *inode);
>> -static int qnx4_remount(struct super_block *sb, int *flags, char *data);
>>  static int qnx4_statfs(struct dentry *, struct kstatfs *);
>> +static int qnx4_get_tree(struct fs_context *fc);
>>  
>>  static const struct super_operations qnx4_sops =
>>  {
>>  	.alloc_inode	= qnx4_alloc_inode,
>>  	.free_inode	= qnx4_free_inode,
>>  	.statfs		= qnx4_statfs,
>> -	.remount_fs	= qnx4_remount,
>>  };
>>  
>> -static int qnx4_remount(struct super_block *sb, int *flags, char *data)
>> +static int qnx4_reconfigure(struct fs_context *fc)
>>  {
>> -	struct qnx4_sb_info *qs;
>> +	struct super_block *sb = fc->root->d_sb;
>> +	struct qnx4_sb_info *qs = sb->s_fs_info;
>>  
>>  	sync_filesystem(sb);
>>  	qs = qnx4_sb(sb);
>>  	qs->Version = QNX4_VERSION;
>> -	*flags |= SB_RDONLY;
>> +	fc->sb_flags |= SB_RDONLY;
> 
> This confused me to no end because setting SB_RDONLY here
> unconditionally would be wrong if it's not requested from userspace
> during a remount. Because in that case the vfs wouldn't know that an
> actual read-only remount request had been made which means that we don't
> take the necessary protection steps to transition from read-write to
> read-only. But qnx{4,6} are read-only so this is actually correct even
> though it seems pretty weird.

This seems to be how every only-read-only filesystem does it,
see erofs, romfs, squashfs, cramfs ...

-Eric


