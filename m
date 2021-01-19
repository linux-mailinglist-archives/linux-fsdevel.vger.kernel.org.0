Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E2172FC454
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Jan 2021 00:01:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbhASXAn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Jan 2021 18:00:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32221 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2404051AbhASOTe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Jan 2021 09:19:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611065887;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2ycJhE8mXTZkoJTspQiF4eAdjjIOqaHJTzxw51QUBpw=;
        b=iH91giBXcrvLWkxZafRwzhtnAaqC4UgOyL2/svKS5JpqN4aXD9uZoHjHC1ghixJvzFQFwB
        wLFBArEfZwc4Z7vEzAYFoEYWqEGfkJemKwWQ+7hEoy/NTkYb2K/87UEluBwNSQI9TmihSg
        YrK+WSWmMbUsVGj8AVkkO22Ba2gkMuA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-504-Na2rrFESP2-59Jhvxs6BgA-1; Tue, 19 Jan 2021 09:14:34 -0500
X-MC-Unique: Na2rrFESP2-59Jhvxs6BgA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B9A58806661;
        Tue, 19 Jan 2021 14:14:29 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2AA0D19C47;
        Tue, 19 Jan 2021 14:14:23 +0000 (UTC)
Date:   Tue, 19 Jan 2021 09:14:22 -0500
From:   Mike Snitzer <snitzer@redhat.com>
To:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Cc:     linux-block@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        drbd-dev@lists.linbit.com, linux-bcache@vger.kernel.org,
        linux-raid@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        cluster-devel@redhat.com, jfs-discussion@lists.sourceforge.net,
        dm-devel@redhat.com, axboe@kernel.dk, philipp.reisner@linbit.com,
        lars.ellenberg@linbit.com, efremov@linux.com, colyli@suse.de,
        kent.overstreet@gmail.com, agk@redhat.com, song@kernel.org,
        hch@lst.de, sagi@grimberg.me, martin.petersen@oracle.com,
        viro@zeniv.linux.org.uk, clm@fb.com, josef@toxicpanda.com,
        dsterba@suse.com, tytso@mit.edu, adilger.kernel@dilger.ca,
        rpeterso@redhat.com, agruenba@redhat.com, darrick.wong@oracle.com,
        shaggy@kernel.org, damien.lemoal@wdc.com, naohiro.aota@wdc.com,
        jth@kernel.org, tj@kernel.org, osandov@fb.com, bvanassche@acm.org,
        gustavo@embeddedor.com, asml.silence@gmail.com,
        jefflexu@linux.alibaba.com
Subject: Re: [RFC PATCH 00/37] block: introduce bio_init_fields()
Message-ID: <20210119141422.GA23758@redhat.com>
References: <20210119050631.57073-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210119050631.57073-1-chaitanya.kulkarni@wdc.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 19 2021 at 12:05am -0500,
Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com> wrote:

> Hi,
> 
> This is a *compile only RFC* which adds a generic helper to initialize
> the various fields of the bio that is repeated all the places in
> file-systems, block layer, and drivers.
> 
> The new helper allows callers to initialize various members such as
> bdev, sector, private, end io callback, io priority, and write hints.
> 
> The objective of this RFC is to only start a discussion, this it not 
> completely tested at all.                                                                                                            
> Following diff shows code level benefits of this helper :-
>  38 files changed, 124 insertions(+), 236 deletions(-)


Please no... this is just obfuscation.

Adding yet another field to set would create a cascade of churn
throughout kernel (and invariably many callers won't need the new field
initialized, so you keep passing 0 for more and more fields).

Nacked-by: Mike Snitzer <snitzer@redhat.com>

