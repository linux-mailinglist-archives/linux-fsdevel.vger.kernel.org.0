Return-Path: <linux-fsdevel+bounces-51081-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79741AD2AF1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 02:38:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 545F616FC79
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 00:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 659CF14831E;
	Tue, 10 Jun 2025 00:38:20 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD4E13C3F6;
	Tue, 10 Jun 2025 00:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749515900; cv=none; b=U3kvef971lkxn/QFAzN84r+ZbIgVHgU22YNHkbmRNXkfn7sz22kSJhZWB4lGmJ9HDB1N6iOwNYhT3Uez5NuSkU+PEUOcaudjjCbCZtDxhBrCdRfPSvHGh9I1cGP2bOYWDgpBPKi4qGS0TcWco4EC1aBI8Wpe4sEQUPuY6X0LADI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749515900; c=relaxed/simple;
	bh=sXMXcNjaMwDS7Y82cYLAAuCTgTourZYEan+IEDMvyko=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=LEmUtb3W8eqftYdwLxx8hsjXffTGIEYSw52Q2xMRjHUS+h8fJ2clwlRpOftL9CRC5w9YoTuV7UFGZ2HHke33YJ1uV3bUjl6U60n8C+NzAtcG2rwU3h91edmtfYX04+5jsXsXBxUlNa8qwgrAx4R4vMzG3dhC1z6YW61lfA4ljYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1uOn08-00715x-4a;
	Tue, 10 Jun 2025 00:38:04 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neil@brown.name>
To: "Steve French" <smfrench@gmail.com>
Cc: "Christian Brauner" <brauner@kernel.org>,
 "linux-fsdevel" <linux-fsdevel@vger.kernel.org>,
 "LKML" <linux-kernel@vger.kernel.org>, "CIFS" <linux-cifs@vger.kernel.org>,
 "Bharath S M" <bharathsm@microsoft.com>
Subject: Re: Perf regression in 6.16-rc1 in generic/676 (readdir related)
In-reply-to:
 <CAH2r5mu5SfBrdc2CFHwzft8=n9koPMk+Jzwpy-oUMx-wCRCesQ@mail.gmail.com>
References:
 <CAH2r5mu5SfBrdc2CFHwzft8=n9koPMk+Jzwpy-oUMx-wCRCesQ@mail.gmail.com>
Date: Tue, 10 Jun 2025 10:38:00 +1000
Message-id: <174951588031.608730.13342747411339092972@noble.neil.brown.name>

On Tue, 10 Jun 2025, Steve French wrote:
> Instead of the usual 10 to 12 minutes to run generic/676 (on all
> kernels up to 6.15), we are now seeing 23-30 minutes to run
> generic/676, much more than twice as slow.   It looks like this is due
> to unnecessary revalidates now being sent to the fs (starting with
> 6.16-rc1 kernels) on every file in a directory, and is caused by
> readdir.   Bharath was trying to isolate the commit that caused this,
> but this recently merged series could be related:
> 
> 06c567403ae5 Use try_lookup_noperm() instead of d_hash_and_lookup()
> outside of VFS
> fa6fe07d1536 VFS: rename lookup_one_len family to lookup_noperm and
> remove permission check

Thanks for the report.  The cause is almost certainly the first of
these.  No callers of try_lookup_noperm() need or want the revalidate.
Before my patch the only user was autofs which doesn't even have a
d_revalidate().

I'll write and post a patch.

Thanks,
NeilBrown


> 
> Has anyone else noticed this perf regression?
> 
> For the case of cifs.ko mounts, it is easy to repro with generic/676.
> And also could be reproduced with simple "ls" of large directories.
> 
> -- 
> Thanks,
> 
> Steve
> 


