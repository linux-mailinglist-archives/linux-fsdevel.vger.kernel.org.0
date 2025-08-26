Return-Path: <linux-fsdevel+bounces-59161-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 615C0B354B7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 08:40:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5163F1B60AA8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 06:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0034F2F547E;
	Tue, 26 Aug 2025 06:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ov3Af6id"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C7582D6412;
	Tue, 26 Aug 2025 06:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756190439; cv=none; b=DnjITOkWI9OcPysa6qdXEI+CctMB5qugRFPQDQnIlzcxtz1Z5Eva3/tvz+9CPaPu1x3/oNKjtjke535iSGqqsKGOcdvs7HgCoiEnm7x66rfd0SylhGnj3i+AyK3tWROGjoBnzCVjg3QDSEusOvd3o23PgkYn7eB0AeihT5EG2wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756190439; c=relaxed/simple;
	bh=OPeSeeN5sm4B+A5/piocA+tuR6C93uRHpSyGNO+hSSs=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=A8wGSpoVOMrym7ZtqPHyn8Aoq1qmoz6/0oqdHu5yCbIcYWrBLiJG2s2sG89h7/gWu49GoqVb11cUc0Nqhamm8tkrMXFntN4NH49s+w7SP/+ngDr/N9v2QSOQRrEI6TYF7KRt+KKWtLhNkd607FczhadCscwAxHOMWXIQqRecVN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ov3Af6id; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-771fa65b0e1so105837b3a.0;
        Mon, 25 Aug 2025 23:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756190433; x=1756795233; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oFbku8l3NNlrZ/5pf3rxrWelYCFBeqxIPXUp7eudbew=;
        b=Ov3Af6idD8tQIllh/4i6kV7Bee+HClfqkikbcbSo5PlThZwFIHNGqSo3LNjX7LJGDi
         KH25/gcO16P1PQkcx6/qFJjn5WTYoqBc0dnd0bbW15PMys5Fa3yZ6iIyn8Mj7uFv41iP
         oB3CB5vV1Zo0jzjPorgmjX+uZRTuEAj2eKTjYAHEHODTCsy1j0owoB6ZVSap0bSnukRk
         QyP2xG06sVUFpjgzq3TjUE5Zy5FtwipGX4N3h4jc2akVnCPdi8ze1JRjFDKuxv9+uH6a
         Ywqtbit5RfwiBj68Uj12od4NZvZj/tbP/pWH9bOyoejlpNe/CT2dWc4ZvTedvJDwdeXQ
         73zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756190433; x=1756795233;
        h=references:message-id:date:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oFbku8l3NNlrZ/5pf3rxrWelYCFBeqxIPXUp7eudbew=;
        b=ouA2Wtx/IDD5MYaa9udxQb2s13E+v2R8Lj6a0BlzIoT95gdA/bJho8zH1+RKdTqHQe
         M7BgnYekdO8RSCB5QXJVqiW/AXM9FjNa2xaVbT1IVpYMKgGWbqfcSjsHMQ2BmiKRxDZi
         nwQrouQVZtaOQTF0iKp5wJ8zr7eoPPq+DCnLdXXRTKZOPgWzLhezHOnmWalZF0vvCF8m
         m9I+ktls46MgzMAIK6+aQu4UJ0jowmbpXPrzRlWdYOVMps00KkA+xB+EEgIL7Dn8goMp
         HwDCQw1tOktn6AyjfSCkk5UbKWtxZ3uxSy4NzsqF0pMv0WGZ+NkLtTYNtuMyXMATAGTN
         tl9A==
X-Forwarded-Encrypted: i=1; AJvYcCVKoumyIslck1boEpBjL0ZZ9u2rTDKckmwtqHV9TgueSTI15Y/RuLUqSh9cdLnLPIIk+kv72x9gRqgc@vger.kernel.org, AJvYcCW+dHgJzZIQs4jZkStSfrDz7KRGKLdqQeMiwYpy0LYBhVxnkJkhyGJAqnS/YoIbD+knxp09qgrkOKkkDQ==@vger.kernel.org, AJvYcCX6Pmtcj4cahUdfy8UyYKLrwg538wYzeWF89uP+iaXDv3lUe7N0DRmOeBZkQJ3DZYjWbITkV/uRZHjGaYOr@vger.kernel.org, AJvYcCXqZPk3pwWhabd4czNRhY18RLeJ/bWaxeb1SEB26lrmA3LsgjneAYGK5bV49MDjlC6yuQnI3j/smJJmlQ==@vger.kernel.org, AJvYcCXxKxrjRGBo9DzMc1q2hpIxt4+gtJY+y7uw7kXPAB5jFl/lIJJwKGfTjw8CFWNZvqqrCJbXAlskQPgfvQBzSA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxfoQAx/X7ZiccCwNY51oAHyKhK9u5g37R13Qj5Tlzatk4cDBm6
	Y1/CYlOom70tGxURyzFP31Q+uZbsX1HpuB8mI1GaIlSFKmQk3f4DBN/D
X-Gm-Gg: ASbGncuDmPeJPGGCJzldJU4fdCvCjIMBgKlmYbaNpqNDYiOGx8c7/nagRCOvgzTjaZ3
	JjQCEPD3mIla9Qk8uqJAosAoH8qcG9psasmBqJRDIg9Jzaq0pl3Kxmysd1pRQIR2m0FO1aWbO5R
	91rEZf44n6TwLzEJisG7Dr/k+f8fh8K0mNA40jGcoFlbzzXhCAu2DKJUKJ+fEXmvTcSOki609U7
	SivBYSNASYULWqD+7BDM+U4aK3biNT3EL2fLpTARcxrR7fZ1XPGLrtBS41oVX7MXPSvLaOUTeJG
	D7zKpFz/DV+FtS0tw01berHYh4hq5A+CV0RVDttjPOIdylJq6OztxvK8rwofyCq1hvkrlU44JVq
	dIOIjdqEOWmLAyJJ9QDK7uNm4
