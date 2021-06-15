Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62E933A7924
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jun 2021 10:37:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231161AbhFOIj0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Jun 2021 04:39:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26411 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230502AbhFOIj0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Jun 2021 04:39:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623746242;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=baAmkgM+AWGY356VSVgLvgws69TxGo9QZingMrfUCr8=;
        b=TfUCZslAomH+lBNByBvMU9HjZzJvUC5IkpET75ZbCgsMufMbH8mXLMZtg29CfCHiFY2qYk
        YNpcwpFMfOkYnV7LKiGy1FT0nZrlCVQ712/uFLZOLTsxmN1+AxIgLYNClH6anEqXlVPCdt
        DpojrIfRkz6+LVHs/8CtjVKBDOvVO0k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-361-4JEmupRkNnC2Vw9NDkZ6qg-1; Tue, 15 Jun 2021 04:37:20 -0400
X-MC-Unique: 4JEmupRkNnC2Vw9NDkZ6qg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8F746107ACF6;
        Tue, 15 Jun 2021 08:37:19 +0000 (UTC)
Received: from T590 (ovpn-12-39.pek2.redhat.com [10.72.12.39])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B40F85D6DC;
        Tue, 15 Jun 2021 08:37:13 +0000 (UTC)
Date:   Tue, 15 Jun 2021 16:37:09 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Qu Wenruo <wqu@suse.de>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>
Subject: Re: About `bio->bi_iter.bi_size` at write endio time
Message-ID: <YMhmtd8doc9g23cT@T590>
References: <18cbcd0b-8c49-00b8-558b-5d74b3664b85@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <18cbcd0b-8c49-00b8-558b-5d74b3664b85@suse.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 15, 2021 at 03:22:59PM +0800, Qu Wenruo wrote:
> Hi,
> 
> Recently I got a strange case where for write bio, at its endio time, I got
> bio->bi_iter.bi_size == 0, but bio_for_each_segment_all() reports we still
> have some bv_len.

It is normal to observe zero .bi_size in ->bi_end_io(), see req_bio_endio().
Meantime bio_for_each_segment_all() covers all pages added to the bio via
bio_add_page(), which is invariant after the bio is submitted.

> 
> And obviously, when the bio get submitted, its bi_size is not 0.
> 
> This is especially common for REQ_OP_ZONE_APPEND bio, but I also get rare
> bi_size == 0 at endio time, for REQ_OP_WRITE too.

It shouldn't be rare.

> 
> So I guess bi_size at endio time is no longer reliable due to bio
> merging/splitting?

No, ->bi_size should be zero in .bi_end_io() if this bio is completed
successfully no matter if the bio is splitted or not.

> 
> Thus the only correct way to get how large a bio really is, is through
> bio_for_each_segment_all()?

Yeah, if you mean to get the bio's real size in ->bi_end_io().


Thanks,
Ming

