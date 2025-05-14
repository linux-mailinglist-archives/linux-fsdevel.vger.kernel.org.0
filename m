Return-Path: <linux-fsdevel+bounces-48976-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EF07AB7043
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 May 2025 17:47:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B20881BA2470
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 May 2025 15:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17F121A841E;
	Wed, 14 May 2025 15:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LHTDyyzK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED659AD51
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 May 2025 15:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747237645; cv=none; b=qPYTIjDQUz1uf1W1S0SZ/5fqlVw9Y1gNxLOx3d0e5p3gV4ZUSQllRG8yH0c/rhjiiqEJSiZ4TlsiW7qmupobyONX3Y9DIQh5X5FG5c1XtX1Y6WDDClHS0rg56VIXly+wFRDeiQklmMRtCpPpNoZzXbYRNdyMFZuhh+J1lwQpJAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747237645; c=relaxed/simple;
	bh=rdgz0wibDum2K8DXcighb/oixmpausKov2e86qgU120=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MH+C487G0jq/tsFstLJZAjrntpFO76iZSMV62F2pcTBOSFp5pGm81aGqk1iAhLyMCTcTUroPmRTdFXvCaWQ7gCiPKoiX1YGeqkZMEqT+41Q06TphT+LQyY2ODPOyCjKuvvYme7U0spwDLJEGL34aqDqOu4u1sRttc8Vs4ZuRNEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LHTDyyzK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747237642;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jU28VTGkYq3grG2ezVmpkoqsdw/v8m5FZ2T6NAgVL7A=;
	b=LHTDyyzK+NBaoLjTPlcDSvs1CvJwPquKvDr7r8xd0GGxfLYxG2VBHHrecVWXUf2UjRnwf3
	BpGihETxeK6OxtkTYtCCR8ewwYEiVdDXQgEgveMwHMVd4P/Cv8xYiRocLhR1GuyTCyV23z
	BkWq0ge47plVHkgtU6D0xnLvr8TJZIQ=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-335-U8U2DmfbOqqgV4Xw1I55nw-1; Wed, 14 May 2025 11:47:21 -0400
X-MC-Unique: U8U2DmfbOqqgV4Xw1I55nw-1
X-Mimecast-MFC-AGG-ID: U8U2DmfbOqqgV4Xw1I55nw_1747237641
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-72bc289077fso7858072a34.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 May 2025 08:47:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747237641; x=1747842441;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jU28VTGkYq3grG2ezVmpkoqsdw/v8m5FZ2T6NAgVL7A=;
        b=QmPUi3hwv1ED8mRhD4B3FqP5ZNEaYt9GsYW/GPLzm2VDcobRfcKRHWvvfCU5JJFo0I
         t4ZQ79UbKORDQqPzfWTh83oyStRoCfQqlHNhwQPfbxVYnSKGUJ+fUK4+oKT9a82fRdqK
         IGGM0wySP6dxMHtujbY6+D02Ja8mSEmUn2bf/MhtMBk1XXJBWz49z233k9meQis+OxJy
         nszTiJ25EfphLaAFm28xmiBAskBzR1FQeYPE5h1mh24YdguyioxlL1Y+V/LNlPdmN07p
         vIV4D39Hqh3hGTZxThcLdKVUrszAsuFj9garoe8+TchxVlQcglPuMwJi+F4jBtnjZTZi
         8YsQ==
X-Forwarded-Encrypted: i=1; AJvYcCU82SDISDfSZr02a8GF0dGXdmFSguKyKDAtL8VpxDCuuEQrflk9Q3PwjjaxirND4CV7+6RzUHW7fbIDy5AY@vger.kernel.org
X-Gm-Message-State: AOJu0Yws8gQhCuqI5VIQETW0Kr0vQ3oehJBkYJkNxNRnuPH2ONs5J4kj
	ZE6kVjt6fWD+Vmn8/zlwZWQMeXaeji6176gRJXAu4aMQ+3mVgG8ZB3SzHt9JzJ8JwJJat1snEGr
	2jCYSbyKQs1cxJ+DKY8i5Cw7B4/gexHekU+s0oqHfwfDxWjL3LjhYSQLLlk/iZzaO2i3X/hzdSQ
	==
