Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E7962CC192
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Dec 2020 17:04:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730623AbgLBQBe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Dec 2020 11:01:34 -0500
Received: from mga17.intel.com ([192.55.52.151]:42669 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726178AbgLBQBe (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Dec 2020 11:01:34 -0500
IronPort-SDR: vTQ49dhM8QBd0+4nYadcCOvoTfZw705rWHm0qw0rm50FiH9wI14DM2hvQCAkSRTZDARA2k3ter
 hLH5oIOwMlSQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9823"; a="152864217"
X-IronPort-AV: E=Sophos;i="5.78,387,1599548400"; 
   d="scan'208";a="152864217"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2020 08:00:50 -0800
IronPort-SDR: z1IqvhDZPFYY4z4SR+s5gX3XaQ3NMgT9GM0Mla2pqeN/yCqk8tUFbBLI/da0PDe15bIDT0ioBg
 KB4Vk+2ypybA==
X-IronPort-AV: E=Sophos;i="5.78,387,1599548400"; 
   d="scan'208";a="539744114"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2020 08:00:50 -0800
Date:   Wed, 2 Dec 2020 08:00:49 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Eric Sandeen <sandeen@redhat.com>
Cc:     torvalds@linux-foundation.org,
        Miklos Szeredi <mszeredi@redhat.com>,
        David Howells <dhowells@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-man@vger.kernel.org,
        linux-kernel@vger.kernel.org, xfs <linux-xfs@vger.kernel.org>,
        linux-ext4@vger.kernel.org, Xiaoli Feng <xifeng@redhat.com>
Subject: Re: [PATCH V2] uapi: fix statx attribute value overlap for DAX &
 MOUNT_ROOT
Message-ID: <20201202160049.GD1447340@iweiny-DESK2.sc.intel.com>
References: <3e28d2c7-fbe5-298a-13ba-dcd8fd504666@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3e28d2c7-fbe5-298a-13ba-dcd8fd504666@redhat.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 01, 2020 at 05:21:40PM -0600, Eric Sandeen wrote:
> [*] Note: This needs to be merged as soon as possible as it's introducing an incompatible UAPI change...
> 
> STATX_ATTR_MOUNT_ROOT and STATX_ATTR_DAX got merged with the same value,
> so one of them needs fixing. Move STATX_ATTR_DAX.
> 
> While we're in here, clarify the value-matching scheme for some of the
> attributes, and explain why the value for DAX does not match.
> 
> Fixes: 80340fe3605c ("statx: add mount_root")
> Fixes: 712b2698e4c0 ("fs/stat: Define DAX statx attribute")
> Reported-by: David Howells <dhowells@redhat.com>
> Signed-off-by: Eric Sandeen <sandeen@redhat.com>
> Reviewed-by: David Howells <dhowells@redhat.com>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> ---
> V2: Change flag value per Darrick Wong
>     Tweak comment per Darrick Wong
>     Add Fixes: tags & reported-by & RVB per dhowells
> 
>  include/uapi/linux/stat.h | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/include/uapi/linux/stat.h b/include/uapi/linux/stat.h
> index 82cc58fe9368..1500a0f58041 100644
> --- a/include/uapi/linux/stat.h
> +++ b/include/uapi/linux/stat.h
> @@ -171,9 +171,12 @@ struct statx {
>   * be of use to ordinary userspace programs such as GUIs or ls rather than
>   * specialised tools.
>   *
> - * Note that the flags marked [I] correspond to generic FS_IOC_FLAGS
> + * Note that the flags marked [I] correspond to the FS_IOC_SETFLAGS flags
>   * semantically.  Where possible, the numerical value is picked to correspond
> - * also.
> + * also.  Note that the DAX attribute indicates that the file is in the CPU
> + * direct access state.  It does not correspond to the per-inode flag that
> + * some filesystems support.
> + *
>   */
>  #define STATX_ATTR_COMPRESSED		0x00000004 /* [I] File is compressed by the fs */
>  #define STATX_ATTR_IMMUTABLE		0x00000010 /* [I] File is marked immutable */
> @@ -183,7 +186,7 @@ struct statx {
>  #define STATX_ATTR_AUTOMOUNT		0x00001000 /* Dir: Automount trigger */
>  #define STATX_ATTR_MOUNT_ROOT		0x00002000 /* Root of a mount */
>  #define STATX_ATTR_VERITY		0x00100000 /* [I] Verity protected file */
> -#define STATX_ATTR_DAX			0x00002000 /* [I] File is DAX */
> +#define STATX_ATTR_DAX			0x00200000 /* File is currently in DAX state */
>  
>  
>  #endif /* _UAPI_LINUX_STAT_H */
> -- 
> 2.17.0
> 
