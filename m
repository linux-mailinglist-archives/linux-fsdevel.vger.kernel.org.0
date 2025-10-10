Return-Path: <linux-fsdevel+bounces-63751-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8734EBCCC61
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Oct 2025 13:28:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 940854F7739
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Oct 2025 11:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 130AC286891;
	Fri, 10 Oct 2025 11:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="DSKhhRY5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 241DE1FA178
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Oct 2025 11:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760095689; cv=none; b=ovJ8OvsJu2n5EGfrEPb9f8DcHl2TcHsAOrD81FiECGR2zREFfEUnlAvE2v5hRzvrKUoGKZLF1CTsW3329f9Q+zgaEp47mljTgKenshZWlnDn6GeZ27c0dqrn8yFBnIFmKAGZMyhsMQVZhyq7rNoo+c+jwlCP4EyLgsPKtiBr7lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760095689; c=relaxed/simple;
	bh=ViTQiNmPUQBOueOGB/HBimEbEB4WPPhPlz7ms/N44JE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r08w18Q0ZLadOaZ5Jj/OMzbqwTmE63ESyKlS4EUVhrxbEKR9o442b6rrDO0Qk3rdRfUptyuVAR5/vcyXldnrGsVBfQRs3owaHwaOWbqcTr5atAt3SpMpr247ldK+RaGFHOfadOzrctcv9G9eXg1yIG03xErXwJaKljj3uzDWqkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=DSKhhRY5; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-2897522a1dfso19143135ad.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Oct 2025 04:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1760095685; x=1760700485; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XoBMX2Aubvb8wO+lMjvIKgOPI34JtmNvU/ihlZvT4+A=;
        b=DSKhhRY5jR2sbexe0tMl1bUkT5aAruLLPJV0lDFKSXyg43Veh2Tv2LkwMMx65fUfYx
         leXZ+hzwzHH9ImYAq8b+kwqM3jTDimTuu09Y1qUTgDx5SXBqNidk27VuhqpfVwNhl5a6
         mRgijWant8heIliAFHaBJIAbIESexItzQ8SjJOaeQuUR3Vx7s5RWtF+FliiJ2aQVIYo9
         9PN1i6KLhq44lBHDucWvSE5I2qsky/3nJXHPwqeoUwsw0IZNQO5/nIeTm40mKbkXQW9H
         KwD40n/dJLyPHBkr6LnAQvo5eLi71AARfGzVkzL/00GuVOlxvztzlwweE8NldfJG8h2n
         c/kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760095685; x=1760700485;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XoBMX2Aubvb8wO+lMjvIKgOPI34JtmNvU/ihlZvT4+A=;
        b=gcQjECS5mb1+274xk65hjEn+PvuAQy+cUqC/ODhrjr/pZ+hlQXCSze03P890mcpww9
         uWKuDiO3GyzP/+iXDHLzqfoRUgG4+qe+BDGm9QAog9FkW92o2ZdLzGCr0C1VON1Tz/9M
         qHmT1qT+4WflHZEpHxAStChCAjU08CyQaFw5c3WgVEUDKFQiPykdLSBHZdV5E6Bo19Pn
         FnuWDIeHAB3/PQbeAJ97LJqaGRdtYoQ3jEKiYKLVZWxg5XqRytdK6f45MpVyzA/ZCCOV
         LF6qdncXT+Q/WZ+V8ThrEeK0z/IGfCE+RMy+vLoxN9CRgyWyowJBvhvieyAK+mEqcFCS
         o8fA==
X-Gm-Message-State: AOJu0YxgvZ4Vj5mr76lqNwbizzcTUDmLxRQvGZ9MGbA6h0B4YX8pWwpU
	AG3+cOqf7Xwovw7Mdi8OO2eK9xSWTtvwGmYBSIeA65/DyutmFloYEW3L3j16T0143pU=
X-Gm-Gg: ASbGncusXH1hQaRn7SP5FEckcvxqA1UKcWD5CXgGnCfzQNOpXWcZIdG22rdQ+glLTuH
	X5G3qnKrMxY/xZkJR5A50LMXN7Yfla2j3ZU0LjzmpQSS77AEMZgniYm9ejCoePcLS4mtl9U2T7J
	uz/yrvMkJmwKLGYfOvaPiuu4P4BdqaEx0InRuoPuY6Es0SV6Dg6svuNHKabBmeA/e6BHhELygoa
	rYFQCZRleU0Y/M+IWdkx1IubpUy6YlN9TYQa5IGXwj9cnus5DZIvErlvHoYCIG5hZTzMvouCKJf
	Y2XTMTULWpVPiw4NXJfOQauvhz/NL6rFqaYE2VTy6igJ+4O7s0zrkQrBAxbaNpfI4yFD+KJZ62d
	3V5kHDPR8ESCJhRaY4/QvA7N9VyUPU4AQeou37Zpws4mZipwjY9/KFb2z21OJmzRqju05xZA1SV
	b0g+Qbd6PhxSb5gQcC
