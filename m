Return-Path: <linux-fsdevel+bounces-32922-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 544449B0C3E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 19:55:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42761B22E72
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 17:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F7EA200B9E;
	Fri, 25 Oct 2024 17:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TkMqeKnO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA2718CC19;
	Fri, 25 Oct 2024 17:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729878882; cv=none; b=gSVUR1i45jtTykXbc05EOwpKUBPK+NZrS8/3bKtqdlJvzztoke3G5ovB9zV+JX5Lpv01j6wBKjtoNxeQtdpJcIM4XR7cAZxQFDwOWqYsf1gikJ1ihJ+oo/34n2PnH+9KD0R63xm5yOMVurNQNvoVlYowKMzTUU9oF+9/o4PCIrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729878882; c=relaxed/simple;
	bh=aATAafsKTLVSgQN8HhKPZWX/2XBJPznbOwmRE0uSSZs=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=CLTpG0EbI/4Rpga/+dac1YmEAvwpXFPZL0jv/o+NnMC2UkNcZkiOBKnDzVfa86byXxBTQB0jQYOSR4uoDePliUggQeTCzSRMuh/+w+DwPwmWmL57bbOZnnT2J46aASroib2/jvzeGu9mRwe7cqUbpu4uyFe9PVuHDxqTQyREjvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TkMqeKnO; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-20ceb8bd22fso18545165ad.3;
        Fri, 25 Oct 2024 10:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729878879; x=1730483679; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DQaE4l6YD8LIHuY6N/RnTrXda4hlyzV45z0O+q1pIik=;
        b=TkMqeKnOBwzQqMfm9/zKPWBv0siuxHgbxthdW+0LHESFIEZJ+xhIftYGp/QFGBWvSF
         2/jJACHHMZiQf70i9QjfgF9LMlRLS7qHZTBMCMw7ao2NOUbfVfoe2s56yCa/MJ9oQt+m
         wquMRndKpEuo2piSfv8fuYHeQkgWSAQRtN2vdNm0PPMmmLvxQFzu1f8A4sI7tGKwlySj
         ecsD85shqAEjt+WzsDlnzP1zQoLEHA/yp5L9XZbkJ7oogi0VmizNawuJbB2bR+WVHAEP
         DsYvLKBSlzVSFTF7Sfp34KjL8qQFR5ZADsl1g19El3dZ4eWOqqA0YAyXjodTrK0acx7r
         JVdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729878879; x=1730483679;
        h=references:message-id:date:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DQaE4l6YD8LIHuY6N/RnTrXda4hlyzV45z0O+q1pIik=;
        b=wj4AvvFABkfChUgwCjz9Gza4raZthnsmuwku8EJnlBu/HPrI45dwG2uGEOcyWmw+yX
         BneIEYc9UQDGLUVDp+pZjK/V/ARcoBrHv+mTiZaWtUEzqb5ROurDB3y6ujaS4cTdLAQ0
         rEzleiHSsvsYZwPYMDnmQ2vwNKXyKeNbfdN8TGI7Ns2LSalQrtd1pYKmy2mib8KgrzYw
         4pzr2YGV+Sxqp3wYGI84HnY0QAr8a1lWYM5ZUw8G4jnJkfdT2+Gjirr8yNe3kh2e2KeN
         gv5/OYPyPAjs6xBJgHb9ancFi1fECFmMD0Dk4mKHKhvl/WfTK2ipwMiO77vneon4DwpB
         +PjA==
