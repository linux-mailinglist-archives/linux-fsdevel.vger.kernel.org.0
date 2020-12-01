Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C0412CAA47
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Dec 2020 18:56:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404184AbgLARzN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Dec 2020 12:55:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:20110 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729734AbgLARzN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Dec 2020 12:55:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606845227;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v6BFyU2UYKTaosDZ89o5LvY8H2HM/d+FWPuM2+XPNh0=;
        b=gVRIAm6Vha0Dc4qMkqR+DveA8I0GLcsZVG0BoFyo9JXcFvfJGL1Eu5GYZs3/TTAmJlg1vx
        Fj7ZO9SaViX5E7KKjVa6XQtRYr5OgBYBVjWmX6GLWlCjetgkyIfi2M0Mla9hRiwc/NWpBz
        PbHHF+E3bh1tGGzk8TKYGXi2uXrqFxs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-592-5Y-NiigVMVePOR6i0Ml_Ow-1; Tue, 01 Dec 2020 12:53:45 -0500
X-MC-Unique: 5Y-NiigVMVePOR6i0Ml_Ow-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1BFAD858188;
        Tue,  1 Dec 2020 17:53:44 +0000 (UTC)
Received: from liberator.sandeen.net (ovpn04.gateway.prod.ext.phx2.redhat.com [10.5.9.4])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 315AB5D6AD;
        Tue,  1 Dec 2020 17:53:43 +0000 (UTC)
Subject: Re: [PATCH 2/2] statx: move STATX_ATTR_DAX attribute handling to
 filesystems
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     torvalds@linux-foundation.org,
        Miklos Szeredi <mszeredi@redhat.com>,
        Ira Weiny <ira.weiny@intel.com>,
        David Howells <dhowells@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-man@vger.kernel.org,
        linux-kernel@vger.kernel.org, xfs <linux-xfs@vger.kernel.org>,
        linux-ext4@vger.kernel.org, Xiaoli Feng <xifeng@redhat.com>
References: <e388f379-cd11-a5d2-db82-aa1aa518a582@redhat.com>
 <05a0f4fd-7f62-8fbc-378d-886ccd5b3f11@redhat.com>
 <20201201173905.GI143045@magnolia>
From:   Eric Sandeen <sandeen@redhat.com>
Message-ID: <98503625-d40e-78d7-334b-5fa5ff06045e@redhat.com>
Date:   Tue, 1 Dec 2020 11:53:42 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201201173905.GI143045@magnolia>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/1/20 11:39 AM, Darrick J. Wong wrote:
>> diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
>> index 1414ab79eacf..56deda7042fd 100644
>> --- a/fs/xfs/xfs_iops.c
>> +++ b/fs/xfs/xfs_iops.c
>> @@ -575,10 +575,13 @@ xfs_vn_getattr(
>>  		stat->attributes |= STATX_ATTR_APPEND;
>>  	if (ip->i_d.di_flags & XFS_DIFLAG_NODUMP)
>>  		stat->attributes |= STATX_ATTR_NODUMP;
>> +	if (IS_DAX(inode))
>> +		stat->attributes |= STATX_ATTR_DAX;
>>  
>>  	stat->attributes_mask |= (STATX_ATTR_IMMUTABLE |
>>  				  STATX_ATTR_APPEND |
>> -				  STATX_ATTR_NODUMP);
>> +				  STATX_ATTR_NODUMP |
>> +				  STATX_ATTR_DAX);
> TBH I preferred your previous iteration on this, which only set the DAX
> bit in the attributes_mask if the underlying storage was pmem and the
> blocksize was correct, etc. since it made it easier to distinguish
> between a filesystem where you /could/ have DAX (but it wasn't currently
> enabled) and a filesystem where it just isn't possible.
> 
> That might be enough to satisfy any critics who want to be able to
> detect DAX support from an installer program.

(nb: that previous iteration wasn't in public, just something I talked to
Darrick about)

I'm sympathetic to that argument, but the exact details of what the mask means
in general, and for dax in particular, seems to be subject to ongoing debate.

I'd like to just set it with the simplest definition "the fileystem supports
the feature" for now, so that we aren't ever setting a feature that's omitted
from the mask, and refine the mask-setting for the dax flag in another
iteration if/when we reach agreement.

-Eric

> --D
> 

