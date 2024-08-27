Return-Path: <linux-fsdevel+bounces-27388-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48C3C9611EC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 17:25:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F19A91F23772
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 15:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A49B1C7B71;
	Tue, 27 Aug 2024 15:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kGHgnwUA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAFC51C5783;
	Tue, 27 Aug 2024 15:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724772282; cv=none; b=h6ffmNwXLLu5BHf/hpnQ4RQMC89INCDNQFznVTp4+/Vu2YB1uztBrEp12Y1KX7HbPEDcMvVg+15zfJaGgKHOXT9FVkNoepAgLS86SnhuYDMp/bap11bLyjs8GG5DeY3kDAGVEiCZVpd5qxua/q2A+yjnCre12QEj371+VzA9k7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724772282; c=relaxed/simple;
	bh=YQ2VG2DYOB80viZEe5vmkUS0nQMT8d50waYYo97gKDM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pLc/kIC2r6r2Y+iQ7baiS4VJkkU9/HQmw5+BcHC2Okf3ribHaf+gjQQH8LVSM5LX08AEj3+M10pL+Gq4N+R+vx1xnAuF87PRVRkdKbLOfu1qIHWsMkqZG85omHtT7NDh8sJEj6iDSggE4ojBULG69Q2Ws0Ew2d4JaBxq7We/F5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kGHgnwUA; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-533461323cdso6432164e87.2;
        Tue, 27 Aug 2024 08:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724772279; x=1725377079; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5+3AhCX+ZJlKziiTtmYukdp7nOWfib5WaN8umHYwjNM=;
        b=kGHgnwUA8rDbifE6CSeLybERnaV+OJUI6XaY7gW831M09T48b0IwTRucAg26v/p2Ou
         8KqLix3w3ehQUbjXmgGBDOmoWzOXtp/zFmMoThRkjMPsiXWCrlHaaad3zFNcvGuuqfjN
         StdLWrCbIvKQ1GMPvC7zDglbWf5jx7LnUms8GxUfaSccp1pYbR8CB9sniNfnGnKNdDwQ
         yq2ewVN/aZ7tsKrFly+ZRCn4cCCjiKWXJjc7BUFGMTRxROSKDR4rADkse2OmzhsRGgjn
         RzC6PFVhDkI6N2mJ4arsRanoOFu87WyjWc5TFb6fiEmFx0j3GPFSlUQJR9yKcitEqGwT
         V11g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724772279; x=1725377079;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5+3AhCX+ZJlKziiTtmYukdp7nOWfib5WaN8umHYwjNM=;
        b=H2ahzvFnCnwnSUog5OPFtIQylUAaRap0jLFi0Db/iRbfSar6bCPKOdSJhA6Z+sR6J1
         ZDeH/h3JlTD0NMNchB3WoX1jifC60iKVq7HR3PsMSNcjt+/Fl2HTSxli11qywo68KPsT
         WMMyV46quCgHP/h+Lvi7sdKNY4Lr673dJr8cBFBAJRied0drm8XLy0ZOcsh0GsFpTCWv
         iWdZA2HK3RnuzotMGQ9SL2PQ+OjwB+uOAR8hNh5spyNloqtFmVD6ryxMn3rSMOT5fQKZ
         5YkWIH8S1RzmdWk/VhDEwu5wHvTYuW1dVMrdOftBC9nZGg9P8D4gTIZ9lHEM5wcnSaH0
         QoQg==
X-Forwarded-Encrypted: i=1; AJvYcCWVRrqTnPtaubxGrTFMR3LvsvJq1yLwVipkNgaZsyaRzkvpssy+WuKETEZ7EFX9bUic9F5UJoV271yusZvQ@vger.kernel.org, AJvYcCX46MgojIFseqQLmTMgCVemTt3UmlM1B+ogdIvPxZqiO0h+l/fXQNG6ZKAUKCD+2QVrMXuBdO7rkKI2@vger.kernel.org
X-Gm-Message-State: AOJu0YwxR0XrTnCiEl2cYu4uoxvEmYN2tQlCePHjztmVzMlC2Ffrg7QW
	vaPAovQClNAX8jLMjy7fp5fOORJMGvmH+s/CklaLuFqEfzu+I/Lc
