Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5DA82130052
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 Jan 2020 03:56:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727273AbgADC4Y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Jan 2020 21:56:24 -0500
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:53417 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727255AbgADC4Y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Jan 2020 21:56:24 -0500
Received: from dread.disaster.area (pa49-180-68-255.pa.nsw.optusnet.com.au [49.180.68.255])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 33E4043ED89;
        Sat,  4 Jan 2020 13:56:22 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1inZbw-00084l-N0; Sat, 04 Jan 2020 13:56:20 +1100
Date:   Sat, 4 Jan 2020 13:56:20 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Tony Asleson <tasleson@redhat.com>
Cc:     linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [RFC 9/9] __xfs_printk: Add durable name to output
Message-ID: <20200104025620.GC23195@dread.disaster.area>
References: <20191223225558.19242-1-tasleson@redhat.com>
 <20191223225558.19242-10-tasleson@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191223225558.19242-10-tasleson@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=X6os11be c=1 sm=1 tr=0
        a=sbdTpStuSq8iNQE8viVliQ==:117 a=sbdTpStuSq8iNQE8viVliQ==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=Jdjhy38mL1oA:10
        a=20KFwNOVAAAA:8 a=7-415B0cAAAA:8 a=Y1q_LsDJlNF9FywMdSwA:9
        a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Dec 23, 2019 at 04:55:58PM -0600, Tony Asleson wrote:
> Add persistent durable name to xfs messages so we can
> correlate them with other messages for the same block
> device.
> 
> Signed-off-by: Tony Asleson <tasleson@redhat.com>
> ---
>  fs/xfs/xfs_message.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/fs/xfs/xfs_message.c b/fs/xfs/xfs_message.c
> index 9804efe525a9..8447cdd985b4 100644
> --- a/fs/xfs/xfs_message.c
> +++ b/fs/xfs/xfs_message.c
> @@ -20,6 +20,23 @@ __xfs_printk(
>  	const struct xfs_mount	*mp,
>  	struct va_format	*vaf)
>  {
> +	char dict[128];
> +	int dict_len = 0;
> +
> +	if (mp && mp->m_super && mp->m_super->s_bdev &&
> +		mp->m_super->s_bdev->bd_disk) {
> +		dict_len = dev_durable_name(
> +			disk_to_dev(mp->m_super->s_bdev->bd_disk)->parent,
> +			dict,
> +			sizeof(dict));
> +		if (dict_len) {
> +			printk_emit(
> +				0, level[1] - '0', dict, dict_len,
> +				"XFS (%s): %pV\n",  mp->m_fsname, vaf);
> +			return;
> +		}
> +	}

NACK on the ground this is a gross hack.

> +
>  	if (mp && mp->m_fsname) {

mp->m_fsname is the name of the device we use everywhere for log
messages, it's set up at mount time so we don't have to do runtime
evaulation of the device name every time we need to emit the device
name in a log message.

So, if you have some sooper speshial new device naming scheme, it
needs to be stored into the struct xfs_mount to replace mp->m_fsname.

And if you have some sooper spehsial new printk API that uses this
new device name, everything XFS emits needs to use it
unconditionally as we do with mp->m_fsname now.

IOWs, this isn't conditional code - it either works for the entire
life of the mount for every message we have to emit with a single
setup call, or the API is broken and needs to be rethought.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
