Return-Path: <linux-fsdevel+bounces-35873-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB41A9D92FE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Nov 2024 09:01:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 617D9163FDA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Nov 2024 08:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21991192D7C;
	Tue, 26 Nov 2024 08:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WI8KUgV3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7E6143748;
	Tue, 26 Nov 2024 08:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732608103; cv=none; b=k/ssENpniGXVpl3mGz/l+0IGwsTVeGRKY0aR8P0VlwpqepXuA1FVMNLneXNEL0o6A1aqyX799PXA4E7MT/d2MGElIIhucz3W4UrjMimKMb0llZtMBk0ZKKPK4JljJxjHWs+yoBNgYNkd3DehpAwvJioQnHlt3Yg0Gl12MVeyBN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732608103; c=relaxed/simple;
	bh=Qr/taxXz3vGfl/Nx+zsxIithDFdRIadoA3c15spbSLc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=NJ8tSWml/SE0oxggVnEBVOCnJ8f3yaFZEeOq5hOyqZ0HxRavQhWznTastf9ZTG5bwJefXa6yD8FjeDZAbocwZB0lESKZOf+vcn4BnzMO5pd855/HHrAAiB2pgpInLNxKOxnl2JGCSAP7S9rLbjS1Wjlzp38LIkqt++xJKPnaxaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WI8KUgV3; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2ffc76368c6so25678831fa.0;
        Tue, 26 Nov 2024 00:01:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732608099; x=1733212899; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TLhcUgcaehzCh657DFQOY7eTZBplqKp16QE7H3wG/RI=;
        b=WI8KUgV3k/vm8f45by5qTUXPXsu8SuTQTJle5glaKkq8a7puSNHTjNu76j0xKNqwzd
         NRMuGRDxd9CjNO+tKM0UOL3LPlY07YY/Q1qIE6Qcyv3PRE8tGrjC4T3HrqLTPQXNUGDL
         PaoNUg3QVkqT2mCXbm4LSuTkeJt/vvZn8IasOToANmbwGGWHPPkfXJSoPFe/SX4aAQEm
         k3YpQd41R2YRu5Cc7CpE9Ul4NMU8+IH7jPUIM4wmyY0aYoy6F3+mx0hgo4QiQtuj1aks
         43DahBQbXaWsywQ3jNvOtNJ4XeHQpviH7pIWxbytDpV7x/fUUGI3cQNgtwmrnbo8sy5r
         NbtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732608099; x=1733212899;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TLhcUgcaehzCh657DFQOY7eTZBplqKp16QE7H3wG/RI=;
        b=XPplNLIa722m1pcE+yCnyFmLhzzHi78WhyObTy6uyTpZbyukwoxYo1xpFl3ji+rNWQ
         lLcF7zuCqWEO+4cHV2Qj1fZINl+RsY2yzOtjpPo3bX0DU0b4q9ifd+Nhlf7LVCpPqpb/
         27EEhR0d/6lMh8OyLJT42SyDcDTRSeH05bIspxNAHXjdUwePFa7j2twCHAR2owL7G8Jk
         m/iW6GvXcbUHLciGQT8/O0EXUUHCI+/LXrPpjFXewSwPScBShj6vFqwIQjkEF57wBHTW
         N19R0jxQm8KryNiVjvAwarCs7MJedKOZFf5FloMzSlUipLtvweM7H+QB+ig/Z+piResB
         ceyg==
X-Forwarded-Encrypted: i=1; AJvYcCWkWyuoaKNsM3jXDjUeL4/psXcF1sPdJTa8yp8mSXTgE3UhUb+9ySWjw1s7cdjRawj78r/v1a/uEq9cPNXO@vger.kernel.org, AJvYcCXhV3svlFrf6OWYJwA/9pDlMUBbS35ix7oNldq+oEPAm/deLUkjQv3LftNlG3jUmSSDcjMvgaAzwF91L939@vger.kernel.org
X-Gm-Message-State: AOJu0Ywavzgi1lRZhB4jNW6astvHd//k5/IuMEJ/gdfXWs7rn5HJLTD0
	QrsIh3cjCAKrS8TWURK07O3yOBnQG63+SBccb9VvHiNtK/p6N+GL
