Return-Path: <linux-fsdevel+bounces-39414-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C8A1A13DD8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2025 16:38:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 288E83A0466
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2025 15:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B92E022ACFD;
	Thu, 16 Jan 2025 15:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ioFIm0kR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E3F1DE881
	for <linux-fsdevel@vger.kernel.org>; Thu, 16 Jan 2025 15:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737041893; cv=none; b=oJmAwMs/0KmvWQs1pD0AFe4Xxj451LnA56BjtNCNr6+CWKASLdk9szjysFFMa2Z4E0XxH9X522kbC1dR0BOAmPnBm6P9tG/wD6f94cZTF63L0mMuovKD1HyHveLfCnlE23IzVYPbxeP9ABrCd8X0t78BH0GvjpjcK2He8R7t6oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737041893; c=relaxed/simple;
	bh=kp/3kdPV+ibpPsVyqmecaumGt7nXvjh3BdWYF7G8mnQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UsSHwp1Ow0MmYK+uhBiMSHia3nyXBjH1kH9A05eow7gt1dU3bm8hd9ZeO7DOkmB+F8+u9PurMqXPeDgJy+UxZz28pLPLgK8Hb49SITJhWxjzLLXgZhTNr493cneo5CjVya9sYu18yBjcHHomlFtYJrOW68266doX1hDRFc/WYKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ioFIm0kR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737041890;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qg2b8+LB1OTrdCNXh9fJDT5jAwBpmW2na19qSENGMOo=;
	b=ioFIm0kRml651wQa71YggeJ2BOvJUuX99N/ykugApTiTDD7BNb8Su0q1k7I2Pm8WXQx5iY
	sJP7+JNw5TD0YPp4WuaOZBt0YEfIUirr3eE5zfaFuubZCQPdjgR5aqZ4DaYDPzzTf7cThz
	s0etDm7B3DZkb6/gxBKcwcqi/L/3AGY=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-299-1MTTHZh_MFeqrX2B5FoNJA-1; Thu, 16 Jan 2025 10:38:09 -0500
X-MC-Unique: 1MTTHZh_MFeqrX2B5FoNJA-1
X-Mimecast-MFC-AGG-ID: 1MTTHZh_MFeqrX2B5FoNJA
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a9d57cff85so19326275ab.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Jan 2025 07:38:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737041888; x=1737646688;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qg2b8+LB1OTrdCNXh9fJDT5jAwBpmW2na19qSENGMOo=;
        b=W9RTYhNXiMtMFVpl8MHHBQlsEaMQygwi619+LEvTYBDoq3t1JxvS3lSS8tBIgVsDXG
         ldnxpFTi+RlIx5Tf1yUb9m0pBrEKk6BrdJvoNi2YcgJaRlweiW02W/ocTk507qRHjbht
         5uoUPLaJR9yuXMFAsiY9jWn2UYDFAoJdgQD7DikotXnUjzc5P9op+LHCj6y6sKngRBd2
         VKtXTKOlgULsnHSwRAGkITNkFZYAMxgGrd38Q/QADvjraPYX/EZmBFS6fCkYDZcPx0Sg
         NycPLsqWQLxrKFBrC92n9EroFspzLTM2TmnNtciFCbz+oqcZ010JdMeBRKwivAYHUDYG
         87YA==
X-Gm-Message-State: AOJu0YxqzwlEUWMlcJOi54ckupfJL5sAr0q4N8BNH1nfiUMcD0f3yjJP
	NQfPzfXCcChQ7Mr8fUWkdijrveC7GBgLo4SxhNA4PEKq2YcUAARZaxgQ+ib9JTwziOF1w7vITYa
	L/cuq2qntdF1VBIsBtaNImNU3zfz/sU/0J3fMOO5cC3973batPS8aXV3Sc9xVYEw=
X-Gm-Gg: ASbGnct9vWOwgND5pPOtwcfc3fFUWPoNRyXISr92LWtknUIP90D5VNt5zZPbBeu7SpZ
	xFNjKPBe3I04Sn8OJtifubsBg31H5ExhF5djuw0Ir2ViEnXnP6IMV1i3ZhKuzzJXYad85Eyec8o
	z1LR4NEuYkloBzLY6QSwYw8RWau/Q66w1ubpRoUk9mBdCvBvVZsw9RgLhlaZ8H3XMFrO7T9iCw8
	vm5+S0tUTl9utTlMkD27FiA7e6re083AmGXdYq1I5xdIJaPbUeE/aIcScKsm/gFROinQXQ4o91u
	UtolfseXcvMI9ZR8Tq60
X-Received: by 2002:a92:cb84:0:b0:3ce:4bc8:7844 with SMTP id e9e14a558f8ab-3ce4bc87dd1mr179796645ab.4.1737041888357;
        Thu, 16 Jan 2025 07:38:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGYDSg2vho8vbKJnY/FXCyAKIqg3/9sj4TyIheddz/qkeiQ7VRaR3M/Q3MlaY0qcaXjSCmq3g==
X-Received: by 2002:a92:cb84:0:b0:3ce:4bc8:7844 with SMTP id e9e14a558f8ab-3ce4bc87dd1mr179796555ab.4.1737041888066;
        Thu, 16 Jan 2025 07:38:08 -0800 (PST)
Received: from [10.0.0.48] (97-116-180-154.mpls.qwest.net. [97.116.180.154])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ea75440a2fsm76767173.45.2025.01.16.07.38.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jan 2025 07:38:07 -0800 (PST)
Message-ID: <efb93d2c-c48f-4b72-b9fd-09151d2e74d6@redhat.com>
Date: Thu, 16 Jan 2025 09:38:07 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: mount api: Q on behavior of mount_single vs. get_tree_single
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, David Howells <dhowells@redhat.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>
References: <732c3de1-ef0b-49a9-b2c2-0c3c5e718a40@redhat.com>
 <20250116-erbeben-waren-2ad516da1343@brauner>
Content-Language: en-US
From: Eric Sandeen <sandeen@redhat.com>
In-Reply-To: <20250116-erbeben-waren-2ad516da1343@brauner>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/16/25 4:28 AM, Christian Brauner wrote:
> On Wed, Jan 15, 2025 at 10:50:31AM -0600, Eric Sandeen wrote:
>> I was finally getting back to some more mount API conversions,
>> and was looking at pstore, which I thought would be straightforward.
>>
>> I noticed that mount options weren't being accepted, and I'm fairly
>> sure that this is because there's some internal or hidden mount of
>> pstore, and mount is actually a remount due to it using a single
>> superblock. (looks like it was some sort of clone mount done under
> 
> Yes, some legacy filesystems behave that way unforunately.

Is it not the case that every current (or past) user of mount_single
behave[sd] this way due to the internals of mount_single()?

gadgetfs, configfs, debugfs, tracefs, efivars, openpromfs and more all
currently call get_tree_single (and used to call mount_single, which did
the reconfigure for them).

Or am I missing something?

...

> I would think we should make this the filesystems problem or add a
> get_tree_single_reconfigure() helper that the few filesystems that need
> this behavior can use. Thoughts?

I wasn't seeing this as individual filesystems needing it, it looked to
me like every filesystem that used to call mount_single() automatically
got the behavior. So was looking at this from a consistency/regression
POV.

While it seems odd to me that mounting any "_single" sb filesystem would
reconfigure all of its current mounts on a new mount, that's the way it
used to work for everyone, as far as I can tell, so I was assuming that
we'd need to keep the behavior. But if it's a question of just fixing it
up per-filesystem, I don't mind going that route either.

Thanks,
-Eric


