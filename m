Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 541902F504E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Jan 2021 17:47:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727782AbhAMQqF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Jan 2021 11:46:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:57449 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727777AbhAMQqF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Jan 2021 11:46:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610556279;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=B2nZaowcmYpAm6+Q7xTb3SoumDbJkYtkPecNpTcfdqc=;
        b=gvmR8F0EbASo0nL0dV8lZ1GlhFmyJlkBeGGMQffQY7SY/sauHd0Ofyh1Pge1YL3vchdVmY
        fs6YYNA9X5Rxl3krfkKAd9u5R/ITRkqRaExL3QpNQfSTeVXHixtErfW2ZP739RYzZyvBiI
        4VPiU4tJmeBHnXHlINjuGaRhXOOdzYM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-208-n2t6kthuPH2jhsKcw9bewQ-1; Wed, 13 Jan 2021 11:44:35 -0500
X-MC-Unique: n2t6kthuPH2jhsKcw9bewQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0654A806660;
        Wed, 13 Jan 2021 16:44:33 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C7E0C6062F;
        Wed, 13 Jan 2021 16:44:32 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id 10DGiWGW005756;
        Wed, 13 Jan 2021 11:44:32 -0500
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id 10DGiUmf005752;
        Wed, 13 Jan 2021 11:44:31 -0500
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Wed, 13 Jan 2021 11:44:30 -0500 (EST)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Zhongwei Cai <sunrise_l@sjtu.edu.cn>
cc:     Mingkai Dong <mingkaidong@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jan Kara <jack@suse.cz>,
        Steven Whitehouse <swhiteho@redhat.com>,
        Eric Sandeen <esandeen@redhat.com>,
        Dave Chinner <dchinner@redhat.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Wang Jianchao <jianchao.wan9@gmail.com>,
        "Tadakamadla, Rajesh" <rajesh.tadakamadla@hpe.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-nvdimm@lists.01.org
Subject: Re: Expense of read_iter
In-Reply-To: <2041983017.5681521.1610459100858.JavaMail.zimbra@sjtu.edu.cn>
Message-ID: <alpine.LRH.2.02.2101131008530.27448@file01.intranet.prod.int.rdu2.redhat.com>
References: <alpine.LRH.2.02.2101061245100.30542@file01.intranet.prod.int.rdu2.redhat.com> <20210107151125.GB5270@casper.infradead.org> <17045315-CC1F-4165-B8E3-BA55DD16D46B@gmail.com> <2041983017.5681521.1610459100858.JavaMail.zimbra@sjtu.edu.cn>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On Tue, 12 Jan 2021, Zhongwei Cai wrote:

> 
> I'm working with Mingkai on optimizations for Ext4-dax.

What specific patch are you working on? Please, post it somewhere.

> We think that optmizing the read-iter method cannot achieve the
> same performance as the read method for Ext4-dax. 
> We tried Mikulas's benchmark on Ext4-dax. The overall time and perf
> results are listed below:
> 
> Overall time of 2^26 4KB read.
> 
> Method       Time
> read         26.782s
> read-iter    36.477s

What happens if you use this trick ( https://lkml.org/lkml/2021/1/11/1612 )
- detect in the "read_iter" method that there is just one segment and 
treat it like a "read" method. I think that it should improve performance 
for your case.

Mikulas

