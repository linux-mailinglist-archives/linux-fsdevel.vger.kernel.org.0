Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDE2B2CB2BE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Dec 2020 03:18:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727776AbgLBCRZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Dec 2020 21:17:25 -0500
Received: from mga18.intel.com ([134.134.136.126]:13586 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727099AbgLBCRZ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Dec 2020 21:17:25 -0500
IronPort-SDR: 9qsx34WJlyxzeiH2TkkB7Uab823FxYJy/eYG/xQz9RzxASyUfcT1+WuSMwx8GTUqXt6zn46EOr
 FEEjfVkGbuMg==
X-IronPort-AV: E=McAfee;i="6000,8403,9822"; a="160711255"
X-IronPort-AV: E=Sophos;i="5.78,385,1599548400"; 
   d="scan'208";a="160711255"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2020 18:16:34 -0800
IronPort-SDR: syQiLccva6stDbNmtbS0hsL7Vj0C7CtYMTf4cj0Th6eoO+u5tYBaPAPmHSe1SMNZL+lK7ODY84
 X3FCfyjIHroQ==
X-IronPort-AV: E=Sophos;i="5.78,385,1599548400"; 
   d="scan'208";a="481350812"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2020 18:16:34 -0800
Date:   Tue, 1 Dec 2020 18:16:33 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Eric Sandeen <sandeen@redhat.com>
Cc:     torvalds@linux-foundation.org,
        Miklos Szeredi <mszeredi@redhat.com>,
        David Howells <dhowells@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-man@vger.kernel.org,
        linux-kernel@vger.kernel.org, xfs <linux-xfs@vger.kernel.org>,
        linux-ext4@vger.kernel.org, Xiaoli Feng <xifeng@redhat.com>
Subject: Re: [PATCH 1/2] uapi: fix statx attribute value overlap for DAX &
 MOUNT_ROOT
Message-ID: <20201202021633.GA1455219@iweiny-DESK2.sc.intel.com>
References: <e388f379-cd11-a5d2-db82-aa1aa518a582@redhat.com>
 <7027520f-7c79-087e-1d00-743bdefa1a1e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7027520f-7c79-087e-1d00-743bdefa1a1e@redhat.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 01, 2020 at 10:57:11AM -0600, Eric Sandeen wrote:
> STATX_ATTR_MOUNT_ROOT and STATX_ATTR_DAX got merged with the same value,
> so one of them needs fixing. Move STATX_ATTR_DAX.
> 
> While we're in here, clarify the value-matching scheme for some of the
> attributes, and explain why the value for DAX does not match.
> 
> Signed-off-by: Eric Sandeen <sandeen@redhat.com>
> ---
>  include/uapi/linux/stat.h | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/include/uapi/linux/stat.h b/include/uapi/linux/stat.h
> index 82cc58fe9368..9ad19eb9bbbf 100644
> --- a/include/uapi/linux/stat.h
> +++ b/include/uapi/linux/stat.h
> @@ -171,9 +171,10 @@ struct statx {
>   * be of use to ordinary userspace programs such as GUIs or ls rather than
>   * specialised tools.
>   *
> - * Note that the flags marked [I] correspond to generic FS_IOC_FLAGS
> + * Note that the flags marked [I] correspond to the FS_IOC_SETFLAGS flags
>   * semantically.  Where possible, the numerical value is picked to correspond
> - * also.
> + * also. Note that the DAX attribute indicates that the inode is currently
> + * DAX-enabled, not simply that the per-inode flag has been set.
>   */
>  #define STATX_ATTR_COMPRESSED		0x00000004 /* [I] File is compressed by the fs */
>  #define STATX_ATTR_IMMUTABLE		0x00000010 /* [I] File is marked immutable */
> @@ -183,7 +184,7 @@ struct statx {
>  #define STATX_ATTR_AUTOMOUNT		0x00001000 /* Dir: Automount trigger */
>  #define STATX_ATTR_MOUNT_ROOT		0x00002000 /* Root of a mount */
>  #define STATX_ATTR_VERITY		0x00100000 /* [I] Verity protected file */
> -#define STATX_ATTR_DAX			0x00002000 /* [I] File is DAX */
> +#define STATX_ATTR_DAX			0x00400000 /* File is currently DAX-enabled */

This will force a change to xfstests at a minimum.  And I do know of users who
have been using this value.  But I have gotten inquires about using the feature
so there are users out there.

Darrick, do we have someone doing the patches for xfstest?

Ira

>  
>  
>  #endif /* _UAPI_LINUX_STAT_H */
> -- 
> 2.17.0
> 
