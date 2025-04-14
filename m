Return-Path: <linux-fsdevel+bounces-46340-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3136FA8779D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Apr 2025 07:59:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 652A41890A2D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Apr 2025 05:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E24FE1A2C27;
	Mon, 14 Apr 2025 05:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L4dcw5tF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74DCC19E7F9
	for <linux-fsdevel@vger.kernel.org>; Mon, 14 Apr 2025 05:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744610349; cv=none; b=UnIt8tEk/hXZxOhPBb3YqqDw70B2vKXiDX1ApuYjO+L5RQJFgCpk+b6hoAj8bO9d/jOS+m0XTeRNe2omGPSKSstW46/lLb83IRR9IlOKxFjxFRidPY9vBGhF/eLAxh2n4TqVhBnbGHWMSlYKZndHe9ryV6AIppM8uD36g0UTbz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744610349; c=relaxed/simple;
	bh=O/+P6UHdiiiLJ9S0915lY6FrTgAk37edEMTWj3ysGcQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RFa4EHi+zjeWBS5Y7bCG9NuLN101k3w3VlHYYALewPldmpE8mY5cANmZ/XE9bZGQKpnIeqEEeQ5cn5JoP1ra64WNUCAUYJHpFfYI5AhZdHsxLaPHK67JSKQP9LKcfe+/SI8s6eYZDlLsvQFaT+oH6FGvU94wQWqXipd3t/aVnWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L4dcw5tF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744610346;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V3vpZzO1IKjjrI7weLLsfR0ytu7kb+hwfvLc+24LbL4=;
	b=L4dcw5tFvP0VcIvnHOtY4hQKxZwWbD1jSV1BrRe2YKAN2u3DC1G9qH9cpPXn7VXvpk0Qw7
	YNmq8b8R5lvtoOU9dtL0JVCoijwHNtaRgXTLtR1aCPqFtkoEN5RWuHDE8HHvh1Kcnr52a8
	DKbV7ad3AeyzBhleZ55UYIpbYsQ99OE=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-551-G5Is1V90MnytVkwfCB0rxg-1; Mon, 14 Apr 2025 01:59:03 -0400
X-MC-Unique: G5Is1V90MnytVkwfCB0rxg-1
X-Mimecast-MFC-AGG-ID: G5Is1V90MnytVkwfCB0rxg_1744610343
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-227a8cdd272so33076395ad.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 13 Apr 2025 22:59:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744610342; x=1745215142;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V3vpZzO1IKjjrI7weLLsfR0ytu7kb+hwfvLc+24LbL4=;
        b=jJkbbvmnXNR6JaM5KyAXVhRwXGc2fqS8VEC+VB8NjGRDqd6E+JFfrRRaqa1QsHV+LX
         fx1oXdTsy5A1cy8++FmXQbLaotp5M629cBM1vN0cT4x6OOCNy70TtyVLL1U4cj8z3SU7
         2APwC3O9n3SVZQghwXSYk/G1TWSQNvrU+4UIUFAE+FKkgy1yVKvIbulwYd1s/V97NnlU
         B0b7jVxdomF/QzjCtpPUkZssE8qyGf3pjs+WJBnCssQ2UgFTUD/N7Nd5yQ32MP8cdPph
         3RvYKAc9uo5cNSgNPwRvzdMNrFc6dmOBNkWi1c17rxf+oZNKgta/7Izv5/+WC99sxKrE
         06Wg==
X-Forwarded-Encrypted: i=1; AJvYcCXNn0qBmtoPjw/uT9Znt1IHFp4OlbtdV8Xfp0kDASjVOn+XAmYRm1zyZnuwevCd3OBMo+sN7u+IeUI68v/E@vger.kernel.org
X-Gm-Message-State: AOJu0YwEo2kSSxit0QCZ8ZVka2PQ+kHYjIZgmm52wjbQFG2MbN1a2OfS
	nArr7C4WoA8FCJc2OSFHHpCAbaFoWPEpOgq04Uv82Wm4amORxw8HzmMAPSFjZs2O+SFJsCi9HUF
	JlKmFU/dibqOGpqmkUgtrhfLeJA46s9uk1tv5jsJfgkDZpsp5LTRchCV8hAdzRxN3ix4a9jI=
