Return-Path: <linux-fsdevel+bounces-36041-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 28A7E9DB20A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Nov 2024 05:04:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51B7DB21A24
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Nov 2024 04:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E101136357;
	Thu, 28 Nov 2024 04:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RYK24fuT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875DD134BD;
	Thu, 28 Nov 2024 04:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732766680; cv=none; b=DKCmlgI2a87mWohFvNynICn0r9bfQoJRMywRo/3hB20p3JNo3Hw5QSOU4+iD0+wa2DFw/KEO3ge9IrnQqIZYh2ESiDd8yYJsgMfuZWgeAZ7z8XgTYuXlh81XTMRuacmCQkjfq/CQ8eniYSTlidaiG+mN0+FiLJxM/F10SENwFDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732766680; c=relaxed/simple;
	bh=a/wQokmDWnAXvA0ciOFVwoUQHroroKOswWbDyoczoo8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=Vat/qUO3sXLg3VI/8u2EAGp8XSGt7SHCROt2Hn6r/cALRL3UyeC9Q1mnxXfLbevVVPdLtX07rN7+hGkuRFmztcLedyFPi/+EmpKTFYh6jIJcs/r5Yss7LoFYq0W4+FA0JWOTia2KXhF5k0AjrQN+kbgvgZasX7Cfj99qSnsaMOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RYK24fuT; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-212583bd467so3397775ad.3;
        Wed, 27 Nov 2024 20:04:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732766677; x=1733371477; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mdo8hi9A09XvCUMFQQtNlaibVX3RLcTHnaQ9Hl5QeFo=;
        b=RYK24fuTqyPwY3rwn+S9RNpvwu1lbxWbYXYx/zzp84FsAKQrHmRE+ZBroN3+t1zNwy
         DGhe7hzYoWeW46LinE7nPKAZh/bK62Xo+UH1bq1blmdgwEZGVYNTp1cvR39gw4n0wzl6
         CAy5GsYJt/5R5rZsoh467AWeQQT1ier/djCDnTDghuGzSeSk1IPXQGor8kAeeq5LmkAG
         QHXFNUDmffk8jrQ3wn2ejW3YCHMuxrUdo+YSdwUP+pZXJBSgxbiit0/tJcVtEHfkRwvQ
         wrlKzRDnLXgkK35x2lVu1+RV4Ws2ytIqFk0ZzQO1uraY6WRGgMkQvWofvUfg9bGs/Wmg
         dTvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732766677; x=1733371477;
        h=content-transfer-encoding:cc:to:subject:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Mdo8hi9A09XvCUMFQQtNlaibVX3RLcTHnaQ9Hl5QeFo=;
        b=F95ilOB7NaDnFoNqPXRqdK00op/EziJSRvTD5cTsy7jAZJbQaSkOG+bQBYvcGa5zrj
         kfvBM9dna849lngAqhdd64MwkCIaFVgSqxvkG0vL6Er20+ErzTINb2l8FnY/ZgA/nRHM
         n2/ZvIEet/yCB+7YJmueTyHqIY9kpeSlEbrnvuUn3MySdvfmt9y+1yFUTQFZhPG3tLyo
         MYXyop0TP0H8qsUMvGZCpGbkKJcQwAbmXdqD36/0fkOeDVIiGhUILDi2b4vi02rORFM6
         +kKYjJ15CQMnWy+ipAKjQEJ2YOu+u6WEHbsZZIZdzdLQdZ8aXtC5cAKIU9BQ0bZ3iPzA
         oGRg==
X-Forwarded-Encrypted: i=1; AJvYcCUPPKX4riqAfNANW9AG4I04FNPcong32Vhi0VQstv7ebsvtesuRle3l0tbF0aWdMV4mq5fmk31RP21xJ3w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOnV0fRxyfkD0o4TPlJkTI0733PUYFi0yoPK6xmLQ3RaUxamcR
	jLAV6nYgRXdWsrBsYlKPjQ5VeMR2A/7q0hs/dawdH1sKQVqXYWKMvJO9kAxNpNw=
X-Gm-Gg: ASbGncschrd73O5ecRTuRl8PC0Is9fvPLnMtHBYeZo4qBOacnP7Et8TYkS50te+R6wT
	kXhnY32Ap+8x9eBtomAD6YkiJpN/enmd9XpqAZTvKyCX4zUbPAJkRsz0tyUuvidwORi8oqSNaY/
	9WSRPw/C+HUYZ5jIDaxxvRT9QvypoGgzGug2okyUShXZd8WGA2k/IFzeNUPAk6K4v7+5tpA8uqr
	IuVruL/ORFXzSzkOEGGc4/A5MSRVB7+94IxR/c0YXja+0pkY93Isjb2r4mK9kS601Xsc87aTK8y
	8g==
X-Google-Smtp-Source: AGHT+IFC214M7/WZA/GJ3HXTq60altY0eM9aZSbzRNiMN6sJViY4KSvVqWu1p2spaItHM9Qe2r4LOQ==
X-Received: by 2002:a17:903:40ca:b0:212:68c2:4e01 with SMTP id d9443c01a7336-215010909d3mr68884075ad.17.1732766676698;
        Wed, 27 Nov 2024 20:04:36 -0800 (PST)
