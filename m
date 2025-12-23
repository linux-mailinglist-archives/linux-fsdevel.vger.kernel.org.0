Return-Path: <linux-fsdevel+bounces-71956-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 25284CD835B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Dec 2025 06:41:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C8268303C9AE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Dec 2025 05:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DAEA2F6179;
	Tue, 23 Dec 2025 05:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AmuGU0S3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE582F49F0
	for <linux-fsdevel@vger.kernel.org>; Tue, 23 Dec 2025 05:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766468350; cv=none; b=J58IntD4Vg4rJrZGoM8SGZ0Xu7gaBOTq9pFWvD3NBZX0Awt4xZtUtPf+zizyNWa1S7P0Lt4jw9it4i6f/4Wt1lh6IO8zzjGFTwoqAXO2nNBet7LMXqE+w8kedB9UKfazBzA7TpwTC02gGSxwCyOVWuITtQ3V4Fa3vNqWjV2f1II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766468350; c=relaxed/simple;
	bh=4EYwI5dt6aXRXkl+FSZUrQuoyCBEuH9OaUQ78T0nqW0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UyXCFGsWDSXZvkz/M6tmmTCR956I4V627Z6kfFvtmHEbceX0K0bt8QcJsS6wLbTiXqcJoj970QaYSJhAQMWhdMHoKdVX44het/TQi2SA9Kzza5B30cImNCszZH3C0/64F8JirdjGy3+X8h49JDpZA0UQteNw2+iWdJ8sa3BLUt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AmuGU0S3; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2a099233e8dso40146385ad.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Dec 2025 21:39:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766468347; x=1767073147; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V0Oa5NOGMRC1AJFdH7RGft89mUSkkZqf9Qovy9KVtFo=;
        b=AmuGU0S3tNTq4XtJ8CPVuHsrup5GslR4U1PsfZM5q7Es9j9PRoBOtcmrNZjZY9bYX2
         UKR+5USfuLaeedQBq8VdFeWlSpdtJwj9cUx0XSPWF6iw2+/Dx0Y5UVucH/qMMErYNCo2
         DmPMJSCgLNX8OFyioDFMPSDOCAjVz+YVUY/Iz/KUSFGJ2xhlgSyingmuGzIf1Ot4VcrN
         bRMe9e6HU5DXOTn41IlUPOezYioUBfH4sOmBJ/VJV2wbgRChwx/8WJgiqq1vVmt2UJG1
         sPq57LHY2hmsktX2yrFZnu8K5GlUfYr80BrqjJruZXf92pssdcqPz8wFkvEzjVdz2E5K
         tIhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766468347; x=1767073147;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V0Oa5NOGMRC1AJFdH7RGft89mUSkkZqf9Qovy9KVtFo=;
        b=xSxbeMCU2jmgIN2LzEMM7ChrEenlPqgfVsE91Iz4G3LbVGiGqzLL5xPfBxTqj3gL6Y
         4C4/QR6dhnsIRRzFoHWMMEc/uXsAwxjnhXVHZ0lLFjYjPjCAo8xwYhaC1sKxunmcuG2x
         yIWjm3Xqy7HdCpyqfPEzeihkLaiH2y7QC4bPnbBwBa56Ox3w/tknU+KbHQLC4qSwBtxm
         hn2BrDOT2pAsyEwnmqrGTQVJGt5gzGODkISFliS0xzUq0PdXysHvx3gIeD0IMJGLghfk
         ahaEYui0vMrvGwxv1VVoiR1EixJrIzZ59W68AKGUoTQkkkOQOwPxNx8GR8KBtwj1qmet
         qQmQ==
X-Forwarded-Encrypted: i=1; AJvYcCVIQvn9CU5UTPi77rI+JHsrIRCLmffWem4GKX6sz3QmzW3FQI8iz/oLlPnfzCa4r+g6Y9SdRU56X59uAsqT@vger.kernel.org
X-Gm-Message-State: AOJu0YzMdPZyQQ+8/nBOLXNyt4au4t4C2wnfVoOSM7ZfvJptA+7dHcz5
	Zg3GCqPaLPEErS+V0+Z1A71jRGgs83IQJy1a3oYH8iFMttj+TPJ6AS37
