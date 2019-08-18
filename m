Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3005917C5
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Aug 2019 18:22:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726478AbfHRQWR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 18 Aug 2019 12:22:17 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35550 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbfHRQWQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 18 Aug 2019 12:22:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=N0aKd3kbobOVM+ja2qXPqQEy6PJXskjZ3fNW6CYKznA=; b=LM+w7i3N+Q7emAXcFs7q/xvtc
        LwYBK72c0UsD7+mZtVDq2ehkyG8sRdB/QM4oWWhXa7TvYK4mNCXln2gua/Hr0suUTXsMyHjeABY4B
        LfiObpOBKlFJIUXS5IcHU0+lAfxM9IFPNXLfwQjCjurgwPar/NOd7sJsEnxmJpZoy2nj1QMUCxgkE
        hibZO4GddXdRUF+BvG5lHCrttPsXkdjjbdBA4RSbWYLE5JJ8vHitpoCCKzfp2k6sZ4KOGLjyF29zh
        OtL1O2BwpaLQGyhTKkFrbt4yyOfDRQOTEqdXKt22YCxIxcuJJl7M6aoMf9gW9nxwtL3eY9xOl0rKO
        lyHSgKIYQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hzNwP-0005So-3L; Sun, 18 Aug 2019 16:22:01 +0000
Date:   Sun, 18 Aug 2019 09:22:01 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Richard Weinberger <richard@nod.at>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Gao Xiang <hsiangkao@aol.com>, Jan Kara <jack@suse.cz>,
        Chao Yu <yuchao0@huawei.com>,
        Dave Chinner <david@fromorbit.com>,
        David Sterba <dsterba@suse.cz>, Miao Xie <miaoxie@huawei.com>,
        devel <devel@driverdev.osuosl.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Darrick <darrick.wong@oracle.com>,
        Amir Goldstein <amir73il@gmail.com>,
        linux-erofs <linux-erofs@lists.ozlabs.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Li Guifu <bluce.liguifu@huawei.com>,
        Fang Wei <fangwei1@huawei.com>, Pavel Machek <pavel@denx.de>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] erofs: move erofs out of staging
Message-ID: <20190818162201.GA16269@infradead.org>
References: <1163995781.68824.1566084358245.JavaMail.zimbra@nod.at>
 <20190817233843.GA16991@hsiangkao-HP-ZHAN-66-Pro-G1>
 <1405781266.69008.1566116210649.JavaMail.zimbra@nod.at>
 <20190818084521.GA17909@hsiangkao-HP-ZHAN-66-Pro-G1>
 <1133002215.69049.1566119033047.JavaMail.zimbra@nod.at>
 <20190818090949.GA30276@kroah.com>
 <790210571.69061.1566120073465.JavaMail.zimbra@nod.at>
 <20190818151154.GA32157@mit.edu>
 <20190818155812.GB13230@infradead.org>
 <20190818161638.GE1118@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190818161638.GE1118@sol.localdomain>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Aug 18, 2019 at 09:16:38AM -0700, Eric Biggers wrote:
> Ted's observation was about maliciously-crafted filesystems, though, so
> integrity-only features such as metadata checksums are irrelevant.  Also the
> filesystem version is irrelevant; anything accepted by the kernel code (even if

I think allowing users to mount file systems (any of ours) without
privilege is a rather bad idea.  But that doesn't mean we should not be
as robust as we can.  Optionally disabling support for legacy formats
at compile and/or runtime is something we should actively look into as
well.

> it's legacy/deprecated) is open attack surface.
> 
> I personally consider it *mandatory* that we deal with this stuff.  But I can
> understand that we don't do a good job at it, so we shouldn't hold a new
> filesystem to an unfairly high standard relative to other filesystems...

I very much disagree.  We can't really force anyone to fix up old file
systems.  But we can very much hold new ones to (slightly) higher
standards.  Thats the only way to get the average quality up.  Some as
for things like code style - we can't magically fix up all old stuff,
but we can and usually do hold new code to higher standards.  (Often not
to standards as high as I'd personally prefer, btw).
