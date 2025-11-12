Return-Path: <linux-fsdevel+bounces-68014-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 767F7C50E5D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Nov 2025 08:21:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C5613BBB42
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Nov 2025 07:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D71AF2BCF46;
	Wed, 12 Nov 2025 07:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XgH8q1jr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C28C6286D57
	for <linux-fsdevel@vger.kernel.org>; Wed, 12 Nov 2025 07:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762931652; cv=none; b=QIf9b8MqxRvxrivhhc4d2r2SUADOMALGOscPSCo3Jla94VGBIJQBLjtcueB44kD1AhFUYnnAODchOsUavm6gA6E7B/OKgbgaEC0MhyxA9wd3KL6G7PNC6NbqqqWtqFM6DFpgbuOwnBHvJBpJDBvNvzNvkswOL61AsidG96rn6/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762931652; c=relaxed/simple;
	bh=cUgCmt7/S4H78nSegwnrwPgzDrfISuJQ8hnVSCrlVDQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C0PajoTe2n7/+0Rv87IVq1sYUeG/SFKkc9MnGiSrv6NqWOl1Mu/ojlM5B0S2bgHCNgxaard+In+BcCnTBDa2w2yzYAzt7WA9uqeUHTMUe9EKiqChWH88YyDG4p07+kaLSXfop9KHTwTyAt+Bq8vtNHYNS2K3Fcj3MMId1uds1gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XgH8q1jr; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2958db8ae4fso4652205ad.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Nov 2025 23:14:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762931650; x=1763536450; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X8sb02e1W+AKeJ6wR0eYaD2KkfiM6HqalBahoIkkYHA=;
        b=XgH8q1jr2+XQgLkfDKCa/eUWE1ZvSrkjRxtr5lBbLGxRYdtzxNaRzJKM50Ux2SEHOn
         0BlAjFIYdWeA6qeOVyyZmDrK6k4OKLxGTQYKjGI7qHlLKCwbVIW0OFzrgEv4v5ewBziv
         lv4ohKUGv7dG6To2zsCiMcMO+Ruuo3xwZdTgTqKyLYSvet1wbq7QLkzDOvfx78zFlOw+
         MR3w5gfbC9TLFm1qlc0UjFCOBC78Zar1o6Tx335kme/yEGz0nsP3JeYSRpYmnGxuxOuv
         z5Wpi3dE0zdK4SoBYUa7rWSOkPUcOAf6XQY3Au3eII4YW4J+vud6XV4zDnR1hSYZ39Yj
         SQ2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762931650; x=1763536450;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X8sb02e1W+AKeJ6wR0eYaD2KkfiM6HqalBahoIkkYHA=;
        b=h2RySYtb3gBqy9iUpJktggS30SqenTw5w5SqqKG35QqUxNpgAPze8UNn0k9Gpi/V7K
         gS+YAnSkurYV4F6NVVnJfCBPmq6yOukB56wNFnEz4dwneKzxA3Fa8+tuqQ2RfAnPSa8L
         Gds8PgnIWHBGO03GSNeKTPyInvE6daQ9Qg+m7sGoZAK08OMWQGUCEkKVbgIZWoubWMwN
         Bu6V6svLVDfoZjdNpsoDtFvaRFzZoxUiLoYPQEUHlJcGuBcAEx4283O611hjI2FwDvqn
         aNLVPVaIu6QQ50vLDJRI/jgOy2NbLcF0+H6ky98Bf6p3P/WHDXE14uC8c27JEIX/+DV6
         vakQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8qNr8iblrYS3gCexeciEHrqjXDrB29DHLNLmsFnBQg2rl323eKG8oTQQVkiBkgDrWFHQMsoE2HxBxrQUd@vger.kernel.org
X-Gm-Message-State: AOJu0YxKNxkiAQAkiZ09toyDp2w9DKtGzhxo3bFRzew3juz2ie//rAed
	g85ostkO43HsCcVP1dizOgCimzAgbT4X0G2TmU7nSI6Aa8ZDNmyH7yXo