X-Google-Smtp-Source: AGHT+IEc+gSdYQ6hfEohMYhEAqp/AIMMOR/OMinFKwRDdz+PsR7qTqufzjT7jd8JoY+/Ftxk3txX0w==
X-Received: by 2002:a05:6a20:2585:b0:240:ed9:dd0a with SMTP id adf61e73a8af0-24340d11bf2mr20872863637.35.1756190433217;
        Mon, 25 Aug 2025 23:40:33 -0700 (PDT)
Received: from dw-tp ([171.76.82.15])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b49cb8ca240sm8255492a12.25.2025.08.25.23.40.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 23:40:32 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Keith Busch <kbusch@kernel.org>, Jan Kara <jack@suse.cz>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org, snitzer@kernel.org, axboe@kernel.dk, dw@davidwei.uk, brauner@kernel.org, hch@lst.de, martin.petersen@oracle.com, djwong@kernel.org, linux-xfs@vger.kernel.org, viro@zeniv.linux.org.uk, Jan Kara <jack@suse.com>
Subject: Re: [PATCHv3 0/8] direct-io: even more flexible io vectors
In-Reply-To: <aKx485EMthHfBWef@kbusch-mbp>
Date: Tue, 26 Aug 2025 10:29:58 +0530
Message-ID: <87cy8ir835.fsf@gmail.com>
References: <20250819164922.640964-1-kbusch@meta.com> <87a53ra3mb.fsf@gmail.com> <g35u5ugmyldqao7evqfeb3hfcbn3xddvpssawttqzljpigy7u4@k3hehh3grecq> <aKx485EMthHfBWef@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

Keith Busch <kbusch@kernel.org> writes:

> On Mon, Aug 25, 2025 at 02:07:15PM +0200, Jan Kara wrote:
>> On Fri 22-08-25 18:57:08, Ritesh Harjani wrote:
>> > Keith Busch <kbusch@meta.com> writes:
>> > >
>> > >   - EXT4 falls back to buffered io for writes but not for reads.
>> > 
>> > ++linux-ext4 to get any historical context behind why the difference of
>> > behaviour in reads v/s writes for EXT4 DIO. 
>> 
>> Hum, how did you test? Because in the basic testing I did (with vanilla
>> kernel) I get EINVAL when doing unaligned DIO write in ext4... We should be
>> falling back to buffered IO only if the underlying file itself does not
>> support any kind of direct IO.
>
> Simple test case (dio-offset-test.c) below.
>
> I also ran this on vanilla kernel and got these results:
>
>   # mkfs.ext4 /dev/vda
>   # mount /dev/vda /mnt/ext4/
>   # make dio-offset-test
>   # ./dio-offset-test /mnt/ext4/foobar
>   write: Success
>   read: Invalid argument
>
> I tracked the "write: Success" down to ext4's handling for the "special"
> -ENOTBLK error after ext4_want_directio_fallback() returns "true".
>

Right. Ext4 has fallback only for dio writes but not for DIO reads... 

buffered
static inline bool ext4_want_directio_fallback(unsigned flags, ssize_t written)
{
	/* must be a directio to fall back to buffered */
	if ((flags & (IOMAP_WRITE | IOMAP_DIRECT)) !=
		    (IOMAP_WRITE | IOMAP_DIRECT))
		return false;

    ...
}

So basically the path is ext4_file_[read|write]_iter() -> iomap_dio_rw
    -> iomap_dio_bio_iter() -> return -EINVAL. i.e. from...


	if ((pos | length) & (bdev_logical_block_size(iomap->bdev) - 1) ||
	    !bdev_iter_is_aligned(iomap->bdev, dio->submit.iter))
		return -EINVAL;

EXT4 then fallsback to buffered-io only for writes, but not for reads. 


-ritesh


> dio-offset-test.c:
> ---
> #ifndef _GNU_SOURCE
> #define _GNU_SOURCE
> #endif
>
> #include <sys/uio.h>
> #include <err.h>
> #include <errno.h>
> #include <fcntl.h>
> #include <stdlib.h>
> #include <stdio.h>
> #include <unistd.h>
>
> int main(int argc, char **argv)
> {
> 	unsigned int pagesize;
> 	struct iovec iov[2];
> 	int ret, fd;
> 	void *buf;
>
> 	if (argc < 2)
> 		err(EINVAL, "usage: %s <file>", argv[0]);
> 	
> 	pagesize = sysconf(_SC_PAGE_SIZE);
> 	ret = posix_memalign((void **)&buf, pagesize, 2 * pagesize);
> 	if (ret)
> 		err(errno, "%s: failed to allocate buf", __func__);
> 	
> 	fd = open(argv[1], O_RDWR | O_CREAT | O_TRUNC | O_DIRECT);
> 	if (fd < 0)
> 		err(errno, "%s: failed to open %s", __func__, argv[1]);
> 	
> 	iov[0].iov_base = buf;
> 	iov[0].iov_len = 256;
> 	iov[1].iov_base = buf + pagesize;
> 	iov[1].iov_len = 256;
> 	ret = pwritev(fd, iov, 2, 0);
> 	perror("write");
> 	
> 	ret = preadv(fd, iov, 2, 0);
> 	perror("read");
> 	
> 	return 0;
> }
> --

