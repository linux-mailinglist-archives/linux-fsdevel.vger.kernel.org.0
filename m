Return-Path: <linux-fsdevel+bounces-41149-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25D5EA2B969
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 04:05:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C87A93A2CB2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 03:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3ECB1547C8;
	Fri,  7 Feb 2025 03:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GKjUw1E9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20052AF1E;
	Fri,  7 Feb 2025 03:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738897512; cv=none; b=GSvkg4m7gVa7TjXY130R8pFaLj0iZBIjHKuZsU6lZ09TRFjbKc7ciUJ4jpEVa61BxsoeTcZRY8O70VzBksg60uI163Sw7PJOXBcOkQR9lTdqgoTNNpyjbASv5uVbuFNwMJAvEkqgNQhwsQHcnE8dbUAgBUL1tjmv2Xcf7PDPgbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738897512; c=relaxed/simple;
	bh=AM9VDgNJkOEJ/gBbgnmK3npw0SmrzFX7jP4QZOkq6p8=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=OK7T6aOSN0Q2EQ6WB5eRMlxvN/Ha4fgNR/FRPSWms/BPcew+rdp3WYj2r798jXGlnkhb67OMBT/XHix+NeBx0DToVMU1KC3H36NCZvqrBNRDSynjiYLo8mnQGotu9BEQUYEnKhNELaMazr6B4mtHF8cC0xWJ5kWh44cPV98Y2E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GKjUw1E9; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-21c2f1b610dso39551125ad.0;
        Thu, 06 Feb 2025 19:05:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738897510; x=1739502310; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4o4TSS9FsO3vXUbBh9d56FG0CFO0Dizjn5EtzUGaSE0=;
        b=GKjUw1E9Uv3FB/JKEoP1xlaxcpuy+v41UxcxIiS7rbj0MZ5fO6jTlkvqYAQ4Lewx3A
         7dhmuf5WSGSvfRWz77JbLyfn9G+kojQ+XH/v85ecs26046/TSnxvRekjhjtPQTrNVtSD
         1eNVkgLdulrNDc9VUWEpAM43IavkI8lT2ghOusBsOQHwjR19kTN9pJDm65j2oWa0fIs2
         M2IiHjyMD8fY5kzjl3OSJ+Lik1b/Qi5hMlv5G4dUWw92uFys7Gdw+TWboDg1LcEcP4we
         atvTwnG6U0G74Z6dtZr9z3mee18ajWHE5sUGZQYz3t3CV6bd2PSuWXv2229riDkUeAZp
         ZggA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738897510; x=1739502310;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4o4TSS9FsO3vXUbBh9d56FG0CFO0Dizjn5EtzUGaSE0=;
        b=NTTLAU3GDcJF9Z/OTCYBsmYwR3vqSb5Kke/+mBdjIUu2cxaWyERkHQgFKVhGU7W+2D
         dLVHnHnBqQshU7tRLLuE9S/yfgwoQKAI6e1FnOK6doiM1jek9Hlm6L1U86mfnt3neKDj
         TqdiHrinc/NYJmXgXqI4gwf3BEt4+iwlbBxTAcRjonfs5DTFojCgGO34EzHQ9KZpsbMS
         kFBoAckTFxql1hwBhTXBUoQmw0XBLUVbqLlfC4PVWBJqMLZ4FreFIv7H08r7g5YjIkWr
         MHrFBuruTd3VGverAR+YkLeLOKuWcsRRCx5a3e2zH9GW4yKL/94dQaFqYKU78msXH/X+
         oXXQ==
X-Forwarded-Encrypted: i=1; AJvYcCVLG/ZGAXth11e0d79CF6W73zAvyoxZpLTXM6lLA9k+lnycBVtor3uHLVOXnmX+22IRiwVyeNQhnxmgi6xb@vger.kernel.org, AJvYcCW/WvUF1AQTWEkW1iP6s/pwHBi2LXAd1VCCP1CambS5WOHoN4LkRHiYUuF58mv/KbjA5lMJTvuoy35fRDbs@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1TVV/gXtjmH7GIGHTDmbac4px4vNx9aht+b/pkpzUuqQkRuJf
	vo67qXXqOlO7Fm7qkfhvbe7f6YiKvlmvIddaCUh5MX/cbXl/Rleo
X-Gm-Gg: ASbGnctewfuuFwY3Gz+wQR0rS2OIvseP7gFwRIuHx00fyTgjIX8y7eySelEbouVr/HA
	jtI9S7RawIASjV6dMxRPNkYPIb19XaqtQXheJo/d/XgU8//Dks8psyfaXPGeNTU+jdjzF0otv6y
	yYxOV3IBrwos6IKxw0hnv1iLbAAGmqQlWaQdE+8APaqxgyQ9aP3rbbroiZ6T8QNp6VYEgznwVvY
	bFnNxQB7Elpuu6lecxllN7yF0STKAo/MVvv+q3yj+WlW4yzFxDQA9sG7hQrimwRFv2Z1QgPCg36
	+Lwj9ofTlDJnDctlFlHQ1kuY0bwdptdAklAtWknUX4fjvTx/gYkCyy2liF1C/g==
