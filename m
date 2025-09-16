Return-Path: <linux-fsdevel+bounces-61730-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EADBB597E2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 15:40:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13FA6161EFC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 13:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA7C931326B;
	Tue, 16 Sep 2025 13:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="w11yYXx+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74599315D30
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Sep 2025 13:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758030018; cv=none; b=bgXPIGG22Q/QvBhC/kAB+oWwdEtyPa+2PKmYhJWbQuNa9pjhmg7/ObHmMla6dmdjcMJblAtA+Ogq9B6+BVQSi2CfCmvI8Pj4TBHmuNFqMy3ud/bMMemKLmdocayaZV0PGcIZtXOjwWljakVcCDSuCUoMem16FpHb0CGZO9E/S2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758030018; c=relaxed/simple;
	bh=+gio5aL+IW3u8W8SSU4aBeYKAREDBl4pvtVMTW2Fww4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nHvgI2JA3bGgczJ0XgrSx7MYfB96isfY/I1E7MfsMsXjoLXZSeW0++q2glKRpJ+SPKkWD7SG8SJ4ObL5+F5uQ5mSeXQQnw7d8OmBu4Mb04etKS8fs29tXKORx88+cM7ELnIKLDJr2wQBwLW+mm/+H8mUDUs4kk0IqXlsHYTRdY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=w11yYXx+; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-45dfb8e986aso55075505e9.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Sep 2025 06:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758030015; x=1758634815; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mcfExlni0fgEhBakaF+iv8wUB2vTkCFI57QVuCuRuQI=;
        b=w11yYXx+PJ2S70aQQE6th1BIImCh6AeKdDLfGNuw5UKqoUlQg24eqiqWzz2LuG36Rr
         St7GLc6KvVp/2vysYpx1BN3l0cAXG/8+P9e80zbhvu/Kg7OAgIdQCFEeLjhmwiKxH+uf
         p7ihY0EUmz0EaHqBp8WcDF9zuLuLyQk+vBrXeBBCcAVU8+lRgrLuFbvDVAgOIpnGq/Qi
         TVC8MIaj7CrgWSh+klvGhsiNYl/1fjByc8yKuEVjD/sDV2EDFt/ZzKKNRqEpI7ky3nTm
         IhtAJC8awvvIPShrMU6xonUvljn1ALrGtZTid0edYRLBXDT+vBY0Tfbmur/QuBe+zHRM
         wSpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758030015; x=1758634815;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mcfExlni0fgEhBakaF+iv8wUB2vTkCFI57QVuCuRuQI=;
        b=as/h8onlEw+ZkVrgchtnksuJWRE/tsIKGV5jNcGHXyFtpBn3JhO7wZ80WNgFa0qLxL
         5tPVGYgcYbHeNDCcYYkykMmpJRqmKQAWzDP9fXFkZpq+J45BIcLFM2ECuPK7Sd2zfhc0
         2Ts5LycQxKzHQVVf4Kcw+Q0l/7C6ygtd2o2anVHlQy5sTxRMd+lfX0U879zmHbHjBtjV
         IuTGEPdYDWh1v2TjyM4rsyvTok0fMxMb1JJEWbtcgQdkXqeqpUMKZrxIC1z5PQNaKjJm
         G2woWWHxXJHHdV3R6iZo0wEey6nJ2cOgaItvVmjlF459X/CD5pHDWG/SDTOlBTxzqnHl
         zEhg==
X-Forwarded-Encrypted: i=1; AJvYcCU64F6uz26zsd6V3j7u0tzYKXxjIqs6aBhaGhIpCJLNKYjZkP4XoilFa8I8aPPVxz0WcHBj5o9mEXGbLOi4@vger.kernel.org
X-Gm-Message-State: AOJu0YxxJzFgXc6v9rv1yZiuoIB3M8wjHCiFGYPW/95a7/HGw5cuLNmn
	UNPc/C4N3p8iI4dODgYJ9UZvNCmio7Efrncmh4qx7BrTexd6jlfflR4GfsvUg7AcnmE=
X-Gm-Gg: ASbGncv7/A28M0Jwg/BrlOIlqJQSOjm63XDb4aq1vUBMXoDhlVky2ilmdz+xcxEBrMN
	gI3Qvdlo0M72JhFFdGmxnb1m1Bvt+v1x4qzww/J6Ai8CaRk2cZJ++ceUsBxPvA5r4Pyk/HGXpaN
	M+5wvyoVDfij8OeXO31mU7ndvcD4daBF+TDAmcJ7Nwsl0Iec+W2CP+EkYxvX0+mfQUkOY/lsx85
	iuoEOGKLcqLddngdUe5yXezT7t7xOl2H7moRu6bPhg4aprWvXc6n+9bS8vllK9qzDbb9z0a0wbY
	qU2dVgPA4B3W8/NecoIkh9l0OWhheHqyOdafbU8AJZmMoQbS6GP89FvKpUSenFNrfG/kHYrCwNW
	pygQJVk+tr1uX2mm5478v5S0LKJc=
X-Google-Smtp-Source: AGHT+IG8kaWPMWFHbVd4viKfQeFJBGjRKwC9gr1w5fiYvRQ3T/k+ZTU4DWIxru8SYExw4YHgKkL4Vg==
X-Received: by 2002:a05:6000:2887:b0:3ec:dbcc:8104 with SMTP id ffacd0b85a97d-3ecdbcc8195mr912496f8f.36.1758030014747;
        Tue, 16 Sep 2025 06:40:14 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45f31c51e8dsm41553405e9.1.2025.09.16.06.40.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 06:40:14 -0700 (PDT)
Date: Tue, 16 Sep 2025 16:40:10 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Mark Brown <broonie@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Amir Goldstein <amir73il@gmail.com>, linux-fsdevel@vger.kernel.org,
	Josef Bacik <josef@toxicpanda.com>,
	Jeff Layton <jlayton@kernel.org>, Mike Yuan <me@yhndnzj.com>,
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	Lennart Poettering <mzxreary@0pointer.de>,
	Daan De Meyer <daan.j.demeyer@gmail.com>,
	Aleksa Sarai <cyphar@cyphar.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH v2 04/33] block: use extensible_ioctl_valid()
Message-ID: <aMlouk_55OXZv8w5@stanley.mountain>
References: <20250912-work-namespace-v2-0-1a247645cef5@kernel.org>
 <20250912-work-namespace-v2-4-1a247645cef5@kernel.org>
 <02da33e3-6583-4344-892f-a9784b9c5b1b@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02da33e3-6583-4344-892f-a9784b9c5b1b@sirena.org.uk>

Yeah, the:

	if (extensible_ioctl_valid(cmd, FS_IOC_GETLBMD_CAP, LBMD_SIZE_VER0))
		return -ENOIOCTLCMD;

test is inverted...  It should be if (!valid) return instead of if (valid)
return;

regards,
dan carpenter