X-Google-Smtp-Source: AGHT+IGN+YWFM7JBQHZzprqLqKzWiSalbcIV4d5jWwNOE+pO4SLQc5W9LSDGLUPVTbVD4Rs4vEN0YA==
X-Received: by 2002:a17:903:1a86:b0:290:2a14:2eef with SMTP id d9443c01a7336-2902a143dbbmr124687075ad.0.1760095685211;
        Fri, 10 Oct 2025 04:28:05 -0700 (PDT)
Received: from [10.88.210.107] ([61.213.176.56])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034f08eb7sm54147855ad.82.2025.10.10.04.28.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Oct 2025 04:28:04 -0700 (PDT)
Message-ID: <66611854-79ec-4610-956d-01de752cf8e1@bytedance.com>
Date: Fri, 10 Oct 2025 19:28:01 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: (subset) [PATCH v3 1/2] writeback: Wake up waiting tasks when
 finishing the writeback of a chunk.
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
 Jan Kara <jack@suse.cz>
References: <20250930065637.1876707-1-sunjunchao@bytedance.com>
 <20251006-zenit-ozonwerte-32bf073c7a02@brauner>
 <CAHSKhte2naFFF+xDFQt=jQ+S-HaNQ_s7wBkxjaO+QwKmnmqVgg@mail.gmail.com>
 <CAHSKhtckJwprCQapkg-AKaz-X_gjX7n_5+LzE8G7iZ0VzHCU3Q@mail.gmail.com>
 <20251010-kreide-salzkartoffel-b2c718b7f708@brauner>
From: Julian Sun <sunjunchao@bytedance.com>
In-Reply-To: <20251010-kreide-salzkartoffel-b2c718b7f708@brauner>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/10/25 7:10 PM, Christian Brauner wrote:
> On Tue, Oct 07, 2025 at 10:37:39PM +0800, Julian Sun wrote:
>> Kindly ping..
> 
> Please check vfs-6.19.writeback again.

Looks good to me now.>
> Your patch numbering is broken btw. This should've been v4 with both
> patches resent. This confuses the tooling and reviewers. ;)

Ah, yeah.. Sorry for the confusion, and thanks for your time.>
>>
>> On Mon, Oct 6, 2025 at 10:29 PM Julian Sun <sunjunchao@bytedance.com> wrote:
>>>
>>> Hi Christian,
>>>
>>> It looks like an earlier version of my patch was merged, which may
>>> cause a null pointer dereference issue. The latest and correct version
>>> can be found here:
>>> https://lore.kernel.org/linux-fsdevel/20250930085315.2039852-1-sunjunchao@bytedance.com/.
>>>
>>> Sorry for the confusion, and thank you for your time and help!
>>>
>>> Best,
>>>
>>>
>>> On Mon, Oct 6, 2025 at 6:44 PM Christian Brauner <brauner@kernel.org> wrote:
>>>>
>>>> On Tue, 30 Sep 2025 14:56:36 +0800, Julian Sun wrote:
>>>>> Writing back a large number of pages can take a lots of time.
>>>>> This issue is exacerbated when the underlying device is slow or
>>>>> subject to block layer rate limiting, which in turn triggers
>>>>> unexpected hung task warnings.
>>>>>
>>>>> We can trigger a wake-up once a chunk has been written back and the
>>>>> waiting time for writeback exceeds half of
>>>>> sysctl_hung_task_timeout_secs.
>>>>> This action allows the hung task detector to be aware of the writeback
>>>>> progress, thereby eliminating these unexpected hung task warnings.
>>>>>
>>>>> [...]
>>>>
>>>> Applied to the vfs-6.19.writeback branch of the vfs/vfs.git tree.
>>>> Patches in the vfs-6.19.writeback branch should appear in linux-next soon.
>>>>
>>>> Please report any outstanding bugs that were missed during review in a
>>>> new review to the original patch series allowing us to drop it.
>>>>
>>>> It's encouraged to provide Acked-bys and Reviewed-bys even though the
>>>> patch has now been applied. If possible patch trailers will be updated.
>>>>
>>>> Note that commit hashes shown below are subject to change due to rebase,
>>>> trailer updates or similar. If in doubt, please check the listed branch.
>>>>
>>>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
>>>> branch: vfs-6.19.writeback
>>>>
>>>> [1/2] writeback: Wake up waiting tasks when finishing the writeback of a chunk.
>>>>        https://git.kernel.org/vfs/vfs/c/334b83b3ed81
>>>
>>>
>>>
>>> --
>>> Julian Sun <sunjunchao@bytedance.com>
>>
>>
>>
>> -- 
>> Julian Sun <sunjunchao@bytedance.com>

Best,
-- 
Julian Sun <sunjunchao@bytedance.com>

