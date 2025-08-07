Return-Path: <linux-fsdevel+bounces-57018-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1106BB1DE96
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Aug 2025 23:01:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E22BF18C19D9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Aug 2025 21:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A88CB207A3A;
	Thu,  7 Aug 2025 21:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=joshtriplett.org header.i=@joshtriplett.org header.b="lI+F6Ef9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TsI9nULV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 950B42AD32
	for <linux-fsdevel@vger.kernel.org>; Thu,  7 Aug 2025 21:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754600481; cv=none; b=P+9K1+ZjEk3Bk3SBh/PfaA9cirmKyJR9F0rVorVY889ghYduYzzaTnA593UPmIsl8qBQs2+Nsp+3UmGLe4zir1rA6+0cbwRg41DsiRB4tieGXTbOSxDlrhOd63nPbly/UoIQy/ZUsnp21xBSKoHV436NFX0o+Xzy+vijTVU9zTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754600481; c=relaxed/simple;
	bh=rz04v2wTBINoGu0Ur5WxqrMSyTGYU80gMg9CiAfouFI=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=mTo+GB2sJoWr/83k/9I/eZGSQEsDx0sDOe78rXGglkKdrvajNbaxosKsCJMtyTMcBqCcm2jzJQZJNCqwsTu4MW2HSD5+Lj/kCSkCKxnKL/QDvYG3PdW5bUtTCg1YmQ1IbNFOTJL0p3xCevhlzXCCbGyckOV7m+owtIoaZ8JOfo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joshtriplett.org; spf=pass smtp.mailfrom=joshtriplett.org; dkim=pass (2048-bit key) header.d=joshtriplett.org header.i=@joshtriplett.org header.b=lI+F6Ef9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TsI9nULV; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joshtriplett.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joshtriplett.org
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id A8E0AEC01CD
	for <linux-fsdevel@vger.kernel.org>; Thu,  7 Aug 2025 17:01:17 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 07 Aug 2025 17:01:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	joshtriplett.org; h=cc:content-type:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm3; t=1754600477; x=1754686877; bh=LErLBlhCuX
	j1NH6NqMdHEiJ4dOhbfYQfSkcVHCiovdc=; b=lI+F6Ef9AFBUrzV+Ow/v99I7RN
	ZMeY8N/NvCcjpys2GYljhO/OnMgmFApGZgwKGv3btUX52FTTDTYVE1VnklDZKvPt
	YG4qFQnzgbPa9Oj0QkSp179UE0c1Q+Uv6IxbyHMaI1iDIFQqVlI9njkvGxuoEzf5
	3XkFyzGGKHaEa1DvP01Oz7HniOWQ1ZeT0qjbdSTNkadUEpocOtKlWxthfdyeIkqg
	twoxImaXP6TvSphjL4rBqDfXZ+WoQWrky0OmXJE+FoB6mtv4GZQ7hp2HGyRluT7G
	WfN0AWc93PPwDSbZAN9yUwtQUODJPEK3cvrJgShSEm6r3A6lCgNP+gG/UBnA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1754600477; x=
	1754686877; bh=LErLBlhCuXj1NH6NqMdHEiJ4dOhbfYQfSkcVHCiovdc=; b=T
	sI9nULV7aeM9QAnUsn1jIxnglyEY4XLHuaMf0zprg1DAagPt40/OTreYR8Vr0Esq
	vKyK+n59G1bXqX0Dj4R1WSkRX6bR1XMk7CPJkEhcVj89iXNaT+x8P9lk3Ld2u3Xl
	BSYD0XtqpzxOrLglviE85OS3dNttcTufCpDm9ewpnwUbG95xQBEAnBiSU5FWSSKi
	j8A2gW+gcbQCxZOTa1pvATLHCI3RFZiftob8ZgkshsYNhijY224yNtgE5DAxqXfR
	lX42NBQrpbPy3DqfnoEReH8+TFSosEo2/0TWN9vC4uBLCHimLa0ZjeBs/XAyQ/+1
	LT0MfM1AKK4O7tqd8D2Qw==
