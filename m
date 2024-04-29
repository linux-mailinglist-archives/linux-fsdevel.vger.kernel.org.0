Return-Path: <linux-fsdevel+bounces-18070-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 490D98B525A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 09:30:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A11C1C21346
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 07:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C903914A83;
	Mon, 29 Apr 2024 07:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="H8CSOms1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9413313FE7
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Apr 2024 07:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714375829; cv=none; b=kQcRXnrsQjovBcmjOZqkBY+b7NyNlH47+rdkAygK+90d3UJmKTaTKRmq6oZYsgUnmRHh/aLy3mrztBTkQoixp5v+23cTH9K/yNpcWy8uueoj9TDj8jwWB6EwPQT3YJHorZB5NTK3lyLZrzWRoHmWliAaXROsKlUAWeTBWLgQZFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714375829; c=relaxed/simple;
	bh=abiLjfbVYT1PCT8XRlCX9O4WSfYiaoIRAzu9ILdzJ2w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QgwYPGWLJxVZ6w7PpR+1rdGJsdybv3Ylv3etOR2pZfuY6sBmbI5JH39/8FB6R7zdf1bdIURIjd9yaApbdthlzZoNHC1TbliFQHb2QQQdESedJekd9wVFprRa+JYD0ixnZw4m7NLddZ9nzz6QjwabAL9ycOXeKmuguwJoxrhHoKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=H8CSOms1; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1714375824;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7wClpp3ytBXqx6FuSYlOnTSoe8yKiqfJfSI+cFyyNaw=;
	b=H8CSOms1feJGszTeR+vBaTEQtjXR5FxreTPVPjzizsrz37isE0gqaQT4IzQxHynsstrhja
	v2EEbIntUxkwwMcQLN/tnVtJX5k2tikAwVt/DB0Akiwn5IspaBpnIWDt1ApqlVA6EwAT5I
	5eqsj+z2JukScCjiI04eWaCYkU2EULs=
From: Kent Overstreet <kent.overstreet@linux.dev>
To: linux-bcachefs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Kent Overstreet <kent.overstreet@linux.dev>
Subject: [PATCH] bcachefs: Developer guide
Date: Mon, 29 Apr 2024 03:29:55 -0400
Message-ID: <20240429072957.3103483-1-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 .../filesystems/bcachefs/developer-guide.rst  | 177 ++++++++++++++++++
 Documentation/filesystems/bcachefs/index.rst  |   1 +
 2 files changed, 178 insertions(+)
 create mode 100644 Documentation/filesystems/bcachefs/developer-guide.rst