X-Gm-Gg: ASbGncsuSLuuHMaQ4TN4z5W80Miuj3+ZWE9XlUVevaMaMTDcppCSf8MS3LL9VtYrCoE
	bXNXCi1HjJ67dU+KwXd8Vt2fxFjc9mvpqGtHGXaZnDUDlAv2s1Ih5s8xLNC9PB1mWvdHF7AAp5W
	lr4n/MV2/ECLz0EqGw4r/GNj98DMirxjBAkW2fEy1dA2I6jc/3HnjuZ7xuFqMc0deoXjIiVKCLc
	C6gix7xS2uludNHqrfeAFjmu6VCjklhqPfDzzORp9mUUzNVxxwbYFC6cSncFE7mQ6CQgkArhL0n
	+wsUNd2utbn7Ph4eYO1EXxzKUOiwZtN471hkh0DIfNEshVJ7ItXImm1k9oMSlAyvGR478BsP5Ro
	GNZ5X53E1s4rSEKqyFg454zpNpkvZYu3TnCjmmHnZQlNyUeyI3xMET8xTd791zcX5He30KJrEA7
	1xiip3UgeDou9PCQRd
X-Google-Smtp-Source: AGHT+IFxIDHbMDQtJnDd1j29er8I9W16ktyYHaqy/e9kdgu1LMq6asMSVrMWec36NOc6lpyOhk0v6w==
X-Received: by 2002:a17:903:3d0b:b0:295:9e4e:4090 with SMTP id d9443c01a7336-2984edde5demr21733055ad.52.1762931650013;
        Tue, 11 Nov 2025 23:14:10 -0800 (PST)
Received: from [9.109.246.38] ([129.41.58.6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2984dca027esm19947645ad.70.2025.11.11.23.14.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Nov 2025 23:14:09 -0800 (PST)
Message-ID: <c91c87ab-dd85-4c42-9af4-a25ea2540de3@gmail.com>
Date: Wed, 12 Nov 2025 12:43:05 +0530
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] xfs: fallback to buffered I/O for direct I/O when
 stable writes are required
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
Cc: Carlos Maiolino <cem@kernel.org>, Christian Brauner <brauner@kernel.org>,
 Jan Kara <jack@suse.cz>, "Martin K. Petersen" <martin.petersen@oracle.com>,
 linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-raid@vger.kernel.org,
 linux-block@vger.kernel.org
References: <20251029071537.1127397-1-hch@lst.de>
 <20251029071537.1127397-5-hch@lst.de>
 <7f7163d79dc89ae8c8d1157ce969b369acbcfb5d.camel@gmail.com>
 <20251110135932.GA11277@lst.de>
From: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
In-Reply-To: <20251110135932.GA11277@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 11/10/25 19:29, Christoph Hellwig wrote:
> On Mon, Nov 10, 2025 at 07:08:05PM +0530, Nirjhar Roy (IBM) wrote:
>> Minor: Let us say that an user opens a file in O_DIRECT in an atomic
>> write enabled device(requiring stable writes), we get this warning
>> once. Now the same/different user/application opens another file
>> with O_DIRECT in the same atomic write enabled device and expects
>> atomic write to be enabled - but it will not be enabled (since the
>> kernel has falled back to the uncached buffered write path)
>> without any warning message. Won't that be a bit confusing for the
>> user (of course unless the user is totally aware of the kernel's exact
>> behavior)?
> The kernel with this patch should reject IOCB_ATOMIC writes because
> the FMODE_CAN_ATOMIC_WRITE is not set when we need to fallback.
Okay, makes sense.
>
> But anyway, based on the feedback in this thread I plan to revisit the
> approach so that the I/O issuer can declare I/O stable (initially just
> for buffered I/O, but things like nvmet and nfsd might be able to
> guarantee that for direct I/O as well), and then bounce buffer in lower
> layers.  This should then also support parallel writes, async I/O and
> atomic writes.

Okay.

--NR

>
-- 
Nirjhar Roy
Linux Kernel Developer
IBM, Bangalore


