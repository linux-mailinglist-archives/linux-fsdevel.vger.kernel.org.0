Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 677A636FF6C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Apr 2021 19:23:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231136AbhD3RXn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Apr 2021 13:23:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:47523 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229750AbhD3RXn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Apr 2021 13:23:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619803374;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IM9ZLrWCzDO7UrznlTqVNpu6QDNVgR9JF+FG4iXzCVQ=;
        b=AbYPfDFA7kkI+LfY+PnP1sT211FnIthh2XpXwhARP4lLaZgrx6HPMCb/TNfT9yrTvtC4m1
        QtSyQU+GS64Q2jT+k+t28UmjFneeVsQBTiLFavsArcEBcq9zRCvRb8026TjkygheYStiYp
        LufLRtAgwyCkJVomctCAANFebO+LJ4Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-460-8lSFMl4dOVeI0-cDermbHg-1; Fri, 30 Apr 2021 13:22:50 -0400
X-MC-Unique: 8lSFMl4dOVeI0-cDermbHg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1C2311008066;
        Fri, 30 Apr 2021 17:22:49 +0000 (UTC)
Received: from madcap2.tricolour.ca (unknown [10.3.128.45])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 190E0101F965;
        Fri, 30 Apr 2021 17:22:43 +0000 (UTC)
Date:   Fri, 30 Apr 2021 13:22:41 -0400
From:   Richard Guy Briggs <rgb@redhat.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 3/3] test: add openat2() test for invalid upper 32 bit
 flag value
Message-ID: <20210430172241.GA3141668@madcap2.tricolour.ca>
References: <20210423111037.3590242-1-brauner@kernel.org>
 <20210423111037.3590242-3-brauner@kernel.org>
 <20210430152400.GY3141668@madcap2.tricolour.ca>
 <20210430160913.mowefxfnrwnoc3vd@wittgenstein>
 <20210430164625.GZ3141668@madcap2.tricolour.ca>
 <20210430170856.4wqsr6on664brl4t@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210430170856.4wqsr6on664brl4t@wittgenstein>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2021-04-30 19:08, Christian Brauner wrote:
> On Fri, Apr 30, 2021 at 12:46:25PM -0400, Richard Guy Briggs wrote:
> > On 2021-04-30 18:09, Christian Brauner wrote:
> > > On Fri, Apr 30, 2021 at 11:24:00AM -0400, Richard Guy Briggs wrote:
> > > > On 2021-04-23 13:10, Christian Brauner wrote:
> > > > > From: Christian Brauner <christian.brauner@ubuntu.com>
> > > > > 
> > > > > Test that openat2() rejects unknown flags in the upper 32 bit range.
> > > > > 
> > > > > Cc: Richard Guy Briggs <rgb@redhat.com>
> > > > > Cc: Aleksa Sarai <cyphar@cyphar.com>
> > > > > Cc: linux-fsdevel@vger.kernel.org
> > > > > Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> > > > > ---
> > > > >  tools/testing/selftests/openat2/openat2_test.c | 7 ++++++-
> > > > >  1 file changed, 6 insertions(+), 1 deletion(-)
> > > > > 
> > > > > diff --git a/tools/testing/selftests/openat2/openat2_test.c b/tools/testing/selftests/openat2/openat2_test.c
> > > > > index 381d874cce99..7379e082a994 100644
> > > > > --- a/tools/testing/selftests/openat2/openat2_test.c
> > > > > +++ b/tools/testing/selftests/openat2/openat2_test.c
> > > > > @@ -155,7 +155,7 @@ struct flag_test {
> > > > >  	int err;
> > > > >  };
> > > > >  
> > > > > -#define NUM_OPENAT2_FLAG_TESTS 24
> > > > > +#define NUM_OPENAT2_FLAG_TESTS 25
> > > > >  
> > > > >  void test_openat2_flags(void)
> > > > >  {
> > > > > @@ -229,6 +229,11 @@ void test_openat2_flags(void)
> > > > >  		{ .name = "invalid how.resolve and O_PATH",
> > > > >  		  .how.flags = O_PATH,
> > > > >  		  .how.resolve = 0x1337, .err = -EINVAL },
> > > > > +
> > > > > +		/* Invalid flags in the upper 32 bits must be rejected. */
> > > > > +		{ .name = "invalid flags (1 << 63)",
> > > > > +		  .how.flags = O_RDONLY | (1ULL << 63),
> > > > > +		  .how.resolve = 0, .err = -EINVAL },
> > > > 
> > > > This doesn't appear to specifically test for flags over 32 bits.  It
> > > > appears to test for flags not included in VALID_OPEN_FLAGS.
> > > > 
> > > > "1ULL << 2" would accomplish the same thing, as would "1ULL << 31" due
> > > > to the unused flags in the bottom 32 bits.
> > > > 
> > > > The test appears to be useful, but misnamed.
> > > 
> > > I mean we can name it test "currently unknown upper bit".
> > > 
> > > > 
> > > > If a new flag was added at 1ULL << 33, this test wouldn't notice and it
> > > 
> > > It isn't supposed to notice because it's a known flag. If we add
> > > #define O_FANCY (1ULL << 63)
> > > this test should fail and either would need to be adapted or more likely
> > > be dropped since all bits are taken apparently.
> > 
> > If that O_FANCY was added to VALID_OPEN_FLAGS, then this test would fail
> > to fail since the check in build_open_flags() would have no problem with
> > it.
> 
> Right but that's perfectly fine and just means you need to update the
> test. That's why this is 1ULL << 63 which moves this way into the
> future.

It is temping to change the test to (-1ULL & ~VALID_OPEN_FLAGS) to catch
any outside what has been expressly defined.  (Not certain about syntax...)

> > > > would still get dropped in build_open_flags() when flags gets assigned
> > > > to op->open_flags.
> > > 
> > > I didn't intend to add a test whether flags are silently dropped. I
> > > intended to add a test whether any currently unkown bit in the upper 32
> > > bits is loudly rejected instead of silently ignored.
> > 
> > It appears to be testing for unknown flags regardless of where they are
> > in the 64 bits, since the incoming flags are tested against
> > VALID_OPEN_FLAGS.
> 
> I fail to see the fundamental issue (even with the name) but I happily
> rename it to "currently unknown bit in upper 32 bits rejected" to
> indicate that.

How about "currently unknown bit rejected"?

> > > I may misunderstand what kind of test you would like to see here.
> > 
> > I think we need two tests:
> > 
> > 1) test for unknown flags
> > 2) test for flags that will get dropped in build_open_flags() by the
> > assignment from (u64) how->flags to (int) op->open_flag.
> > 
> > This second test could be a BUILD_* test.
> 
> Yes, that makes sense. Thank you.
> I think that can be a build test based on VALID_OPEN_FLAGS. I think the
> assumption that any new flag needs to be added to this define is
> perfectly fine?

I don't see how else we can do this other than to throw a runtime error
which will happen anyways the first time userspace tries to use a new
flag that isn't included in VALID_OPEN_FLAGS in the first place, so I
think this is a safe assumption.

> Christian

- RGB

--
Richard Guy Briggs <rgb@redhat.com>
Sr. S/W Engineer, Kernel Security, Base Operating Systems
Remote, Ottawa, Red Hat Canada
IRC: rgb, SunRaycer
Voice: +1.647.777.2635, Internal: (81) 32635

