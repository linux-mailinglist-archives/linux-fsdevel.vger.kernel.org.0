Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D9AC91797
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Aug 2019 17:58:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726256AbfHRP6h (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 18 Aug 2019 11:58:37 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41610 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbfHRP6h (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 18 Aug 2019 11:58:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:To:From:Date:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=tIZZ/FYTg4zcRyMX1dDT7uD/VTliOCaMSPK8iFKI03c=; b=mEaJhougJmxShBi14iedqWYnSl
        T5xUqdoX+PlWdPbb07JL0OLcmq4TMqzEV/i2TEeZbz3PKOirVDvizdOT2V1bmZ6BiEYJxBIDfHD7u
        0vxgUmsY6El7Bk7d9qpDGt3Icf5KivaU6N7b6NmMh+glrwIUxVa/n3rC3kCMPqB6fcbxCxTM2GF0f
        T1BDgybJyRhvTPwFZ51SSTW+hta7+b/v0Hu85H8AoZOLuCzrUB46Fcn0MmEdn0On4J4vTd3DH132m
        U/4zSWAEHFn1LPPDzQEnQzugWBJreUm7VrPVFDSAaRKgwNtGwJ8T0GUQomopLVBHe0kRtBQfMMCKG
        2Okqdggw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hzNZM-0003ZJ-KO; Sun, 18 Aug 2019 15:58:12 +0000
Date:   Sun, 18 Aug 2019 08:58:12 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Richard Weinberger <richard@nod.at>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Gao Xiang <hsiangkao@aol.com>, Jan Kara <jack@suse.cz>,
        Chao Yu <yuchao0@huawei.com>,
        Dave Chinner <david@fromorbit.com>,
        David Sterba <dsterba@suse.cz>, Miao Xie <miaoxie@huawei.com>,
        devel <devel@driverdev.osuosl.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Darrick <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@infradead.org>,
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
Message-ID: <20190818155812.GB13230@infradead.org>
References: <20190817082313.21040-1-hsiangkao@aol.com>
 <20190817220706.GA11443@hsiangkao-HP-ZHAN-66-Pro-G1>
 <1163995781.68824.1566084358245.JavaMail.zimbra@nod.at>
 <20190817233843.GA16991@hsiangkao-HP-ZHAN-66-Pro-G1>
 <1405781266.69008.1566116210649.JavaMail.zimbra@nod.at>
 <20190818084521.GA17909@hsiangkao-HP-ZHAN-66-Pro-G1>
 <1133002215.69049.1566119033047.JavaMail.zimbra@nod.at>
 <20190818090949.GA30276@kroah.com>
 <790210571.69061.1566120073465.JavaMail.zimbra@nod.at>
 <20190818151154.GA32157@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190818151154.GA32157@mit.edu>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Aug 18, 2019 at 11:11:54AM -0400, Theodore Y. Ts'o wrote:
> Note that of the mainstream file systems, ext4 and xfs don't guarantee
> that it's safe to blindly take maliciously provided file systems, such
> as those provided by a untrusted container, and mount it on a file
> system without problems.  As I recall, one of the XFS developers
> described file system fuzzing reports as a denial of service attack on
> the developers.

I think this greatly misrepresents the general attitute of the XFS
developers.  We take sanity checks for the modern v5 on disk format
very series, and put a lot of effort into handling corrupted file
systems as good as possible, although there are of course no guaranteeѕ.

The quote that you've taken out of context is for the legacy v4 format
that has no checksums and other integrity features.
