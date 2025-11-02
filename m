Return-Path: <linux-fsdevel+bounces-66689-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DC85EC29094
	for <lists+linux-fsdevel@lfdr.de>; Sun, 02 Nov 2025 15:54:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7FE014E6928
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Nov 2025 14:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5819CE555;
	Sun,  2 Nov 2025 14:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YWqT83DM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A6531EEA54
	for <linux-fsdevel@vger.kernel.org>; Sun,  2 Nov 2025 14:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762095250; cv=none; b=tf50Z6lLi99XHHe1WeSE1Wt9Qy0jAvCXqo+hkonQ/bS4Q6YfouQiLyZCQfh/HeXYJFHcb6VL091FeWGOULD3cz+AfIQ+bT9d7Fqmy1UlHSFs9osSXUdddbfeY0w9sN4rj2apzxTFMIW4muIVwRPok3oEutVXks+cdcjyQFARo+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762095250; c=relaxed/simple;
	bh=bxlaRRL2nlhlY73i6Z4C9oKQbVYkM51GfKeaLJcEQCg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rvhPkD2YQATC/Owx03JzLgbTTpkU5XWyBeSJ8WwJghi/W1m2QTvI6YTqAQ+moATXOCUGdSDIp4M6wQfbALstZ+1csxI6Ex89JXXCQWa6w3esHOhk2Pj3C0te/pYIGvWP0s5eF629L6VL54td/nOH5AA3AhailcgRMTe5d5z/M6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YWqT83DM; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b6271ea3a6fso2536681a12.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 02 Nov 2025 06:54:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762095249; x=1762700049; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fbBV+bsxsJJo9i4W5rlnGSN2o5UCpIao/xa2AtsqV4U=;
        b=YWqT83DMvAFc7vKG142AHXBf+zWFhN884IslkqgpLI8sspgPFKJZ9hemsMsrrkrK5z
         FWlVQw44SjhqXk4mmtDHYQHzFBzsEUvSYXa2K+odeqhJ7H+gkcbmq0H0ueQWUwViYLDZ
         hUVErENyQjvaL0/kzMmfXRhibwMg32MoibakV2gyKt2EgYVpZcVZMOCza2HASgnbWvJl
         N7633hu9/9WpcOFYViHYp5WjXCJFWHvWkc4ZGkH7YERqRMFyoa4KkuzKwdmuikgyN6Oz
         uacOyF34uPNZI0LMU1Ep2f8suCKwQDwmrDpQlEN3BMhRDVy8Un0yg3m0TOhuoKO5farK
         TTTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762095249; x=1762700049;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fbBV+bsxsJJo9i4W5rlnGSN2o5UCpIao/xa2AtsqV4U=;
        b=EOP+WXHJm8F76YMoDDmjm9crknSLvwZafrmKPfb8XF4ruVKzNtrP8W65Xhs6GT7aeP
         RIAuYSbimTQ0ih7wVLuRbnEJw9L5XuUw3Uq9ImpOtZJ6Z8Zi0ztpogdKxMqaNOE6E7zG
         t42va8syPVTkNZ6vMXI+dG2XBHzLLFpz4Jan/5bPkwvDRiAfZGylBqdcu51vUtPbekbb
         ih+3R9hQls1jjgT/kX4ur8y24TG8EX0pSQocUU6lOeEYDrPt8+4eackhaAoPtfC8QtTd
         CNkN62BrVIw4sYLNFPpHSve6IXIldQc8WqaKA4SL6g3OqyToIe9wHTFyvg5+HLXTP/N4
         2h3g==
X-Forwarded-Encrypted: i=1; AJvYcCVg8n7vW4Z8v9Hrubnz+Oq6ZBeUviFCq+YrFo4dLHQqDjRagmhPQS5UFEY7YoVKfl343DU5adoVPdu1+IQC@vger.kernel.org
X-Gm-Message-State: AOJu0YwkRYn4Gy1MIXHfqZO/3Mrs7r2hnWGRaU2RIvZvG74f+jdg7vI4
	THO8YG8/yVriX3gyPi9EctSlrNH9ILh2jnuVgxpxV+cKVGtMTHNV67Jv
