Return-Path: <linux-fsdevel+bounces-33743-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F5D79BE581
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Nov 2024 12:27:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73D711C218EE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Nov 2024 11:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A839A1DED47;
	Wed,  6 Nov 2024 11:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="SXshlaeV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9409F1DA63C
	for <linux-fsdevel@vger.kernel.org>; Wed,  6 Nov 2024 11:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730892462; cv=none; b=LrYD2yo8o5ptqS66QPyXTjTR7aIJnRlfytGwoXoPMsS02yTxAoaJLFqKIScdCR8D0tux+gfvl/hXNDrHgGSQHrS0DSqJxGBjRRk3Sod9T/F+ndbJOljhyBwjRM98nus31ssVsptIBlOsx4+x+0b78aDo3H0OttErm+JadKlV1DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730892462; c=relaxed/simple;
	bh=IWfiV9C2TNo1i32RgtTKpGKTtcqS+aKGASZSVO1pxko=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rqCLtYRYfylNT6oK9Bpey33hkC1J1TRkDFIZckjGWDsIb4cJXtTfCYoGisKPp89/GEjf+OKS8pQSt6+I6NxU9kb8fE06JkI20hxEQZZv65IWwTgZhVX8xZ82Obq+swVySWfiy8KInkCLH0V5ZWk4lvdExALKdmMa7+ojnCgHkd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=SXshlaeV; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1730892456; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=p7ZHQ5mkOZNXXRb8gvuUfgRIvKUxX4RcPlPJpX0awus=;
	b=SXshlaeVX48tx+L6kZjUztc/vDET2ZxCIOXyiG1j/PS7IJg6CxSGKH+wSsOVPDsAl925CD2BOLm44l2itfu6Pwq9nPN0VxnUsbTJOnYfS28m0DkdShiLymxktYJz3nDHcsYhPQ2exSbVrWh0dmLmSi4zOvQVOhqe3Mjd6ufqYRY=
