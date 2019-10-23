Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76DCFE21B9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Oct 2019 19:27:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729377AbfJWR1i (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Oct 2019 13:27:38 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:31066 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728583AbfJWR1i (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Oct 2019 13:27:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571851656;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=esWx43fZLzMnjouiOJwe7rGNAZqI0D7XVCwYEnxdbUA=;
        b=BCJgtDeO7mYFGt7ROjRdrf0L81AoVq3f3IbT3/cmigJWJuKC2nSbuDq2eBBn7PnF6ylA9M
        nsW0AsueiXzw75AZS9UHA5E/YSi451ivsdB6nAQNHMYyD9Kf81cd1SiKsm0zmuR4SMkQfZ
        /cdDuue3UBecaVVIINzTalgYtIl/8hg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-346-N1h7g-G8MRyyM5N5r7xtRg-1; Wed, 23 Oct 2019 13:27:35 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3FDBA800D49;
        Wed, 23 Oct 2019 17:27:33 +0000 (UTC)
Received: from [10.10.123.185] (ovpn-123-185.rdu2.redhat.com [10.10.123.185])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4BC1760C80;
        Wed, 23 Oct 2019 17:27:30 +0000 (UTC)
Subject: Re: [PATCH] Add prctl support for controlling PF_MEMALLOC V2
To:     Michal Hocko <mhocko@kernel.org>,
        Dave Chinner <david@fromorbit.com>
References: <20191021214137.8172-1-mchristi@redhat.com>
 <20191022112446.GA8213@dhcp22.suse.cz> <5DAF2AA0.5030500@redhat.com>
 <20191022163310.GS9379@dhcp22.suse.cz>
 <20191022204344.GB2044@dread.disaster.area>
 <20191023071146.GE754@dhcp22.suse.cz>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, martin@urbackup.org,
        Damien.LeMoal@wdc.com
From:   Mike Christie <mchristi@redhat.com>
Message-ID: <5DB08D81.8050300@redhat.com>
Date:   Wed, 23 Oct 2019 12:27:29 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <20191023071146.GE754@dhcp22.suse.cz>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: N1h7g-G8MRyyM5N5r7xtRg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/23/2019 02:11 AM, Michal Hocko wrote:
> On Wed 23-10-19 07:43:44, Dave Chinner wrote:
>> On Tue, Oct 22, 2019 at 06:33:10PM +0200, Michal Hocko wrote:
>=20
> Thanks for more clarifiation regarding PF_LESS_THROTTLE.
>=20
> [...]
>>> PF_IO_FLUSHER would mean that the user
>>> context is a part of the IO path and therefore there are certain reclai=
m
>>> recursion restrictions.
>>
>> If PF_IO_FLUSHER just maps to PF_LESS_THROTTLE|PF_MEMALLOC_NOIO,
>> then I'm not sure we need a new definition. Maybe that's the ptrace
>> flag name, but in the kernel we don't need a PF_IO_FLUSHER process
>> flag...
>=20
> Yes, the internal implementation would do something like that. I was
> more interested in the user space visible API at this stage. Something
> generic enough because exporting MEMALLOC flags is just a bad idea IMHO
> (especially PF_MEMALLOC).

Do you mean we would do something like:

prctl()
....
case PF_SET_IO_FLUSHER:
        current->flags |=3D PF_MEMALLOC_NOIO;
....

or are you saying we would add a new PF_IO_FLUSHER flag and then modify
PF_MEMALLOC_NOIO uses like in current_gfp_context:

if (current->flags & (PF_MEMALLOC_NOIO | PF_IO_FLUSHER)
      flags &=3D ~(__GFP_IO | __GFP_FS);

?

>=20
>>>>>> This patch allows the userspace deamon to set the PF_MEMALLOC* flags
>>>>>> with prctl during their initialization so later allocations cannot
>>>>>> calling back into them.
>>>>>
>>>>> TBH I am not really happy to export these to the userspace. They are
>>>>> an internal implementation detail and the userspace shouldn't really
>>>>
>>>> They care in these cases, because block/fs drivers must be able to mak=
e
>>>> forward progress during writes. To meet this guarantee kernel block
>>>> drivers use mempools and memalloc/GFP flags.
>>>>
>>>> For these userspace components of the block/fs drivers they already do
>>>> things normal daemons do not to meet that guarantee like mlock their
>>>> memory, disable oom killer, and preallocate resources they have contro=
l
>>>> over. They have no control over reclaim like the kernel drivers do so
>>>> its easy for us to deadlock when memory gets low.
>>>
>>> OK, fair enough. How much of a control do they really need though. Is a
>>> single PF_IO_FLUSHER as explained above (essentially imply GPF_NOIO
>>> context) sufficient?
>>
>> I think some of these usrspace processes work at the filesystem
>> level and so really only need GFP_NOFS allocation (fuse), while
>> others work at the block device level (iscsi, nbd) so need GFP_NOIO
>> allocation. So there's definitely an argument for providing both...
>=20
> The main question is whether giving more APIs is really necessary. Is
> there any real problem to give them only PF_IO_FLUSHER and let both
> groups use this one? It will imply more reclaim restrictions for solely
> FS based ones but is this a practical problem? If yes we can always add
> PF_FS_$FOO later on.


I am not sure. I will have to defer to general FS experts like Dave or
Martin and Damien for the specific fuse case. There do not seem to be a
lot of places where we check for __GFP_IO so configs with fuse and
bcache for example are probably not a big deal. However, I am not very
familiar with some of the other code paths in the mm layer and how FSs
interact with them.

