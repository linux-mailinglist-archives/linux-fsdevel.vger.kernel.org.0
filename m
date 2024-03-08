Return-Path: <linux-fsdevel+bounces-13982-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBE3D875F04
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Mar 2024 09:03:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 711511F21F01
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Mar 2024 08:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30BB952F75;
	Fri,  8 Mar 2024 08:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gQhEdWpk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42FE1524B2;
	Fri,  8 Mar 2024 08:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709884970; cv=none; b=RZB4nmYXdpwlUbDw6mirWU3Vcx1n6KaQPZ4hLCuCINR2NZLInJyG9PzlrxrRDKVGZJokHC4/02Tp/A1eL8s1HnB1dEO6eU9LbjPijDGDoz9+aYODALe4DwI/9X2fMmtUe9TRxtk/80s5FJpCbQeWKIw/CIUkLs7QUbcStwdDmqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709884970; c=relaxed/simple;
	bh=DD2OjHZao1PKvEiW6v7muNX5dGWw4TSeaWSciZ5xlDE=;
	h=Date:Message-Id:From:To:Cc:Subject:In-Reply-To; b=fYfzkNNLljE3GdksOZC87ehofeJiif6Ku1fVbBu8szxfilo2vSjX/wmtPU+tkAN8PzX40ZB0K3ZwpduHY/jislrbMNIVranuJmpk9i/lQ/669Ebd0AyDI8r1JeCjLsT5ZXK727DkpLeIx/cXtpIzUZ9ojeWAxDs4/5zfMqzvRH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gQhEdWpk; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1dc1ff3ba1aso14482565ad.3;
        Fri, 08 Mar 2024 00:02:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709884967; x=1710489767; darn=vger.kernel.org;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CGH+NkVk0LWmirWv8vjWVUIOa6iKMn0cG0JNRFIGUDA=;
        b=gQhEdWpkVkq7eqsKA2dSHBUpqFHuODdLLrvPDgSWmrbi6m9MKoyoZSJr3cy9OBm45n
         2D7/WJwrm4wsLrGQenDQMsWZgl3+XIqfCSKdNwjUwBZjp89JkEhZt62l6TI9GpGM/0SH
         qUEQt2cvWTnADVaRTdppfXqNCycnm+bLVSer8zWvYRe3/DeRIfI666wmwN/RKZX9BjLi
         AHX6JFXQU8i6olo6cOnroN48pv3xrzJy8+p7Aua/Lgldyf5oVdnDdu0kqpk818/Y6mH0
         jLNKnby+Q9EAvPu1BO6ez5lrVoFbHZc6RCpfzg7wWmU83HRLLCWrBsKLkuJPL8FL7Vu/
         oB+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709884967; x=1710489767;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CGH+NkVk0LWmirWv8vjWVUIOa6iKMn0cG0JNRFIGUDA=;
        b=ceueGBYMGMDPdSussTGOFEZBXKQD3FR+Oqyr9FFwHUlKfkAMoFURvZprrnZ363vjnf
         74+V86VXgsAosHS7y56XUYt5y6JsgtVpJTCv0BQE5WES1UGKw8OW77z4psn0N5G5JlBb
         ourNOjaXxiEWy3CdiGU3aIvKyKg2G8Pni+/042IgsAMIP7DTbLOjXS0LWQFP3qLCy16D
         u7AtjsAf6aNFw9mbvKSwlGPIf9RdT6cM+StGM1T4meS8eCExcINu6U16RWCcid+yYZrW
         uG5zsWxpNXkc3XCLX3b0SFJfXjT97InYBHT5/3iDEyMYreQb2Rca74hnlTYYNx3u0zKs
         dUdQ==
X-Forwarded-Encrypted: i=1; AJvYcCVmsepUhlEi4w1HNAXNYITdFF3iU2mg5vk/9CEo9jec8XMoOzOEyrTSjv+pLgjYpck1uZ3QO8qPQZhvoinRdWNwjU7JQERiMYM1kHVTunS9Ouxu5RZCgwhi+p5FCmQecmom5f1oQjMyaQ==
X-Gm-Message-State: AOJu0YxhJpdlqI5f5fHITgm9DcGB1hOihelPLyO0KwGMyUFZ0hnLJCAe
	M9opGwtQPvGcMIsZhiQch3ChJAnDoH2htW1lEFqJfQ9zBWCt9gzKlIPWyw0b
X-Google-Smtp-Source: AGHT+IHZ0JWKUW5wHvW68w80jLwU1Wgl2jjvQPd/dhtY1akJX0NuOMjXTWAA2skaWCVKIS/jAlIJCg==
X-Received: by 2002:a17:903:1c7:b0:1dc:a60a:a7c7 with SMTP id e7-20020a17090301c700b001dca60aa7c7mr11987003plh.25.1709884967124;
        Fri, 08 Mar 2024 00:02:47 -0800 (PST)
Received: from dw-tp ([49.205.218.89])
        by smtp.gmail.com with ESMTPSA id jy7-20020a17090342c700b001dd621111e2sm1407946plb.194.2024.03.08.00.02.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 00:02:46 -0800 (PST)
Date: Fri, 08 Mar 2024 13:32:36 +0530
Message-Id: <87ttlhp2w3.fsf@doe.com>
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Dave Chinner <david@fromorbit.com>
Cc: linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, Ojaswin Mujoo <ojaswin@linux.ibm.com>, Jan Kara <jack@suse.cz>, Theodore Ts'o <tytso@mit.edu>, Matthew Wilcox <willy@infradead.org>, "Darrick J . Wong" <djwong@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, John Garry <john.g.garry@oracle.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC 6/8] ext4: Add an inode flag for atomic writes
In-Reply-To: <ZeYwavaG5WOJTFQ7@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

Dave Chinner <david@fromorbit.com> writes:

> On Sat, Mar 02, 2024 at 01:12:03PM +0530, Ritesh Harjani (IBM) wrote:
>> This patch adds an inode atomic writes flag to ext4
>> (EXT4_ATOMICWRITES_FL which uses FS_ATOMICWRITES_FL flag).
>> Also add support for setting of this flag via ioctl.
>> 
>> Co-developed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
>> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
>> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
>> ---
>>  fs/ext4/ext4.h  |  6 ++++++
>>  fs/ext4/ioctl.c | 11 +++++++++++
>>  2 files changed, 17 insertions(+)
>> 
>> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
>> index 1d2bce26e616..aa7fff2d6f96 100644
>> --- a/fs/ext4/ext4.h
>> +++ b/fs/ext4/ext4.h
>> @@ -495,8 +495,12 @@ struct flex_groups {
>>  #define EXT4_EA_INODE_FL	        0x00200000 /* Inode used for large EA */
>>  /* 0x00400000 was formerly EXT4_EOFBLOCKS_FL */
>>  
>> +#define EXT4_ATOMICWRITES_FL		FS_ATOMICWRITES_FL /* Inode supports atomic writes */
>>  #define EXT4_DAX_FL			0x02000000 /* Inode is DAX */
>
> Tying the on disk format to the kernel user API is a poor choice.
> While the flag bits might have the same value, anything parsing the
> on-disk format should not be required to include kernel syscall API
> header files just to get all the on-disk format definitions it
> needs.

sure. Make sense.
I will hardcode that value.

-ritesh

>
> -Dave.
> -- 
> Dave Chinner
> david@fromorbit.com

