Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 734452DF08E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Dec 2020 17:54:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbgLSQyW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 19 Dec 2020 11:54:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726843AbgLSQyV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 19 Dec 2020 11:54:21 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86172C0613CF;
        Sat, 19 Dec 2020 08:53:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=16b/4Hd/UEENoUJo02OaUevQRkDdVSOEk9lJH8ZvBys=; b=XNF3cfxnJfBX6H2bplMWyTHPU3
        0TceJlGt12iNHKIKOhjBK4o93MR/lw2ptxl7gTdbtwb+/cIl9tXPwklcY1IClpjI1/xuBrY4C9ckB
        5aqTa/LkuOjU9oMJcTW6bgAsNwcmSaGz61ZzgBJwKkEoyhG3BsBrTJMuWZ1ijS+2dxMZubPpavDgt
        Cp0cuxrzIEkYWzhVokid72awf7Nru0nGkFUlFNmXYfktxu4BI6nTzw2gGeRMAdmdzGP01G1RahB7W
        RVsSnbvlVP10E9bwNwgGKlvFWXpfWaSzFB35HkRzJGA2KOa9ocyPQfsOqG3V55HsIYDAUDalisvpi
        eYY3DKDw==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kqfU7-0007MG-5P; Sat, 19 Dec 2020 16:53:35 +0000
Date:   Sat, 19 Dec 2020 16:53:35 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Sargun Dhillon <sargun@sargun.me>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Vivek Goyal <vgoyal@redhat.com>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        NeilBrown <neilb@suse.com>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH v3] errseq: split the ERRSEQ_SEEN flag into two new flags
Message-ID: <20201219165335.GT15600@casper.infradead.org>
References: <20201217150037.468787-1-jlayton@kernel.org>
 <20201219061331.GQ15600@casper.infradead.org>
 <f84f3259d838f132029576b531d81525abd4e1b8.camel@kernel.org>
 <20201219153312.GS15600@casper.infradead.org>
 <9a1263329effe436a970d5aa61a4cfad3098a076.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a1263329effe436a970d5aa61a4cfad3098a076.camel@kernel.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Dec 19, 2020 at 10:49:58AM -0500, Jeff Layton wrote:
> On Sat, 2020-12-19 at 15:33 +0000, Matthew Wilcox wrote:
> > On Sat, Dec 19, 2020 at 07:53:12AM -0500, Jeff Layton wrote:
> > > On Sat, 2020-12-19 at 06:13 +0000, Matthew Wilcox wrote:
> > > > On Thu, Dec 17, 2020 at 10:00:37AM -0500, Jeff Layton wrote:
> > > > > Overlayfs's volatile mounts want to be able to sample an error for their
> > > > > own purposes, without preventing a later opener from potentially seeing
> > > > > the error.
> > > > 
> > > > umm ... can't they just copy the errseq_t they're interested in, followed
> > > > by calling errseq_check() later?
> > > > 
> > > 
> > > They don't want the sampling for the volatile mount to prevent later
> > > openers from seeing an error that hasn't yet been reported.
> > 
> > That's why they should use errseq_check(), not errseq_check_and_advance()
> > ...
> 
> If you sample it without setting the OBSERVED (aka SEEN) bit, then you
> can't guarantee that the next error that occurs will be recorded. The
> counter won't be bumped unless that flag is set.

Ah, right, that's why we set to zero when sampling.

It isn't clear to me that overlayfs doesn't want that behaviour ...
because the overlayfs people have been so very unclear on what they
actually want.

I'm beginning to think we want a test-suite for errseq_t, which would
serve the twin purpose of documenting how to use it and what behaviours
you can get from it, as well as making sure we don't regress anything
when making changes.
