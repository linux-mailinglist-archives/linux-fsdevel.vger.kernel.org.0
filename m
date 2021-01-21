Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A5D62FEFD1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Jan 2021 17:10:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730048AbhAUQIj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Jan 2021 11:08:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23957 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732237AbhAUQH4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Jan 2021 11:07:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611245190;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ghSQldHnSV4jEn/ZPu5R3O+xcFRIxfAiUKuyClRAeXw=;
        b=RNb/J0gh9x3WtGsuAUFFkjxbjD4drFAF0oEyZF10JhIQS0nzjgVcvDKP8V7MEzd8NXLblF
        x+J0GDHA2WxFwJAwUxha9ZqEmADEVl8Wn1XZKfsudgaI0Ayz7mI6Xg6ONHNmE5x/DZqTV1
        S+KbZvHc41orUcJ18x1hh4CYt10rPY4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-65-1PsCEpKXOM6q52LxuR5Vpg-1; Thu, 21 Jan 2021 11:06:23 -0500
X-MC-Unique: 1PsCEpKXOM6q52LxuR5Vpg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 747841005513;
        Thu, 21 Jan 2021 16:06:12 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AE6D861F55;
        Thu, 21 Jan 2021 16:06:11 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id 10LG6Bio019315;
        Thu, 21 Jan 2021 11:06:11 -0500
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id 10LG6A87019311;
        Thu, 21 Jan 2021 11:06:10 -0500
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Thu, 21 Jan 2021 11:06:10 -0500 (EST)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Matthew Wilcox <willy@infradead.org>
cc:     Jan Kara <jack@suse.cz>, Dave Chinner <david@fromorbit.com>,
        Zhongwei Cai <sunrise_l@sjtu.edu.cn>,
        "Theodore Ts'o" <tytso@mit.edu>,
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
In-Reply-To: <20210121154744.GQ2260413@casper.infradead.org>
Message-ID: <alpine.LRH.2.02.2101211101190.18413@file01.intranet.prod.int.rdu2.redhat.com>
References: <alpine.LRH.2.02.2101061245100.30542@file01.intranet.prod.int.rdu2.redhat.com> <20210107151125.GB5270@casper.infradead.org> <17045315-CC1F-4165-B8E3-BA55DD16D46B@gmail.com> <2041983017.5681521.1610459100858.JavaMail.zimbra@sjtu.edu.cn>
 <alpine.LRH.2.02.2101131008530.27448@file01.intranet.prod.int.rdu2.redhat.com> <1224425872.715547.1610703643424.JavaMail.zimbra@sjtu.edu.cn> <20210120044700.GA4626@dread.disaster.area> <20210120141834.GA24063@quack2.suse.cz>
 <alpine.LRH.2.02.2101200951070.24430@file01.intranet.prod.int.rdu2.redhat.com> <20210121154744.GQ2260413@casper.infradead.org>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On Thu, 21 Jan 2021, Matthew Wilcox wrote:

> On Wed, Jan 20, 2021 at 10:12:01AM -0500, Mikulas Patocka wrote:
> > Do you have some idea how to optimize the generic code that calls 
> > ->read_iter?
> 
> Yes.
> 
> > It might be better to maintain an f_iocb_flags in the
> > struct file and just copy that unconditionally.  We'd need to remember
> > to update it in fcntl(F_SETFL), but I think that's the only place.
> 
> Want to give that a try?

Yes - send me the patch and I'll benchmark it.

Mikulas

