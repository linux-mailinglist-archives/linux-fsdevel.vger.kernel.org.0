Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C14E5F3AA8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Oct 2022 02:31:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbiJDAbM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Oct 2022 20:31:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbiJDAbH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Oct 2022 20:31:07 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42B9215A2A;
        Mon,  3 Oct 2022 17:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Wa9KrrKNC6Vgnnu2W46pq1xBHNyZVTHJGYOL4jFN34Q=; b=OgKh8MRDp07PoG9+f4r8Hd0YoI
        a/SIUw1+vbbFjOF/LMh2Un0mf3L4e50cEsQsUh/3Iywoy72ExZ9FowrxtNyW0zOGoXKazQjTVqBTA
        32n+cnRZQfwYPfAYuYaYz435d1ip8golXB/xx7FbXe81nc+C2e5XWql+urAWm2YMYo6nPwAQz9KIJ
        szwXD04Vq5qJ539Vsrw/VMSRCjcFXc/T73ZZzbR7lcMoQZsqOepivLEbQ8rO7DglBRnuOWL/8q6PT
        m3h7T1QyKBZntxNhpvOPS49q0v54PNHJ9ROlln6ZvRCyYHagfNbtyJjHI0OiVu+dnn8OKN7T2koKT
        QLl2Y5Yw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1ofVpu-006faW-21;
        Tue, 04 Oct 2022 00:31:02 +0000
Date:   Tue, 4 Oct 2022 01:31:02 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "J. R. Okajima" <hooanon05g@gmail.com>,
        Ira Weiny <ira.weiny@intel.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH][CFT] [coredump] don't use __kernel_write() on
 kmap_local_page()
Message-ID: <Yzt+xvE88/OENka+@ZenIV>
References: <YzN+ZYLjK6HI1P1C@ZenIV>
 <YzSSl1ItVlARDvG3@ZenIV>
 <YzpcXU2WO8e22Cmi@iweiny-desk3>
 <7714.1664794108@jrobl>
 <Yzs4mL3zrrC0/vN+@iweiny-mobl>
 <YztfvaAFOe2kGvDz@ZenIV>
 <4011.1664837894@jrobl>
 <YztyLFZJKKTWcMdO@ZenIV>
 <CAHk-=whsOyuRhjmUQ5c1dBQYt1E4ANhObAbEspWtUyt+Pq=Kmw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whsOyuRhjmUQ5c1dBQYt1E4ANhObAbEspWtUyt+Pq=Kmw@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 03, 2022 at 05:20:03PM -0700, Linus Torvalds wrote:
> On Mon, Oct 3, 2022 at 4:37 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > One variant would be to revert the original patch, put its
> > (hopefully) fixed variant into -next and let it sit there for
> > a while.  Another is to put this incremental into -next and
> > merge it into mainline once it gets a sane amount of testing.
> 
> Just do the incremental fix. It looks obvious enough ("oops, we need
> to get the pos _after_ we've done any skip-lseeks on the core file")
> that I think it would be just harder to follow a "revert and follow up
> with a fix".
> 
> I don't think it needs a ton of extra testing, with Okajima having
> already confirmed it fixes his problem case..

OK, incremental is in #fixes, pushed out.