diff --git a/Documentation/filesystems/bcachefs/developer-guide.rst b/Documentation/filesystems/bcachefs/developer-guide.rst
new file mode 100644
index 000000000000..47e851c3fba5
--- /dev/null
+++ b/Documentation/filesystems/bcachefs/developer-guide.rst
@@ -0,0 +1,177 @@
+Good development is like gardening, and codebases are our gardens. Tend to them
+every day; look for little things that are out of place or in need of tidying.
+A little weeding here and there goes a long way; don't wait until things have
+spiraled out of control.
+
+Things don't always have to be perfect - nitpicking often does more harm than
+good. But appreciate beauty when you see it - and let people know.
+
+The code that you are afraid to touch is the code most in need of refactoring.
+
+A little organizing here and there goes a long way.
+
+Put real thought into how you organize things.
+
+Good code is readable code, where the structure is simple and leaves nowhere
+for bugs to hide.
+
+Assertions are one of our most important tools for writing reliable code. If in
+the course of writing a patchset you encounter a condition that shouldn't
+happen (and will have unpredictable or undefined behaviour if it does), or
+you're not sure if it can happen and not sure how to handle it yet - make it a
+BUG_ON(). Don't leave undefined or unspecified behavior lurking in the codebase.
+
+By the time you finish the patchset, you should understand better which
+assertions need to be handled and turned into checks with error paths, and
+which should be logically impossible. Leave the BUG_ON()s in for the ones which
+are logically impossible. (Or, make them debug mode assertions if they're
+expensive - but don't turn everything into a debug mode assertion, so that
+we're not stuck debugging undefined behaviour should it turn out that you were
+wrong).
+
+Assertions are documentation that can't go out of date. Good assertions are
+wonderful.
+
+Good assertions drastically and dramatically reduce the amount of testing
+required to shake out bugs.
+
+Good assertions are based on state, not logic. To write good assertions, you
+have to think about what the invariants on your state are.
+
+Good invariants and assertions will hold everywhere in your codebase. This
+means that you can run them in only a few places in the checked in version, but
+should you need to debug something that caused the assertion to fail, you can
+quickly shotgun them everywhere to find the codepath that broke the invariant.
+
+A good assertion checks something that the compiler could check for us, and
+elide - if we were working in a language with embedded correctness proofs that
+the compiler could check. This is something that exists today, but it'll likely
+still be a few decades before it comes to systems programming languages. But we
+can still incorporate that kind of thinking into our code and document the
+invariants with runtime checks - much like the way people working in
+dynamically typed languages may add type annotations, gradually making their
+code statically typed.
+
+Looking for ways to make your assertions simpler - and higher level - will
+often nudge you towards making the entire system simpler and more robust.
+
+Good code is code where you can poke around and see what it's doing -
+introspection. We can't debug anything if we can't see what's going on.
+
+Whenever we're debugging, and the solution isn't immediately obvious, if the
+issue is that we don't know where the issue is because we can't see what's
+going on - fix that first.
+
+We have the tools to make anything visible at runtime, efficiently - RCU and
+percpu data structures among them. Don't let things stay hidden.
+
+The most important tool for introspection is the humble pretty printer - in
+bcachefs, this means `*_to_text()` functions, which output to printbufs.
+
+Pretty printers are wonderful, because they compose and you can use them
+everywhere. Having functions to print whatever object you're working with will
+make your error messages much easier to write (therefore they will actually
+exist) and much more informative. And they can be used from sysfs/debugfs, as
+well as tracepoints.
+
+Error messages should, whenever possible, tell you everything you need to debug
+the issue. It's worth putting effort into them.
+
+Tracepoints shouldn't be the first thing you reach for. They're an important
+tool, but always look for more immediate ways to make things visible. When we
+have to rely on tracing, we have to know which tracepoints we're looking for,
+and then we have to run the troublesome workload, and then we have to sift
+through logs. This is a lot of steps to go through when a user is hitting
+something, and if it's intermittent it may not even be possible.
+
+The humble counter is an incredibly useful tool. They're cheap and simple to
+use, and many complicated internal operations with lots of things that can
+behave weirdly (anything involving memory reclaim, for example) become
+shockingly easy to debug once you have counters on every distinct codepath.
+
+Persistent counters are even better.
+
+When debugging, try to get the most out of every bug you come across; don't
+rush to fix the initial issue. Look for things that will make related bugs
+easier the next time around - introspection, new assertions, better error
+messages, new debug tools, and do those first. Look for ways to make the system
+better behaved; often one bug will uncover several other bugs through
+downstream effects.
+
+Fix all that first, and then the original bug first - even if that means
+keeping a user waiting. They'll thank you in the long run, and when they
+understand what you're doing you'll be amazed at how patient they're happy to
+be. Users like to help - otherwise they wouldn't be reporting the bug in the
+first place.
+
+Talk to your users. Don't isolate yourself.
+
+Users notice all sorts of interesting things, and by just talking to them and
+interacting with them you can benefit from their experience.
+
+Spend time doing support and helpdesk stuff. Don't just write code - code isn't
+finished until it's being used trouble free.
+
+This will also motivate you to make your debugging tools as good as possible,
+and perhaps even your documentation, too. Like anything else in life, the more
+time you spend at it the better you'll get, and you the developer are the
+person most able to improve the tools to make debugging quick and easy.
+
+Be wary of how you take on and commit to big projects. Don't let development
+become product-manager focused. Often time an idea is a good one but needs to
+wait for its proper time - but you won't know if it's the proper time for an
+idea until you start writing code.
+
+Expect to throw a lot of things away, or leave them half finished for later.
+Nobody writes all perfect code that all gets shipped, and you'll be much more
+productive in the long run if you notice this early and shift to something
+else. The experience gained and lessons learned will be valuable for all the
+other work you do.
+
+But don't be afraid to tackle projects that require significant rework of
+existing code. Sometimes these can be the best projects, because they can lead
+us to make existing code more general, more flexible, more multipurpose and
+perhaps more robust. Just don't hesitate to abandon the idea if it looks like
+it's going to make a mess of things.
+
+Complicated features can often be done as a series of refactorings, with the
+final change that actually implements the feature as a quite small patch at the
+end. It's wonderful when this happens, especially when those refactorings are
+things that improve the codebase in their own right. When that happens there's
+much less risk of wasted effort if the feature you were going for doesn't work
+out.
+
+Always strive to work incrementally. Always strive to turn the big projects
+into little bite sized projects that can prove their own merits.
+
+Instead of always tackling those big projects, look for little things that
+will be useful, and make the big projects easier.
+
+The question of what's likely to be useful is where junior developers most
+often go astray - doing something because it seems like it'll be useful often
+leads to overengineering. Knowing what's useful comes from many years of
+experience, or talking with people who have that experience - or from simply
+reading lots of code and looking for common patterns and issues. Don't be
+afraid to throw things away and do something simpler.
+
+Talk about your ideas with your fellow developers; often times the best things
+come from relaxed conversations where people aren't afraid to say "what if?".
+
+Don't neglect your tools.
+
+The most important tools (besides the compiler and our text editor) are the
+tools we use for testing. The shortest possible edit/test/debug cycle is
+essential for working productively. We learn, gain experience, and discover the
+errors in our thinking by running our code and seeing what happens. If your
+time is being wasted because your tools are bad or too slow - don't accept it,
+fix it.
+
+Put effort into your documentation, commmit messages, and code comments - but
+don't go overboard. A good commit message is wonderful - but if the information
+was important enough to go in a commit message, ask yourself if it would be
+even better as a code comment.
+
+A good code comment is wonderful, but even better is the comment that didn't
+need to exist because the code was so straightforward as to be obvious;
+organized into small clean and tidy modules, with clear and descriptive names
+for functions and variable, where every line of code has a clear purpose.
diff --git a/Documentation/filesystems/bcachefs/index.rst b/Documentation/filesystems/bcachefs/index.rst
index e2bd61ccd96f..7fb8d54e150a 100644
--- a/Documentation/filesystems/bcachefs/index.rst
+++ b/Documentation/filesystems/bcachefs/index.rst
@@ -8,4 +8,5 @@ bcachefs Documentation
    :maxdepth: 2
    :numbered:
 
+   developer-guide
    errorcodes
-- 
2.43.0


