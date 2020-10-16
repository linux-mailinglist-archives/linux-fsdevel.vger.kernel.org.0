Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E0AE290B3B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Oct 2020 20:19:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391426AbgJPSTQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Oct 2020 14:19:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:32657 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391238AbgJPSTQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Oct 2020 14:19:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602872354;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PNcTYASBUK76y4R0AHU+hFUZ+jRwiMVZ47LoAmlhGsI=;
        b=eMf2HngXru+VPbmjsIipMZbYebTwZCMq2aG+gN4HFIcXhsasxKpj87vSYkAcWs70Jti4S+
        VmMBvRHxojgV2MJpsD0j+m2Nywt68oM2XEL7tn9W+y/z/4aI3+AP6W6fz0TR3o0JD8ZjMQ
        jRntZM7HF7ouvl0a99QXBIFuNdicP84=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-578-5fJoCHmJMzStAuTrYKDbWA-1; Fri, 16 Oct 2020 14:19:12 -0400
X-MC-Unique: 5fJoCHmJMzStAuTrYKDbWA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4A952186DD27;
        Fri, 16 Oct 2020 18:19:10 +0000 (UTC)
Received: from horse.redhat.com (ovpn-112-72.rdu2.redhat.com [10.10.112.72])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 168DE55774;
        Fri, 16 Oct 2020 18:19:09 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 9DB1422030D; Fri, 16 Oct 2020 14:19:08 -0400 (EDT)
Date:   Fri, 16 Oct 2020 14:19:08 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Miklos Szeredi <miklos@szeredi.hu>, Qian Cai <cai@lca.pw>,
        Hugh Dickins <hughd@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Amir Goldstein <amir73il@gmail.com>
Subject: Re: Possible deadlock in fuse write path (Was: Re: [PATCH 0/4] Some
 more lock_page work..)
Message-ID: <20201016181908.GA282856@redhat.com>
References: <CAHk-=wgkD+sVx3cHAAzhVO5orgksY=7i8q6mbzwBjN0+4XTAUw@mail.gmail.com>
 <4794a3fa3742a5e84fb0f934944204b55730829b.camel@lca.pw>
 <CAHk-=wh9Eu-gNHzqgfvUAAiO=vJ+pWnzxkv+tX55xhGPFy+cOw@mail.gmail.com>
 <20201015151606.GA226448@redhat.com>
 <20201015195526.GC226448@redhat.com>
 <CAHk-=wj0vjx0jzaq5Gha-SmDKc3Hnog5LKX0eJZkudBvEQFAUA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wj0vjx0jzaq5Gha-SmDKc3Hnog5LKX0eJZkudBvEQFAUA@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 15, 2020 at 02:21:58PM -0700, Linus Torvalds wrote:

[..]
> 
> I don't know why fuse does multiple pages to begin with. Why can't it
> do whatever it does just one page at a time?

Sending multiple pages in single WRITE command does seem to help a lot
with performance. I modified code to write only one page at a time
and ran a fio job with sequential writes(and random writes),
block size 64K and compared the performance on virtiofs.

NAME                    WORKLOAD                Bandwidth       IOPS
one-page-write          seqwrite-psync          58.3mb          933
multi-page-write        seqwrite-psync          265.7mb         4251

one-page-write          randwrite-psync         53.5mb          856
multi-page-write        randwrite-psync         315.5mb         5047

So with multi page writes performance seems much better for this
particular workload.

Thanks
Vivek

