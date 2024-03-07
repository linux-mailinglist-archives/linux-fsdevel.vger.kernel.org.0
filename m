Return-Path: <linux-fsdevel+bounces-13890-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C780875280
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 15:58:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8EDCB227EB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 14:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 369AA12D775;
	Thu,  7 Mar 2024 14:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dXCZz9i/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE30804
	for <linux-fsdevel@vger.kernel.org>; Thu,  7 Mar 2024 14:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709823495; cv=none; b=ZeEwQEJW7eT8KLUFjE9MgcopqsviALlp1W3V0dd2/EXN7g+6Y4bU2kFnWXker0HY5s7pXTa8mVmXJst3Xu7vT8BQQGoXKVf60wEyqkJXpApMWAsy5N52hpBkgO5dGUMi1/i4tXUSELkCBZujiJ4B43scpkbaYHcxieJib9woxR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709823495; c=relaxed/simple;
	bh=wAELNV5JCtMGbJAvBoPHvfVKPBWW7QdcrsQlu/7tCjI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kCaG6EZRXyLJIF4APuDecclhubeswVwPL5oBABB1cwQtIDTI34vrVgaJEG/VSqmiELsJzIwQM4hEAfIPNY99y9IYcelpb7vu70Ggmhov9VRU2fkn+M4fNn80PQ8d8UjFO4WvO97Fcvs8wjaAvTr8xaTPl/WU5N/INPc1hB4Y0zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dXCZz9i/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709823492;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3w+m1DxomiASBkSs9j7Ponw1vJhDMxKwapO3O06VGwk=;
	b=dXCZz9i/qp7qBWdU7dOSB04YYbtbFb/QQwI9ePhJItC3rhWFGP/9rEs8XgTqEltqukio56
	dyavpCgbqKMXRORhqUTfnUXug090CxbhVui3K3x+LAYV/aPrrF3JnN2EmD9hHi6pxG2Jow
	onQCfdSDplMEZ/Z4dKhpeAEbzYykUX4=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-DMf74nlLOKuydLmIBeKJPg-1; Thu, 07 Mar 2024 09:58:11 -0500
X-MC-Unique: DMf74nlLOKuydLmIBeKJPg-1
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3657cf730a0so8437225ab.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 07 Mar 2024 06:58:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709823491; x=1710428291;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3w+m1DxomiASBkSs9j7Ponw1vJhDMxKwapO3O06VGwk=;
        b=mqp/8heKj3QQU1d/hb7mxnncnjzgE2qxlMfWflFRmQOOkLlAnUMl43LSNyXnh82PtA
         ckl2qhzZlFu6ZkWhxiPHq1tteWwZIH5YwWcKEi9uHVCDse4oZjobtRbvC9+VSSRJaIMx
         J3mbIdZm+GE3vTJoKLTyv5AH8iVEp/sYKb/GVNahrD/qrTix17u7VFduwP7I81u7KDqO
         8DpGsNsQf+qt6PlC22vHClrXDNCfHDTL0uyLe15x98ISCzsEow2MVgESI8n1zEM5pZmz
         HWli6w3izXM/DIgjiCDqhucgXi5uN0yF4aWWT7Jt6ZWQEv5USTVFcLrAn8a0993Buqgc
         IQtg==
X-Gm-Message-State: AOJu0YyqbA/t2f8Zw0XkIpgLJECUNUZXsYVea1MxMVdU8ulnFgeECc0H
	xbMIRj9v75m/YophC+1WFEBxuOB1rpjbchd00eX26bJl+VKeE/aWxbSN7Uw+TIDbCUSkD8JHU3E
	4ajJ8FiSkB2+mSqhibHKHypORpNnOXSB9HwQ3499aw4WQWxSkxfJdTrB+v/FGCf4=
X-Received: by 2002:a92:c9cb:0:b0:365:fe08:6c6c with SMTP id k11-20020a92c9cb000000b00365fe086c6cmr8067044ilq.5.1709823490969;
        Thu, 07 Mar 2024 06:58:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHU74Llt3qX5vrkfNAJ2OGNvlMMdKtD9onXvU7hwg9skny605NdGbjFMz0exDU5lO8PysFDHg==
X-Received: by 2002:a92:c9cb:0:b0:365:fe08:6c6c with SMTP id k11-20020a92c9cb000000b00365fe086c6cmr8067035ilq.5.1709823490689;
        Thu, 07 Mar 2024 06:58:10 -0800 (PST)
Received: from [10.0.0.71] (sandeen.net. [63.231.237.45])
        by smtp.gmail.com with ESMTPSA id w1-20020a056e021a6100b003657e2aee61sm4103381ilv.34.2024.03.07.06.58.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Mar 2024 06:58:10 -0800 (PST)
Message-ID: <b0cbbb5e-15ec-4e29-a79c-1b5fc18ecc24@redhat.com>
Date: Thu, 7 Mar 2024 08:58:08 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] isofs: convert isofs to use the new mount API
Content-Language: en-US
To: Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, Bill O'Donnell <billodo@redhat.com>
References: <f15910da-b39e-44ff-8a2f-df7ce8c52057@redhat.com>
 <20240307124225.gm2d4dkscbcg4kt2@quack3>
From: Eric Sandeen <sandeen@redhat.com>
In-Reply-To: <20240307124225.gm2d4dkscbcg4kt2@quack3>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/7/24 6:42 AM, Jan Kara wrote:
> Hi Eric!
> 
> Thanks for the conversion!
> 
> On Fri 01-03-24 16:56:41, Eric Sandeen wrote:
>> -static int isofs_remount(struct super_block *sb, int *flags, char *data)
>> +static int iso9660_reconfigure(struct fs_context *fc)
> 	      ^^^ Why this renaming? Practically all the function have
> isofs prefix, not iso9660 so I'd prefer to keep it. Similarly with other
> vars defined below. If anything, I'd rename struct iso9660_options to
> struct isofs_options...

I don't remember ;) I was thinking I'd seen both used. Happy to keep everything
as isofs.

>>  {
>> -	sync_filesystem(sb);
>> -	if (!(*flags & SB_RDONLY))
>> +	sync_filesystem(fc->root->d_sb);
>> +	if (!(fc->sb_flags & SB_RDONLY) & SB_RDONLY)
> 					^^^ What's this about?

a braino, oops.

> Otherwise the patch looks good to me!

Will get V2 going shortly. Thanks for the review!

-Eric

> 								Honza