X-ME-Sender: <xms:HRSVaD4tu9Z53rJMIDsK3GpZGG-i0AgwGywLTeGJJLHS1bObtguGew>
    <xme:HRSVaK5ioo0G4emSLBeIi9BkLwYo4X70QZeVqozTwnaOQAcnLZr4DRJ2z3Z2eUHeW
    pSZq_xsnulX2NiHCEw>
X-ME-Received: <xmr:HRSVaD3ZqXcenPhOsUzes618o3WXbj9N1Soco9DooL8CwLUqaWGz4UUkaQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduvdduleeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkgggtugesthdtredttddtvd
    enucfhrhhomheplfhoshhhucfvrhhiphhlvghtthcuoehjohhshhesjhhoshhhthhrihhp
    lhgvthhtrdhorhhgqeenucggtffrrghtthgvrhhnpeelleeggedtjeejfeeuvddufeeggf
    ektdefkeehveeuvedvvdfhgeffgfdvgfffkeenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehjohhshhesjhhoshhhthhrihhplhgvthhtrdhorh
    hgpdhnsggprhgtphhtthhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehl
    ihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:HRSVaGVC31eBOC0Q31Fs5XmmX8hWCxPLAIs6pXkAWaghkVwwz_Wmtw>
    <xmx:HRSVaO7vfIzN2tJxO_O4CkszcWYnZnU9-SZ9QjaD9NbuFh3N8g5Yfg>
    <xmx:HRSVaNIFKbMkYmw8DvnxfWgHbiRkDrPpoOEvU9b6FrliaMtKZaMlRA>
    <xmx:HRSVaPLF3XWB2UTavwnvjtt6n0b_sbSHgsPzeB6bZBc58cDmJHrqOA>
    <xmx:HRSVaJTKI9bztoX--Cbr7Rlejx7RNK9GlilIHoOl_YAkzKooIrtjjj7y>
Feedback-ID: i83e94755:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <linux-fsdevel@vger.kernel.org>; Thu, 7 Aug 2025 17:01:16 -0400 (EDT)
Date: Thu, 7 Aug 2025 14:01:15 -0700
From: Josh Triplett <josh@joshtriplett.org>
To: linux-fsdevel@vger.kernel.org
Subject: futimens use of utimensat does not support O_PATH fds
Message-ID: <aJUUGyJJrWLgL8xv@localhost>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I just discovered that opening a file with O_PATH gives an fd that works
with

utimensat(fd, "", times, O_EMPTY_PATH)

but does *not* work with what futimens calls, which is:

utimensat(fd, NULL, times, 0)

The former will go through do_utimes_fd, while the latter goes through
do_utimes_path. I would have expected these two cases to end up in the
same codepath once they'd discovered they were operating on a file
descriptor, and I would have expected both to support O_PATH file
descriptors if either does.

This is true for both symlinks (with O_NOFOLLOW | O_PATH) and regular
files (with just O_PATH). This is on 6.12, in case it matters.

Quick and dirty test program (in Rust, using rustix to make syscalls):

```
use rustix::fs::{AtFlags, OFlags, Timespec, Timestamps, UTIME_OMIT};

fn main() -> std::io::Result<()> {
    let f = rustix::fs::open("oldfile", OFlags::PATH | OFlags::CLOEXEC, 0o666.into())?;
    let times = Timestamps {
        last_access: Timespec { tv_sec: 0, tv_nsec: UTIME_OMIT },
        last_modification: Timespec { tv_sec: 0, tv_nsec: 0 },
    };
    let ret = rustix::fs::utimensat(&f, "", &times, AtFlags::EMPTY_PATH);
    println!("utimensat: {ret:?}");
    let ret = rustix::fs::futimens(&f, &times);
    println!("futimens: {ret:?}");
    Ok(())
}
```

Is this something that would be reasonable to fix? Would a patch be
welcome that makes both cases work identically and support O_PATH file
descriptors?