X-Google-Smtp-Source: AGHT+IE6eAaVS0g91zaL8EKcj3HOTk8vY8xhM7k1eoix4HsI/20/Uae50383wAdhbyY8fhBzSbDc4Q==
X-Received: by 2002:a05:6512:6cf:b0:52c:e0fb:92c0 with SMTP id 2adb3069b0e04-5343883abdfmr8530719e87.34.1724772278344;
        Tue, 27 Aug 2024 08:24:38 -0700 (PDT)
Received: from [130.235.83.196] (nieman.control.lth.se. [130.235.83.196])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5334ea59474sm1800442e87.150.2024.08.27.08.24.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Aug 2024 08:24:38 -0700 (PDT)
Message-ID: <1037bb5a-a48f-47cb-ace7-5e0aba7c6195@gmail.com>
Date: Tue, 27 Aug 2024 17:24:36 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [ANNOUNCE] xfs-linux: for-next updated to a24cae8fc1f1
To: Chandan Babu R <chandanbabu@kernel.org>
Cc: dchinner@redhat.com, djwong@kernel.org, hch@lst.de,
 kjell.m.randa@gmail.com, linux-fsdevel@vger.kernel.org,
 linux-xfs@vger.kernel.org, willy@infradead.org, wozizhi@huawei.com
References: <877cc2rom1.fsf@debian-BULLSEYE-live-builder-AMD64>
Content-Language: en-US
From: Anders Blomdell <anders.blomdell@gmail.com>
In-Reply-To: <877cc2rom1.fsf@debian-BULLSEYE-live-builder-AMD64>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Since 6.10 is still marked as a stable release, maybe this shold go into 6.10-fixes branch as well?

   Dave Chinner (1):
       [95179935bead] xfs: xfs_finobt_count_blocks() walks the wrong btree

/Anders

On 2024-08-27 17:05, Chandan Babu R wrote:
> Hi folks,
> 
> The for-next branch of the xfs-linux repository at:
> 
> 	https://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git
> 
> has just been updated.
> 
> Patches often get missed, so please check if your outstanding patches
> were in this update. If they have not been in this update, please
> resubmit them to linux-xfs@vger.kernel.org so they can be picked up in
> the next update.
> 
> The new head of the for-next branch is commit:
> 
> a24cae8fc1f1 xfs: reset rootdir extent size hint after growfsrt
> 
> 9 new commits:
> 
> Darrick J. Wong (6):
>        [e21fea4ac3cf] xfs: fix di_onlink checking for V1/V2 inodes
>        [5335affcff91] xfs: fix folio dirtying for XFILE_ALLOC callers
>        [410e8a18f8e9] xfs: don't bother reporting blocks trimmed via FITRIM
>        [6b35cc8d9239] xfs: use XFS_BUF_DADDR_NULL for daddrs in getfsmap code
>        [16e1fbdce9c8] xfs: take m_growlock when running growfsrt
>        [a24cae8fc1f1] xfs: reset rootdir extent size hint after growfsrt
> 
> Dave Chinner (1):
>        [95179935bead] xfs: xfs_finobt_count_blocks() walks the wrong btree
> 
> Zizhi Wo (2):
>        [68415b349f3f] xfs: Fix the owner setting issue for rmap query in xfs fsmap
>        [ca6448aed4f1] xfs: Fix missing interval for missing_owner in xfs fsmap
> 
> Code Diffstat:
> 
>   fs/xfs/libxfs/xfs_ialloc_btree.c |  2 +-
>   fs/xfs/libxfs/xfs_inode_buf.c    | 14 +++--
>   fs/xfs/scrub/xfile.c             |  2 +-
>   fs/xfs/xfs_discard.c             | 36 ++++--------
>   fs/xfs/xfs_fsmap.c               | 30 ++++++++--
>   fs/xfs/xfs_rtalloc.c             | 78 ++++++++++++++++++++-----
>   6 files changed, 114 insertions(+), 48 deletions(-)

