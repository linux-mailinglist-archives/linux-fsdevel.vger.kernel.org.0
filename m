Return-Path: <linux-fsdevel+bounces-32445-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C3FE9A53D6
	for <lists+linux-fsdevel@lfdr.de>; Sun, 20 Oct 2024 13:42:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B25DC1F22667
	for <lists+linux-fsdevel@lfdr.de>; Sun, 20 Oct 2024 11:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 040B8191F7E;
	Sun, 20 Oct 2024 11:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ievfR+FK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C003183CA5;
	Sun, 20 Oct 2024 11:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729424524; cv=none; b=fidAG/QDdfFdUI0F+DZUefNc9xP/AnSGEQYiq1s4UOm0B8Jdi6m4oxRv7yRSy2HIp41JMXDZE8aBeORyeYChGxmyokoEAj4LZ9EkCuQUA6TkQ4eYbDDp1Og/4HA/bfJCWBMeLaGGcvBCJR135hTU13GB7/lofWRhYyYVh6vIwnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729424524; c=relaxed/simple;
	bh=dOEtTxNoCgKNWvCOieCgqHI8eFqyxtEz3YEE1b9LO30=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=vDSgqGEEp8dnbh7GFIDfSNFggu0HfUfN3AH1Vcr7JzsPbVq/XrL25BkN15fliIDmMLSiN2HXiCF/qXgep8BQCnK38oZVlkZaSA4unCE5HF+CaUx3iVYddq5sgflO0BqKyUq92/iuVIpqQ6xyqKEfckOswcBW9f4Dbgv2Umn56vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ievfR+FK; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-20ca7fc4484so25227325ad.3;
        Sun, 20 Oct 2024 04:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729424522; x=1730029322; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lNLdxWPoqloigSpZiNStmiV3lY3Ajgs6rVNZxJBT/Dk=;
        b=ievfR+FKdyYyFi1fsF2YDNW65QbzDysF++lsuGLbiSKQjhMhQoRqaxDC+VmFsgZqS1
         q8RcFZtFdFcC++5SZQ91C6GR1qb6+rty1QDOpY7cvpeu3cTZfu/rm3GPUOtCvuQpxuh7
         SzqSEFP7un9Zunt0zsdnWRYl79SiEEyggWb43zy8MxdKZoO3+d6baVjtuPDANJajtzGz
         Ofn9vJZTKLgrrKWdE020BrycMZlzdFdMvHvJCsgS7epm/exKdA1njHk6OnZf+DBrhfMG
         FFX4B6WjgSn4Z1moiODA9U2y6hyU4i1+zxt8LRxNMnwZX1X09HgY+8PXG0s5/HBFX3Nc
         f69g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729424522; x=1730029322;
        h=references:message-id:date:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lNLdxWPoqloigSpZiNStmiV3lY3Ajgs6rVNZxJBT/Dk=;
        b=UCP/eOErQWl3ucVGfii5ilR80y85lI7rpz2oxcPly65H2BVjztaNrVAzCCQOjY85is
         yzPxIkuQtTQw1khakffiNnhbftMC6l6fWOiGq6X7D3gOHS2mC2difHmdOZDs/z24G58w
         Vjd8drGOFqt0ELN/BZLTUt4txoldOuaD4t4pk+Hwh3PEjOS9Jiq8h1WQ2zh9+povmzCO
         HGf5nEDT5Gk/ZhZXomA0IkNOkqt4yOyoWHZ84EccOFBE0y32AmPunBfv3QZwHNpSk9Fl
         drA5ojH96Hx6Q9a+rCOKGHIYZtqSDeXluQemMVRgQztk5q5Lxp0Gu7ylO8WeDn+qDa0/
         6lXw==
X-Forwarded-Encrypted: i=1; AJvYcCUjsDR2M/BkxfH8zJac+nsN30RQKADBJiLb/ywdLya566G86a/6jsxsC6ix8krznqQzHP4dY2rvRSlUY7Q/@vger.kernel.org, AJvYcCX/gviPdcFQy1lI6YKNf4Ynxc4mkc47p1b4P/iaI2xlkoRTtnRwyji84lqrY/TQ10Bt3Gq0Gq3+Yr5dDX2C@vger.kernel.org, AJvYcCXZld6sYEWo3vA7UwM/QPFtaBsYG3Zxlg0qAW8B5lPNRBc1HSpM580ANaFk8qkmt3j7i+GBWp7oI1to@vger.kernel.org
X-Gm-Message-State: AOJu0YzfpIYVeD3EV8MV6xS8VB932SJ/igv03T50C7Neltplcb7hyHij
	wCGNkUeE7Ngm25t/bmawpimBTIpbht3Tfzh9fQic5VSWgnKomFlYDiBMLw==
X-Google-Smtp-Source: AGHT+IEsk4OVyU6P/f71bkBDWmph0wOtG9z3xu5h9CKQvfJr+zUwppjE4FlHGneiBD+ceHX+0e2DHg==
X-Received: by 2002:a17:902:ce89:b0:20c:7485:891c with SMTP id d9443c01a7336-20e5a95de13mr82846255ad.54.1729424521746;
        Sun, 20 Oct 2024 04:42:01 -0700 (PDT)
Received: from dw-tp ([171.76.81.191])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e7eee3c88sm9120455ad.43.2024.10.20.04.41.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Oct 2024 04:42:01 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: John Garry <john.g.garry@oracle.com>, axboe@kernel.dk, brauner@kernel.org, djwong@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, dchinner@redhat.com, hch@lst.de, cem@kernel.org
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, hare@suse.de, martin.petersen@oracle.com, catherine.hoang@oracle.com, mcgrof@kernel.org, ojaswin@linux.ibm.com
Subject: Re: [PATCH v10 7/8] xfs: Validate atomic writes
In-Reply-To: <c4edb568-6fac-4c30-9ca3-12fbefc761e2@oracle.com>
Date: Sun, 20 Oct 2024 17:11:40 +0530
Message-ID: <87ldyjgfwr.fsf@gmail.com>
References: <20241019125113.369994-1-john.g.garry@oracle.com> <20241019125113.369994-8-john.g.garry@oracle.com> <87plnvglck.fsf@gmail.com> <c4edb568-6fac-4c30-9ca3-12fbefc761e2@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

John Garry <john.g.garry@oracle.com> writes:

> On 20/10/2024 10:44, Ritesh Harjani (IBM) wrote:
>>> +	if (iocb->ki_flags & IOCB_ATOMIC) {
>>> +		/*
>>> +		 * Currently only atomic writing of a single FS block is
>>> +		 * supported. It would be possible to atomic write smaller than
>>> +		 * a FS block, but there is no requirement to support this.
>>> +		 * Note that iomap also does not support this yet.
>>> +		 */
>>> +		if (ocount != ip->i_mount->m_sb.sb_blocksize)
>>> +			return -EINVAL;
>> Shouldn't we "return -ENOTSUPP" ?
>> Given we are later going to add support for ocount > sb_blocksize.
>
> So far we have been reporting -EINVAL for an invalid atomic write size 
> (according to atomic write unit min and max reported for that inode).
>
> -ENOTSUPP is used for times when we just don't support atomic writes, 
> like non-DIO.
>

Sure make sense. 

-ritesh

