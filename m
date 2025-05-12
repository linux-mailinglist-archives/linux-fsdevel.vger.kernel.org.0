Return-Path: <linux-fsdevel+bounces-48704-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B4AAAB3128
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 May 2025 10:11:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97B983B2E0E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 May 2025 08:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C95E25745A;
	Mon, 12 May 2025 08:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="QuDg+Yb4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC5AD257441
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 May 2025 08:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747037454; cv=none; b=ZUswE6Vj3ff0SCfIz7/+oOyVCDZz8XQpAGYIBdCjIXvqODVAGKdxSII0sMHYKC6yAOLB8S4rQuxHu5RBsR4IKjgVaoIXDxPZFifpedqiULqV1e6iJHPbf/txUSDSNPuRtHEbdJS5s//6/2pgbrSrnBM6nw3k4jCOMoLL/aX49fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747037454; c=relaxed/simple;
	bh=BOP6Uw6zm7kXZhT9LMuJCWcMldNLHWkHgkN3+glNCvs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EOC3ueXRMcQ1bL6hKeJqLWm/aePMHi++6bnNKlo1DErOzE3RkJP6qXmJTtyyHda8/4groz2uBvH6P/kFtV7q3nPUL4TxJmE/q+t2c0egImzTWbzn1/lP3tbQ+5fngUelh4IPyM5lQk4bYbkD7eQWFrTAti1AEr8QD1DO4YAyuL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=QuDg+Yb4; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-476f4e9cf92so34696651cf.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 May 2025 01:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1747037451; x=1747642251; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BOP6Uw6zm7kXZhT9LMuJCWcMldNLHWkHgkN3+glNCvs=;
        b=QuDg+Yb4FoyhWZ7CnOsbbrw77oYDZczjXNHd4CPBAR899TYUPVigb8cMBnwHxItjdM
         c0Zkpa3CBi3NVC3qQifXIdqVuNk+p//XpFEaIIG/Y5RnUL+M5BwsVUf2CkDXflr968GV
         70EpHTuFgURd3CGYTtkY1cATZs9tVXOhOCiKc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747037451; x=1747642251;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BOP6Uw6zm7kXZhT9LMuJCWcMldNLHWkHgkN3+glNCvs=;
        b=RmZf4K7YGmUD/XvvAASoGqiTJC5Xu5CSKaCMXwIjKNhCapU5RVBsWICVqDXQdL8t/L
         Qk9eoevtf/h9rKVeaJtxgyv/AIg8xcvqgW0rZYilrXRasdzj1nuVyEirbCIn4DB1337y
         j/xpSxMCKSymWwBiuI6Gmcgq+CkSp5B3+/pFrXHk/DDrNfFiZ/q6Af/8YbmuNgJR3sW8
         S/JXn3a0gHuIKi+7z8SEQNii59wjNFJFJSWkmO5w5esxKkitkRep7gMQwdltqQUmDQ3h
         ul9lT+XvjhN/Rp3kC1AjIEo/XJttXzty8/JBN8huNP3LGzcjIUsWirXOQQxWVjlGDtqT
         V9gw==
X-Forwarded-Encrypted: i=1; AJvYcCXmJW8pZ8w518CZIKiBdy8zJq5swmjE1UDf6mFYT4B11qO2zcc1zebv6PnmTYXiArCLW/SW8l4VzMVvdOiE@vger.kernel.org
X-Gm-Message-State: AOJu0YzCgUJvT6E/hYSpoQK2uhJtZhglH095k7FXbjpiEd5rjDEkDZkz
	q2dCtpQqE2snGYEfsHhgL+islEo8Bk9xM59We5DCYv3tIN3SO5SXad1Jk7hs7H1Kneb5eMfDxc4
	1fTcn256aFhshdudlooc9RUlzNhvDVr80XLRhrw==
X-Gm-Gg: ASbGncs3LQ0A8aGWpUJWnl/oUyKp8n1vegAtt+Huwm0Lg3qG3M8MWiGIVuCVnUYBrxh
	GAe+eQY8BjVPG/1ILW/FB8zFwH0vtNkSdpktperZXaJjVa7le1GxVc/b45sQJV/mNuwUrBsXh9g
	LFdShOtn8bFgELQFrS1kQpWq3lalJm6LDhWm9usf/n8okOnw==
X-Google-Smtp-Source: AGHT+IE9riVAa+kf1k7H/s/DMg0+dtkLLuYpL/QwjZJPyX/AyxDSXkoHgrrw6V5TpkgnV8ryhPngQ9J6/WtkR8aF34o=
X-Received: by 2002:a05:622a:30c:b0:48a:e2ec:a3b4 with SMTP id
 d75a77b69052e-49452744396mr167098991cf.17.1747037450856; Mon, 12 May 2025
 01:10:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250507-fuse-passthrough-doc-v2-0-ae7c0dd8bba6@uniontech.com>
In-Reply-To: <20250507-fuse-passthrough-doc-v2-0-ae7c0dd8bba6@uniontech.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 12 May 2025 10:10:40 +0200
X-Gm-Features: AX0GCFtoLXIKOqkBSTvl2qMeCrxjYdfhogIog4A5r7OHYgoDzEDxfLUMnrE1sJo
Message-ID: <CAJfpegt46sKDJfB0V=1Db43VjoZQ-nxHuCVQU_k-A_AgxqnPVw@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Add a documentation for FUSE passthrough
To: chenlinxuan@uniontech.com
Cc: Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, 
	Amir Goldstein <amir73il@gmail.com>, Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Type: text/plain; charset="UTF-8"

On Wed, 7 May 2025 at 10:42, Chen Linxuan via B4 Relay
<devnull+chenlinxuan.uniontech.com@kernel.org> wrote:
>
> This series adds a new file,
> Documentation/filesystems/fuse-passthrough.rst, which documents why
> FUSE passthrough functionality requires CAP_SYS_ADMIN capabilities.
>
> The series also updates the MAINTAINERS file to ensure
> scripts/get_maintainer.pl works correctly with FUSE documentation.
>
> Signed-off-by: Chen Linxuan <chenlinxuan@uniontech.com>

Applied, thanks.

Miklos

