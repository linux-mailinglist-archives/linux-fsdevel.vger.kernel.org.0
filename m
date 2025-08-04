Return-Path: <linux-fsdevel+bounces-56672-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5338EB1A855
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Aug 2025 19:06:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 704BC16E947
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Aug 2025 17:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DCDE28B401;
	Mon,  4 Aug 2025 17:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VquAel3/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8356619F11E;
	Mon,  4 Aug 2025 17:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754327176; cv=none; b=q9iWoyrvDfbS9JWgo0LkBY/NDMFz05gaE0ccmngcdfTJIaBBgy8ctZ41qwTaaAQMaot//XQOrbNdgq0JdwR1uJTDM67wG+sAKDLZN1cg3ZBTdVEDQoSLNqr87RaerWhByuj6n+RyHDPUHGGKLHBlXZ6s/kLz2UDeQu2IGBR3rG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754327176; c=relaxed/simple;
	bh=OtkcLE6jiVrpw9+Y7WxMUvxGGzQdpskb3RxE6l34rLA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NI7E8vLJO/+jgtWponQox5EmqEus5jevakCSrv2v7+Fr4VivcuZ17MZLgPKe/j2NdC6yf6vr66AYqujPXSMzOghMkgw3i2okMA0CvIED8EoHEfhektipB0893OYKs/Eux2JNi2J/z3dFNeX9desV/i1eV2pK86MvFh5ZQSJqlDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VquAel3/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 695D2C4CEE7;
	Mon,  4 Aug 2025 17:06:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754327175;
	bh=OtkcLE6jiVrpw9+Y7WxMUvxGGzQdpskb3RxE6l34rLA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VquAel3/ToXsi4MwFUgneKdKNa3SyBeBuQpNaaR8wgZBoMNp3WmUEgxrd70HDecgl
	 iUZrfDr1zAWiDbJC77vjYv2ktSNqne0iu+q5HI43XVVyPyApBnU+YKtLyYiSoO9MkI
	 sGfN8DsxUYsDg72ONBzwVx5xtXPeF+GVXaHG3aQ1QhZhHnw2Klov25jy7AnCV/utt6
	 MNrwFqIoSe6WyKHcKCDg5QPxWK/xrPyNm/FDJm4wiZ5jdpbwmekurVBaQNcR7i5wDl
	 UWO0nR0XY3TE+97ZU4886KYuAMDdCyWrOld76m7eW9LQeqS7ZxiNYbXKxt8yxgoTJU
	 Pe4+WxqUJCXWw==
Date: Mon, 4 Aug 2025 11:06:12 -0600
From: Keith Busch <kbusch@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	snitzer@kernel.org, dw@davidwei.uk, brauner@kernel.org
Subject: Re: [PATCH 0/7] direct-io: even more flexible io vectors
Message-ID: <aJDohO7v7lMWxn7V@kbusch-mbp>
References: <20250801234736.1913170-1-kbusch@meta.com>
 <43716438-2fb9-4377-a4a0-6f803d7b8aec@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43716438-2fb9-4377-a4a0-6f803d7b8aec@kernel.dk>

On Sat, Aug 02, 2025 at 09:37:32AM -0600, Jens Axboe wrote:
> Did you write some test cases for this?

I have some crude unit tests to hit specific conditions that might
happen with nvme.

Note, the "second" test here will fail with the wrong result with this
version of the patchset due to the issue I mentioned on patch 2, but
I've a fix for it ready for the next version.

---
/*
 * This test is aligned to NVMe's PRP virtual boundary. It is intended to
 * execute on such a device with 4k formatted logical block size.
 *
 * The first test will submit a vectored read with a total size aligned to a 4k
 * block, but individual vectors may not be. This should be successful.
 *
 * The second test will submit a vectored read with a total size aligned to a
 * 4k block, but the first vector contains an invalid address. This should get
 * EFAULT.
 *
 * The third one will submit an IO with a total size aligned to a 4k block,
 * but it will fail the virtual boundary condition, which should result in a
 * split to a 0 length bio. This should get an EINVAL.
 *
 * The fourth test will submit IO with a total size aligned to a 4k block, but
 * with invalid DMA offsets. This should get an EINVAL.
 *
 * The last test will submit a large IO with a page offset that should exceed
 * the bio max vectors limit, resulting in reverting part of a bio iteration.
 * This should be successful.
 */
#define _GNU_SOURCE
#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <errno.h>
#include <sys/uio.h>
#include <string.h>

#define BSIZE (8 * 1024 * 1024)
#define VECS 4

int main(int argc, char **argv)
{
        int fd, ret, i, j;
        struct iovec iov[VECS];
        char *buf;

        if (argc < 2)
                return -1;

        fd = open(argv[1], O_RDONLY | O_DIRECT);
        if (fd < 0)
                return fd;

        ret = posix_memalign((void **)&buf, 4096, BSIZE);
        if (ret)
                return ret;

        memset(buf, 0, BSIZE);

        iov[0].iov_base = buf + 3072;
        iov[0].iov_len = 1024;

        iov[1].iov_base = buf + (2 * 4096);
        iov[1].iov_len = 4096;

        iov[2].iov_base = buf + (8 * 4096);
        iov[2].iov_len = 4096;

        iov[3].iov_base = buf + (16 * 4096);
        iov[3].iov_len = 3072;

        ret = preadv(fd, iov, VECS, 0);
        if (ret < 0)
                perror("unexpected read failure");

        iov[0].iov_base = 0;
        ret = preadv(fd, iov, VECS, 0);
        if (ret < 0)
                perror("expected read failure for invalid address");

        iov[0].iov_base = buf;
        iov[0].iov_len = 1024;

        iov[1].iov_base = buf + (2 * 4096);
        iov[1].iov_len = 1024;

        iov[2].iov_base = buf + (8 * 4096);
        iov[2].iov_len = 1024;

        iov[3].iov_base = buf + (16 * 4096);
        iov[3].iov_len = 1024;

        ret = preadv(fd, iov, VECS, 0);
        if (ret < 0)
                perror("expected read for invalid virtual boundary");

        iov[0].iov_base = buf + 3072;
        iov[0].iov_len = 1025;

        iov[1].iov_base = buf + (2 * 4096);
        iov[1].iov_len = 4096;

        iov[2].iov_base = buf + (8 * 4096);
        iov[2].iov_len = 4096;

        iov[3].iov_base = buf + (16 * 4096);
        iov[3].iov_len = 3073;

        ret = preadv(fd, iov, VECS, 0);
        if (ret < 0)
                perror("expected read for invalid dma boundary");

        ret = pread(fd, buf + 2048, BSIZE - 8192, 0);
        if (ret < 0)
                perror("unexpected large read failure");

        free(buf);
        return errno;
}
--

