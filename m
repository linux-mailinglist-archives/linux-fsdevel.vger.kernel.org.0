Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 715AB1ECD70
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jun 2020 12:24:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbgFCKY2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Jun 2020 06:24:28 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:52805 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726890AbgFCKYZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Jun 2020 06:24:25 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200603102423euoutp01f8f56371287f0879328a99d3ec9a98eb~VAafAw7FK2691926919euoutp01S
        for <linux-fsdevel@vger.kernel.org>; Wed,  3 Jun 2020 10:24:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200603102423euoutp01f8f56371287f0879328a99d3ec9a98eb~VAafAw7FK2691926919euoutp01S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1591179863;
        bh=eDICBmLdfSReJ0IIZgbXl0S9aPELmh5Oc+cKhvrkRBQ=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=itpaM7U5QNM5cGBgSqU/gKdBa2wyNR9qSujdfoGuya2nSv8hhgZOUelUsfkVNwyXB
         SuuGRBFjR1fyt2l1Udj9G0BpgNKu1h2XfS1kedBXu8fIrVy5ybICBdQGmWOy34sMsE
         jD6VCm5KwZYs3a+sXGcsS/wGZyOt+xFdsywp9OU0=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200603102423eucas1p2627b59b24daa069df127ed05ee3e4ece~VAaeuqMXm0341003410eucas1p2E;
        Wed,  3 Jun 2020 10:24:23 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id FB.DD.61286.65A77DE5; Wed,  3
        Jun 2020 11:24:23 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200603102422eucas1p109e0d0140e8fc61dc3e57957f2ccf700~VAaeUAeQt0910609106eucas1p1I;
        Wed,  3 Jun 2020 10:24:22 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200603102422eusmtrp2ac3eef239fd6542e93825d5cf2456da4~VAaeTWRr-1914019140eusmtrp2e;
        Wed,  3 Jun 2020 10:24:22 +0000 (GMT)
X-AuditID: cbfec7f2-ef1ff7000001ef66-4c-5ed77a561226
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 42.81.07950.65A77DE5; Wed,  3
        Jun 2020 11:24:22 +0100 (BST)
