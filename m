Return-Path: <linux-fsdevel+bounces-71475-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 29C28CC48F5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Dec 2025 18:09:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2450B300A578
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Dec 2025 17:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2C3C390207;
	Tue, 16 Dec 2025 12:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="DE3BNhOc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF653901F4
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Dec 2025 12:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765889064; cv=none; b=hOfAmQJ0KrVCvXWLAxfUd5ARWSqABZ929/IYwAtlN/g3q9a6R7CflF+TPvDbiszbXdbS+HYGGxf0ajhplBfxxlmgC1uo2o1MSwJvzRsDV/xmN7U1S+l0zojUp9RyxUqynPZm7aDfq+rqRh2UhjZ6jXycaXx2pm7lv/OJ1HIUS3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765889064; c=relaxed/simple;
	bh=boIqxM+ov9nSjwgWpy63cnTTzp37ctPMetwDRjr716c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YRe9IbXAkHCp4gpWYB3iN3UUNvOHOLVI5N4IPFH7DwVnqPUKF5tw9G4vF+Rz0/Pvavy+l9V9ypKZDx67CBG3hJGpR0pVYVCpQ9WwnO9evjbRqAnbz4RxGk3+YLu8+TnexxBwzCLWDaDEoBcrtrp+6CpDu7ubUlcoziGLnq5kIvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=DE3BNhOc; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-477619f8ae5so35354805e9.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Dec 2025 04:44:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1765889060; x=1766493860; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/lTD5T6FLVPMFiI1zK6zOO1/qp2X5cLGG7vD5u13cD0=;
        b=DE3BNhOcc+HNQXvq2D9wHK7NIuewOffYSeXDSlTTjBkaAYU97BUwxMG9Bd17Vj04G0
         Udn8He0ZTL2b6WWpup21Pz65uKv9xFnVS7CsZ3CMMxLk4LdE+ORIqEU90QzUCeZoYY3E
         M93a4SOb9XP+Clv4+mIKU4Mp8YVXMRjFWFsAvF6zu11+Ni4hYptYb8CfRJTJBTud4Nwq
         C61+N5a2YmlS6bDZ/Ku2Q5wgp/hTUEegwISlmbTHBHBU5TMM+11ijwfMN4CfjDDiL/MH
         g4UfBRPjvF2wlxN0Xv8vHhKINDlp+zTZpBTb3GZCiCYQBxHLtYr5ITzGE3AKYiitxSzC
         1FZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765889060; x=1766493860;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/lTD5T6FLVPMFiI1zK6zOO1/qp2X5cLGG7vD5u13cD0=;
        b=QU/Dn3nP+QCw67Dl5Q/aRZa5t8WSEPmdzSfXO3Yy8PZEW3GaXyDDe4yF8vxAGROjr5
         +/fQ/tCS/upBM6lRvIZ57BAiZ2VAzgdnhVPZviqi4ApOWBdWJ9yKrtQ42YE2IrvPZ7cQ
         HnFwoCSHczS+QkcQNKI0wITLRKxyWUF2xg/XVVFgaTXbJhn2p7VljfqOzzmaJn8w9pfH
         2a4W1w3luWtLjF9Phu1I+YY15RzwH+JX4HecWXqxtPclz0Im0iH5Kopb63qWFsaS9E0U
         ZR5KHp7RZU9HzpTKWv6uzU8xHAJ+Ki4dY0kD1rEQEa5B6jok/JDX4uaEj433lPORp7U9
         9CwQ==
X-Forwarded-Encrypted: i=1; AJvYcCXi0E6JhdWEIHHrLgNqRRwNxJ8H9oGNG0sn2v1/edHKOkZEwjTt9nmM1QFem4/VC+3ei0Lc6Ru4+j5opz0q@vger.kernel.org
X-Gm-Message-State: AOJu0YxC1oU/EiC2sHhqRdT0Ej8o/BXBQNNnd63PPtW9avDxs95A+MxF
	UrbOug0gIaeSKTyIXEGMUx0LzZN7Vr5jpUS9kvoQcOGm8P/Bi5EH9Wi9YksmH3mMRJg=
