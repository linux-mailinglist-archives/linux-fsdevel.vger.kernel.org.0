Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C43B788D94
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Aug 2023 19:08:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344184AbjHYRHj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Aug 2023 13:07:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344182AbjHYRHJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Aug 2023 13:07:09 -0400
Received: from smtp-190a.mail.infomaniak.ch (smtp-190a.mail.infomaniak.ch [IPv6:2001:1600:4:17::190a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6131410D
        for <linux-fsdevel@vger.kernel.org>; Fri, 25 Aug 2023 10:07:06 -0700 (PDT)
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4RXRFh6x6TzMpnn4;
        Fri, 25 Aug 2023 17:07:04 +0000 (UTC)
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4RXRFh2KmpzMpp9v;
        Fri, 25 Aug 2023 19:07:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1692983224;
        bh=zCI9rThMupAPOQMoDWypft1uJQGAltZHayzbrpdhdnw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QUS/ad0ysS+hFWj2TRsdapIrWLBCuenE76xQOYM4DVXQ+v3y/QUSOf3UgJTFfrkkN
         j5BDxpJzvXgK6UQg4VgC98YId7cr4GwRCbfNA5hG5PWXiEQMrQO8y6bBBjfIpesp/P
         WRQKjvJhR87qg+Fo8FZ4gccHSCoTJeQ5CpzD72Co=
Date:   Fri, 25 Aug 2023 19:07:01 +0200
From:   =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To:     =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
Cc:     linux-security-module@vger.kernel.org, Jeff Xu <jeffxu@google.com>,
        Jorge Lucangeli Obes <jorgelo@chromium.org>,
        Allen Webb <allenwebb@google.com>,
        Dmitry Torokhov <dtor@google.com>,
        Paul Moore <paul@paul-moore.com>,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        Matt Bobrowski <repnop@google.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 2/5] selftests/landlock: Test ioctl support
Message-ID: <20230825.ohtoh6aivahX@digikod.net>
References: <20230814172816.3907299-1-gnoack@google.com>
 <20230814172816.3907299-3-gnoack@google.com>
 <20230818.HopaLahS0qua@digikod.net>
 <ZOjN7dub5QGJOzSX@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZOjN7dub5QGJOzSX@google.com>
X-Infomaniak-Routing: alpha
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 25, 2023 at 05:51:09PM +0200, Günther Noack wrote:
> Hello!
> 
> On Fri, Aug 18, 2023 at 07:06:07PM +0200, Mickaël Salaün wrote:
> > On Mon, Aug 14, 2023 at 07:28:13PM +0200, Günther Noack wrote:
> > > @@ -3639,7 +3639,7 @@ TEST_F_FORK(ftruncate, open_and_ftruncate)
> > >  	};
> > >  	int fd, ruleset_fd;
> > >  
> > > -	/* Enable Landlock. */
> > > +	/* Enables Landlock. */
> > >  	ruleset_fd = create_ruleset(_metadata, variant->handled, rules);
> > >  	ASSERT_LE(0, ruleset_fd);
> > >  	enforce_ruleset(_metadata, ruleset_fd);
> > > @@ -3732,6 +3732,96 @@ TEST(memfd_ftruncate)
> > >  	ASSERT_EQ(0, close(fd));
> > >  }
> > 
> > We should also check with O_PATH to make sure the correct error is
> > returned (and not EACCES).
> 
> Is this remark referring to the code before it or after it?
> 
> My interpretation is that you are asking to test that test_fioqsize_ioctl() will
> return errnos correctly?  Do I understand that correctly?  (I think that would
> be a little bit overdone, IMHO - it's just a test utility of ~10 lines after
> all, which is below the threshold where it can be verified by staring at it for
> a bit. :))

I was refering to the previous memfd_ftruncate test, which is changed
with a next patch. We should check the access rights tied (and checkd)
to FD (i.e. truncate and ioctl) opened with O_PATH.

> 
> > > +/* Invokes the FIOQSIZE ioctl(2) and returns its errno or 0. */
> > > +static int test_fioqsize_ioctl(int fd)
> > > +{
> > > +	loff_t size;
> > > +
> > > +	if (ioctl(fd, FIOQSIZE, &size) < 0)
> > > +		return errno;
> > > +	return 0;
> > > +}
> 
> 
> 
> > > +	dir_s1d1_fd = open(dir_s1d1, O_RDONLY);
> > 
> > You can use O_CLOEXEC everywhere.
> 
> Done.
> 
> 
> > > +	ASSERT_LE(0, dir_s1d1_fd);
> > > +	file1_s1d1_fd = open(file1_s1d1, O_RDONLY);
> > > +	ASSERT_LE(0, file1_s1d1_fd);
> > > +	dir_s2d1_fd = open(dir_s2d1, O_RDONLY);
> > > +	ASSERT_LE(0, dir_s2d1_fd);
> > > +
> > > +	/*
> > > +	 * Checks that FIOQSIZE works on files where LANDLOCK_ACCESS_FS_IOCTL is
> > > +	 * permitted.
> > > +	 */
> > > +	EXPECT_EQ(EACCES, test_fioqsize_ioctl(dir_s1d1_fd));
> > > +	EXPECT_EQ(0, test_fioqsize_ioctl(file1_s1d1_fd));
> > > +	EXPECT_EQ(0, test_fioqsize_ioctl(dir_s2d1_fd));
> > > +
> > > +	/* Closes all file descriptors. */
> > > +	ASSERT_EQ(0, close(dir_s1d1_fd));
> > > +	ASSERT_EQ(0, close(file1_s1d1_fd));
> > > +	ASSERT_EQ(0, close(dir_s2d1_fd));
> > > +}
> > > +
> > > +TEST_F_FORK(layout1, ioctl_always_allowed)
> > > +{
> > > +	struct landlock_ruleset_attr attr = {
> > 
> > const struct landlock_ruleset_attr attr = {
> 
> Done.
> 
> I am personally unsure whether "const" is worth it for local variables, but I am
> happy to abide by whatever the dominant style is.  (The kernel style guide
> doesn't seem to mention it though.)

I prefer to constify as much as possible to be notified when a write
will be needed for a patch. From a security point of view, it's always
good to have as much as possible read-only data, at least in theory (it
might not always be enforced in memory). It's also useful as
documentation.

> 
> BTW, it's somewhat inconsistent within this file already -- we should maybe
> clean this up.

I probably missed some, more constification would be good, but not with
this patch series.

> 
> 
> > > +		.handled_access_fs = LANDLOCK_ACCESS_FS_IOCTL,
> > > +	};
> > > +	int ruleset_fd, fd;
> > > +	int flag = 0;
> > > +	int n;
> > 
> > const int flag = 0;
> > int ruleset_fd, test_fd, n;
> 
> Done.
> 
> Thanks for the review!
> —Günther
> 
> -- 
> Sent using Mutt 🐕 Woof Woof
