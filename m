Return-Path: <linux-fsdevel+bounces-39402-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A74DBA13A34
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2025 13:50:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2AE087A42BC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2025 12:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD9801DE89E;
	Thu, 16 Jan 2025 12:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="S5flDUM6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3091DE892
	for <linux-fsdevel@vger.kernel.org>; Thu, 16 Jan 2025 12:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737031815; cv=none; b=juZRuKD+/8YffcjdFznNDDy+10rV/y+S+VpuAgnjwl9J0wdKBdD+K4r1DcoVpHdsQfWUDRFAs7kVvsY63pNeVZl6z1LCWomTmuh7Uers1jBVNLqDtmQ4hNpPe4zpuiWQ7999MHpCJ0dBlGO5ag1bnnTeE8cbDBRc684DIqHBYb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737031815; c=relaxed/simple;
	bh=cUAp7WUEbNcmPHqsSB2egxYTb5Myvc39NYPg9s9X79s=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=lUn8WslyhEQIoxh+Mc5AY7f1auJ3dlJDeo5YZztLHx25x7v+kQZcWJPcoF3M8XOLim2/q3ZOPihjVUsgBgZFprciliXepGrB9TbA7XzUtsYtFKHUBy9l1+RP2CNTnOjNdmj7redCF2jCOaLlLELVoUBxMss0XZSGheZf1Nq/SzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=S5flDUM6; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-108-26-156-113.bstnma.fios.verizon.net [108.26.156.113])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 50GCnnFm019186
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jan 2025 07:49:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1737031791; bh=huf9Ik1hje0HQYQhWKBTuB0nHn68Gol/moxeLj16d6o=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=S5flDUM6m8t/2Y7Qox8IFKNFz3YEbLwIJ4BenVzGoIqlojz7ADOJtH0ryPta3hGvR
	 S/610GAIrE5clwssPaUilNLFiqytCSEiQ/WptqYnLG5YhJZGd1Todi3+k2WOQb+p8H
	 YRHBcHuk0mUVuSChvchwTfdBKTGoir1QvgHC8/BZ/R4fWbxtFWEExzXTDSyYIFV06V
	 wGqshAJPP/iPC3HGjUU2PecYSx6K7Tk8PzRwxByXh1I0nNX2ju5RmtlmVkSJgL/n/6
	 Uvo1bzyg2X/+ijYIFMZ1Hw+g/PoudeUlE18LM9KqsEqcLTel7IS9j6sSC8WD+6hgam
	 GXDXMXykPjW8A==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 932E915C0108; Thu, 16 Jan 2025 07:49:49 -0500 (EST)
Date: Thu, 16 Jan 2025 07:49:49 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: lsf-pc@lists.linux-foundation.org
Cc: Linux Filesystem Development List <linux-fsdevel@vger.kernel.org>,
        bpf@vger.kernel.org
Subject: [LSF/MM/BPF TOPIC] time to reconsider tracepoints in the vfs?
Message-ID: <20250116124949.GA2446417@mit.edu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Historically, we have avoided adding tracepoints to the VFS because of
concerns that tracepoints would be considered a userspace-level
interface, and would therefore potentially constrain our ability to
improve an interface which has been extremely performance critical.

I'd like to discuss whether in 2025, it's time to reconsider our
reticence in adding tracepoints in the VFS layer.  First, while there
has been a single incident of a tracepoint being used by programs that
were distributed far and wide (powertop) such that we had to revert a
change to a tracepoint that broke it --- that was ***14** years ago,
in 2011.  Across multiple other subsystems, many of
which have added an extensive number of tracepoints, there has been
only a single problem in over a decade, so I'd like to suggest that
this concern may have not have been as serious as we had first
thought.

In practice, most tracepoints are used by system administrators and
they have to deal with enough changes that break backwards
compatibility (e.g., bash 3 ->bash 4, bash 4 -> bash 5, python 2.7 ->
python 3, etc.) that the ones who really care end up using an
enterprise distribution, which goes to extreme length to maintain the
stable ABI nonsense.  Maintaining tracepoints shouldn't be a big deal
for them.

Secondly, we've had a very long time to let the dentry interface
mature, and so (a) the fundamental architecture of the dcache hasn't
been changing as much in the past few years, and (b) we should have
enough understanding of the interface to understand where we could put
tracepoints (e.g., close to the syscall interface) which would make it
much less likely that there would be any need to make
backwards-incompatible changes to tracepoints.

The benefits of this would be to make it much easier for users,
developers, and kernel developers to use BPF to probe file
system-related activities.  Today, people who want to do these sorts
of things need to use fs-specific tracepoints (for example, ext4 has a
very large number of tracepoints which can be used for this purpose)
but this locks users into a single file system and makes it harder for
them to switch to a different file system, or if they want to use
different file systems for different use cases.

I'd like to propose that we experiment with adding tracepoints in
early 2025, so that at the end of the year the year-end 2025 LTS
kernels will have tracepoints that we are confident will be fit for
purpose for BPF users.

Thanks,

					- Ted

