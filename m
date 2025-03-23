Return-Path: <linux-fsdevel+bounces-44830-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13D38A6CF8C
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Mar 2025 15:09:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3115E3B4026
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Mar 2025 14:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBEDC60B8A;
	Sun, 23 Mar 2025 14:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S4ESwyvp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A93C2ED;
	Sun, 23 Mar 2025 14:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742738900; cv=none; b=C1V8NO3kfNTj3od+Et9TlMAJ1pOz9UOmgEqyQ+GeDhc7kbP10bTR/zsFb4HyZ+x7P+zCTCydFXCG0GTbqErzpgsim/wiv0StXHcYWdQhNKCtsa35A+eOpmJg0GFbm/FlF7SDwJLnk3+QLQ+CmZIaavjugY+IxekaN749rYNRUZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742738900; c=relaxed/simple;
	bh=xIwEINjj2gwrAy/Ew60O0QcjqBoYbWNAugj+Qco60z0=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=ZMP9iuIFpZvIjdP0bd9/jccI9M4qTZOi55iWJOrPR58Y1LAxkxYLr0Pn4zYsJGRHb4BDo/aaHmZ0dWkVOvDCKZ9m8ePYTnoeZ+c8Yb4sVZoW1yB2oQOA8DiTU1/egGDOw3GtMfmuEl0lTUciAJTR+WdS3zpqqAtnHvnWcj5BqUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S4ESwyvp; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-226185948ffso66562165ad.0;
        Sun, 23 Mar 2025 07:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742738895; x=1743343695; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IDF1H30hmfmuS4zs/ZqkO/uL6rPCL3F/GOuz/E1e84g=;
        b=S4ESwyvpbXF8In+Y36vs2bXtL2wdw7TVLirxugc741SEqonGdTQk81YswxsQs6//qR
         Ro15voj11IFtnsOm7hm4qlaezn/wlQ14wCHPliXT0ohfiZ8EIS3ImR/N/W6dtNeftd7S
         cPjtaPR+INBHm7+rH2KoDWEeC+5tGWV/yv6KEPDJ/dlJGbqYnzixVIGa0uGXPjRj9dzk
         c7v4SSNDLZUzcyTiZL7Y+vxwze0TDL1/3cNzKvsYFAeXy62/Mb0miFLM1R1UAHg/oVT9
         nEmQNaxk9f0BMYB8IvT5fCrgxDwSNJ+yKWXqDDWJlEiMHZR+pnaV7JgjN3Pf4T0ZShtS
         +9+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742738895; x=1743343695;
        h=references:message-id:date:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IDF1H30hmfmuS4zs/ZqkO/uL6rPCL3F/GOuz/E1e84g=;
        b=spIM8OOcsMdiJ+4Uc7QDIcJprLJ79RrH/XKaugOBhMarvFU8r00iCW9ydtYfwseGYn
         RaKFhGivAlUp6J/I/NN2fRSPKDjC9i9hzcoPYhjqM/dBucpqBsq+VxTGrRU/qlxtpGDM
         SnCk6HiJ4/SKr3x+x0XI6fHB/hkqvvGKLKJEjMra1SdowaK6Vk1SfIcsNJtDUIaHUkRq
         g/IOL1RBlSwcNflFIdqyKbFVqNLjSdAw/rWxZ4P2VmH1iEaRx+BQE2NKmtgPGDBB9P/B
         q6LctSZ+DyFIbAz/7HK+2tHOI3hDK4k/Jokr6iQhw76ZnxbJDxZOifWiLmYumSgQg7x7
         kmOw==
X-Forwarded-Encrypted: i=1; AJvYcCVOtDAKvTArsKv2ES4thJwPqiGDMZccsrALn+s2VkgVJjyJzrZC3eShtbENVQumST+9uOl6KLY6umom@vger.kernel.org, AJvYcCVwC3SyNW9hI8jwDrsSlhrDSO3cqlDbwqstbevcbciWC9i3OpUgCQvPfG6nrVEUNmMYsxnCvDYx1wnEQrPmhg==@vger.kernel.org, AJvYcCXFCt10DN5/H+ANLyTu028IUhzPg0Yf7/ZjLpucfytCgr77fHTEIZ9TthV61bNTiXfFXuK5YwD5CYdP@vger.kernel.org, AJvYcCXJ9vt/Kf3OGlQswNKpfj9oHejepwMudB8D3hwV8Cggz3SvFBIPbJhr1DGIi4sMbvLkkICZ0P9f07fd0xDH@vger.kernel.org
X-Gm-Message-State: AOJu0YzxcOSMV6hkDp/hekWZ+gOcfAnXc6oSq0rj4oG/0bgXAAdqOuZ5
	aAlNJy3ZzA684er1IYGujdFerWA9r9NJEPV9XS6556YXm/NPLCR7RLZ0aw==