X-Google-Smtp-Source: AGHT+IHU1oP15UNA5b2tlLhSpLU0N0t0y190lFWi2XLtEm75ybNppw1Nu9VXhNbPeToD/613i6kadw==
X-Received: by 2002:a05:6a00:929c:b0:729:597:4fa9 with SMTP id d2e1a72fcca58-7305d53a88fmr2934639b3a.22.1738897509828;
        Thu, 06 Feb 2025 19:05:09 -0800 (PST)
Received: from [10.0.2.15] (KD106167137155.ppp-bb.dion.ne.jp. [106.167.137.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73048c16370sm1986354b3a.152.2025.02.06.19.05.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Feb 2025 19:05:09 -0800 (PST)
Message-ID: <6491ceb6-e48b-442b-ac61-7b2b65252d7a@gmail.com>
Date: Fri, 7 Feb 2025 12:05:05 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: kent.overstreet@linux.dev
Cc: linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
 Akira Yokosawa <akiyks@gmail.com>
References: <z2eszznjel6knkkvckjxvkp5feo5jhnwvls3rtk7mbt47znvcr@kvo6dhimlghe>
Subject: Re: [GIT PULL] bcachefs fixes for 6.14-rc2
Content-Language: en-US
From: Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <z2eszznjel6knkkvckjxvkp5feo5jhnwvls3rtk7mbt47znvcr@kvo6dhimlghe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello Kent,

Kent Overstreet wrote:
> Nothing major, things continue to be fairly quiet over here.
> 
> Tracking some bugs that show up on nix build servers; would like someone
> to confirm or deny that these are or are not still happening on 6.14,
> and if you've got an environment where this is reproducing and can work
> with me to debug that would save me some trouble...
> 
> Also, another bug report is implicating hibernate, please let me know if
> you have any data on that, still trying to piece together what's going
> on there.
> 
> And as usual, be noisy if you're seeing a serious bug that's not getting
> resolved.
> 

I'm not Linus, and not a serious bug, but let me be noisy.

See below.

> The following changes since commit 2014c95afecee3e76ca4a56956a936e23283f05b:
> 
>   Linux 6.14-rc1 (2025-02-02 15:39:26 -0800)
> 
> are available in the Git repository at:
> 
>   git://evilpiepirate.org/bcachefs.git tags/bcachefs-2025-02-06
> 
> for you to fetch changes up to 44a7bfed6f352b4bae4fd244d0fcd32aa25d0deb:
> 
>   bcachefs: bch2_bkey_sectors_need_rebalance() now only depends on bch_extent_rebalance (2025-02-05 19:56:24 -0500)
> 
> ----------------------------------------------------------------
> bcachefs fixes for 6.14-rc2
> 
> - add a SubmittingPatches to clarify that patches submitted for bcachefs
>   do, in fact, need to be tested
> - discard path now correctly issues journal flushes when needed, this
>   fixes performance issues when the filesystem is nearly full and we're
>   bottlenecked on copygc
> - fix a bug that could cause the pending rebalance work accounting to be
>   off when devices are being onlined/offlined; users should report if
>   they are still seeing this
> - and a few more trivial ones
> 
> ----------------------------------------------------------------
> Jeongjun Park (2):
>       bcachefs: fix incorrect pointer check in __bch2_subvolume_delete()
>       bcachefs: fix deadlock in journal_entry_open()
> 
> Kent Overstreet (4):
>       bcachefs docs: SubmittingPatches.rst

This caused a new warning in "make htmldocs", which was reported at:

    https://lore.kernel.org/20250204141216.4a2635ee@canb.auug.org.au/

, and has not been taken care of.

I'd like you not to ignore such a friendly report!

Regards, Akira

>       bcachefs: Fix discard path journal flushing
>       bcachefs: Fix rcu imbalance in bch2_fs_btree_key_cache_exit()
>       bcachefs: bch2_bkey_sectors_need_rebalance() now only depends on bch_extent_rebalance
> 
>  .../filesystems/bcachefs/SubmittingPatches.rst     | 98 ++++++++++++++++++++++
>  MAINTAINERS                                        |  1 +
>  fs/bcachefs/alloc_background.c                     | 47 ++++++-----
>  fs/bcachefs/alloc_foreground.c                     | 10 ++-
>  fs/bcachefs/alloc_types.h                          |  1 +
>  fs/bcachefs/btree_key_cache.c                      |  1 -
>  fs/bcachefs/buckets_waiting_for_journal.c          | 12 ++-
>  fs/bcachefs/buckets_waiting_for_journal.h          |  4 +-
>  fs/bcachefs/inode.h                                |  4 +-
>  fs/bcachefs/journal.c                              | 18 +++-
>  fs/bcachefs/journal.h                              |  1 +
>  fs/bcachefs/journal_types.h                        |  1 +
>  fs/bcachefs/opts.h                                 | 14 ----
>  fs/bcachefs/rebalance.c                            |  8 +-
>  fs/bcachefs/rebalance.h                            | 20 +++++
>  fs/bcachefs/subvolume.c                            |  7 +-
>  fs/bcachefs/super.c                                | 11 +++
>  fs/bcachefs/super.h                                |  1 +
>  fs/bcachefs/trace.h                                | 14 +++-
>  19 files changed, 214 insertions(+), 59 deletions(-)
>  create mode 100644 Documentation/filesystems/bcachefs/SubmittingPatches.rst



