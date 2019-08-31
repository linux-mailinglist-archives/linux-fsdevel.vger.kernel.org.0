Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A2F3A416B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Aug 2019 02:46:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728358AbfHaAqC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Aug 2019 20:46:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37214 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728279AbfHaAqC (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Aug 2019 20:46:02 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 816D2308404E;
        Sat, 31 Aug 2019 00:46:02 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-255.rdu2.redhat.com [10.10.120.255])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EF4A860BF7;
        Sat, 31 Aug 2019 00:45:57 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20190830165920.GA28182@lst.de>
References: <20190830165920.GA28182@lst.de> <20190829071312.GE11909@lst.de> <20190820115731.bed7gwfygk66nj43@pegasus.maiolino.io> <20190808082744.31405-1-cmaiolino@redhat.com> <20190808082744.31405-3-cmaiolino@redhat.com> <20190814111535.GC1885@lst.de> <7003.1566305430@warthog.procyon.org.uk> <2587.1567181871@warthog.procyon.org.uk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     dhowells@redhat.com, Carlos Maiolino <cmaiolino@redhat.com>,
        linux-fsdevel@vger.kernel.org, adilger@dilger.ca,
        jaegeuk@kernel.org, darrick.wong@oracle.com, miklos@szeredi.hu,
        rpeterso@redhat.com, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 2/9] cachefiles: drop direct usage of ->bmap method.
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <28401.1567212357.1@warthog.procyon.org.uk>
Date:   Sat, 31 Aug 2019 01:45:57 +0100
Message-ID: <28402.1567212357@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Sat, 31 Aug 2019 00:46:02 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Christoph Hellwig <hch@lst.de> wrote:

> We'll you'd need to implement a IOCB_NOHOLE, but that wouldn't be all
> that hard.  Having a READ_PLUS like interface that actually tells you
> how large the hole is might be hard.

Actually, that raises another couple of questions:

 (1) Is a filesystem allowed to join up two disjoint blocks of data with a
     block of zeros to make a single extent?  If this happens, I'll see the
     inserted block of zeros to be valid data.

 (2) Is a filesystem allowed to punch out a block of valid zero data to make a
     hole?  This would cause me to refetch the data.

David
