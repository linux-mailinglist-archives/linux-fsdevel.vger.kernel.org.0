Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 092281BDCCA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Apr 2020 14:57:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726937AbgD2M53 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Apr 2020 08:57:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:58666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726558AbgD2M53 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Apr 2020 08:57:29 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3AE07208FE;
        Wed, 29 Apr 2020 12:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588165048;
        bh=xzT/KkNS3Xwx0ljtjKedzOR7MaoXuFG1UnsZ0fUYCoI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r2KaiYDUDUDUtPm14PqwArONv9atx0AeQgXxeAHuy4Hah5UcUEnNgw8czuHJDrhuC
         PkqrEs6Zqwd77NrjGQOiHSLUU8eu8Gpgapz2H8cjv0HS9YQihvo4tG8uaTYk1DHdEV
         9dt2TkQcfLt/ivhTwGlh/qA52QOThA/Sd+M5n1vs=
Date:   Wed, 29 Apr 2020 14:57:26 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>, axboe@kernel.dk,
        viro@zeniv.linux.org.uk, bvanassche@acm.org, rostedt@goodmis.org,
        mingo@redhat.com, jack@suse.cz, ming.lei@redhat.com,
        nstange@suse.de, akpm@linux-foundation.org, mhocko@suse.com,
        yukuai3@huawei.com, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Omar Sandoval <osandov@fb.com>,
        Hannes Reinecke <hare@suse.com>,
        Michal Hocko <mhocko@kernel.org>,
        syzbot+603294af2d01acfdd6da@syzkaller.appspotmail.com
Subject: Re: [PATCH v3 4/6] blktrace: fix debugfs use after free
Message-ID: <20200429125726.GA2123334@kroah.com>
References: <20200429074627.5955-1-mcgrof@kernel.org>
 <20200429074627.5955-5-mcgrof@kernel.org>
 <20200429112637.GD21892@infradead.org>
 <20200429114542.GJ11244@42.do-not-panic.com>
 <20200429115051.GA27378@infradead.org>
 <20200429120230.GK11244@42.do-not-panic.com>
 <20200429120406.GA913@infradead.org>
 <20200429122152.GL11244@42.do-not-panic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200429122152.GL11244@42.do-not-panic.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 29, 2020 at 12:21:52PM +0000, Luis Chamberlain wrote:
> On Wed, Apr 29, 2020 at 05:04:06AM -0700, Christoph Hellwig wrote:
> > On Wed, Apr 29, 2020 at 12:02:30PM +0000, Luis Chamberlain wrote:
> > > > Err, that function is static and has two callers.
> > > 
> > > Yes but that is to make it easier to look for who is creating the
> > > debugfs_dir for either the request_queue or partition. I'll export
> > > blk_debugfs_root and we'll open code all this.
> > 
> > No, please not.  exported variables are usually a bad idea.  Just
> > skip the somewhat pointless trivial static function.
> 
> Alrighty. It has me thinking we might want to only export those symbols
> to a specific namespace. Thoughts, preferences?
> 
> BLOCK_GENHD_PRIVATE ?

That's a nice add-on issue after this is fixed.  As Christoph and I
pointed out, you have _less_ code in the file if you remove the static
wrapper function.  Do that now and then worry about symbol namespaces
please.

thanks,

greg k-h
