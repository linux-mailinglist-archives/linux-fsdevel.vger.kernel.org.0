Return-Path: <linux-fsdevel+bounces-49473-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A5E7ABCE73
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 May 2025 07:15:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE69916C247
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 May 2025 05:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCE8825A2D9;
	Tue, 20 May 2025 05:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aXCGjr3o"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E8C211A07
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 May 2025 05:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747718116; cv=none; b=q44a5H21SrZYSvQGdHnSEZl7sJjQESZinVqq5BYIjviknnrM1izu3qUNSd3892AiwQOTYf38djqX7KNOaKh/Ka2b01z99VzWXrfJcyjO41gnHXFqc7kw2edcxW7HSfKrCe/a9O1NX0VFzy055/9RM9xVsgdd1Kg31SkxeuWs7hU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747718116; c=relaxed/simple;
	bh=l9uDPeb1Op/lAHJBHz3/JUe5Uu5x4M5WwnU1yD8OyEg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=tZs33QtTuMx3RPUe+rNwM8kw5kHInpTSVwp/nwiMmkvUu5jNBnAE2sAiSOVfLy5dMbw0R/dDPYhuFrid7TfkO14BKORiVgYt89t6NUI+ggS5P9q5+2xLCwFzz4TGazwQjyOCjiWgiO02IehR1kIG5fD+rAi+1VixFhsTzduTHWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=aXCGjr3o; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-74264d1832eso6774361b3a.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 May 2025 22:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1747718114; x=1748322914; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HiysgefIEzUO5GCfnzINSaq9Lwavqid+wd8gv2MrulE=;
        b=aXCGjr3oAnmba8NWuijKcfoSXZWyGZ6nuFFSkRTlC/KTmWp93TpjIj2R364sotCvYJ
         2arRcrLKgVMLyP8uESmzFmfOGy61Abb/EyU9V/YlHYIBjFk9F7y+8TheMG1JwR7BtILA
         hR0I92eCrsMYos8c6XtVN6xIJlBSqlexMkudc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747718114; x=1748322914;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HiysgefIEzUO5GCfnzINSaq9Lwavqid+wd8gv2MrulE=;
        b=iS6nkx64GvaClrkyLmXShnJxvxZinnO5JJxsQaKc9YBV7tE2Ccv04Li2vpy+vTYIYU
         tWCfSJv7Po5D0ggzRLtPriBBmXJHGVghQyHZXEa2/VMm6T8lMMuLtDJ7wPpyVJuiS2Yh
         JJ4e6f+3ucS/MrdA/3YYwSfYf/hSKu3nqnHYOUVKY82P+CqjVdT6S92kfPmwePABPIph
         WoG9YLgW9wUg/iXRvJ7obthOOKXZgBw0jUcesF7WWzzVwY1XGQP9ZTVvSSLDlBWdWNmB
         mryt46kzjpXziepybqSrejBJuXVA29AM1UsDzRdXF1OXKSHLyF3Sw7sEFYaCPRb6RPWH
         +BtA==
X-Gm-Message-State: AOJu0Yw9L2Z07gEH+ZC4eESR4bJYpnvaD0BzJ12Nc+kCCO/bqCwc7DJL
	ENB+XRp0AFdi+U1W5jKf9lajeDtqxgkptm1XYHN1xTWvTl8NODUbWgk4du6tKr/9VQ==
X-Gm-Gg: ASbGncv2DKTQgaHBvf07YKArIEZNFvFPL213imLwE3MiLEFWsX/xCXBMe1WAAMVDOxo
	iRBuhfY5wbyZPI9EG2vIDYrQX4nfTlA42GJOsf+1jEZaQTWyGPyH7r3Q3pJ3JicsDYuo6Lr+AzR
	NkBgingE+4hn1fuksoppB82LLEKTVzX9R5sQWk8HjAxO5+qp1hRbTROBxG7HmgVyP/lCB7tbIeq
	BhYgl5bhx10AbaxoUKyLMst+56qr9+q0uGN+bMdBsbLupkbAarLEp8m6RjObtqWGKwfg8SMTZ7g
	Oey2+7bzyh2XCCNOE17+ta9Wr/2XWfvA7LiYlr2fremc1utnv5/p1B0=
X-Google-Smtp-Source: AGHT+IEFKnPKfgX98qSEHZHOpRkj8MQwEVAPRNDz/Xu8YBp0YmRXN4XOaVXMD+HIcDb1EXD4aQWuig==
X-Received: by 2002:a05:6a00:2790:b0:740:5927:bb8b with SMTP id d2e1a72fcca58-742a961837amr18032495b3a.0.1747718114140;
        Mon, 19 May 2025 22:15:14 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:451b:c9c0:8e9a:5e30])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a98a338bsm7362953b3a.175.2025.05.19.22.15.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 22:15:13 -0700 (PDT)
Date: Tue, 20 May 2025 14:15:09 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>, 
	Matthew Bobrowski <repnop@google.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: notify: wake_up response waiters on release
Message-ID: <3p5hvygkgdhrpbhphtjm55vnvprrgguk46gic547jlwdhjonw3@nz54h4fjnjkm>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

A quick question, it seems that fanotify_release() wake_up() just one
waiter from the group->fanotify_data.access_waitq queue.  Why doesn't
it wake_up_all() instead?

