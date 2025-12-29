Return-Path: <linux-fsdevel+bounces-72194-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A1D57CE73A0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Dec 2025 16:38:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7EC363017387
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Dec 2025 15:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93A06324B3E;
	Mon, 29 Dec 2025 15:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fqmRja8U"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E28726CE2B
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Dec 2025 15:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767022681; cv=none; b=ls/LrqLHfTjbyfZacnBZF+b3ZAu8CTHBaF4PIJnnWhmvWWbFfEDA4pqmPp2rSj8Z+rzpoeiMQYHdTGt/7s5pcF7ykNAlXQzj0uW569SjdUmsQGPN0UwXaSZQCkoiVkE07mX6oL1Gggb3PfwEw7IFNPJaRAl61zHJh9GMLE33Npo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767022681; c=relaxed/simple;
	bh=M+n/asYPRZ98K++RdyjAiMXrIWu//u7uquWLSZ2T2pY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UJJCjucgJ9kkZjvl385c1Sw3z6DtJAjndBnTaNWsqzwUFuCWLqfp8kGN6RmTff9V+ETV+z1R3BLBjpZy2EzfdA7OTKcB+z+hHZIJG7tgkgA7tjnYIDdoNS8VL4tUxhXR8Eg/A4uos6VjWEs2vZvdLH85LmjgJAQTRxVf5FnUcpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fqmRja8U; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-64d2c50f0d6so10463072a12.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Dec 2025 07:37:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767022678; x=1767627478; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IQu+3cek+G7ype1IIG96TrFy2B8q2Y0rPO9MgBIDIdo=;
        b=fqmRja8U+ic2IpRytBYAJ/U2STg9wG0dPkgOA3iir70UKxukldnhUKF/qbMpjYyKC9
         iInLoi5mqP/0nZ1TIqDhpeUs2wSpxDTh5Kf0J8cdt3xtQv4LJ1Lf/a98pf0crNIoCU6V
         HZ0Mg7S/OXkmjL05ZardW/ruiheTQ8rswjALsms/CpoEpFdz08SSVxOlPV8FUN98Gx9b
         JDMFMCIoljtZZomnZMyQ/mBCs1r9HFzET1P+Lc8CZzhc+89BPzWrZOoLZ6WXYOCruJrk
         wlUd+T5Gdl0uTud3F7HmjEjpPQHJoLI+wi6dXbtkE9EfMdZJBXFlMLJSMyvbgqtlFNzK
         5/zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767022678; x=1767627478;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IQu+3cek+G7ype1IIG96TrFy2B8q2Y0rPO9MgBIDIdo=;
        b=keD65BrlHrFlzqeSDZ+aQkpbKPtlWkENYxKeDOOCdiMN44SCiBCQG7Si2TeF72zMHR
         k1s+OlPFvmKpLzd1NHSukRUpSh9iNEpnBxhXhAA+D/qT3LCQemxvzEFRrSFwCsniuBFR
         wI8fg5D8PtV5mnYcIbhJ7JH9Zq4e7L2xKDT5jH3y3hjTmXGtbsLfYQA1xtIPWFa1foiy
         Kr8rHo/r6iCpZEk1DBmERsVEuth0O9paU1EhjcmYzbaSIxnOG2gSx87Fs/JmRLdzP7SC
         g8ajq5ZBEVA/VK4hCK/mWnpbGl7HW7lE+APuaqtOlj662AFoIyJk87vYzoP92etgTp5O
         CIuA==
X-Forwarded-Encrypted: i=1; AJvYcCVIHlHO+BNiz9RcEIc7JdamB9siuyhfLbuDV1OzOO1cakOmD6KkbqF25R9YyV7Oja2sRWXbkyxsC4xknz0q@vger.kernel.org
X-Gm-Message-State: AOJu0YwQY3MS06Kft7bC0DhZ8+amoIz257q58Oyuj2yH4C3vOefeOifC
	f4W2nSdbjr6HuuIW27UFKuJ6/Dl3/U+e4y24bkOeFF4C0fIkPl6YMsL9B0C8QipyZ+/YbIBmNZ2
	zPvWvCjZsXREG1NLv7VbEtj2WNq+jDgg=
X-Gm-Gg: AY/fxX6ravOQNEGDW9Paz/8jd9MZQzZRsOiR5WLCW+gPgtP9mEGCpnRiAneSpAAyOGI
	rKzyOll2fSBRQ2ZghY1EUj2wenJCphyoxBBm0cqpwwWq9j6QHSm+YmG62Ed3jST1fWxilqljKtW
	9j/2hqulvY+dkdQLZwbGV/p/2fkMFX1cOVvL41O5WYM9/0cwpUpY+Fj2AIM6FgjdoDKTV+Z7DFr
	ZRyIAHO49yYERrtD0dc+ndelrPPVEpaMMS/+O9hqLl5xg2/De0SaITKy8C4oykERvm7JEis9k0g
	sxkY+5PRY1AMtCsUYeJ9UFJGejjnbDy6iakLI+io
X-Google-Smtp-Source: AGHT+IE6xFIeeF19mSrh42z2GiQ0duCwohZ1aP7gaVHuMpU+1c32ls+61yK5U4ehC0J49R809Nd6HCDmKFuUS6HIBQ0=
X-Received: by 2002:a05:6402:20c4:10b0:64e:f6e1:e517 with SMTP id
 4fb4d7f45d1cf-64ef6e1e6f0mr1078326a12.32.1767022677818; Mon, 29 Dec 2025
 07:37:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251229105932.11360-1-linkinjeon@kernel.org> <20251229105932.11360-3-linkinjeon@kernel.org>
In-Reply-To: <20251229105932.11360-3-linkinjeon@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 29 Dec 2025 17:37:46 +0200
X-Gm-Features: AQt7F2p89_q5uov30h9xAw05QkRLxf2leG3dG7NYZNYzzuOTl7_cLgh5rlEE5LM
Message-ID: <CAOQ4uxgNJT5+rGG5=yLwDhcSCBuFVr+jPZmYcM2q6OOpHDs67Q@mail.gmail.com>
Subject: Re: [PATCH v3 02/14] ntfs: update in-memory, on-disk structures and headers
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, hch@infradead.org, hch@lst.de, 
	tytso@mit.edu, willy@infradead.org, jack@suse.cz, djwong@kernel.org, 
	josef@toxicpanda.com, sandeen@sandeen.net, rgoldwyn@suse.com, 
	xiang@kernel.org, dsterba@suse.com, pali@kernel.org, ebiggers@kernel.org, 
	neil@brown.name, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	iamjoonsoo.kim@lge.com, cheol.lee@lge.com, jay.sim@lge.com, gunho.lee@lge.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 29, 2025 at 3:01=E2=80=AFPM Namjae Jeon <linkinjeon@kernel.org>=
 wrote:
>
> This updates in-memory, on-disk structures, headers and documentation.
>
> Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
> ---
>  Documentation/filesystems/index.rst |    1 +
>  Documentation/filesystems/ntfs.rst  |  203 +++

This does not belong in this patch.
Should have been part of the revert patch.

Thanks
Amir.

