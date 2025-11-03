Return-Path: <linux-fsdevel+bounces-66797-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 544F1C2C399
	for <lists+linux-fsdevel@lfdr.de>; Mon, 03 Nov 2025 14:46:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 664EF4F0001
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Nov 2025 13:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A6C830B51D;
	Mon,  3 Nov 2025 13:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mTPQC/TW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D5BC2FBE08
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Nov 2025 13:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762177244; cv=none; b=YW052jVZkLtNEK4CDwlXkfjahOl6NN0VlbUIBN3eIpXTeBid8uT3ZrQ52tRpE1klLOdHdFkyUfrtqB0IDj6bT+GPokQWqh7keyitwmmacZ/QgAPBPW/Isqw3eReb5iDHkepXrsWwXcaKTG8LpWxxFmk07fnY6GpRP0AAsWOfRow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762177244; c=relaxed/simple;
	bh=JZ0P1jUJT/JHdrkC2pQPX3089iJixp+OjT43MwzgNR8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jDAG/k2vqSInYQXg4zs7/Ti2UIub4wXyZdaQ0fU6ZTGtEOVjiVC0LxNaDtf6Ieeguhoywx3LH4ZuZMPQ263mX7L1GffcvTdLomt6nLjayCZgA+cWbiy2RvyEadGhNCb2lBXWhJSs8IpKT4aBXc0q5amTm52qMjmbkNqvhIQPi6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mTPQC/TW; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-33ba5d8f3bfso3794490a91.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 03 Nov 2025 05:40:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762177242; x=1762782042; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+8IwqJtA/22JVDtVDWFjIJd2N2jNDTeHgnje61NBmJ8=;
        b=mTPQC/TW205WGM22q1YNn+ndPJrOc6Yjahm5rTeZ0CLzA0C3ZORehURZEkV/qyA4jx
         ML8RGQqdmf68ZoDpjlBVJCYZndBFghHjftPIIGsVBVIhFEPiqBldDefn56V/2kPo4lx6
         dyy3h1DmvC7TBbOYOEBsvwfGS0bfg7kYT8DL1LP/LtICizpMdmV7MAPWJ/7GzcBjgjXl
         og21ElomjErRG678nAYWFEEeWLSCD5FMX/IN7v2wZA+m+2fEDzfIql+2hh07LcqPZclH
         V1tpcDnYGkijZIllr90/FQ5OPQS9iujhJ0+Hm963Hftbsv1loMFjknr1HaPeBTbtIJI5
         ZGrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762177242; x=1762782042;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+8IwqJtA/22JVDtVDWFjIJd2N2jNDTeHgnje61NBmJ8=;
        b=n9qt8Lsm92DCOpH82LTT+s0GhROXDL6axRAfV1mhJms8sKAK1zqGs9XOQQUCqqoEyI
         l/gRs/AMTr6RYfDE1l20qSBYxV9U+gD+OxewFjIGHUk4/E4GotpAiVE6y0SkPv2OxrDq
         3E9ow/9/lufi2R5QfDKZCPRrfqxzNmuiK5M8PYGPMfKHynhNwmlAn3QQR0YgnGmDo3F6
         Ru1bSKBcm1KMx7+UeWDhzSERoSdd8Qfti32+se/pdrUmQCuDq7y2SaQExtLkhvOGp+SN
         lSFGLX2QZkSmgbLgmBEeRmY6Zqdk1zS9A5rJBAgfHKWmAp/iWENtgLv4oiWyqfdLUKYk
         djEg==
X-Forwarded-Encrypted: i=1; AJvYcCVhWwT6zoWOuCEDTMQUyYg8WmhC+v9F6HQw5O5hvFWCa8gQdwRV+YUU4D/xjVfEa06KIKtO2d809GDDB/cD@vger.kernel.org
X-Gm-Message-State: AOJu0YwpyF2VEHdJE9yEB2kuyZ0/zXgpM0VU/673pZmk7jAG5bvgdqSh
	D7hmCFv7tLHXVCGLRxp8QDSe2VJoHhl5411odc5XGoXd5UQAGRGArg8F