Received: from [106.210.88.143] (unknown [106.210.88.143]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200603102421eusmtip1497219aabad721a8fb33142e00b9ba1e~VAadqRY3x3044930449eusmtip11;
        Wed,  3 Jun 2020 10:24:21 +0000 (GMT)
Subject: Re: [PATCHv5 1/1] ext4: mballoc: Use raw_cpu_ptr instead of
 this_cpu_ptr
To:     Ritesh Harjani <riteshh@linux.ibm.com>, linux-ext4@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.com>,
        tytso@mit.edu, linux-kernel@vger.kernel.org,
        adilger.kernel@dilger.ca, sfr@canb.auug.org.au,
        linux-next@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        syzbot+82f324bb69744c5f6969@syzkaller.appspotmail.com
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <ca794804-7d99-9837-2490-366a2eb97a94@samsung.com>
Date:   Wed, 3 Jun 2020 12:24:22 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
        Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200602134721.18211-1-riteshh@linux.ibm.com>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA01SfSxVYRzuvec491DXXjfNb5RyF5saUWlnY5aPctZayxLTuHXlDPOR3eMj
        xiZk3NnCWnJTvmaUpCGirGixO7orUjdruUZTdPPd0kLdeyj/Pc/v9zzv8z7vXpqQDpjZ0jEJ
        SZwyQREnoyzItt5lrUtI+nu52/RVxCwt5pPMZF0NYsrufKSYp10akhnqLKeY7qo8xEyNj4iZ
        R13DYmY6t5FkdK23CeZq4bL46Fb2ik5HsbktqezTYg3FFlU/R2z2wEuCbWodJtkygxO70Gx/
        mj5n4RXJxcWkcMoD3hcsoufrXosTi6wvd7+Zo7LQClYhcxrwYWifzDVTIQtaiusRlNTMiwSy
        iGCgdmSdLCBYXSwmVYg2Wdb0J41uKa5DoHpBCpoZBN/b34qMi+34DPwcWyCM2Bofh/tdA6aD
        CHxdBFMNnSYRhd1BZVBRRizB3tD2ZdRkIPFe0DZ0mDQ7cDgUjk4RgsYKNGUTpBGbY0+omhk3
        aQi8G9oN5YSAbWBkosIUBtggBm35EyQU9YdSfaVIwNthqq9VLOCdsNaxYchBMKZtFAukEMFQ
        9s11tyd81P6ijP0J7AxNnQeEsQ90/L6BhGexBJ3BSriEJZS0lRLCWAL5eVJB7QTqvgf/Yrtf
        DxJFSKbeVE29qY56Ux31/9xKRN5DNlwyHx/F8e4JXKorr4jnkxOiXC9eim9Gf/9Y/2rf/GO0
        NBjRgzCNZNskbu7v5FIzRQqfFt+DgCZk1hLfV/1yqSRSkZbOKS+dVybHcXwPsqNJmY3kUPXX
        cCmOUiRxsRyXyCk3tiLa3DYL2VZ987tW74BbQgPGB9mayAy3dr/G0QIvl+CwQ6F1/vLg7Fqd
        ql4zzVH6iA+ZzmWOZwtFmuV0X4dP0go+yCrnhN+tYkdt4P4+Ty8727sHWzx6M2ID9ZMegVvs
        93wOs1+JqT+lz1LuCjg2OevT0NSbF/Ls4Jy89GFB8I9Mr6DZI7Uyko9WuO8jlLziDzqBQ0tf
        AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLIsWRmVeSWpSXmKPExsVy+t/xu7phVdfjDH7+ULT4+qWDxeL58sWM
        FjPn3WGz2LP3JIvF5V1z2CwOLmxjtHj1+Ba7xda9V9ktXresZbG4sWUus0Vrz092B26Pxhs3
        2DxaNpd77Jl4ks1jwqIDjB5NZ44ye6zfcpXFY+ZbNY/Pm+QCOKL0bIryS0tSFTLyi0tslaIN
        LYz0DC0t9IxMLPUMjc1jrYxMlfTtbFJSczLLUov07RL0Mj4tv8BeMEGk4uDFj2wNjH8Fuhg5
        OCQETCT+P/DpYuTiEBJYyihx9dlNxi5GTqC4jMTJaQ2sELawxJ9rXWwQRW8ZJT797WcHSQgL
        BEv8ePiZGcQWEXCTWLP3DBNIEbPAFCaJGTu2sYNsEBKwkri0Xhqkhk3AUKLrLcggTg5eATuJ
        bS/ug/WyCKhInFu9kwnEFhWIlehe/IMdokZQ4uTMJywgNqeAtcTC94/BapgFzCTmbX7IDGHL
        S2x/OwfKFpe49WQ+0wRGoVlI2mchaZmFpGUWkpYFjCyrGEVSS4tz03OLjfSKE3OLS/PS9ZLz
        czcxAqN227GfW3Ywdr0LPsQowMGoxMNrYHgtTog1say4MvcQowQHs5IIr9PZ03FCvCmJlVWp
        RfnxRaU5qcWHGE2BnpvILCWanA9MKHkl8YamhuYWlobmxubGZhZK4rwdAgdjhATSE0tSs1NT
        C1KLYPqYODilGhjn/rHcF/jTl8FX0p8ruPBhkGSSrcXEz88t87lTlvbtrmRbwtmZI6l5xmvv
        /8TY0A29isxnvklLmxVL3d98UpeLJ3nL91sqGkV16uGCa5a+2Ky075Hl6YexMic19RO/8hyb
        6i7IXr9r1U67cJH0C+un1KRniM+yfZzx+r+BZOv2i7d/yYRvPqDEUpyRaKjFXFScCAA94j+O
        8AIAAA==
X-CMS-MailID: 20200603102422eucas1p109e0d0140e8fc61dc3e57957f2ccf700
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200603102422eucas1p109e0d0140e8fc61dc3e57957f2ccf700
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200603102422eucas1p109e0d0140e8fc61dc3e57957f2ccf700
References: <20200602134721.18211-1-riteshh@linux.ibm.com>
        <CGME20200603102422eucas1p109e0d0140e8fc61dc3e57957f2ccf700@eucas1p1.samsung.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Ritesh,

On 02.06.2020 15:47, Ritesh Harjani wrote:
> It doesn't really matter in ext4_mb_new_blocks() about whether the code
> is rescheduled on any other cpu due to preemption. Because we care
> about discard_pa_seq only when the block allocation fails and then too
> we add the seq counter of all the cpus against the initial sampled one
> to check if anyone has freed any blocks while we were doing allocation.
>
> So just use raw_cpu_ptr instead of this_cpu_ptr to avoid this BUG.
>
> BUG: using smp_processor_id() in preemptible [00000000] code: syz-fuzzer/6927
> caller is ext4_mb_new_blocks+0xa4d/0x3b70 fs/ext4/mballoc.c:4711
> CPU: 1 PID: 6927 Comm: syz-fuzzer Not tainted 5.7.0-next-20200602-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> Call Trace:
>   __dump_stack lib/dump_stack.c:77 [inline]
>   dump_stack+0x18f/0x20d lib/dump_stack.c:118
>   check_preemption_disabled+0x20d/0x220 lib/smp_processor_id.c:48
>   ext4_mb_new_blocks+0xa4d/0x3b70 fs/ext4/mballoc.c:4711
>   ext4_ext_map_blocks+0x201b/0x33e0 fs/ext4/extents.c:4244
>   ext4_map_blocks+0x4cb/0x1640 fs/ext4/inode.c:626
>   ext4_getblk+0xad/0x520 fs/ext4/inode.c:833
>   ext4_bread+0x7c/0x380 fs/ext4/inode.c:883
>   ext4_append+0x153/0x360 fs/ext4/namei.c:67
>   ext4_init_new_dir fs/ext4/namei.c:2757 [inline]
>   ext4_mkdir+0x5e0/0xdf0 fs/ext4/namei.c:2802
>   vfs_mkdir+0x419/0x690 fs/namei.c:3632
>   do_mkdirat+0x21e/0x280 fs/namei.c:3655
>   do_syscall_64+0x60/0xe0 arch/x86/entry/common.c:359
>   entry_SYSCALL_64_after_hwframe+0x44/0xa9
>
> Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
> Reported-by: syzbot+82f324bb69744c5f6969@syzkaller.appspotmail.com

This fixes the warning observed on various Samsung Exynos SoC based 
boards with linux-next 20200602.

Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

> ---
>   fs/ext4/mballoc.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index a9083113a8c0..b79b32dbe3ea 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -4708,7 +4708,7 @@ ext4_fsblk_t ext4_mb_new_blocks(handle_t *handle,
>   	}
>   
>   	ac->ac_op = EXT4_MB_HISTORY_PREALLOC;
> -	seq = *this_cpu_ptr(&discard_pa_seq);
> +	seq = *raw_cpu_ptr(&discard_pa_seq);
>   	if (!ext4_mb_use_preallocated(ac)) {
>   		ac->ac_op = EXT4_MB_HISTORY_ALLOC;
>   		ext4_mb_normalize_request(ac, ar);

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

