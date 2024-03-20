Return-Path: <linux-fsdevel+bounces-14894-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 21C308811C2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Mar 2024 13:39:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BEED6B23088
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Mar 2024 12:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E5E33FE20;
	Wed, 20 Mar 2024 12:39:02 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from vps.thesusis.net (vps.thesusis.net [34.202.238.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327F33EA62
	for <linux-fsdevel@vger.kernel.org>; Wed, 20 Mar 2024 12:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.238.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710938341; cv=none; b=fCJ3B+qi3+xjrNCg/A+Cegb0UB93Ze7wr+H0zb2uXjHFaB0lIJcys46EqLa5bTnuZG9u6r38NTGzYI63O3AAoXmYg0YqQHF98GUOkbLT5VlSP/OzB6pArQOufl4tiRrwjQgz+3o+u3p4OiF12+9DbaEUC4/NbFZZ2HMpm7v+Fg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710938341; c=relaxed/simple;
	bh=kxwRjPUqcNG9TAudiswtW/7gS5A/wlXNMa9X3KmVwIc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=m+l6TCD610OHS/WLl47Mozk5bXAa5bzmW56m/oWxL4r7PEVWZ/12yDo4H0xY/SdHIIqCQoSruI7sXvalVYqhHVuBML7GokDj5hwj+UFF9Vuh2FlKBx06/Qn50J2nHe50k7PQmhwMlQsfv7xLoa2ZEmofy/oh/cbymwnNa50eGVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thesusis.net; spf=pass smtp.mailfrom=thesusis.net; arc=none smtp.client-ip=34.202.238.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thesusis.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thesusis.net
Received: by vps.thesusis.net (Postfix, from userid 1000)
	id E9CAE2A94E; Wed, 20 Mar 2024 08:38:52 -0400 (EDT)
From: Phillip Susi <phill@thesusis.net>
To: Dave Chinner <david@fromorbit.com>
Cc: linux-fsdevel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>
Subject: Re: Uneccesary flushes waking up suspended disks
In-Reply-To: <ZfdyoJ90mxRLzELg@dread.disaster.area>
References: <877cieqhaw.fsf@vps.thesusis.net>
 <Ze5fOTojI+BhgXOW@dread.disaster.area> <87h6h78uar.fsf@vps.thesusis.net>
 <ZfdyoJ90mxRLzELg@dread.disaster.area>
Date: Wed, 20 Mar 2024 08:38:52 -0400
Message-ID: <87r0g5ulgj.fsf@vps.thesusis.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Dave Chinner <david@fromorbit.com> writes:

> That's what I expected - I would have been surprised if you found
> problems across multiple filesystems...

How do the other filesystems know they don't need to issue a flush?
While this particular method of reproducing the problem ( sync without
touching the filesystem ) only shows on ext4, I'm not sure this isn't
still a broader problem.

Say that a program writes some data to a file.  Due to cache pressure,
the dirty pages get written to the disk.  Some time later, the disk is
runtime suspended ( which flushes its write cache ).  After that,
someone does some kind of sync ( whole fs or individual file ).  Doesn't
the FS *have* to issue a flush at that point?  Even though there is
nothing in the disk's cache, the FS doesn't know that.


