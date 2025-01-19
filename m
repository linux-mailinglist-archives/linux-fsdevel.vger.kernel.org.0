Return-Path: <linux-fsdevel+bounces-39607-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA98EA16226
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Jan 2025 15:28:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26731164775
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Jan 2025 14:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50B301D4335;
	Sun, 19 Jan 2025 14:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="HID91rtm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2DA22F3E
	for <linux-fsdevel@vger.kernel.org>; Sun, 19 Jan 2025 14:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737296888; cv=none; b=clgzRZLmPyOYHBuwoPJFn3ZOyTFCEeXOdS70228h5kCuWc2xEnCSoYyaULf08NoHdrsXaKHMVLR5qTaOZ+9aJyJi+m6fVEn8ZPdSkTJ4zwaWoyynodm5YneCF2hxb1GZ9QoSVbQj9nIYXU+i9hgS5EGK5nOUweD3kfq1vxOTRII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737296888; c=relaxed/simple;
	bh=s/QBnPzwI+8A30i8RtyWFIiUspj7nqxP9IRumrOehlk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CKc6nEXDhhjmD4V6sGziXZG6c6IunZ5zcz0sM56/fzstgmlWg/fGJ9Yi+mk5pFq5MCIRaMG/tevmq6/+oXvt/+edO2khAOxpoL3LD40qWBI2f8bKet1VREafXOlx8gqhUYnmXQSrRfKLYc1n3UjFbhhBXFMhcidur4T2WVGiibE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=HID91rtm; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-216426b0865so62492235ad.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 19 Jan 2025 06:28:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1737296885; x=1737901685; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rDhWogoim4g5YVJEhKyf80vC+SG8qHV5+KKD/7G+Zmg=;
        b=HID91rtmuy61J0JFiHrf4tJiKxaNsxyubXhDTeENLro4QIuJXWr//svAnyWB3iOKaJ
         2JzbZbSKsytIXQvTF10O+eGua4MUwLnSdOXumLMZFOqrds3XaQcdNHjBQ40GWHTKYoZ1
         14qjp/nxF7pR7nx1xyJ4eHfKu/ft4IrLL3h2st2zJR/A6nclSFBAJXIzaMsadYQlRjoB
         OU6sX6f/DuSMKb3PdF2CwdOWejI21usGPfHQ7FAYi7BBhGrRCYt4nd2KEzG4jW116Y1y
         jyKARAyDDtLAB4ty/v9M9tWRcHtBLxYk43EFiBLu9JjLWFJeZAlpbYAVmeKXAbvRNH0/
         vOwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737296885; x=1737901685;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rDhWogoim4g5YVJEhKyf80vC+SG8qHV5+KKD/7G+Zmg=;
        b=Lsr57TgjWeypMkPLuSUY7ip/kUAhWiMhNjflvbSb+Xt9tlYJlQ+yVIrtoy3auhGNxx
         3sFRqvqEP0eUrK8oWObj5edMqjGxzCRDgC2+/sBbcom8c3hz9pCmkPKQ6dDN8NPz9g4s
         ZKwnEgBoYxFVQOMKSk3sT/Fka4nOPLnGeY/BPzmLM2ruM2XEljcF7rwJsOnq8sghPAQA
         xlxkuAyZCaqO8mrHDn7g82H4Ofseo6QIJtSnw65Rkt5rCdWzZlmbwRweCh3miNCxMlFf
         RWtIh2EoztsQP81L9TlfjsDDJ7849wxxNbMWiHuHV2HrBLffnSo2gxKEdP5Qq+qwrADE
         FG1Q==
X-Gm-Message-State: AOJu0YycYU1HEs12v8XvtwrVzKfie4WjaosOSOkFFQ6Dtxa6xK4muCcC
	zvQCl7UhdJDNyeXuf1plDbsrQVHOMKC8j7+hjnE/H9P9TEqQxfgYKcwzi6aiywQ=
X-Gm-Gg: ASbGnctsziVtkNVvQ4E8OK2+lDFsEv7c+C1FzVYS/2zIsiC6EDLam5KVwRWM4Gl17lb
	/qwjJwM/Ql2SWCyvgA7knn5ZaNp7mqtzMEWM61DYWzzidKNOpC51Mbnv+ODQuUvpGBQrIECt2Ea
	/bzheKSi/ElHWNe/IOWPutq4VpP2Z83GHytMBerEC8buy+YdmI4vyaqoHcYd7jFR095oRnrbrb5
	GGS77Yq0Sg3xIUBFefZRDPl/0pkVF4XWUAjT57gLemIA1dT48QkqUuXH/FVdQzCzmNw3MVsh0py
	om5gz4dwVyIsh6tkWKuYg5f+bxpsgdEHP7AZ
X-Google-Smtp-Source: AGHT+IGaG1oRqwGEeFkz4NWIiM01JQqVDYkdDntFQ46G7kDRMTuU9WpFCZ94WedWoukFKfc/EUAgCA==
X-Received: by 2002:a17:902:d48f:b0:216:282d:c697 with SMTP id d9443c01a7336-21c35544097mr119855425ad.27.1737296884945;
        Sun, 19 Jan 2025 06:28:04 -0800 (PST)
Received: from ?IPV6:2600:380:6c18:e44c:3622:e9ea:5693:cb1d? ([2600:380:6c18:e44c:3622:e9ea:5693:cb1d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21c2cebaebcsm45456485ad.99.2025.01.19.06.28.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Jan 2025 06:28:03 -0800 (PST)
Message-ID: <2c0ee9b0-bdcf-4470-88f7-80a616f64cd2@kernel.dk>
Date: Sun, 19 Jan 2025 07:28:02 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC][PATCH] fix io_uring_show_fdinfo() misuse of ->d_iname
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, Pavel Begunkov <asml.silence@gmail.com>,
 io-uring@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
References: <20250118025717.GU1977892@ZenIV>
 <cf13b64b-29fb-47b9-ae2d-1dcedd8cc415@kernel.dk>
 <20250119032649.GW1977892@ZenIV>
From: Jens Axboe <axboe@kernel.dk>
Content-Language: en-US
In-Reply-To: <20250119032649.GW1977892@ZenIV>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/18/25 8:26 PM, Al Viro wrote:
> 	Output of io_uring_show_fdinfo() has several problems:
> * racy use of ->d_iname
> * junk if the name is long - in that case it's not stored in ->d_iname
> at all
> * lack of quoting (names can contain newlines, etc. - or be equal to "<none>",
> for that matter).
> * lines for empty slots are pointless noise - we already have the total
> amount, so having just the non-empty ones would carry the same information.

Thanks Al, I'll queue this up.

-- 
Jens Axboe