X-Gm-Gg: ASbGncsuVA8NrYnQQAXejCqdXhacEYe7Xc1rpghHGWkOfcM2deDsP2i6+C/QngeA3Md
	asLOefyLG3UbPojeOZR93e+ucVMae/2yzASz019PVBf6zLsOFuYSdjDPu9VIz26XLSZYQ7M1KNi
	YU+i+12F+Z1b66pYdhwYvS/ev5ygPeYqpjBgbmBogKhtWkRr7B5llz6fHeJDqpsUtLcuylKnWdb
	Q2+Cyy+tiTMNZ6iL0qxP2YEYFAFvHBM6GWuKdziGjG2y4R+ckGKeTaCboG6BRdTtWI8G/1ccu45
	o3iJb6ty6UU+HUs/VYGgHBfo7g==
X-Received: by 2002:a05:6e02:1541:b0:3da:7cb7:79c with SMTP id e9e14a558f8ab-3db6f7bcd95mr38635835ab.13.1747237630420;
        Wed, 14 May 2025 08:47:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEIDAy+HmwZb2EsEeKV8L3mmlCckkvW79UY/GUeR7NNUr5jpZc1ELCAL2keTsiIBmKvh647UQ==
X-Received: by 2002:a05:6602:408a:b0:85b:3f06:1fd4 with SMTP id ca18e2360f4ac-86a08e501a6mr479793839f.9.1747237619557;
        Wed, 14 May 2025 08:46:59 -0700 (PDT)
Received: from [192.168.1.112] ([75.168.230.114])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-8676356c914sm274685239f.7.2025.05.14.08.46.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 May 2025 08:46:59 -0700 (PDT)
Message-ID: <77ba158a-86f4-4a55-867e-f27a55818b2e@redhat.com>
Date: Wed, 14 May 2025 10:46:58 -0500
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 7/7] f2fs: switch to the new mount api
To: Jaegeuk Kim <jaegeuk@kernel.org>, Hongbo Li <lihongbo22@huawei.com>
Cc: Chao Yu <chao@kernel.org>, linux-fsdevel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
References: <20250423170926.76007-1-sandeen@redhat.com>
 <20250423170926.76007-8-sandeen@redhat.com>
 <ff2c9a74-f359-4bcc-9792-46af946c70ad@kernel.org>
 <63d1977d-2f0b-4c58-9867-0dc1285815a0@huawei.com>
 <979015aa-433d-4057-a454-afaea2c68131@kernel.org>
 <2ea178cb-1ed3-40ba-8dc6-8fa3bff06850@huawei.com>
 <aCS3LZ3IOMgiissx@google.com>
Content-Language: en-US
From: Eric Sandeen <sandeen@redhat.com>
In-Reply-To: <aCS3LZ3IOMgiissx@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/14/25 10:30 AM, Jaegeuk Kim wrote:
> Hi, Hongbo,
> 
> It seems we're getting more issues in the patch set. May I ask for some
> help sending the new patch series having all the fixes that I made as well
> as addressing the concerns? You can get the patches from [1].
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git/log/?h=dev-test

Apologies for being a little absent, some urgent things came up internally
for me at work and I've had less time for this. I'm planning to get
back to it!

It's been a long thread, perhaps we could summarize the remaining questions and
concerns?

And I'm sorry for the errors that got through, I really thought my testing was
fairly exhaustive, but it appears that I missed several cases.

(To be fair, f2fs has far more mount options than any other filesystem, and
combining that with on-disk feature variants, it is a very big test matrix.)

Thanks,
-Eric