Received: from 30.221.128.239(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0WIr70yP_1730892443 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 06 Nov 2024 19:27:35 +0800
Message-ID: <00ac127c-898f-464b-ad2e-ce974b5d350d@linux.alibaba.com>
Date: Wed, 6 Nov 2024 19:27:23 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ocfs2: fix UBSAN warning in ocfs2_verify_volume()
To: Dmitry Antipov <dmantipov@yandex.ru>, Mark Fasheh <mark@fasheh.com>,
 Joel Becker <jlbec@evilplan.org>, akpm <akpm@linux-foundation.org>
Cc: ocfs2-devel@lists.linux.dev, linux-fsdevel@vger.kernel.org,
 lvc-project@linuxtesting.org,
 syzbot+56f7cd1abe4b8e475180@syzkaller.appspotmail.com
References: <8a14ce14-8c91-4778-84d8-2eebec945325@linux.alibaba.com>
 <20241106092100.2661330-1-dmantipov@yandex.ru>
Content-Language: en-US
From: Joseph Qi <joseph.qi@linux.alibaba.com>
In-Reply-To: <20241106092100.2661330-1-dmantipov@yandex.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/6/24 5:21 PM, Dmitry Antipov wrote:
> Syzbot has reported the following splat triggered by UBSAN:
> 
> UBSAN: shift-out-of-bounds in fs/ocfs2/super.c:2336:10
> shift exponent 32768 is too large for 32-bit type 'int'
> CPU: 2 UID: 0 PID: 5255 Comm: repro Not tainted 6.12.0-rc4-syzkaller-00047-gc2ee9f594da8 #0
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-3.fc41 04/01/2014
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0x241/0x360
>  ? __pfx_dump_stack_lvl+0x10/0x10
>  ? __pfx__printk+0x10/0x10
>  ? __asan_memset+0x23/0x50
>  ? lockdep_init_map_type+0xa1/0x910
>  __ubsan_handle_shift_out_of_bounds+0x3c8/0x420
>  ocfs2_fill_super+0xf9c/0x5750
>  ? __pfx_ocfs2_fill_super+0x10/0x10
>  ? __pfx_validate_chain+0x10/0x10
>  ? __pfx_validate_chain+0x10/0x10
>  ? validate_chain+0x11e/0x5920
>  ? __lock_acquire+0x1384/0x2050
>  ? __pfx_validate_chain+0x10/0x10
>  ? string+0x26a/0x2b0
>  ? widen_string+0x3a/0x310
>  ? string+0x26a/0x2b0
>  ? bdev_name+0x2b1/0x3c0
>  ? pointer+0x703/0x1210
>  ? __pfx_pointer+0x10/0x10
>  ? __pfx_format_decode+0x10/0x10
>  ? __lock_acquire+0x1384/0x2050
>  ? vsnprintf+0x1ccd/0x1da0
>  ? snprintf+0xda/0x120
>  ? __pfx_lock_release+0x10/0x10
>  ? do_raw_spin_lock+0x14f/0x370
>  ? __pfx_snprintf+0x10/0x10
>  ? set_blocksize+0x1f9/0x360
>  ? sb_set_blocksize+0x98/0xf0
>  ? setup_bdev_super+0x4e6/0x5d0
>  mount_bdev+0x20c/0x2d0
>  ? __pfx_ocfs2_fill_super+0x10/0x10
>  ? __pfx_mount_bdev+0x10/0x10
>  ? vfs_parse_fs_string+0x190/0x230
>  ? __pfx_vfs_parse_fs_string+0x10/0x10
>  legacy_get_tree+0xf0/0x190
>  ? __pfx_ocfs2_mount+0x10/0x10
>  vfs_get_tree+0x92/0x2b0
>  do_new_mount+0x2be/0xb40
>  ? __pfx_do_new_mount+0x10/0x10
>  __se_sys_mount+0x2d6/0x3c0
>  ? __pfx___se_sys_mount+0x10/0x10
>  ? do_syscall_64+0x100/0x230
>  ? __x64_sys_mount+0x20/0xc0
>  do_syscall_64+0xf3/0x230
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f37cae96fda
> Code: 48 8b 0d 51 ce 0c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 1e ce 0c 00 f7 d8 64 89 01 48
> RSP: 002b:00007fff6c1aa228 EFLAGS: 00000206 ORIG_RAX: 00000000000000a5
> RAX: ffffffffffffffda RBX: 00007fff6c1aa240 RCX: 00007f37cae96fda
> RDX: 00000000200002c0 RSI: 0000000020000040 RDI: 00007fff6c1aa240
> RBP: 0000000000000004 R08: 00007fff6c1aa280 R09: 0000000000000000
> R10: 00000000000008c0 R11: 0000000000000206 R12: 00000000000008c0
> R13: 00007fff6c1aa280 R14: 0000000000000003 R15: 0000000001000000
>  </TASK>
> 
> For a really damaged superblock, the value of 'i_super.s_blocksize_bits'
> may exceed the maximum possible shift for an underlying 'int'. So add an
> extra check whether the aforementioned field represents the valid block
> size, which is 512 bytes, 1K, 2K, or 4K.
> 
> Reported-by: syzbot+56f7cd1abe4b8e475180@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=56f7cd1abe4b8e475180
> Fixes: ccd979bdbce9 ("[PATCH] OCFS2: The Second Oracle Cluster Filesystem")
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>

Cc: <stable@vger.kernel.org>
Reviewed-by: Joseph Qi <joseph.qi@linux.alibaba.com>

> ---
> v2: variable name and message nits as suggested by Joseph
> ---
>  fs/ocfs2/super.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/ocfs2/super.c b/fs/ocfs2/super.c
> index 3d404624bb96..c79b4291777f 100644
> --- a/fs/ocfs2/super.c
> +++ b/fs/ocfs2/super.c
> @@ -2319,6 +2319,7 @@ static int ocfs2_verify_volume(struct ocfs2_dinode *di,
>  			       struct ocfs2_blockcheck_stats *stats)
>  {
>  	int status = -EAGAIN;
> +	u32 blksz_bits;
>  
>  	if (memcmp(di->i_signature, OCFS2_SUPER_BLOCK_SIGNATURE,
>  		   strlen(OCFS2_SUPER_BLOCK_SIGNATURE)) == 0) {
> @@ -2333,11 +2334,15 @@ static int ocfs2_verify_volume(struct ocfs2_dinode *di,
>  				goto out;
>  		}
>  		status = -EINVAL;
> -		if ((1 << le32_to_cpu(di->id2.i_super.s_blocksize_bits)) != blksz) {
> +		/* Acceptable block sizes are 512 bytes, 1K, 2K and 4K. */
> +		blksz_bits = le32_to_cpu(di->id2.i_super.s_blocksize_bits);
> +		if (blksz_bits < 9 || blksz_bits > 12) {
>  			mlog(ML_ERROR, "found superblock with incorrect block "
> -			     "size: found %u, should be %u\n",
> -			     1 << le32_to_cpu(di->id2.i_super.s_blocksize_bits),
> -			       blksz);
> +			     "size bits: found %u, should be 9, 10, 11, or 12\n",
> +			     blksz_bits);
> +		} else if ((1 << le32_to_cpu(blksz_bits)) != blksz) {
> +			mlog(ML_ERROR, "found superblock with incorrect block "
> +			     "size: found %u, should be %u\n", 1 << blksz_bits, blksz);
>  		} else if (le16_to_cpu(di->id2.i_super.s_major_rev_level) !=
>  			   OCFS2_MAJOR_REV_LEVEL ||
>  			   le16_to_cpu(di->id2.i_super.s_minor_rev_level) !=


