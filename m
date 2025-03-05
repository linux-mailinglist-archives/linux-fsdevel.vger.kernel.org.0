Return-Path: <linux-fsdevel+bounces-43289-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D534A50B33
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Mar 2025 20:12:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E617B3A7613
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Mar 2025 19:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77CE02459FC;
	Wed,  5 Mar 2025 19:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gBl+qYim"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A8316426;
	Wed,  5 Mar 2025 19:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741201910; cv=none; b=A/taSnnzKilbyFf2xNBoi9L02/jZ5xua5/nuo74DkneaV3mnkMn1oD1Y7I3xDh60GjKQTUZLQF29PSCF1jIyZj1WsDImxUC9zs6NiGwY2L0SQG9JE22PF/AQbc1+K3cV4YwU0J3t3HnfeKiHUJVSEjxznsOP2BLhKtNgFLTn8rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741201910; c=relaxed/simple;
	bh=rlu/PBfFar6W+KzmenffVn6xjcWmymEPqS3V1DvS8Q0=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=J9W3nlH1eHkycx7fBHENcTNKwBYZC2dtg6PIls/p4hVBksnsNr+2c2WLV5anoVj9duyMUnbcLhkbi8vg017GRJUG7lHFu4sbN2j1CQboGxexu/dcW5JYEuaG6gxoybzGbVT3myS4YTqFAkF+yt2MlqRUukJJtVFzmjnt1Cwpszg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gBl+qYim; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-22409077c06so4822345ad.1;
        Wed, 05 Mar 2025 11:11:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741201908; x=1741806708; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MibBvp8fgERRPP/r2/0A4WTUjX8qZl0vepOhkrDvMmA=;
        b=gBl+qYimBCfGGciC+GZDqh7sVZvl8YWg/8RgkyQWepdRqjFuYE5tU43sagGfGqicNn
         trgm6YtIKI0Wmz1b5ymPkua1U1IDm8Wb1ahMykZ4efI430f1rc9TBppSbbCtMWPJnhEq
         c4Zteuhaf6OG/5qC48dAYF4hCHf9sSgu5fsk/LW1dFrfobv418RBlH583mYT8I2u+8Bb
         AdGbCLwVMbDUSmJQ+xLLCut6aB7UwsNDtdsx9s5FE8kTz1azNIRpPq3M7WXcEMSqGcrx
         3yTJHBZ2g63t/CjgkBI0DOZ1prVIPu0SAk7ekv4f2dDfm6XKKbGmGvSGD16ypcK8gAHS
         wbEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741201908; x=1741806708;
        h=references:message-id:date:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MibBvp8fgERRPP/r2/0A4WTUjX8qZl0vepOhkrDvMmA=;
        b=rcnt9ff8mogLEaf8NZmB6XG175Ene2HjwGp0ky7trDmggmuOsFNCxKNH7hU3dPdnbr
         Qd/aiO7Zjh0oC/+mzgEr9V3B/nNeB3rsrMxCZSNqtPfpe/WE0Z0MKEX11DbQyyGO7aDF
         k57ThFVwWaGWEAsRWSVA7Sp6s+/ic+3iJxWngem9ax0/ftESFjIdWCx//SPflnOK4QJy
         MDCFELWZvMXRybVsnnmnQbJsE8QkdXNMelBS29RiTULrwmKVVMVZc26fvwYIGkM9REj9
         dZi19XH1fakhJ7q1JuPdoLEl2/cLZx/lSfO6UBWBHMl3Eb9klmKAEXPpVJn8MK7EOd3I
         72IQ==
X-Forwarded-Encrypted: i=1; AJvYcCWj1h0QrB8PFBgXxNhB/lnPOv9ksFhF2DVFlZfg84ttn4z6Wn1KfFAEoiI/KlfibiOq/RjNE6sMX3FcZkUI@vger.kernel.org
X-Gm-Message-State: AOJu0Yyy/7jaz8LipotlEcblTawOQa/Ot41GvTjs5Y5MA1j5hQm+OG6s
	AlGlk97B8rcLDcg57ugmXn7HHHlR4OiTz0lx5iQT2gcj8eBzW3OOoEdRGw==