X-Gm-Gg: ASbGncvwn75aTFYV4/WPCQ+pfZL7y7uKU4IDqANNxnI7KFLtjVWI/faZkOaXGLNoJGr
	StaAuzqvF6CYZiB0OlyR+EumJc2JwWjeYR/2R6jI5V3au0m34Q16wpKOuvnvwMSYKhHmSTuXg+P
	IQsSwFx4uap5ksG6ZcWem9heodTeURW1vtrPoz0mTa6qlRnzidNnZ49X1ezGe327F4Q/CA1Aseb
	wrP240Nq2gEZ0uZoGxQu3BE12cf+f+O+MEFjPHPqb4P9+9FYDPWUCxieexAtkqAxEE+THy+aRNn
	dkmUTLiVIvBORKFbJFCIeUK/DYSUtx9XLr6VQWdNx+szqkNXYuaHQoItnOrtu0hZ7tc4CYrp4Zx
	4UaGUyJFarMOOMbeR6DEsfaO2qmn6ir1CwJfzk2yTHOSSRVIr2Km69zNg+5ee/S8dddQY7MISIg
	bJAr7B4YBDIJ98ll2C9eyzYBr6G3NqzD02mboPlvG6MhoYa67ffOQfymJ8Unz1RNmkzSqf42ZzO
	5W168vr
X-Google-Smtp-Source: AGHT+IHnLWfHGWwD5xspKTLkP9JN/NSwcFfGAB6JIFTeuFpTGFd9k9unp0HkbTkr2AtQX9XeHiH/Qw==
X-Received: by 2002:a17:903:2f8f:b0:249:3efa:3c99 with SMTP id d9443c01a7336-2951a600e39mr135629275ad.61.1762095248528;
        Sun, 02 Nov 2025 06:54:08 -0800 (PST)
Received: from ?IPV6:2409:8a00:79b4:1a90:bcd5:ef4:19ca:265d? ([2409:8a00:79b4:1a90:bcd5:ef4:19ca:265d])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b95c44f7363sm5581091a12.6.2025.11.02.06.54.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Nov 2025 06:54:08 -0800 (PST)
Message-ID: <ef70adab-ed59-45c7-b6f0-93b61fdb620b@gmail.com>
Date: Sun, 2 Nov 2025 22:53:57 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fix missing sb_min_blocksize() return value checks in
 some filesystems
To: Matthew Wilcox <willy@infradead.org>, "Darrick J. Wong"
 <djwong@kernel.org>
Cc: Yongpeng Yang <yangyongpeng.storage@gmail.com>,
 Namjae Jeon <linkinjeon@kernel.org>, Sungjong Seo <sj1557.seo@samsung.com>,
 OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, Jan Kara <jack@suse.cz>,
 Carlos Maiolino <cem@kernel.org>, linux-xfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, Yongpeng Yang <yangyongpeng@xiaomi.com>
References: <20251031141528.1084112-1-yangyongpeng.storage@gmail.com>
 <20251031152324.GN6174@frogsfrogsfrogs>
 <aQTpLEHURCmkpU3K@casper.infradead.org>
Content-Language: en-US
From: Yongpeng Yang <yangyongpeng.storage@gmail.com>
In-Reply-To: <aQTpLEHURCmkpU3K@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/1/2025 12:51 AM, Matthew Wilcox wrote:
> On Fri, Oct 31, 2025 at 08:23:24AM -0700, Darrick J. Wong wrote:
>> Hrmm... sb_min_blocksize clamps its argument (512) up to the bdev lba
>> size, which could fail.  That's unlikely given that XFS sets FS_LBS and
>> there shouldn't be a file->private_data; but this function is fallible
>> so let's not just ignore the return value.
> 
> Should sb_min_blocksize() be marked __must_check ?

Thanks for the review. I'll add the __must_check mark to 
sb_min_blocksize() and include the Fixes tag in v2.

Yongpeng,

