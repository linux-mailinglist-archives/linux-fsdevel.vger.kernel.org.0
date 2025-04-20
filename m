Return-Path: <linux-fsdevel+bounces-46798-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9173DA95244
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Apr 2025 16:00:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAE46172F5C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Apr 2025 14:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57F31250EC;
	Mon, 21 Apr 2025 14:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TG+3CVOZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4395C1372
	for <linux-fsdevel@vger.kernel.org>; Mon, 21 Apr 2025 14:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745244023; cv=none; b=Nw+SuL+r/N+aIRHMlvV5W1CoOcnFWBLFQpA/zK3pt+mkiOMrPECjoe/A4xX52xz/+OukVE9/ukorn1SUBNuoIFbz55cpc8aDVtP0tseS8B0QZhEFX3PmMwzF4NOncI5uQx+Zm413842KeaxhXxresf4S1QeEDPXqP3vQF9+xzyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745244023; c=relaxed/simple;
	bh=ex/zM3TP5JFYcQ4WZQgxZTAxj0sDxCVjWpZE9YswO6U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NMfQfIpC3msrtYaRiAh8BkqiXMeTG+HApc5aoTwRfEeWMnXOaH41U2LCmTnJsJi+Up5bcaelIx9vfCqBfZKEuBttvwjXPSbgy2iimkOZRIGxzg/i0pzPEpHxISzckCw2BYGMYkUbaqOvV6MHsFAfYTIgkGY3TvrN8ZtoS/gnHn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TG+3CVOZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745244020;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=cfMHn5F+EwpnUPxXPntT3pWz5D4jx+KcZshKph6ZmXQ=;
	b=TG+3CVOZnTPn/SOZ9ezfOJznLSy4l+T5kn8FwZAF8DzAhgvn9fHk1fDPU89A8XqWkVBX4h
	zneuf+xWQ5gMGzNnK9uoYT99uyOoFmom7yn0zU6tfBEqgftbTLlhro7LO9voSst4ZhkpOG
	NaWiWcHJEM+VJMg7vlLY3Uk7f4LBhmU=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-8IiHtV7YP0qakBz1BTSYaQ-1; Mon, 21 Apr 2025 10:00:18 -0400
X-MC-Unique: 8IiHtV7YP0qakBz1BTSYaQ-1
X-Mimecast-MFC-AGG-ID: 8IiHtV7YP0qakBz1BTSYaQ_1745244017
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3d8fc035433so46318545ab.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Apr 2025 07:00:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745244017; x=1745848817;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cfMHn5F+EwpnUPxXPntT3pWz5D4jx+KcZshKph6ZmXQ=;
        b=s65/w63Ki6DtI+Ihz5W9jhgBD1mz+ZuBUn5TgrnJzIg28ooIyI0ABBFrS6/KR6xPqH
         a5dmOyJFK3pCuHVq8Mf8JUy6aRA0kuBvn4cHjdDTdfdZQgeJuXXar07kEl44ElINblbN
         aykRw+VvO/lD8ouvjTNfequcjkHvukeyN9FKaNQ+hlFgNmJowNHh6+h82rl9mEJ2vtn3
         TR69V/eg+TBsp/8Rra8hhr/0uL0SolNYyTZgUcGLtUsM6xK4iWRc6Q0nzR/J1+crow08
         jOWa379+XRTKbyWDnSxDkYrqwKnofbIY8CkhBi2k06TplkJBVXqwMRhoJPbqY27Eh9bR
         +jRg==
X-Gm-Message-State: AOJu0YzJCP88QGI9sDA18ReFPRuc+jkdrnfuFz6/4qNbTFMqBvFYeOzY
	DjmL0UGJNGdofMtrDbzXVTYGbwyTrO3u9TMyOLOUG/Q3udS1DzEtRWXqMiOb+z/IwrsdUsCjEKU
	ir2epbRdASaQbYx0FAIWrxxfcuRttH+iMQvzMOySltt11v+th6rgJyHQcIr1mZsc=
