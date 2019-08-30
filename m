Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23681A3CB5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2019 18:55:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728267AbfH3Qzh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Aug 2019 12:55:37 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55256 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727930AbfH3Qzg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Aug 2019 12:55:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=5tlZ2AJFJvBfkQ9+HB/A14V0Nr0ngU+sXRXPgXv+PBY=; b=h3Hti2HJW1XQj8WFYW5QPnxq3
        IFR5kBbNPZGUfJLZgkmP05rpU8kdnbpvD+FGCox/WaA3veCbBUk14Fo8QDppOCOnKanexpTcCpiIC
        sE6OdPzOcn3dr2hQ3CHqWtqGye3D73Fhvq0Q17vVPtbBGqh/n5zn/4vnANjKz08CE7A/cFoQUGoK+
        QAYOlb7eXFJYXO9Z2QKijMU6akEztn+q/Y5JPZP/3q07D2/M04Fi6WwQDEhKWs29h7U3KXFx3H23K
        us6o/usVO3kjrh5OHnBglnCka42lTRpqePeoTQmgPzOXE/Zj/25p3KVTeSiYirbxV1MnU40j6IPKo
        dF4fbKs+g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1i3kBR-00045V-TF; Fri, 30 Aug 2019 16:55:33 +0000
Date:   Fri, 30 Aug 2019 09:55:33 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Gao Xiang <gaoxiang25@huawei.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Theodore Ts'o <tytso@mit.edu>, Pavel Machek <pavel@denx.de>,
        David Sterba <dsterba@suse.cz>,
        Amir Goldstein <amir73il@gmail.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Dave Chinner <david@fromorbit.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Jan Kara <jack@suse.cz>,
        Richard Weinberger <richard@nod.at>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-erofs@lists.ozlabs.org, Chao Yu <yuchao0@huawei.com>,
        Miao Xie <miaoxie@huawei.com>,
        Li Guifu <bluce.liguifu@huawei.com>,
        Fang Wei <fangwei1@huawei.com>
Subject: Re: [PATCH v8 20/24] erofs: introduce generic decompression backend
Message-ID: <20190830165533.GA10909@infradead.org>
References: <20190815044155.88483-1-gaoxiang25@huawei.com>
 <20190815044155.88483-21-gaoxiang25@huawei.com>
 <20190830163534.GA29603@infradead.org>
 <20190830165217.GB107220@architecture4>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190830165217.GB107220@architecture4>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Aug 31, 2019 at 12:52:17AM +0800, Gao Xiang wrote:
> Hi Christoph,
> 
> On Fri, Aug 30, 2019 at 09:35:34AM -0700, Christoph Hellwig wrote:
> > On Thu, Aug 15, 2019 at 12:41:51PM +0800, Gao Xiang wrote:
> > > +static bool use_vmap;
> > > +module_param(use_vmap, bool, 0444);
> > > +MODULE_PARM_DESC(use_vmap, "Use vmap() instead of vm_map_ram() (default 0)");
> > 
> > And how would anyone know which to pick?
> 
> It has significant FIO benchmark difference on sequential read least on arm64...
> I have no idea whether all platform vm_map_ram() behaves better than vmap(),
> so I leave an option for users here...

vm_map_ram is supposed to generally behave better.  So if it doesn't
please report that that to the arch maintainer and linux-mm so that
they can look into the issue.  Having user make choices of deep down
kernel internals is just a horrible interface.

Please talk to maintainers of other bits of the kernel if you see issues
and / or need enhancements.
