Return-Path: <linux-fsdevel+bounces-59087-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4EC8B344A4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 16:53:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C13C35E136D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 14:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D9D82FC037;
	Mon, 25 Aug 2025 14:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sm6BrVYa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2BDE86250;
	Mon, 25 Aug 2025 14:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756133623; cv=none; b=BmB1RK0FbIQMEv/M0De3Rl7n7/S4RMaVkQKaMkRYSFlRK+UbTug5WycKqImuImzV+F/a38iAy5b2DMnXhljnvAKt4evg2nRiRMqbE7p7Q6ple4Ila5rqxxgV5R0DaDt7T0ZuUpxzPFNAQjYg2GBbncEc3rYz7Qs2AP4YN8DPrZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756133623; c=relaxed/simple;
	bh=rvSkBlgHXvVyOVF6z+Syfl+8sP5Q6VJ3ma8KracCPto=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N0sPt02zenm0QRvz+YqJeEZhLvRkkCO5cXEUPMdEJYKqEoTGI+NCVk07Jon7ebdIYYmpEcIrYRrDf6HCgnbOakdhb/DjNPoGOrrOFBxyAsC05BJgv22GFoFV7EZo2UFvmPQKOBDA3RM4uYZISTYJRYr0HAJawuWSzXnWltLwee0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sm6BrVYa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9690AC4CEED;
	Mon, 25 Aug 2025 14:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756133622;
	bh=rvSkBlgHXvVyOVF6z+Syfl+8sP5Q6VJ3ma8KracCPto=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Sm6BrVYa9/c1MVTPYHPv5SPROdM0sxumHFmknVIZd93l7YwUB9cfMJIFL5zXlhwYo
	 K6a8cEkh2PMpf1wXqjScjo1Apm5vnfaJerx85k4LHZGn4JyWGeq9gkoo53jHFmnU8t
	 jpGLxt4CRlZnOQP0TKD0Fl6m/+9ZT0CwUFKc+j65i0rUfaMhHLw7dhc7BhsQgvRRCS
	 4vj/qTn8GUcuWUgr6RUQcvRgl1Rl6RL9/fWVPOA3aXbInBxemJasvXsd4MtB4hPiyv
	 XaLpymDNR8aYEoEjgJQ1ZQy815pS4x0iGHL8tWGHCC38OjoHS8kNMY2kDaoDhKlxS+
	 YQT+cYOVVTrIw==
Date: Mon, 25 Aug 2025 08:53:39 -0600
From: Keith Busch <kbusch@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Ritesh Harjani <ritesh.list@gmail.com>, Keith Busch <kbusch@meta.com>,
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org,
	snitzer@kernel.org, axboe@kernel.dk, dw@davidwei.uk,
	brauner@kernel.org, hch@lst.de, martin.petersen@oracle.com,
	djwong@kernel.org, linux-xfs@vger.kernel.org,
	viro@zeniv.linux.org.uk, Jan Kara <jack@suse.com>
Subject: Re: [PATCHv3 0/8] direct-io: even more flexible io vectors
Message-ID: <aKx485EMthHfBWef@kbusch-mbp>
References: <20250819164922.640964-1-kbusch@meta.com>
 <87a53ra3mb.fsf@gmail.com>
 <g35u5ugmyldqao7evqfeb3hfcbn3xddvpssawttqzljpigy7u4@k3hehh3grecq>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <g35u5ugmyldqao7evqfeb3hfcbn3xddvpssawttqzljpigy7u4@k3hehh3grecq>

On Mon, Aug 25, 2025 at 02:07:15PM +0200, Jan Kara wrote:
> On Fri 22-08-25 18:57:08, Ritesh Harjani wrote:
> > Keith Busch <kbusch@meta.com> writes:
> > >
> > >   - EXT4 falls back to buffered io for writes but not for reads.
> > 
> > ++linux-ext4 to get any historical context behind why the difference of
> > behaviour in reads v/s writes for EXT4 DIO. 
> 
> Hum, how did you test? Because in the basic testing I did (with vanilla
> kernel) I get EINVAL when doing unaligned DIO write in ext4... We should be
> falling back to buffered IO only if the underlying file itself does not
> support any kind of direct IO.

Simple test case (dio-offset-test.c) below.

I also ran this on vanilla kernel and got these results:

  # mkfs.ext4 /dev/vda
  # mount /dev/vda /mnt/ext4/
  # make dio-offset-test
  # ./dio-offset-test /mnt/ext4/foobar
  write: Success
  read: Invalid argument

I tracked the "write: Success" down to ext4's handling for the "special"
-ENOTBLK error after ext4_want_directio_fallback() returns "true".

dio-offset-test.c:
---
#ifndef _GNU_SOURCE
#define _GNU_SOURCE
#endif

#include <sys/uio.h>
#include <err.h>
#include <errno.h>
#include <fcntl.h>
#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>

int main(int argc, char **argv)
{
	unsigned int pagesize;
	struct iovec iov[2];
	int ret, fd;
	void *buf;

	if (argc < 2)
		err(EINVAL, "usage: %s <file>", argv[0]);
	
	pagesize = sysconf(_SC_PAGE_SIZE);
	ret = posix_memalign((void **)&buf, pagesize, 2 * pagesize);
	if (ret)
		err(errno, "%s: failed to allocate buf", __func__);
	
	fd = open(argv[1], O_RDWR | O_CREAT | O_TRUNC | O_DIRECT);
	if (fd < 0)
		err(errno, "%s: failed to open %s", __func__, argv[1]);
	
	iov[0].iov_base = buf;
	iov[0].iov_len = 256;
	iov[1].iov_base = buf + pagesize;
	iov[1].iov_len = 256;
	ret = pwritev(fd, iov, 2, 0);
	perror("write");
	
	ret = preadv(fd, iov, 2, 0);
	perror("read");
	
	return 0;
}
--