X-Gm-Gg: ASbGncte0y6h2M8H8S8+vSIoknw1VRUCv3qdmiWFmiNzTgGmIW0D9CW1cEGLWpUIWKw
	fhF65/MFOso1TAz0f7a7U6phIdfsIMifiG5UdRJ/HfublHAP6ttPyWR7ZblMtQ/lDfcmJS+zeYC
	QHKx8GSz6opMUjFZwwxX76iiEpgcNyMdp7tNi83tv+MzkMW2JmZwgLQ9a7v2vu96ux6KULlkqxe
	Knp+cTbEvSdLWjedan2Ab30F0kkjgOm6jM9M8Qzha3nXGS+ZY/kL+VTrdIRoGqMrW8pgDMLNbsi
	Hqc97NgHnQOV6xsZKu1qDJECEOwMMaPSmUGHOJz7e64puH/1aC5FNJbtzos3ipZAn8QgR39qF9M
	1VDQJQHY1/tTx3lUdwCUxsK2zIv/jS+0GLtWXrHghJNJdywFEco47RW8Xs406sKkIXeZ2y+jUfe
	/y95/oCF9hVR0VO8LQUJWtyhICgBGXNTq60a+gAVM3Sn8mL8WiDB11rqo5rRZuUYNNGTAvV01W
X-Google-Smtp-Source: AGHT+IGpJsA054j4ViTtI38jqwpBxx4LnXSeC5cZfa9rXdhBelszsgUGjl8r93/Fsuxn/l+FZEUG2g==
X-Received: by 2002:a17:90b:2f48:b0:330:bca5:13d9 with SMTP id 98e67ed59e1d1-3408309ae43mr14629306a91.32.1762177242379;
        Mon, 03 Nov 2025 05:40:42 -0800 (PST)
Received: from ?IPV6:2409:8a00:79b4:1a90:5d7b:82d2:2626:164a? ([2409:8a00:79b4:1a90:5d7b:82d2:2626:164a])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3407ef4c263sm5374195a91.3.2025.11.03.05.40.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Nov 2025 05:40:42 -0800 (PST)
Message-ID: <07ab7f80-889e-4a28-adf9-12fc038bdc27@gmail.com>
Date: Mon, 3 Nov 2025 21:40:18 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] fix missing sb_min_blocksize() return value checks in
 some filesystems
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
 Yongpeng Yang <yangyongpeng.storage@gmail.com>
Cc: Namjae Jeon <linkinjeon@kernel.org>, Sungjong Seo
 <sj1557.seo@samsung.com>, Jan Kara <jack@suse.cz>,
 Carlos Maiolino <cem@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sasha Levin <sashal@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, linux-xfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
 stable@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
 "Darrick J . Wong" <djwong@kernel.org>,
 Yongpeng Yang <yangyongpeng@xiaomi.com>
References: <20251102163835.6533-2-yangyongpeng.storage@gmail.com>
 <87cy60idr2.fsf@mail.parknet.co.jp>
Content-Language: en-US
From: Yongpeng Yang <yangyongpeng.storage@gmail.com>
In-Reply-To: <87cy60idr2.fsf@mail.parknet.co.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/3/2025 12:46 AM, OGAWA Hirofumi wrote:
> Yongpeng Yang <yangyongpeng.storage@gmail.com> writes:
> 
>> diff --git a/fs/fat/inode.c b/fs/fat/inode.c
>> index 9648ed097816..d22eec4f17b2 100644
>> --- a/fs/fat/inode.c
>> +++ b/fs/fat/inode.c
>> @@ -1535,7 +1535,7 @@ int fat_fill_super(struct super_block *sb, struct fs_context *fc,
>>   		   void (*setup)(struct super_block *))
>>   {
>>   	struct fat_mount_options *opts = fc->fs_private;
>> -	int silent = fc->sb_flags & SB_SILENT;
>> +	int silent = fc->sb_flags & SB_SILENT, blocksize;
>>   	struct inode *root_inode = NULL, *fat_inode = NULL;
>>   	struct inode *fsinfo_inode = NULL;
>>   	struct buffer_head *bh;
>> @@ -1595,8 +1595,13 @@ int fat_fill_super(struct super_block *sb, struct fs_context *fc,
>>   
>>   	setup(sb); /* flavour-specific stuff that needs options */
>>   
>> +	error = -EINVAL;
>> +	blocksize = sb_min_blocksize(sb, 512);
>> +	if (!blocksize) {
> 
> 	if (!sb_min_blocksize(sb, 512)) {
> 
> Looks like this one is enough?
> 

Thanks for the review. Yes, blocksize doesn't serve any other purpose. 
I'll remove it in v2.

Yongpeng,

>> +		fat_msg(sb, KERN_ERR, "unable to set blocksize");
>> +		goto out_fail;
>> +	}


