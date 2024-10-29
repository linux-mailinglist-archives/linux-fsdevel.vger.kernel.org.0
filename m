Return-Path: <linux-fsdevel+bounces-33097-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D3A219B4093
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Oct 2024 03:42:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D3F6B21B7A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Oct 2024 02:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CE0C1EE02E;
	Tue, 29 Oct 2024 02:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Z2edLyAb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 215401DF26E
	for <linux-fsdevel@vger.kernel.org>; Tue, 29 Oct 2024 02:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730169744; cv=none; b=tx3wxASNJhBFu+XiO6ystVEpbat0cZuT3tyr1WJVFOXZLhOKm/re4DkONpWK2Er2w9kyFXZewDaqVa+OED066yiYoSBqbtB0XBnzUstu8Vh1SFHGRG1LXHnusdgqzpVYFJvIFLB6uTceFICFYTVeSYYZ1kPJP1k9o3u6BoQdW+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730169744; c=relaxed/simple;
	bh=PAjJ9Ou71Uqgdpy0Kz/QpxRFDbhbU7vB9xt2porGJQg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jj6xdm6zpVKz1nw1UV4vAX2iDXJ3JCazPgXwGV+4zwuPagNIjECfODIeWJAqT4hi8LDKW0VhLBRuBf9ASeCp+8syHVjf2nBvZZIoc3sxsEjkZQc5emJ8xi5pT1vrboAltbVq/qXEJ/nOclr308qjdTnL1kAYsvuTI4fIS/g66NU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Z2edLyAb; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7ee11ff7210so481120a12.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Oct 2024 19:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1730169741; x=1730774541; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NhwueTBuyyDS6MSGHD4L/PRA/gmfkEl47Swjzb9s/GI=;
        b=Z2edLyAbHhGFMd1vFhIcGOfI/bI+/x5zqS9VoPUi2+jG3tmA6NwW1FyDAsCpxGdkba
         rRQmkxScsqGx3E8JfBinZPLPG28Y4KPHMkb5a8wF33ZjkkjNdwb1uB1gvEcoXNEntIt2
         98U2lIyWS5219bOs+yPL5bsxC2bhNQyx4sns4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730169741; x=1730774541;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NhwueTBuyyDS6MSGHD4L/PRA/gmfkEl47Swjzb9s/GI=;
        b=Pl4wmRPjoZQLd7mdYS0XREm5gN0dgCOoIB8Zd1bnvQ8o+RmrbS6i19JF39wTrHEb3P
         ggnFx1aeERZ2URlDB1wR1DgTBWEAxH/YEKuZxKhlX8rijOPdkFZjEixi4fCkcmHlITt7
         WeIo81NMn2dJQd0+mEwjSP9FKuQ1i9WWtsLymgjmpwQHrOrqm5imWCAa5mndTmeXXiYE
         ayoO0CKnu/tdSkTdxkn24CavIJ6FHpVgLQsD5Fj7RxjW6jUluAbHwjq1euWsb6QjuxZY
         U5CPgYwSd5XYL1hQCM3gMh+Otyf+U3YvHuRsg46u4jXLU8rSbU/heEMwLBlk/nspVtay
         V+kQ==
X-Forwarded-Encrypted: i=1; AJvYcCVBnYlBHZS5t1XovxFE2oKjq3DSUD6V/T/qmeovXd3bMl4ExTzIHmeRUlbeSvKhIU1Zc6+0GcKHuZKg55I8@vger.kernel.org
X-Gm-Message-State: AOJu0YxMiD5uWpLDjAJ59q6kKszPfvj6HvS7UyoaqW8wJsXOz1MQCaQC
	APaQl0urCEGibq/b/S5q7KuPH7WAv0sICLDypFqojewj+6XCJivn+ucu51oFWwQ=
X-Google-Smtp-Source: AGHT+IEEBAFSTLUWRggpy/zSgYYAMfS9zMnB4WTf3rwU/wiDXRiRmmXCC9HC+DDgqHm/wOcSVYkVbg==
X-Received: by 2002:a05:6a20:d8b:b0:1d9:1071:9175 with SMTP id adf61e73a8af0-1d9a84d70dfmr13069474637.32.1730169741393;
        Mon, 28 Oct 2024 19:42:21 -0700 (PDT)
Received: from [10.200.3.216] (p99249-ipoefx.ipoe.ocn.ne.jp. [153.246.134.248])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7205780e3f5sm6504801b3a.0.2024.10.28.19.42.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Oct 2024 19:42:21 -0700 (PDT)
Message-ID: <c620491d-7bb9-47f5-bd2f-52d8fc814486@linuxfoundation.org>
Date: Mon, 28 Oct 2024 20:42:18 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] selftests/mount_setattr: fix idmap_mount_tree_invalid
 failed to run
To: Christian Brauner <brauner@kernel.org>,
 zhouyuhang <zhouyuhang1010@163.com>
Cc: sforshee@kernel.org, shuah@kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 zhouyuhang <zhouyuhang@kylinos.cn>, Shuah Khan <skhan@linuxfoundation.org>
References: <20241028084132.3212598-1-zhouyuhang1010@163.com>
 <20241028-rodung-kotzen-577438c3b82c@brauner>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241028-rodung-kotzen-577438c3b82c@brauner>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/28/24 06:11, Christian Brauner wrote:
> On Mon, Oct 28, 2024 at 04:41:32PM +0800, zhouyuhang wrote:
>> From: zhouyuhang <zhouyuhang@kylinos.cn>
>>
>> Test case idmap_mount_tree_invalid failed to run on the newer kernel
>> with the following output:
>>
>>   #  RUN           mount_setattr_idmapped.idmap_mount_tree_invalid ...
>>   # mount_setattr_test.c:1428:idmap_mount_tree_invalid:Expected sys_mount_setattr(open_tree_fd, "", AT_EMPTY_PATH, &attr,  sizeof(attr)) (0) ! = 0 (0)
>>   # idmap_mount_tree_invalid: Test terminated by assertion
>>
>> This is because tmpfs is mounted at "/mnt/A", and tmpfs already
>> contains the flag FS_ALLOW_IDMAP after the commit 7a80e5b8c6fa ("shmem:
>> support idmapped mounts for tmpfs"). So calling sys_mount_setattr here
>> returns 0 instead of -EINVAL as expected.
>>
>> Ramfs does not support idmap mounts, so we can use it here to test invalid mounts,
>> which allows the test case to pass with the following output:
>>
>>   # Starting 1 tests from 1 test cases.
>>   #  RUN           mount_setattr_idmapped.idmap_mount_tree_invalid ...
>>   #            OK  mount_setattr_idmapped.idmap_mount_tree_invalid
>>   ok 1 mount_setattr_idmapped.idmap_mount_tree_invalid
>>   # PASSED: 1 / 1 tests passed.
>>
>> Signed-off-by: zhouyuhang <zhouyuhang@kylinos.cn>
>> ---
> 
> Reviewed-by: Christian Brauner <brauner@kernel.org>

Thank you. Applied to kselftest fixes branch for next rc.

thanks,
-- Shuah