X-Forwarded-Encrypted: i=1; AJvYcCUB9yFSnDgMGB8b80eTpmBysfGbQ1qvj4gnjAXkz6YXCAuLqB+wzAUxS84RpKjpxnSabKZDrcyzc5qoHWh5@vger.kernel.org, AJvYcCXdXMSa62aBFfdmKwH2WOadEcPZpQu4fiWuhrxUWSvmHn8BFAMcDl6hYgSUkqXdPbA+S0C7EGTs6zAU@vger.kernel.org, AJvYcCXwkb96dmgHWb4j80I2VI1motRfHkzUadMn6Ws3Wc2N5Egx2iGLnI2dKA5PcgsckLnSoWym6vun/fJMP5o+@vger.kernel.org
X-Gm-Message-State: AOJu0YwaMd3fiCyb0ArR/56oE2aRH/I6jsD11LAEO9yg2QJr7UHQ6Aue
	zsh8e3iTGcnsGf8TkEhbqKPG58S7H66qiIMZPrYXYrv3NFAUa8c6SH6JLg==
X-Google-Smtp-Source: AGHT+IHgpZD74pGmUZu5PDGZa3rs7b/XgzIh/UswNGAEmsb5V0PR763xsGIDpgYdz38U5Z0W8fip+A==
X-Received: by 2002:a17:902:ecc5:b0:20c:c086:4998 with SMTP id d9443c01a7336-20fab31ce28mr153954485ad.55.1729878879195;
        Fri, 25 Oct 2024 10:54:39 -0700 (PDT)
Received: from dw-tp ([171.76.85.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-210bc013392sm11960055ad.142.2024.10.25.10.54.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 10:54:38 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>, John Garry <john.g.garry@oracle.com>, Ojaswin Mujoo <ojaswin@linux.ibm.com>, Dave Chinner <david@fromorbit.com>, linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 4/6] ext4: Warn if we ever fallback to buffered-io for DIO atomic writes
In-Reply-To: <20241025161632.GL2386201@frogsfrogsfrogs>
Date: Fri, 25 Oct 2024 23:21:22 +0530
Message-ID: <87ldycm5ph.fsf@gmail.com>
References: <cover.1729825985.git.ritesh.list@gmail.com> <7c4779f1f0c8ead30f660a2cfbdf4d7cc08e405a.1729825985.git.ritesh.list@gmail.com> <20241025161632.GL2386201@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

"Darrick J. Wong" <djwong@kernel.org> writes:

> On Fri, Oct 25, 2024 at 09:15:53AM +0530, Ritesh Harjani (IBM) wrote:
>> iomap will not return -ENOTBLK in case of dio atomic writes. But let's
>> also add a WARN_ON_ONCE and return -EIO as a safety net.
>> 
>> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
>> ---
>>  fs/ext4/file.c | 10 +++++++++-
>>  1 file changed, 9 insertions(+), 1 deletion(-)
>> 
>> diff --git a/fs/ext4/file.c b/fs/ext4/file.c
>> index f9516121a036..af6ebd0ac0d6 100644
>> --- a/fs/ext4/file.c
>> +++ b/fs/ext4/file.c
>> @@ -576,8 +576,16 @@ static ssize_t ext4_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
>>  		iomap_ops = &ext4_iomap_overwrite_ops;
>>  	ret = iomap_dio_rw(iocb, from, iomap_ops, &ext4_dio_write_ops,
>>  			   dio_flags, NULL, 0);
>> -	if (ret == -ENOTBLK)
>> +	if (ret == -ENOTBLK) {
>>  		ret = 0;
>> +		/*
>> +		 * iomap will never return -ENOTBLK if write fails for atomic
>> +		 * write. But let's just add a safety net.
>
> I think it can if the pagecache invalidation fails, so you really do
> need the safety net.

Ah, right! So in that case I should remove WARN_ON_ONCE and correct
the comment too.

> I suspect that the xfs version of this series
> needs it too, though it may have fallen out?
>

I think so yes. Looks like it got missed.


> Reviewed-by: Darrick J. Wong <djwong@kernel.org>
>
> --D
>

Thanks for pointing that out.

-ritesh

>> +		 */
>> +		if (WARN_ON_ONCE(iocb->ki_flags & IOCB_ATOMIC))
>> +			ret = -EIO;
>> +	}
>> +
>>  	if (extend) {
>>  		/*
>>  		 * We always perform extending DIO write synchronously so by
>> -- 
>> 2.46.0
>> 
>> 

