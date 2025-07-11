Return-Path: <linux-fsdevel+bounces-54631-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B0803B01B4D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 13:59:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C3401885448
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 11:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55D7F28C2CD;
	Fri, 11 Jul 2025 11:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VXjGJMtv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 229AA175D47
	for <linux-fsdevel@vger.kernel.org>; Fri, 11 Jul 2025 11:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752235139; cv=none; b=Rb69vRXKDAWfEejLR0vRryygPOUaMpkbmd6FVlWk2c2LI2kJh+Ozlh6PdTv7Od1wy3Ox1UX7dZhi4Zh1Ulok3sqISRpREYi+IzB69zWShTvXidY3VAP5eEVcBWxU8j0Tzx41Jm2NSlZwc22JwQ4tAH8T66uR9cbhT3y8W4EEHOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752235139; c=relaxed/simple;
	bh=2yK/niXsaeSpgJBeMu4SudichYfKIbv55NlKDYWHkXI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q+MkIRNYUW/799Ox7O7oSm7B6fbXjH+BhOnjPaF0PPbBGM/sELRKxHRRi0mU7w8V2rUZRX34qeKXhLVxkYz+xWYvB+G/+EfD/DpCIXzuJqnFz5OdYAQx5h+nb6AgnJPeASdxDM4svxU9uQERz33HC4cWXWqBodlSO37QvXghTqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VXjGJMtv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752235137;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=GD1ZVd4/AjOtZiQd6PXK5gen+3IMNVTa6EqawMIDX/k=;
	b=VXjGJMtvgoTdbDjLam3TRWJzMyUHqpVAVpBjMpQwnzR8uOuzkYzkADJggD6uCd5V54UFD6
	zUY6zbxWcX4Otyh7BC/PQYOEaind1wuFXjKh17CRHXVAkYyeFMlZ08mPQVUJV0MYPEbo89
	8RL1bwyGTktr3KKLWob+8RNDYpbkuDw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-54-vhbVCJeHMle84eQzPafkjA-1; Fri, 11 Jul 2025 07:58:55 -0400
X-MC-Unique: vhbVCJeHMle84eQzPafkjA-1
X-Mimecast-MFC-AGG-ID: vhbVCJeHMle84eQzPafkjA_1752235134
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3a6d1394b07so1399115f8f.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Jul 2025 04:58:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752235134; x=1752839934;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GD1ZVd4/AjOtZiQd6PXK5gen+3IMNVTa6EqawMIDX/k=;
        b=rF04UXqRdx8bkXJSKXm48H+PTy18U79mJ4LX4wzJQSy2GdugYA2+hRhJvul5AW/jiE
         fsm1PvNM63DW9p4P1+Rxs64lTusJOeVhLwjTGz2wzPl7Fwk/obHNLBnTUY2Nz4TGZNp/
         ZlHSLqumo58KHKpr2usxcSyM2itftWj4X+oQUna1CP9waD4Zp9u/w2KePUpsbEaDSi5c
         maSZdxE2JBsuTNswK93HW7Xxcnb5Z/1LEjvSpJqFmCQKQbG49HJK8n6M+RoXoebmiW7R
         3jBnwCUFp9CUx31acCNQ0pejxMyFpiueya5BR/NPAkIg8MtY/xqo9dxfNEUFXcj6GBnV
         Jnrw==
X-Gm-Message-State: AOJu0YzzrS/ps/HISEk6MNcwM1MvjZKA3/d0qTXLrBZ80BV+aX8zEZ8H
	ki+opKcYGZBsLNmN8veUPgOYYmUSE1efMQq+TXZhch6gW0XShv+Tg6XxBKmHZUDh/SU/80Ci2I4
	8KiYHi80LnI87mmuhOSmZalTtrD1EKFZaitf6eP78L9o1blTZphXk+OAMoO9qwnaGh/9P8crKaU
	sQaw==
X-Gm-Gg: ASbGncvclmOOsXB4Zs14NR5QGmIDjrDBlivl211rbBE3UU73Hp5PyfrsgMtmeJLZSxt
	mMQ+dygUfu2O0MusJckcx7NQkk9jkQcbZW87jBrFcGpF+4LYh9LGqduXeITuYZp2ALZfQT+ZXus
	1NZ/yNYDm6N3ec92R2037fsG41KduFOzzVk9agEoHdH9EsL4JLo95xL9vEMz1+7Lj8D5NWitUSP
	a5W0LrH0UyJPmM4EZtkIM3qmv19Gt7GsELK9Set0/iZq9BDNS4yGwDDbqeT8zPS5BDzBkF9bFkX
	JdkgUo6sgr4CSm3W3HRNjKTbGsxjziVr3pbWLJBL/5/9cXs8S64Zz50thyfsE5lDvmPGIJLYSp9
	0O4QGLERKGrs40RbBnOtJIaBt+Arz3DiEQTkNe8QajN3HdIiuXJui8+KnnnYkpc8sl4M=
