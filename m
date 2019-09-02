Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14E0BA56A7
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2019 14:51:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729962AbfIBMvQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Sep 2019 08:51:16 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52252 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729690AbfIBMvP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Sep 2019 08:51:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=2SRLGmzt9ygJ+k1758a7WeMkOp6QVS9SpfevL0fmQfQ=; b=p1wdTs4XDK/LQWfm/yELbp49u
        phV0PdWujXYthfryE4TkwNYPNSjVRtyhrjikDgf3P3SMQVhM4XRwApkyG5tQzhuUZhc9Bz3ebmUh7
        qJ3KM1c0uT+TU9dK8YwGrjAmSVzRQYI1dlCZedOFGQzdvco5MqhqYrS1C6rDLvn7gNyBDqmIo/xKW
        G8ajsycXwdssNAKgMAPBfcubUQjWvXjRoblHim8dRKXzpDUS1z/aSV/OxkTDhuv2tYkihbFEL8+Ig
        Joaenckr004Pz8x2NJ1XiFbwZSkzUEc91fCcuCSy47u20XG+/CKVdTloaqFrnExpE814on13j+pV8
        EmKp8xVSg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1i4lnZ-0004LV-VP; Mon, 02 Sep 2019 12:51:09 +0000
Date:   Mon, 2 Sep 2019 05:51:09 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Gao Xiang <hsiangkao@aol.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Gao Xiang <gaoxiang25@huawei.com>, Jan Kara <jack@suse.cz>,
        Chao Yu <yuchao0@huawei.com>,
        Dave Chinner <david@fromorbit.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Miao Xie <miaoxie@huawei.com>, devel@driverdev.osuosl.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Theodore Ts'o <tytso@mit.edu>, Pavel Machek <pavel@denx.de>,
        David Sterba <dsterba@suse.cz>,
        Li Guifu <bluce.liguifu@huawei.com>,
        Fang Wei <fangwei1@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-erofs@lists.ozlabs.org
Subject: Re: [PATCH v6 03/24] erofs: add super block operations
Message-ID: <20190902125109.GA9826@infradead.org>
References: <20190802125347.166018-1-gaoxiang25@huawei.com>
 <20190802125347.166018-4-gaoxiang25@huawei.com>
 <20190829101545.GC20598@infradead.org>
 <20190901085452.GA4663@hsiangkao-HP-ZHAN-66-Pro-G1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190901085452.GA4663@hsiangkao-HP-ZHAN-66-Pro-G1>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Sep 01, 2019 at 04:54:55PM +0800, Gao Xiang wrote:
> No modification at this... (some comments already right here...)

>  20 /* 128-byte erofs on-disk super block */
>  21 struct erofs_super_block {
> ...
>  24         __le32 features;        /* (aka. feature_compat) */
> ...
>  38         __le32 requirements;    /* (aka. feature_incompat) */
> ...
>  41 };

This is only cosmetic, why not stick to feature_compat and
feature_incompat?

> > > +	bh = sb_bread(sb, 0);
> > 
> > Is there any good reasons to use buffer heads like this in new code
> > vs directly using bios?
> 
> As you said, I want it in the page cache.
> 
> The reason "why not use read_mapping_page or similar?" is simply
> read_mapping_page -> .readpage -> (for bdev inode) block_read_full_page
>  -> create_page_buffers anyway...
> 
> sb_bread haven't obsoleted... It has similar function though...

With the different that it keeps you isolated from the buffer_head
internals.  This seems to be your only direct use of buffer heads,
which while not deprecated are a bit of an ugly step child.  So if
you can easily avoid creating a buffer_head dependency in a new
filesystem I think you should avoid it.

> > > +	sbi->build_time = le64_to_cpu(layout->build_time);
> > > +	sbi->build_time_nsec = le32_to_cpu(layout->build_time_nsec);
> > > +
> > > +	memcpy(&sb->s_uuid, layout->uuid, sizeof(layout->uuid));
> > > +	memcpy(sbi->volume_name, layout->volume_name,
> > > +	       sizeof(layout->volume_name));
> > 
> > s_uuid should preferably be a uuid_t (assuming it is a real BE uuid,
> > if it is le it should be a guid_t).
> 
> For this case, I have no idea how to deal with...
> I have little knowledge about this uuid stuff, so I just copied
> from f2fs... (Could be no urgent of this field...)

Who fills out this field in the on-disk format and how?

> The background is Al's comments in erofs v2....
> (which simplify erofs_fill_super logic)
> https://lore.kernel.org/r/20190720224955.GD17978@ZenIV.linux.org.uk/
> 
> with a specific notation...
> https://lore.kernel.org/r/20190721040547.GF17978@ZenIV.linux.org.uk/
> 
> "
> > OTOH, for the case of NULL ->s_root ->put_super() won't be called
> > at all, so in that case you need it directly in ->kill_sb().
> "

Yes.  Although none of that is relevant for this initial version,
just after more features are added.