Received: from [192.168.255.10] ([43.132.141.30])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215219672e7sm3583965ad.130.2024.11.27.20.04.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Nov 2024 20:04:36 -0800 (PST)
Message-ID: <be26c9d6-ff51-4399-b47d-8a0d4413ce0d@gmail.com>
Date: Thu, 28 Nov 2024 12:04:34 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: abushwang <abushwangs@gmail.com>
Subject: [performance] fuse: No Significant Performance Improvement with
 Passthrough Enabled?
To: miklos@szeredi.hu
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

I recently learned that FUSE has introduced passthrough support, which 
appears to significantly enhance performance, as discussed in this 
article: [LWN.net](https://lwn.net/Articles/832430/).

I plan to develop some upper-layer applications based on this feature. 
However, during my testing, I found that the performance of passthrough 
for reading small files seems to be worse than that without passthrough. 
Below are the details of my test cases:
https://github.com/wswsmao/fuse-performance/blob/main/file_access_test.c

I generated files of sizes 1M, 500M, and 1000M using the aforementioned 
use case for reading.
https://github.com/wswsmao/fuse-performance/blob/main/generate_large_files.sh

### Test Environment Information:

```
$ uname -r
6.11.5-200.fc40.x86_64
```

```
$mount
/dev/vda1 on / type ext4 (rw,noatime)
...

```

### Testing Steps:

I cloned the latest code from the libfuse upstream community and 
compiled it to obtain passthrough_hp.

The latest passthrough_hp supports passthrough by default. Therefore, 
when testing with passthrough, I used the following command:

```
ls -lh source_dir/
total 1.5G
-rw-r--r-- 1 root root  1.0M Nov 28 02:45 sequential_file_1
-rw-r--r-- 1 root root  500M Nov 28 02:45 sequential_file_2
-rw-r--r-- 1 root root 1000M Nov 28 02:45 sequential_file_3

./lattest_passthrough_hp source_dir/ mount_point/
```

For testing without passthrough, I used the following command:

```
./lattest_passthrough_hp source_dir/ mount_point/ --nopassthrough
```

Then, I executed the test script on mount_point.


During debugging, in a scenario with a 1M buffer set to 4K, I added 
print statements in the FUSE daemon's read function. In the without 
passthrough mode, I observed 11 print statements, with the maximum read 
size being 131072. Additionally, I captured 11 fuse_readahead operations 
using ftrace. However, in passthrough mode, even after increasing the 
ext4 read-ahead size using the command `blockdev --setra $num 
/dev/vda1`, the performance improvement was not significant.

I would like to understand why, in this case, the performance of 
passthrough seems to be inferior to that of without passthrough.

Thank you for your assistance.

Best regards,

Abushwang

Attached is my test report for your reference.

## without passthrough

### Size = 1.0M

| Mode       | Buffer Size | Time (ms) | Read Calls |
| ------------ | ------------- | ----------- | ------------ |
| sequential | 4096        | 7.99      | 256        |
| sequential | 131072      | 6.46      | 8          |
| sequential | 262144      | 7.52      | 4          |
| random     | 4096        | 51.40     | 256        |
| random     | 131072      | 10.62     | 8          |
| random     | 262144      | 8.69      | 4          |


### Size = 500M

| Mode       | Buffer Size | Time (ms) | Read Calls |
| ------------ | ------------- | ----------- | ------------ |
| sequential | 4096        | 3662.68   | 128000     |
| sequential | 131072      | 3399.55   | 4000       |
| sequential | 262144      | 3565.99   | 2000       |
| random     | 4096        | 28444.48  | 128000     |
| random     | 131072      | 5012.85   | 4000       |
| random     | 262144      | 3636.87   | 2000       |

### Size = 1000M

| Mode       | Buffer Size | Time (ms) | Read Calls |
| ------------ | ------------- | ----------- | ------------ |
| sequential | 4096        | 8164.34   | 256000     |
| sequential | 131072      | 7704.75   | 8000       |
| sequential | 262144      | 7970.08   | 4000       |
| random     | 4096        | 57275.82  | 256000     |
| random     | 131072      | 10311.90  | 8000       |
| random     | 262144      | 7839.20   | 4000       |


## with passthrough

### Size = 1.0M

| Mode       | Buffer Size | Time (ms) | Read Calls |
| ------------ | ------------- | ----------- | ------------ |
| sequential | 4096        | 8.50      | 256        |
| sequential | 131072      | 7.54      | 8          |
| sequential | 262144      | 8.71      | 4          |
| random     | 4096        | 52.16     | 256        |
| random     | 131072      | 9.10      | 8          |
| random     | 262144      | 9.54      | 4          |


### Size = 500M

| Mode       | Buffer Size | Time (ms) | Read Calls |
| ------------ | ------------- | ----------- | ------------ |
| sequential | 4096        | 3320.70   | 128000     |
| sequential | 131072      | 3234.08   | 4000       |
| sequential | 262144      | 2881.98   | 2000       |
| random     | 4096        | 28457.52  | 128000     |
| random     | 131072      | 4558.78   | 4000       |
| random     | 262144      | 3476.05   | 2000       |


### Size = 1000M

| Mode       | Buffer Size | Time (ms) | Read Calls |
| ------------ | ------------- | ----------- | ------------ |
| sequential | 4096        | 6842.04   | 256000     |
| sequential | 131072      | 6677.01   | 8000       |
| sequential | 262144      | 6268.29   | 4000       |
| random     | 4096        | 58478.65  | 256000     |
| random     | 131072      | 9435.85   | 8000       |
| random     | 262144      | 7031.16   | 4000       |

