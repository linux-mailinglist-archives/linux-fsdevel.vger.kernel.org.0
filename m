Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D4AA2427CF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Aug 2020 11:43:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727048AbgHLJnx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Aug 2020 05:43:53 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:51459 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727017AbgHLJnx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Aug 2020 05:43:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597225431;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OdzUOSJMEbqrLIXBeiGU3Aa/BNw7IZScNhKdcrSD0Jw=;
        b=MvAgy4OJZt4+1W3P50zRujnQtyNLV7VOKeMN8fgc5qVJFw2q2+znW9Odxt2CGuJGBQKE7B
        QPkVU7ovwZX8qdZ3CZeluTgSeTKVmlQKNvt7Wgk4/0uhwNKerWu3AGi/pNWgAZmiKkVsOt
        ROOzX2i1p+HG6HhuuhtQ85jXcwawgdw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-139-ws1TaZzyOwGDwINq-6ki_Q-1; Wed, 12 Aug 2020 05:43:50 -0400
X-MC-Unique: ws1TaZzyOwGDwINq-6ki_Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4387279ED6;
        Wed, 12 Aug 2020 09:43:48 +0000 (UTC)
Received: from fogou.chygwyn.com (unknown [10.33.36.12])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7BCF019D7B;
        Wed, 12 Aug 2020 09:43:33 +0000 (UTC)
Subject: Re: file metadata via fs API
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Karel Zak <kzak@redhat.com>,
        Jeff Layton <jlayton@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Christian Brauner <christian@brauner.io>,
        Lennart Poettering <lennart@poettering.net>,
        Linux API <linux-api@vger.kernel.org>,
        Ian Kent <raven@themaw.net>,
        LSM <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1842689.1596468469@warthog.procyon.org.uk>
 <1845353.1596469795@warthog.procyon.org.uk>
 <CAJfpegunY3fuxh486x9ysKtXbhTE0745ZCVHcaqs9Gww9RV2CQ@mail.gmail.com>
 <ac1f5e3406abc0af4cd08d818fe920a202a67586.camel@themaw.net>
 <CAJfpegu8omNZ613tLgUY7ukLV131tt7owR+JJ346Kombt79N0A@mail.gmail.com>
 <CAJfpegtNP8rQSS4Z14Ja4x-TOnejdhDRTsmmDD-Cccy2pkfVVw@mail.gmail.com>
 <20200811135419.GA1263716@miu.piliscsaba.redhat.com>
 <CAHk-=wjzLmMRf=QG-n+1HnxWCx4KTQn9+OhVvUSJ=ZCQd6Y1WA@mail.gmail.com>
 <52483.1597190733@warthog.procyon.org.uk>
 <CAJfpegt=cQ159kEH9zCYVHV7R_08jwMxF0jKrSUV5E=uBg4Lzw@mail.gmail.com>
 <98802.1597220949@warthog.procyon.org.uk>
 <CAJfpegsVJo9e=pHf3YGWkE16fT0QaNGhgkUdq4KUQypXaD=OgQ@mail.gmail.com>
From:   Steven Whitehouse <swhiteho@redhat.com>
Message-ID: <d2d179c7-9b60-ca1a-0c9f-d308fc7af5ce@redhat.com>
Date:   Wed, 12 Aug 2020 10:43:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CAJfpegsVJo9e=pHf3YGWkE16fT0QaNGhgkUdq4KUQypXaD=OgQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

On 12/08/2020 09:37, Miklos Szeredi wrote:
[snip]
>
> b) The awarded performance boost is not warranted for the use cases it
> is designed for.
>
> Thanks,
> Miklos
>

This is a key point. One of the main drivers for this work is the 
efficiency improvement for large numbers of mounts. Ian and Karel have 
already provided performance measurements showing a significant benefit 
compared with what we have today. If you want to propose this 
alternative interface then you need to show that it can sustain similar 
levels of performance, otherwise it doesn't solve the problem. So 
performance numbers here would be helpful.

Also - I may have missed this earlier in the discussion, what are the 
atomicity guarantees with this proposal? This is the other key point for 
the API, so it would be good to see that clearly stated (i.e. how does 
one use it in combination with the notifications to provide an up to 
date, consistent view of the kernel's mounts)

Steve.


