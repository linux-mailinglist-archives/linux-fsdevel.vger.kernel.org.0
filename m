Return-Path: <linux-fsdevel+bounces-43452-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5686FA56C4B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Mar 2025 16:39:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E621B3ABAAD
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Mar 2025 15:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE33721D3F0;
	Fri,  7 Mar 2025 15:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K7AEBm0a"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B5DF20968E
	for <linux-fsdevel@vger.kernel.org>; Fri,  7 Mar 2025 15:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741361966; cv=none; b=TZTWejlbHTB/INtLdruNb4QqKJBdapzmSQcYtcUrPw3qWtTvj5SvaHFCEtoWaxxzj9ne56Lz9b+qpQeArL+YEgYY6Kd+lOmfUl+p5P1H8a9Pal6uZNZWXKfNg2sqp0yeUpgHiZFD+OaJiBU1TXVd/O/eDP0T3xA2Y1w7yIP5i3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741361966; c=relaxed/simple;
	bh=WoXf2zTP3jG5mcM6MMb3tvAp1POHk2I6r0X89Fsx6Xw=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=r1DnuFb+RO+Shv7U4fhMI/YDnR3u41GRV7TOeXuHaSpJ3tN3cfMCHOczREE3UhMc0ydB15L99oAUOb78G9SD21U5ybHXdmwvyFHq7xtQFKrm50pv05QgEhSdK9EWUOSyjGBIACN1Xm1EAIV1gfrozPrQlR+A8TFdarMLBlOcPQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K7AEBm0a; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ac0b6e8d96cso284102266b.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 07 Mar 2025 07:39:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741361962; x=1741966762; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:content-language:to
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VnbpHxmW5RvJ0pI/dBqt7zKwlYRwgL+JQnlcmV6pMuk=;
        b=K7AEBm0aRP/GaOU9Pgw9KBRBKOcGLvcQOvPerkJhSRnX/r2V2jwAeY03+hQrF9RJ0M
         NgoWCioLZURv1WhUZpFlNHwvpWfpR5F9uF4sQ4NLDgQ3G8CByPNsPKBXAUt9QEw2Vsv/
         GGprLAJOXOgZDT1zKN/6eEZMW/lbEK+VzM3itFJFR83eU7zNB5ll+6UmV53XJxn5d2Gv
         tOa4m6yFxJEQ1JWDqCtoN1HBDa/697X3YF9EbjW1TaCjKf+ZBSStc3y5G6dmzQcPbw/g
         whDsG4j4xrQoaHflndZVhIkGWEzijAz9WcUmZeK4GFc8Y51BL2e+QQkEsDZ1tKPA1RFZ
         gQxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741361962; x=1741966762;
        h=content-transfer-encoding:subject:from:content-language:to
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VnbpHxmW5RvJ0pI/dBqt7zKwlYRwgL+JQnlcmV6pMuk=;
        b=O7UNRM1j88EnJPiAfmgS+Izu7zknaIfWStj/xG8MEBG6MzSDRoJyfFwPACdZLMlGPF
         I76IFiQWYnEk+wNBv6a93/Vf65g/gMlgZ3zV2Y+gZGmhRU6xzqveZ1YoakDyWAj9WEEE
         ghMZ3IkaAtciUfg4YA7UaASbvKtYFKAXuZqs3SlQZzgdaAT3+xEsFFC6ZDLE0lguVRWx
         +pZFKDYozb2z0BYdeoegiw4krgRnzmLJkuls66J/+ui3gxKGYaJVaJdcS6VAqXhbfzOX
         EEtTXGIun87WGjWytMlZwTMVerswI41SpZE6bi2z9/dwhH830HVz7pXc0b4tnqBiFFs5
         0/dg==
X-Gm-Message-State: AOJu0YzyvFStU2V/r1OydrhV0Et5PQD4Su7NK/vaIR6Z6S0aWylYf98q
	qO4HzhSM3WGMtK3JfxsP39ym4CSJpuRwvC5QLggK4QXey6+S58sELjwzMA==
X-Gm-Gg: ASbGncusi0kbo0vSrgXb8Xq68nPQQzB1487+dFJ1dqw+q4qeQr2iLFQ1DwtW2MEX+fk
	0OyIx25WBNd2wJUMvlC4Ij9kUhUQtUsqKhu8YHeCRkOxefLnRmlPp7YtbnHfeiVxM1/137GmeL0
	gO1X/5y6z7Gg9kFKZYX5FDHbUzKcvItb3VTD7RRdi6tNPwJ+ympoR2uivGni2D/Hyo5CLkssJ5S
	iSRqLFdWUSMLlX4sEM4ReT3WnCCLv/PxJK5MgnXmWPteLVifuJbXUx2OUZmYNEl2NGk46qIA71E
	TJkpX/ByGHUObCH0H57efxqWeKIgH6wRL1LApDa3V/dwTyfytqedvO/CDk3uB6sJ8iZkokE1vZN
	qDxyq5r8J22VJ/CzZWBJU
X-Google-Smtp-Source: AGHT+IFhaV/RCWUbb2StAHCGj1fmrXYauI2shgObp+pigdNZHnIlHwM0Le0aAUCnr43rDnMZPmnC0A==
X-Received: by 2002:a17:906:6a0d:b0:ac0:b05:f0c0 with SMTP id a640c23a62f3a-ac2525dd545mr422238566b.1.1741361962319;
        Fri, 07 Mar 2025 07:39:22 -0800 (PST)
Received: from [192.168.188.67] (5073E277.static.ziggozakelijk.nl. [80.115.226.119])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac255589a30sm144176766b.107.2025.03.07.07.39.21
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Mar 2025 07:39:21 -0800 (PST)
Message-ID: <51d24177-482e-4355-8e14-689752dfa36e@gmail.com>
Date: Fri, 7 Mar 2025 16:39:21 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-fsdevel@vger.kernel.org
Content-Language: en-US
From: tzsz <writing.segfaults@gmail.com>
Subject: Swapping fs root inode without unmounting
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello!

We are currently developing a snapshot feature for a small university 
project. And for this reason we are looking for a way to swap out the 
root inode of our (mounted) fs.
Internally we have a set of root inodes and we'd like to swap them out 
at will without unmounting the entire filesystem.

Is there any function/way how to do this properly?

So far we tried the following:
  -> swapping dentry: setting sb->s_root
     -> causes a lot of problems regarding inode ref counting (I_CLEAR flag)
  -> looking into fs_context (doesnt seem like this is appropriate here)
  -> we did not find anything related within the vfs.rst docs

Furthermore, we cannot mount those other root inodes at different 
mountpoints. All changes have to be live and in-place.

Kind regards