X-Gm-Gg: ASbGncunl+KNEU/nDS2+33s81FYYr21M/QpFJY3InQ/CpiviMEXKXI4a+eHmT2xuf30
	S1S8+aWDMCYrHykaoAPTf6t28l+dM2lhkOiU77gLl6bM79TLQVXLsT0EWh9HqfCpUB3EXkaqdFa
	1zXQ1i/9VHWp2HpbJgk/m71YlwiOeyWmKbKrrTbb80oNj+rOl7/Hv+UqFLedLSiKygYTClTAGHC
	4C1zI1OHI3Imt8tYINae60sWG1iQBvCD4ziRQmDju/LImntnFP0f+PtptoUVQZQjrX9Gl/0Mu6G
	Eo1i1JSxWJm9pCfAi4gRefpJeRs/fQ9+nICGUSdsZkm8gvjg98TM
X-Received: by 2002:a17:902:e788:b0:223:4c09:20b8 with SMTP id d9443c01a7336-22bea4f0043mr152503235ad.37.1744610342272;
        Sun, 13 Apr 2025 22:59:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG4WFg2dhdeBMmaxTN/dxrj8j3X87o6sJSv0cmCghse4HvomrId2kYh5X2iJA+pPvRVH4s6OQ==
X-Received: by 2002:a17:902:e788:b0:223:4c09:20b8 with SMTP id d9443c01a7336-22bea4f0043mr152502985ad.37.1744610341633;
        Sun, 13 Apr 2025 22:59:01 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7b8ae95sm91588485ad.61.2025.04.13.22.58.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Apr 2025 22:59:01 -0700 (PDT)
Date: Mon, 14 Apr 2025 13:58:57 +0800
From: Zorro Lang <zlang@redhat.com>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org,
	David Sterba <dsterba@suse.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2] README: add supported fs list
Message-ID: <20250414055857.w2zvapp3mjintgar@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250328164609.188062-1-zlang@kernel.org>
 <u2pigq4tq5aj5qvjrf3idna7hfdl6b4ciko5jvorkyorg25dck@4ti6fjx55hda>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <u2pigq4tq5aj5qvjrf3idna7hfdl6b4ciko5jvorkyorg25dck@4ti6fjx55hda>

