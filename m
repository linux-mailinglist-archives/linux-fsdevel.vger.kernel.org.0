Return-Path: <linux-fsdevel+bounces-13046-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48CEA86A845
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 07:13:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7ADC91C218BF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 06:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35E1422309;
	Wed, 28 Feb 2024 06:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="AsEoDJYn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9DB22206E
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Feb 2024 06:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709100798; cv=none; b=AcC2N8mQJLCaiZIJC7QiXj1ZqO573P+MC0u4phd2o6diRUXpLgMZzxlBz7O3v4RRRrq2+KH6d65zO52PJFNPdP4rcjxqbIkHWm63aAwg4gm4wylcsQZRZLI2Vl52ry3TTe1KrLyL0oXjgzYCYbZa7pqveoApSaTfHCaI7WqId4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709100798; c=relaxed/simple;
	bh=lcFfLEtNur4VaF3AfmMyKQ9lI1oc5tf8mlUX28tBL9g=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=YFp19lNLn++I2zqxeihfG2ccFHVdAfDyppD2wS2b8NM9ZMhxtY9/M/Nn3ayzn6af5xmDHITUHeNgsw8vMVQCvoXLdxR99Dx4S0Puklst5qkjC2aQd7aPwdQb6xIoc2N2OR8WIqCJLn0T4MfusAlj8rKovBv6oAzCoVRMUICC0VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=AsEoDJYn; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from macsyma.thunk.org (c-73-8-226-230.hsd1.il.comcast.net [73.8.226.230])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 41S6CvOu010520
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Feb 2024 01:12:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1709100780; bh=IWbYT4PyByJDLnOwDbVJjJHvgEAUwrohmKC0t0Q1qyY=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=AsEoDJYn14vXqehYaZYP/nl3VvtZXK3Kec6SaBvnuYGeodTLSKCwxieTiWRUkBYNm
	 7vhFOaFXDrxkJBaAnrcdVLNbCPEcWRdNRtzhikjUXKJHHa6T03ugZumL1IyuCTgY4D
	 5+1menC5Zz/wRo3JHTlho94G2yGiijeVweDim3mhdN+ema+IP2HfsyhxMlAjGyknjK
	 062NSTgzmxXlatrmi/r3qkpxQdPk94DBLGFvHBMs8ATCE81qnki7vUam6ns1tta17R
	 XMT3OWHj3GMS4bwA22V5xVDuEza1E5nFx5rIC4GDLbZlXkxiRQVPMxUKf5NNkx0UrT
	 BM1CPfQQI3H1g==
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id 0EE543403F5; Wed, 28 Feb 2024 00:12:57 -0600 (CST)
Date: Wed, 28 Feb 2024 00:12:57 -0600
From: "Theodore Ts'o" <tytso@mit.edu>
To: lsf-pc@lists.linux-foundation.org
Cc: linux-fsdevel@vger.kernel.org, linux-mm <linux-mm@kvack.org>
Subject: [LSF/MM/BPF TOPIC] untorn buffered writes
Message-ID: <20240228061257.GA106651@mit.edu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Last year, I talked about an interest to provide database such as
MySQL with the ability to issue writes that would not be torn as they
write 16k database pages[1].

[1] https://lwn.net/Articles/932900/

There is a patch set being worked on by John Garry which provides
stronger guarantees than what is actually required for this use case,
called "atomic writes".  The proposed interface for this facility
involves passing a new flag to pwritev2(2), RWF_ATOMIC, which requests
that the specific write be written to the storage device in an
all-or-nothing fashion, and if it can not be guaranteed, that the
write should fail.  In this interface, if the userspace sends an 128k
write with the RWF_ATOMIC flag, if the storage device will support
that an all-or-nothing write with the given size and alignment the
kernel will guarantee that it will be sent as a single 128k request
--- although from the database perspective, if it is using 16k
database pages, it only needs to guarantee that if the write is torn,
it only happen on a 16k boundary.  That is, if the write is split into
32k and 96k request, that would be totally fine as far as the database
is concerned --- and so the RWF_ATOMIC interface is a stronger
guarantee than what might be needed.

So far, the "atomic write" patchset has only focused on Direct I/O,
where this stronger guarantee is mostly harmless, even if it is
unneeded for the original motivating use case.  Which might be OK,
since perhaps there might be other future use cases where they might
want some 32k writes to be "atomic", while other 128k writes might
want to be "atomic" (that is to say, persisted with all-or-nothing
semantics), and the proposed RWF_ATOMIC interface might permit that
--- even though no one can seem top come up with a credible use case
that would require this.


However, this proposed interface is highly problematic when it comes
to buffered writes, and Postgress database uses buffered, not direct
I/O writes.   Suppose the database performs a 16k write, followed by a
64k write, followed by a 128k write --- and these writes are done
using a file descriptor that does not have O_DIRECT enable, and let's
suppose they are written using the proposed RWF_ATOMIC flag.   In
order to provide the (stronger than we need) RWF_ATOMIC guarantee, the
kernel would need to store the fact that certain pages in the page
cache were dirtied as part of a 16k RWF_ATOMIC write, and other pages
were dirtied as part of a 32k RWF_ATOMIC write, etc, so that the
writeback code knows what the "atomic" guarantee that was made at
write time.   This very quickly becomes a mess.

Another interface that one be much simpler to implement for buffered
writes would be one the untorn write granularity is set on a per-file
descriptor basis, using fcntl(2).  We validate whether the untorn
write granularity is one that can be supported when fcntl(2) is
called, and we also store in the inode the largest untorn write
granularity that has been requested by a file descriptor for that
inode.  (When the last file descriptor opened for writing has been
closed, the largest untorn write granularity for that inode can be set
back down to zero.)

The write(2) system call will check whether the size and alignment of
the write are valid given the requested untorn write granularity.  And
in the writeback path, the writeback will detect if there are
contiguous (aligned) dirty pages, and make sure they are sent to the
storage device in multiples of the largest requested untorn write
granularity.  This provides only the guarantees required by databases,
and obviates the need to track which pages were dirtied by an
RWF_ATOMIC flag, and the size of the RWF_ATOMIC write.

I'd like to discuss at LSF/MM what the best interface would be for
buffered, untorn writes (I am deliberately avoiding the use of the
word "atomic" since that presumes stronger guarantees than what we
need, and because it has led to confusion in previous discussions),
and what might be needed to support it.

						- Ted

