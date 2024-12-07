Return-Path: <linux-fsdevel+bounces-36696-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18D619E8265
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Dec 2024 22:59:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFD1E165668
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Dec 2024 21:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12FD015530C;
	Sat,  7 Dec 2024 21:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qHP4kpRE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C105628F5
	for <linux-fsdevel@vger.kernel.org>; Sat,  7 Dec 2024 21:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733608746; cv=none; b=AfWZiXfJlzu/FRZL5Xc5qokhzc0RAy/y/VDFwmRPW7VJmLdHPkRg5l9lHdkHFUd2+cmCXSohaGHJ99Q8kuwWANVpWtS0O48irKFBd9eOKNMisB7zXKjss/WTwCNdx1T0D4rm4sI8omEc8uFfBpfOHtlAzV2jCTgfEj3Rx43k//s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733608746; c=relaxed/simple;
	bh=OAm848NpS4vDI1etGKRvjdt7w6bJiQT0JYVyNZNNBlg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ZDkJ62B3jSrl/gemg2Vczi3W6NmQ8r04w9irSvDZfNGNFoaYMrbKOPsAGaoLZ9LOgkBb8PNlhv9zYfbIs6bRZCdL6qikOmcaMx0w876RQLVWf8zWdqdDdd20JOIwqya36oMNweo8KQHbX2b8BzH+WCQn10LMexay/mkmslEl59Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qHP4kpRE; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sat, 7 Dec 2024 16:58:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1733608740;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=OAm848NpS4vDI1etGKRvjdt7w6bJiQT0JYVyNZNNBlg=;
	b=qHP4kpREi63jl+XsafxX+ON3a2A876x7J7Xw1Moe009IsKnaQOrbfBB0CWTyE3mUwkWP59
	kNjxqYl/lUNKqWCtLCzDp57blBD/pCuoK/ICrd0Wy1CXun5UH8fjsQ/zkIW6ewzOi/F2Sk
	NAi4OWln8G6EqRuwHIRkJtTDr/w83V4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Miklos Szeredi <mszeredi@redhat.com>, malte.schroeder@tnxip.de
Cc: Josef Bacik <josef@toxicpanda.com>, 
	Joanne Koong <joannelkoong@gmail.com>, Matthew Wilcox <willy@infradead.org>, 
	linux-fsdevel@vger.kernel.org
Subject: silent data corruption in fuse in rc1
Message-ID: <p3iss6hssbvtdutnwmuddvdadubrhfkdoosgmbewvo674f7f3y@cwnwffjqltzw>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Migadu-Flow: FLOW_OUT

Hey Miklos, I've got a user who noticed silent data corruption when
building flatpaks on rc1; it appeared when using both bcachefs and btrfs
as the host filesystem, it's now looking like fuse changes might be the
culprit - we just got confirmation that reverting
fb527fc1f36e252cd1f62a26be4906949e7708ff fixes it.

Can you guys take it from here? Also, I think a data corruption in rc1
merits a post mortem and hopefully some test improvements, this caused a
bit of a freak out.

