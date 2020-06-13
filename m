Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A198B1F83BC
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Jun 2020 16:39:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbgFMOjI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 13 Jun 2020 10:39:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726323AbgFMOjI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 13 Jun 2020 10:39:08 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15563C03E96F;
        Sat, 13 Jun 2020 07:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/UHutX/651XYnkKnM6NBQmM9y2YAVAGn9Ikzmv3dpFY=; b=HrXvEgAlgagihhn3EqpqltDMf7
        yF996n0G0Pn33lzbHmvYhJYxdX2LWPBDe6SDuGDCM+YcT+arcaXMJahc6LeqQE4Q19kpbVQaywGjA
        AEil84nspQ/yWQG2TqX9ZXrtBpcoQLafN9wkXGtkL94oRtyKbPSQ8Fe8tsJMAfXQIqo6/InSiuK4F
        vFnwAIPXCAE+QjvYyyUAa+PauVeEYpQRXNqinEPUqfkH8EV6I165Sf+KTYdSmJAnoE3ECKgLsNXe3
        umf9gEUQdltUqPK5yO8hvMvM4JUf40Whej0I8TbZMumrTv0bbCHMpmeyo8ADEF7sM8p2BlfwLvORb
        n+239RWg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jk7J8-0001SL-DS; Sat, 13 Jun 2020 14:38:54 +0000
Date:   Sat, 13 Jun 2020 07:38:54 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Colin Walters <walters@verbum.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        syzbot <syzbot+d6ec23007e951dadf3de@syzkaller.appspotmail.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Subject: Re: [PATCH v4 1/2] hugetlb: use f_mode & FMODE_HUGETLBFS to identify
 hugetlbfs files
Message-ID: <20200613143854.GN8681@bombadil.infradead.org>
References: <20200612004644.255692-1-mike.kravetz@oracle.com>
 <20200612015842.GC23230@ZenIV.linux.org.uk>
 <b1756da5-4e91-298f-32f1-e5642a680cbf@oracle.com>
 <CAOQ4uxg=o2SVbfUiz0nOg-XHG8irvAsnXzFWjExjubk2v_6c_A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxg=o2SVbfUiz0nOg-XHG8irvAsnXzFWjExjubk2v_6c_A@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jun 13, 2020 at 09:53:24AM +0300, Amir Goldstein wrote:
> Currently, the only in-tree stacking fs are overlayfs and ecryptfs, but there
> are some out of tree implementations as well (shiftfs).
> So you may only take that option if you do not care about the combination
> of hugetlbfs with any of the above.

I could see shiftfs being interesting, maybe.  I don't really see
the usecase for layering overlayfs or ecryptfs on top of a ram-based
filesystem.
