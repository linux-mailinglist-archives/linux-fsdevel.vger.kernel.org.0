Return-Path: <linux-fsdevel+bounces-21687-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6B6890825F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Jun 2024 05:14:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA73C1C22016
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Jun 2024 03:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3B8F1836F1;
	Fri, 14 Jun 2024 03:14:42 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C5E4145323;
	Fri, 14 Jun 2024 03:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718334882; cv=none; b=K26At792lJRX3eItTkp3i8/9KeytqdVOVRuOgIDW18K2IMW+OoGKzOZqXN5IatF3XD8Az4vhnb2FlJQJ5Iz8U9HrDopchSp0aRFi4hKO2Ii8NgxduyUS6Z8N675U/H2+akid6b9xg93RJupc4eWwxmgVW9XnpV+B7tNL2a2Jyq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718334882; c=relaxed/simple;
	bh=0ixiiw8ol5u8bIR8LGd0cG5wPj2c29OVajtD5oCH+TM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=W/CKdGWVnWPX7/FMHv7GgDxiT4fUMnW1E/xE3w/DOKpOYnHZox913xMIN7vw9HG+7hBy85rHb1GdTnWi1UwFNsmtzUdy86ngjSC9UoLDvd8RefxLWTvgXN22TONw1dEkT+0SKm7l6a/BGuQYipSlC6KOkl0IQ3UYpWPpAEpv7XM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4W0ksC2MQbz4f3kk6;
	Fri, 14 Jun 2024 11:14:23 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id EB55D1A12BC;
	Fri, 14 Jun 2024 11:14:29 +0800 (CST)
Received: from [10.174.179.155] (unknown [10.174.179.155])
	by APP1 (Coremail) with SMTP id cCh0CgBHZQ6TtWtmy9O1PQ--.63899S3;
	Fri, 14 Jun 2024 11:14:29 +0800 (CST)
Message-ID: <ca71d3c4-0b87-8a1e-a442-236d91674a87@huaweicloud.com>
Date: Fri, 14 Jun 2024 11:14:27 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:104.0) Gecko/20100101
 Thunderbird/104.0
From: Li Lingfeng <lilingfeng@huaweicloud.com>
Subject: Re: [PATCH RFC 2/2] NFSv4: set sb_flags to second superblock
To: dhowells@redhat.com, marc.dionne@auristor.com, raven@themaw.net,
 gregkh@linuxfoundation.org, rafael@kernel.org, viro@zeniv.linux.org.uk,
 brauner@kernel.org, jack@suse.cz, miklos@szeredi.hu,
 trond.myklebust@hammerspace.com, anna@kernel.org, sfrench@samba.org,
 pc@manguebit.com, ronniesahlberg@gmail.com, sprasad@microsoft.com,
 tom@talpey.com, bharathsm@microsoft.com, djwong@kernel.org
Cc: linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
 autofs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
 samba-technical@lists.samba.org, yi.zhang@huawei.com, yangerkun@huawei.com,
 zhangxiaoxu5@huawei.com, lilingfeng3@huawei.com
References: <20240604112636.236517-1-lilingfeng@huaweicloud.com>
 <20240604112636.236517-3-lilingfeng@huaweicloud.com>
In-Reply-To: <20240604112636.236517-3-lilingfeng@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBHZQ6TtWtmy9O1PQ--.63899S3
X-Coremail-Antispam: 1UD129KBjvJXoWxGw4xAw1UGrWrtFykJw48tFb_yoW5urW8pF
	WfAryjkr4kJF17Wa18AFWrXa4Svw18ZF4UCF93ua4kAryUXrn7X3ZxKFWYgFy8ur4furyD
	XFWrtF13C3W7ZFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUtVWrXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
	Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a
	6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
	kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE
	14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf
	9x07jU-B_UUUUU=
X-CM-SenderInfo: polox0xjih0w46kxt4xhlfz01xgou0bp/

I think this may be a problem, but I'm unable to come up with a suitable 
solution. Would you mind providing some suggestions?

在 2024/6/4 19:26, Li Lingfeng 写道:
> From: Li Lingfeng <lilingfeng3@huawei.com>
>
> During the process of mounting an NFSv4 client, two superblocks will be
> created in sequence. The first superblock corresponds to the root
> directory exported by the server, and the second superblock corresponds to
> the directory that will be actually mounted. The first superblock will
> eventually be destroyed.
> The flag passed from user mode will only be passed to the first
> superblock, resulting in the actual used superblock not carrying the flag
> passed from user mode(fs_context_for_submount() will set sb_flags as 0).
>
> If the 'ro' parameter is used in two consecutive mount commands, only the
> first execution will create a new vfsmount, and the kernel will return
> EBUSY on the second execution. However, if a remount command with the 'ro'
> parameter is executed between the two mount commands, both mount commands
> will create new vfsmounts.
>
> The superblock generated after the first mount command does not have the
> 'ro' flag, and the read-only status of the file system is implemented by
> checking the read-only flag of the vfsmount. After executing the remount
> command, the 'ro' flag will be added to the superblock. When the second
> mount command is executed, the comparison result between the superblock
> with the 'ro' flag and the fs_context without the flag in the
> nfs_compare_mount_options() function will be different, resulting in the
> creation of a new vfsmount.
>
> This problem can be reproduced by performing the following operations:
> mount -t nfs -o ro,vers=4.0 192.168.240.250:/sdb /mnt/sdb
> mount -t nfs -o remount,ro,vers=4.0 192.168.240.250:/sdb /mnt/sdb
> mount -t nfs -o ro,vers=4.0 192.168.240.250:/sdb /mnt/sdb
> Two vfsmounts are generated:
> [root@localhost ~]# mount | grep nfs
> 192.168.240.250:/sdb on /mnt/sdb type nfs4 (ro,relatime,vers=4.0,
> rsize=1048576,wsize=1048576,namlen=255,hard,proto=tcp,timeo=600,retrans=2,
> sec=sys,clientaddr=192.168.240.251,local_lock=none,addr=192.168.240.250)
> 192.168.240.250:/sdb on /mnt/sdb type nfs4 (ro,relatime,vers=4.0,
> rsize=1048576,wsize=1048576,namlen=255,hard,proto=tcp,timeo=600,retrans=2,
> sec=sys,clientaddr=192.168.240.251,local_lock=none,addr=192.168.240.250)
>
> Fix this by setting sb_flags to second superblock.
>
> Signed-off-by: Li Lingfeng <lilingfeng3@huawei.com>
> ---
>   fs/nfs/namespace.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/nfs/namespace.c b/fs/nfs/namespace.c
> index 887aeacedebd..8b3d75af60d4 100644
> --- a/fs/nfs/namespace.c
> +++ b/fs/nfs/namespace.c
> @@ -158,7 +158,7 @@ struct vfsmount *nfs_d_automount(struct path *path, unsigned int sb_flags)
>   	/* Open a new filesystem context, transferring parameters from the
>   	 * parent superblock, including the network namespace.
>   	 */
> -	fc = fs_context_for_submount(path->mnt->mnt_sb->s_type, path->dentry, 0);
> +	fc = fs_context_for_submount(path->mnt->mnt_sb->s_type, path->dentry, sb_flags);
>   	if (IS_ERR(fc))
>   		return ERR_CAST(fc);
>   


