Return-Path: <linux-fsdevel+bounces-28926-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AC3C97128E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Sep 2024 10:50:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6BFD1C22A28
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Sep 2024 08:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 943041B1D74;
	Mon,  9 Sep 2024 08:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QpltrMX7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35AF1AC887
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Sep 2024 08:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725871811; cv=none; b=pHXe3HX6G23BYS7mEe4nnzC8xN4l5PrnsQ/dq/WjqMmCKw40kpF+87ClCR8W7VJezSWCC9gglnLTON5nu8QFN4NXOp3wRSAjdt9E6qSY0sSm4DefbRq8xE5ixtWCOQKeSLTYIRhp0VFUnb1+sxzYdz+gy3Yxb5bFXpmYSkct+0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725871811; c=relaxed/simple;
	bh=GbSzCxJCbJMFDl5rUHdvmex1Jg8USAutPcaxRfls/kU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Ni5v3P5hn8vgRrQuU468haAgwghsQ/LcN9CfI4Fke6F3kdkmPxYkkJtPqrNqfflHhC/Tnk37vpbDB0RlTigIyLavqsiIUyJH4ASB4rXxZrY6g2m+0SDl29AbDBhvsxn2/Aag/d5nhr44OZE6kR77nOf1ResYzNFpCDBwaOd7fHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QpltrMX7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2701AC4CEC5;
	Mon,  9 Sep 2024 08:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725871809;
	bh=GbSzCxJCbJMFDl5rUHdvmex1Jg8USAutPcaxRfls/kU=;
	h=Date:From:To:Cc:Subject:From;
	b=QpltrMX7TNaKUNzt/sFx4JeMN4HLR9AafXtCwKERDLq8HkC/XwnWLjrZ/csJPTWDW
	 MKAkgQ84Qq5qnzHpcYRtcu5J+QAqNUNtGWZRkeS3rXZkrUrF0gr+PAawnxc8vkVAAs
	 HZp1vybynQmfhsUaaEdwiIAGoH+Xcgmp4xvjqXGcoskYESouLpgnS3OlcKsA6J5ywT
	 LjXy0ZFt71ohjLQAGAYL3y3lTLMWxbP7GOKvSxTQMnVeI0huiKDSrvfdYqT1PFFt7s
	 eCZwwotRhKDPGdLLZXShLn0fYhCGflaSH+agZTiKhJHOb9H+tubHXTzcPJbfyoyyYk
	 n1AJXbTlhGDBw==
Date: Mon, 9 Sep 2024 10:50:04 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Amir Goldstein <amir73il@gmail.com>, 
	Aleksa Sarai <cyphar@cyphar.com>, Mike Rapoport <rppt@kernel.org>, 
	Vlastimil Babka <vbabka@suse.cz>, Matthew Wilcox <willy@infradead.org>
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: copying from/to user question
Message-ID: <4psosyj7qxdadmcrt7dpnk4xi2uj2ndhciimqnhzamwwijyxpi@feuo6jqg5y7u>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hey,

This is another round of Christian's asking sus questions about kernel
apis. I asked them a few people and generally the answers I got was
"Good question, I don't know." or the reasoning varied a lot. So I take
it I'm not the only one with that question.

I was looking at a potential epoll() bug and it got me thinking about
dos & don'ts for put_user()/copy_from_user() and related helpers as
epoll does acquire the epoll mutex and then goes on to loop over a list
of ready items and calls __put_user() for each item. Granted, it only
puts a __u64 and an integer but still that seems adventurous to me and I
wondered why.

Generally, new vfs apis always try hard to call helpers that copy to or
from userspace without any locks held as my understanding has been that
this is best practice as to avoid risking taking page faults while
holding a mutex or semaphore even though that's supposedly safe.

Is this understanding correct? And aside from best practice is it in
principle safe to copy to or from userspace with sleeping locks held?