X-Gm-Gg: ASbGncuwjzw891OnCMLmLTTraD14CLJ5z1/CvErF9dUu0D4CH2IYdvdSVUs2gharogA
	ylBoYDftgQUzUoZ/hcWd+nHdMYebGygH+OcCAeEkohZOOMCwW/ZIHddeq5tDyg5hY+WOUjpC87z
	ol02dQBuuacG8icJn4FIBiPKyaWZfZb9cVjIXm1rxhtZ17TsOGqs8w6eegDdYhEzHxXoKwcpYym
	92UnFNwmQ8F4Dh5865CHo3aVwK2gWc1ILlzPsLZkYQ/EK903Gn4VY4+yErjlMJ1FmNwOOfmZNAK
	owp+h6feeU6031M=
X-Received: by 2002:a05:6e02:2163:b0:3ce:8ed9:ca94 with SMTP id e9e14a558f8ab-3d894188f96mr82716755ab.14.1745244017172;
        Mon, 21 Apr 2025 07:00:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEp9tbKCdsJJ7qWC5NHVoXlI1cQ9dfkW+Ww++eOP4zIgSfdC7asgof3x4G4bkAo1KHVmv4Hyg==
X-Received: by 2002:a05:6e02:2163:b0:3ce:8ed9:ca94 with SMTP id e9e14a558f8ab-3d894188f96mr82716365ab.14.1745244016614;
        Mon, 21 Apr 2025 07:00:16 -0700 (PDT)
Received: from fedora.. ([65.128.104.55])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f6a3839336sm1788866173.73.2025.04.21.07.00.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Apr 2025 07:00:16 -0700 (PDT)
From: Eric Sandeen <sandeen@redhat.com>
To: linux-f2fs-devel@lists.sourceforge.net
Cc: linux-fsdevel@vger.kernel.org,
	jaegeuk@kernel.org,
	chao@kernel.org,
	lihongbo22@huawei.com
Subject: [PATCH 0/7 V2] f2fs: new mount API conversion
Date: Sun, 20 Apr 2025 10:24:59 -0500
Message-ID: <20250420154647.1233033-1-sandeen@redhat.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a forward-port of Hongbo's original f2fs mount API conversion,
posted last August at 
https://lore.kernel.org/linux-f2fs-devel/20240814023912.3959299-1-lihongbo22@huawei.com/

I had been trying to approach this with a little less complexity,
but in the end I realized that Hongbo's approach (which follows
the ext4 approach) was a good one, and I was not making any progrss
myself. ;)

In addition to the forward-port, I have also fixed a couple bugs I found
during testing, and some improvements / style choices as well. Hongbo and
I have discussed most of this off-list already, so I'm presenting the
net result here.

This does pass my typical testing which does a large number of random
mounts/remounts with valid and invalid option sets, on f2fs filesystem
images with various features in the on-disk superblock. (I was not able
to test all of this completely, as some options or features require
hardware I dn't have.)

Thanks,
-Eric

(A recap of Hongbo's original cover letter is below, edited slightly for
this series:)

Since many filesystems have done the new mount API conversion,
we introduce the new mount API conversion in f2fs.

The series can be applied on top of the current mainline tree
and the work is based on the patches from Lukas Czerner (has
done this in ext4[1]). His patch give me a lot of ideas.

Here is a high level description of the patchset:

1. Prepare the f2fs mount parameters required by the new mount
API and use it for parsing, while still using the old API to
get mount options string. Split the parameter parsing and
validation of the parse_options helper into two separate
helpers.

  f2fs: Add fs parameter specifications for mount options
  f2fs: move the option parser into handle_mount_opt

2. Remove the use of sb/sbi structure of f2fs from all the
parsing code, because with the new mount API the parsing is
going to be done before we even get the super block. In this
part, we introduce f2fs_fs_context to hold the temporary
options when parsing. For the simple options check, it has
to be done during parsing by using f2fs_fs_context structure.
For the check which needs sb/sbi, we do this during super
block filling.

  f2fs: Allow sbi to be NULL in f2fs_printk
  f2fs: Add f2fs_fs_context to record the mount options
  f2fs: separate the options parsing and options checking

3. Switch the f2fs to use the new mount API for mount and
remount.

  f2fs: introduce fs_context_operation structure
  f2fs: switch to the new mount api

[1] https://lore.kernel.org/all/20211021114508.21407-1-lczerner@redhat.com/



