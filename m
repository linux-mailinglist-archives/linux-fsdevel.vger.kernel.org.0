Return-Path: <linux-fsdevel+bounces-23081-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B70A1926CC0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jul 2024 02:31:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3E4E1C21C22
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jul 2024 00:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A5024C8E;
	Thu,  4 Jul 2024 00:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ckBodjt9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A1638C;
	Thu,  4 Jul 2024 00:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720053068; cv=none; b=I/g3anqGfWjohD8VNUPi6eKnpSkn/ydLl2zL3Z8IDoWIPVh9dgrFHPpA6eauMvWpLqpv05LthwlRKOMLTMHShW096XaSNyAO+b4zmyDoL8yrLqRSDL6KPC2dYGwZyjGmIWxywzEguKDCYpwxL0wZ82ImhOrsQVQCG3npUdRw/u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720053068; c=relaxed/simple;
	bh=OCSlpA0xUjy0FM75x+w+MK0yXeQZ1m/eWOyDdcH3YfQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=f+l+GOb3mTWohufpQoQYZrIfYduywBRD/GX8lWM/9foFYuX4RS8ZEDhw6BuddqlN6vS5ix5qYqSlpeL3brpaf+V+wUjL4BtUD/5vAM9tmBDV+dZ16//T2hz9UeFIp+5Cma1THuFfyNxCBy+KN46mlJFZeWFupEtjGnggVF3dKcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ckBodjt9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A058C2BD10;
	Thu,  4 Jul 2024 00:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720053068;
	bh=OCSlpA0xUjy0FM75x+w+MK0yXeQZ1m/eWOyDdcH3YfQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ckBodjt9BYfV2CpKs4tR1O6u4JF8kP4JstM6hr4KHGtNkLcxGq/8N0dT7c/SwAtzk
	 /Qh+XCLbGeWS7sRp4K1VX0jcIbsoIFIMPuzdO7+J6vx8/wPpZEaASjjxxEs3tSei8+
	 Fw0fxa1AmLVojKPXhYCEoZ3xwdk9XB7JvbD+mXcc88BGTAgv116n14dMmjImxRo9Bo
	 qsBVuKThbx0ukwzVlg34tIcyltBQ8FPzRnCon1ApHw/dv90/QyDqi2cNJvIfQHA5Zy
	 mEljk0ZVuhz4/Nnle6mAwAgVjg9BB/AqqQ+54jxfWepa1ggvR+EXaZqFmsHCLa+WGG
	 HzsN7hC5e+3BQ==
From: SeongJae Park <sj@kernel.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Matthew Wilcox <willy@infradead.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Eric Biederman <ebiederm@xmission.com>,
	Kees Cook <kees@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Shuah Khan <shuah@kernel.org>,
	Brendan Higgins <brendanhiggins@google.com>,
	David Gow <davidgow@google.com>,
	Rae Moar <rmoar@google.com>
Subject: Re: [PATCH 0/7] Make core VMA operations internal and testable
Date: Wed,  3 Jul 2024 17:31:03 -0700
Message-Id: <20240704003104.90855-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <1edfc11c-ab99-4e9d-bf5d-b10f34b3f1da@lucifer.local>
References: 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 4 Jul 2024 00:24:15 +0100 Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:

> On Wed, Jul 03, 2024 at 03:56:36PM GMT, SeongJae Park wrote:
> > On Wed, 3 Jul 2024 21:33:00 +0100 Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:
> >
> > > On Wed, Jul 03, 2024 at 01:26:53PM GMT, Andrew Morton wrote:
> > > > On Wed,  3 Jul 2024 12:57:31 +0100 Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:
> > > >
> > > > > Kernel functionality is stubbed and shimmed as needed in tools/testing/vma/
> > > > > which contains a fully functional userland vma_internal.h file and which
> > > > > imports mm/vma.c and mm/vma.h to be directly tested from userland.
> > > >
> > > > Cool stuff.
> > >
> > > Thanks :)
> > >
> > > >
> > > > Now we need to make sure that anyone who messes with vma code has run
> > > > the tests.  And has added more testcases, if appropriate.
> > > >
> > > > Does it make sense to execute this test under selftests/ in some
> > > > fashion?  Quite a few people appear to be running the selftest code
> > > > regularly and it would be good to make them run this as well.
> > >
> > > I think it will be useful to do that, yes, but as the tests are currently a
> > > skeleton to both provide the stubbing out and to provide essentially an
> > > example of how you might test (though enough that it'd now be easy to add a
> > > _ton_ of tests), it's not quite ready to be run just yet.
> >
> > If we will eventually move the files under selftests/, why dont' we place the
> > files there from the beginning?  Is there a strict rule saying files that not
> > really involved with running tests or not ready cannot be added there?  If so,
> > could adding the files after the tests are ready to be run be an option?
> > Cc-ing Shuah since I think she might have a comment.
[...]
> My point to Andrew was that we could potentially automatically run these
> tests as part of a self-test run as they are so quick, at least in the
> future, if that made sense.

