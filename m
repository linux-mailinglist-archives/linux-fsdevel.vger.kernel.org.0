Return-Path: <linux-fsdevel+bounces-13627-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BB03E872181
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Mar 2024 15:33:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C5BC1F23241
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Mar 2024 14:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 697DC5C610;
	Tue,  5 Mar 2024 14:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="FPvfMNsO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 518481F95E
	for <linux-fsdevel@vger.kernel.org>; Tue,  5 Mar 2024 14:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709649188; cv=none; b=ZK7AYb7gv9FfXEwq3+X0/yBQndQgWsye1GSOqeIYvnwL/QYxDS5OvNXopERDXveGR9ZI7NwSScEI5RoLwVydipDQfFTw04m/QVyG9qzK97vK4bg+KZ2NqGo4961QXoFUFNtiLM2z4oD6ggmrfky/abfJH4JcGtnCQ5jDP0/ZSSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709649188; c=relaxed/simple;
	bh=X3osxuXjIttKURCzFETBwIDv2CVhPf8fUO7rGAAuMv4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OJ6ontEFOoH3Okuu+VI+CUrDwqYS6DsekUw03UFTsyTkvauR9ZHDZtSKqtDVtGUkg4v8+vSUECtDGXN9MbP2A6TMSHSVMDJPd+nCrzKbE0V9HHmdpgkSp7o659ocZykJXLLrpC/6Udk0EdjxCSdgM66jsgIv1ey7vWH9XrateYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=FPvfMNsO; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a3ddc13bbb3so1123922066b.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 05 Mar 2024 06:33:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1709649186; x=1710253986; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=X3osxuXjIttKURCzFETBwIDv2CVhPf8fUO7rGAAuMv4=;
        b=FPvfMNsOtB2Z04cVXUt4lkuOcORgCN8ZJMgo9ohvhQol0M2ql3gFNKR8Z6b5xqBPVS
         BumeQ7TYedeFieKXznOVkqYSDj1gQaV3VxQpIwA0PxfxThu12TUZyXMcKEyMqCjRF2Wy
         2BXf9GRPNUpdncJbpYrc4GuyjAGCSFk+2YP9s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709649186; x=1710253986;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X3osxuXjIttKURCzFETBwIDv2CVhPf8fUO7rGAAuMv4=;
        b=kOI7uiyhO2tAggVv/Qs+uV+br2rPsQLWhgezfhEOv+otH20/XMfs4bZQBE+I7Ve/Jm
         yq802YPLDwjytnMQ5kwQCqOLZkPPEUqfhn1mm1FjUPRfWS1dwcchatr5DtCyPDX1xzuX
         dyxEhlEqiAC02uKeWGCw+26SUCHYJMxtna+3TwF9JvUzb0B6sRcbeZU4Wjr2xZgGhtnC
         T2EB11z8lVNzFlUuHkdYLDV5tKJSQSs4sdK7Jo6maYwzIrLHAfJkJCvhsvWgxpLP3vA2
         6XcxbCdK+ldzXUNqghcytqqw7d6h5SvJei4d3de3T64Hukp/msO4BMd6NRQ/x9AIoFR6
         XjgQ==
X-Forwarded-Encrypted: i=1; AJvYcCXXQS+l2Hbhk93DPUwIV4HE+PiMFC0V34vJomcW9V25hFtK48NLh5oQrnWlCLCMIaSx2GCCk+cHF0ZCTYziWiOLh08+ylzvqPmP7xY5pQ==
X-Gm-Message-State: AOJu0Yz+4XSgSSPy51rks1G4XNskoWmncbmdep+1Hftxsp1Vu1ZEFsr0
	bNHCwA2wCx5MVs4pU3fDS4jGeAYUUKgsNMA3xmtWn8UYbEP9FaZ9UtbmO8nAIei0ZIFwwhfih7S
	rRI06QTwdC2YTN1mJFxZ8nf/UqPF0vFHm2ix+YA==
X-Google-Smtp-Source: AGHT+IE3S+29C0ctynYJjZWRQvHHk0cRS3is4y8AM+jGqB69PffROPblGdFzMf6mbswY4nMzrWZg6x+FQKY9VOtDgxM=
X-Received: by 2002:a17:907:764b:b0:a3f:f8a7:e1f7 with SMTP id
 kj11-20020a170907764b00b00a3ff8a7e1f7mr2681846ejc.5.1709649185848; Tue, 05
 Mar 2024 06:33:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240105152129.196824-1-aleksandr.mikhalitsyn@canonical.com> <20240105152129.196824-4-aleksandr.mikhalitsyn@canonical.com>
In-Reply-To: <20240105152129.196824-4-aleksandr.mikhalitsyn@canonical.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 5 Mar 2024 15:32:54 +0100
Message-ID: <CAJfpegvPkLuU6n_4twNkVDfKNj9MUSAv0usrswBs2AhKnFudDg@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] fuse: __kuid_val/__kgid_val helpers in fuse_fill_attr_from_inode()
To: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Cc: mszeredi@redhat.com, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 5 Jan 2024 at 16:22, Alexander Mikhalitsyn
<aleksandr.mikhalitsyn@canonical.com> wrote:
>
> For the sake of consistency, let's use these helpers to extract
> {u,g}id_t values from k{u,g}id_t ones.
>
> There are no functional changes, just to make code cleaner.
>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Miklos Szeredi <miklos@szeredi.hu>
> Cc: <linux-fsdevel@vger.kernel.org>
> Cc: <linux-kernel@vger.kernel.org>
> Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>

Applied, thanks.

Miklos

