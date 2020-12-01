Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33C9F2CADC2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Dec 2020 21:52:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728477AbgLAUvg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Dec 2020 15:51:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:29123 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727863AbgLAUvg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Dec 2020 15:51:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606855810;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=38FF9xvt73XKnUpkOFgpB6GdwGCUNHg/lXcETcqJqJM=;
        b=dVLVm04hW0J4Tt1NLrbB6IEtfjuKCOxxKCpZbY2n72oGtSYdsjW2BG0o49X20ed4FFR4qR
        9lnsSmSJf8YjBT+nEVQZ+R/pObeA7YLToYRqp3XBQYFRIa/feRSS3+fxUWn59LdH+aRwAe
        ++seubfMdigWG+7yayCTb5ZREohd9w0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-506-Pvsvy1TONwmm5e62aNgFyQ-1; Tue, 01 Dec 2020 15:50:06 -0500
X-MC-Unique: Pvsvy1TONwmm5e62aNgFyQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4D321185E480;
        Tue,  1 Dec 2020 20:50:05 +0000 (UTC)
Received: from liberator.sandeen.net (ovpn04.gateway.prod.ext.phx2.redhat.com [10.5.9.4])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6A5845D6AD;
        Tue,  1 Dec 2020 20:50:04 +0000 (UTC)
Subject: Re: [PATCH 2/2] statx: move STATX_ATTR_DAX attribute handling to
 filesystems
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        Ira Weiny <ira.weiny@intel.com>,
        David Howells <dhowells@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        xfs <linux-xfs@vger.kernel.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Xiaoli Feng <xifeng@redhat.com>
References: <e388f379-cd11-a5d2-db82-aa1aa518a582@redhat.com>
 <05a0f4fd-7f62-8fbc-378d-886ccd5b3f11@redhat.com>
 <CAHk-=wgOu9vgUfOSsjO3hHHxGDn4BKhitC_8XCfgmGKiiSm_ag@mail.gmail.com>
From:   Eric Sandeen <sandeen@redhat.com>
Message-ID: <71eecee3-3fc9-d18d-8553-d8326f6d73b3@redhat.com>
Date:   Tue, 1 Dec 2020 14:50:03 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wgOu9vgUfOSsjO3hHHxGDn4BKhitC_8XCfgmGKiiSm_ag@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/1/20 2:04 PM, Linus Torvalds wrote:
> On Tue, Dec 1, 2020 at 8:59 AM Eric Sandeen <sandeen@redhat.com> wrote:
>>
>> It's a bit odd to set STATX_ATTR_DAX into the statx attributes in the VFS;
>> while the VFS can detect the current DAX state, it is the filesystem which
>> actually sets S_DAX on the inode, and the filesystem is the place that
>> knows whether DAX is something that the "filesystem actually supports" [1]
>> so that the statx attributes_mask can be properly set.
>>
>> So, move STATX_ATTR_DAX attribute setting to the individual dax-capable
>> filesystems, and update the attributes_mask there as well.
> 
> I'm not really understanding the logic behind this.
> 
> The whole IS_DAX(inode) thing exists in various places outside the
> low-level filesystem, why shouldn't stat() do this?
> 
> If IS_DAX() is incorrect, then we have much bigger problems than some
> stat results. We have core functions like generic_file_read_iter() etc
> all making actual behavioral judgements on IS_DAX().

It's not incorrect, I didn't mean to imply that. Current code does accurately
set the DAX flag in the statx attributes.
 
> And if IS_DAX() is correct, then why shouldn't this just be done in
> generic code? Why move it to every individual filesystem?

At the end of the day, it's because only the individual filesystems can
manage the dax flag in the statx attributes_mask. (That's only place that
knows if dax "is available" in general, as opposed to being set on a specific
inode) So if they have to do that, they may as well set the actual attribute
as well, like they do for every other flag they manage...

I mean, we could leave the statx->attributes setting in the vfs, and add
the statx->attributes_mask setting to each dax-capable filesystem. That just
felt a bit asymmetric vs. the way every other filesystem-specific flag gets
handled.

-Eric

