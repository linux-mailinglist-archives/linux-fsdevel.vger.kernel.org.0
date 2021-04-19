Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB297364212
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Apr 2021 14:52:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239230AbhDSMxS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Apr 2021 08:53:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55022 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239228AbhDSMxP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Apr 2021 08:53:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618836765;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cMIsYl9JvtnAIFAwpGAulW8Mqzm/WRykKCV3iabQuYA=;
        b=KyU4oWEzR4O0oxn2hgjrFGB+nRGcIiDlSi0/eOg3BiIcuKXRbU8QnrPjusgRpMc9j6P/20
        Ge8vQJB5cppp+b+bLRZ7vi/GvUyeLGRYUWdb9aAGgDawNUzed+vUliiOSTnxx6S4/f+POM
        OmxxrMhhDCGaK+TmTFL3eXotNCC8Dgg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-353-XHAJf3tbOJG7OvIp5qe1Ig-1; Mon, 19 Apr 2021 08:52:41 -0400
X-MC-Unique: XHAJf3tbOJG7OvIp5qe1Ig-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C96011922025;
        Mon, 19 Apr 2021 12:52:39 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0717A10016F4;
        Mon, 19 Apr 2021 12:52:32 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id 13JCqW6V010975;
        Mon, 19 Apr 2021 08:52:32 -0400
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id 13JCqVuW010967;
        Mon, 19 Apr 2021 08:52:31 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Mon, 19 Apr 2021 08:52:31 -0400 (EDT)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Damien Le Moal <damien.lemoal@wdc.com>
cc:     dm-devel@redhat.com, Mike Snitzer <snitzer@redhat.com>,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-fsdevel@vger.kernel.org,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [dm-devel] [PATCH v2 0/3] Fix dm-crypt zoned block device
 support
In-Reply-To: <20210417023323.852530-1-damien.lemoal@wdc.com>
Message-ID: <alpine.LRH.2.02.2104190840310.9677@file01.intranet.prod.int.rdu2.redhat.com>
References: <20210417023323.852530-1-damien.lemoal@wdc.com>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On Sat, 17 Apr 2021, Damien Le Moal wrote:

> Mike,
> 
> Zone append BIOs (REQ_OP_ZONE_APPEND) always specify the start sector
> of the zone to be written instead of the actual location sector to
> write. The write location is determined by the device and returned to
> the host upon completion of the operation.

I'd like to ask what's the reason for this semantics? Why can't users of 
the zoned device supply real sector numbers?

> This interface, while simple and efficient for writing into sequential
> zones of a zoned block device, is incompatible with the use of sector
> values to calculate a cypher block IV. All data written in a zone is
> encrypted using an IV calculated from the first sectors of the zone,
> but read operation will specify any sector within the zone, resulting
> in an IV mismatch between encryption and decryption. Reads fail in that
> case.

I would say that it is incompatible with all dm targets - even the linear 
target is changing the sector number and so it may redirect the write 
outside of the range specified in dm-table and cause corruption.

Instead of complicating device mapper with imperfect support, I would just 
disable REQ_OP_ZONE_APPEND on device mapper at all.

Mikulas

