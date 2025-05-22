Return-Path: <linux-fsdevel+bounces-49698-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D2AA5AC16FE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 May 2025 00:49:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A3211C036D6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 May 2025 22:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3DE729A9C7;
	Thu, 22 May 2025 22:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PX9kju42"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E8529A32B
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 May 2025 22:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747954187; cv=none; b=ifPitFud1C7SjF/qWxC4SWMrPNMeDRMEusrhuvfr4gZaxLoj2tuYjCUP/5C9WF/iRqhLL9B6HPlE9YmGG3fTLZAV7ZsolCpguW2VLcpwsYC1SZFR6q3b7B+IRbSqNOJt8PU74TkLI4iEwVBGtU+R6hioassD3XU5C5n6OJ2Z0Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747954187; c=relaxed/simple;
	bh=MpOiOzRLBDqHqB2k9gzP+UZBhD0AxK51yQUlhLwvf8k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j4YRJSP4Vk6FeEMgFEry3j1XtPyyE1623Su/VFg5thB7EHtjb7Fn0FhTmSwWD5/2tXgLQVpf1mKHpsj2bMvqhqaPdQS8Aadi4ISNhEDEt0Nhv95kH+0q56KWBWP2ZT/xikj57fZpXBAjfVYX5JmuTUamYAaJ89x+Nbio25IyoNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PX9kju42; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3dc6945e109so43324005ab.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 May 2025 15:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1747954184; x=1748558984; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4s3zSEh4snp0xBeK01CCVtJfz7Wl6wxDOdDf1VotpRM=;
        b=PX9kju42Se4jcYByT3jUj7Ppby8Ei8CjFJ9oexJxCKCTsRLDidqC/VI8/LotcVF/zW
         VMjoZbJ1vFlc8afW3s7Gk52e0B0shET2dDZjz2ebu0tY76H7F4eLY+gkrQN35Fn5BqjR
         ctB+2v24C0uj+rnxDUZ6M+ssCv+/GYsYcWhy4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747954184; x=1748558984;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4s3zSEh4snp0xBeK01CCVtJfz7Wl6wxDOdDf1VotpRM=;
        b=Mxru54lHCfYXN4IgybmkOO9aBafbfkQYUgGVhJNtx2j9oxIFePcFfbcr7nAYjQ22yx
         cmmn7RmYlmPjEKX1XMPfMsxbU37mEnm9mNMnjJVIkqP8gZC955cYGDiK6Le7Z6zzU+AJ
         jfFbnKweNbIBCURVEP+j2SsTSGM7oTTVLy/go8nSyzbcGERuqRUyfxayJzC2HlbuQtUb
         /NQrJOQZpqku7Mj3fysKsAmmtz+JoAdUh99mQ7INQUMx9Fr4r21ZxtPc8SWe3Y0EXGDq
         Thg8+CKm3x8hVk3eBf4CWBYHGjOfQc56uJMnmxWTLDI2DyGevjgo1WEDQoUy94i9KtzI
         BkEg==
X-Forwarded-Encrypted: i=1; AJvYcCXvyLUwEwiTOkXpUMVES1FsgeAV2ag1tcxL/N0UbkPphB90WaN8j9SdTllFRWAivCN16aKpMi57OVEkcVVw@vger.kernel.org
X-Gm-Message-State: AOJu0Yzv5kN/ONgVVl4WUGC9q/t30NjYmsU+ernCyDhGpviQnpgIe9As
	ZPe19+hiqFFWHycespcuYXGHaVsRYtQjkLcBnuoxWZXAJ1qMjF75/rcOj8Zt+LuAYIk=
X-Gm-Gg: ASbGncu0qNbV8oNWJ+jT42KAiSU7HmuG3ThW4eovh564RyMzDOJvc1JhLW+ajQ2GSza
	SB/vlVPn3wk96pirZ+vpqn2JP1rgZZFPXA6ggg5uNRVUNR+XbsH+cRx6lab8Z3XYJxwNu4OyqjW
	pIC7K9C/ACiSL/KDg7BksO5Miqqc2yEbikhP5Jr6WyC1FiadcMKXUrc4RQRCA4FiZA1U5BSqkBs
	K4GdqfDdRiskGC4x0mnJZjuaFJhDvb4RE/zLjtKcmjxjuPLNTKRO4FS0xBaJ4jIUWw4EXM2j6dR
	vg/GL/YIn0Qfz3Sp5HekMi4WGWqFHID+RLZBCwOffCRqtAJ1YDfDtZwvKzk+Mg==
X-Google-Smtp-Source: AGHT+IHQS+ZDp8ppQECt+VzLm3Py7wm28k4VQfjNDxyLCiw94PysHUBvarpgdnsCuhzk1t38nuqn2Q==
X-Received: by 2002:a05:6e02:19cf:b0:3d4:244b:db1d with SMTP id e9e14a558f8ab-3dc932664c2mr10876065ab.6.1747954183964;
        Thu, 22 May 2025 15:49:43 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3dc84ceeccesm11041375ab.45.2025.05.22.15.49.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 May 2025 15:49:43 -0700 (PDT)
Message-ID: <57f3f9ec-41bf-4a7b-b4b2-a4dd78ad7801@linuxfoundation.org>
Date: Thu, 22 May 2025 16:49:42 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] selftests: Add functional test for the abort file in
 fusectl
To: Chen Linxuan <chenlinxuan@uniontech.com>, Shuah Khan <shuah@kernel.org>,
 Miklos Szeredi <miklos@szeredi.hu>
Cc: zhanjun@uniontech.com, niecheng1@uniontech.com, wentao@uniontech.com,
 Amir Goldstein <amir73il@gmail.com>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250517012350.10317-2-chenlinxuan@uniontech.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250517012350.10317-2-chenlinxuan@uniontech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/16/25 19:23, Chen Linxuan wrote:
> This patch add a simple functional test for the "abort" file
> in fusectlfs (/sys/fs/fuse/connections/ID/about).
> 
> A simple fuse daemon is added for testing.
> 
> Related discussion can be found in the link below.
> 
> Link: https://lore.kernel.org/all/CAOQ4uxjKFXOKQxPpxtS6G_nR0tpw95w0GiO68UcWg_OBhmSY=Q@mail.gmail.com/
> Cc: Amir Goldstein <amir73il@gmail.com>
> Signed-off-by: Chen Linxuan <chenlinxuan@uniontech.com>
> ---
> Changes in v2:
> - Apply changes suggested by Amir Goldstein
>    - Check errno
> - Link to v1: https://lore.kernel.org/all/20250515073449.346774-2-chenlinxuan@uniontech.com/

Short summary should include the test name:

selftests: filesystems: Add functional test for the abort file in fusectl

Also if this test requires root previlege, add check for it. The rest
looks good to me.

Acked-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah

