Return-Path: <linux-fsdevel+bounces-36062-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3BA19DB5EA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Nov 2024 11:46:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3D9BB27FDC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Nov 2024 10:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4D9F191F79;
	Thu, 28 Nov 2024 10:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="c3lCeq9R"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86F11459F6
	for <linux-fsdevel@vger.kernel.org>; Thu, 28 Nov 2024 10:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732790684; cv=none; b=KpzvJLTcP5zS3RT8LPe59KpOFJtLCY0dvLw/Z4E2jfrP2lVhovSCGsrPSZ17gn/mRwoMYQgqRLPo7HkvrBrYJIN7NClkM6Wvj9vochh3xHa7NxXNdh4E6v86jx7cQ40ioUH9q8faeVtnE+rJNeYirxhoufyCZD9FYwrsvtOmZTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732790684; c=relaxed/simple;
	bh=eI+vJ+1Nc2t3LXrGlA474JxhWSRgmiqQE9xrhvMjhEY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GLgfibeREh++Yn8XP1JMDdlzpINFxi/8r61GIm59tfn17DPO6zDbAAdo2RPyxy0zibXcYQfB0b7J1v3sBq4/d7C5XS/2LTqCkgpV10vBi1Mt90Z9eEgDPdOc9PiZeWJ5RL/ICJhnrIDQvBJSJd9vcNAzH+b+QMq8xrOWtKyMC6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=c3lCeq9R; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7fbc29b3145so1355760a12.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Nov 2024 02:44:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732790682; x=1733395482; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ttG0vWeu1Joq31iBiY9HQi0brxn5SNFc+Fjhdmas1Ss=;
        b=c3lCeq9RGljgD4p390Z4aMfplWEMMao3T22LWUJWY1DXTsJEY+0qzEFqQUTzO4xBsI
         LfKWUIvh2/Lamy1jPEe25PG33+cz+B+Hvp3tlZMHCP0bs4pryTZUpLxk6qFBYbV9u82t
         fhgY2nku+86R2bC8zx1UWyheg5DKNIj1/uxlc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732790682; x=1733395482;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ttG0vWeu1Joq31iBiY9HQi0brxn5SNFc+Fjhdmas1Ss=;
        b=B/6EZ1oy7lUhhRUWgNBFn1zVfVPrjQbLife4/p3jTYCv6kjW0xdZug6ct7w0JhsCSa
         HlFwJKvKZN7uUHSTZTABgyWkTKXiShlXlnCuYoFKGsziJfOC1lMczfOjrEb9LCLDTdL7
         PxJkJjZuuyNhTPV5KvOm0Hd8dFdlykdybiBXAwqFiohpCfEo3aKgisI08Zcl+X3o+usv
         hgTM4HmjWRHXZx9a3Nu3zaqc8vwFsDCaTeonyyjRkmmN9ExJBF+WFyI+68gNOQ1mANCw
         zeYrKYP8btApcrg4GeTyQk7ltHo0SFxrIBWrib3dNlYxp8D+4IYMliFPP+wMgSu9MtaR
         5oSQ==
X-Forwarded-Encrypted: i=1; AJvYcCWyTd1P/+6gBZ3p1RNgY06YnDM/BBtJUjmZ0uvkngIMdzBGdBkE5v6/4znUW+gn3bo+G4BmUQHN/GAm4t6d@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3Rp/wwlH+fodnMzPMGJe6u0T7ykB0bKybdbh7BPLqUVrt9QWK
	W3jTXMGR73pYiOIG++M7+Qab5GD7A9alY3AWTtRldzRMq+tzwt9MyUbajPGgcQ==
