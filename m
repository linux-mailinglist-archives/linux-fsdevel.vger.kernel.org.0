Return-Path: <linux-fsdevel+bounces-27815-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9306196446F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 14:30:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2D361C228C5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 12:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7499C197A6B;
	Thu, 29 Aug 2024 12:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="U0VrUGvi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414EB196455
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Aug 2024 12:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724934589; cv=none; b=hV52tb/xIwJcA8KdMnJsgcg4xdB/fERPlHbIAU5w3QUyXj60mGVDA3TEDQmvjpIe3gefJvtev5lfFxli6g6G5YiwoCRTaXj3RKoTc2mlwBRNH17TgP8Bqo+2vmoEVz9zWAt1vCU7okHOmGIa+7CKzJWsR3jZdNFvhU9mDfcygFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724934589; c=relaxed/simple;
	bh=FGHM4XNfa/cVlTtzzUXPSLt9FVuJ0sM45yJhXV9JDCI=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=igP8k3WavbmpKWOOdWVPuLOnvO7FGMfUbKQA8OIK2ClmR7LG2nGFG5UqykD5Dm853FatbN/UrCut9XDZhTkVQwTQuzNM3kHN2bVoNPdnbkgFpEslE/5xMkhjoATTmvK/Iff1RK8sXqMgoTxDBKa5I4EV2e5nKSdXtBKj99Cf9jE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=U0VrUGvi; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a866966ffceso3143466b.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Aug 2024 05:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1724934586; x=1725539386; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yi9q0gAo3pbGHakMMQ1qlw9QBFV5RKXeNwADykw9ibU=;
        b=U0VrUGviA78NIc/Ny3WC9WDWYTagQ4y7ygBmpezMpJ++bPGjwm532NF5Nh15Ui3hgn
         sFLeUqDVMqdgRqQGY1XKfPCsckeYQJvP4ud+nl9GVNrTUo8xgfT+/jM8Y3R9pjfWM+Jw
         K4f6r0E2/KbE/Ut8EDsDw5xF0zPs0tsx7Rh1yVlAYwiuYWDtv5MJmWvp8mdbEzV1RiAl
         bqhHHFRH/9kZDUzjFktg7GlrrAItQG5UVuYI4okwbXSvNSBKZZjRE/maGUY8P9mF/MY6
         wxdZfYRu0diPFHbEfjmfDEnYIafGEuI1o0s2nKZxxBJgLJy5UC5cZ4EE69jHyP1nLYXE
         F5Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724934586; x=1725539386;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yi9q0gAo3pbGHakMMQ1qlw9QBFV5RKXeNwADykw9ibU=;
        b=pXJUd+l+M0JWGF+BNHP52NUnZkI6CikiC2glqKfSc5ri1e1nggkHFPBSrQQoNc/D4p
         aJYRKeTxsa+1/5BNTmSAm/M+Wsuos+SoeFh88Z9BFnqXa9cn2aluG3LsKX0fvTtlLL2Y
         Mhj1ZDf5x/UGU2XUAwvZAPdpgPjb2OliDlBx/tgTGAGONh2TrVI0zTVE76YxKKzECztd
         H/8j0oPKVTvC5wlwNJ4HiQFTF6dYNJ0zJ7d6Md70Kd1+8B18lFAOolPZ7fpBpS/wVI1f
         sEoc9756mLTp+QnY7Ap9DgMdgJo8lYzwvNZanxIJOPfUJ8H0qoHfRWQLeBfivlt5kj2J
         TS5g==
X-Forwarded-Encrypted: i=1; AJvYcCXfhg5gXi76ve64pC1ttO/cJcjgFDaV2tUIxv6q5UKV0HQTrl7kZZKNWuEFVDKtRHoA4qnE8ITDZzLS0cH7@vger.kernel.org
X-Gm-Message-State: AOJu0YxSwuj8HI0huTY2eCxBZUDMpdKj2s7R0wWwBynD//xtG8IFBqNl
	5p5JbEiCVBA+VzbSWyADbBWrkuSDKY4rmj1J4SQh4AknzkhT0fMEOsDnPJwkpTw=
X-Google-Smtp-Source: AGHT+IGC9nmjU8Jg5RFOgij0MQ/hzj3G8U3KttB3SuxCDoCApdLe6XuQc8iokX8LRBfJC/kKOpynpQ==
X-Received: by 2002:a17:907:3d88:b0:a80:79ff:6aa9 with SMTP id a640c23a62f3a-a897fb15d30mr118842766b.8.1724934586358;
        Thu, 29 Aug 2024 05:29:46 -0700 (PDT)
Received: from smtpclient.apple ([2001:a61:1050:bb01:2965:1b4:50ce:19ef])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8988feb0f0sm73372866b.20.2024.08.29.05.29.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Aug 2024 05:29:45 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51\))
Subject: Re: [RESEND PATCH] fscache: Remove duplicate included header
From: Thorsten Blum <thorsten.blum@toblux.com>
In-Reply-To: <20240628-dingfest-gemessen-756a29e9af0b@brauner>
Date: Thu, 29 Aug 2024 14:29:34 +0200
Cc: netfs@lists.linux.dev,
 linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Simon Horman <horms@kernel.org>,
 dhowells@redhat.com,
 jlayton@kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <4A2EAFA2-842F-46EF-995E-7843937E8CD5@toblux.com>
References: <20240628062329.321162-2-thorsten.blum@toblux.com>
 <20240628-dingfest-gemessen-756a29e9af0b@brauner>
To: Christian Brauner <brauner@kernel.org>
X-Mailer: Apple Mail (2.3776.700.51)

On 28. Jun 2024, at 10:44, Christian Brauner <brauner@kernel.org> wrote:
> On Fri, 28 Jun 2024 08:23:30 +0200, Thorsten Blum wrote:
>> Remove duplicate included header file linux/uio.h
>> 
>> 
> 
> Applied to the vfs.netfs branch of the vfs/vfs.git tree.
> Patches in the vfs.netfs branch should appear in linux-next soon.
> 
> Please report any outstanding bugs that were missed during review in a
> new review to the original patch series allowing us to drop it.
> 
> It's encouraged to provide Acked-bys and Reviewed-bys even though the
> patch has now been applied. If possible patch trailers will be updated.
> 
> Note that commit hashes shown below are subject to change due to rebase,
> trailer updates or similar. If in doubt, please check the listed branch.
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
> branch: vfs.netfs
> 
> [1/1] fscache: Remove duplicate included header
>      https://git.kernel.org/vfs/vfs/c/5094b901bedc

Hi Christian,

I just noticed that this patch never made it into linux-next and I 
can't find it in the vfs.netfs branch either. Any ideas?

Thanks,
Thorsten

