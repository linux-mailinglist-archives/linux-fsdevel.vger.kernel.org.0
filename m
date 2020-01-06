Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44698130C31
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jan 2020 03:45:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727393AbgAFCpM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 5 Jan 2020 21:45:12 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:47272 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727307AbgAFCpL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 5 Jan 2020 21:45:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578278710;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R7cuW4nr6dXYOh0P9VyDEZmrT7Y+OzXd9iAtK+rNk4U=;
        b=bp1QaRp/i+CM94SoJjBsqf+qWy0ma4Lx6QFpiU0CLzvoxlzcPxLYRe5tmHzvUP34OHx5+b
        WWHP6Rb5Ca4WlzBGPnmi4xvaEEkHuUNCS0ibUMxgoYIFgyQUnKybqlBID59kjp81LIPTnj
        xq62FCvXeB85AAbmO+4ngSAvJZSI4Pk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-104-dr3OOEMuN7-CQWg_qHRm-Q-1; Sun, 05 Jan 2020 21:45:07 -0500
X-MC-Unique: dr3OOEMuN7-CQWg_qHRm-Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E663C800D48;
        Mon,  6 Jan 2020 02:45:05 +0000 (UTC)
Received: from [10.3.112.12] (ovpn-112-12.phx2.redhat.com [10.3.112.12])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0D4747BFFB;
        Mon,  6 Jan 2020 02:45:02 +0000 (UTC)
Reply-To: tasleson@redhat.com
Subject: Re: [RFC 9/9] __xfs_printk: Add durable name to output
To:     Dave Chinner <david@fromorbit.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20191223225558.19242-1-tasleson@redhat.com>
 <20191223225558.19242-10-tasleson@redhat.com>
 <20200104025620.GC23195@dread.disaster.area>
From:   Tony Asleson <tasleson@redhat.com>
Organization: Red Hat
Message-ID: <5ad7cf7b-e261-102c-afdc-fa34bed98921@redhat.com>
Date:   Sun, 5 Jan 2020 20:45:00 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200104025620.GC23195@dread.disaster.area>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/3/20 8:56 PM, Dave Chinner wrote:
> On Mon, Dec 23, 2019 at 04:55:58PM -0600, Tony Asleson wrote:
>> Add persistent durable name to xfs messages so we can
>> correlate them with other messages for the same block
>> device.
>>
>> Signed-off-by: Tony Asleson <tasleson@redhat.com>
>> ---
>>  fs/xfs/xfs_message.c | 17 +++++++++++++++++
>>  1 file changed, 17 insertions(+)
>>
>> diff --git a/fs/xfs/xfs_message.c b/fs/xfs/xfs_message.c
>> index 9804efe525a9..8447cdd985b4 100644
>> --- a/fs/xfs/xfs_message.c
>> +++ b/fs/xfs/xfs_message.c
>> @@ -20,6 +20,23 @@ __xfs_printk(
>>  	const struct xfs_mount	*mp,
>>  	struct va_format	*vaf)
>>  {
>> +	char dict[128];
>> +	int dict_len = 0;
>> +
>> +	if (mp && mp->m_super && mp->m_super->s_bdev &&
>> +		mp->m_super->s_bdev->bd_disk) {
>> +		dict_len = dev_durable_name(
>> +			disk_to_dev(mp->m_super->s_bdev->bd_disk)->parent,
>> +			dict,
>> +			sizeof(dict));
>> +		if (dict_len) {
>> +			printk_emit(
>> +				0, level[1] - '0', dict, dict_len,
>> +				"XFS (%s): %pV\n",  mp->m_fsname, vaf);
>> +			return;
>> +		}
>> +	}
> 
> NACK on the ground this is a gross hack.

James suggested I utilize dev_printk, which does make things simpler.
Would something like this be acceptable?

diff --git a/fs/xfs/xfs_message.c b/fs/xfs/xfs_message.c
index 9804efe525a9..0738c74a8d3a 100644
--- a/fs/xfs/xfs_message.c
+++ b/fs/xfs/xfs_message.c
@@ -20,11 +20,18 @@ __xfs_printk(
        const struct xfs_mount  *mp,
        struct va_format        *vaf)
 {
+       struct device *dev = NULL;
+
+       if (mp && mp->m_super && mp->m_super->s_bdev &&
+               mp->m_super->s_bdev->bd_disk) {
+               dev = disk_to_dev(mp->m_super->s_bdev->bd_disk)->parent;
+       }
+
        if (mp && mp->m_fsname) {
-               printk("%sXFS (%s): %pV\n", level, mp->m_fsname, vaf);
+               dev_printk(level, dev, "XFS (%s): %pV\n", mp->m_fsname,
vaf);
                return;
        }
-       printk("%sXFS: %pV\n", level, vaf);
+       dev_printk(level, dev, "XFS: %pV\n", vaf);
 }

>> +
>>  	if (mp && mp->m_fsname) {
> 
> mp->m_fsname is the name of the device we use everywhere for log
> messages, it's set up at mount time so we don't have to do runtime
> evaulation of the device name every time we need to emit the device
> name in a log message.
> 
> So, if you have some sooper speshial new device naming scheme, it
> needs to be stored into the struct xfs_mount to replace mp->m_fsname.

I don't think we want to replace mp->m_fsname with the vpd 0x83 device
identifier.  This proposed change is adding a key/value structured data
to the log message for non-ambiguous device identification over time,
not to place the ID in the human readable portion of the message.  The
existing name is useful too, especially when it involves a partition.

> And if you have some sooper spehsial new printk API that uses this
> new device name, everything XFS emits needs to use it
> unconditionally as we do with mp->m_fsname now.
> 
> IOWs, this isn't conditional code - it either works for the entire
> life of the mount for every message we have to emit with a single
> setup call, or the API is broken and needs to be rethought.

I've been wondering why the struct scsi device uses rcu data for the vpd
as I would not think that it would be changing for a specific device.
Perhaps James can shed some light on this?

-Tony

