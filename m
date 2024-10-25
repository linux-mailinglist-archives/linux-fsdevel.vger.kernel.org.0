Return-Path: <linux-fsdevel+bounces-32921-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F18219B0C26
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 19:51:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F7941C20AB1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 17:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A7DE1FB89E;
	Fri, 25 Oct 2024 17:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZaWo9SHs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D7B18C02E;
	Fri, 25 Oct 2024 17:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729878643; cv=none; b=ZJi8gMc4zAlDRToTJcvAvgGw0/NyHijf3+I3rT/WpUhJgNBXO8tuPdFlSudm4cPcXuLKCwbL/GobcF8JRiic7RNVjNUP1zdKDZb0DGXJTKsIkwcnHj03245IXqEmL4dGaV3IyQCoeSI/OZfC/AY4bu1jmiNh5TroD5UtGrqGDbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729878643; c=relaxed/simple;
	bh=Dgf0Y4s6QVh/AJGYZhjcKZ5u8LJTOFqyvfuz7txKybU=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=d45hQQyRlzTF7+Qcb4zmXc9YBwrFPIFetaiqdpJaOBZ09auEBcWzFMWBpkt6S+9F+NZ83vDwrHuyjzKtmMOmc2i2gpdcLJUHBf6zVhErrMeaSRXmCkaSnZ1kr0pzzE27hC30CMoaHgn8bNGmJKsascAnj8XE87itA08o0P1mUjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZaWo9SHs; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-20cceb8d8b4so12932855ad.1;
        Fri, 25 Oct 2024 10:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729878640; x=1730483440; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hXO015SY00U52dE4urHGMPnobIGL1/gKdqDsZCitIQA=;
        b=ZaWo9SHsp38r2T2U/pKkiDjzXtlYdpySjl0vvIWQrNzYYmnky6Uv0L5IlZ+7laKo+j
         PG03qodtUaquaVVCe+2AX+uAOi+jCezvVvntjdXnf+i9IBJNBb2+Kpb2C828CNJIqxDz
         4AGwnZqWNL+5uYBGIeJ6TcUVLVWuAZ3qPD52o/fdOIrZhXRK4oUy5G7onbAmqGKAVCXl
         qrNEiW5TlQwqEv/tLH1h2QF7INIOK7Jj7f1dYEAppStgFKgpN/ErA0BYEG0JKGvclavU
         aV43Jw8Spm4nna8M5NPrcL3rIpyJNUOJmQpIVDTvkpDn/L1C1eDl0ZVtMQjoZ6BfR9XD
         hHdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729878640; x=1730483440;
        h=references:message-id:date:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hXO015SY00U52dE4urHGMPnobIGL1/gKdqDsZCitIQA=;
        b=BpW4aokXjTBkAY6xhfhhxu6C/jys52o01VKNt3RrFWaOS9/eXbq4B5TaVeHFceJFOB
         3M+jxOPBxBtbZkCZ+SzmO+QRm27ffdAvoIHW3mIYqEAey1pTgMtRXDo/VnMGh5ORKgXx
         46CZ9kRuOHITa/qDOI7X0VbX0GhMgHdvOGzutUkKdm5b4XHwLv9RLg5wTwRR/kY76Z2i
         0F4ta05B0sK+eP5DW5GA+TcvyuD0AQ4Ut6FHe7Z0vp/ETWK9PCfSOESL02jgDdEWEBZN
         icu7bPmzjztF76B+0EfrDtKTKpfAjAzPayGy6w7ttS5FktlXsx2tRx/F8WU6R/HKrBGu
         xrqg==
X-Forwarded-Encrypted: i=1; AJvYcCUNYyZEGWH+nJCZjHYn9bJJycRSIcRehRpOYiuSnuNiqY1ySLYnBQ5k9U51hkeibwWKmXECeNgzw2EyOXndng==@vger.kernel.org, AJvYcCUuiHFT2yz1PQXXTsJdrw9IBRmLkiDE8i65lvj8fTIAa8qxmjbJSlTXABNgQU5NisvlrFmylNgF7uaC@vger.kernel.org, AJvYcCWd7Z64TSJLtHCPHtrKK1oNLd8xckW8cLZ/eQpt3UfkxKWQ1tCYjE1FLC95is85Rltj0Urht8n7JF4K@vger.kernel.org, AJvYcCXHGmWn0c0q6rz9gYXA3jZR5Z0+QaAZv0ga0u1rd/qF0W0p7E+06SwUzUwGOyrgj+Bazc16VuUBpw2dQ4Pb@vger.kernel.org
X-Gm-Message-State: AOJu0Yw73EhON4lqcp971NFMuEerSHl0IHa/wVDfR2axbfGVXQZlCKqg
	zwzujsLplPmW5jekTB8gIcYM9RBqRkzfYoFwHnwsalefLCZVb3NIe03rVQ==
