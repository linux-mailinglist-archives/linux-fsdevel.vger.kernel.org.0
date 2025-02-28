Return-Path: <linux-fsdevel+bounces-42857-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E41F2A49C0A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Feb 2025 15:31:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B305C1895246
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Feb 2025 14:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 192BB26D5D1;
	Fri, 28 Feb 2025 14:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TvFcAwYV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D391C331E
	for <linux-fsdevel@vger.kernel.org>; Fri, 28 Feb 2025 14:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740753084; cv=none; b=sELLUVKKIHJzkIgWk7pYTvQL0f/vZIKRUEmkZmq7bxe1uKiSNDuefH8FmcTAizB9LYX45VyZfYOtxiODQ1v2rF1HnBIk7puvegqpsA2YTcDC2mb72nrPks3clq85wxsajc92uE2ZOakzekmuIB4BlbGv+TmbDqbjHk7gNaYWWD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740753084; c=relaxed/simple;
	bh=+7CzGnDBIDd4BqGhIvbnloxe7L8DcX+khk2Kak149s4=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=sN7goU1hjGUZoohLnL9vavNgpnyOwHogwUYDWi2jokHf4AmKf4oLNQJbqhi5/z/I6Bv11UlVlzKLt6ERlzAOuONVePsV8EPRodZFPLVmvC2wR7zg81HF4H/Y9JK5PPOPwAGrIbXMdusPj+H2K3EUWpmF1X9WyIAfcqpB95+iqn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TvFcAwYV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740753081;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=OQjxfFAHtgfGWCK0MAJP0NkVI8s6GG7w+i6oug7RcL4=;
	b=TvFcAwYVaqUswyciGmQldfdd8Iw+MFWcWJ29SQyL+L4R+KZWvLU1rxWIhclL9coxZRkiju
	M1IdvucEAb/7SafUz1UmRarxQQxQ60OOYh3eAFW7tj/+UKXiv44VgsAIC9wXeawU5Sfl8j
	bI6u+tb36ZHqLUxC7LkNKjMUE8a/Ijk=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-36-8G0oYIWPPpu-XSscvHl9hw-1; Fri, 28 Feb 2025 09:31:20 -0500
X-MC-Unique: 8G0oYIWPPpu-XSscvHl9hw-1
X-Mimecast-MFC-AGG-ID: 8G0oYIWPPpu-XSscvHl9hw_1740753079
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3d2b6d933acso20910405ab.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 Feb 2025 06:31:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740753079; x=1741357879;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OQjxfFAHtgfGWCK0MAJP0NkVI8s6GG7w+i6oug7RcL4=;
        b=gDGe+0jgurB/AlWiK3WnQYSGQPrc/JFjFgTZF5/9nLSlDUBXTg+dBwJZb3OdbKk286
         NA4LeF6eW4J4t6eKTyOVzBKtR5CeVhD5eqZ7j03AZnxAT5f4qgQ4f09pbA9XS7cmivuK
         hx+72S2hrWftD01tCWi7MvyWu35B/EO0ivoU1EOEfZuxxCYCs6tUM+XmtTzKn++8Q8Ir
         wCqb86j5HkOm7IzhPmjQS8vc8GipQd8TXYkSBBtqZSukgoxDIpLJh8ncJJkeeTJmtx10
         K9FklNnSYxrGvHKsN61s2541lIsgS6Pcke3V5qEkwr8kt9Jfk/YHyBNZvzcs5/fR1bij
         WyEQ==
X-Gm-Message-State: AOJu0YwowdykLt7QIPYA8pUIKZoBkzwFywHwcUdTr6f1R9UIFz7RmABO
	JEBViT2nFKmOR2nmtHU6l5t3p+FOa548WRt1t3auum8HVT5uGDCY/cl038ezgjuAcvLNGWT5g1E
	LoQFjLyDneab68Bb2c1M8JTTwsERq2hsiMlDqkIn52zEXiEUNElgOW0ulqaoOAe3gKbJNVJQ96X
	qcbqcUqWRbSWaTThgDpCc8JJFL9KpzD5wvEh+CdrmXt6LUaxZM
X-Gm-Gg: ASbGncu+rFjNhWq4xckUArEgdV+v1kMsZ0M/5fd+0HT5NMtiw2yaPjkffWW+FEakTmh
	GF0t2zx8fLJFa3Qu8h81Qw6wnHv84eMUL/OKCiXbYtkuLNnOGu7VhXHshrMiQ8aMf0tQcxGnywL
	+LU6QY3by8pIKvOX7kp2FJpUgUGlzTCDeBfKGPfHUaBFtyWZ/7/c6XyG7ndX+5cozAv/rqoW462
	zhoy9KgISeXlusb09EdLnf+M87OSAzFddlRX6MMXS47Z1spIToOBN/LlJEITlWGhnXN5/NQ6iLT
	K9V3eS1ffh5u7a5OmLpOEXHCtr0JGSZcyPwvI5LAAl7SdyKbDkxOwA==
X-Received: by 2002:a05:6e02:1fe5:b0:3d1:97e1:cbac with SMTP id e9e14a558f8ab-3d3e6e91255mr33113365ab.11.1740753079250;
        Fri, 28 Feb 2025 06:31:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGe71g3vIBaAdMPA6frGtvFAqE2VzwqwgnDOFRdcV5EPWqFoZijUB9e5167y0dYRZyZ9W3C1g==
X-Received: by 2002:a05:6e02:1fe5:b0:3d1:97e1:cbac with SMTP id e9e14a558f8ab-3d3e6e91255mr33112965ab.11.1740753078860;
        Fri, 28 Feb 2025 06:31:18 -0800 (PST)
Received: from [10.0.1.24] (nwtn-09-2828.dsl.iowatelecom.net. [67.224.43.12])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f061f77783sm932446173.110.2025.02.28.06.31.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Feb 2025 06:31:18 -0800 (PST)
Message-ID: <5dc2eb45-7126-4777-a7f9-29d02dff443f@redhat.com>
Date: Fri, 28 Feb 2025 08:31:17 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-fsdevel <linux-fsdevel@vger.kernel.org>
Cc: Tyler Hicks <code@tyhicks.com>, Christian Brauner <brauner@kernel.org>
From: Eric Sandeen <sandeen@redhat.com>
Subject: [PATCH] ecryptfs: remove NULL remount_fs from super_operations
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

This got missed during the mount API conversion. This makes no functional
difference, but after we convert the last filesystem, we'll want to remove
the remount_fs op from super_operations altogether. So let's just get this
out of the way now.

Signed-off-by: Eric Sandeen <sandeen@redhat.com>
---

diff --git a/fs/ecryptfs/super.c b/fs/ecryptfs/super.c
index 0b1c878317ab..e7b7f426fecf 100644
--- a/fs/ecryptfs/super.c
+++ b/fs/ecryptfs/super.c
@@ -172,7 +172,6 @@ const struct super_operations ecryptfs_sops = {
 	.destroy_inode = ecryptfs_destroy_inode,
 	.free_inode = ecryptfs_free_inode,
 	.statfs = ecryptfs_statfs,
-	.remount_fs = NULL,
 	.evict_inode = ecryptfs_evict_inode,
 	.show_options = ecryptfs_show_options
 };


