Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDA112778AE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Sep 2020 20:47:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728727AbgIXSr5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Sep 2020 14:47:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59442 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728707AbgIXSr5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Sep 2020 14:47:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600973276;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Qevhx+mKfF351kyzXMJzLK28uMAwbH6ptXHpGeBndNM=;
        b=BUhqwnRRCHltiitirCdzrzPBVIbZVJHnHX6cqnQbCullc5NRkw4kqpzAU8WPXFPo8y2H3b
        2jpMvpnoq/dtE1GCdAxSyo48Oe2iIY3DdyFSKNrFESPQkeb/5QCf16kYQEkqGj5vfys/u9
        FRTF7r0T1rWc4Xt7al5D53u/EVPJ+/o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-505-J0C0jdFUOn6GGTo368u4aA-1; Thu, 24 Sep 2020 14:47:52 -0400
X-MC-Unique: J0C0jdFUOn6GGTo368u4aA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4BE1E80B727;
        Thu, 24 Sep 2020 18:47:51 +0000 (UTC)
Received: from ovpn-66-196.rdu2.redhat.com (unknown [10.10.67.196])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 719AA73684;
        Thu, 24 Sep 2020 18:47:50 +0000 (UTC)
Message-ID: <f623da731d7c2e96e3a37b091d0ec99095a6386b.camel@redhat.com>
Subject: Re: [PATCH] iomap: Set all uptodate bits for an Uptodate page
From:   Qian Cai <cai@redhat.com>
To:     sedat.dilek@gmail.com, Matthew Wilcox <willy@infradead.org>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@infradead.org>,
        Brian Foster <bfoster@redhat.com>
Date:   Thu, 24 Sep 2020 14:47:49 -0400
In-Reply-To: <CA+icZUUgwcLP8O9oDdUMT0SzEQHjn+LkFFkPL3NsLCBhDRSyGw@mail.gmail.com>
References: <20200924125608.31231-1-willy@infradead.org>
         <CA+icZUUQGmd3juNPv1sHTWdhzXwZzRv=p1i+Q=20z_WGcZOzbg@mail.gmail.com>
         <20200924151538.GW32101@casper.infradead.org>
         <CA+icZUX4bQf+pYsnOR0gHZLsX3NriL=617=RU0usDfx=idgZmA@mail.gmail.com>
         <20200924152755.GY32101@casper.infradead.org>
         <CA+icZUURRcCh1TYtLs=U_353bhv5_JhVFaGxVPL5Rydee0P1=Q@mail.gmail.com>
         <20200924163635.GZ32101@casper.infradead.org>
         <CA+icZUUgwcLP8O9oDdUMT0SzEQHjn+LkFFkPL3NsLCBhDRSyGw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 2020-09-24 at 20:27 +0200, Sedat Dilek wrote:
> I run both linux-kernel on my Debian/unstable AMD64 host (means not in
> a VM) with and without your patch.
> 
> Instructions:
> cd /opt/ltp
> ./runltp -f syscalls -s preadv203
> 
> Unfortunately, the logs in the "results" directory have only the short
> summary.
> 
> Testcase                                           Result     Exit Value
> --------                                           ------     ----------
> preadv203                                          PASS       0
> preadv203_64                                       PASS       0
> 
> So, I guess I am not hitting the issue?
> Or do I miss some important kernel-config?

https://gitlab.com/cailca/linux-mm/-/blob/master/arm64.config

That is .config I used to reproduce. Then, I ran the linux-mm testsuite (lots of
hard-coded places because I only need to run this on RHEL8) first:

# git clone https://gitlab.com/cailca/linux-mm
# cd linux-mm; make
# ./random -k

Then, run the whole LTP syscalls:
# ./runltp -f syscalls

If that is still not triggered, it needs some syscall fuzzing:
# ./random -x 0-100 -f




