Return-Path: <linux-fsdevel+bounces-58292-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C71F5B2BF70
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 12:54:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82662683090
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 10:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 729B4322DC6;
	Tue, 19 Aug 2025 10:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="BJTLR2EL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD41C22615
	for <linux-fsdevel@vger.kernel.org>; Tue, 19 Aug 2025 10:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755600890; cv=none; b=tpn+Uuvflf7rpXA4u5oV44vuC4Jgmip39JD2l3Qsv3NniOhZy4q6i38OJYLwYsmzB6r4kEBq4t9vExE80f9Y3AKux1MF95WzWEiRMY8sF6Ycz1wFvFO8yL0787IW4e69VIudtKJ6Rk8HLx6YB8YMT2eDVcZgb66ECW3PBs0NfjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755600890; c=relaxed/simple;
	bh=6yCHoVaGq+4SdzPbm/a2+uFQTdad0EyYgYe4cmXoxlk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M56cSQQvxXMQtdHhCZRVTf4Ds3qZW5E/wTXmN4HJRGUKCdCWVHZC03UrZCV6SeO2zpJyq42gU6RYPEDIourkzfmuzThyA+XXynbrvETVBZQTKzw031DwTchrnPpApqAkyXKHqLP/OpSzC3HoGQ2/jDzkp5RIF96gX6iTfXxL40w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=BJTLR2EL; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4b134a96ea9so20195191cf.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Aug 2025 03:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1755600887; x=1756205687; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6yCHoVaGq+4SdzPbm/a2+uFQTdad0EyYgYe4cmXoxlk=;
        b=BJTLR2ELRf/MVqCh8zo9iCGS9EpbeFMvrQ7m5X9MYOR74eO28dfLq6t7bTo7QbqzRX
         TJYDhzYAIGCgbz1NajUidQ6VUQ4EGxs/hO73BVyU602gprEOKhj+bMLElDIrParUF+0h
         IfEsnTxTfYkfzg3yalcY74m42Ef0kwLH+oczY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755600887; x=1756205687;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6yCHoVaGq+4SdzPbm/a2+uFQTdad0EyYgYe4cmXoxlk=;
        b=rIhe2YtXJoYJSjO0HrKXQtkBeAp8QOg6fKgcjrGeU0+cslG1BqRvzCnNnkK5mfUQgp
         64RgU/p4hs+ffAKwwgHn0497Q5R+DOo/yb+MMhmZo5OvsvV1HWfRpNnrQ5N/mHhQnZqj
         P8vOtQSu8EabAvvDQ7kFBxuAWY8JfjXSRgtCqhSedXV3d3+DpKRelbc2z3vlK39v4DCQ
         o8p10eCnLnOmC+D+bOLZZskHdxp1eg+3m8qLZyzeMeKqqkEWzfg8lFtqWvjGZbv/kc28
         O6qim1lyc/vthv7+dtnK6sDkLvZQTs0BIKW43TLa7aBSAQw/H5MVnRyGsa6JKYJenoCk
         hQlg==
X-Forwarded-Encrypted: i=1; AJvYcCVDfdGdt/c+4KU1yQuEqeLO3wJkA+LbVg2S5bWISp8QWkd1od2ztqz/McRq9h9gmT6uJDrYTrJLD3CmwmO9@vger.kernel.org
X-Gm-Message-State: AOJu0YxzRbafqSnQXeK4utoUORKyNKwFPHeV0xar7TygzI9yUbZshmPd
	eHFzvR4WzHpPgB8j6LzQyq8cU4ptLovQ72Jmrr3x2xZdi+mYPuRD4xbe4tobanvw5g3VkRRSU9O
	tZ7zleRSdcKsfII//HBdIi+JY8oV6H/chw2ItX1eGog==
X-Gm-Gg: ASbGncs2heQNBABVhmVVnCUI0uurl3OZtxq3FCy1n36ugL9Hc1dboLXSLJPtRq65fGg
	ZqI0nWb2ta8b7ma+nzU2Kgd3jbPnSqwtmy5cvPFs2UA7+9bofAhDrP4PPlRK1zXXGIZ5+tZOKnU
	sFvFoMMytaJKn2y+19nuWtmBXKsEmepYd/6VPTeZBmfQ7EX3xnvsDCHoD4OSTy1APApFwnU1cSY
	ralxWEwAw==
X-Google-Smtp-Source: AGHT+IGoA0MFmlo2xnMlSxpzDsHBCn43Y/FZNExD/OWKDz6VX3pZm1Ai94Gc4ty5kd2FKGmS9chdojXJrkCtR7ErajI=
X-Received: by 2002:a05:622a:4e07:b0:4ab:80e0:955f with SMTP id
 d75a77b69052e-4b286d1c17emr22020411cf.34.1755600886672; Tue, 19 Aug 2025
 03:54:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250730130604.4374-1-luochunsheng@ustc.edu>
In-Reply-To: <20250730130604.4374-1-luochunsheng@ustc.edu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 19 Aug 2025 12:54:34 +0200
X-Gm-Features: Ac12FXzTUa6B2gqZdV53Nbqmh2rOu1I6mJta-4Jhozqr_obCpMz3u73DhKy8jF0
Message-ID: <CAJfpeguVSwfgR+O2AwpTof-k3g57ZCkS0mfGLGYT23ocSqDNig@mail.gmail.com>
Subject: Re: [PATCH] fuse: remove unused 'inode' parameter in fuse_passthrough_open
To: Chunsheng Luo <luochunsheng@ustc.edu>
Cc: mszeredi@redhat.com, amir73il@gmail.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 30 Jul 2025 at 15:06, Chunsheng Luo <luochunsheng@ustc.edu> wrote:
>
> The 'inode' parameter in fuse_passthrough_open() is never referenced
> in the function implementation.
>
> Signed-off-by: Chunsheng Luo <luochunsheng@ustc.edu>

Applied, thanks.

Miklos

