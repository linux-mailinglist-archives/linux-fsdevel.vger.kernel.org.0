Return-Path: <linux-fsdevel+bounces-19937-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E3D648CB48D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 May 2024 22:09:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C3D31C21B5E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 May 2024 20:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B1CB149C47;
	Tue, 21 May 2024 20:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="urezVFcw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B85F148821
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 May 2024 20:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716322162; cv=none; b=p3shDj6O4csM7DQHrq9ChlFsJCTxY/jo7+GKIkkBtjkRXsCWj4Rzwb+xfwFYTua0udHDwJPybwFsi6g9iyhGUS2Sb3c/bZL23xapXCaZJmPpkoWg6G689jmZ92UVrdnG0NjEkx8mKzmKDlefYkSmWZ5kpIHxdIDRnt2I38RjWZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716322162; c=relaxed/simple;
	bh=Ia5u62ZgalmlFXflRn8jvvJ7YquyeyNuoWA9RxmS/I8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ek2DJuz+QhRQLkVoOe+078Me3kSxwwhhqdhdd5Os0xoeMfMg+VhkjZtjYM1Qff2faAvZ92I5+RiCiAULvfAMxQ5eIIemRgMDGvztz1Xt6esa3aKQ106Rvdr5p1CkntpdLQlgMpRsBC2F7TvbHcM44EX+8nNXY4CFoNCGQZZUbw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=urezVFcw; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-36dd6cbad62so2647345ab.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 May 2024 13:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1716322159; x=1716926959; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EWrpteYcdBNlx+6493QsXpUMihLRMiYDww87eKY9bg8=;
        b=urezVFcwAiXBmGxAsFkm97cF+UsuRLuHC0dXkrDQK/jCNIKBo1Yr3nZYS5q80L5Eu7
         GDyuu7LMQKf2LpA+z8dtn4OmRvdZE7fNN+cIDxjXtsIrDgrUZS4b9hc8nOyH5iLxvts+
         LXjfDggMZclw0guNwFOJJedhCjUHL3/Lw8FzuQpdD144HIbi/cUZuBH09mDS+kAbydZf
         NNpADEiNiL0gRuLH7vz0pMWsKBzGLk7NeoqzsUKHN5v8yNcAJyqRpRPVcIsxbCncGg2p
         EO6qBsC+lCGSHhn8dVfu2KU4QEJLJeQ0H1XPivealkzgHmYh5+hNh6c65K74RDtX5kGF
         ShYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716322159; x=1716926959;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EWrpteYcdBNlx+6493QsXpUMihLRMiYDww87eKY9bg8=;
        b=nSMyBC5/KRRIAQsfAl23zTFqGDpaty4h5Ml9Tmf3lSDpWFS1IxNv6Ra7NzUbsj2atg
         w2+US9qZG+6pzYEFr/c6zEf5xTGB37riiOY+JBhDjLGmxS35bvMbK5D7vrap80WfcA1h
         TWsWR4kShDnCIKKeTiyTrtP9A9zg6SBsxE46ryqtSoMQBjA1gmT/4vLCGds0DuK7mx5/
         r9bPe+nrlcl/Vue30hlxlCWD1M2Z+4TUA8Mgw7Kv1lRSihqBgj3sUKMycHp9WHF3JGGK
         KPxhzmE4KCgU+ZHB91yJiKSPSBlk8Fo+eqjbc1abLrrGrEueUB1YVXzvyi/j/kau0uHp
         A9/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUJ9bcK318oIQ9lIe7sQATeesGy7E72vwsPOjMXIulzkgeF+F9zN67a2cetmq/qPW2RkuAV/B8ZvFBzfXP0rVvV4EkBgyZ6U9I3uWam0w==
X-Gm-Message-State: AOJu0YyVvpqID2U45c+o4iMpVyatVlJvwH/IImE1d7zs8vI1tSuyDby5
	2KI56y+M4bphGY95LgmUOJXl3OGORTmg7fc76jAylqvNrPWiNiktFI2VRGdnPAU=
X-Google-Smtp-Source: AGHT+IFmqPzAUfkTViTVSpsDLLwhzPZ48S3LYwKXKDRY2ly4piMizKtsvAivJxLfypb9ZtbG417izA==
X-Received: by 2002:a05:6e02:13af:b0:369:f53b:6c2 with SMTP id e9e14a558f8ab-371f9405868mr782595ab.1.1716322159199;
        Tue, 21 May 2024 13:09:19 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4893703b15bsm7042659173.54.2024.05.21.13.09.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 May 2024 13:09:18 -0700 (PDT)
Message-ID: <6c7676ae-f0a3-4a9d-bcfa-f6fa0a03c928@kernel.dk>
Date: Tue, 21 May 2024 14:09:16 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] netfs: Fix setting of BDP_ASYNC from iocb flags
To: David Howells <dhowells@redhat.com>
Cc: Steve French <stfrench@microsoft.com>, Jeff Layton <jlayton@kernel.org>,
 Enzo Matsumiya <ematsumiya@suse.de>, Matthew Wilcox <willy@infradead.org>,
 Christian Brauner <brauner@kernel.org>, netfs@lists.linux.dev,
 v9fs@lists.linux.dev, linux-afs@lists.infradead.org,
 linux-cifs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <110d2995-f473-4781-9412-30f7f96858dd@kernel.dk>
 <2e73c659-06a3-426c-99c0-eff896eb2323@kernel.dk>
 <316306.1716306586@warthog.procyon.org.uk>
 <316428.1716306899@warthog.procyon.org.uk>
 <322229.1716321947@warthog.procyon.org.uk>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <322229.1716321947@warthog.procyon.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/21/24 2:05 PM, David Howells wrote:
> Jens Axboe <axboe@kernel.dk> wrote:
> 
>> On 5/21/24 9:54 AM, David Howells wrote:
>>> Jens Axboe <axboe@kernel.dk> wrote:
>>>
>>>> However, I'll note that BDP_ASYNC is horribly named, it should be
>>>> BDP_NOWAIT instead. But that's a separate thing, fix looks correct
>>>> as-is.
>>>
>>> I thought IOCB_NOWAIT was related to RWF_NOWAIT, but apparently not from the
>>> code.
>>
>> It is, something submitted with RWF_NOWAIT should have IOCB_NOWAIT set.
>> But RWF_NOWAIT isn't the sole user of IOCB_NOWAIT, and no assumptions
>> should be made about whether something is sync or async based on whether
>> or not RWF_NOWAIT is set. Those aren't related other than _some_ proper
>> async IO will have IOCB_NOWAIT set, and others will not.
> 
> Are you sure?  RWF_NOWAIT seems to set IOCB_NOIO.

As it should, no-wait should imply not blocking on other IO. This is
completely orthogonal to whether or not it's async or sync IO.

I have a distinct feeling we're talking past each other :-)

-- 
Jens Axboe