Ok, I think I was misunderstanding your point on the reply to Andrew.  I was
thinking you will eventually move the tests to selftests, but not for now, only
because it is not ready to run.  I understand your points now.

> 
> >
> > Also, I haven't had enough time to read the patches in detail but just the
> > cover letter a little bit.  My humble impression from that is that this might
> > better to eventually be kunit tests.  I know there was a discussion with Kees
> > on RFC v1 [1] which you kindly explained why you decide to implement this in
> > user space.  To my understanding, at least some of the problems are not real
> > problems.  For two things as examples,
> 
> They are real problems. And I totally disagree that these should be kunit
> tests. I'm surprised you didn't find my and Liam's arguments compelling?
> 
> I suggest you try actually running tools/testing/vma/vma and putting a
> break point in gdb in vma_merge(), able to observe all state in great
> detail with no interrupts and see for yourself.
> 
> >
> > 1. I understand that you concern the test speed [2].  I think Kunit could be
> > slower than the dedicated user space tests, but to my experience, it's not that
> > bad when using the default UML-based execution.
> 
> I'm sorry but running VMA code in the smallest possible form in userland is
> very clearly faster and you are missing the key point that we can _isolate_
> anything we _don't need_.
> 
> There's no setup/teardown whatsoever, no clever tricks needed, we get to
> keep entirely internal interfaces internal and clean. It's compelling.
> 
> You are running the code as fast as you possibly can and that allows for
> lots of interesting things like being able to fuzz at scale, being able to
> run thousands of cases with basically zero setup/teardown or limits,
> etc. etc.

I read this from the previous thread, and this is really cool.  I was thinking
it would be really nice if more kernel subsystems and features be able to do
this kind of great testing with minimum duplicated efforts.  That was one of
the motivations of my previous reply.

> 
> Also, it's basically impossible to explicitly _unit_ test vma merge and vma
> split and friends without invoking kernel stuff like TLB handling, MMU
> notifier, huge page handling, process setup/teardown, mm setup/teardown,
> rlimits, anon vma name handling, uprobes, memory policy handling, interval
> tree handling, lock contention, THP behaviour, etc. etc. etc.
> 
> With this test we can purely _unit_ test these fundamental operations, AND
> have the ability to for example in future - dump maple tree state from a
> buggy kernel situation that would result in a panic for instance - and
> recreate it immediately for debug.
> 
> We also then have the ability to have strong guarantees about the behaviour
> of these operations at a fundamental level.
> 
> If we want _system_ tests that bring in other kernel components then it
> makes more sense to use kunit/selftests. But this offers something else.

As I also previously mentioned, I was assuming you made the decision to not use
KUnit based on real limitations of KUnit you found.  Thank you so much for this
detailed explanations with nice examples.

[...]
> > To recap, I have no strong opinions about this patch, but I think knowing how
> > Selftests and KUnit developers think could be helpful.
> 
> With respect it strikes me that you have rather strong feelings on
> this. But again I make the plea that we don't hold this up on the basis of
> a debate about this vs. other options re: testing.

No worry, I'm not willing to delay this work with unnecessary discussions.
That's why I'm saying I have no strong opinion.  I'm rather regret that I don't
have enough time to get a credit on this great work by reading the details and
provide my Reviewed-by:.

What I want to say is that it would be nice to ensure the developers of
Kselftest and Kunit, who obviously have experiences on testing, get a chance to
be involved in this discussion.  I believe that would be nice since they might
find something we're misunderstanding about Kselftest and/or Kunit.  Also they
might find some unknown limitations of Kselftest and/or Kunit that you found.
I personally hope it is the latter case and it helps evolving KUnit, so that
not only vma but also other kernel subsystems and features be able to enhance
their test setups with minimum efforts.

Again, I don't think such discussions and possible future works sould be
blockers of this work.

> 
> Kees was agreeable with this approach so I don't think we should really see
> too much objection to this.

You're right.  Nonetheless, I found the mail is not Cc-ing KUnit developers,
and then I thought giving KUnit developers more chances to be involved would be
nice.


Thanks,
SJ

[...]

