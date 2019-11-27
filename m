Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 89A7210B293
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Nov 2019 16:42:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727138AbfK0PmJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Nov 2019 10:42:09 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:34933 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726558AbfK0PmJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Nov 2019 10:42:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574869327;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rTiplu3jVVG57/goTxX/EWtlHVQFyeygebJxT1iF7jE=;
        b=NP4zJgSxRdtEh5kJoYt6wHBchePLp7N22H5wxOT7UVjdejkqmQtyETS+1Yhtv8xPEPyXdm
        AdN/Dknww0GOIs6rwzK6C01c00vviANp4AJ8rN1KfalK5zv+5PQu56uh5AovJ4moBBT5Om
        b5diZsepnkFSN5tUIjvmNXKGxnVKlOk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-165-KTmG-I0VOJaQbcSWsc6Yig-1; Wed, 27 Nov 2019 10:42:06 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4E31A101F4E0;
        Wed, 27 Nov 2019 15:42:04 +0000 (UTC)
Received: from fogou.chygwyn.com (unknown [10.33.36.46])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 43F691001DE1;
        Wed, 27 Nov 2019 15:41:55 +0000 (UTC)
Subject: Re: [PATCH] mm/filemap: do not allocate cache pages beyond end of
 file at read
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     =?UTF-8?Q?Andreas_Gr=c3=bcnbacher?= <andreas.gruenbacher@gmail.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "cluster-devel@redhat.com" <cluster-devel@redhat.com>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Steve French <sfrench@samba.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Bob Peterson <rpeterso@redhat.com>
References: <157225677483.3442.4227193290486305330.stgit@buzz>
 <20191028124222.ld6u3dhhujfqcn7w@box>
 <CAHk-=wgQ-Dcs2keNJPovTb4gG33M81yANH6KZM9d5NLUb-cJ1g@mail.gmail.com>
 <20191028125702.xdfbs7rqhm3wer5t@box>
 <ac83fee6-9bcd-8c66-3596-2c0fbe6bcf96@yandex-team.ru>
 <CAHk-=who0HS=NT8U7vFDT7er_CD7+ZreRJMxjYrRXs5G6dbpyw@mail.gmail.com>
 <f0140b13-cca2-af9e-eb4b-82eda134eb8f@redhat.com>
 <CAHk-=wh4SKRxKQf5LawRMSijtjRVQevaFioBK+tOZAVPt7ek0Q@mail.gmail.com>
 <640bbe51-706b-8d9f-4abc-5f184de6a701@redhat.com>
 <CAHpGcM+o2OwXdrj+A2_OqRg6YokfauFNiBJF-BQp0dJFvq_BrQ@mail.gmail.com>
 <22f04f02-86e4-b379-81c8-08c002a648f0@redhat.com>
 <CAHk-=whRuPkm7zFUiGe_BXkLvEdShZGngkb=uRufgU65ogCxfg@mail.gmail.com>
From:   Steven Whitehouse <swhiteho@redhat.com>
Message-ID: <cdd48a4d-42a4-dd15-2701-e08e26fef17f@redhat.com>
Date:   Wed, 27 Nov 2019 15:41:53 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CAHk-=whRuPkm7zFUiGe_BXkLvEdShZGngkb=uRufgU65ogCxfg@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: KTmG-I0VOJaQbcSWsc6Yig-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

On 25/11/2019 17:05, Linus Torvalds wrote:
> On Mon, Nov 25, 2019 at 2:53 AM Steven Whitehouse <swhiteho@redhat.com> wrote:
>> Linus, is that roughly what you were thinking of?
> So the concept looks ok, but I don't really like the new flags as they
> seem to be gfs2-specific rather than generic.
>
> That said, I don't _gate_ them either, since they aren't in any
> critical code sequence, and it's not like they do anything really odd.
>
> I still think the whole gfs2 approach is broken. You're magically ok
> with using stale data from the cache just because it's cached, even if
> another client might have truncated the file or something.

If another node tries to truncate the file, that will require an 
exclusive glock, and in turn that means the all the other nodes will 
have to drop their glock(s) shared or exclusive. That process 
invalidates the page cache on those nodes, such that any further 
requests on those nodes will find the cache empty and have to call into 
the filesystem.

If a page is truncated on another node, then when the local node gives 
up its glock, after any copying (e.g. for read) has completed then the 
truncate will take place. The local node will then have to reread any 
data relating to new pages or return an error in case the next page to 
be read has vanished due to the truncate. It is a pretty small window, 
and the advantage is that in cases where the page is in cache, we can 
directly use the cached page without having to call into the filesystem 
at all. So it is page atomic in that sense.

The overall aim here is to avoid taking (potentially slow) cluster locks 
when at all possible, yet at the same time deliver close to local fs 
semantics whenever we can. You can think of GFS2's glock concept (at 
least as far as the inodes we are discussing here) as providing a 
combination of (page) cache control and cluster (dlm) locking.

>
> So you're ok with saying "the file used to be X bytes in size, so
> we'll just give you this data because we trust that the X is correct".
>
> But you're not ok to say "oh, the file used to be X bytes in size, but
> we don't want to give you a short read because it might not be correct
> any more".
>
> See the disconnect? You trust the size in one situation, but not in another one.

Well we are not trusting the size at all... the original algorithm 
worked entirely off "is this page in cache and uptodate?" and for 
exactly the reason that we know the size in the inode might be out of 
date, if we are not currently holding a glock in either shared or 
exclusive mode. We also know that if there is a page in cache and 
uptodate then we must be holding the glock too.


>
> I also don't really see that you *need* the new flag at all. Since
> you're doing to do a speculative read and then a real read anyway, and
> since the only thing that you seem to care about is the file size
> (because the *data* you will trust if it is cached), then why don't
> you just use the *existing* generic read, and *IFF* you get a
> truncated return value, then you go and double-check that the file
> hasn't changed in size?
>
> See what I'm saying? I think gfs2 is being very inconsistent in when
> it trusts the file size, and I don't see that you even need the new
> behavior that patch gives, because you might as well just use the
> existing code (just move the i_size check earlier, and then teach gfs2
> to double-check the "I didn't get as much as I expected" case).
>
>                   Linus

I'll leave the finer details to Andreas here, since it is his patch, and 
hopefully we can figure out a good path forward. We are perhaps also a 
bit reluctant to go off and (nearly) duplicate code that is already in 
the core vfs library functions, since that often leads to things getting 
out of sync (our implementation of ->writepages is one case where that 
happened in the past) and missing important bug fixes/features in some 
cases. Hopefully though we can iterate on this a bit and come up with 
something which will resolve all the issues,

Steve.


>

