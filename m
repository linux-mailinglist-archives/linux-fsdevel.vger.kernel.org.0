Return-Path: <linux-fsdevel+bounces-63109-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A04CBAC69F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Sep 2025 12:09:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D6F87A28A7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Sep 2025 10:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C794623C4F3;
	Tue, 30 Sep 2025 10:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="HzjaCeEV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE6154918
	for <linux-fsdevel@vger.kernel.org>; Tue, 30 Sep 2025 10:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759226953; cv=none; b=iZcoV7BBhNxtVhx82OzlIuUCWL4yOFiPrRPEQgmodUGDZP6H1YJjOzBdvW+vRpa2VgY52+I2IqW8J/Q0BPdN84wXCac/Cr1Y+pqO3C4NMwMuy6SHT0euDK5woqFeMsfaJnRXhebEubT4fP26mhgl7KE3bKgV4u2q7WWSAhYKCeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759226953; c=relaxed/simple;
	bh=SLew00m9sv/5guerSxaZ6D3P/tZBBKSOxzSolBVU8Aw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ctFW31hQTZ1D7u6SonkEOjWm7TTXkvmHmlaNEX7AJvdzLMmP2AznjPHKAUBZkPDVE5Wj2QRVHMLb1J/ol3s0L520RQmmObHdFvauarAbwPcKUyZDJXmiPkWPdCn/Rwqzw5hoy7CfHCyqpmrt9RzqTGU49+ga1x3Hzov3B2koQec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=HzjaCeEV; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4db7e5a653cso46803001cf.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 Sep 2025 03:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1759226948; x=1759831748; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SLew00m9sv/5guerSxaZ6D3P/tZBBKSOxzSolBVU8Aw=;
        b=HzjaCeEVhfdJXsiGfj77aPdUuFQQUdfr75I73WvOhAcy7QLmgTmZEaXoynAL5xn4Ya
         MkN9Zh4UDNipepRXwzZDP4TbUm8r7tKdjitmIpRyHqfGGZxRusKVjkqnKf+JFu54rC+K
         oWELfUMZxR6G80Ad01kKB3YLqQfe4GCwpDOwg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759226948; x=1759831748;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SLew00m9sv/5guerSxaZ6D3P/tZBBKSOxzSolBVU8Aw=;
        b=pDHQjXekM9MtHKCqqJBfMK43EZG7kx/uyF1MAvS2hQKTndySrgoky1ytH2ZNcPDupf
         VAM4DzHqftJa1rz1kQ7yhlE4y+mUWFDWOLy6dpivU9qyDlpQflPaavdTJnBk8RUlvI1W
         /KmOegbiUCu3FboFvzZdZfBJc4WMB4g8IAHduUMOB/SE7NBZ8l+7HDVVa+1LS2PPN1aj
         pmIRcGasB3gCAi1hkafpoxYekk5GdveT7bfiCMET5C9aNTgOZrJgIHE0JbPCDHuKR4hp
         TIVuAs4bE5y04BHe3Cbi8mANUByFCqnMnhtBcyS0CuCDWUQ3TDBODX6Uh0xd34L2THnc
         iVhg==
X-Forwarded-Encrypted: i=1; AJvYcCVHjqNfqFeJdG3u5n2tqIOAZ8BolTYMDeBfI3uUJqiYIPQ0NEmsy02vCtOo7NKJY706oEFWllIN51+reRD1@vger.kernel.org
X-Gm-Message-State: AOJu0YzxTMwCHIzDJ+QcouZVnBV/5VZhZxzSJJ7GV6JLHy2ORqDa6SyW
	EbcwVABcVASScWqDP2eRP1t3F+NO+y2ORqOD7fXl2OqlVCvhCpstvkROY/oPYMamfeXEO+M1+gh
	XCOpYEsM5oQ0sw28qS+p8Aq5Dc30bIv/fkBNVzGoXRA==
X-Gm-Gg: ASbGnctvstssYylyu9ypAVHVYW2mhxMThFKXu77/o5YEqm98wrSPzVlUCetSdBjFI5h
	MgJna3csEPu3fodKpYiL2gTMgpVBaeLqjqWt48T5NPDV8ayA+e/P5zANcnNQ8Zxp4ygKLZg6eo5
	y+4SKjahHHfZ8Y4AaV2DRUZ7+cW7EGKn8sCBzoHMAyWT5ey1fe7ZInwomc+1MEiOgXPDhFZj8KM
	+hwkl7TNqtf7VNonKQxaG6aBjp+htU7J9aKDcVXa6DSiv1JakHx4idqLc6ErSqAlLfDm3mYuQ==
X-Google-Smtp-Source: AGHT+IEq4DwIarnRg0jD+7Zy4wGDhUKfW3KJG7n7PenATFygXqxyCdRjo+JCK/n8+sN2tUe8tdZ5IhGe0Q9nfyrrf/g=
X-Received: by 2002:ac8:5716:0:b0:4b5:fd77:82c1 with SMTP id
 d75a77b69052e-4da4d220344mr236804081cf.62.1759226948601; Tue, 30 Sep 2025
 03:09:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250925224404.2058035-1-joannelkoong@gmail.com>
 <dc3fbd15-1234-485e-a11d-4e468db635cd@linux.alibaba.com> <9e9d5912-db2f-4945-918a-9c133b6aff81@linux.alibaba.com>
 <CAJnrk1b=0ug8RMZEggVQpcQzG=Q=msZimjeoEPwwp260dbZ1eg@mail.gmail.com> <a517168d-840f-483b-b9a1-4b9c417df217@linux.alibaba.com>
In-Reply-To: <a517168d-840f-483b-b9a1-4b9c417df217@linux.alibaba.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 30 Sep 2025 12:08:57 +0200
X-Gm-Features: AS18NWCaVS05nBSMv19xuvzdqrIv-l4Q-81pd2pC0o_d2SqMPUxLxdptD-oGzeE
Message-ID: <CAJfpeguSW1mSjdDZg2AnTGmRqe7F9+WhCHd3Byt2J7v4vscrsA@mail.gmail.com>
Subject: Re: [PATCH] fuse: fix readahead reclaim deadlock
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Joanne Koong <joannelkoong@gmail.com>, linux-fsdevel@vger.kernel.org, osandov@fb.com, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 30 Sept 2025 at 04:21, Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

> In principle, typical the kernel filesystem holds a valid `file`
> during the entire buffered read (file)/mmap (vma->vm_file)

Actually, fuse does hold a ref to fuse_file, which should make sure
that the inode is not released while the readahead is ongoing.

See igrab() in fuse_prepare_release() and iput() in fuse_release_end().

So I don't understand what's going on.

Joanne, do you have a reproducer?

Thanks,
Miklos

