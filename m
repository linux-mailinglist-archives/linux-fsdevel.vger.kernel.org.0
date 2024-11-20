Return-Path: <linux-fsdevel+bounces-35261-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B31D9D3335
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2024 06:40:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B24BBB211D2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2024 05:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C1F7156F39;
	Wed, 20 Nov 2024 05:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g6q6eqyE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 496A71547FD;
	Wed, 20 Nov 2024 05:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732081240; cv=none; b=Z67ue+vvF5zx5bM99cQezuhXYBDC+zi0heNXyVCV3K/wBr1k+JBsXg4PXBPPDj33tjZM+RfVg+zTnhYU+WQKgiPLN+BKGRf4qZ4HrQ09E3GLiLdAFXY51myPziKGZ0UK2DaZUk6d2iNoQbYjCy1oge2NKNFWBumZHfMaBcVS7JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732081240; c=relaxed/simple;
	bh=NZX7EJEftC8ogdSNUbqlqxEm7+iQXkYv8nzBOlRv0z0=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=NBMpyTrV3PKu13vts8D+dkIKBIDStyPUxY/LDZxSak6+yKLdkbcw3eiVLknY+N+nI1+HdDVzQiFW1iTT8kilcBvk1maAd/4Rn57rHvKXUTXqLs/w17hWmQKEPSi39jLf+P3YawqKDeWj3ZTo4odc6qvHxB7emqnJJg95Bglfe58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g6q6eqyE; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-7f43259d220so2795987a12.3;
        Tue, 19 Nov 2024 21:40:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732081238; x=1732686038; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:cc:to:content-language:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=49ldDJo3N8z4og68gIqgA/slR0RHXRgXwRCuFS38v0c=;
        b=g6q6eqyEeyGTIQXCpiuFnqmBzYIt+g8KWKj7VfK6XbtXEItrFhEiUyrFh3gL2Anviz
         yAxDnWTpAuTNoiGdlaLferDX/JOA53IxXBiPaeGSkPr3xAhgSk5m5Qt81wnPabtl3qYs
         8ASVfHFx8XBY5GUtAKKm0JJMtelLWf9z4V8py263TGxeMzwq9w3fXCwQzCGkatRxTSqF
         5phYlP+LliybKyadsiV560syQikLbg8FtRwNbTkPQFAvpFQRuwqQoiyprL8Jz9D/812D
         vhokt2j6ZJRVlp1rxDIEAUc1lR6LprtX1kINhOGZM+BDUqFQzHpS/wW7aQbWMZ8KF/F3
         NdMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732081238; x=1732686038;
        h=content-transfer-encoding:subject:cc:to:content-language:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=49ldDJo3N8z4og68gIqgA/slR0RHXRgXwRCuFS38v0c=;
        b=CX8TnJiQ3/J07X2X6SiKlV8nLpQFXMvYaTn+tmceghI3UVP4/FNT35TSxvGGEZESN3
         Hdv+ydQcsAWyPxqy3eFIhfXIG8dO12tm563KEmAN230mduqLfWES0TPfpWDOzsVtRWRG
         HhiK1BU2auyWgO+qITpEix0DfFTjVsaf4PZfLlf7Or8rBLb5fktnS70cUZ0yorHzNuiI
         fQihzhb0xXfSubvhdQMlDudabF+sRVb0Y/c35gCauFlP8K4qwSzce8h2qt6c6oLuQmqc
         Zoo+OHIzdcRPzSZVEh+/dMuDSQ8tTdl2OGZbufOf4zvx+hEkzxQ0TUf7uJt5wfaFhjTQ
         +mqQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4wZEMUgSVILaYuD8tOcTfU9x/3dNRW9v3zU4gK2YUZxB2FE9Q9LqsGieWXxKzC8+kwqvC1sGfZGc3cds=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmIP++cdB5yRkRQ+w7aW8/6TUlGOKG/FNLbmarg+QrfNSfdzGe
	5ny9SIdHQOeownjBI6P+mz82wQASXNHuJR3TvjR+7SeDqBkshsUA
X-Google-Smtp-Source: AGHT+IG31LJq2bi3QnR5bKoafknw+rirBINa2huhIzbNN7UNJ1r6TTupybhgqrYR4YKxnchSEkCH2A==
X-Received: by 2002:a05:6a20:8402:b0:1dc:32a:d409 with SMTP id adf61e73a8af0-1ddb0433d90mr2589292637.39.1732081238451;
        Tue, 19 Nov 2024 21:40:38 -0800 (PST)
Received: from [10.193.178.64] ([124.127.236.177])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2125fa8dddcsm14406445ad.264.2024.11.19.21.40.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Nov 2024 21:40:38 -0800 (PST)
Message-ID: <0c04e4ea-b900-4476-abc9-6b57e5c26e43@gmail.com>
Date: Wed, 20 Nov 2024 13:40:32 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: ZhengYuan Huang <gality369@gmail.com>
Content-Language: en-US
To: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 baijiaju@buaa.edu.cn
Subject: [BUG] fs/eventfd: Possible undefined behavior about read and eventfd
 interaction
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello,

Our dynamic analysis tool has encountered a potential issue with the
interaction between read and eventfd. Below is a minimal code snippet
to reproduce the behavior:

int main() {
  int fd = syscall(__NR_eventfd, 1);
  int ret = syscall(__NR_read, fd, 0x000fffffffffffff, 8);
  assert(ret == -1); // invalid address
  long value;
  int ret2 = syscall(__NR_read, fd, &value, 8);
  assert(0); // never reached here
  return 0;
}

When read is called with an eventfd file descriptor and an invalid 
address as the second argument, it fails and correctly returns an 
"invalid address" error. However, the second read syscall does not 
proceed; instead, it blocks indefinitely. This suggests that the 
counter in the eventfd object is consumed by the first read syscall, 
despite its failure.

I could not find any explanation for this behavior in the man pages 
or the source code. Could you clarify if this behavior is expected, 
or might it be a bug?

Thank you for your time and assistance. Please let me know if 
further details or additional reproducer information are needed.

Best wishes,
ZhengYuan Huang

