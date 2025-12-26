Return-Path: <linux-fsdevel+bounces-72118-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CF70CDEF60
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Dec 2025 21:02:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7393530124E3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Dec 2025 20:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0FC72459DD;
	Fri, 26 Dec 2025 20:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BiTt/cEF";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Uh4GqLT7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72573238171
	for <linux-fsdevel@vger.kernel.org>; Fri, 26 Dec 2025 20:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766779320; cv=none; b=CthRfCUaQZT6Absc3x5XgSHy8fIgk5ptdP4qrZa3CIoUZAIZxDGATPZk5ozxsXwe1p/dooeg0fphVfIflFhd1TbXFoXSOp0bYaUvayV1fhCrLgc9/odBQzQuuTm9zMwvHUpJQFF5dkq031Hhx3govcx7QayRHCnMe3ExXDOTrnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766779320; c=relaxed/simple;
	bh=QQyG4KMrALCAk4qB42lsLkH4v13igT5T+7TUGqsvJ7M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KOkXfzsW/TObOShAttK7mMBUiG7kd7SMIA4xKB8AzsjcTM6ty9tlWuSo1qGGD0ZrfPWgLGbfwhrL6ibWUZViheVFJ3XV4GOZR5txjXAQPeP+WifgEh1wClcyfjabK1PPkyZft4pYEAjE+7izM0oWZwWxffdTurDVcLgbJYsFy3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BiTt/cEF; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Uh4GqLT7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766779317;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ojpffjf9WXO3wNJhOKSQJLHQbbSlgOUFtmMuKKKVw8E=;
	b=BiTt/cEFmTpjSTVEQ86LjebwdkxEt3isCmp4KbOizPc6iIagw6akKUaTYt5rh73ud7F5kt
	C1ykLBWzujhyary3s0mwUMNSChCDzXwLHr8SkE2dlMsn9ZyuU42Q5RDlM5EoU3MDVp14Hz
	X9VbeXKTpowhDREOh9AjO8aNoVH7uiQ=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-94R90D6aMJKNSoqpNJBgmA-1; Fri, 26 Dec 2025 15:01:53 -0500
X-MC-Unique: 94R90D6aMJKNSoqpNJBgmA-1
X-Mimecast-MFC-AGG-ID: 94R90D6aMJKNSoqpNJBgmA_1766779313
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4edb6a94873so144942191cf.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 26 Dec 2025 12:01:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766779313; x=1767384113; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ojpffjf9WXO3wNJhOKSQJLHQbbSlgOUFtmMuKKKVw8E=;
        b=Uh4GqLT7vNyTUbnzYFCwXxqrzrQSyCTuF6eFECe0JeQs5SxqWeOA3uOO9d7lK1ErVl
         F6BoWHsclq/XDvRC+GZmWFGNa2HtoqowfhJaV6Q6Az8AXWjx5FQR9bXMvSDu9nm6GfSw
         ry20l5XAcXL7IRUUNBBlyZQRYwxhlIzF9usHXYLCay+oQuqlHUreg0Tm3e/9lY10EUXJ
         p995z8U/67t9dJWjKaYhtfKv4V+ZHha8HiRsj/ruTUfsPEgaerKklONvHLSnFaK3vgGQ
         nGSFOzMjYMuqZvus/enbGxjcYYBujgsLG8rvMLPGz70eDS/9kgDkJ99FKpbX8TPoBoj3
         4TTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766779313; x=1767384113;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ojpffjf9WXO3wNJhOKSQJLHQbbSlgOUFtmMuKKKVw8E=;
        b=kqkAwKbDN9utTuQWePrsus1KZ0sapgeEId/FOk5LZ6/KFsrYEF9bnR9urDKBOuS9sC
         IlmKw0jInCzxkGyW0Vm12KarLOQx/EKGhUdXnq1jHL43CVitf9aoqmDhD3wBsqicg4PA
         X+xLedao4BJ0/JTZ6nNCpmWZITaQicMpxvVo3zVBB9sLxGg/Ul473nZEuGo0PJQpjbfd
         IfFA16yeRp6XDNSCL86DwfHWteFucqJEcE/d2UiK96BqPO1k2wU7uF+uC9L1zQO7zU7k
         LmVOBx/Ib7VXDV7EiWq/m8c5/0EzxQWOkRBYMrPs69+8LlYGeH1lbs5mYjMMBQNTcnEG
         9esg==
X-Forwarded-Encrypted: i=1; AJvYcCVahEMcNbxA0mgxARYl+Ru+r6Y5Ch/YVMm2om6vu+3bmwx137zzfT5eg8wCvWfXzso2nXU0eJyWOxQW6xI5@vger.kernel.org
X-Gm-Message-State: AOJu0YzaH9FC/VRjGwWf0mZ1ZR8LgEbbZbNuvcivqTXIUhnj59/dR/YZ
	ME5vyhcFYUOtZoTfjVfd/R4rLL1xJWddgFmxNfYlRw+sN9oC1jjZh0tFJ5I5RjtXTHFfiueBTV5
	ssEVTyC2QOlM2LZiJ6+g7Y2eIus8i/6qrMK995abohzZ57j3Gr0hGYzIE0bUIbZe9drA=
