Return-Path: <linux-fsdevel+bounces-43200-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D82FA4F3BC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Mar 2025 02:30:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3286116F6F4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Mar 2025 01:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7F85502B1;
	Wed,  5 Mar 2025 01:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mKhta9J5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B31C81E871;
	Wed,  5 Mar 2025 01:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741138214; cv=none; b=G/TSGLV0b6dDQCwMtDESqmf1xf4w1DEgfuQSpSmwdRe4prPBP19iIBXpnTjKt8J6BOmmbJtXLB7BZ9T8jahLpKwQ7eRDTnMeb4jExwF8gg3twMUNCKhVc4nsAeX/zNL7cGsQ/9/P4iVCodvvA3n5GsSmamCDnCZ2q7F+1nr8v+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741138214; c=relaxed/simple;
	bh=BAZpksIfudZLfG278fDh6U6XbgN0uYXIeEZSEL46VAk=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=m2JHRIqmatFM45IhslqHMkRmILVddxZpUY255rBT+vtMjjaN8GwESYd9jDegzQNDvOv/ibWNofgoPp1pMTCw1qrdt/v3Qi/EEwVF0aCl2f1aBsHe32z3GfIzhvg37M+pLgEhE+DOaM2KyAuVxN9+wVwq/nQYXHo7wqZY90OLLbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mKhta9J5; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-22356471820so101435435ad.0;
        Tue, 04 Mar 2025 17:30:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741138212; x=1741743012; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=B4k85nBDmp9f5UqLIxemhwGOtFjz2nfNoZ338sAhLj4=;
        b=mKhta9J53yWJkaYjGhPFA6/XZPbIVwCnKy/+vMp2QDZkHfkSm/6t0wly+nq89RnpW3
         V+R8e/o1p0DZQX676DlCKUUxcPM4XGNS0f2kt4gP/kNjzSkOkI3x+hhNDngG6iITMVZl
         OATJStn4MvbfmEGeUjFDBYfjPmh3WeKahbpQhfBydGsu/kXQmT+l49GBPEZI5VaW7hFd
         h8Jj8QtvAPH4hX0yErTWG5MHbwgWlyzGxMUeNoloCXdi1OjHLsOxfxgFQUzJ4h293Iw1
         LHJV+zj8S1973SSx6y5BfZZAJQ+rsqsL78xjpdoP1yQanPMwz+adIqxV8z9gggKQdW3/
         Rx4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741138212; x=1741743012;
        h=references:message-id:date:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B4k85nBDmp9f5UqLIxemhwGOtFjz2nfNoZ338sAhLj4=;
        b=fBElnpby3cpyBMYq2pOVNT1kadXlrT6LTBoLb44VNTGrJ0vv4pYfwehwLvbkYJZ6pI
         JDs1gxtMsfDPDwWjCofP9qRWStqhK2qoTpUq7etCUK1PQUo6EZnajmKuslk0FFI2RjM7
         OaBUyQVAFVB6ErYN3tPSlePTlt/PuTI5+RsytoYATJuqZP2CKT71cAeuoP2WpeLVOP1g
         86vYuYLs8i8kisrcRD1l05gVJ5dw18lfTTPtp/bSSMGHwArybFXv9cUTfSf/b1FEJ1rN
         rlcSoRz8YJTR1lVR0vPQrt8T9lsyhyPgqS+gs6D2oezo+CDV6wB9EQefVzCi5hT+CCnk
         UcHg==
X-Forwarded-Encrypted: i=1; AJvYcCWrn9vch0GM3D2Aim04Yeabc+v9I1eXjVCXU2AwfJUr2u1FNKXGOGgrB1Xt9DmulVbEd9paOvzBU7AH1clU@vger.kernel.org
X-Gm-Message-State: AOJu0YxvjFKo7GGARgztQcr1bvCT5K7WwYKiLWyJlP7iNqielWsRJKUe
	vOyNFW1SlInnqeymEQ9lp4nKNmMv/2uAjtXRn3Pbdya0OJNu54o8