X-Google-Smtp-Source: AGHT+IFfkH0cnfWPkAORX05I+avgZ9f2e5kGrP39f/spd+jEqOTI9dQ+/HXY3i3aDkLGnT3ND3MjoQ==
X-Received: by 2002:a17:902:ea0c:b0:20c:9026:93a with SMTP id d9443c01a7336-20fb89daaf3mr101315385ad.19.1729878640407;
        Fri, 25 Oct 2024 10:50:40 -0700 (PDT)
Received: from dw-tp ([171.76.85.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-210bbf6dc66sm11822085ad.101.2024.10.25.10.50.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 10:50:39 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: John Garry <john.g.garry@oracle.com>, linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>, Ojaswin Mujoo <ojaswin@linux.ibm.com>, Dave Chinner <david@fromorbit.com>, linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/6] ext4: Check for atomic writes support in write iter
In-Reply-To: <20241025161131.GK2386201@frogsfrogsfrogs>
Date: Fri, 25 Oct 2024 23:20:11 +0530
Message-ID: <87msism5rg.fsf@gmail.com>
References: <cover.1729825985.git.ritesh.list@gmail.com> <319766d2fd03bd47f773d320577f263f68ba67a1.1729825985.git.ritesh.list@gmail.com> <b6f456bb-9998-4789-830d-45767dbbfdea@oracle.com> <87wmhwmq01.fsf@gmail.com> <20241025161131.GK2386201@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

"Darrick J. Wong" <djwong@kernel.org> writes:

> On Fri, Oct 25, 2024 at 04:03:02PM +0530, Ritesh Harjani wrote:
>> John Garry <john.g.garry@oracle.com> writes:
>> 
>> > On 25/10/2024 04:45, Ritesh Harjani (IBM) wrote:
>> >> Let's validate using generic_atomic_write_valid() in
>> >> ext4_file_write_iter() if the write request has IOCB_ATOMIC set.
>> >> 
>> >> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
>> >> ---
>> >>   fs/ext4/file.c | 14 ++++++++++++++
>> >>   1 file changed, 14 insertions(+)
>> >> 
>> >> diff --git a/fs/ext4/file.c b/fs/ext4/file.c
>> >> index f14aed14b9cf..b06c5d34bbd2 100644
>> >> --- a/fs/ext4/file.c
>> >> +++ b/fs/ext4/file.c
>> >> @@ -692,6 +692,20 @@ ext4_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
>> >>   	if (IS_DAX(inode))
>> >>   		return ext4_dax_write_iter(iocb, from);
>> >>   #endif
>> >> +
>> >> +	if (iocb->ki_flags & IOCB_ATOMIC) {
>> >> +		size_t len = iov_iter_count(from);
>> >> +		int ret;
>> >> +
>> >> +		if (!IS_ALIGNED(len, EXT4_SB(inode->i_sb)->fs_awu_min) ||
>> >> +			len > EXT4_SB(inode->i_sb)->fs_awu_max)
>> >> +			return -EINVAL;
>> >
>> > this looks ok, but the IS_ALIGNED() check looks odd. I am not sure why 
>> > you don't just check that fs_awu_max >= len >= fs_awu_min
>> >
>> 
>> I guess this was just a stricter check. But we anyways have power_of_2
>> and other checks in generic_atomic_write_valid(). So it does not matter. 
>> 
>> I can change this in v2. 
>
> Also please fix the weird indenting in the if test:
>
> 		if (len < EXT4_SB(inode->i_sb)->fs_awu_min) ||
> 		    len > EXT4_SB(inode->i_sb)->fs_awu_max)
> 			return -EINVAL;
>
> --D

Got it!

-ritesh

>
>> Thanks!
>> 
>> >> +
>> >> +		ret = generic_atomic_write_valid(iocb, from);
>> >> +		if (ret)
>> >> +			return ret;
>> >> +	}
>> >> +
>> >>   	if (iocb->ki_flags & IOCB_DIRECT)
>> >>   		return ext4_dio_write_iter(iocb, from);
>> >>   	else
>> 
>> -ritesh
>> 

