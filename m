Return-Path: <linux-fsdevel+bounces-24032-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27C19937D6A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jul 2024 22:49:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5FC7281DCA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jul 2024 20:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7443C148319;
	Fri, 19 Jul 2024 20:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ARw3dmiL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E851B86EC;
	Fri, 19 Jul 2024 20:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721422171; cv=none; b=F5wCDIsuhEUoFLsUP9pL/DIRBTFJfX43oK2fCH72REH7TKbmoMJ1VDwbVwWqBnWL3QQoKvQE0coxUWG6pLCjk4P87L/JDh4DmZKK7Za7lUdQnUl79fUs+IbFmSqDHuWvQ1rB/42Y+wEwjfKPZcXXmgWZZbbZRyqISPmXtOyZtnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721422171; c=relaxed/simple;
	bh=wyRlpQ4hI7FapDcQRHRoxYiLS9yDAfcb74CF9XRKd/U=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=tIInE/6tmkug9xqJaWkAt8T16DdAew6NvYfuMhCTlJEB69hXjhybTr2/9qSVi0hzTH5cal9/FwWoHI9A8vhJ42zU+zCzechCLkdAcz5AzJHgMnj0VKF+l7GB5UAYOC7HbfZJk0ZgeJpAubJXxYIUA7g/JQyn/0zUAtVW2qHx3TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ARw3dmiL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE586C32782;
	Fri, 19 Jul 2024 20:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1721422171;
	bh=wyRlpQ4hI7FapDcQRHRoxYiLS9yDAfcb74CF9XRKd/U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ARw3dmiLOIKrSELhjaymX8Ec0t62FW/yv2qGsNLIVnTEY0ad7MRuqYkOp7g7WUQhO
	 IHJqeQHpq7Y+ohflT/VP9f9vl0SaEwBdlMxn3PXXb+bF7+pCyBfWp0nsTUI0jmEQjH
	 INORm0NlZBmMiRKWKzLbWhkR7de52He+LJ0JBis8=
Date: Fri, 19 Jul 2024 13:49:30 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, Vlastimil Babka <vbabka@suse.cz>, Matthew Wilcox
 <willy@infradead.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Christian
 Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Eric Biederman
 <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>, Suren Baghdasaryan
 <surenb@google.com>, SeongJae Park <sj@kernel.org>, Shuah Khan
 <shuah@kernel.org>, Brendan Higgins <brendanhiggins@google.com>, David Gow
 <davidgow@google.com>, Rae Moar <rmoar@google.com>
Subject: Re: [PATCH v2 0/7] Make core VMA operations internal and testable
Message-Id: <20240719134930.db9f6ce24a52b9bd6416e688@linux-foundation.org>
In-Reply-To: <8768fe2a-e4f7-4831-b608-cb3d21556534@lucifer.local>
References: <cover.1720121068.git.lorenzo.stoakes@oracle.com>
	<8a2e590e-ff4c-4906-b229-269cd7c99948@lucifer.local>
	<20240710195408.c14d80b73e58af6b73be6376@linux-foundation.org>
	<3sdist4b5ojz2iyatqgtngilrkudb63i7b6kp3aeeufl3vrnt6@p4icz5igbsix>
	<8768fe2a-e4f7-4831-b608-cb3d21556534@lucifer.local>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 19 Jul 2024 11:52:00 +0100 Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:

> > > It's really big and it's quite new and it's really late.  I think it best to await the
> > > next -rc cycle, see how much grief it all causes.
> >
> > Yes, this patch set is huge.
> >
> > It is, however, extremely necessary to get to the point where we can
> > test things better than full system tests (and then wait for a distro to
> > rebuild all their rpms and find a missed issue).  I know a lot of people
> > would rather see everything in a kunit test, but the reality is that, at
> > this level in the kernel, we cannot test as well as we can with the
> > userspace approach.
> >
> > With the scope of the change, it will be a lot of work to develop in
> > parallel and rebase on top of the moving of this code.  I'm wondering if
> > you can provide some more information on your plan?  Will this be the
> > first series in your mm-unstable branch after the release? iow, should I
> > be developing on top of the code moving around for my future work?  I am
> > happy enough to rebase my in-flight MAP_FIXED patches on top of this set
> > if that helps things along.
> >
> > Thanks,
> > Liam
> 
> Thanks Liam!
> 
> I think best way forward unless you feel we should take a different
> approach Andrew is for me to simply wait until the end of the merge window
> and at the start of the week after rebase on 6.11-rc1 and do a resend?

How about you send out a version early next week and I'll aim to send
it in to Linus late in this merge window?

