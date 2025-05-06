Return-Path: <linux-fsdevel+bounces-48161-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17966AAB9B4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 09:02:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C2213AB4BA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 06:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16B2C223300;
	Tue,  6 May 2025 04:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GSoEwn2b"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3F02FECFB
	for <linux-fsdevel@vger.kernel.org>; Tue,  6 May 2025 02:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746497936; cv=none; b=CqQEu+1AfCb7jNF3sUYgSQDjT7Ehx9yohpVVv0iPuQDDzLBeBUhI64jD+nDrx3fD0l7/Mpv73+zBj5yImTAigEQfR24DPvrdzldp3n8qVuIgjA/hm6oTSTD9zpuQQ89Bj1MVJss+1OdcHWlSgchgZGc14kHI/1SiuAEJJTHvfGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746497936; c=relaxed/simple;
	bh=9JcClZk0+gnvRfYDgRN4RZ+yOXRchbnML0kEvhpXi2I=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ZiHtI66vYKwxJSZYG4bYpERk06KXMca6z6Jid7HbcsL9hLoyPcWKfhS/lmsyRkX6EMYaP1SclAlXZTiUVqghato6ycfmsyF97WV8EVRakfDAxEbsTEWgCpPWtVC3NRcr9egGwp+8lgNX2b0zuPe0y0l1OUNwTRWD9oxFH/MvsIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GSoEwn2b; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746497929;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Et8TCn0u/SHrBh2poXeA0ZCHndWgAtXK+u08Te8MVs0=;
	b=GSoEwn2bwVs/gCTE9iJ1bHJFC2dCb62k2A2vbZjfoydFtSxXt8fRY07l6WRJXJANN9IFwt
	IpRhI/QQtzdvQ2/F6mWjiGvVrJrOni8uGd8iNURUvoNEnM7TIxGrlzqz+gbgpSdkGqWJ3T
	O2l1LQvj/v2IxkjV9sTYcQFiz4m3X44=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-532--1f1DjYqPG-UDJ-tAeNvcg-1; Mon, 05 May 2025 22:18:48 -0400
X-MC-Unique: -1f1DjYqPG-UDJ-tAeNvcg-1
X-Mimecast-MFC-AGG-ID: -1f1DjYqPG-UDJ-tAeNvcg_1746497927
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-86195b64df7so945961539f.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 05 May 2025 19:18:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746497927; x=1747102727;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Et8TCn0u/SHrBh2poXeA0ZCHndWgAtXK+u08Te8MVs0=;
        b=UO0yF0Ett3+kKvVPqgQIr3it3XecbvzgH9ve5YtYfj6rIQYAR1eaFCIvLta4gui6Xs
         hvFNPDumUnD2C3BPicDa1IO2gCWEpYU3OkYYlLVndz02ltE/rY6Y3caEsdscIhKSggva
         zW3thGZXh03hhnSw02uNPcflT9oh3ti4/oX10sBhgB8FXbu46+b7Hk9PcIW2tX+FkH8F
         4S8Bdu8oOePi3VQzNFZkVZYhnafDp3qipTk8h6+ovfSWUfZSoXioJh9u707wCHU2Kb+L
         QuG9ziJtrjd2rULGZ67Bsgr4qy/LA7V3+gWwUe+0iFsivRS+vZrwAm/9U8zQjSrAZJY1
         6u5A==
X-Gm-Message-State: AOJu0Yz0SjalisayWW0zQbtfMg8yD9/Rc7zboBFyr6VzqH6i0a9RVNRP
	ykfI/kEFmrcQhVtEgH0E61qZHwFrHGILO9U56Be4ADBgsMsZUMdNsPqOs9+srpQ4BrU0qbWBMzY
	pSBRzF06Sxo8m7a1fuVewIDON/gwX+2i2IR/ZsYaC26s7FX/RDYkr4lP7l3RXzmA=
X-Gm-Gg: ASbGncvfqU4VfDbpUnkzLSMJ4bbUiyhoSWo0bvWoEOhtDFqWoCysZXNvb7Pk0J64V6g
	7h5vkZ63P/A7aqPVF5UGGKvaNhZnOKNEM99deFGb7j7VVYCoEbEcSqH45YScklMT82S4vYk8U1Q
	MdMUlgNHUVBnuiCDcDru+6C+u8h9FFc2JxXzRw0JQ3B5gg8sh7Eyv2saW1QT+auhcoP9n97+CA1
	V3fL6TgcSdndzJ5RGeEvOR/tUCbLGVxltfLwL5hOdbD9Gb0OY63igQghQuuI9aK4DD0yH/Kc03G
	1mIZgN00UZk5J0D0nRsdJyVOXZHp6TZLGRvu0CaLUd3Mzi2sDg==
