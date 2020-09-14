Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFD9E2689BA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Sep 2020 13:08:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726003AbgINLIO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Sep 2020 07:08:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbgINLIG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Sep 2020 07:08:06 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64F4DC06174A;
        Mon, 14 Sep 2020 04:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=R3WQcbK1OYupOiZx/4aRKRWUnmzNcweOP1HOOsSlSWU=; b=TkCOOe1DWoOM+uWKWkJZWxo9oD
        kqJ7qOtuibBqqE6cz5MQssWjL0fhXofYGJHn60PJEkdsLwjUSdo4O90gd+4J7mMFw17z+1Xu++JbS
        Gi8Zv+v+uSAPWwOVL+458uKf07DKJ+cBRDNd7ncoIR2Ua+tYTiJ9GJ0TRPxVjmucZCZPlkoJQaldy
        wbatSlKrssuvitaz2/VjlhfZK2svX0dFEZlSc0rcCj6mK+HZgKFhsftYqJw210I4xVHHBXgka2OLp
        ZDKDrkaLtuvPZfdV/FfXSYRDE9Ma+3Cc4unIyIrelx2ZNV44gV0DcIkLqbsZgC1032RKRj7T3gFvA
        T+Oi3tHg==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kHmL6-0004bO-15; Mon, 14 Sep 2020 11:08:04 +0000
Date:   Mon, 14 Sep 2020 12:08:03 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Anmol Karn <anmol.karan123@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        syzbot+f7204dcf3df4bb4ce42c@syzkaller.appspotmail.com
Subject: Re: [Linux-kernel-mentees] [PATCH] idr: remove WARN_ON_ONCE() when
 trying to check id
Message-ID: <20200914110803.GL6583@casper.infradead.org>
References: <20200914071724.202365-1-anmol.karan123@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200914071724.202365-1-anmol.karan123@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 14, 2020 at 12:47:24PM +0530, Anmol Karn wrote:
> idr_get_next() gives WARN_ON_ONCE() when it gets (id > INT_MAX) true
> and this happens when syzbot does fuzzing, and that warning is
> expected, but WARN_ON_ONCE() is not required here and, cecking
> the condition and returning NULL value would be suffice.
> 
> Reference: commit b9959c7a347 ("filldir[64]: remove WARN_ON_ONCE() for bad directory entries")
> Reported-and-tested-by: syzbot+f7204dcf3df4bb4ce42c@syzkaller.appspotmail.com
> Link: https://syzkaller.appspot.com/bug?extid=f7204dcf3df4bb4ce42c 
> Signed-off-by: Anmol Karn <anmol.karan123@gmail.com>

https://lore.kernel.org/netdev/20200605120037.17427-1-willy@infradead.org/
