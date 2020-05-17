Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06D021D6506
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 May 2020 03:16:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbgEQBQE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 16 May 2020 21:16:04 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:58059 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726763AbgEQBQD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 16 May 2020 21:16:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589678160;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DkMpg+DAZVobJN3z7nH0TAxZiR3oF4oJ3zndpFda8ag=;
        b=WayT9XOoEURYH4R2ywfSeIrJlcEfXa552jfiDOgcP+zQVQy87CMgf8jsRW8HB5Q5JoSySW
        mEKu+AWowwYHTkcgdpwcALyR3rJQgNpJEoLZLOxR+npzzZW4x6UR2yGFOjKnZkbmF5p89B
        Yt3QPE33vwvpoo68Vgmq46t3UOEbcWM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-291-sw_h2SfLOCSt6ovumpljBA-1; Sat, 16 May 2020 21:15:58 -0400
X-MC-Unique: sw_h2SfLOCSt6ovumpljBA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 771F01009440;
        Sun, 17 May 2020 01:15:57 +0000 (UTC)
Received: from llong.remote.csb (ovpn-112-26.rdu2.redhat.com [10.10.112.26])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E7D805C1D6;
        Sun, 17 May 2020 01:15:55 +0000 (UTC)
Subject: Re: "BUG: MAX_LOCKDEP_ENTRIES too low" with 6979
 "&type->s_umount_key"
To:     Qian Cai <cai@lca.pw>, Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@redhat.com>
Cc:     David Howells <dhowells@redhat.com>,
        Alexander Viro <viro@ZenIV.linux.org.uk>,
        linux-fsdevel@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <F430E503-F8E9-41B6-B23E-D350FD73359B@lca.pw>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <e8c6d3af-3045-0a37-5e9e-bfd60c09f97d@redhat.com>
Date:   Sat, 16 May 2020 21:15:55 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <F430E503-F8E9-41B6-B23E-D350FD73359B@lca.pw>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/15/20 1:21 AM, Qian Cai wrote:
> Lockdep is screwed here in next-20200514 due to "BUG: MAX_LOCKDEP_ENTRIES too low". One of the traces below pointed to this linux-next commit,
>
> 8c8e824d4ef0 watch_queue: Introduce a non-repeating system-unique superblock ID
>
> which was accidentally just showed up in next-20200514 along with,
>
> 46896d79c514 watch_queue: Add superblock notifications
>
> I did have here,
>
> CONFIG_SB_NOTIFICATIONS=y
> CONFIG_MOUNT_NOTIFICATIONS=y
> CONFIG_FSINFO=y
>
> While MAX_LOCKDEP_ENTRIES is 32768, I noticed there is one type of lock had a lot along,
>
> # grep  'type->s_umount_key’ /proc/lockdep_chains | wc -l
> 6979

The lock_list table entries are for tracking a lock's forward and 
backward dependencies. The lockdep_chains isn't the right lockdep file 
to look at. Instead, check the lockdep files for entries with the 
maximum BD (backward dependency) + FD (forward dependency). That will 
give you a better view of which locks are consuming most of the 
lock_list entries. Also take a look at lockdep_stats for an overall view 
of how much various table entries are being consumed.

Cheers,
Longman


