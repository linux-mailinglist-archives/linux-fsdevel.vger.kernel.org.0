Return-Path: <linux-fsdevel+bounces-13983-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 293FB875F26
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Mar 2024 09:10:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D76192828A2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Mar 2024 08:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6D4D51036;
	Fri,  8 Mar 2024 08:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mCRR1Bsf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEFFE50A64;
	Fri,  8 Mar 2024 08:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709885427; cv=none; b=g7DV5jU4f1KC9Y6nGuTdz1Mu/5WcvDaCi6mR+PpC7BrZWZBPxOGjWy5vvT/d66HVlhIXVqPVsUncYVOdUlmu3ohc4Os3JC1vddsqebh5JP8jzpuRui2jOTuwM+yZIzNw8ZmzMmV8OB3h9Mw4T5XRvMHQ9ORX/8Y9BcXsMZdFMbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709885427; c=relaxed/simple;
	bh=QjZEM1MYYmI+IOq2vcxJk/pRuJdvqllvHwDZJOPw12A=;
	h=Date:Message-Id:From:To:Cc:Subject:In-Reply-To; b=nZLM7TNIyLJ5TtqDQSIjiZTvb3g7Z/vJ073FzWkAaOwzMmuGNUprHEYPC7/HQhVZtCuseBEmDESt+Imv3eJ+RiSF3LvEzSS8STGn44I0TAguIaJbHr5lIBRUXCys1GxML2VCw4hLIhrQzUA8Mb1BO4xEJ6EuwUkN0hxpXdKu9H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mCRR1Bsf; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1dcc7f4717fso4793975ad.0;
        Fri, 08 Mar 2024 00:10:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709885424; x=1710490224; darn=vger.kernel.org;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hcM7FrNQHVQGFhkrY8ckS/fCn/8FtV3DNgN4UpFrLKE=;
        b=mCRR1Bsf/OP3MzNpufC9OjgT8kP5rXBIs/lHwa0nhYRGNLd+w9VQj6A05hDRGPSzTe
         D/f+ZUiyGFcBgJFtAZ9JtHRyEASljabTqO9H3rXun5nfZlAMSQqPPNVQWIt7dr9++NAi
         +D6VdfU7ulWgOVZLnesu4isGFD/iEZqgeJpwQSUxuliI2jtt2ZvQuS92F9Zx/E9bh5PS
         JFJlfn8cZvDC7Bcmyx/cpFahcE26PkDV6cKdVtrPswRVGDazcYv0wwezCIyrzAgv9Wm+
         0D4e7T0MC2AadWm3MFm48YPWor/bpZyvUNsnOkeVqJQd+CV/Hxow3QmhGQwR956LXygb
         Ou3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709885424; x=1710490224;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hcM7FrNQHVQGFhkrY8ckS/fCn/8FtV3DNgN4UpFrLKE=;
        b=dVsWAtpLx1Rsj//zukwoffKOKNhTXUuMqvFG2HJO9mStyK+NNyTr3rtYkxx/Beapu5
         jvYlSIv1Spqg+klkGQeEYDSkJv7Io/j53jpmlb79IFnTzSHq7SpnKUTEl3G0umWxll43
         Aid+i3A0k6cjxQ4oJmMI496XXQ4MahKwOmziuB5WiTuYWMST0Rnb620Q4TKJ2ixkkBrw
         hpr6iIBbBWF8VxsYQSBPG6c29QEzpAzeAxjWShblfvjagTX2Ni7yPK6HVXjf8Qwra1h0
         LcxNVyI3C6f62oeLW4T8MWEZ6Jp2cmmf2EkVt7yGyTM9LM84smWQ4Mzoxp4ZDX0RciXl
         9vQQ==
X-Forwarded-Encrypted: i=1; AJvYcCWV4iYJb8r4GEvTpbphO+Gm9ShHWo35qrkr46SHq7jYjD4L0oVAZQqBjTdFTGuUuo+LsN2GIxANY/4oh//8of4PuZbHERK4H9AG+3aHSXsodl1tpwJME5+EVeZEx5LGtPpGX3AanpUFvNF3lP4KWRA2+NvsaTX0JP7lgqXf+iYsHgsOK5Me3rw=
X-Gm-Message-State: AOJu0YziyaOsJTdImpaTwfKpaHOgtcRqWzfsQ8mJZyx2/5rPx/Yb6x0S
	UOnMBNGMNsYdgTeyiQfsKOnSvVYCqhAGgui55Mzhst8fhNjsLidWfRe+WtlP
X-Google-Smtp-Source: AGHT+IGrBuaPbsZ3jHUc+Hl21nNzlKHS6HWAKWT/9bvJ4uIRvOv547zmcLIbLtccSHPy4ErvBnLWfw==
X-Received: by 2002:a17:903:1104:b0:1dc:cbc0:1971 with SMTP id n4-20020a170903110400b001dccbc01971mr11852309plh.49.1709885424308;
        Fri, 08 Mar 2024 00:10:24 -0800 (PST)
Received: from dw-tp ([49.205.218.89])
        by smtp.gmail.com with ESMTPSA id x1-20020a170902a38100b001dd1bdee6d9sm8857439pla.31.2024.03.08.00.10.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 00:10:23 -0800 (PST)
Date: Fri, 08 Mar 2024 13:40:19 +0530
Message-Id: <87r0glp2j8.fsf@doe.com>
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: John Garry <john.g.garry@oracle.com>, linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Cc: Ojaswin Mujoo <ojaswin@linux.ibm.com>, Jan Kara <jack@suse.cz>, Theodore Ts'o <tytso@mit.edu>, Matthew Wilcox <willy@infradead.org>, "Darrick J . Wong" <djwong@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFC 4/8] ext4: Add statx and other atomic write helper routines
In-Reply-To: <e06621b2-8b33-41ec-a049-1befe83cdb5c@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

John Garry <john.g.garry@oracle.com> writes:

> On 02/03/2024 07:42, Ritesh Harjani (IBM) wrote:
>>   	}
>>   
>> +	if (request_mask & STATX_WRITE_ATOMIC) {
>> +		unsigned int fsawu_min = 0, fsawu_max = 0;
>> +
>> +		/*
>> +		 * Get fsawu_[min|max] value which we can advertise to userspace
>> +		 * in statx call, if we support atomic writes using
>> +		 * EXT4_MF_ATOMIC_WRITE_FSAWU.
>> +		 */
>> +		if (ext4_can_atomic_write_fsawu(inode->i_sb)) {
>
> To me, it does not make sense to fill this in unless 
> EXT4_INODE_ATOMIC_WRITE is also set for the inode.
>

I was thinking advertising filesystem atomic write unit on an inode
could still be advertized. But I don't have any strong objection either.
We can advertize this values only when the inode has the atomic write
attribute enabled. I think this makes more sense. 

Thanks
-ritesh


>> +			ext4_atomic_write_fsawu(inode->i_sb, &fsawu_min,
>> +						&fsawu_max);
>> +		}
>> +
>> +		generic_fill_statx_atomic_writes(stat, fsawu_min, fsawu_max);
>> +	}
>> +
>>   	flags = ei->i_flags & EXT4_FL_USER_VISIBLE;

