Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBB852FD3A6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Jan 2021 16:15:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389903AbhATPOa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Jan 2021 10:14:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:24745 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390642AbhATPNg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Jan 2021 10:13:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611155530;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=m0WX/IW9qTI7pWygS2OV9t8yQ+iugqSZyKKAWy8i8Ng=;
        b=LglTVpRC/1kMWL8D0GxEMi88e62kV1LijsabXZ/58WW8nJ76dToeLP4xkR5MpBn9dyuuTf
        7/Ey65RUJRx6rJrqLSvg9e6pF1+BbiMlDsrrJj+rEC7Ht3RYJ09Mfqvuchq40y1AnY8Gij
        96Zrrq37aWv+Za0BS7S6+d0palFmHKc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-212-i0lmVuOrNH2l7F-G-gW3wA-1; Wed, 20 Jan 2021 10:12:08 -0500
X-MC-Unique: i0lmVuOrNH2l7F-G-gW3wA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3DE2D8066E5;
        Wed, 20 Jan 2021 15:12:05 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 926EA608BA;
        Wed, 20 Jan 2021 15:12:04 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id 10KFC4DG027528;
        Wed, 20 Jan 2021 10:12:04 -0500
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id 10KFC1Sq027524;
        Wed, 20 Jan 2021 10:12:01 -0500
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Wed, 20 Jan 2021 10:12:01 -0500 (EST)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Jan Kara <jack@suse.cz>
cc:     Dave Chinner <david@fromorbit.com>,
        Zhongwei Cai <sunrise_l@sjtu.edu.cn>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Matthew Wilcox <willy@infradead.org>,
        David Laight <David.Laight@aculab.com>,
        Mingkai Dong <mingkaidong@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Whitehouse <swhiteho@redhat.com>,
        Eric Sandeen <esandeen@redhat.com>,
        Dave Chinner <dchinner@redhat.com>,
        Wang Jianchao <jianchao.wan9@gmail.com>,
        Rajesh Tadakamadla <rajesh.tadakamadla@hpe.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>
Subject: Re: Expense of read_iter
In-Reply-To: <20210120141834.GA24063@quack2.suse.cz>
Message-ID: <alpine.LRH.2.02.2101200951070.24430@file01.intranet.prod.int.rdu2.redhat.com>
References: <alpine.LRH.2.02.2101061245100.30542@file01.intranet.prod.int.rdu2.redhat.com> <20210107151125.GB5270@casper.infradead.org> <17045315-CC1F-4165-B8E3-BA55DD16D46B@gmail.com> <2041983017.5681521.1610459100858.JavaMail.zimbra@sjtu.edu.cn>
 <alpine.LRH.2.02.2101131008530.27448@file01.intranet.prod.int.rdu2.redhat.com> <1224425872.715547.1610703643424.JavaMail.zimbra@sjtu.edu.cn> <20210120044700.GA4626@dread.disaster.area> <20210120141834.GA24063@quack2.suse.cz>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On Wed, 20 Jan 2021, Jan Kara wrote:

> Yeah, I agree. I'm against ext4 private solution for this read problem. And
> I'm also against duplicating ->read_iter functionatily in ->read handler.
> The maintenance burden of this code duplication is IMHO just too big. We
> rather need to improve the generic code so that the fast path is faster.
> And every filesystem will benefit because this is not ext4 specific
> problem.
> 
> 								Honza

Do you have some idea how to optimize the generic code that calls 
->read_iter?

vfs_read calls ->read if it is present. If not, it calls new_sync_read. 
new_sync_read's frame size is 128 bytes - it holds the structures iovec, 
kiocb and iov_iter. new_sync_read calls ->read_iter.

I have found out that the cost of calling new_sync_read is 3.3%, Zhongwei 
found out 3.9%. (the benchmark repeatedy reads the same 4k page)

I don't see any way how to optimize new_sync_read or how to reduce its 
frame size. Do you?

Mikulas