X-Received: by 2002:a05:6602:2d85:b0:864:4a82:15ec with SMTP id ca18e2360f4ac-86713adb682mr1151076139f.6.1746497927414;
        Mon, 05 May 2025 19:18:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHzSxB1we3zK5o9gdf7WMzlE6y+dZ6hnjVVgqV7oycZj2oSqm1Nm3N1QL+RrYBY23ySthgLlQ==
X-Received: by 2002:a05:6602:2d85:b0:864:4a82:15ec with SMTP id ca18e2360f4ac-86713adb682mr1151075039f.6.1746497927070;
        Mon, 05 May 2025 19:18:47 -0700 (PDT)
Received: from [10.0.0.82] (97-116-169-14.mpls.qwest.net. [97.116.169.14])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-864aa2bb423sm200783839f.4.2025.05.05.19.18.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 May 2025 19:18:46 -0700 (PDT)
Message-ID: <b673458e-98b6-42ad-b95f-7a771cd56b03@redhat.com>
Date: Mon, 5 May 2025 21:18:45 -0500
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 0/7] f2fs: new mount API conversion
From: Eric Sandeen <sandeen@redhat.com>
To: linux-f2fs-devel@lists.sourceforge.net
Cc: linux-fsdevel@vger.kernel.org, jaegeuk@kernel.org, chao@kernel.org,
 lihongbo22@huawei.com
References: <20250423170926.76007-1-sandeen@redhat.com>
Content-Language: en-US
In-Reply-To: <20250423170926.76007-1-sandeen@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi all - it would be nice to get some review or feedback on this;
seems that these patches tend to go stale fairly quickly as f2fs
evolves. :)

Thanks,
-Eric

On 4/23/25 12:08 PM, Eric Sandeen wrote:
> V3:
> - Rebase onto git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git
>   dev branch
> - Fix up some 0day robot warnings
> 
> This is a forward-port of Hongbo's original f2fs mount API conversion,
> posted last August at 
> https://lore.kernel.org/linux-f2fs-devel/20240814023912.3959299-1-lihongbo22@huawei.com/
> 
> I had been trying to approach this with a little less complexity,
> but in the end I realized that Hongbo's approach (which follows
> the ext4 approach) was a good one, and I was not making any progrss
> myself. 😉
> 
> In addition to the forward-port, I have also fixed a couple bugs I found
> during testing, and some improvements / style choices as well. Hongbo and
> I have discussed most of this off-list already, so I'm presenting the
> net result here.
> 
> This does pass my typical testing which does a large number of random
> mounts/remounts with valid and invalid option sets, on f2fs filesystem
> images with various features in the on-disk superblock. (I was not able
> to test all of this completely, as some options or features require
> hardware I dn't have.)
> 
> Thanks,
> -Eric
> 
> (A recap of Hongbo's original cover letter is below, edited slightly for
> this series:)
> 
> Since many filesystems have done the new mount API conversion,
> we introduce the new mount API conversion in f2fs.
> 
> The series can be applied on top of the current mainline tree
> and the work is based on the patches from Lukas Czerner (has
> done this in ext4[1]). His patch give me a lot of ideas.
> 
> Here is a high level description of the patchset:
> 
> 1. Prepare the f2fs mount parameters required by the new mount
> API and use it for parsing, while still using the old API to
> get mount options string. Split the parameter parsing and
> validation of the parse_options helper into two separate
> helpers.
> 
>   f2fs: Add fs parameter specifications for mount options
>   f2fs: move the option parser into handle_mount_opt
> 
> 2. Remove the use of sb/sbi structure of f2fs from all the
> parsing code, because with the new mount API the parsing is
> going to be done before we even get the super block. In this
> part, we introduce f2fs_fs_context to hold the temporary
> options when parsing. For the simple options check, it has
> to be done during parsing by using f2fs_fs_context structure.
> For the check which needs sb/sbi, we do this during super
> block filling.
> 
>   f2fs: Allow sbi to be NULL in f2fs_printk
>   f2fs: Add f2fs_fs_context to record the mount options
>   f2fs: separate the options parsing and options checking
> 
> 3. Switch the f2fs to use the new mount API for mount and
> remount.
> 
>   f2fs: introduce fs_context_operation structure
>   f2fs: switch to the new mount api
> 
> [1] https://lore.kernel.org/all/20211021114508.21407-1-lczerner@redhat.com/
> 
> 


