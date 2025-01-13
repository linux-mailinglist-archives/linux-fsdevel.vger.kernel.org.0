Return-Path: <linux-fsdevel+bounces-39060-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5032A0BD08
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2025 17:13:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C599C1649C7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2025 16:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4453820AF80;
	Mon, 13 Jan 2025 16:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fmpoWUHA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104BC20AF68
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 Jan 2025 16:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736784739; cv=none; b=LkpSgdb+DhXBRxED3DNueAEqB/WDPpd2pTtHB6/xZWrYokFn+zuANlYYJXUV88OkM498x/QZsmJTF2B2oAgToofAZh5cpV0qUFkuYvCXXSjcF5C44d7clI5hCWYL04Sui5ERrUbr/BBGPcXe6Bjy5HtbzC6neNc1pLgXr65Yg+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736784739; c=relaxed/simple;
	bh=H+F9tHVBR0fQmf71J3gLkHC9qgPnJkYNp5GS5S4g+7g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RK4vxhNjNUOqtgavcAdxJzREoGUfrh3htJgmx7fMHLUu3ww2Mk/YI924zxqAk6R+uoAMF9uj39JCvra+ninAniAQyjd3Fv5CQqbU7KovCVqumr1LpY5lfIzrUwQ1u386QDanLyGRAPt4KTtkw5tphigKfyXr82/T+K7FuOIqj1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fmpoWUHA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736784737;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+pjWyIe8mnk7g6/F83/ZX7003rIKqe+bESoWt3TOXDo=;
	b=fmpoWUHARcHa1L5eBdiJm/uSkhcGrmcmjnJW219VmUgXm6qCED5+Kk2BgmFFGJ+sQH5WEl
	4wjzyr8vr9hy3rpp46JLpf5fe96EkAv3skAgoYWM3yB0+1CLBinYwNr2VsnymP+00zI/Sy
	wVVXBopl40WkIK++BXMVwH4oWSxaBRI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-177-ezOroC7PMmC4SlB1wgCqeA-1; Mon, 13 Jan 2025 11:12:15 -0500
X-MC-Unique: ezOroC7PMmC4SlB1wgCqeA-1
X-Mimecast-MFC-AGG-ID: ezOroC7PMmC4SlB1wgCqeA
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43628594d34so25690205e9.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Jan 2025 08:12:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736784734; x=1737389534;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+pjWyIe8mnk7g6/F83/ZX7003rIKqe+bESoWt3TOXDo=;
        b=wntt8SObnkR18EdEugwqfEtB4q1MXnpWkxsx5SkBffBmBCpdx0yiPDWXx7r/S9nSLa
         +JNfjngkgRG3zg8meWKWMa57Hlq8lR8FAsf+le+EVUJz8GEAKdqG1/IXqNx7yhDanhoh
         eZW356hRaOyFk+JjaUylb8uTxWRCyWI5vurCyTTPaVayKVqfif/IlQvecKHs98Z3Htb7
         W79AQ8hB/b5XjKoSeyO9/wtM8q8pNi6/ex339cN8ntQi770YOpcChyc/TRnkJd8k02hn
         u4Dplm3V9Hw3psL6PvVsntbGcWtQrFPwzOSJqK912X2LhyI70aNvVYh++8tE4SesHIqu
         s1Bw==
X-Forwarded-Encrypted: i=1; AJvYcCVblVkfEWxJEMvQ6DcUjnp4pVU+UAupZ9JUQHRrSUo1SbHU0Cq6wg/wiKQcKNeBTW5MCBohrs2ZIw+W3RG/@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1aVISMrvIg5wDd4lBGHRDojr7IP41q+1S3OjzMIKt+9QXD5h/
	m61eIi11KnpUNpgXUkLvA1ufj62UKpfMqLEbzeo4e7STbO1sMh9HjeLbRRXf+BA/Hmc236R7O8q
	AKDnhbuBstBqGKjGAnevs/zsKhY+v5nqR6OcRNom2WTl17fNBELoNJ2O2Gi/vuiY=
X-Gm-Gg: ASbGncvjBGcwtt91BgGSWCZgCFqUnvtyjKZYTEIUCd1tnLSc9jpDKTNvxMYrvEFE443
	SZByWD88gtXWxAd7jeky86K91q2Kat+1LQN7qN2FOZVJUKT3zVnuxG9qQxwVyQkJWJnmhrHiQ4Y
	XfUEDZNKHj9NKzq/uuf1Xbp1j0I+blyZCxlULJhwu5gVdeI5uCWCikDB+c90vvt6NFlFq5eO5qT
	Fhz7fVqYDjkar+0sPXCJNgI8qJC5/9hgKOe8FWrYFnNJ0cXVjQ6aEaN2Mr8d+uGaC71tz+S+SBH
	uCAp76LRl1PFaMBMSe1RVvBuHyltoUhtNEhV1liy
