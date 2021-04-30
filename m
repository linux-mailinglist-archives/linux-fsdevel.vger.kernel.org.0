Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4E9036FD8C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Apr 2021 17:18:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbhD3PSs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Apr 2021 11:18:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:59994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229532AbhD3PSr (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Apr 2021 11:18:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BEAE261407;
        Fri, 30 Apr 2021 15:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619795878;
        bh=m+766K8TP9QqsNsFMrziCZjUfhcjsNmqevpxCGi6uVI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ToK90G53adWVyS/HgPRbjv9opitgFQKM3Fx6di80uRcw/8014R4DtgkRzCHowkch9
         BjOS4gjZYY9b17YlYLDA3J9j4+5iP3Ji6krlnBGsQy4pvL4RiXUS9sGrBUBdK0eU+T
         OmQH6EyHNQ/QBBMAzyoWdufNfB4LrXPbVVhOs4qK/4whcZTLiyfMSvo2kaH6on5IPj
         gos2oNHWcbCC8ZJgoxQgAYoX7FlQ1JsqJQJlPMH0fX/wX7h7Acx3F/fjW+lKgekekk
         3tbyduS5sIZoIVQtdTr2nNdNx/YNwMYgGDHhphcGROtIE5DiQQ+D2KOY7osC2Uj6Q7
         K1cK4G3KKHwyA==
Date:   Fri, 30 Apr 2021 08:17:57 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Shreeya Patel <shreeya.patel@collabora.com>
Cc:     fstests@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        krisman@collabora.com, preichl@redhat.com, kernel@collabora.com,
        willy@infradead.org
Subject: Re: [PATCH] generic/631: Add a check for extended attributes
Message-ID: <20210430151757.GK1251862@magnolia>
References: <20210430102656.64254-1-shreeya.patel@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210430102656.64254-1-shreeya.patel@collabora.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 30, 2021 at 03:56:56PM +0530, Shreeya Patel wrote:
> Test case 631 fails for filesystems like exfat or vfat or any other
> which does not support extended attributes.
> 
> The main reason for failure is not being able to mount overlayfs
> with filesystems that do not support extended attributes.
> mount -t overlay overlay -o "$l,$u,$w,$i" $mergedir
> 
> Above command would return an error as -
> /var/mnt/scratch/merged0: wrong fs type, bad option, bad superblock on overlay,
> missing codepage or helper program, or other error.
> 
> dmesg log reports the following -
> overlayfs: filesystem on '/var/mnt/scratch/upperdir1' not supported
> 
> As per the overlayfs documentation -
> "A wide range of filesystems supported by Linux can be the lower filesystem,
> but not all filesystems that are mountable by Linux have the features needed
> for OverlayFS to work. The lower filesystem does not need to be writable.
> The lower filesystem can even be another overlayfs.
> The upper filesystem will normally be writable and if it is it must support
> the creation of trusted.* and/or user.* extended attributes, and must provide
> valid d_type in readdir responses, so NFS is not suitable.

Does this test also need to check for d_type support?

> A read-only overlay of two read-only filesystems may use any filesystem type."
> 
> As per the above statements from the overlayfs documentation, it is clear that
> filesystems that do not support extended attributes would not work with overlayfs.
> This is why we see the error in dmesg log for upperdir1 which had an exfat filesystem.

(Please wrap the commit messages at 75 columns, per SubmittingPatches.)

> Hence, add a check for extended attributes which would avoid running this tests for
> filesystems that are not supported.
> 
> Signed-off-by: Shreeya Patel <shreeya.patel@collabora.com>

Regardless, this seems like a reasonable change, so:

Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  tests/generic/631 | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tests/generic/631 b/tests/generic/631
> index c43f3de3..c7f0190e 100755
> --- a/tests/generic/631
> +++ b/tests/generic/631
> @@ -39,10 +39,12 @@ _cleanup()
>  
>  # get standard environment, filters and checks
>  . ./common/rc
> +. ./common/attr
>  
>  # real QA test starts here
>  _supported_fs generic
>  _require_scratch
> +_require_attrs
>  test "$FSTYP" = "overlay" && _notrun "Test does not apply to overlayfs."
>  _require_extra_fs overlay
>  
> -- 
> 2.30.2
> 
