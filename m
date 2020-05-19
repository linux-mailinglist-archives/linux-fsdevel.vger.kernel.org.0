Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2A231D9D3E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 May 2020 18:54:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729214AbgESQyZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 May 2020 12:54:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:59416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728689AbgESQyZ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 May 2020 12:54:25 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A6F42207C4;
        Tue, 19 May 2020 16:54:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589907265;
        bh=F3dN0zrn02XqYeGLdYTC4OWEcZAQOnLoUQNvjt28dtE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NMAVz0oEMdnOqwFksq0gW53YAZ54LG/epC0v3woqU/q0cWmCmRjqYeMM6gw7gKqDF
         F+zFd6cj48LY1VSSoWEBcd0PeabLkT32n8uAIkn+KvFOmX+ghVQtDcgdnWKBfuqUtL
         cpL1Z3dWBG9USTwZkJiPHyyqekVaLHoQyP8RXnQI=
Date:   Tue, 19 May 2020 18:54:21 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>, axboe@kernel.dk,
        viro@zeniv.linux.org.uk, bvanassche@acm.org, rostedt@goodmis.org,
        mingo@redhat.com, jack@suse.cz, ming.lei@redhat.com,
        nstange@suse.de, akpm@linux-foundation.org, mhocko@suse.com,
        yukuai3@huawei.com, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Omar Sandoval <osandov@fb.com>,
        Hannes Reinecke <hare@suse.com>,
        Michal Hocko <mhocko@kernel.org>,
        syzbot+603294af2d01acfdd6da@syzkaller.appspotmail.com
Subject: Re: [PATCH v5 5/7] blktrace: fix debugfs use after free
Message-ID: <20200519165421.GA1064707@kroah.com>
References: <20200516031956.2605-1-mcgrof@kernel.org>
 <20200516031956.2605-6-mcgrof@kernel.org>
 <20200519163713.GA29944@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200519163713.GA29944@infradead.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 19, 2020 at 09:37:13AM -0700, Christoph Hellwig wrote:
> I don't think we need any of that symlink stuff.  Even if we want it
> (which I don't), it should not be in a bug fix patch.

I agree, why are the symlinks even needed?  This is debugfs, the
files/contents there can change whenever they want to, no userspace code
should depend on this stuff...

> In fact to fix the blktrace race I think we only need something like
> this fairly trivial patch (completely untested so far) below.
> 
> (and with that we can also drop the previous patch, as blk-debugfs.c
> becomes rather pointless)

Patch looks much more sane than Luis's one.

thanks,

greg k-h
