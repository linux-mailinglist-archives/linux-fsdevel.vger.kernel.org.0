Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CCC2BE086E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Oct 2019 18:14:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389326AbfJVQNe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Oct 2019 12:13:34 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:41137 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389312AbfJVQN3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Oct 2019 12:13:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571760807;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TCw08GQg2fbzaBC8SDGKOVDBqyM+OtQZLQZFHMAIIEc=;
        b=GGodo4xa+ApfC2DwUJNHDFNHd/e8w7qMYC1x9JJU4b08G4U8mG8WLMPFUHUxYadPbu5ej/
        RGEhf/AEOZQuhgvRsU+LfJBIc3+CYFdzrexEAYQhtDKfILqgWGhWCi3NPWzELWFZtGx8CJ
        Kj5qJEUYqRik/EpGx5K3en2sJCeI1sE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-362-DSKNdaqiOa6Zbume7Z6VPg-1; Tue, 22 Oct 2019 12:13:23 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1F8891005500;
        Tue, 22 Oct 2019 16:13:22 +0000 (UTC)
Received: from [10.10.123.180] (ovpn-123-180.rdu2.redhat.com [10.10.123.180])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 068B210027A4;
        Tue, 22 Oct 2019 16:13:20 +0000 (UTC)
Subject: Re: [PATCH] Add prctl support for controlling PF_MEMALLOC V2
To:     Michal Hocko <mhocko@kernel.org>
References: <20191021214137.8172-1-mchristi@redhat.com>
 <20191022112446.GA8213@dhcp22.suse.cz>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, martin@urbackup.org,
        Damien.LeMoal@wdc.com
From:   Mike Christie <mchristi@redhat.com>
Message-ID: <5DAF2AA0.5030500@redhat.com>
Date:   Tue, 22 Oct 2019 11:13:20 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <20191022112446.GA8213@dhcp22.suse.cz>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: DSKNdaqiOa6Zbume7Z6VPg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/22/2019 06:24 AM, Michal Hocko wrote:
> On Mon 21-10-19 16:41:37, Mike Christie wrote:
>> There are several storage drivers like dm-multipath, iscsi, tcmu-runner,
>> amd nbd that have userspace components that can run in the IO path. For
>> example, iscsi and nbd's userspace deamons may need to recreate a socket
>> and/or send IO on it, and dm-multipath's daemon multipathd may need to
>> send IO to figure out the state of paths and re-set them up.
>>
>> In the kernel these drivers have access to GFP_NOIO/GFP_NOFS and the
>> memalloc_*_save/restore functions to control the allocation behavior,
>> but for userspace we would end up hitting a allocation that ended up
>> writing data back to the same device we are trying to allocate for.
>=20
> Which code paths are we talking about here? Any ioctl or is this a
> general syscall path? Can we mark the process in a more generic way?

It depends on the daemon. The common one for example are iscsi and nbd
need network related calls like sendmsg, recvmsg, socket, etc.
tcmu-runner could need the network ones and also read and write when it
does IO to a FS or device. dm-multipath needs the sg io ioctls.


> E.g. we have PF_LESS_THROTTLE (used by nfsd). It doesn't affect the
> reclaim recursion but it shows a pattern that doesn't really exhibit
> too many internals. Maybe we need PF_IO_FLUSHER or similar?

I am not familiar with PF_IO_FLUSHER. If it prevents the recursion
problem then please send me details and I will look into it for the next
posting.

>=20
>> This patch allows the userspace deamon to set the PF_MEMALLOC* flags
>> with prctl during their initialization so later allocations cannot
>> calling back into them.
>=20
> TBH I am not really happy to export these to the userspace. They are
> an internal implementation detail and the userspace shouldn't really

They care in these cases, because block/fs drivers must be able to make
forward progress during writes. To meet this guarantee kernel block
drivers use mempools and memalloc/GFP flags.

For these userspace components of the block/fs drivers they already do
things normal daemons do not to meet that guarantee like mlock their
memory, disable oom killer, and preallocate resources they have control
over. They have no control over reclaim like the kernel drivers do so
its easy for us to deadlock when memory gets low.

