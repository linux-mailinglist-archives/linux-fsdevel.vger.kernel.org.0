Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2D553B6AFD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jun 2021 00:34:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235550AbhF1Wge (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Jun 2021 18:36:34 -0400
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:54729 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233442AbhF1Wgd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Jun 2021 18:36:33 -0400
Received: from dread.disaster.area (pa49-179-138-183.pa.nsw.optusnet.com.au [49.179.138.183])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 74A7F1044A55;
        Tue, 29 Jun 2021 08:34:04 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1lxzpL-000XQU-FI; Tue, 29 Jun 2021 08:34:03 +1000
Date:   Tue, 29 Jun 2021 08:34:03 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Wang Shilong <wangshilong1991@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH v2] fs: forbid invalid project ID
Message-ID: <20210628223403.GE664593@dread.disaster.area>
References: <20210628123801.3511-1-wangshilong1991@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210628123801.3511-1-wangshilong1991@gmail.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=YKPhNiOx c=1 sm=1 tr=0
        a=MnllW2CieawZLw/OcHE/Ng==:117 a=MnllW2CieawZLw/OcHE/Ng==:17
        a=kj9zAlcOel0A:10 a=r6YtysWOX24A:10 a=lB0dNpNiAAAA:8 a=7-415B0cAAAA:8
        a=7euumQaoeVMSjSfkz0cA:9 a=CjuIK1q_8ugA:10 a=c-ZiYqmG3AbHTdtsH08C:22
        a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 28, 2021 at 08:38:01AM -0400, Wang Shilong wrote:
> fileattr_set_prepare() should check if project ID
> is valid, otherwise dqget() will return NULL for
> such project ID quota.
> 
> Signed-off-by: Wang Shilong <wshilong@ddn.com>
> ---
> v1->v2: try to fix in the VFS
> ---
>  fs/ioctl.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/fs/ioctl.c b/fs/ioctl.c
> index 1e2204fa9963..5db5b218637b 100644
> --- a/fs/ioctl.c
> +++ b/fs/ioctl.c
> @@ -845,6 +845,9 @@ static int fileattr_set_prepare(struct inode *inode,
>  	if (fa->fsx_cowextsize == 0)
>  		fa->fsx_xflags &= ~FS_XFLAG_COWEXTSIZE;
>  
> +	if (!projid_valid(KPROJIDT_INIT(fa->fsx_projid)))
> +		return -EINVAL;

This needs to go further up in this function in the section where
project IDs passed into this function are validated. Projids are
only allowed to be changed when current_user_ns() == &init_user_ns,
so this needs to be associated with that verification context.

This check should also use make_kprojid(), please, not open code
KPROJIDT_INIT.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
