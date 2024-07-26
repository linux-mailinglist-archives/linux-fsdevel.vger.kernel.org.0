Return-Path: <linux-fsdevel+bounces-24285-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41E1093CC8D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jul 2024 03:55:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AA731F221E8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jul 2024 01:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 011BE19470;
	Fri, 26 Jul 2024 01:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="XKszq6Xq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2DB817578
	for <linux-fsdevel@vger.kernel.org>; Fri, 26 Jul 2024 01:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721958934; cv=none; b=mCKQX5hcpXXZCpfYSTenHrCMxo4Z9AEX0y3rbp/uQqnq9aoeeuTCKDkExWL4RMo7vIqNaabqUUAwlqvwSvY1tt4uCTqY0ZPmZ6GuruCT8b7p5+UORHGSYfY3NR88F+rutFRtwl/2HVn7JhQjsQlIsH6yw+nZFnVarHOLr0YyOZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721958934; c=relaxed/simple;
	bh=WYqZridchZzfdN6QnNSxKIdLAnZBSVIQm81qtZ+/BJo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MELNKyJZJxtu1a+roJJgq0IwHS+88Z7K87TbAK02RuxfQcLdMxc4Sp7HkY7VG1Or/IaDa2EA6UTu/Qs9BSdkBzkcCXKffmMVi8J74JR3GGhwakUG1GuFd6F39H5DNbfnMGhSwVtjDPR3XwnKphgSOh5tFQJg5q7LSYlhqXYebyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=XKszq6Xq; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3db1d4dab7fso13540b6e.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Jul 2024 18:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1721958932; x=1722563732; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lwZLflB06V4tnnB1EWMignUoULBKSrqsfwebBDmI2fA=;
        b=XKszq6XqcG1sJjOBOaUlzpYQurFzlqo5ErX82NJlEZgwnqUSPe43kKvM8SZ42c4+z3
         Y/Z4abuhOL802P0xJWpDTjc/8fMHlTpkreFnZIPn3CWMJVNjnZGmgEiyzNBVX0eWI7+V
         gXvYd98jdWd4ifiirAhvo5GtBiVvsUoSZjBcLuLxrfkJlcxaSAvxoGrRUa0NVtx60ozL
         lDJmNEpdMt1H5+tFj/KARnUmYbMY58ZB5TtKaVhYsvmqNYDFFxmQYs3VclMO3BGh4vwK
         42OV354ErYYJQepZsRRszH2N/nM5ORMDcdQuecRyWRg2PmKKBnVLQF/wM2HklbwiJ4aM
         ZTPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721958932; x=1722563732;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lwZLflB06V4tnnB1EWMignUoULBKSrqsfwebBDmI2fA=;
        b=CgacozYOF1RBtXjN39cuyplPdTy3YgQ4wk8zB0trdWQHbFI+Tsiy8uqgqH3VrAUfPE
         lefe35Dt9byLzBfg7377okuSdazAEZz1tZ/nyzuQU+rUuE9cNVb3eQfFBr3w+DwIR5ka
         pCO77VBlW54vbiCgcrllK01CmxJuQrOmabQlTdgQY4wv1VAbmp2Cl9JIsV6SNAF5AHPm
         NR4n8h5dQP3uRZiQXRqjLxBe+8ySp8XI0Us3qWJ4mHA3Aub1MIUfIu8HGr/JihGRa4fG
         bAVvRUE2JjMHM21V4IaANEvoLBaZ7aiNvF5TouwCdoUs1DEOepk/FuSganUYRFkyNTqc
         IgDw==
X-Forwarded-Encrypted: i=1; AJvYcCXQdAd+cgolnP2YBcE9fzag+LyLLsvMzQjX1fTDwgUNHZ93hDQdKsTCmYfZlBLhRhANityMehd43WtoEOTMGG7/ulzlS5AOZ3V9J4RoVA==
X-Gm-Message-State: AOJu0YzTHt17Zy+v7j3Kf/+ZUJMxg7EO0cPWciEVUH5Dzo4vt4RVsKwa
	AQ6ENl/PaJk8X68egVk1c+m7hwbZjtNzNhqX0E0RkyHLDBoJ3ESDvhyWOItkd48=
X-Google-Smtp-Source: AGHT+IHfvKlhTS94BpVJJTIAh0iHmmNCdLG03YYWoEQxpyHfOQ6GoTN0j7Qeo4O9DHpwZL4tivVUzQ==
X-Received: by 2002:a05:6808:1449:b0:3db:31b:1d5b with SMTP id 5614622812f47-3db10ef676fmr6465894b6e.13.1721958931962;
        Thu, 25 Jul 2024 18:55:31 -0700 (PDT)
Received: from [10.54.24.59] ([143.92.118.3])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7a9f7c73cffsm1539945a12.8.2024.07.25.18.55.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jul 2024 18:55:31 -0700 (PDT)
Message-ID: <ed6f4fc6-bde5-4b04-badc-c4927334f766@shopee.com>
Date: Fri, 26 Jul 2024 09:55:26 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs: don't flush in-flight wb switches for superblocks
 without cgroup writeback
To: Jan Kara <jack@suse.cz>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, tj@kernel.org,
 axboe@kernel.dk, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240725023958.370787-1-haifeng.xu@shopee.com>
 <20240725084232.bj7apjqqowae575c@quack3>
From: Haifeng Xu <haifeng.xu@shopee.com>
In-Reply-To: <20240725084232.bj7apjqqowae575c@quack3>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

             

On 2024/7/25 16:42, Jan Kara wrote:
> On Thu 25-07-24 10:39:58, Haifeng Xu wrote:
>> When deactivating any type of superblock, it had to wait for the in-flight
>> wb switches to be completed. wb switches are executed in inode_switch_wbs_work_fn()
>> which needs to acquire the wb_switch_rwsem and races against sync_inodes_sb().
>> If there are too much dirty data in the superblock, the waiting time may increase
>> significantly.
>>
>> For superblocks without cgroup writeback such as tmpfs, they have nothing to
>> do with the wb swithes, so the flushing can be avoided.
>>
>> Signed-off-by: Haifeng Xu <haifeng.xu@shopee.com>
>> ---
>>  fs/super.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/super.c b/fs/super.c
>> index 095ba793e10c..f846f853e957 100644
>> --- a/fs/super.c
>> +++ b/fs/super.c
>> @@ -621,7 +621,8 @@ void generic_shutdown_super(struct super_block *sb)
>>  		sync_filesystem(sb);
>>  		sb->s_flags &= ~SB_ACTIVE;
>>  
>> -		cgroup_writeback_umount();
>> +		if (sb->s_bdi != &noop_backing_dev_info)
>> +			cgroup_writeback_umount();
> 
> So a more obvious check would be:
> 
> 		if (sb->s_bdi->capabilities & BDI_CAP_WRITEBACK)
> 
> even better would be if we'd pass 'sb' into cgroup_writeback_umount() and
> that function would do this check inside so that callers don't have to
> bother... I know there is only one caller so this is not a huge deal but
> still I'd find it cleaner that way.
> 
> 								Honza
> 

Yes, Thanks for you suggestions!

