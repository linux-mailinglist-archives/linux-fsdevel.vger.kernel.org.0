Return-Path: <linux-fsdevel+bounces-41524-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80132A310AC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Feb 2025 17:08:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33CC33A331E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Feb 2025 16:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 049FC253B76;
	Tue, 11 Feb 2025 16:08:04 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69C501EF088
	for <linux-fsdevel@vger.kernel.org>; Tue, 11 Feb 2025 16:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739290083; cv=none; b=mVRLifb6l0OTHx6ofQoNQCPa+JleTMbByIxwwXO2f2MWkuqj4joYgffPvEkNMV9lsCoj+6HWarDM/aOJ74TwwTpLSu1nb7xW50m8nu3m00x6SP5liKY17DBtC6Hdg+0iTpkK49kmTx1WdHbPLY/KkxMJA3Uqs8jZgUP/oQ4Qfxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739290083; c=relaxed/simple;
	bh=swFDWmkC/k9LC1U1c4/R8egFPJSEiddZIihgWh3ru9w=;
	h=Message-ID:Date:MIME-Version:From:To:Subject:Content-Type; b=fioi1M/1NRxRGR/ogZ0OgNj/dQnnsiJ7Wob5mnWb/FjKzOCloAArwf4xEQ2R4hqn0an1p2Hww8VFVyemZUz3cgvljtojCuFaUEkybQR4o5fEmto4NoiADvqeDQg00PpKf90BgSg7TZrrGtSTycjhiL7H8YpffC7pPVd9Aqdj5UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A7D1613D5;
	Tue, 11 Feb 2025 08:08:21 -0800 (PST)
Received: from [10.57.81.93] (unknown [10.57.81.93])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B52003F6A8;
	Tue, 11 Feb 2025 08:07:59 -0800 (PST)
Message-ID: <aea64a67-e236-4606-a330-1d53fed45bf9@arm.com>
Date: Tue, 11 Feb 2025 16:07:58 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
From: Ryan Roberts <ryan.roberts@arm.com>
To: Matthew Wilcox <willy@infradead.org>, Linux-MM <linux-mm@kvack.org>,
 linux-fsdevel@vger.kernel.org
Subject: Large folios for overlayfs (and potential BUG)
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Matthew,

I'm interested in enabling large folios support in overlayfs. I've been doing
some digging and it looked like it should JustWork already, but testing suggests
that's not the case. Given that's not the case, then I think there may be a bug
relating to BS > PS when XFS is providing one of the layers.

So overlayfs has a "lower layer" and an "upper layer". Both are just directories
on other file systems. The lower layer is read-only. The upper layer contains
any created files as well as any modified files (when modified, the whole file
is "copied up" to the upper then modified). The upper layer also contains
"white-outs"; meta data to describe a deleted file. The final view is the merged
views of these 2 layers.

Anyway, overlayfs creates/maintains its own inodes (and mappings), but delegates
IO (.read_iter/.write_iter) down to the "real" file on the real filesystem; one
of the 2 layers. overlayfs never calls mapping_set_large_folios() for it's
mappings. But it also doesn't implement any of the mapping ops (except direct_IO).

overlayfs's read_iter() will delegate into the real file's read_iter() (via
backing_file_read_iter()). For XFS that means it will end up calling
generic_file_read_iter() to interact with the page cache which will use the
mapping ops for the real mapping (i.e. XFS). Since XFS should have called
mapping_set_large_folios(), we should get large folios, right?

Except, testing this from user space shows the folios are small when coming from
overlayfs, backed by XFS. The same test case shows the folios are large when the
file is pulled directly from XFS.

So I guess my unserstanding of this is wrong and for some reason we need to call
mapping_set_large_folios() for overlayfs's mapping, or do something else?
Although I don't really get why that would even be used...

But the fact that this doesn't all JustWork, makes me concerned that this is all
broken for BS > PS? If the underlying FS requires all folios to be bigger than
order-0, but overlayfs is somehow fixing it so that all folios are order-0,
don't we have a mismatch?

FWIW, ChatGPT was suggesting that mapping_set_large_folios() DOES need to be
called for the overlayfs mapping, but from code inspection I don't see why. If
needed, it also opens up the problem that if the file needs to be copied up to
the upper layer in future, we don't know if that can support large folios (or
more generally we don't know if there is a single configuration that can be
supported by both layers). So it would suggest a need to change the large folio
configuration on an active mapping, which I don't think is currently allowed.

Anyway, from my rambling, you can probably tell there are a bunch of holes in my
mental model. Any clarifications/suggestions you have would be gratefully received!

Thanks
Ryan