X-Received: by 2002:a05:600c:a44:b0:434:a852:ba6d with SMTP id 5b1f17b1804b1-436e2692d98mr192763375e9.9.1736784734397;
        Mon, 13 Jan 2025 08:12:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFf6XW1cvL5UoHvdjbD30b+iBZ9HkwmTvZwbT8O+46nwB/B8rcXEgT73vr2SwiShA/NK8OOuA==
X-Received: by 2002:a05:600c:a44:b0:434:a852:ba6d with SMTP id 5b1f17b1804b1-436e2692d98mr192763035e9.9.1736784733859;
        Mon, 13 Jan 2025 08:12:13 -0800 (PST)
Received: from [192.168.1.167] (cpc76484-cwma10-2-0-cust967.7-3.cable.virginm.net. [82.31.203.200])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e38bd0dsm12465616f8f.45.2025.01.13.08.12.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jan 2025 08:12:13 -0800 (PST)
Message-ID: <31f0da2e-4dd7-44eb-95ee-6d22d310a2d6@redhat.com>
Date: Mon, 13 Jan 2025 16:12:12 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Bug: slab-out-of-bounds Write in __bh_read
Content-Language: en-US
To: Kun Hu <huk23@m.fudan.edu.cn>, Andreas Gruenbacher <agruenba@redhat.com>
Cc: Jan Kara <jack@suse.cz>, viro@zeniv.linux.org.uk, brauner@kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 "jjtan24@m.fudan.edu.cn" <jjtan24@m.fudan.edu.cn>, gfs2@lists.linux.dev
References: <F0E0E5DD-572E-4F05-8016-46D36682C8BB@m.fudan.edu.cn>
 <brheoinx2gsmonf6uxobqicuxnqpxnsum26c3hcuroztmccl3m@lnmielvfe4v7>
 <5757218E-52F8-49C7-95F1-9051EB51A2F3@m.fudan.edu.cn>
 <6yd5s7fxnr7wtmluqa667lok54sphgtg4eppubntulelwidvca@ffyohkeovnyn>
 <31A10938-C36E-40A2-8A1D-180BD95528DD@m.fudan.edu.cn>
 <xqx6qkwti3ouotgkq5teay3adsja37ypjinrhur4m3wzagf5ia@ippcgcsvem5b>
 <86F5589E-BC3A-49E5-824F-0E840F75F46D@m.fudan.edu.cn>
 <CAHc6FU5YgChLiiUtEmS8pJGHUUhHAK3eYrrGd+FaNMDLti786g@mail.gmail.com>
 <27DB604A-8C3B-4703-BB8A-CBC16B9C4969@m.fudan.edu.cn>
From: Andrew Price <anprice@redhat.com>
In-Reply-To: <27DB604A-8C3B-4703-BB8A-CBC16B9C4969@m.fudan.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 13/01/2025 15:54, Kun Hu wrote:
> 
>>
>> 32generated_program.c memory maps the filesystem image, mounts it, and
>> then modifies it through the memory map. It's those modifications that
>> cause gfs2 to crash, so the test case is invalid.
>>
>> Is disabling CONFIG_BLK_DEV_WRITE_MOUNTED supposed to prevent that? If
>> so, then it doesn't seem to be working.
>>
>> Thanks,
>> Andreas
> 
> 
>>   We have reproduced the crash with CONFIG_BLK_DEV_WRITE_MOUNTED disabled to obtain the same crash log. The new crash log, along with C and Syzlang reproducers are provided below:
> 
>> Crash log: https://drive.google.com/file/d/1FiCgo05oPheAt4sDQzRYTQwl0-CY6rvi/view?usp=sharing
>> C reproducer: https://drive.google.com/file/d/1TTR9cquaJcMYER6vtYUGh3gOn_mROME4/view?usp=sharing
>> Syzlang reproducer: https://drive.google.com/file/d/1R9QDUP2r7MI4kYMiT_yn-tzm6NqmcEW-/view?usp=sharing
> 
> Hi Andreas,
> 
> As per Jan's suggestion, we’ve successfully reproduced the crash with CONFIG_BLK_DEV_WRITE_MOUNTED disabled. Should you require us to test this issue again, we are happy to do so.
> 
FWIW the reproducer boils down to

   #include <fcntl.h>
   #include <unistd.h>
   #include <sys/ioctl.h>
   #include <linux/fs.h>

   /*
      mkfs.gfs2 -b 2048 -p lock_nolock $DEV
      mount $DEV $MNT
      cd $MNT
      /path/to/this_test
    */
   int main(void)
   {
           unsigned flag = FS_JOURNAL_DATA_FL;
           char buf[4102] = {0};
           int fd;

           /* Error checking omitted for clarity */
           fd = open("f", O_CREAT|O_RDWR);
           write(fd, buf, sizeof(buf));
           ioctl(fd, FS_IOC_SETFLAGS, &flag);
           write(fd, buf, sizeof(buf)); /* boom */
           close(fd);
           return 0;
   }

So it's switching the file to journaled data mode between two writes.

The size of the writes seems to be relevant and the fs needs to be 
created with a 2K block size (I'm guessing it could reproduce with other 
combinations).

Andy