X-Gm-Gg: AY/fxX5QtxnMBQWxRDvaR+EKixVVL/YzfzBHra1qxqrYgYRgjfLISpbMwHF3HEJlUbc
	ni/m5reuUYT9IikQsc2sVay4LA0rJiEfRhskop6kRi/xTe4C/Xm0t7pxnxzu3l1pn+cCJDdC+Lu
	/Nr1BlJWZ7b/rQy/F7dUyvpON92re8y4afv43OTC+4afVMds/jtIxuZBn8fxpPkcxTYLBalvjK7
	TNUk8HA2KuEr2TpRkfeMgunXXasPwgAgVuAhoH70R0s8Mr4Ze9WyJttVf5O3tYQoQFoHkELVVM+
	JUXTvuSEYy/BevWNACPVF+DhRWzTfEhNguI/Ox6Kkpckx98IHwRlcLTQRdUtbVZw2kaFrfXXzYS
	/LovQOEBHzBYcHTXGQMOwVKrsJGHI+bWnL5dvpxShARG122i8A7s=
X-Received: by 2002:a05:622a:3cc:b0:4e8:baad:9875 with SMTP id d75a77b69052e-4f4abccf532mr368603451cf.4.1766779313167;
        Fri, 26 Dec 2025 12:01:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFZnYKkCFK7rhcnq+xYC/+SDh2RlrIBRh7zni7hxgTjidevNQ22xkFYWKyG03JlVIxpiZ0mxg==
X-Received: by 2002:a05:622a:3cc:b0:4e8:baad:9875 with SMTP id d75a77b69052e-4f4abccf532mr368602871cf.4.1766779312766;
        Fri, 26 Dec 2025 12:01:52 -0800 (PST)
Received: from [10.0.0.82] (97-127-77-149.mpls.qwest.net. [97.127.77.149])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4f4ac62f59csm161375721cf.20.2025.12.26.12.01.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Dec 2025 12:01:52 -0800 (PST)
Message-ID: <fb920248-a0fc-432f-926f-c27b1760de58@redhat.com>
Date: Fri, 26 Dec 2025 14:01:50 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [linux-next:master] [fs] 51a146e059:
 BUG:kernel_hang_in_boot_stage
To: kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com,
 Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <202512230315.1717476b-lkp@intel.com>
Content-Language: en-US
From: Eric Sandeen <sandeen@redhat.com>
In-Reply-To: <202512230315.1717476b-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/22/25 8:36 PM, kernel test robot wrote:
> 
> 
> Hello,
> 
> 
> we don't have enough knowledge to analyze the connection between the issue and
> this change. just observed the issue is quite persistent on 51a146e059 and
> clean on its parent.

Odd. Not much to go on, and I don't see any obvious connection either, but
I'll see if i can reproduce.

In the successful dmesg it looks like devtmpfs was next up, maybe that's a clue.

This is probably a classic case of assuming that removing dead code
"can't break anything!" without enough testing. :( I'll see what I can find.

Thanks for the report,
-Eric

> 
> =========================================================================================
> tbox_group/testcase/rootfs/kconfig/compiler/sleep:
>   vm-snb-i386/boot/debian-11.1-i386-20220923.cgz/i386-randconfig-2006-20250804/gcc-14/1
> 
> d5bc4e31f2a3f301 51a146e0595c638c58097a1660f
> ---------------- ---------------------------
>        fail:runs  %reproduction    fail:runs
>            |             |             |
>            :200        100%         200:200   last_state.booting
>            :200        100%         200:200   last_state.is_incomplete_run
>            :200        100%         200:200   dmesg.BUG:kernel_hang_in_boot_stage
> 
> 
> we cannot spot out useful information from dmesg which is uploaded to [1]. also
> attached one dmesg from parent commit (d5bc4e31f2) FYI.
> 
> 
> kernel test robot noticed "BUG:kernel_hang_in_boot_stage" on:
> 
> commit: 51a146e0595c638c58097a1660ff6b6e7d3b72f3 ("fs: Remove internal old mount API code")
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> 
> [test failed on linux-next/master cc3aa43b44bdb43dfbac0fcb51c56594a11338a8]
> 
> in testcase: boot
> 
> config: i386-randconfig-2006-20250804
> compiler: gcc-14
> test machine: qemu-system-i386 -enable-kvm -cpu SandyBridge -smp 2 -m 4G
> 
> (please refer to attached dmesg/kmsg for entire log/backtrace)
> 
> 
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202512230315.1717476b-lkp@intel.com
> 
> 
> [   15.178608][    T1] signal: max sigframe size: 1760
> [   15.669386][    T1] rcu: Hierarchical SRCU implementation.
> [   15.785114][    T1] rcu: 	Max phase no-delay instances is 1000.
> [  104.130757][    C0] workqueue: round-robin CPU selection forced, expect performance impact
> [  110.182304][    C0] random: crng init done
> BUG: kernel hang in boot stage
> 
> 
> 
> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20251223/202512230315.1717476b-lkp@intel.com [1]
> 
> 
> 


