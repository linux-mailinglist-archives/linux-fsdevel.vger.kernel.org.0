Return-Path: <linux-fsdevel+bounces-32783-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3CCD9AE8CC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2024 16:30:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 313051C21AEB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2024 14:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADDE71E571A;
	Thu, 24 Oct 2024 14:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZCl7BX4x"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D31451EABB9
	for <linux-fsdevel@vger.kernel.org>; Thu, 24 Oct 2024 14:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729780024; cv=none; b=nV6Fq0M+skL4vmyEaFucClDTg0rUyq/uzn7DUBrRMCHxjHEzhdlCqENY8YCjZ5P2+eaU/LJMyLBs9MdvlNjvPKbKHqBCRQLJom+tZDOWfe2OzK/LNJ4F6Ac7DG952KlVi+TNtvU5IzCmPRIA0h6Dw62zpJ2mN7hcvNTb4zrrbUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729780024; c=relaxed/simple;
	bh=Br4rUo7jXSyDoQxwb4vji74KoTCk3I/0TKPiOd4IYHI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q1Zdm8TLZxipjug2hVfr5lhLvbN2Z7ePNl0uQ6sn/HU/B2A3yRTf2JhHmIB5jrdYX47VVO+bgGnmWgJshs70XmQTGntZQSJduAjb/sTUjAb3bAixy94qxCkdJX2MMXA1YMbK+UvqADB87FCkkxsewt/3+N5xYw7z7QANn5kM4+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZCl7BX4x; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-83ab5b4b048so42650639f.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Oct 2024 07:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1729780021; x=1730384821; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=apwKRmC6AYWNzrkiex3WwhJW5GIZvlbImA6QoEBbivc=;
        b=ZCl7BX4xkrIFvVvZGHtyM/oy3pt/aKmBnCo6ikFH1ajyb9egT9T5XTsiV0hAaOO9k/
         ps2A45qQcP8lCS/knovTMouiU4uGQWesQhIVdGo5v3UbWntib8/VTW3mro96iMJEsVyv
         WmTXi3cvo38TqgLX8YQ7TDpG4gusvH7pOSb8s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729780021; x=1730384821;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=apwKRmC6AYWNzrkiex3WwhJW5GIZvlbImA6QoEBbivc=;
        b=bawxvhQvH9qQIG9mjiUXTTSAJMiZU07A2CnRgCWmQmlEsF4yTrupTLkHV9hVQ4D8Po
         +SPvlJiuBS4oE+E+yB4AXiUqc8TEfyjsN7ZXRd++t9lsVDQYpgxF9vWpjDhyRFIY1enL
         dOgPYTEezqJ/oQTaiOu0fmK6xhWmQ6xSoIWYPMZlRqf5QeSZ1w6fIzXsuVHCVXqN7eq6
         MSHCaQ0LPrS/SqgFfiAmctdaI4n3ftCJfLRMYC3aT+66X/RtwW+bzRrouaHAUWpiJ9Ga
         cBLw1xFqmbvPseT3qV39d+quKEzCqr+akXidzX1XDVnCTXaXjBwBSBCn9NHKr8Kn9PJC
         g8rw==
X-Gm-Message-State: AOJu0YwrpdzInKwyodQ8UOo3Kx2Pd/4ov3Hlu0DgIPgyDOf6JzgClbCs
	HHrSy/i0SXVdZ6sU2I/d67CY6L1eVlLDcqjzkUe/23qtkT9jJxNDi4A2tQYra6E=
X-Google-Smtp-Source: AGHT+IEjoNotzF3cjr6+gorjptn9Dul3pcmua2S6p0cxQk5f5nfOd26Q5xIzWEQ2ssLjTpxV/ceAyg==
X-Received: by 2002:a05:6602:140a:b0:83a:c5dd:3000 with SMTP id ca18e2360f4ac-83b04041acfmr315071039f.6.1729780020797;
        Thu, 24 Oct 2024 07:27:00 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4dc2a630571sm2729448173.147.2024.10.24.07.26.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Oct 2024 07:27:00 -0700 (PDT)
Message-ID: <1c8674a0-d220-4349-88ea-780f0fed8545@linuxfoundation.org>
Date: Thu, 24 Oct 2024 08:26:59 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/mount_setattr: fix idmap_mount_tree_invalid
 failed to run
To: zhouyuhang <zhouyuhang1010@163.com>, brauner@kernel.org,
 sforshee@kernel.org, shuah@kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, zhouyuhang <zhouyuhang@kylinos.cn>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241024095013.1213852-1-zhouyuhang1010@163.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241024095013.1213852-1-zhouyuhang1010@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/24/24 03:50, zhouyuhang wrote:
> From: zhouyuhang <zhouyuhang@kylinos.cn>
> 
> Test case idmap_mount_tree_invalid failed to run on the newer kernel
> with the following output:
> 
>   #  RUN           mount_setattr_idmapped.idmap_mount_tree_invalid ...
>   # mount_setattr_test.c:1428:idmap_mount_tree_invalid:Expected sys_mount_setattr(open_tree_fd, "", AT_EMPTY_PATH, &attr,  sizeof(attr)) (0) ! = 0 (0)
>   # idmap_mount_tree_invalid: Test terminated by assertion
> 
> This is because tmpfs is mounted at "/mnt/A", and tmpfs already
> contains the flag FS_ALLOW_IDMAP after the commit 7a80e5b8c6fa ("shmem:
> support idmapped mounts for tmpfs"). So calling sys_mount_setattr here
> returns 0 instead of -EINVAL as expected.
> 
> Ramfs is mounted at "/mnt/B" and does not support idmap mounts.
> So we can use "/mnt/B" instead of "/mnt/A" to make the test run
> successfully with the following output:
> 
>   # Starting 1 tests from 1 test cases.
>   #  RUN           mount_setattr_idmapped.idmap_mount_tree_invalid ...
>   #            OK  mount_setattr_idmapped.idmap_mount_tree_invalid
>   ok 1 mount_setattr_idmapped.idmap_mount_tree_invalid
>   # PASSED: 1 / 1 tests passed.
> 

Sounds like this code is testing this very condition passing
in invalid mount to see what happens. If that is the intent
this patch is incorrect.

> Signed-off-by: zhouyuhang <zhouyuhang@kylinos.cn>
> ---
>   tools/testing/selftests/mount_setattr/mount_setattr_test.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/mount_setattr/mount_setattr_test.c b/tools/testing/selftests/mount_setattr/mount_setattr_test.c
> index c6a8c732b802..54552c19bc24 100644
> --- a/tools/testing/selftests/mount_setattr/mount_setattr_test.c
> +++ b/tools/testing/selftests/mount_setattr/mount_setattr_test.c
> @@ -1414,7 +1414,7 @@ TEST_F(mount_setattr_idmapped, idmap_mount_tree_invalid)
>   	ASSERT_EQ(expected_uid_gid(-EBADF, "/tmp/B/b", 0, 0, 0), 0);
>   	ASSERT_EQ(expected_uid_gid(-EBADF, "/tmp/B/BB/b", 0, 0, 0), 0);
>   
> -	open_tree_fd = sys_open_tree(-EBADF, "/mnt/A",
> +	open_tree_fd = sys_open_tree(-EBADF, "/mnt/B",
>   				     AT_RECURSIVE |
>   				     AT_EMPTY_PATH |
>   				     AT_NO_AUTOMOUNT |

thanks,
-- Shuah