X-Gm-Gg: ASbGncvDFefqhmhpebNvWBjIPehy06VWDVImLgxpj0smfOQZXguBpdGdJFjSwT2CnO0
	pKMPwaDqeQQO94aAl7+Akdc2GGyQGPf5DNcFbAtlOvi5v2T482iHOk94tB7s6J2AY4RanJ8kK7Z
	7m2hfYX5AObN6g5QmatT2ADkV1LzjBh0+MCsakHJWnnUlXSx5UIeJGCXXvX18c5PfTN4+VwGl4D
	p9s8pKr8HKXks9KvaMbKo7XPY46b5J0y18dp5mZZ+jPWkAwUxls2A==
X-Google-Smtp-Source: AGHT+IE4a0VHtXouYAcZqlbu2VMGsDppVzHLdJzsqmrF2oHzFQOMuwCwXrLtOKKTuG6v/t4KV1s/Ag==
X-Received: by 2002:a17:90b:28cb:b0:2ea:696d:732d with SMTP id 98e67ed59e1d1-2ee25b0411dmr4361086a91.13.1732790682000;
        Thu, 28 Nov 2024 02:44:42 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:e87e:5233:193f:13e1])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ee0fa47fbasm3187806a91.13.2024.11.28.02.44.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2024 02:44:41 -0800 (PST)
Date: Thu, 28 Nov 2024 19:44:37 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, josef@toxicpanda.com,
	bernd.schubert@fastmail.fm, jefflexu@linux.alibaba.com,
	laoar.shao@gmail.com, kernel-team@meta.com,
	Bernd Schubert <bschubert@ddn.com>
Subject: Re: [PATCH RESEND v9 2/3] fuse: add optional kernel-enforced timeout
 for requests
Message-ID: <20241128104437.GB10431@google.com>
References: <20241114191332.669127-1-joannelkoong@gmail.com>
 <20241114191332.669127-3-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241114191332.669127-3-joannelkoong@gmail.com>

Hi Joanne,

On (24/11/14 11:13), Joanne Koong wrote:
> There are situations where fuse servers can become unresponsive or
> stuck, for example if the server is deadlocked. Currently, there's no
> good way to detect if a server is stuck and needs to be killed manually.
>
> This commit adds an option for enforcing a timeout (in minutes) for
> requests where if the timeout elapses without the server responding to
> the request, the connection will be automatically aborted.

Does it make sense to configure timeout in seconds?  hung-task watchdog
operates in seconds and can be set to anything, e.g. 45 seconds, so it
panic the system before fuse timeout has a chance to trigger.

Another question is: this will terminate the connection.  Does it
make sense to run timeout per request and just "abort" individual
requests?  What I'm currently playing with here on our side is
something like this:

----

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 8573d79ef29c..82e071cecafd 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -21,6 +21,7 @@
 #include <linux/swap.h>
 #include <linux/splice.h>
 #include <linux/sched.h>
+#include <linux/sched/sysctl.h>
 
 MODULE_ALIAS_MISCDEV(FUSE_MINOR);
 MODULE_ALIAS("devname:fuse");
@@ -368,11 +369,24 @@ static void request_wait_answer(struct fuse_req *req)
        int err;
 
        if (!fc->no_interrupt) {
-               /* Any signal may interrupt this */
-               err = wait_event_interruptible(req->waitq,
+               /* We can use CONFIG_DEFAULT_HUNG_TASK_TIMEOUT here */
+               unsigned long hang_check = sysctl_hung_task_timeout_secs;
+
+               if (hang_check) {
+                       /* Any signal or timeout may interrupt this */
+                       err = wait_event_interruptible_timeout(req->waitq,
+                                       test_bit(FR_FINISHED, &req->flags),
+                                       hang_check * (HZ / 2));
+                       if (err > 0)
+                               return;
+               } else {
+                       /* Any signal may interrupt this */
+                       err = wait_event_interruptible(req->waitq,
                                        test_bit(FR_FINISHED, &req->flags));
-               if (!err)
-                       return;
+
+                       if (!err)
+                               return;
+               }
 
                set_bit(FR_INTERRUPTED, &req->flags);
                /* matches barrier in fuse_dev_do_read() */