X-Gm-Gg: ASbGncttwEkUMZtIc35+1UhD3cjdcRTRlE6ytbhLoszg7tzlIxfhkPnzvVsoMdlD6u/
	UphP4Ju48jL6/m0mm/OVVdci0F1E9TMfnwdSAD4jlQurqAqJUMTae43tyzJQmSPPlMKYg6AiFI6
	F8wEGUa6cGVPw9k43NoTl4j10Kd5WtPxT0UWGxs6iVcHb9+6L/7eHLM0bwPL60Dudxd/TLnXitw
	mo2FmAJ5uMTMlDKR7vmtg18H80RDRJ9rr4z+zUz7jdiH7mfyBSJUPspEPmzF/hDboe6EYsMGmx0
	Fx7YF1JWHgqDj1T/lNsxvRp+tHHA+o9XpUFqTg==
X-Google-Smtp-Source: AGHT+IHd/xOJDKzMszmmJY8R65iDjlKcj/8EOOvgOxl+O6/QSou8JF83rpuUp+diePpRmx/NTiZytg==
X-Received: by 2002:a05:6a00:3e04:b0:730:4c55:4fdf with SMTP id d2e1a72fcca58-73682bb37bemr1794349b3a.7.1741138211807;
        Tue, 04 Mar 2025 17:30:11 -0800 (PST)
Received: from dw-tp ([171.76.80.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-734a003dcedsm11642378b3a.125.2025.03.04.17.30.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 17:30:11 -0800 (PST)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v1 1/3] configure: xfs_io: Add support for preadv2
In-Reply-To: <20250304175232.GB2803749@frogsfrogsfrogs>
Date: Wed, 05 Mar 2025 06:36:05 +0530
Message-ID: <87ikoo70ci.fsf@gmail.com>
References: <cover.1741087191.git.ritesh.list@gmail.com> <046cc1b4dc00f8fb8997ec6ebedc9b3625f34c1c.1741087191.git.ritesh.list@gmail.com> <20250304175232.GB2803749@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

"Darrick J. Wong" <djwong@kernel.org> writes:

> On Tue, Mar 04, 2025 at 05:25:35PM +0530, Ritesh Harjani (IBM) wrote:
>> preadv2() was introduced in Linux 4.6. This patch adds support for
>> preadv2() to xfs_io.
>> 
>> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
>> ---
>>  configure.ac          |  1 +
>>  include/builddefs.in  |  1 +
>>  io/Makefile           |  4 ++++
>>  io/pread.c            | 45 ++++++++++++++++++++++++++++---------------
>>  m4/package_libcdev.m4 | 18 +++++++++++++++++
>>  5 files changed, 54 insertions(+), 15 deletions(-)
>> 
>> diff --git a/configure.ac b/configure.ac
>> index 8c76f398..658117ad 100644
>> --- a/configure.ac
>> +++ b/configure.ac
>> @@ -153,6 +153,7 @@ AC_PACKAGE_NEED_URCU_H
>>  AC_PACKAGE_NEED_RCU_INIT
>>  
>>  AC_HAVE_PWRITEV2
>> +AC_HAVE_PREADV2
>
> I wonder, will we ever encounter a C library that has pwritev2 and /not/
> preadv2?
>

Sure make sense. I will use Makefile to detect if we have support of
HAVE_PWRITEV2 to also define HAVE_PREADV2 (instead of using autoconf).


>>  AC_HAVE_COPY_FILE_RANGE
>>  AC_NEED_INTERNAL_FSXATTR
>>  AC_NEED_INTERNAL_FSCRYPT_ADD_KEY_ARG
>> diff --git a/include/builddefs.in b/include/builddefs.in
>> index 82840ec7..a11d201c 100644
>> --- a/include/builddefs.in
>> +++ b/include/builddefs.in
>> @@ -94,6 +94,7 @@ ENABLE_SCRUB	= @enable_scrub@
>>  HAVE_ZIPPED_MANPAGES = @have_zipped_manpages@
>>  
>>  HAVE_PWRITEV2 = @have_pwritev2@
>> +HAVE_PREADV2 = @have_preadv2@
>>  HAVE_COPY_FILE_RANGE = @have_copy_file_range@
>>  NEED_INTERNAL_FSXATTR = @need_internal_fsxattr@
>>  NEED_INTERNAL_FSCRYPT_ADD_KEY_ARG = @need_internal_fscrypt_add_key_arg@
>> diff --git a/io/Makefile b/io/Makefile
>> index 8f835ec7..f8b19ac5 100644
>> --- a/io/Makefile
>> +++ b/io/Makefile
>> @@ -69,6 +69,10 @@ ifeq ($(HAVE_PWRITEV2),yes)
>>  LCFLAGS += -DHAVE_PWRITEV2
>>  endif
>>  
>> +ifeq ($(HAVE_PREADV2),yes)
>> +LCFLAGS += -DHAVE_PREADV2
>> +endif
>> +
>>  ifeq ($(HAVE_MAP_SYNC),yes)
>>  LCFLAGS += -DHAVE_MAP_SYNC
>>  endif
>> diff --git a/io/pread.c b/io/pread.c
>> index 62c771fb..782f2a36 100644
>> --- a/io/pread.c
>> +++ b/io/pread.c
>> @@ -162,7 +162,8 @@ static ssize_t
>>  do_preadv(
>>  	int		fd,
>>  	off_t		offset,
>> -	long long	count)
>> +	long long	count,
>> +	int 		preadv2_flags)
>
> Nit:       ^ space before tab.  There's a bunch more of thense, every
> time a "preadv2_flags" variable or parameter are declared.
>

