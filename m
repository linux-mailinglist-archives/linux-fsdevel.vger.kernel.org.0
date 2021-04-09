Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC385359D1B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Apr 2021 13:18:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234201AbhDILSi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Apr 2021 07:18:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234113AbhDILS0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Apr 2021 07:18:26 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D738C061762;
        Fri,  9 Apr 2021 04:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0G+omcGOetSmBATjuAzTrvUrz2CKNcOMwN8ZffcfyG4=; b=cYjFYTUAND/8orFcuvXNhJh1Pn
        S4JLFssq7lsdlXEYLFeO7iCpsoeEuDQZRQus+40z4ZiKzZfGqh0Txij8C4sO4nivhKozSMZhzMR67
        58doyVPxBZtBqonPz5HD8++G2Cye3xFp0YwjxhN8HrqnnfLaMDS2T8rKFmYuOKyUCVkn4nNME1OmP
        R2+kdWozmWuuf2wa7o17y1AGWbUvm7Q8EWqa2dcT0Y/l/fcCge0kMN4Eo++bIdeHCZVpLcrL1x7Bb
        1VY6fdzgy2VnC9oQnRyfbtE1k/K+zbBQSRPWyC67EMnX5Qef2wHj1w+vHR7UlrOZksh+r/yu4rBEy
        9kcK7F2w==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lUp7s-000GjE-Mr; Fri, 09 Apr 2021 11:17:01 +0000
Date:   Fri, 9 Apr 2021 12:16:36 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     torvalds@linux-foundation.org,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, jlayton@kernel.org, hch@lst.de,
        linux-cachefs@redhat.com, v9fs-developer@lists.sourceforge.net,
        linux-afs@lists.infradead.org, ceph-devel@vger.kernel.org,
        linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2/3] mm: Return bool from pagebit test functions
Message-ID: <20210409111636.GR2531743@casper.infradead.org>
References: <CAHk-=wi_XrtTanTwoKs0jwnjhSvwpMYVDJ477VtjvvTXRjm5wQ@mail.gmail.com>
 <161796595714.350846.1547688999823745763.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <161796595714.350846.1547688999823745763.stgit@warthog.procyon.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 09, 2021 at 11:59:17AM +0100, David Howells wrote:
> Make functions that test page bits return a bool, not an int.  This means
> that the value is definitely 0 or 1 if they're used in arithmetic, rather
> than rely on test_bit() and friends to return this (though they probably
> should).

iirc i looked at doing this as part of the folio work, and it ended up
increasing the size of the kernel.  Did you run bloat-o-meter on the
result of doing this?
