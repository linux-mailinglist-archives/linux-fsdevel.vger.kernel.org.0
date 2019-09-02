Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E479EA58CA
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2019 16:07:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731037AbfIBOG4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Sep 2019 10:06:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:48752 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726766AbfIBOG4 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Sep 2019 10:06:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8DC1FABE9;
        Mon,  2 Sep 2019 14:06:53 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 4659BDA796; Mon,  2 Sep 2019 16:07:12 +0200 (CEST)
Date:   Mon, 2 Sep 2019 16:07:12 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Pavel Machek <pavel@denx.de>
Cc:     dsterba@suse.cz, Joe Perches <joe@perches.com>,
        Gao Xiang <gaoxiang25@huawei.com>,
        Christoph Hellwig <hch@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Theodore Ts'o <tytso@mit.edu>,
        Amir Goldstein <amir73il@gmail.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Dave Chinner <david@fromorbit.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Jan Kara <jack@suse.cz>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        LKML <linux-kernel@vger.kernel.org>,
        linux-erofs@lists.ozlabs.org, Chao Yu <yuchao0@huawei.com>,
        Miao Xie <miaoxie@huawei.com>,
        Li Guifu <bluce.liguifu@huawei.com>,
        Fang Wei <fangwei1@huawei.com>
Subject: Re: [PATCH v6 01/24] erofs: add on-disk layout
Message-ID: <20190902140712.GV2752@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Pavel Machek <pavel@denx.de>,
        Joe Perches <joe@perches.com>, Gao Xiang <gaoxiang25@huawei.com>,
        Christoph Hellwig <hch@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Theodore Ts'o <tytso@mit.edu>, Amir Goldstein <amir73il@gmail.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Dave Chinner <david@fromorbit.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Jan Kara <jack@suse.cz>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        LKML <linux-kernel@vger.kernel.org>, linux-erofs@lists.ozlabs.org,
        Chao Yu <yuchao0@huawei.com>, Miao Xie <miaoxie@huawei.com>,
        Li Guifu <bluce.liguifu@huawei.com>, Fang Wei <fangwei1@huawei.com>
References: <20190802125347.166018-1-gaoxiang25@huawei.com>
 <20190802125347.166018-2-gaoxiang25@huawei.com>
 <20190829095954.GB20598@infradead.org>
 <20190829103252.GA64893@architecture4>
 <67d6efbbc9ac6db23215660cb970b7ef29dc0c1d.camel@perches.com>
 <20190830120714.GN2752@twin.jikos.cz>
 <20190902084303.GC19557@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190902084303.GC19557@amd>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 02, 2019 at 10:43:03AM +0200, Pavel Machek wrote:
> > > > Rather than they didn't run "gdb" or "pahole" and change it by mistake.
> > > 
> > > I think Christoph is not right here.
> > > 
> > > Using external tools for validation is extra work
> > > when necessary for understanding the code.
> > 
> > The advantage of using the external tools that the information about
> > offsets is provably correct ...
> 
> No. gdb tells you what the actual offsets _are_.

Ok, reading your reply twice, I think we have different perspectives. I
don't trust the comments.

The tool I had in mind is pahole that parses dwarf information about the
structures, the same as gdb does. The actual value of the struct members
is the thing that needs to be investigated in memory dumps or disk image
dumps.

> > > The expected offset is somewhat valuable, but
> > > perhaps the form is a bit off given the visual
> > > run-in to the field types.
> > > 
> > > The extra work with this form is manipulating all
> > > the offsets whenever a structure change occurs.
> > 
> > ... while this is error prone.
> 
> While the comment tells you what they _should be_.

That's exactly the source of confusion and bugs. For me an acceptable
way of asserting that a value has certain offset is a build check, eg.
like

BUILD_BUG_ON(strct my_superblock, magic, 16);
