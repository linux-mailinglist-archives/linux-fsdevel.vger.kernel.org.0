Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E0D236C9FE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Apr 2021 19:03:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235777AbhD0REf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Apr 2021 13:04:35 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:28454 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235647AbhD0REe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Apr 2021 13:04:34 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=eguan@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0UX.IUxB_1619543019;
Received: from localhost(mailfrom:eguan@linux.alibaba.com fp:SMTPD_---0UX.IUxB_1619543019)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 28 Apr 2021 01:03:39 +0800
Date:   Wed, 28 Apr 2021 01:03:39 +0800
From:   Eryu Guan <eguan@linux.alibaba.com>
To:     Kent Overstreet <kent.overstreet@gmail.com>
Cc:     fstests@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-bcachefs@vger.kernel.org
Subject: Re: [PATCH 3/3] Use --yes option to lvcreate
Message-ID: <20210427170339.GA9611@e18g06458.et15sqa>
References: <20210427164419.3729180-1-kent.overstreet@gmail.com>
 <20210427164419.3729180-4-kent.overstreet@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210427164419.3729180-4-kent.overstreet@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 27, 2021 at 12:44:19PM -0400, Kent Overstreet wrote:
> This fixes spurious test failures caused by broken pipe messages.
> 
> Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
> ---
>  tests/generic/081 | 2 +-
>  tests/generic/108 | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/generic/081 b/tests/generic/081
> index 5dff079852..26702007ab 100755
> --- a/tests/generic/081
> +++ b/tests/generic/081
> @@ -70,7 +70,7 @@ _scratch_mkfs_sized $((300 * 1024 * 1024)) >>$seqres.full 2>&1
>  $LVM_PROG vgcreate -f $vgname $SCRATCH_DEV >>$seqres.full 2>&1
>  # We use yes pipe instead of 'lvcreate --yes' because old version of lvm
>  # (like 2.02.95 in RHEL6) don't support --yes option
> -yes | $LVM_PROG lvcreate -L 256M -n $lvname $vgname >>$seqres.full 2>&1
> +$LVM_PROG lvcreate --yes -L 256M -n $lvname $vgname >>$seqres.full 2>&1

Please see above comments, we use yes pipe intentionally. I don't see
how this would result in broken pipe. Would you please provide more
details? And let's see if we could fix the broken pipe issue.

Thanks,
Eryu

>  # wait for lvcreation to fully complete
>  $UDEV_SETTLE_PROG >>$seqres.full 2>&1
>  
> diff --git a/tests/generic/108 b/tests/generic/108
> index 6fb194f43c..74945fdf3c 100755
> --- a/tests/generic/108
> +++ b/tests/generic/108
> @@ -56,7 +56,7 @@ $LVM_PROG pvcreate -f $SCSI_DEBUG_DEV $SCRATCH_DEV >>$seqres.full 2>&1
>  $LVM_PROG vgcreate -f $vgname $SCSI_DEBUG_DEV $SCRATCH_DEV >>$seqres.full 2>&1
>  # We use yes pipe instead of 'lvcreate --yes' because old version of lvm
>  # (like 2.02.95 in RHEL6) don't support --yes option
> -yes | $LVM_PROG lvcreate -i 2 -I 4m -L 275m -n $lvname $vgname \
> +$LVM_PROG lvcreate --yes -i 2 -I 4m -L 275m -n $lvname $vgname \
>  	>>$seqres.full 2>&1
>  # wait for lv creation to fully complete
>  $UDEV_SETTLE_PROG >>$seqres.full 2>&1
> -- 
> 2.31.1