On Sun, Apr 13, 2025 at 05:56:08PM -0400, Kent Overstreet wrote:
> On Sat, Mar 29, 2025 at 12:46:09AM +0800, Zorro Lang wrote:
> > To clarify the supported filesystems by fstests, add a fs list to
> > README file.
> > 
> > Signed-off-by: Zorro Lang <zlang@kernel.org>
> > Acked-by: "Darrick J. Wong" <djwong@kernel.org>
> > ---
> > 
> > The v1 patch and review points:
> > https://lore.kernel.org/fstests/20250227200514.4085734-1-zlang@kernel.org/
> > 
> > V2 did below things:
> > 1) Fix some wrong english sentences
> > 2) Explain the meaning of "+" and "-".
> > 3) Add a link to btrfs comment.
> > 4) Split ext2/3/4 to 3 lines.
> > 5) Reorder the fs list by "Level".
> > 
> > Thanks,
> > Zorro
> > 
> >  README | 90 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 90 insertions(+)
> > 
> > diff --git a/README b/README
> > index 024d39531..5ceaa0c1e 100644
> > --- a/README
> > +++ b/README
> > @@ -1,3 +1,93 @@
> > +_______________________
> > +SUPPORTED FS LIST
> > +_______________________
> > +
> > +History
> > +-------
> > +
> > +Firstly, xfstests is the old name of this project, due to it was originally
> > +developed for testing the XFS file system on the SGI's Irix operating system.
> > +When xfs was ported to Linux, so was xfstests, now it only supports Linux.
> > +
> > +As xfstests has many test cases that can be run on some other filesystems,
> > +we call them "generic" (and "shared", but it has been removed) cases, you
> > +can find them in tests/generic/ directory. Then more and more filesystems
> > +started to use xfstests, and contribute patches. Today xfstests is used
> > +as a file system regression test suite for lots of Linux's major file systems.
> > +So it's not "xfs"tests only, we tend to call it "fstests" now.
> > +
> > +Supported fs
> > +------------
> > +
> > +Firstly, there's not hard restriction about which filesystem can use fstests.
> > +Any filesystem can give fstests a try.
> > +
> > +Although fstests supports many filesystems, they have different support level
> > +by fstests. So mark it with 4 levels as below:
> > +
> > +L1: Fstests can be run on the specified fs basically.
> > +L2: Rare support from the specified fs list to fix some generic test failures.
> > +L3: Normal support from the specified fs list, has some own cases.
> > +L4: Active support from the fs list, has lots of own cases.
> > +
> > +("+" means a slightly higher than the current level, but not reach to the next.
> > +"-" is opposite, means a little bit lower than the current level.)
> > +
> > ++------------+-------+---------------------------------------------------------+
> > +| Filesystem | Level |                       Comment                           |
> > ++------------+-------+---------------------------------------------------------+
> > +| XFS        |  L4+  | N/A                                                     |
> > ++------------+-------+---------------------------------------------------------+
> > +| Btrfs      |  L4   | https://btrfs.readthedocs.io/en/latest/dev/Development-\|
> > +|            |       | notes.html#fstests-setup                                |
> > ++------------+-------+---------------------------------------------------------+
> > +| Ext4       |  L4   | N/A                                                     |
> > ++------------+-------+---------------------------------------------------------+
> > +| Ext2       |  L3   | N/A                                                     |
> > ++------------+-------+---------------------------------------------------------+
> > +| Ext3       |  L3   | N/A                                                     |
> > ++------------+-------+---------------------------------------------------------+
> > +| overlay    |  L3   | N/A                                                     |
> > ++------------+-------+---------------------------------------------------------+
> > +| f2fs       |  L3-  | N/A                                                     |
> > ++------------+-------+---------------------------------------------------------+
> > +| tmpfs      |  L3-  | N/A                                                     |
> > ++------------+-------+---------------------------------------------------------+
> > +| NFS        |  L2+  | https://linux-nfs.org/wiki/index.php/Xfstests           |
> > ++------------+-------+---------------------------------------------------------+
> > +| Ceph       |  L2   | N/A                                                     |
> > ++------------+-------+---------------------------------------------------------+
> > +| CIFS       |  L2-  | https://wiki.samba.org/index.php/Xfstesting-cifs        |
> > ++------------+-------+---------------------------------------------------------+
> > +| ocfs2      |  L2-  | N/A                                                     |
> > ++------------+-------+---------------------------------------------------------+
> > +| Bcachefs   |  L1+  | N/A                                                     |
> 
> I heavily use xfstests and look at the test results every day - I
> believe that would indicate L3.

Glad to receive the response from bcachefs :) L3 means there're enough fs specific
test cases in tests/$FSTYP besides generic cases, e.g. tests/overlay, or f2fs (although
it only has a few currently, but it's increasing).

> 
> bcachefs specific tests are not generally in fstests beacuse there's
> lots of things that ktest can do that fstests can't, and I find it a bit
> more modern (i.e. tests that names, not numbers)

ktest? linux/tools/testing/ktest/ ? I'm glad to learn about more test suites,
I run fstests and LTP and some others too, fstests can't cover everything :)
Hmm... about the names... fstests supports to append a name to the ID number,
but the developers (looks like) prefer using number only all the time, then
it become a "tradition" now.

> 
> Not all tests are passing (and won't be for awhile), but the remaining
> stuff is non critical (i.e. fsync() error behaviour when the filesystem
> has been shutdown, or certain device removal tests where the behaviour
> could probably use some discussion.
> 
> But if you find e.g. a configuration that produces a generic/388 pop,
> that would go to the top of the pile.
> 
> (I do have a few patches to the tests for bcachefs in my tree that I
> really ought to get upstream).

Sure, warm welcome your patches. And don't worry, you can send patch to
update the level part anytime when you think fstests supports becachefs
more :)

Thanks,
Zorro

> 


