Return-Path: <linux-fsdevel+bounces-65219-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BDEF1BFE4EB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 23:25:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 35B9A4FA118
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 21:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7561C2798FA;
	Wed, 22 Oct 2025 21:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iWsshTzb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E259277C9A
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Oct 2025 21:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761168292; cv=none; b=AAj7KcMb4H7VJLPrYOBZUOZvpcaIsNkitsO8BBMFBGEqyVE+U7OQt/v+m2XhnuDDbQVy+HKCYBefmjt7gv4xzJvHVhhHvWoOj9Wdmpp3HNoPd9hb7KGkpWxmTiR/cb+BboXtw5pubnypCer+acvtQRLCiyz/OlEW5hFDEmk2yKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761168292; c=relaxed/simple;
	bh=YtKOyixoHPx1NcMiJII//Ztppxn1gQj+UOEosExhxZo=;
	h=Date:From:Subject:To:Cc:Message-Id:MIME-Version:Content-Type; b=CR0zCmWkQ0At1v4b9cfqe23Az8oIpap3aqRr0JUaSZNrn3qcjIm8qkR5WhvsmJlKmE4QQRrFKMJfkg80vHCtlza4loiLQ4gxczdwAZC/fykZFP8ggjkHlcYpWFVJiYlnNY78zpXkifYp+tKI7QlYdGaZo9wfXuq+EF7edo3JcJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iWsshTzb; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b48d8deafaeso32560866b.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Oct 2025 14:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761168289; x=1761773089; darn=vger.kernel.org;
        h=mime-version:message-id:cc:to:subject:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=D47Gbljbsf5qONWORr4UBdHnIFfq+62yiZau0TgnRH0=;
        b=iWsshTzbkUKmrXlgG1tIdkrSxGIMGsKBUIrQwSy/QOKsxc5mNT2U/8UvIoYccVh9Fr
         0H2DM7deKEebKBVYytYp8zDjQeedH7QQ64ws45qibnqf3gQCpaadmXvUz4a/uw3+tdU9
         Ll5VwtVY0q8c353yF9hfvvMLWqrd8wejtW1i8xHXngQpgwB85alQIrqOYGMfHcTH41Xi
         0VwGOX56GJfzZ9jXFA2eL6BYncHlXRd8Lm0t8DvsZNNlGePxxiM/2ueqk0pMQBnVhmG9
         xm6ztfAZEyWQFoaL863UOEK0+kcwoT8nV6tMxXIN0vJlXVE8xLWlUm4OUgTYQQQZD3gS
         j54A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761168289; x=1761773089;
        h=mime-version:message-id:cc:to:subject:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D47Gbljbsf5qONWORr4UBdHnIFfq+62yiZau0TgnRH0=;
        b=Xacrf0FbDqP9CTeTnRj7E5EbWqIgdQ1/auDXoMTd6SR5gKeWEUb1d27JsfxC9P12rw
         1yCnRyZ4+wGwEC4mHF91gs2CTad3DlGIEyMe2NBwnhzZvG0rbMsHNNSzeE9cvHqK/cOO
         bZYnqiyrtexRnr9EspRjCtPHxOme0mEj6eIOPTMJb8jibFs3K7QXRIMk5QyaVSBRCbUx
         zEstsjGJf5q84sMZKucoPKg+VxXTy75frmSl1zV5+FzAREy8x59LZEtYNQCXF3kwxjUH
         SHobKQniAS89+kdUE27yXfaHDH0t0FkhdvUBLDBaNzjTVaaQgvtmer+RIpBfAAxmhPMJ
         VnwQ==
X-Forwarded-Encrypted: i=1; AJvYcCVuNpLZxsW7E5QGS9n7g6wGSagt9eHhNKoVSLsmZS4rxEJcsXNtYfIRgNiWaBwje6H8rMGCEqWz5+2MLwFM@vger.kernel.org
X-Gm-Message-State: AOJu0YxK8GMQd5OPtLGfYVA+MHF+RC0CCryFvHEgvz/Y9wHX1GNX+0RV
	WhzMXxRhxUGcxiqcRpZ2Bt4OGf7JVCDNYU6WhD/rBVmIwNkJ3cX4cEYG
X-Gm-Gg: ASbGncuXIimK+lJ5jMN1/giomAGp3jiBEQengfWCngxePNMSvXYLru0olpLFAixxcia
	3IYEUZvG4AhjaOs4EvbC62ee5jvfX+Qe1NOasrB7UbkUvZ7+quXND0nkWDxqjfnIpJJhYoBeL2L
	B3UP6g20cW73WvOlhG+7raywh4bbvp27WyKvaJXqPoxsrxpl3oSYLeld9JovDF7VgDSJTBVc/2U
	07LrkbCBRXR0uBjMGlyXl+PqmqIq8hqBS30+ULW5fUi4ealgt0q1RmQUoWRvEbL3oz14rSDM15i
	qB5atdG3xhrONBWm1QYBx/sbNIJSW/w2XbShUFmc9nyVRV63bijRoElfZpJcQEZqmfkdfpSkdh2
	g/sc2+pagFxkNJaQEB5IKSKPlT6as8KFAJjqPbxh7/kzewCE+auuJ/ByZ7FSjCSSx2DQ0geWLFh
	l7iq2FM+njCDCy4lcrGR5WnXLw9Gjb17QV
X-Google-Smtp-Source: AGHT+IFmLH+8l6H+VvzdRHUG2NfuU3wQ0/dYwaK5pBf9lS9xco0crOebWlYIrWguJ5pagQ+0tLTd3w==
X-Received: by 2002:a17:906:410e:b0:b6d:2f3d:5cf8 with SMTP id a640c23a62f3a-b6d2f3d5e23mr431981266b.14.1761168289227;
        Wed, 22 Oct 2025 14:24:49 -0700 (PDT)
Received: from [192.168.1.228] (232.0.31.31.dyn.idknet.com. [31.31.0.232])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d51417143sm16918766b.42.2025.10.22.14.24.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 14:24:48 -0700 (PDT)
Date: Thu, 23 Oct 2025 00:24:40 +0300
From: Lassebq <lassebq.mine@gmail.com>
Subject: Re: [PATCH 00/11] ntfsplus: ntfs filesystem remake
To: linkinjeon@kernel.org
Cc: amir73il@gmail.com, brauner@kernel.org, cheol.lee@lge.com,
	djwong@kernel.org, dsterba@suse.com, ebiggers@kernel.org, gunho.lee@lge.com,
	hch@infradead.org, hch@lst.de, iamjoonsoo.kim@lge.com, jack@suse.cz,
	jay.sim@lge.com, josef@toxicpanda.com, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, neil@brown.name, pali@kernel.org,
	rgoldwyn@suse.com, sandeen@sandeen.net, tytso@mit.edu,
	viro@zeniv.linux.org.uk, willy@infradead.org, xiang@kernel.org
Message-Id: <45YJ4T.CS9RVQCDTG7F1@gmail.com>
X-Mailer: org.gnome.Geary/46.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed

Hello

I wanted to apply these patches on top of my kernel build, but I 
noticed that not every diff is included in the thread. And I think some 
code in patches appears to be a out of date or target an older kernel? 
Like there is usage of inode_generic_drop instead of generic_drop_inode.

Is there a reason for that? I'm new to kernel mailing lists so I'm not 
exactly sure why that's the case or how it works.

Appreciate if you could clear things up for a newbie like me.

Ivan



