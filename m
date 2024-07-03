Return-Path: <linux-fsdevel+bounces-23079-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69CF4926C22
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jul 2024 00:56:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24DCD284A9D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jul 2024 22:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A81031946AD;
	Wed,  3 Jul 2024 22:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XXYwWVqc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 070DA191F6E;
	Wed,  3 Jul 2024 22:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720047402; cv=none; b=XbrgqbNc1sNIBLodAtNA5hC09v/Fg2CPbfzy9M9iRCW1yAsmVcmQAqzZ5lMRHkj4cQOfGcneoxaYmXSvVpGV+TycDL9SkZeuQ9Uocog9fPsI10V3rL0iA1197PAXZvrt1I6YkpBL9LUYp0loNFXp7DJrTBG4JJ0z5HmeQkGRKG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720047402; c=relaxed/simple;
	bh=Yat0dK/GhlDCw3tceD2Z/jjY0MWRMnghoD2FZYxbUcA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HdnEJ4P1vwC+Hkq8Rxv/h2/yXSecHUZesumoM48IhYmkuqqiZjMLq61AlNrN2BAOKhLXBV8MxIZcHRyWjgvYSqnMVpTo42Xj70KowBKORC/eyN9xUedXcDiItNg/nN8XJ08YTX17+YWzttMldV5+ddZGMiNYEV+G8mB77GuHW6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XXYwWVqc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35D60C2BD10;
	Wed,  3 Jul 2024 22:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720047401;
	bh=Yat0dK/GhlDCw3tceD2Z/jjY0MWRMnghoD2FZYxbUcA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XXYwWVqc3CV0XkQTLD4cWmjKk0wybWM5sGbLpuQhSvQ3bIot1RH1W2lVcT720kwPR
	 6gyQSNFj8vyx66ztit/JwRPYaBk6ZFYvp37tClSqpNRLkAzYwcJTteIp/2ovY7T+Zm
	 4QdEicx1aEjbCC1dPU55prGCONCM92aewgc02/hhjPg4bck9Q1YCkPBqtB79t9Zep/
	 FgyUn4ke0RDsrMYFOG3A/y2pBBpoErW9kEtp8t1UY8GeBu3nNUYUJ3Bv2MCYw4GDzK
	 zES3yr87WT37H8E7ZIPCNoZBEI0ZTcpbJebiqryqdfqVxhaq+tEBjn5Wkx6bezb8zT
	 Zpi+RT5U+DelA==
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
Date: Wed,  3 Jul 2024 15:56:36 -0700
Message-Id: <20240703225636.90190-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <1a41caa5-561e-415f-85f3-01b52b233506@lucifer.local>
References: 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 3 Jul 2024 21:33:00 +0100 Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:

> On Wed, Jul 03, 2024 at 01:26:53PM GMT, Andrew Morton wrote:
> > On Wed,  3 Jul 2024 12:57:31 +0100 Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:
> >
> > > Kernel functionality is stubbed and shimmed as needed in tools/testing/vma/
> > > which contains a fully functional userland vma_internal.h file and which
> > > imports mm/vma.c and mm/vma.h to be directly tested from userland.
> >
> > Cool stuff.
> 
> Thanks :)
> 
> >
> > Now we need to make sure that anyone who messes with vma code has run
> > the tests.  And has added more testcases, if appropriate.
> >
> > Does it make sense to execute this test under selftests/ in some
> > fashion?  Quite a few people appear to be running the selftest code
> > regularly and it would be good to make them run this as well.
> 
> I think it will be useful to do that, yes, but as the tests are currently a
> skeleton to both provide the stubbing out and to provide essentially an
> example of how you might test (though enough that it'd now be easy to add a
> _ton_ of tests), it's not quite ready to be run just yet.

If we will eventually move the files under selftests/, why dont' we place the
files there from the beginning?  Is there a strict rule saying files that not
really involved with running tests or not ready cannot be added there?  If so,
could adding the files after the tests are ready to be run be an option?
Cc-ing Shuah since I think she might have a comment.

Also, I haven't had enough time to read the patches in detail but just the
cover letter a little bit.  My humble impression from that is that this might
better to eventually be kunit tests.  I know there was a discussion with Kees
on RFC v1 [1] which you kindly explained why you decide to implement this in
user space.  To my understanding, at least some of the problems are not real
problems.  For two things as examples,

1. I understand that you concern the test speed [2].  I think Kunit could be
slower than the dedicated user space tests, but to my experience, it's not that
bad when using the default UML-based execution.

2. My next humble undrestanding is that you want to test functions that you
don't want to export [2,3] to kernel modules.  To my understanding it's not
limited on Kunit.  I'm testing such DAMON functions using KUnit by including
test code in the c file but protecting it via a config.  For an example, please
refer to DAMON_KUNIT_TEST.

I understand above are only small parts of the reason for your decision, and
some of those would really unsupported by Kunit.  In the case, I think adding
this user space tests as is is good.  Nonetheless, I think it would be good to
hear some comments from Kunit developers.  IMHO, letting them know the
limitations will hopefully help setting their future TODO items.  Cc-ing
Brendan, David and Rae for that.

To recap, I have no strong opinions about this patch, but I think knowing how
Selftests and KUnit developers think could be helpful.


[1] https://lore.kernel.org/202406270957.C0E5E8057@keescook
[2] https://lore.kernel.org/5zuowniex4sxy6l7erbsg5fiirf4d4f5fbpz2upay2igiwa2xk@vuezoh2wbqf4
[3] https://lore.kernel.org/f005a7b0-ca31-4d39-b2d5-00f5546d610a@lucifer.local


Thanks,
SJ

[...]

