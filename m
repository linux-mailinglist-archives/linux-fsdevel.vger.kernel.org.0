Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11D3B2AFD1B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Nov 2020 02:51:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728330AbgKLBcP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Nov 2020 20:32:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727672AbgKKXAR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Nov 2020 18:00:17 -0500
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05885C0613D1;
        Wed, 11 Nov 2020 15:00:16 -0800 (PST)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kcz5y-003sj0-JF; Wed, 11 Nov 2020 23:00:06 +0000
Date:   Wed, 11 Nov 2020 23:00:06 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Greg KH <gregkh@linuxfoundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/6] seq_file: add seq_read_iter
Message-ID: <20201111230006.GB3576660@ZenIV.linux.org.uk>
References: <20201104082738.1054792-1-hch@lst.de>
 <20201104082738.1054792-2-hch@lst.de>
 <20201110213253.GV3576660@ZenIV.linux.org.uk>
 <20201110213511.GW3576660@ZenIV.linux.org.uk>
 <20201110232028.GX3576660@ZenIV.linux.org.uk>
 <CAHk-=whTqr4Lp0NYR6k3yc2EbiF0RR17=TJPa4JBQATMR__XqA@mail.gmail.com>
 <20201111215220.GA3576660@ZenIV.linux.org.uk>
 <20201111222116.GA919131@ZenIV.linux.org.uk>
 <CAHk-=wiRM_wDsz1AZ4hyWbctikjSXsYMe-ofvtnQRQ1mFcTqnA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiRM_wDsz1AZ4hyWbctikjSXsYMe-ofvtnQRQ1mFcTqnA@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 11, 2020 at 02:27:02PM -0800, Linus Torvalds wrote:
> On Wed, Nov 11, 2020 at 2:21 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > Something like below (build-tested only):
> 
> Apart from my usual "oh, Gods, the iter model really does confuse me"
> this looks more like what I expected, yes.
> 
> Considering the original bug, I'm clearly not the only one confused by
> the iov_iter helper functions and the rules..

copy_to_iter() returns the amount it has actually copied, that's all;
the cause of that bug is not the primitives used, it's the rules for
->read_iter().  The rules are actually fairly simple - "->read_iter()
should not report less data than it has actually left there".  For read(2)
it's a matter of QoI - if we hit an unmapped page, POSIX pretty much says
that all bets are off; read(fd, unmapped - 5, 8) might copy 5 bytes and
return 4.  It is allowed (and read(2) on those files used to do just that),
but it's nicer not to do so.  For generic_file_splice_read(), OTOH, it's
a bug - we end up with stray data spewed into pipe.  So converting
to ->read_iter() needs some care.  Probably something along those
lines should go into D/f/porting...
