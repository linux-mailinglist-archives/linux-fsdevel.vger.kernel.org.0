Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED42995F2B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2019 14:50:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729351AbfHTMug convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Aug 2019 08:50:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41278 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728657AbfHTMug (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Aug 2019 08:50:36 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 29079307C947;
        Tue, 20 Aug 2019 12:50:36 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-255.rdu2.redhat.com [10.10.120.255])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5538510016E9;
        Tue, 20 Aug 2019 12:50:31 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20190820115731.bed7gwfygk66nj43@pegasus.maiolino.io>
References: <20190820115731.bed7gwfygk66nj43@pegasus.maiolino.io> <20190808082744.31405-1-cmaiolino@redhat.com> <20190808082744.31405-3-cmaiolino@redhat.com> <20190814111535.GC1885@lst.de>
To:     Carlos Maiolino <cmaiolino@redhat.com>
Cc:     dhowells@redhat.com, Christoph Hellwig <hch@lst.de>,
        linux-fsdevel@vger.kernel.org, adilger@dilger.ca,
        jaegeuk@kernel.org, darrick.wong@oracle.com, miklos@szeredi.hu,
        rpeterso@redhat.com, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 2/9] cachefiles: drop direct usage of ->bmap method.
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7002.1566305430.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: 8BIT
Date:   Tue, 20 Aug 2019 13:50:30 +0100
Message-ID: <7003.1566305430@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Tue, 20 Aug 2019 12:50:36 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Carlos Maiolino <cmaiolino@redhat.com> wrote:

> > > +	block = page->index;
> > > +	block <<= shift;
> > 
> > Can't this cause overflows?
> 
> Hmm, I honestly don't know. I did look at the code, and I couldn't really spot
> anything concrete.

Maybe, though we'd have to support file sizes over 16 Exabytes for that to be
a problem.

Note that bmap() is *only* used to find out if the page is present in the
cache - and even that I'm not actually doing very well, since I really *ought*
to check every block in the page.

I really want to replace the use of bmap entirely with iov_iter doing DIO.
Cachefiles currently does double buffering because it works through the
pagecache of the underlying to do actual read or write - and this appears to
cause memory management problems.

David
