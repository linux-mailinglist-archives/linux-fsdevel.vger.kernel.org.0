Return-Path: <linux-fsdevel+bounces-42883-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDD7BA4AAE0
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Mar 2025 13:17:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAEB2172918
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Mar 2025 12:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 196D81DE3CE;
	Sat,  1 Mar 2025 12:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d0wAecDV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04190BA3D
	for <linux-fsdevel@vger.kernel.org>; Sat,  1 Mar 2025 12:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740831450; cv=none; b=LswnollxiVxQ/GMpKWC0bi0D3EIFW3pdoB3FTO3BJN+VinSB5R8pfGm1AGAADaDMiPGaQzebZPJoTPOSO0onQV52ofcUO5YdKct0ek/HzNVKaLI60id1Sp01wptf222SXyTE8/98ovXa/lLU5CxUAu/fRTshHfMI+3h3Cl9NQFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740831450; c=relaxed/simple;
	bh=Ipct6Go1kmoL0WQW1WVM6MTZ9CSZNRNOFBLf3PrRgr4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=EwrQ9TRU6ErDpOguBK6nzXoMcsF1zxlG1LEbosZOJ/1CcyxuTXAVRJHr6XizoktHSvlPRYMv7lbPaB1P6LiRATH8/FjzJzuBq8T/5mm4jAfbOF+CV9j+9MMxoLdeNga94xDAouLP2HgFyye/Kfa3/PUrmYBqANuqVpRBjsibBEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d0wAecDV; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43989226283so19056725e9.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 01 Mar 2025 04:17:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740831447; x=1741436247; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TS8hRcBVMFupMwpCR2cx1lD5donEFlGluHngi7Yx6Ic=;
        b=d0wAecDVd9nDvtWW1QeG3ocBhmx5l8uUq7Yyq1VzXYsddYI52oiX0oMknvAX1BC1nk
         5VrpcBWDYVq60xH1Z8pV3KuB2B6AFbV2w7XiTsogFni2qBII2Ga8R7lZkbNMZaYeaSvC
         Uplib8m+EvV23QIahWmZ6eTL06q5Q+q9NSaWMLcQ1Qb0SRzEaZ+N25w2qiBM5MxzfM/9
         qwgRBIAtnG9SEZKtvCsBbGokqxM5AXDt6+syT08nGn7NmXFhvDJhYkdGUA6H8oCrcWn+
         lkeWREJ3YgrO9TOG+fXA65QzpfvXqjkuzIyZU5m5UUQnsZ2mDx+3D1XeXeLPdQ/PQZ3+
         lC4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740831447; x=1741436247;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TS8hRcBVMFupMwpCR2cx1lD5donEFlGluHngi7Yx6Ic=;
        b=J2FhkiL2LGEWdcnBJsgwpsU/+vfiMpjo1/60ri69hYCRWyEJ+sEE+UQ/p+4vQVXXuM
         vVXCvoZhWjgfHMiHHd+qdTWPzP+2DLR/jaULjYyxcIq93lh7g9iTkz+qinr6r/9td8ZN
         745Kp66cG28XZ+BLkfwCfSOkYEzDVEbnFQjHjdXc3gKm8icUv94R6zf43kH7PfJfNN7A
         xgEOoij7/yrWvv20riY4/B0YJ7MPmnqHPFpbYkzJ0IIlMr5Vl+bOIskEbx98OGKgYt7+
         BVHrrHjGa2Fkes3GCmQRKEIDMrVyPAHhOlfZaLyePybZq7nsvCHpKoaI1zN2L8Q6mxS1
         55Fg==
X-Gm-Message-State: AOJu0YwIoQ1BjRTi27NfgkVHSY9mk4XmQYDMR5+esyf/lKUAXRvKvkRl
	mLhBYdNiB9a7IIYi2g0i4vyOLTV+00K/BPZOLELLyN5dXPJe9bw=
X-Gm-Gg: ASbGncu9Smd0q2IDSVoY4zZfse+pAQzlyr8bWaMrrndwxGg+guCQRLQnd1X3OHDoeHG
	LfUinhv7/V3PCQLwIKhhNpEeJZWWZUzErw8cVDqZOFdOwS6Q8/cAFf12mum/mYKF2YdQhnL3iAT
	gLeTE95EdoDMbgQY2TTrmHGZy7xoSsV+S9SlqzZ58zSYbSvhoZHmH8e4lYhua6zWm/L5lYiYKeK
	/4Ff32aLjyZMJ/blpY7kcj++btEPulQCxaxeokhBVcBikBnBdoYU2xJyrsyE80YAsRHhRpboQuW
	XQdbB/h+yBnoMBaqx9t8Lwc4EPEqa+4gwSIw7nPTCs4Q8ACEsvcJ3741IWBffsYlDTOjM/HZKg2
	9bxqFxPL7DWEV0A==
X-Google-Smtp-Source: AGHT+IE6eFM5OW1g1MQS70mPNI529CXNSZQ1GSsnfo1j2dHqVBUIF5y3bD0DFJZnCSdFu6muoMZI6g==
X-Received: by 2002:a05:600c:1615:b0:439:7dfe:f12 with SMTP id 5b1f17b1804b1-43bb4550d41mr2688435e9.5.1740831447044;
        Sat, 01 Mar 2025 04:17:27 -0800 (PST)
Received: from p183 (dynamic-vpdn-brest-46-53-133-113.brest.telecom.by. [46.53.133.113])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e479608fsm8312890f8f.14.2025.03.01.04.17.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Mar 2025 04:17:26 -0800 (PST)
Date: Sat, 1 Mar 2025 15:17:24 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Neil Brown <neilb@suse.de>, Miklos Szeredi <miklos@szeredi.hu>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Subject: mismerge alarm Re: [RFC] dentry->d_flags locking
Message-ID: <40653779-6123-4def-89e4-14eaa2864e35@p183>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

> +#define PROC_ENTRY_FORCE_LOOKUP 2 /* same space as PROC_ENTRY_PERMANENT */

		Mismerge alarm!

Can this go to include/linux/proc_fs.h, added to enum and
switched off for modules (#ifdef MODULE)?

There is ~18 year old(?) /proc UAF being fixed:
https://lore.kernel.org/linux-fsdevel/9760f1ae-7aec-4e17-b277-ea6aca13b382@p183/T/#u
https://lore.kernel.org/linux-fsdevel/3d25ded0-1739-447e-812b-e34da7990dcf@p183/T/#u

Of course "proc_flags" enum should go elsewhere but this is separate story
(maybe it shouldn't).

	/proc/alexey