X-Gm-Gg: ASbGncsF3eBBaSWdDjekXzh6x/NiwXiXWXhGfj3f7Jfkk7fPXctETg0Zso21XXR5dH0
	AhfJmXfQNpkTPbkvRNJ4VI9xUM7XFTpGolepnnjv6de5f8OyIbr3UbS+RmMrBegi7I/7bRYfATV
	wS0ry3ygDpMbg5NyLMGi5qYwxoL4PmkNqBukpW7f/bD1AVUzW3UxMV3+Jk+a8ToxxJGj/gfPYLd
	OX9dSBJ/9CEcEmM14ISDp1EfP8S1Ni7xPv7KP/QMEgpdozjFB8KBj5Rs8SztpfjrINCp1Gsdb1n
	It9Xj5qDdezPHFisxWfnsll+MfU=
X-Google-Smtp-Source: AGHT+IE4dWqX6FYS8GpTyQPwG7QbFUjZkKoqX8mHebeNCaYOS/7Fu3gJfNC6CUKQ2XORHy1/kXb/oA==
X-Received: by 2002:a05:651c:888:b0:2fb:3df8:6a8c with SMTP id 38308e7fff4ca-2ffa71259cdmr113863541fa.23.1732608098684;
        Tue, 26 Nov 2024 00:01:38 -0800 (PST)
Received: from ?IPV6:2a00:801:2f3:e48d:c8bb:deb3:99d1:7504? ([2a00:801:2f3:e48d:c8bb:deb3:99d1:7504])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ffa538f23csm17380591fa.111.2024.11.26.00.01.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Nov 2024 00:01:38 -0800 (PST)
Message-ID: <4bb8bfe1-5de6-4b5d-af90-ab24848c772b@gmail.com>
Date: Tue, 26 Nov 2024 09:01:35 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Regression in NFS probably due to very large amounts of readahead
To: Philippe Troin <phil@fifi.org>, Jan Kara <jack@suse.cz>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Andrew Morton <akpm@linux-foundation.org>, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <49648605-d800-4859-be49-624bbe60519d@gmail.com>
 <3b1d4265b384424688711a9259f98dec44c77848.camel@fifi.org>
Content-Language: en-US
From: Anders Blomdell <anders.blomdell@gmail.com>
In-Reply-To: <3b1d4265b384424688711a9259f98dec44c77848.camel@fifi.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024-11-26 02:48, Philippe Troin wrote:
> On Sat, 2024-11-23 at 23:32 +0100, Anders Blomdell wrote:
>> When we (re)started one of our servers with 6.11.3-200.fc40.x86_64,
>> we got terrible performance (lots of nfs: server x.x.x.x not
>> responding).
>> What triggered this problem was virtual machines with NFS-mounted
>> qcow2 disks
>> that often triggered large readaheads that generates long streaks of
>> disk I/O
>> of 150-600 MB/s (4 ordinary HDD's) that filled up the buffer/cache
>> area of the
>> machine.
>>
>> A git bisect gave the following suspect:
>>
>> git bisect start
> 
> 8< snip >8
> 
>> # first bad commit: [7c877586da3178974a8a94577b6045a48377ff25]
>> readahead: properly shorten readahead when falling back to
>> do_page_cache_ra()
> 
> Thank you for taking the time to bisect, this issue has been bugging
> me, but it's been non-deterministic, and hence hard to bisect.
> 
> I'm seeing the same problem on 6.11.10 (and earlier 6.11.x kernels) in
> slightly different setups:
> 
> (1) On machines mounting NFSv3 shared drives. The symptom here is a
> "nfs server XXX not responding, still trying" that never recovers
> (while the server remains pingable and other NFSv3 volumes from the
> hanging server can be mounted).
> 
> (2) On VMs running over qemu-kvm, I see very long stalls (can be up to
> several minutes) on random I/O. These stalls eventually recover.
> 
> I've built a 6.11.10 kernel with
> 7c877586da3178974a8a94577b6045a48377ff25 reverted and I'm back to
> normal (no more NFS hangs, no more VM stalls).
> 
> Phil.
Some printk debugging, seems to indicate that the problem
is that the entity 'ra->size - (index - start)' goes
negative, which then gets cast to a very large unsigned
'nr_to_read' when calling 'do_page_cache_ra'. Where the true
bug is still eludes me, though.

/Anders

