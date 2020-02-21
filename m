Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86231167990
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2020 10:37:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727840AbgBUJhl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Feb 2020 04:37:41 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:32112 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726930AbgBUJhl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Feb 2020 04:37:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582277859;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PKgM7vsRrdBwIvm369Whuhz6zJ+JIzSVniKOUJb1bUM=;
        b=NXpkh35+NCUkywhrgKh0XGZx1flve2igJfsJTpDvD3ysUrCMm8FopQ6IaRSkyOApNS3OYD
        w+haYz0c5pz9s6YHhpacLUKNsRXXlukBs0KGdsmCMYGgeIZUSyOcW/F1sVS4V9SwQwco+x
        +MR/1SIiLOU5O4hNp9OLIUaHWWYi3F4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-349-1a6uWXuZP3u46w5NtGZVKg-1; Fri, 21 Feb 2020 04:37:38 -0500
X-MC-Unique: 1a6uWXuZP3u46w5NtGZVKg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 42482800D50;
        Fri, 21 Feb 2020 09:37:37 +0000 (UTC)
Received: from localhost (dhcp-12-102.nay.redhat.com [10.66.12.102])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B12A2859A5;
        Fri, 21 Feb 2020 09:37:36 +0000 (UTC)
Date:   Fri, 21 Feb 2020 17:48:01 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Jeff Moyer <jmoyer@redhat.com>
Cc:     fstests@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org
Subject: Re: [PATCH V2 1/3] dax/dm: disable testing on devices that don't
 support dax
Message-ID: <20200221094801.GJ14282@dhcp-12-102.nay.redhat.com>
Mail-Followup-To: Jeff Moyer <jmoyer@redhat.com>, fstests@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
References: <20200220200632.14075-1-jmoyer@redhat.com>
 <20200220200632.14075-2-jmoyer@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200220200632.14075-2-jmoyer@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 20, 2020 at 03:06:30PM -0500, Jeff Moyer wrote:
> Move the check for dax from the individual target scripts into
> _require_dm_target.  This fixes up a couple of missed tests that are
> failing due to the lack of dax support (such as tests requiring
> dm-snapshot).
> 
> Signed-off-by: Jeff Moyer <jmoyer@redhat.com>
> ---
>  common/dmdelay  |  5 -----
>  common/dmerror  |  5 -----
>  common/dmflakey |  5 -----
>  common/dmthin   |  5 -----
>  common/rc       | 11 +++++++++++
>  5 files changed, 11 insertions(+), 20 deletions(-)
> 
> diff --git a/common/dmdelay b/common/dmdelay
> index f1e725b9..66cac1a7 100644
> --- a/common/dmdelay
> +++ b/common/dmdelay
> @@ -7,11 +7,6 @@
>  DELAY_NONE=0
>  DELAY_READ=1
>  
> -echo $MOUNT_OPTIONS | grep -q dax
> -if [ $? -eq 0 ]; then
> -	_notrun "Cannot run tests with DAX on dmdelay devices"
> -fi
> -
>  _init_delay()
>  {
>  	local BLK_DEV_SIZE=`blockdev --getsz $SCRATCH_DEV`
> diff --git a/common/dmerror b/common/dmerror
> index 426f1e96..7d12e0a1 100644
> --- a/common/dmerror
> +++ b/common/dmerror
> @@ -4,11 +4,6 @@
>  #
>  # common functions for setting up and tearing down a dmerror device
>  
> -echo $MOUNT_OPTIONS | grep -q dax
> -if [ $? -eq 0 ]; then
> -	_notrun "Cannot run tests with DAX on dmerror devices"
> -fi
> -
>  _dmerror_setup()
>  {
>  	local dm_backing_dev=$SCRATCH_DEV
> diff --git a/common/dmflakey b/common/dmflakey
> index 2af3924d..b4e11ae9 100644
> --- a/common/dmflakey
> +++ b/common/dmflakey
> @@ -8,11 +8,6 @@ FLAKEY_ALLOW_WRITES=0
>  FLAKEY_DROP_WRITES=1
>  FLAKEY_ERROR_WRITES=2
>  
> -echo $MOUNT_OPTIONS | grep -q dax
> -if [ $? -eq 0 ]; then
> -	_notrun "Cannot run tests with DAX on dmflakey devices"
> -fi
> -
>  _init_flakey()
>  {
>  	local BLK_DEV_SIZE=`blockdev --getsz $SCRATCH_DEV`
> diff --git a/common/dmthin b/common/dmthin
> index 7946e9a7..61dd6f89 100644
> --- a/common/dmthin
> +++ b/common/dmthin
> @@ -21,11 +21,6 @@ DMTHIN_POOL_DEV="/dev/mapper/$DMTHIN_POOL_NAME"
>  DMTHIN_VOL_NAME="thin-vol"
>  DMTHIN_VOL_DEV="/dev/mapper/$DMTHIN_VOL_NAME"
>  
> -echo $MOUNT_OPTIONS | grep -q dax
> -if [ $? -eq 0 ]; then
> -	_notrun "Cannot run tests with DAX on dmthin devices"
> -fi
> -
>  _dmthin_cleanup()
>  {
>  	$UMOUNT_PROG $SCRATCH_MNT > /dev/null 2>&1
> diff --git a/common/rc b/common/rc
> index eeac1355..65cde32b 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -1874,6 +1874,17 @@ _require_dm_target()
>  	_require_sane_bdev_flush $SCRATCH_DEV
>  	_require_command "$DMSETUP_PROG" dmsetup
>  
> +	echo $MOUNT_OPTIONS | grep -q dax
> +	if [ $? -eq 0 ]; then
> +		case $target in
> +		stripe|linear|log-writes)

I've checked all cases which import ./common/dm.* (without dmapi), they all
has _require_dm_target. So this patch is good to me.

And by checking current linux source code:

  0 dm-linear.c      226 .direct_access = linear_dax_direct_access,
  1 dm-log-writes.c 1016 .direct_access = log_writes_dax_direct_access,
  2 dm-stripe.c      486 .direct_access = stripe_dax_direct_access,
  3 dm-target.c      159 .direct_access = io_err_dax_direct_access,

Only linear, stripe and log-writes support direct_access.

Thanks,
Zorro

> +			;;
> +		*)
> +			_notrun "Cannot run tests with DAX on $target devices."
> +			;;
> +		esac
> +	fi
> +
>  	modprobe dm-$target >/dev/null 2>&1
>  
>  	$DMSETUP_PROG targets 2>&1 | grep -q ^$target
> -- 
> 2.19.1
> 

