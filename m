Return-Path: <linux-fsdevel+bounces-44925-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A635A6E671
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Mar 2025 23:14:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3744816CE75
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Mar 2025 22:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E58D91EE7AA;
	Mon, 24 Mar 2025 22:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="jUG8Hgmu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 790771DC998
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Mar 2025 22:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742854452; cv=none; b=fQcMesMZUbdb6bi18VcNbZVCXlDK34aN136NnGsrXm1WiDpSA9Vy6wf/X+shxBGu1q0SPwpPdVIbrH8jhJ+KbYUXLyXJ+LMvJfsx40ftNksjYcrKFdGrzhVtzim0ZEq9tOe12C3PXU+DTTqPD34voLHTQJ6X9Px2GaUnjBQruZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742854452; c=relaxed/simple;
	bh=MBZ1W6CapH5d1usBknnCkjHBOxHiRymKU3jB4IbXVKY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cLClQBVpNcU2xLv2zuy5gvlAhLCJtFCYPa3T5xDQYt9FDGAll0fkKVFzAkOZNI7EuOKVIZB7jX53nPO6hM+ANl5aqBNxFxGsNJi1i7IiOjQWHbp2Yb84uVwReFpiubtIZJTinbljZOmjIIlW3rhQpVRIlu1TXp5VdE4QeWItQ34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=jUG8Hgmu; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-47691d82bfbso98108241cf.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Mar 2025 15:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1742854449; x=1743459249; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vKFno+iOMuHuHC6FIOmkLIKhwtvzDp4MmUu/eD7g6UQ=;
        b=jUG8Hgmu3qbb0PUAtX51m+gsWwDcG/c8BMyntGjDGcVqwhbY4tQ15Sk/plH8BRZSIe
         E33ZvDqLTsFI/KhsqjMtzp2K81cT//cCwxee55Tsw22JHn6BEfuArCDj9qLHehscyL0O
         UvNz6zIqViCPCM8+kA5GfWrRVVmivTldAWxnSNSdLpJTA6qugzcLhnzyTOnGpSMPj3aC
         033yJalopafgkcYN08WdlJlvlDctqNal8PV4nOtQCiIYa8AXyscICQVi2qqzbbIEnfa8
         iopsytAoeLhVg2ljGYo6NpH84vDMpsJuwjRJeXKFC9Kcay3n6B+N+/4qlSjK4fusvXXj
         7ASw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742854449; x=1743459249;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vKFno+iOMuHuHC6FIOmkLIKhwtvzDp4MmUu/eD7g6UQ=;
        b=e97nhDOmuVf0zOTTwCvC6fHrAwPnkCGT4LNpGtu37fFB6I5bc0d6giQsEQi/8EQsLY
         YwWH+NyoXkcL9tDuCX1jlhrqkf7ZRAHTbVy0BE+2/iXFH/u3ohuROjr3c/OEMmY4qt5p
         snTFvAT7hrXgSTOk+MoHNTrHKAbvWqFDnSz/FD2aNBOK216mH5M74PvCSnOWfsmYfA8r
         vyDblxtppO1O7S9Qdmy2ggalEK2lE+vROdz2gEDr3I/Ff9zMCWkcQdLe95/fL2D1alS0
         di+3RyPAgW19VHIr5MQeDe1aIj2p99jaz7ZMFS4hzq+YYjqPULU0tYONSedGQ19IQsf8
         rFWg==
X-Forwarded-Encrypted: i=1; AJvYcCWm+iE5Anz4py520dNUUgO43RpJARp8zGhFLW1we9NPHowGCmisCi4qYHC0g0UsuuTuG57QnFrWjYQTdEC0@vger.kernel.org
X-Gm-Message-State: AOJu0YyaJq/AvEDaMsiuDlVBkDQojlTn8INx1TnPJSzesS3P8PVJPPU7
	pJCt563OuC6jdqIcvtz6eRB6ED0BzNTgngHbtLJPNVtjZT+2/rJdtkKyxmep3Kc=
X-Gm-Gg: ASbGnctY9qTLDg10DIxjaTMlE3qHqDG4LYTYy0ilKZ7JzVVg43EZOUKdTUmeQbpFrKv
	N8cbG6AfQmVKppySQltcw5C7QZFBWGdzyK57RT66xkpmUVKBmK1Wuyn+uT5b6dtxwjxCKk9e8gk
	AJ2Ms0uM5fB24YgHRDNodZtnb1gyvOKOaqN3zxuUfLEStbUQzZOA5gV1ODlwBPKYT9anFrP7272
	jVg8K4XaMozqxzVeMmVXrBObvxD2prY8R/X2/ffgZIueItba/Qgpv7GJDL4wIw9VFodRk90gAy+
	9ScbubRvkxQtALtsiIRUKKyPBOQ22JMxb9mdodk=
X-Google-Smtp-Source: AGHT+IEN6pbLUjK4t/MwdNJ+7x4g+/K+DOAyn8HeIcLki0j6zcILdxKCHHj5sT36bGH6QAwdA1QJyA==
X-Received: by 2002:a05:622a:59c5:b0:476:6f90:395e with SMTP id d75a77b69052e-4771dd94fcbmr237673821cf.21.1742854448967;
        Mon, 24 Mar 2025 15:14:08 -0700 (PDT)
Received: from [172.20.6.96] ([99.209.85.25])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4771d51fe11sm51891581cf.50.2025.03.24.15.14.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Mar 2025 15:14:08 -0700 (PDT)
Message-ID: <80835395-d43d-46de-8ed6-2cc5c2268b19@kernel.dk>
Date: Mon, 24 Mar 2025 16:14:06 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH vfs/for-next 0/3] Move splice_to_socket to net/socket.c
To: Joe Damato <jdamato@fastly.com>, linux-fsdevel@vger.kernel.org
Cc: netdev@vger.kernel.org, brauner@kernel.org, asml.silence@gmail.com,
 hch@infradead.org, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>,
 "David S. Miller" <davem@davemloft.net>, Jan Kara <jack@suse.cz>,
 open list <linux-kernel@vger.kernel.org>
References: <20250322203558.206411-1-jdamato@fastly.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20250322203558.206411-1-jdamato@fastly.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/22/25 2:35 PM, Joe Damato wrote:
> Greetings:
> 
> While reading through the splice and socket code I noticed that some
> splice helpers (like sock_splice_read and sock_splice_eof) live in
> net/socket.c, but splice_to_socket does not.
> 
> I am not sure if there is a reason for this, but it seems like moving
> this code provides some advantages:
>   - Eliminates the #ifdef CONFIG_NET from fs/splice.c
>   - Keeps the socket related splice helpers together in net/socket.c
>     where it seems (IMHO) more logical for them to live

Not sure I think this is a good idea. Always nice to get rid of some
ifdefs, but the code really should be where it's mostly related to, and
the socket splice helpers have very little to do with the networking
code, it's mostly just pure splice code.

-- 
Jens Axboe

