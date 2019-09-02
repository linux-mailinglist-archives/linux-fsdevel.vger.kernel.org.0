Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D1A8A5A27
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2019 17:06:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731801AbfIBPGp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Sep 2019 11:06:45 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34568 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731307AbfIBPGp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Sep 2019 11:06:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=nNUDDXya3h8hqFlB3tiL0TsifnVLRoZdKphNekPMo0s=; b=tLPkucC5rxvW7BgJAmnNzExc4
        jCapxosKXIHpknqAkYvSi3cp2jeockOD66WW1kwhnydi/5iiDzv08sSwt+y2+Te0GRAnFNTy5l4Nn
        bPRW62bal2Azk1tepSwDyWTTcx0rhUPPD92aUfB6GZjINZamiP9k0jXlDPCfI5FAg7JOwFrHEN8h0
        bn2WgpiHzivlJGyNW0s9cDfix4/jZnjEGr6nvQiGOpklSkdIAvVIFbwRm2zxWMCzzLkNvGikY+fgE
        dZOMVOMeExieYAnXWniEGIiwbWQKYVYc1Uis0znCdI4FAJClNgNqLYMH7kk561bAMgM+SEUO6meMX
        2iMABbwFg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1i4nui-0007SA-OE; Mon, 02 Sep 2019 15:06:40 +0000
Date:   Mon, 2 Sep 2019 08:06:40 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     dsterba@suse.cz, Chao Yu <chao@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Gao Xiang <gaoxiang25@huawei.com>,
        linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Theodore Ts'o <tytso@mit.edu>, Pavel Machek <pavel@denx.de>,
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
Subject: Re: [PATCH v8 11/24] erofs: introduce xattr & posixacl support
Message-ID: <20190902150640.GA23089@infradead.org>
References: <20190815044155.88483-1-gaoxiang25@huawei.com>
 <20190815044155.88483-12-gaoxiang25@huawei.com>
 <20190902125711.GA23462@infradead.org>
 <20190902130644.GT2752@suse.cz>
 <813e1b65-e6ba-631c-6506-f356738c477f@kernel.org>
 <20190902142037.GW2752@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190902142037.GW2752@twin.jikos.cz>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 02, 2019 at 04:20:37PM +0200, David Sterba wrote:
> Oh right, I think the reasons are historical and that we can remove the
> options nowadays. From the compatibility POV this should be safe, with
> ACLs compiled out, no tool would use them, and no harm done when the
> code is present but not used.
> 
> There were some efforts by embedded guys to make parts of kernel more
> configurable to allow removing subsystems to reduce the final image
> size. In this case I don't think it would make any noticeable
> difference, eg. the size of fs/btrfs/acl.o on release config is 1.6KiB,
> while the whole module is over 1.3MiB.

Given that the erofs folks have an actual use case for it I think
it is fine to keep the options, I just wanted to ensure this wasn't
copy and pasted for no good reason.  Note that for XFS we don't have
an option for xattrs, as those are integral to a lot of file system
features.  WE have an ACL option mostly for historic reasons.
