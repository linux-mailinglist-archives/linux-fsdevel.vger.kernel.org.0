Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B8F98D635E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Oct 2019 15:06:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730102AbfJNNGy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Oct 2019 09:06:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42748 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725989AbfJNNGx (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Oct 2019 09:06:53 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C04D2C049E1A;
        Mon, 14 Oct 2019 13:06:53 +0000 (UTC)
Received: from bfoster (dhcp-41-2.bos.redhat.com [10.18.41.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2C54B1001B35;
        Mon, 14 Oct 2019 13:06:53 +0000 (UTC)
Date:   Mon, 14 Oct 2019 09:06:51 -0400
From:   Brian Foster <bfoster@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Dave Chinner <david@fromorbit.com>, linux-xfs@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 08/26] mm: directed shrinker work deferral
Message-ID: <20191014130651.GB12380@bfoster>
References: <20191009032124.10541-1-david@fromorbit.com>
 <20191009032124.10541-9-david@fromorbit.com>
 <20191014084604.GA11758@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191014084604.GA11758@infradead.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Mon, 14 Oct 2019 13:06:53 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 14, 2019 at 01:46:04AM -0700, Christoph Hellwig wrote:
> On Wed, Oct 09, 2019 at 02:21:06PM +1100, Dave Chinner wrote:
> > From: Dave Chinner <dchinner@redhat.com>
> > 
> > Introduce a mechanism for ->count_objects() to indicate to the
> > shrinker infrastructure that the reclaim context will not allow
> > scanning work to be done and so the work it decides is necessary
> > needs to be deferred.
> > 
> > This simplifies the code by separating out the accounting of
> > deferred work from the actual doing of the work, and allows better
> > decisions to be made by the shrinekr control logic on what action it
> > can take.
> 
> I hate all this boilerplate code in the scanners.  Can't we just add
> a a required_gfp_mask field to struct shrinker and lift the pattern
> to common code?

FWIW, I suggested something similar on the RFC as well. Based on where
that discussion ended up, however, I'm also kind of wondering why we
wouldn't move towards infrastructure that supports the more granular
per-item deferred tracking that is the supposed end goal (and at the
same time avoid shifting this logic back and forth between the count
callback and the scan/reclaim callback)..?

Brian
