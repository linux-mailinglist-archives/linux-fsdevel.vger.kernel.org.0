Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62E3338E862
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 May 2021 16:11:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233029AbhEXOM4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 May 2021 10:12:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45918 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233004AbhEXOMv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 May 2021 10:12:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621865481;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XrgScrtgPE6h0yjFQjkRNhNAavrRYvrma6AaGeqjrVc=;
        b=YirQvvSzv2AId6c8/vh1jsyENZpp9zmxMhREPUM3VMvkt3PcSVTwFrIzzgJ4mkNe2ViPBx
        0H9/T4PI26/8m7jmJs6kpB0BQGIjTDjUGXXroFf/BwqjMPG0ds2y6q7858oZjs13z/yD97
        eIPO3bvcbaJ3BO7OLe1cedFCsrlZXfI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-331-lh9f0pMyNxGBhr0E5-DRCQ-1; Mon, 24 May 2021 10:11:19 -0400
X-MC-Unique: lh9f0pMyNxGBhr0E5-DRCQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4AF84107B78A;
        Mon, 24 May 2021 14:11:18 +0000 (UTC)
Received: from T590 (ovpn-12-30.pek2.redhat.com [10.72.12.30])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2E2D35C701;
        Mon, 24 May 2021 14:11:15 +0000 (UTC)
Date:   Mon, 24 May 2021 22:11:10 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Brian Foster <bfoster@redhat.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] iomap: resched ioend completion when in
 non-atomic context
Message-ID: <YKuz/vX44vqZrrVR@T590>
References: <20210517171722.1266878-1-bfoster@redhat.com>
 <20210517171722.1266878-2-bfoster@redhat.com>
 <YKi2hwnJMbLYtkmb@T590>
 <YKuUvHB6HUyQ6TWD@bfoster>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YKuUvHB6HUyQ6TWD@bfoster>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 24, 2021 at 07:57:48AM -0400, Brian Foster wrote:
> On Sat, May 22, 2021 at 03:45:11PM +0800, Ming Lei wrote:
> > On Mon, May 17, 2021 at 01:17:20PM -0400, Brian Foster wrote:
> > > The iomap ioend mechanism has the ability to construct very large,
> > > contiguous bios and/or bio chains. This has been reported to lead to
> > 
> > BTW, it is actually wrong to complete a large bio chains in
> > iomap_finish_ioend(), which may risk in bio allocation deadlock, cause
> > bio_alloc_bioset() relies on bio submission to make forward progress. But
> > it becomes not true when all chained bios are freed just after the whole
> > ioend is done since all chained bios(except for the one embedded in ioend)
> > are allocated from same bioset(fs_bio_set).
> > 
> 
> Interesting. Do you have a reproducer (or error report) for this? Is it

No, but the theory has been applied for long time.

> addressed by the next patch, or are further changes required?

Your patchset can't address the issue.


Thanks,
Ming