X-Gm-Gg: AY/fxX5D84eJJpGQPoOvvujGLt9V4MKYIC8aXru0OfWWTGCQxnfZ0fUAs2QsMSXEZLI
	rZWu5DnDVyRChsNnejo00IwiQor8hBBUZuv/vNTm2zKcVbkT4FmiDGSqbeDWoanYWXkJeoMlGd+
	ycvVy+hQ83AY3mCh9z22GQTQPgMXU47iQC+BbA+Ag2NIlwnq170lSfyCPxR0RO8QJ5/sg0mllRX
	rOrHlz48QQlF5gl6hY80JQ2L851UhoU+DGt8luCjWRYr2pcKM8FYBgRkrMvaq/Ygkfp7qqjoNrJ
	ct48ECZJBUQkC0Iolad145gMYHc+TaVknaQ8cEwMgXOLRQmYxd6w0moREg0L/OV54zhxrOdkfDS
	3L441zfkuh2gwwCG0qfX6OVaU7ULJPRaKYqFn4EVuo/WY6oxfZnhtKg34DeoeJoOPdoz+DjdlDD
	5w9m1FIIWY+B2DE+XD8cb8njW9V9+hifsSu0g/6IMwSLY72vC4tXkUsIqhfXstXQ2F
X-Google-Smtp-Source: AGHT+IFzlCLo+BvPmOwaQvXqt6LlTFpUSJebHNJribHXa7k68xn/ydFompByNLrYdKm0zAa3YWAnPw==
X-Received: by 2002:a05:7022:793:b0:11b:9386:8257 with SMTP id a92af1059eb24-12172302180mr11142291c88.44.1766468347292;
        Mon, 22 Dec 2025 21:39:07 -0800 (PST)
Received: from ?IPV6:2600:8802:b00:9ce0:637f:5cdc:9df0:d9ab? ([2600:8802:b00:9ce0:637f:5cdc:9df0:d9ab])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121724de268sm40285157c88.8.2025.12.22.21.39.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Dec 2025 21:39:06 -0800 (PST)
Message-ID: <bc999618-1f1a-4ae7-a81c-57062d57614d@gmail.com>
Date: Mon, 22 Dec 2025 21:39:05 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/11] xfs: enable non-blocking timestamp updates
To: Christoph Hellwig <hch@lst.de>, Christian Brauner <brauner@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, David Sterba <dsterba@suse.com>,
 Jan Kara <jack@suse.cz>, Mike Marshall <hubcap@omnibond.com>,
 Martin Brandenburg <martin@omnibond.com>, Carlos Maiolino <cem@kernel.org>,
 Stefan Roesch <shr@fb.com>, Jeff Layton <jlayton@kernel.org>,
 linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, gfs2@lists.linux.dev,
 io-uring@vger.kernel.org, devel@lists.orangefs.org,
 linux-unionfs@vger.kernel.org, linux-mtd@lists.infradead.org,
 linux-xfs@vger.kernel.org, linux-nfs@vger.kernel.org
References: <20251223003756.409543-1-hch@lst.de>
 <20251223003756.409543-12-hch@lst.de>
Content-Language: en-US
From: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
In-Reply-To: <20251223003756.409543-12-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/22/25 16:37, Christoph Hellwig wrote:
> The lazytime path using the generic helpers can never block in XFS
> because there is no ->dirty_inode method that could block.  Allow
> non-blocking timestamp updates for this case by replacing
> generic_update_time with the open coded version without the S_NOWAIT
> check.
>
> Fixes: 66fa3cedf16a ("fs: Add async write file modification handling.")
> Signed-off-by: Christoph Hellwig<hch@lst.de>
> Reviewed-by: Jeff Layton<jlayton@kernel.org>


Looks good.

Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>

-ck



