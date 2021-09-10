Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EA73406615
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Sep 2021 05:24:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbhIJDZR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Sep 2021 23:25:17 -0400
Received: from zeniv-ca.linux.org.uk ([142.44.231.140]:59272 "EHLO
        zeniv-ca.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbhIJDZR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Sep 2021 23:25:17 -0400
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mOX8y-002n4l-Ew; Fri, 10 Sep 2021 03:24:00 +0000
Date:   Fri, 10 Sep 2021 03:24:00 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Pavel Begunkov <asml.silence@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [git pull] iov_iter fixes
Message-ID: <YTrP0EbPaZ4c67Ij@zeniv-ca.linux.org.uk>
References: <CAHk-=wiacKV4Gh-MYjteU0LwNBSGpWrK-Ov25HdqB1ewinrFPg@mail.gmail.com>
 <5971af96-78b7-8304-3e25-00dc2da3c538@kernel.dk>
 <ebc6cc5e-dd43-6370-b462-228e142beacb@kernel.dk>
 <CAHk-=whoMLW-WP=8DikhfE4xAu_Tw9jDNkdab4RGEWWMagzW8Q@mail.gmail.com>
 <ebb7b323-2ae9-9981-cdfd-f0f460be43b3@kernel.dk>
 <CAHk-=wi2fJ1XrgkfSYgn9atCzmJZ8J3HO5wnPO0Fvh5rQx9mmA@mail.gmail.com>
 <88f83037-0842-faba-b68f-1d4574fb45cb@kernel.dk>
 <YTrHYYEQslQzvnWW@zeniv-ca.linux.org.uk>
 <8d9e4f7c-bcf4-2751-9978-6283cabeda52@kernel.dk>
 <YTrN16wu/KE0X/QZ@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YTrN16wu/KE0X/QZ@zeniv-ca.linux.org.uk>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 10, 2021 at 03:15:35AM +0000, Al Viro wrote:
> On Thu, Sep 09, 2021 at 09:06:58PM -0600, Jens Axboe wrote:
> > On 9/9/21 8:48 PM, Al Viro wrote:
> > > On Thu, Sep 09, 2021 at 07:35:13PM -0600, Jens Axboe wrote:
> > > 
> > >> Yep ok I follow you now. And yes, if we get a partial one but one that
> > >> has more consumed than what was returned, that would not work well. I'm
> > >> guessing that a) we've never seen that, or b) we always end up with
> > >> either correctly advanced OR fully advanced, and the fully advanced case
> > >> would then just return 0 next time and we'd just get a short IO back to
> > >> userspace.
> > >>
> > >> The safer way here would likely be to import the iovec again. We're
> > >> still in the context of the original submission, and the sqe hasn't been
> > >> consumed in the ring yet, so that can be done safely.
> > > 
> > > ... until you end up with something assuming that you've got the same
> > > iovec from userland the second time around.
> > > 
> > > IOW, generally it's a bad idea to do that kind of re-imports.
> > 
> > That's really no different than having one thread do the issue, and
> > another modify the iovec while it happens. It's only an issue if you
> > don't validate it, just like you did the first time you imported. No
> > assumptions need to be made here.
> 
> 	It's not "need to be made", it's "will be mistakenly made by
> somebody several years down the road"...

E.g. somebody blindly assuming that the amount of data read the last
time around will not exceed the size of reimported iov_iter.  What I'm
saying is that there's a plenty of ways to fuck up in that direction,
and they will *not* be caught by normal fuzzers.

I'm not arguing in favour of an uncoditional copy, BTW - I would like to
see something resembling profiling data, but it's obviously not a pretty
solution.
