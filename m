Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 11F5F11C67B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2019 08:35:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728158AbfLLHeg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Dec 2019 02:34:36 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:47389 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728133AbfLLHee (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Dec 2019 02:34:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576136073;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QcotRZOg8cVYsqL5GLsgP8ixI9kdR95Q2W4XEWIcwA4=;
        b=FadP9GPEhm/EYxZySOIyhBMHnzfufJdHIvS3nCljWZx0aRefR+lkR8RJBm5HJeuAnbFAaE
        sDIN4EbymvXShHzznUHwie194Y1F8mb8z92EfciYmTrmsbLS1wSPiyC8+f0Wsa1Zq5lbCX
        H/rkFiFRtLLpimqXc+ho/C7mDz8qFDA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-10-4Wt3wXf3P0GGIDpB7LgN2g-1; Thu, 12 Dec 2019 02:34:30 -0500
X-MC-Unique: 4Wt3wXf3P0GGIDpB7LgN2g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 148EB107ACC7;
        Thu, 12 Dec 2019 07:34:28 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-52.rdu2.redhat.com [10.10.120.52])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1352D6013D;
        Thu, 12 Dec 2019 07:34:25 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CAHk-=wgVpV-O4zeO+xOMcOUyKZi+1kg+6Kmi-P7SUx-ydZm5Og@mail.gmail.com>
References: <CAHk-=wgVpV-O4zeO+xOMcOUyKZi+1kg+6Kmi-P7SUx-ydZm5Og@mail.gmail.com> <157558502272.10278.8718685637610645781.stgit@warthog.procyon.org.uk> <20191206135604.GB2734@twin.jikos.cz> <CAHk-=wiN_pWbcRaw5L-J2EFUyCn49Due0McwETKwmFFPp88K8Q@mail.gmail.com> <CAHk-=wjvO1V912ya=1rdXwrm1OBTi6GqnqryH_E8OR69cZuVOg@mail.gmail.com> <CAHk-=wizsHmCwUAyQKdU7hBPXHYQn-fOtJKBqMs-79br2pWxeQ@mail.gmail.com> <CAHk-=wjeG0q1vgzu4iJhW5juPkTsjTYmiqiMUYAebWW+0bam6w@mail.gmail.com> <9417.1576097731@warthog.procyon.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dhowells@redhat.com, David Sterba <dsterba@suse.cz>,
        Eric Biggers <ebiggers@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH 0/2] pipe: Fixes [ver #2]
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1416.1576136065.1@warthog.procyon.org.uk>
Date:   Thu, 12 Dec 2019 07:34:25 +0000
Message-ID: <1417.1576136065@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> wrote:

> You are sure you won't want that for the notification queue cases? I
> guess they'll never want to "sync" part..

Actually, that's a good point, I do call it in post_one_notification() since I
have to hold the lock anyway.  But, as you say, I'm not sure whether I need
the sync variant.

David

