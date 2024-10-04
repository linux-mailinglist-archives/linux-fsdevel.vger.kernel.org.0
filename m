Return-Path: <linux-fsdevel+bounces-30929-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43CC498FCE0
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 06:57:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 006C41F23082
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 04:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50B0A4DA00;
	Fri,  4 Oct 2024 04:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="aWOxfsTF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA874D59F
	for <linux-fsdevel@vger.kernel.org>; Fri,  4 Oct 2024 04:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728017821; cv=none; b=N4i1ooLMgvvvIN6PGWoFQDzdeuEhx+GblULdwqf35FZcA9MKKvab+IthfTRKERxsTKT1We2gLz185BJ2VjyYqwuouyRkp33HhCT2Bj+XOrAci7BialDZa5F0NaZ4n6mkP1FyT1JjTTLUfFKjPBeNNRYNv7+LaYZ40gdI5utbiRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728017821; c=relaxed/simple;
	bh=hFhgqXpDKqNj9K2zODynENExrPCnO8JIBxCkfaWlQAU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=hp3NTqqSvQJ9OczBwG8/acZKjfXfTvenTYKK8ekoo/ZhBUhW3AsPyNyuH54uzgollsY4Dp8LJbKqS15CKzcpGJBQEUDFJCc0OHq8vzjOoDtpe6JiPTh81+HfI3D78C+n9iCy57eeOFN4bjFCEpCqieoQbBE3a7ZdswMLsXQP/F0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=aWOxfsTF; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=zuci2qW6deOTuuAzXjzkRKSa1nyPsYyXv8/KbY63LFM=; b=aWOxfsTF/arS9Znqc8pU+QZEkW
	Ff1ArW8KLQA1N795lxN8NAKPQytcmIgBd4dqQugzKfMc6+ihZEQmV8RaO3JGrVxKV0fMmePExr7oT
	E+4r0jofS0pBAWYMloELY/p23AbkDtI3R7+GrOzD1NSpW/9fWFDNXP+uDyxepw4hg2J3zXrYKebzR
	sLFNzyENGBU6lFLTWMzJ+U4jRreuneK6eJOn/QqwNNmR6rAoJ2KgAfAC8manpgXHv6c7+UPp1QOOA
	9MD8Fb+iD/H9+QXk5qRMePun/D7o5IFgkjttvXpm1KEvSo21/qCZgPT6n8C6OB2fHxN6WyiMU1hX9
	Q7HnLQsw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1swaN6-00000000fqE-41oB;
	Fri, 04 Oct 2024 04:56:56 +0000
Date: Fri, 4 Oct 2024 05:56:56 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org
Subject: [git pull] missed close_range() fix from back in August...
Message-ID: <20241004045656.GP4017910@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>

My apologies - I thought I'd sent it back in late August, but it had
fallen through the cracks ;-/  Sat in -next all along, rebased verbatim
to 6.12-rc1 and sat in -next in that form since Oct 1.

The following changes since commit 9852d85ec9d492ebef56dc5f229416c925758edc:

  Linux 6.12-rc1 (2024-09-29 15:06:19 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-fixes

for you to fetch changes up to 678379e1d4f7443b170939525d3312cfc37bf86b:

  close_range(): fix the logics in descriptor table trimming (2024-09-29 21:52:29 -0400)

----------------------------------------------------------------
close_range(): fix the logics in descriptor table trimming

----------------------------------------------------------------
Al Viro (1):
      close_range(): fix the logics in descriptor table trimming

 fs/file.c               | 95 ++++++++++++++++++-------------------------------
 include/linux/fdtable.h |  8 ++---
 kernel/fork.c           | 32 ++++++++---------
 3 files changed, 52 insertions(+), 83 deletions(-)

