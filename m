Return-Path: <linux-fsdevel+bounces-42973-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F41ECA4C95B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Mar 2025 18:26:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 982F21696A4
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Mar 2025 17:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0594C2144B8;
	Mon,  3 Mar 2025 17:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="cPOdA0kf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F84323A988
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Mar 2025 17:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741021237; cv=none; b=NRMSAxv28Cb5d7+hlJYZxzY0yoRy0bjnKjFLP5CXCSgy7WoL5AhGkbo0VOYwJD4IQSbTpG0UYINPLk1mv1yEKV2+67Bx0gqzkbHJsqwK/rlv3DvqIt63IU6NAQaQxveq8mSTFQ5Tmqn2o+tIM5683p7MfKfa7WFpOFspoqgXu8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741021237; c=relaxed/simple;
	bh=lisTh2Yrr/QIZ5rzfbtjUQZ8mFxTjgdH+MqB93VLoGQ=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=lvEPoNen4kOaA4rv0WT7ZEy3K4Q/7er4HSEzHzzgpzBaZ4y3+aIeuch2cpOO1Gjp5yVVa8IaPrSCWKewACQwjUf/tgIOfznpiptT7WyVB6Z0TI9+H6Wie5osaz+naM4Fx8srEcf23enc+qswf+OpMzpv21rMjIrJHlM3cuKhvU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=cPOdA0kf; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-471f7261f65so45944551cf.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 03 Mar 2025 09:00:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1741021233; x=1741626033; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=65AS1TurM0DuZqajOs3Fp2VtWioENosiSkc7EjrvsLs=;
        b=cPOdA0kf5h7IB50EtKv3JMaVS2VWR3fM8/YPcP70Mgco48AdQhI67N4PUhBjlSGhtE
         BLNvuzRx08UslplhtH3r6yz5TwglJgmM+Q4XMNbjq9voJkDBtSBbKlcZRV/SOY8zjzwX
         fyOySvXISYpHXOttobWQBwjVA26eH9JSWhY1HrjObOfVhPZWnX5qE++rAcSJ/jE9jAtp
         Gz3EtztPinIn0Go8teT1izLyWjg9UEUli2GI+DDgVBNa59CYQo4aGtj8DrsRaJYZKFJV
         tjuR8ryPut7j82nJdJtBWFcAOGa/lxlP5R/bFdydmgijXdG32JVgLAXjnO4lAuu4X65K
         t2fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741021233; x=1741626033;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=65AS1TurM0DuZqajOs3Fp2VtWioENosiSkc7EjrvsLs=;
        b=VMXj1vmDE2o/QdeIW2HA93+gsTeE0ZAxMopiwPrTuA/K4Y3RCwMZAI0dPm9Ote1BcQ
         8/JWlSypFdAtOKmLEAoQVt6CPo3mdhensEX56Yg3Ak3vdlVyhXdP4+jY3bZtPGr1v273
         Oh6qUA0HGvHblvH5rm1kIZRG8YQqFTIewlGi+lv2DSduTeRYei529yKS8etcD7pJUvV8
         fJzsTUvDfVGwXYixp3dkvFrST9942OVse+oO4t+GeMjbJjR794AtH6MAw+KNPVW3E3yx
         bwR0D8JajcGvagxziFG4AQArDTIetWrGQI2+yNJU8DCO0t0by/qudzGRil3wM9jNgEFE
         HVkA==
X-Gm-Message-State: AOJu0YxWfvOM3U2sxnmNNl+5i/9Q+lHQv7YLkwF3HJmdWX6xY9+BrYIx
	+2X9x5t0B7ThoyT/Y16DjoPzhG2nj8DH+u6p61bYtX9yN1WxMvNvPMjzYZ0SJj8VGOBQ1PXomzn
	c
X-Gm-Gg: ASbGncvJ13sMLRrF4dNzzjC2h9Lbnwpzlu9gnFld6cUFRp3NXszTQASKNAiMge+eL9W
	ZM3vurL9vG943Ans+BUYbeoD3mIwsi0AzC5U2AFfmvXwq66K9H4NmdQ/34FLIhDa0MXSPeV5sFi
	TsgjtuPUGwqbhxuGqbbEGJEp8WDYgK3S67CDA9Ly/ybkd0YM+ajKrPInMRurcqUB9HAhmxw4ROM
	dCRQnIJsLQpbYrnBtH3cc7zBpgKjNyIAg+JOPwDfJVhqvTPpQm2r8EC2KjUj/BxVDI5cFRhBpfW
	Atxa1rZ56iy0tVdRzwTtr2qqYqgNYCoAr7RyS5Y6z1pcpdjTbCCmwdZshShkN1blbB/Lz4sb6lO
	QBZUk1w==
