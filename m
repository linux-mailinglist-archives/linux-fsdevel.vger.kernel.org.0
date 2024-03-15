Return-Path: <linux-fsdevel+bounces-14459-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5983E87CE7B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Mar 2024 15:05:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1691B2820FC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Mar 2024 14:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C233F376F9;
	Fri, 15 Mar 2024 14:05:24 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from vps.thesusis.net (vps.thesusis.net [34.202.238.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F161C376EB
	for <linux-fsdevel@vger.kernel.org>; Fri, 15 Mar 2024 14:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.238.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710511524; cv=none; b=qCL/LKj2aXRfZANE46079cNlTL6iYQ95fOplg3YG1iwWpHSdb2wud2sf6Q2ZRdXYZDXMBLYjIFiSp2WXQWjmLlLn7xepZMVLvqwixgVn3QqM5IWkzsu/0gT5u1uOkoOJwUPZij7C3DrvvmCEie2u+iOe5+L1rB2b4VFlIsoFYOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710511524; c=relaxed/simple;
	bh=lPGtBFMkTbmo0hjXK/bSvF83XXMOkPdN5B6xeP9jEHU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=d2z/NfFeWelauS37+Fw7gREddWqRkxj8vn94KxEDZSlSx6/IjCY0CYp6H7x76brcHT7hoD4PewdUrTQLG4o5UDIxpZbSeXqsnL2kCRcpv+x5Ut7CnI7L7gU6s1vj6U52nvpzyBzEHJum/zeglq1k5ueEYg9KIWvhlooBbMXY00U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thesusis.net; spf=pass smtp.mailfrom=thesusis.net; arc=none smtp.client-ip=34.202.238.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thesusis.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thesusis.net
Received: by vps.thesusis.net (Postfix, from userid 1000)
	id 6F1CA29C26; Fri, 15 Mar 2024 10:05:16 -0400 (EDT)
From: Phillip Susi <phill@thesusis.net>
To: Dave Chinner <david@fromorbit.com>
Cc: linux-fsdevel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>
Subject: Re: Uneccesary flushes waking up suspended disks
In-Reply-To: <Ze5fOTojI+BhgXOW@dread.disaster.area>
References: <877cieqhaw.fsf@vps.thesusis.net>
 <Ze5fOTojI+BhgXOW@dread.disaster.area>
Date: Fri, 15 Mar 2024 10:05:16 -0400
Message-ID: <87h6h78uar.fsf@vps.thesusis.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Dave Chinner <david@fromorbit.com> writes:

> How do other filesystems behave? Is this a problem just on specific
> filesystems?

I finally got around to testing other filesystems and surprisingly, it
seems this is only a problem for ext4.  I tried btrfs, f2fs, jfs, udf,
and xfs.  xfs even uses the same jbd2 for journaling that ext4 does
doesn't it?

I just formatted a clean fs, synced, and ran blktrace, then synced
again, and only ext4 emits a flush on the second sync.