X-Gm-Gg: ASbGncu4uKTMBWfJG77S1vwb+OzEqCOMv8+mQodhrO9hfIqrQkNbY9g8wLxF6xJgEqF
	JSSQdNfRISO5+CJaOrcl5V8MGM5y6jFXaopxYYV5jN3RFhLyTkoSx32sVWYG5trP0c41fl82huW
	8LU+bzhTNgXZrSJZ+rE9akqigpWVJ9U/czce9k7/WI84JKLCOeFvUlC1Z0avBn7ZFeTiVH85bUR
	iOgw9gNQt5KSCh4KFG+D8ljjhLIJRpTzO6TdRWtFlpHHBZU/W8VdoujphsXPxyifuuso5KUQWAf
	H+StfnrKHiTJvtVmXPvw3RWCqOt4IRbn+6F9UA==
X-Google-Smtp-Source: AGHT+IEkmAEKPdh0jQfji8uT54ROIymXE2ge9urAF1zUGsnPiRsQO+XUM3tUN5Mtk+3AiXiLB7EQeg==
X-Received: by 2002:a17:902:cec1:b0:215:5625:885b with SMTP id d9443c01a7336-223f1d20336mr66614815ad.52.1741201908589;
        Wed, 05 Mar 2025 11:11:48 -0800 (PST)
Received: from dw-tp ([171.76.80.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223504c5bf3sm117313715ad.110.2025.03.05.11.11.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 11:11:47 -0800 (PST)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v2 1/3] xfs_io: Add support for preadv2
In-Reply-To: <20250305180833.GF2803749@frogsfrogsfrogs>
Date: Thu, 06 Mar 2025 00:37:09 +0530
Message-ID: <87bjuf70v6.fsf@gmail.com>
References: <cover.1741170031.git.ritesh.list@gmail.com> <68b83527415c7c2a74270193f5ffd14363e5de88.1741170031.git.ritesh.list@gmail.com> <20250305180833.GF2803749@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

"Darrick J. Wong" <djwong@kernel.org> writes:

> On Wed, Mar 05, 2025 at 03:57:46PM +0530, Ritesh Harjani (IBM) wrote:
>> This patch adds support for preadv2() to xfs_io.
>> 
>> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
>> ---
>>  io/Makefile |  2 +-
>>  io/pread.c  | 45 ++++++++++++++++++++++++++++++---------------
>>  2 files changed, 31 insertions(+), 16 deletions(-)
>> 
>> diff --git a/io/Makefile b/io/Makefile
>> index 8f835ec7..14a3fe20 100644
>> --- a/io/Makefile
>> +++ b/io/Makefile
>> @@ -66,7 +66,7 @@ LLDLIBS += $(LIBEDITLINE) $(LIBTERMCAP)
>>  endif
>>  
>>  ifeq ($(HAVE_PWRITEV2),yes)
>> -LCFLAGS += -DHAVE_PWRITEV2
>> +LCFLAGS += -DHAVE_PWRITEV2 -DHAVE_PREADV2
>>  endif
>>  
>>  ifeq ($(HAVE_MAP_SYNC),yes)
>> diff --git a/io/pread.c b/io/pread.c
>> index 62c771fb..b314fbc7 100644
>> --- a/io/pread.c
>> +++ b/io/pread.c
>> @@ -162,7 +162,8 @@ static ssize_t
>>  do_preadv(
>>  	int		fd,
>>  	off_t		offset,
>> -	long long	count)
>> +	long long	count,
>> +	int			preadv2_flags)
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
>>  	/* restore trimmed iov */
>>  	if (oldlen)
>>  		iov[vecs - 1].iov_len = oldlen;
>> @@ -195,12 +202,13 @@ do_pread(
>>  	int		fd,
>>  	off_t		offset,
>>  	long long	count,
>> -	size_t		buffer_size)
>> +	size_t		buffer_size,
>> +	int			preadv2_flags)
>
> Too much indenting here ^^ I think?
>

This is how I think git patch is showing. But the indentation is proper
when we apply the patch. In fact the "int fd" param is not properly
aligned to the rest of the params (lacking exactly 1 tab). Otherwise it
would have been easier to compare with "int fd".

> With that fixed,

So I don't think this needs any fixing. 

> Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
>

Thanks for the review!

-ritesh

> --D
>
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
>> +	int		preadv2_flags)
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
>> +	int		preadv2_flags)
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
>> +	int		preadv2_flags)
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
>> +	int		preadv2_flags = 0;
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
>> -- 
>> 2.48.1
>> 
>> 