> care. So if this is really necessary then we need a very good argumnets
> and documentation to make the usage clear.
> =20
>> Signed-off-by: Mike Christie <mchristi@redhat.com>
>> ---
>>
>> V2:
>> - Use prctl instead of procfs.
>> - Add support for NOFS for fuse.
>> - Check permissions.
>>
>>  include/uapi/linux/prctl.h |  8 +++++++
>>  kernel/sys.c               | 44 ++++++++++++++++++++++++++++++++++++++
>>  2 files changed, 52 insertions(+)
>>
>> diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
>> index 7da1b37b27aa..6f6b3af6633a 100644
>> --- a/include/uapi/linux/prctl.h
>> +++ b/include/uapi/linux/prctl.h
>> @@ -234,4 +234,12 @@ struct prctl_mm_map {
>>  #define PR_GET_TAGGED_ADDR_CTRL=09=0956
>>  # define PR_TAGGED_ADDR_ENABLE=09=09(1UL << 0)
>> =20
>> +/* Control reclaim behavior when allocating memory */
>> +#define PR_SET_MEMALLOC=09=09=0957
>> +#define PR_GET_MEMALLOC=09=09=0958
>> +#define PR_MEMALLOC_SET_NOIO=09=09(1UL << 0)
>> +#define PR_MEMALLOC_CLEAR_NOIO=09=09(1UL << 1)
>> +#define PR_MEMALLOC_SET_NOFS=09=09(1UL << 2)
>> +#define PR_MEMALLOC_CLEAR_NOFS=09=09(1UL << 3)
>> +
>>  #endif /* _LINUX_PRCTL_H */
>> diff --git a/kernel/sys.c b/kernel/sys.c
>> index a611d1d58c7d..34fedc9fc7e4 100644
>> --- a/kernel/sys.c
>> +++ b/kernel/sys.c
>> @@ -2486,6 +2486,50 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long=
, arg2, unsigned long, arg3,
>>  =09=09=09return -EINVAL;
>>  =09=09error =3D GET_TAGGED_ADDR_CTRL();
>>  =09=09break;
>> +=09case PR_SET_MEMALLOC:
>> +=09=09if (!capable(CAP_SYS_ADMIN))
>> +=09=09=09return -EPERM;
>> +
>> +=09=09if (arg3 || arg4 || arg5)
>> +=09=09=09return -EINVAL;
>> +
>> +=09=09switch (arg2) {
>> +=09=09case PR_MEMALLOC_SET_NOIO:
>> +=09=09=09if (current->flags & PF_MEMALLOC_NOFS)
>> +=09=09=09=09return -EINVAL;
>> +
>> +=09=09=09current->flags |=3D PF_MEMALLOC_NOIO;
>> +=09=09=09break;
>> +=09=09case PR_MEMALLOC_CLEAR_NOIO:
>> +=09=09=09current->flags &=3D ~PF_MEMALLOC_NOIO;
>> +=09=09=09break;
>> +=09=09case PR_MEMALLOC_SET_NOFS:
>> +=09=09=09if (current->flags & PF_MEMALLOC_NOIO)
>> +=09=09=09=09return -EINVAL;
>> +
>> +=09=09=09current->flags |=3D PF_MEMALLOC_NOFS;
>> +=09=09=09break;
>> +=09=09case PR_MEMALLOC_CLEAR_NOFS:
>> +=09=09=09current->flags &=3D ~PF_MEMALLOC_NOFS;
>> +=09=09=09break;
>> +=09=09default:
>> +=09=09=09return -EINVAL;
>> +=09=09}
>> +=09=09break;
>> +=09case PR_GET_MEMALLOC:
>> +=09=09if (!capable(CAP_SYS_ADMIN))
>> +=09=09=09return -EPERM;
>> +
>> +=09=09if (arg2 || arg3 || arg4 || arg5)
>> +=09=09=09return -EINVAL;
>> +
>> +=09=09if (current->flags & PF_MEMALLOC_NOIO)
>> +=09=09=09error =3D PR_MEMALLOC_SET_NOIO;
>> +=09=09else if (current->flags & PF_MEMALLOC_NOFS)
>> +=09=09=09error =3D PR_MEMALLOC_SET_NOFS;
>> +=09=09else
>> +=09=09=09error =3D 0;
>> +=09=09break;
>>  =09default:
>>  =09=09error =3D -EINVAL;
>>  =09=09break;
>> --=20
>> 2.20.1
>>
>=20

