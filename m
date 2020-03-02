Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14915175AE6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Mar 2020 13:54:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727784AbgCBMyd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Mar 2020 07:54:33 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:58284 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727497AbgCBMyd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Mar 2020 07:54:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Nhw0MyTwnMoRWiNQ3WoBjVjfgBy1tdHCwpldhLXeSH8=; b=aU8OrciQmEGwZ6570fjY/eMdvR
        X1kANb83Bq0fTIhznB+kIfB4p/5nRzMJ7czJPnaY1OXFrD/5TUBR+PFPEHLrCqQDQMz6TdNGnZ3Nc
        7CTNKOiQTzP9xr6E5inn3lrjbzESMTDxTie7XXD9eE0giZ1TpdPHlquxev2i7CD5vvaUX4pDlI2dU
        UpOW2ruUCQKsYOHi7firLkgbbyjrjLtZeiKJjjjkrXx58gxEFg/iqUxL9SqooGp4tOTSBk+HE88hQ
        I2cIAioRqtlpmlUcxJlCQMwI6HiYZAF8h+0UoyH3P8FPHC26Re7WppYBXdIp05X7R46PwmGTJVtDk
        lWMQ6L1w==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j8kae-0000q8-Ok; Mon, 02 Mar 2020 12:54:32 +0000
Date:   Mon, 2 Mar 2020 04:54:32 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     lampahome <pahome.chen@mirlab.org>
Cc:     linux-fsdevel@vger.kernel.org
Subject: Re: why do we need utf8 normalization when compare name?
Message-ID: <20200302125432.GP29971@bombadil.infradead.org>
References: <CAB3eZfv4VSj6_XBBdHK12iX_RakhvXnTCFAmQfwogR34uySo3Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAB3eZfv4VSj6_XBBdHK12iX_RakhvXnTCFAmQfwogR34uySo3Q@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 02, 2020 at 05:00:24PM +0800, lampahome wrote:
> According to case insensitive since kernel 5.2, d_compare will
> transform string into normalized form and then compare.
> 
> But why do we need this normalization function? Could we just compare
> by utf8 string?

Have you read https://en.wikipedia.org/wiki/Unicode_equivalence ?

We need to decide whether a user with a case-insensitive filesystem
who looks up a file with the name U+00E5 (lower case "a" with ring)
should find a file which is named U+00C5 (upper case "A" with ring)
or U+212B (Angstrom sign).

Then there's the question of whether e-acute is stored as U+00E9
or U+0065 followed by U+0301, and both of those will need to be found
by a user search for U+00C9 or a user searching for U+0045 U+0301.

So yes, normalisation needs to be done.