X-Gm-Gg: ASbGncvoJy1grSSUB5bURK93TUBZcRAVgizDqM5NXvhaQ30+M0ucs3MrN8WH0fGg0c2
	ATAVp/lvB15HqtYATehRg1iOajH3m5/JCQa+TiqrZb0uBCVnqxifsw3mT+XyY/+mbKwiC2r6A1y
	dkySUfnIymKpxaQRfiNvLZkmdhyEt5JsjOB21yvpAoPFeyIV4bYk9Xb8PIMvfiFurd8VP7376YK
	WE+yHSQmX4D24A0fhVMWdzW9h2etzJJmBoBvmK7O1gRDoTOFMXUKarEaIT9x8gKZZmgUlaz5Vzi
	5tg9EPutwN/oxJ1gMlA4fNcxfCsJTx3+44BU9tTE3oY3vg3H
X-Google-Smtp-Source: AGHT+IGaBFfjt0FQLriFYCmj3Oa1iv0U46d/ndwDW3jiP2m6speDDfglrGw//6dI9D+Ld9iT/ZIFUA==
X-Received: by 2002:aa7:88c9:0:b0:730:7600:aeab with SMTP id d2e1a72fcca58-739059c5da7mr15848294b3a.13.1742738895230;
        Sun, 23 Mar 2025 07:08:15 -0700 (PDT)
Received: from dw-tp ([49.205.218.89])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73905fa97fdsm5801796b3a.26.2025.03.23.07.08.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Mar 2025 07:08:14 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Christoph Hellwig <hch@lst.de>
Cc: John Garry <john.g.garry@oracle.com>, brauner@kernel.org, djwong@kernel.org, hch@lst.de, linux-fsdevel@vger.kernel.org, dchinner@redhat.com, linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com, martin.petersen@oracle.com, tytso@mit.edu, linux-ext4@vger.kernel.org
Subject: Re: [PATCH 3/3] iomap: rework IOMAP atomic flags
In-Reply-To: <20250323063850.GA30703@lst.de>
Date: Sun, 23 Mar 2025 19:12:02 +0530
Message-ID: <87bjtrsw2d.fsf@gmail.com>
References: <20250320120250.4087011-1-john.g.garry@oracle.com> <20250320120250.4087011-4-john.g.garry@oracle.com> <87cye8sv9f.fsf@gmail.com> <20250323063850.GA30703@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

Christoph Hellwig <hch@lst.de> writes:

> On Sun, Mar 23, 2025 at 01:17:08AM +0530, Ritesh Harjani wrote:
>
> [full quote deleted, can you please properly trim your replies?]
>

Sure.

>> So, I guess we can shift IOMAP_F_SIZE_CHANGED and IOMAP_F_STALE by
>> 1 bit. So it will all look like.. 
>
> Let's create some more space to avoid this for the next round, e.g.

Sure, that make sense. 

> count the core set flags from 31 down, and limit IOMAP_F_PRIVATE to a
> single flag, which is how it is used.

flags in struct iomap is of type u16. So will make core iomap flags
starting from bit 15, moving downwards. 

Here is a diff of what I think you meant - let me know if this diff
looks good to you? 



diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 02fe001feebb..68416b135151 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -78,6 +78,11 @@ struct vm_fault;
 #define IOMAP_F_ANON_WRITE     (1U << 7)
 #define IOMAP_F_ATOMIC_BIO     (1U << 8)

+/*
+ * Flag reserved for file system specific usage
+ */
+#define IOMAP_F_PRIVATE                (1U << 12)
+
 /*
  * Flags set by the core iomap code during operations:
  *
@@ -88,14 +93,8 @@ struct vm_fault;
  * range it covers needs to be remapped by the high level before the operation
  * can proceed.
  */
-#define IOMAP_F_SIZE_CHANGED   (1U << 8)
-#define IOMAP_F_STALE          (1U << 9)
-
-/*
- * Flags from 0x1000 up are for file system specific usage:
- */
-#define IOMAP_F_PRIVATE                (1U << 12)
-
+#define IOMAP_F_SIZE_CHANGED   (1U << 14)
+#define IOMAP_F_STALE          (1U << 15)

 /*
  * Magic value for addr:



(PS: I might be on transit / travel for some other work for a week. My reponses may be delayed.)
-ritesh


