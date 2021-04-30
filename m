Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDDAA36FF36
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Apr 2021 19:09:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230514AbhD3RJt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Apr 2021 13:09:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:39182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229750AbhD3RJt (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Apr 2021 13:09:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 66FD86145A;
        Fri, 30 Apr 2021 17:08:59 +0000 (UTC)
Date:   Fri, 30 Apr 2021 19:08:56 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 3/3] test: add openat2() test for invalid upper 32 bit
 flag value
Message-ID: <20210430170856.4wqsr6on664brl4t@wittgenstein>
References: <20210423111037.3590242-1-brauner@kernel.org>
 <20210423111037.3590242-3-brauner@kernel.org>
 <20210430152400.GY3141668@madcap2.tricolour.ca>
 <20210430160913.mowefxfnrwnoc3vd@wittgenstein>
 <20210430164625.GZ3141668@madcap2.tricolour.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210430164625.GZ3141668@madcap2.tricolour.ca>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 30, 2021 at 12:46:25PM -0400, Richard Guy Briggs wrote:
> On 2021-04-30 18:09, Christian Brauner wrote:
> > On Fri, Apr 30, 2021 at 11:24:00AM -0400, Richard Guy Briggs wrote:
> > > On 2021-04-23 13:10, Christian Brauner wrote:
> > > > From: Christian Brauner <christian.brauner@ubuntu.com>
> > > > 
> > > > Test that openat2() rejects unknown flags in the upper 32 bit range.
> > > > 
> > > > Cc: Richard Guy Briggs <rgb@redhat.com>
> > > > Cc: Aleksa Sarai <cyphar@cyphar.com>
> > > > Cc: linux-fsdevel@vger.kernel.org
> > > > Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> > > > ---
> > > >  tools/testing/selftests/openat2/openat2_test.c | 7 ++++++-
> > > >  1 file changed, 6 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/tools/testing/selftests/openat2/openat2_test.c b/tools/testing/selftests/openat2/openat2_test.c
> > > > index 381d874cce99..7379e082a994 100644
> > > > --- a/tools/testing/selftests/openat2/openat2_test.c
> > > > +++ b/tools/testing/selftests/openat2/openat2_test.c
> > > > @@ -155,7 +155,7 @@ struct flag_test {
> > > >  	int err;
> > > >  };
> > > >  
> > > > -#define NUM_OPENAT2_FLAG_TESTS 24
> > > > +#define NUM_OPENAT2_FLAG_TESTS 25
> > > >  
> > > >  void test_openat2_flags(void)
> > > >  {
> > > > @@ -229,6 +229,11 @@ void test_openat2_flags(void)
> > > >  		{ .name = "invalid how.resolve and O_PATH",
> > > >  		  .how.flags = O_PATH,
> > > >  		  .how.resolve = 0x1337, .err = -EINVAL },
> > > > +
> > > > +		/* Invalid flags in the upper 32 bits must be rejected. */
> > > > +		{ .name = "invalid flags (1 << 63)",
> > > > +		  .how.flags = O_RDONLY | (1ULL << 63),
> > > > +		  .how.resolve = 0, .err = -EINVAL },
> > > 
> > > This doesn't appear to specifically test for flags over 32 bits.  It
> > > appears to test for flags not included in VALID_OPEN_FLAGS.
> > > 
> > > "1ULL << 2" would accomplish the same thing, as would "1ULL << 31" due
> > > to the unused flags in the bottom 32 bits.
> > > 
> > > The test appears to be useful, but misnamed.
> > 
> > I mean we can name it test "currently unknown upper bit".
> > 
> > > 
> > > If a new flag was added at 1ULL << 33, this test wouldn't notice and it
> > 
> > It isn't supposed to notice because it's a known flag. If we add
> > #define O_FANCY (1ULL << 63)
> > this test should fail and either would need to be adapted or more likely
> > be dropped since all bits are taken apparently.
> 
> If that O_FANCY was added to VALID_OPEN_FLAGS, then this test would fail
> to fail since the check in build_open_flags() would have no problem with
> it.

Right but that's perfectly fine and just means you need to update the
test. That's why this is 1ULL << 63 which moves this way into the
future.

> 
> > > would still get dropped in build_open_flags() when flags gets assigned
> > > to op->open_flags.
> > 
> > I didn't intend to add a test whether flags are silently dropped. I
> > intended to add a test whether any currently unkown bit in the upper 32
> > bits is loudly rejected instead of silently ignored.
> 
> It appears to be testing for unknown flags regardless of where they are
> in the 64 bits, since the incoming flags are tested against
> VALID_OPEN_FLAGS.

I fail to see the fundamental issue (even with the name) but I happily
rename it to "currently unknown bit in upper 32 bits rejected" to
indicate that.

> 
> > I may misunderstand what kind of test you would like to see here.
> 
> I think we need two tests:
> 
> 1) test for unknown flags
> 2) test for flags that will get dropped in build_open_flags() by the
> assignment from (u64) how->flags to (int) op->open_flag.
> 
> This second test could be a BUILD_* test.

Yes, that makes sense. Thank you.
I think that can be a build test based on VALID_OPEN_FLAGS. I think the
assumption that any new flag needs to be added to this define is
perfectly fine?

Christian
