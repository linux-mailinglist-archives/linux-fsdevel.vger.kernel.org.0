Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A238108C4C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2019 11:53:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727450AbfKYKxH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Nov 2019 05:53:07 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:44313 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727316AbfKYKxG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Nov 2019 05:53:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574679185;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bi5re4//WovKGOVUOVay0aFuM2RKiYZ7dV+O0Ky8THo=;
        b=R+E3W5GDPHz17cQ1ah1nAJsec49W7h3jY4Vo0VNcq/LjzyMlrUVOMtSsG+Xkxzj8ORnzpB
        GozzQhDKisvox0J6lVtwVLw+cAvOSvRQssekZgs1kxdoJ2bpT9LpJ7jAZzZ45CW1Pi7nsa
        7P2YvlF3MTbNXdaARenQEUmDvRlAzO4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-333-8LXIc6n-MC-1gWmJ8rxzMw-1; Mon, 25 Nov 2019 05:53:04 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C5BB21083E83;
        Mon, 25 Nov 2019 10:53:00 +0000 (UTC)
Received: from fogou.chygwyn.com (unknown [10.33.36.46])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 76A7360863;
        Mon, 25 Nov 2019 10:52:53 +0000 (UTC)
Subject: Re: [PATCH] mm/filemap: do not allocate cache pages beyond end of
 file at read
To:     =?UTF-8?Q?Andreas_Gr=c3=bcnbacher?= <andreas.gruenbacher@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
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
From:   Steven Whitehouse <swhiteho@redhat.com>
Message-ID: <22f04f02-86e4-b379-81c8-08c002a648f0@redhat.com>
Date:   Mon, 25 Nov 2019 10:52:51 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <CAHpGcM+o2OwXdrj+A2_OqRg6YokfauFNiBJF-BQp0dJFvq_BrQ@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: 8LXIc6n-MC-1gWmJ8rxzMw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

On 22/11/2019 23:59, Andreas Gr=C3=BCnbacher wrote:
> Hi,
>
> Am Do., 31. Okt. 2019 um 12:43 Uhr schrieb Steven Whitehouse
> <swhiteho@redhat.com>:
>> Andreas, Bob, have I missed anything here?
> I've looked into this a bit, and it seems that there's a reasonable
> way to get rid of the lock taking in ->readpage and ->readpages
> without a lot of code duplication. My proposal for that consists of
> multiple patches, so I've posted it separately:
>
> https://lore.kernel.org/linux-fsdevel/20191122235324.17245-1-agruenba@red=
hat.com/T/#t
>
> Thanks,
> Andreas
>
Andreas, thanks for taking a look at this.

Linus, is that roughly what you were thinking of?

Ronnie, Steve, can the same approach perhaps work for CIFS?

Steve.




