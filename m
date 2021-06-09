Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B766C3A1508
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Jun 2021 15:01:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232366AbhFINDg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Jun 2021 09:03:36 -0400
Received: from alexa-out.qualcomm.com ([129.46.98.28]:22160 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231231AbhFINDg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Jun 2021 09:03:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1623243702; x=1654779702;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=VZlcXVEwmFnY01mwIlUZHeuNKUjGhrs1lJFRi8gIe4I=;
  b=CQZPlia7HKeWBKg/W7M298F5CBHAhQKFvDu0sGePVEJeK5Ch3zLXR2kp
   NVD3olzD4bF1NhB3+XvpEbZpdH9yI9MarDhv0Prjvcil4MxGEQ0PFKb9Q
   iTqAX6DpGKuquZaiRkjT1vGPnjhWts4ov6wz7TunVtfyAoadlrG5/54Kw
   8=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 09 Jun 2021 06:01:41 -0700
X-QCInternal: smtphost
Received: from nalasexr03e.na.qualcomm.com ([10.49.195.114])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 09 Jun 2021 06:01:40 -0700
Received: from [10.38.245.103] (10.80.80.8) by nalasexr03e.na.qualcomm.com
 (10.49.195.114) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 9 Jun
 2021 06:01:38 -0700
Subject: Re: [RFC PATCH 16/37] iov_iter_gap_alignment(): get rid of
 iterate_all_kinds()
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
CC:     <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        David Sterba <dsterba@suse.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Anton Altaparmakov <anton@tuxera.com>,
        David Howells <dhowells@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pavel Begunkov <asml.silence@gmail.com>
References: <YL0dCEVEiVL+NwG6@zeniv-ca.linux.org.uk>
 <20210606191051.1216821-1-viro@zeniv.linux.org.uk>
 <20210606191051.1216821-16-viro@zeniv.linux.org.uk>
From:   Qian Cai <quic_qiancai@quicinc.com>
Message-ID: <fc95d524-3e61-208d-52af-8ad0048fd76e@quicinc.com>
Date:   Wed, 9 Jun 2021 09:01:36 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210606191051.1216821-16-viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasexr03e.na.qualcomm.com (10.49.195.114)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 6/6/2021 3:10 PM, Al Viro wrote:
> For one thing, it's only used for iovec (and makes sense only for those).
> For another, here we don't care about iov_offset, since the beginning of
> the first segment and the end of the last one are ignored.  So it makes
> a lot more sense to just walk through the iovec array...
> 
> We need to deal with the case of truncated iov_iter, but unlike the
> situation with iov_iter_alignment() we don't care where the last
> segment ends - just which segment is the last one.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Al, today's linux-next started to give a boot warning. I looked at the code and noticed this series is new. Any thoughts?

[   70.060822][ T1286] WARNING: CPU: 26 PID: 1286 at lib/iov_iter.c:1320 iov_iter_gap_alignment+0x144/0x1a8
[   70.070323][ T1286] Modules linked in: loop cppc_cpufreq processor efivarfs ip_tables x_tables ext4 mbcache jbd2 dm_mod igb i2c_algo_bit nvme mlx5_core i2c_core nvme_core firmware_class
[   70.086922][ T1286] CPU: 26 PID: 1286 Comm: fwupd Tainted: G        W         5.13.0-rc5-next-20210609+ #19
[   70.096668][ T1286] Hardware name: MiTAC RAPTOR EV-883832-X3-0001/RAPTOR, BIOS 1.6 06/28/2020
[   70.105196][ T1286] pstate: 10000005 (nzcV daif -PAN -UAO -TCO BTYPE=--)
[   70.111902][ T1286] pc : iov_iter_gap_alignment+0x144/0x1a8
[   70.117485][ T1286] lr : blk_rq_map_user_iov+0xd00/0xff0
[   70.122808][ T1286] sp : ffff80002360f680
[   70.126821][ T1286] x29: ffff80002360f680 x28: 0000000000000000 x27: ffff00005dc8d620
[   70.134670][ T1286] x26: 0000000000001000 x25: ffff80002360f980 x24: 0000000000001000
[   70.142518][ T1286] x23: 0000000000000000 x22: 0000000000000007 x21: 1ffff000046c1f30
[   70.150365][ T1286] x20: 0000000000000fff x19: ffff80002360f980 x18: 0000000000000000
[   70.158214][ T1286] x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
[   70.166067][ T1286] x14: 0000000000000045 x13: 0000000000000000 x12: 000000000000f1f1
[   70.173915][ T1286] x11: ffff00093d700040 x10: 000000000000f2f2 x9 : 00000000f3000000
[   70.181763][ T1286] x8 : dfff800000000000 x7 : 00000000f3f3f3f3 x6 : 00000000f2000000
[   70.189610][ T1286] x5 : 0000000000000000 x4 : 0000000000000cc0 x3 : 1ffff000046c1f30
[   70.197459][ T1286] x2 : 1ffff000046c1f30 x1 : 0000000000000000 x0 : 0000000000000000
[   70.205307][ T1286] Call trace:
[   70.208453][ T1286]  iov_iter_gap_alignment+0x144/0x1a8
[   70.213693][ T1286]  blk_rq_map_user_iov+0xd00/0xff0
[   70.218668][ T1286]  blk_rq_map_user+0xf4/0x190
[   70.223209][ T1286]  nvme_submit_user_cmd.isra.0+0x150/0x4e0 [nvme_core]
[   70.229943][ T1286]  nvme_user_cmd.isra.0+0x298/0x3d0 [nvme_core]
[   70.236063][ T1286]  nvme_dev_ioctl+0x19c/0x3c8 [nvme_core]
[   70.241661][ T1286]  __arm64_sys_ioctl+0x114/0x180
[   70.246463][ T1286]  invoke_syscall.constprop.0+0xdc/0x1d8
[   70.251959][ T1286]  do_el0_svc+0x1f8/0x298
[   70.256151][ T1286]  el0_svc+0x20/0x30
[   70.259910][ T1286]  el0t_64_sync_handler+0xb0/0xb8
[   70.264796][ T1286]  el0t_64_sync+0x178/0x17c
[   70.269161][ T1286] irq event stamp: 254526
[   70.273348][ T1286] hardirqs last  enabled at (254525): [<ffff8000102cae90>] seqcount_lockdep_reader_access.constprop.0+0x138/0x190
[   70.285183][ T1286] hardirqs last disabled at (254526): [<ffff8000111371c0>] el1_dbg+0x28/0x80
[   70.293805][ T1286] softirqs last  enabled at (250668): [<ffff800010010a90>] _stext+0xa90/0x1114
[   70.302597][ T1286] softirqs last disabled at (250661): [<ffff800010114f64>] irq_exit+0x53c/0x610

> ---
>  lib/iov_iter.c | 25 ++++++++++++++-----------
>  1 file changed, 14 insertions(+), 11 deletions(-)
> 
> diff --git a/lib/iov_iter.c b/lib/iov_iter.c
> index bb7089cd0cf7..a6947301b9a0 100644
> --- a/lib/iov_iter.c
> +++ b/lib/iov_iter.c
> @@ -1409,23 +1409,26 @@ EXPORT_SYMBOL(iov_iter_alignment);
>  unsigned long iov_iter_gap_alignment(const struct iov_iter *i)
>  {
>  	unsigned long res = 0;
> +	unsigned long v = 0;
>  	size_t size = i->count;
> +	unsigned k;
>  
> -	if (unlikely(iov_iter_is_pipe(i) || iov_iter_is_discard(i))) {
> +	if (unlikely(iter_is_iovec(i))) {
>  		WARN_ON(1);
>  		return ~0U;
>  	}
>  
> -	iterate_all_kinds(i, size, v,
> -		(res |= (!res ? 0 : (unsigned long)v.iov_base) |
> -			(size != v.iov_len ? size : 0), 0),
> -		(res |= (!res ? 0 : (unsigned long)v.bv_offset) |
> -			(size != v.bv_len ? size : 0)),
> -		(res |= (!res ? 0 : (unsigned long)v.iov_base) |
> -			(size != v.iov_len ? size : 0)),
> -		(res |= (!res ? 0 : (unsigned long)v.bv_offset) |
> -			(size != v.bv_len ? size : 0))
> -		);
> +	for (k = 0; k < i->nr_segs; k++) {
> +		if (i->iov[k].iov_len) {
> +			unsigned long base = (unsigned long)i->iov[k].iov_base;
> +			if (v) // if not the first one
> +				res |= base | v; // this start | previous end
> +			v = base + i->iov[k].iov_len;
> +			if (size <= i->iov[k].iov_len)
> +				break;
> +			size -= i->iov[k].iov_len;
> +		}
> +	}
>  	return res;
>  }
>  EXPORT_SYMBOL(iov_iter_gap_alignment);
> 
