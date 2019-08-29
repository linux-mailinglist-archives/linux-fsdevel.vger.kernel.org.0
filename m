Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B223A15EE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2019 12:28:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbfH2K2w (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Aug 2019 06:28:52 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56100 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725990AbfH2K2w (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Aug 2019 06:28:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=CDQv3og0UHxZ8vB+W50a7E0hCQ70tmtKnd44IXZRO7w=; b=I/bTPQ8RCf8zjKa1/9w6Dg0Au
        8CT1NhvbPHzlLq9A4A6MS5qrSb4cArkSEJJmndaErf+jxuwohcpeC/0KFBuQkWgTgtYhZQUvt2ShJ
        A99zZunMfEuwcyXnF3oyU63S1t6NYuUeGjjvCLhmYqJKy/VSNHBAoewNsS6ouZWtzGBYJY/1t9GUE
        5PNjTnhT0pxt0ukc0WatR2xMwj3N8gLTRE+TXBo0L47Ke5LAkd7pza4dG8LmUZPXQmg7DLGvYqPQF
        H0XiYwNorBcLaSFmPVQtQQ1W7pE+0bGZhGs6o6FErUOmZ0c+GwdG90l9SLrWnhLMY4o0y1HGfuuRy
        A1JPuzUuQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1i3HfS-00005P-Hh; Thu, 29 Aug 2019 10:28:38 +0000
Date:   Thu, 29 Aug 2019 03:28:38 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Gao Xiang <gaoxiang25@huawei.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Theodore Ts'o <tytso@mit.edu>, Pavel Machek <pavel@denx.de>,
        David Sterba <dsterba@suse.cz>,
        Amir Goldstein <amir73il@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
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
Subject: Re: [PATCH v6 08/24] erofs: add namei functions
Message-ID: <20190829102838.GG20598@infradead.org>
References: <20190802125347.166018-1-gaoxiang25@huawei.com>
 <20190802125347.166018-9-gaoxiang25@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190802125347.166018-9-gaoxiang25@huawei.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 02, 2019 at 08:53:31PM +0800, Gao Xiang wrote:
> +struct erofs_qstr {
> +	const unsigned char *name;
> +	const unsigned char *end;
> +};

Maybe erofs_name?  The q in qstr stands for quick, because of the
existing hash and len, which this doesn't really provide.

Also I don't really see why you don't just pass the actual qstr and
just document that dirnamecmp does not look at the hash and thus
doesn't require it to be filled out.