X-Google-Smtp-Source: AGHT+IGZpPZlqBEy5+CEdp0dB2xrLm830YpnD3SLs9+GNyVePcT8hr7qcHK8/TE9xyQEkxKP/Ds85w==
X-Received: by 2002:a05:622a:6103:b0:474:bc32:41e7 with SMTP id d75a77b69052e-474bc324255mr180704261cf.1.1741021231810;
        Mon, 03 Mar 2025 09:00:31 -0800 (PST)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4746b5edf1asm61143641cf.28.2025.03.03.09.00.30
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 09:00:30 -0800 (PST)
Date: Mon, 3 Mar 2025 12:00:29 -0500
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org
Subject: [LSF/MM/BPF TOPIC] Changing reference counting rules for inodes
Message-ID: <20250303170029.GA3964340@perftesting>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

I've recently gotten annoyed with the current reference counting rules that
exist in the file system arena, specifically this pattern of having 0 referenced
objects that indicate that they're ready to be reclaimed.

This pattern consistently bites us in the ass, is error prone, gives us a lot of
complicated logic around when an object is actually allowed to be touched versus
when it is not.

We do this everywhere, with inodes, dentries, and folios, but I specifically
went to change inodes recently thinking it would be the easiest, and I've run
into a few big questions.  Currently I've got about ~30 patches, and that is
mostly just modifying the existing file systems for a new inode_operation.
Before I devote more time to this silly path, I figured it'd be good to bring it
up to the group to get some input on what possible better solutions there would
be.

I'll try to make this as easy to follow as possible, but I spent a full day and
a half writing code and thinking about this and it's kind of complicated.  I'll
break this up into sections to try and make it easier to digest.

WHAT DO I WANT

I want to have refcount 0 == we're freeing the object.  This will give us clear
"I'm using this object, thus I have a reference count on it" rules, and we can
(hopefully) eliminate a lot of the complicated freeing logic (I_FREEING |
I_WILL_FREE).

HOW DO I WANT TO DO THIS

Well obviously we keep a reference count always whenever we are using the inode,
and we hold a reference when it is on a list.  This means the i_io_list holds a
reference to the inode, that means the LRU list holds a reference to the inode.

This makes LRU handling easier, we just walk the objects and drop our reference
to the object.  If it was truly the last reference then we free it, otherwise it
will get added back onto the LRU list when the next guy does an iput().

POTENTIAL PROBLEM #1

Now we're actively checking to see if this inode is on the LRU list and
potentially taking the lru list lock more often.  I don't think this will be the
case, as we would check the inode flags before we take the lock, so we would
martinally increase the lock contention on the LRU lock.  We could mitigate this
by doing the LRU list add at lookup time, where we already have to grab some of
these locks, but I don't want to get into premature optimization territory here.
I'm just surfacing it as a potential problem.

POTENTIAL PROBLEM #2

We have a fair bit of logic in writeback around when we can just skip writeback,
which amounts to we're currently doing the final truncate on an inode with
->i_nlink set.  This is kind of a big problem actually, as we could no
potentially end up with a large dirty inode that has an nlink of 0, and no
current users, but would now be written back because it has a reference on it
from writeback.  Before we could get into the iput() and clean everything up
before writeback would occur.  Now writeback would occur, and then we'd clean up
the inode.

SOLUTION FOR POTENTIAL PROBLEM #1

I think we ignore this for now, get the patches written, do some benchmarking
and see if this actually shows up in benchmarks.  If it does then we come up
with strategies to resolve this at that point.

SOLUTION FOR POTENTIAL PROBLEM #2 <--- I would like input here

My initial thought was to just move the final unlink logic outside of evict, and
create a new reference count that represents the actual use of the inode.  Then
when the actual use went to 0 we would do the final unlink, de-coupling the
cleanup of the on-disk inode (in the case of local file systems) from the
freeing of the memory.

This is a nice to have because the other thing that bites us occasionally is an
iput() in a place where we don't necessarily want to be/is safe to do the final
truncate on the inode.  This would allow us to do the final truncate at a time
when it is safe to do so.

However this means adding a different reference count to the inode.  I started
to do this work, but it runs into some ugliness around ->tmpfile and file
systems that don't use the normal inode caching things (bcachefs, xfs).  I do
like this solution, but I'm not sure if it's worth the complexity.

The other solution here is to just say screw it, we'll just always writeback
dirty inodes, and if they were unlinked then they get unlinked like always.  I
think this is also a fine solution, because generally speaking if you've got
memory pressure on the system and the file is dirty and still open, you'll be
writing it back normally anyway.  But I don't know how people feel about this.

CONCLUSION

I'd love some feedback on my potential problems and solutions, as well as any
other problems people may see.  If we can get some discussion beforehand I can
finish up these patches and get some testing in before LSFMMBPF and we can have
a proper in-person discussion about the realities of the patchset.  Thanks,

Josef

