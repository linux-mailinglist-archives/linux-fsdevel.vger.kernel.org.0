Return-Path: <linux-fsdevel+bounces-38414-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 82C17A021A6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jan 2025 10:22:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AD101885244
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jan 2025 09:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DF4F1D934D;
	Mon,  6 Jan 2025 09:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="jNtHuX41"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C2C61D8DEE
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Jan 2025 09:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736155308; cv=none; b=J5QnkIvEptqGk/6QOTgVc9IvBumNzni54qY5HHJTiRKLgVIfj5F2QuYWGuANRob9LcbSGC9usz8c5bQy0+cdE9t+jm6aWObwdZ03/wAhG8Rm/0jj3LH9DGDWYp7xMalS+iD9Y/gDD00gr7AqW72ikbt1b2x7agAhkAKhVXnyOq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736155308; c=relaxed/simple;
	bh=o+kXTplRVUCUvhEajnIjUGWu05VGVRRba7eVIYEAOuk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cg2VaVHtB/RbSQx5+9y8SM7tud5hHyFZSE6jviQIvytk3EX54/HKZMhmBUx0ernCbnwYFacMBhTAXwofbO/B56StFI8Vfs13AwL8aQ7pCX83B8MaunAhCIySuFIUmkWFPLAJ+wPaPxo/hj+/hsLLrHomIASqtSbQL4yyJFL67OU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=jNtHuX41; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-467838e75ffso173469801cf.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Jan 2025 01:21:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1736155305; x=1736760105; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=o+kXTplRVUCUvhEajnIjUGWu05VGVRRba7eVIYEAOuk=;
        b=jNtHuX41fUg5w1wToPpW1AQSg7NXsExsROj4oE4E4ul7FiGqyTNp8sKCV242GXTy3r
         fsRztX+3N0bNaXANcMVCfH2hWAJXgTmhHA5XZa9mw8lhb9eyAbazLZFL4HUjl402xq/r
         JzSsj/kvLqxAYJJeXD1HsQqRM6rm1Ur5uLCvU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736155305; x=1736760105;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o+kXTplRVUCUvhEajnIjUGWu05VGVRRba7eVIYEAOuk=;
        b=OGfpDhHzi4KaqV/hUVDSEjBeGUu/zgnsH5rjEHMrQumxB64oj2eFHhfJavOre2Zioz
         7Zw4B8EZXSS3BYTlZ3ZnEqrGBCemtnUucMNQcUC1M66qcr1c8z2E83hJM65SNdmMFj28
         qL6LHrBa6GJ0ZX32BX0iG8JGW3jcMK02rKDi4gjONKfck8Idr0+5ox1aIAh6ciMR/SEi
         3UQJtqQLcdzsssWv647bwEedYXfFojoav5FjpX3qehFFpOh43oUTvpUMScAxZzw/MJy6
         KLTAxbHvpV9breXblMeZd5TKiLhaLqFqAgbFCMXaMB/FrFWk1rjr0RFVbbYGTI3cDOvG
         InQg==
X-Gm-Message-State: AOJu0Yzl7HWymfdVlGkQy7UxHOCMVd/bNmpzEb5dQsv8T/tfMBLfLKvi
	9X6D2uq40OnaPsuQiPXqzL8JlgHmPFgCK6+hWjxRwVDfKHAHrTrBRR6rYL0M+6q7v10DANZdCSf
	G+7pi1enxGBnmQujIbYBtfzW6jR8jaLhx/1k2Jg==
X-Gm-Gg: ASbGnctlx4RNxCNYb/p+/gAdC8tw2PE2ZcTB0aYS0gVALe9GP9gj0LrNC8xrAYhn6jv
	cf7trpPmQMt1OSF5/8Et/K2CTvnHw8wagAec7ew==
X-Google-Smtp-Source: AGHT+IF8Ds6ghfbOGGDbhNh6X9Y8CqcczoY31NSOWdgQapCpIVDNnkjA+RlTfwrKVoqDUHnGcUWziAyULUaL9wQZZLA=
X-Received: by 2002:a05:622a:1822:b0:466:8e3a:e6cb with SMTP id
 d75a77b69052e-46a4a8ea644mr864262471cf.29.1736155305347; Mon, 06 Jan 2025
 01:21:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6773ed41.050a0220.25abdd.08f6.GAE@google.com>
In-Reply-To: <6773ed41.050a0220.25abdd.08f6.GAE@google.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 6 Jan 2025 10:21:34 +0100
Message-ID: <CAJfpegvukv7oXtvzCFwSGQScPDzW9xerpV8D6B=pEVJ8SiU=5g@mail.gmail.com>
Subject: Re: [syzbot] [fuse?] BUG: unable to handle kernel NULL pointer
 dereference in fuse_copy_one
To: syzbot <syzbot+43f6243d6c4946b26405@syzkaller.appspotmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

#syz dup: kernel BUG in iov_iter_revert (2)

