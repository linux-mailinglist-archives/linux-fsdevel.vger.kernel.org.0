Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48639A3BC6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2019 18:17:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727938AbfH3QR5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Aug 2019 12:17:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46336 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727135AbfH3QR4 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Aug 2019 12:17:56 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 706A1A36EE1;
        Fri, 30 Aug 2019 16:17:56 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-255.rdu2.redhat.com [10.10.120.255])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 593541001284;
        Fri, 30 Aug 2019 16:17:52 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20190829071312.GE11909@lst.de>
References: <20190829071312.GE11909@lst.de> <20190820115731.bed7gwfygk66nj43@pegasus.maiolino.io> <20190808082744.31405-1-cmaiolino@redhat.com> <20190808082744.31405-3-cmaiolino@redhat.com> <20190814111535.GC1885@lst.de> <7003.1566305430@warthog.procyon.org.uk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     dhowells@redhat.com, Carlos Maiolino <cmaiolino@redhat.com>,
        linux-fsdevel@vger.kernel.org, adilger@dilger.ca,
        jaegeuk@kernel.org, darrick.wong@oracle.com, miklos@szeredi.hu,
        rpeterso@redhat.com, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 2/9] cachefiles: drop direct usage of ->bmap method.
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2585.1567181871.1@warthog.procyon.org.uk>
Date:   Fri, 30 Aug 2019 17:17:51 +0100
Message-ID: <2587.1567181871@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.68]); Fri, 30 Aug 2019 16:17:56 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Christoph Hellwig <hch@lst.de> wrote:

> Not related to this patch, but using iov_iter with dio is trivial, what
> is the blocker therere?

The usual: time.

The change as a whole is not actually trivial since it will involve completely
overhauling the fscache data API and how the filesystems use it - and then
having cachefiles perform the DIO asynchronously as per Trond's requirements
for using fscache with NFS.

I also need to work out how I'm going to do data/hole detection.  Can I set,
say, O_NOREADHOLE and then expect the DIO to stop early with a short read?  Or
do I need to use SEEK_DATA/SEEK_HOLE in advance to define the occupied
regions?

Maybe a better way would be to take a leaf out of the book of OpenAFS and
suchlike and keep a parallel file that tracks the occupancy of a cache object
(eg. a bitmap with 1 bit per 64k block) - but that the synchronisation and
performance issues.

David
