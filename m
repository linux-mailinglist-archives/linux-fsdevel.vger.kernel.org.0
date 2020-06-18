Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 129C01FE461
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jun 2020 04:18:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731569AbgFRCR5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Jun 2020 22:17:57 -0400
Received: from [211.29.132.59] ([211.29.132.59]:46282 "EHLO
        mail108.syd.optusnet.com.au" rhost-flags-FAIL-FAIL-OK-OK)
        by vger.kernel.org with ESMTP id S1729811AbgFRBTv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Jun 2020 21:19:51 -0400
Received: from dread.disaster.area (unknown [49.180.124.177])
        by mail108.syd.optusnet.com.au (Postfix) with ESMTPS id BB9BD1AEAF2;
        Thu, 18 Jun 2020 11:19:20 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1jljCy-0001gV-Fl; Thu, 18 Jun 2020 11:19:12 +1000
Date:   Thu, 18 Jun 2020 11:19:12 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Satya Tangirala <satyat@google.com>
Cc:     linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org
Subject: Re: [PATCH 1/4] fs: introduce SB_INLINECRYPT
Message-ID: <20200618011912.GA2040@dread.disaster.area>
References: <20200617075732.213198-1-satyat@google.com>
 <20200617075732.213198-2-satyat@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200617075732.213198-2-satyat@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=W5xGqiek c=1 sm=1 tr=0
        a=k3aV/LVJup6ZGWgigO6cSA==:117 a=k3aV/LVJup6ZGWgigO6cSA==:17
        a=kj9zAlcOel0A:10 a=nTHF0DUjJn0A:10 a=1XWaLZrsAAAA:8 a=7-415B0cAAAA:8
        a=Yn2aIsqHhkDqJBDDX5kA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 17, 2020 at 07:57:29AM +0000, Satya Tangirala wrote:
> Introduce SB_INLINECRYPT, which is set by filesystems that wish to use
> blk-crypto for file content en/decryption. This flag maps to the
> '-o inlinecrypt' mount option which multiple filesystems will implement,
> and code in fs/crypto/ needs to be able to check for this mount option
> in a filesystem-independent way.
> 
> Signed-off-by: Satya Tangirala <satyat@google.com>
> ---
>  fs/proc_namespace.c | 1 +
>  include/linux/fs.h  | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/fs/proc_namespace.c b/fs/proc_namespace.c
> index 3059a9394c2d..e0ff1f6ac8f1 100644
> --- a/fs/proc_namespace.c
> +++ b/fs/proc_namespace.c
> @@ -49,6 +49,7 @@ static int show_sb_opts(struct seq_file *m, struct super_block *sb)
>  		{ SB_DIRSYNC, ",dirsync" },
>  		{ SB_MANDLOCK, ",mand" },
>  		{ SB_LAZYTIME, ",lazytime" },
> +		{ SB_INLINECRYPT, ",inlinecrypt" },
>  		{ 0, NULL }
>  	};
>  	const struct proc_fs_opts *fs_infop;

NACK.

SB_* flgs are for functionality enabled on the superblock, not for
indicating mount options that have been set by the user.

If the mount options are directly parsed by the filesystem option
parser (as is done later in this patchset), then the mount option
setting should be emitted by the filesystem's ->show_options
function, not a generic function.

The option string must match what the filesystem defines, not
require separate per-filesystem and VFS definitions of the same
option that people could potentially get wrong (*cough* i_version vs
iversion *cough*)....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
