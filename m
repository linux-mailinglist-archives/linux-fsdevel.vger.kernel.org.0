Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1990438D43C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 May 2021 09:45:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbhEVHqv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 22 May 2021 03:46:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:25041 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229990AbhEVHqu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 22 May 2021 03:46:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621669525;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=h2vI6qAlLV/+LbtWLIAbep8Td7DB8/nLdLSULmPCA2k=;
        b=IH7mSIvnZ7+wLApCBOG2H9W7EqeDfPzf9s89rbYMQ+BgAW6N3az+aG03valeCZX9Up269Z
        vmrT9kqvFm/eo4kBL1VYN3dAtiufCgZzwo6lb6ICdtPoXViEVvFid6HZR5nskq5RlO7DZt
        mISRi7LR4sB10NFQ0l0ExERZ2t+0PlI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-58-tC9wFz4xPm2K-paW3QMXaw-1; Sat, 22 May 2021 03:45:22 -0400
X-MC-Unique: tC9wFz4xPm2K-paW3QMXaw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 62E98180FD60;
        Sat, 22 May 2021 07:45:21 +0000 (UTC)
Received: from T590 (ovpn-12-34.pek2.redhat.com [10.72.12.34])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D9D4560D4B;
        Sat, 22 May 2021 07:45:15 +0000 (UTC)
Date:   Sat, 22 May 2021 15:45:11 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Brian Foster <bfoster@redhat.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] iomap: resched ioend completion when in
 non-atomic context
Message-ID: <YKi2hwnJMbLYtkmb@T590>
References: <20210517171722.1266878-1-bfoster@redhat.com>
 <20210517171722.1266878-2-bfoster@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210517171722.1266878-2-bfoster@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 17, 2021 at 01:17:20PM -0400, Brian Foster wrote:
> The iomap ioend mechanism has the ability to construct very large,
> contiguous bios and/or bio chains. This has been reported to lead to

BTW, it is actually wrong to complete a large bio chains in
iomap_finish_ioend(), which may risk in bio allocation deadlock, cause
bio_alloc_bioset() relies on bio submission to make forward progress. But
it becomes not true when all chained bios are freed just after the whole
ioend is done since all chained bios(except for the one embedded in ioend)
are allocated from same bioset(fs_bio_set).


Thanks,
Ming