Ohk, sorry about that. Let me fix these in v2.

>>  {
>>  	int		vecs = 0;
>>  	ssize_t		oldlen = 0;
>> @@ -181,8 +182,14 @@ do_preadv(
>>  	} else {
>>  		vecs = vectors;
>>  	}
>> +#ifdef HAVE_PREADV2
>> +	if (preadv2_flags)
>> +		bytes = preadv2(fd, iov, vectors, offset, preadv2_flags);
>> +	else
>> +		bytes = preadv(fd, iov, vectors, offset);
>> +#else
>>  	bytes = preadv(fd, iov, vectors, offset);
>> -
>> +#endif
>
> Can we have the case that preadv2_flags!=0 and HAVE_PREADV2 isn't
> defined?  If so, then there ought to be a warning about that.
>

That won't happen. Since case 'U' to take input flags is defined under
#ifdef HAVE_PREADV2. So if someone tries to set preadv2_flags using -U
when HAVE_PREADV2 is not true, it will go into default case where we
will use exitcode 1 and print command_usage()


> --D
>

Thanks for the quick review. 

-ritesh


>>  	/* restore trimmed iov */
>>  	if (oldlen)
>>  		iov[vecs - 1].iov_len = oldlen;
>> @@ -195,12 +202,13 @@ do_pread(
>>  	int		fd,
>>  	off_t		offset,
>>  	long long	count,
>> -	size_t		buffer_size)
>> +	size_t		buffer_size,
>> +	int 		preadv2_flags)
>>  {
>>  	if (!vectors)
>>  		return pread(fd, io_buffer, min(count, buffer_size), offset);
>>  
>> -	return do_preadv(fd, offset, count);
>> +	return do_preadv(fd, offset, count, preadv2_flags);
>>  }
>>  
>>  static int
>> @@ -210,7 +218,8 @@ read_random(
>>  	long long	count,
>>  	long long	*total,
>>  	unsigned int	seed,
>> -	int		eof)
>> +	int		eof,
>> +	int 	preadv2_flags)
>>  {
>>  	off_t		end, off, range;
>>  	ssize_t		bytes;
>> @@ -234,7 +243,7 @@ read_random(
>>  				io_buffersize;
>>  		else
>>  			off = offset;
>> -		bytes = do_pread(fd, off, io_buffersize, io_buffersize);
>> +		bytes = do_pread(fd, off, io_buffersize, io_buffersize, preadv2_flags);
>>  		if (bytes == 0)
>>  			break;
>>  		if (bytes < 0) {
>> @@ -256,7 +265,8 @@ read_backward(
>>  	off_t		*offset,
>>  	long long	*count,
>>  	long long	*total,
>> -	int		eof)
>> +	int		eof,
>> +	int 	preadv2_flags)
>>  {
>>  	off_t		end, off = *offset;
>>  	ssize_t		bytes = 0, bytes_requested;
>> @@ -276,7 +286,7 @@ read_backward(
>>  	/* Do initial unaligned read if needed */
>>  	if ((bytes_requested = (off % io_buffersize))) {
>>  		off -= bytes_requested;
>> -		bytes = do_pread(fd, off, bytes_requested, io_buffersize);
>> +		bytes = do_pread(fd, off, bytes_requested, io_buffersize, preadv2_flags);
>>  		if (bytes == 0)
>>  			return ops;
>>  		if (bytes < 0) {
>> @@ -294,7 +304,7 @@ read_backward(
>>  	while (cnt > end) {
>>  		bytes_requested = min(cnt, io_buffersize);
>>  		off -= bytes_requested;
>> -		bytes = do_pread(fd, off, cnt, io_buffersize);
>> +		bytes = do_pread(fd, off, cnt, io_buffersize, preadv2_flags);
>>  		if (bytes == 0)
>>  			break;
>>  		if (bytes < 0) {
>> @@ -318,14 +328,15 @@ read_forward(
>>  	long long	*total,
>>  	int		verbose,
>>  	int		onlyone,
>> -	int		eof)
>> +	int		eof,
>> +	int 	preadv2_flags)
>>  {
>>  	ssize_t		bytes;
>>  	int		ops = 0;
>>  
>>  	*total = 0;
>>  	while (count > 0 || eof) {
>> -		bytes = do_pread(fd, offset, count, io_buffersize);
>> +		bytes = do_pread(fd, offset, count, io_buffersize, preadv2_flags);
>>  		if (bytes == 0)
>>  			break;
>>  		if (bytes < 0) {
>> @@ -353,7 +364,7 @@ read_buffer(
>>  	int		verbose,
>>  	int		onlyone)
>>  {
>> -	return read_forward(fd, offset, count, total, verbose, onlyone, 0);
>> +	return read_forward(fd, offset, count, total, verbose, onlyone, 0, 0);
>>  }
>>  
>>  static int
>> @@ -371,6 +382,7 @@ pread_f(
>>  	int		Cflag, qflag, uflag, vflag;
>>  	int		eof = 0, direction = IO_FORWARD;
>>  	int		c;
>> +	int 	preadv2_flags = 0;
>>  
>>  	Cflag = qflag = uflag = vflag = 0;
>>  	init_cvtnum(&fsblocksize, &fssectsize);
>> @@ -463,15 +475,18 @@ pread_f(
>>  	case IO_RANDOM:
>>  		if (!zeed)	/* srandom seed */
>>  			zeed = time(NULL);
>> -		c = read_random(file->fd, offset, count, &total, zeed, eof);
>> +		c = read_random(file->fd, offset, count, &total, zeed, eof,
>> +						preadv2_flags);
>>  		break;
>>  	case IO_FORWARD:
>> -		c = read_forward(file->fd, offset, count, &total, vflag, 0, eof);
>> +		c = read_forward(file->fd, offset, count, &total, vflag, 0, eof,
>> +						 preadv2_flags);
>>  		if (eof)
>>  			count = total;
>>  		break;
>>  	case IO_BACKWARD:
>> -		c = read_backward(file->fd, &offset, &count, &total, eof);
>> +		c = read_backward(file->fd, &offset, &count, &total, eof,
>> +						  preadv2_flags);
>>  		break;
>>  	default:
>>  		ASSERT(0);
>> diff --git a/m4/package_libcdev.m4 b/m4/package_libcdev.m4
>> index 4ef7e8f6..5a1f748a 100644
>> --- a/m4/package_libcdev.m4
>> +++ b/m4/package_libcdev.m4
>> @@ -16,6 +16,24 @@ pwritev2(0, 0, 0, 0, 0);
>>      AC_SUBST(have_pwritev2)
>>    ])
>>  
>> +#
>> +# Check if we have a preadv2 libc call (Linux)
>> +#
>> +AC_DEFUN([AC_HAVE_PREADV2],
>> +  [ AC_MSG_CHECKING([for preadv2])
>> +    AC_LINK_IFELSE(
>> +    [	AC_LANG_PROGRAM([[
>> +#define _GNU_SOURCE
>> +#include <sys/uio.h>
>> +	]], [[
>> +preadv2(0, 0, 0, 0, 0);
>> +	]])
>> +    ], have_preadv2=yes
>> +       AC_MSG_RESULT(yes),
>> +       AC_MSG_RESULT(no))
>> +    AC_SUBST(have_preadv2)
>> +  ])
>> +
>>  #
>>  # Check if we have a copy_file_range system call (Linux)
>>  #
>> -- 
>> 2.48.1
>> 
>> 