X-Received: by 2002:a5d:5d0a:0:b0:3a5:5270:c38f with SMTP id ffacd0b85a97d-3b5f17f81efmr2490991f8f.0.1752235134236;
        Fri, 11 Jul 2025 04:58:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFwQ0yjfGgbrdPfsdS3XDPZ5kUA1A90UwOpxwFgAtqeIvAIy0tnjiXpyNWxRzo7dGabUFOX8g==
X-Received: by 2002:a5d:5d0a:0:b0:3a5:5270:c38f with SMTP id ffacd0b85a97d-3b5f17f81efmr2490970f8f.0.1752235133773;
        Fri, 11 Jul 2025 04:58:53 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f3c:3a00:5662:26b3:3e5d:438e? (p200300d82f3c3a00566226b33e5d438e.dip0.t-ipconnect.de. [2003:d8:2f3c:3a00:5662:26b3:3e5d:438e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8dc1e4fsm4240246f8f.21.2025.07.11.04.58.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jul 2025 04:58:53 -0700 (PDT)
Message-ID: <a7866534-6000-4e15-a428-94fec3aa42d2@redhat.com>
Date: Fri, 11 Jul 2025 13:58:52 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] fuse: use default writeback accounting
To: Bernd Schubert <bernd@bsbernd.com>, Joanne Koong
 <joannelkoong@gmail.com>, miklos@szeredi.hu
Cc: linux-fsdevel@vger.kernel.org, willy@infradead.org, linux-mm@kvack.org
References: <20250707234606.2300149-1-joannelkoong@gmail.com>
 <20250707234606.2300149-2-joannelkoong@gmail.com>
 <4ef06726-1851-44af-b4d1-45b828746ce2@bsbernd.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <4ef06726-1851-44af-b4d1-45b828746ce2@bsbernd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 09.07.25 13:06, Bernd Schubert wrote:
> 
> 
> On 7/8/25 01:46, Joanne Koong wrote:
>> commit 0c58a97f919c ("fuse: remove tmp folio for writebacks and internal
>> rb tree") removed temp folios for dirty page writeback. Consequently,
>> fuse can now use the default writeback accounting.
>>
>> With switching fuse to use default writeback accounting, there are some
>> added benefits. This updates wb->writeback_inodes tracking as well now
>> and updates writeback throughput estimates after writeback completion.
>>
>> This commit also removes inc_wb_stat() and dec_wb_stat(). These have no
>> callers anymore now that fuse does not call them.
>>
>> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
>> ---
>>   fs/fuse/file.c              |  9 +--------
>>   fs/fuse/inode.c             |  2 --
>>   include/linux/backing-dev.h | 10 ----------
>>   3 files changed, 1 insertion(+), 20 deletions(-)
>>
>> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
>> index adc4aa6810f5..e53331c851eb 100644
>> --- a/fs/fuse/file.c
>> +++ b/fs/fuse/file.c
>> @@ -1784,19 +1784,15 @@ static void fuse_writepage_finish(struct fuse_writepage_args *wpa)
>>   	struct fuse_args_pages *ap = &wpa->ia.ap;
>>   	struct inode *inode = wpa->inode;
>>   	struct fuse_inode *fi = get_fuse_inode(inode);
>> -	struct backing_dev_info *bdi = inode_to_bdi(inode);
>>   	int i;
>>   
>> -	for (i = 0; i < ap->num_folios; i++) {
>> +	for (i = 0; i < ap->num_folios; i++)
>>   		/*
>>   		 * Benchmarks showed that ending writeback within the
>>   		 * scope of the fi->lock alleviates xarray lock
>>   		 * contention and noticeably improves performance.
>>   		 */
>>   		folio_end_writeback(ap->folios[i]);
>> -		dec_wb_stat(&bdi->wb, WB_WRITEBACK);
>> -		wb_writeout_inc(&bdi->wb);
>> -	}
> 
> Probably, just my own style, personally I keep the braces when there are
> comments.

Yeah, sometimes it can aid readability. I tend to keep them on 
multi-line comments IIRC.

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


