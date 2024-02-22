Return-Path: <linux-fsdevel+bounces-12419-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DBC9285F169
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Feb 2024 07:19:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BA4F1F23652
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Feb 2024 06:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0A28171AF;
	Thu, 22 Feb 2024 06:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bY8abVoT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95EB1111B2;
	Thu, 22 Feb 2024 06:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708582755; cv=none; b=ZyZyIeUx9PAMWj9SBLcoWiIkI3d+humvhwH4C1j34EYoLwpaCWlRiPY4KvJ+ryPIEA9gyudWW7vHYmXtisJv0a/prz9uFZ0JbjEhCv56eh9xITgec51MgLXaDJzjKjjHur6WkmbmKjhIlFhfyYubAhJvvNtFJxEZrxolmhzMfOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708582755; c=relaxed/simple;
	bh=0Lr5AX7FpO/aXj6qVayv8ofx1ZqBAzWpFrAwAcDTM6k=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=VAw9jBpJ2/H8cTCleC6Dn+/ypP7+e/9ddq9eYCfk00R6ds+3cuuq7vTgQshHMlgMJ6iOn6IePaSmoCaYWBGLhXm1pPEQrvQXpJKwyiRifid8rOQG4P8Ooli6mbjBVYks3AfNSHUPFitXk3kI7SAjT2YIdmRPTq1Te/ee+7Ag9Io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bY8abVoT; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a3e82664d53so549331066b.3;
        Wed, 21 Feb 2024 22:19:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708582743; x=1709187543; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xPC3HI8Z845qLz3kUsWszBQiV6ZgNOYEP7Ob0HaDyNQ=;
        b=bY8abVoTBCBoh5P/7A7HQzn/06lVrts8WEeLpOTkHwnyR+WeUh8h4RAJSTI022XGYO
         LxoXJzkTGqiCpdLiE3nrTYUizCDEvn5XRedSz7+YIM/Jvw7fALZdt2tJLSTUH7F3qQrJ
         E9EXhuknD/GsYjO9cUjf5GJs6RS/miEUPz4DlIJKwMyqjtxn44G7Xt4tyx1jKlzQFnSH
         DFMDeDFoszAvsyeurZWw/CNyBDiCFZ0VW+Zlp40U6akbgbDcZT8F+9i0crk7MNsVHx/u
         +dHTRdhaPL/1XZd2mK/CaoPkEZMuh5bOR3bQc48ar3dCu91i5xprmEuOb4E3rM0QsIof
         xLQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708582743; x=1709187543;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xPC3HI8Z845qLz3kUsWszBQiV6ZgNOYEP7Ob0HaDyNQ=;
        b=hTEuzPfyAKC2IA7EHxAq77lqxXZSh/d1vKFGvWG2G+MpKLXBbLfvwB8oZMZVkdWsg5
         er6UsE1k/u0t+XF8hZTayJFun9yMSi8fEwQo2XYiw5toiHCA6+UN8r4JBQz+qKLhqhLW
         cN+RrRUVo7qsCe9N6VZ2MuxSnyr1NUaSLAID2roSKXvEycq9YldaU0DoaJZ8sq5B4N6W
         KFdFru8QE0QZ6qmF6HUKq0uqh3ZP4489ltbUjDSNpP5nGuICMGnChn75wROubTs4vbK3
         /CJs4SXLTN7xd2CA0HQ3rRgQuCHNPNfJB6MiI+P6T+N6VEfw4hgRUmOSY4gkGPFAm4a8
         Neog==
X-Forwarded-Encrypted: i=1; AJvYcCXJTsoQ/IxeBvVZQG4dnTE+4l4dzIX7LEE1dZv9izj0mh53qkG9g2izP0zJKrHLvPo0KkScTo/2N5NvX8+hkjQPUjm2EABNtSsk0ZR4oA==
X-Gm-Message-State: AOJu0Yzvu1Qu8w13222bAOCp3pPaOQZmKA3B2Y+/g4N74lB9KYQSvhwM
	OcalLCftzmMGiwyAxC4PqJlsYEpfKdHNVfXrl/NC5RWAA5C3yf6R
X-Google-Smtp-Source: AGHT+IEG7HibaMSVR4WszoJmFurHvTqqfwmJavSGmz3ZBGgDGYfemtVbvvksLmQ36jWwvqQIQpKaFA==
X-Received: by 2002:a17:906:3b12:b0:a3e:59e5:a38f with SMTP id g18-20020a1709063b1200b00a3e59e5a38fmr8255861ejf.11.1708582742617;
        Wed, 21 Feb 2024 22:19:02 -0800 (PST)
Received: from [192.168.26.149] (031011218106.poznan.vectranet.pl. [31.11.218.106])
        by smtp.googlemail.com with ESMTPSA id vk7-20020a170907cbc700b00a3efba5543csm2268945ejc.13.2024.02.21.22.19.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Feb 2024 22:19:02 -0800 (PST)
Message-ID: <67bb0571-a6e0-44ea-9ab6-91c267d0642f@gmail.com>
Date: Thu, 22 Feb 2024 07:19:00 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Subject: Can overlayfs follow mounts in lowerdir?
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>,
 Christian Brauner <brauner@kernel.org>, Vivek Goyal <vgoyal@redhat.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 linux-unionfs@vger.kernel.org, Luiz Angelo Daros de Luca <luizluca@gmail.com>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

I'm trying to use overlay to create temporary virtual root filesystem.
I need a copy of / with custom files on top of it.

To achieve that I used a simple mount like this:
mount -t overlay overlay -o lowerdir=/,upperdir=/tmp/ov/upper,workdir=/tmp/ov/work /tmp/ov/virtual

In /tmp/ov/virtual/ I can see my main filesystem and I can make temporary
changes to it. Almost perfect!

The problem are mounts. I have some standard ones:
proc on /proc type proc (rw,nosuid,nodev,noexec,noatime)
sysfs on /sys type sysfs (rw,nosuid,nodev,noexec,noatime)
tmpfs on /tmp type tmpfs (rw,nosuid,nodev,noatime)

They are not visible in my virtual root:
# ls -l /tmp/ov/proc/
# ls -l /tmp/ov/sys/
# ls -l /tmp/ov/tmp/
(all empty)

Would that be possible to make overlayfs follow such mounts in lowerdir?

-- 
Rafał