X-Gm-Gg: AY/fxX4mBPYxOWLPfxljur4a7XjfhTuUfZ4m6TECmYVLABPSWTZz85zDo4x59yAkRFM
	AE8+Pqb/Equ4UcSKSY/CvE/iPhQpMfnCB57eRwtq7w90p0gyhwDIn66ZSIzdebe/DwLqaL5oskx
	ugyahJGMFmdQp4nCvEKISMTILlbLFBJF+kkR+1Efb+d6vIjTZ5MgHkum63mAwC3ZGWuI3msigjN
	ECUCywsz3DLAfCt2RddKMKcyjm1ppPu7VhOlUeW3g9CWVKqqSQgLqvllOZH3pAgILPEqYMFIdhj
	vD84ljC9ueR1FtMXohNnqpJdALof5rygDlUW67dFDp7uC44W3bBZFXuOd3cmnn5XhsMZ0fZY30V
	5BFratn+c7m6UrrtVY1/KecjgZ/5sA93Kyhj8P08WWnohvCoEp9O6zUL1SGuh0S7zNBQIHvNb1J
	+nV3biVYL+RXW/9g==
X-Google-Smtp-Source: AGHT+IFW5qDickl4JAEFRsGArKDI6FcAB611ceysvy3jNS62BLSz150yvQDh+EMhh7oPcWPJX+4yHw==
X-Received: by 2002:a05:600c:3acf:b0:477:1bb6:17de with SMTP id 5b1f17b1804b1-47a8f90f96bmr152908605e9.30.1765889060304;
        Tue, 16 Dec 2025 04:44:20 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47bd95e0161sm9700215e9.2.2025.12.16.04.44.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 04:44:19 -0800 (PST)
Date: Tue, 16 Dec 2025 13:44:17 +0100
From: Petr Mladek <pmladek@suse.com>
To: Joel Granados <joel.granados@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-hams@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH] sysctl: Remove unused ctl_table forward declarations
Message-ID: <aUFUIfVvRcYN3_ID@pathway.suse.cz>
References: <20251215-jag-sysctl_fw_decl-v1-1-2a9af78448f8@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251215-jag-sysctl_fw_decl-v1-1-2a9af78448f8@kernel.org>

On Mon 2025-12-15 16:25:19, Joel Granados wrote:
> Remove superfluous forward declarations of ctl_table from header files
> where they are no longer needed. These declarations were left behind
> after sysctl code refactoring and cleanup.
> 
> Signed-off-by: Joel Granados <joel.granados@kernel.org>

For the printk part:

Reviewed-by: Petr Mladek <pmladek@suse.com>

That said, I have found one more declaration in kernel/printk/internal.h.
It is there because of devkmsg_sysctl_set_loglvl() declaration.
But I think that a better solution would be:

diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
index dff97321741a..27169fd33231 100644
--- a/kernel/printk/internal.h
+++ b/kernel/printk/internal.h
@@ -4,9 +4,9 @@
  */
 #include <linux/console.h>
 #include <linux/types.h>
+#include <linux/sysctl.h>
 
 #if defined(CONFIG_PRINTK) && defined(CONFIG_SYSCTL)
-struct ctl_table;
 void __init printk_sysctl_init(void);
 int devkmsg_sysctl_set_loglvl(const struct ctl_table *table, int write,
 			      void *buffer, size_t *lenp, loff_t *ppos);
diff --git a/kernel/printk/sysctl.c b/kernel/printk/sysctl.c
index bb8fecb3fb05..512f0c692d6a 100644
--- a/kernel/printk/sysctl.c
+++ b/kernel/printk/sysctl.c
@@ -3,7 +3,6 @@
  * sysctl.c: General linux system control interface
  */
 
-#include <linux/sysctl.h>
 #include <linux/printk.h>
 #include <linux/capability.h>
 #include <linux/ratelimit.h>

Feel free to add this into v2. Or we could do this in a separate patch.

Best Regards,
Petr

