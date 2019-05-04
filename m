Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73A961387B
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 May 2019 11:42:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbfEDJm2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 4 May 2019 05:42:28 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39754 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725819AbfEDJm2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 4 May 2019 05:42:28 -0400
Received: by mail-wm1-f67.google.com with SMTP id n25so9326445wmk.4;
        Sat, 04 May 2019 02:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=EYUTX8c297XneKoeSHCwPD3Tbzv8GCxiVDcwaABHHH4=;
        b=HmcM6CTgTZAbBAmYwuAGcS/05xw/rSCxFXC12KWuf4NUUdypt6THfzKgreNqDhD1Dd
         0Idyk/2SHue0BR3Y/vxlyNq4o+frhO9UoV7YilTv1EsMbAsmPBLQbvHgsFqAhBIFjhM4
         lLjnZtnHac9zCq/8fZW5+iRRMGEkbYStYuDCI1GpDAUrnNpI6VnCJZWtgsDYE3uRj1bf
         +uXS45q6u+2PKYH5GrzjdZYF2m+O4CDPK8WEK7WhHMKdDGY0rNhDdWqWP8WZbuMYd9Ki
         aF0dh4H4BHdZDwLHzJfjuw5gvJ6yX29zhenQkYArtsGAzF/BAO7G7LGAmimbsNGjnx7L
         Wb/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EYUTX8c297XneKoeSHCwPD3Tbzv8GCxiVDcwaABHHH4=;
        b=PeNq866QxMpTcOUlMVqYNI1q1y+xwGPkug1BUIAwYAGI/owpQXzEOHR6mqgX8/btzj
         NR7gCaHol5PoHuF4yMvz6pGDc+/KtjLX/NctqymXh7J2x5TkqlDGrVgch9EK5MmRZLCH
         RDg44jZiYGpkVg6ToFP1juGXtU9n/ieiDeBNxchB8Tdcq44Nh3mdW3hMge58L2gh82q2
         LxMrrxjQ5wjIgGApyU3ILVBEDs/ah62+LGzTN77DlBzlciaSU1xdZg3Mmu82gM6CCueg
         sXWLx+YzZ/IPnAWGLfCk5SaaDiG4MITmSIFVcxpAdHoABg6kdY4c1T6aG56O3CsxuMEz
         vV6w==
X-Gm-Message-State: APjAAAVrn8/TV53iPhDztHCh9+k5F/al841kQdvLbhmZ/dFfS8wP9Q7I
        TCW5in597sQw2VR0smKsaM0=
X-Google-Smtp-Source: APXvYqx/MBWyVTdZfn6ssAEw1tcYL0GtpLZW61frOtGJytrBprwvipLWMVDs4u6Ro0N4zgCjbSmFPQ==
X-Received: by 2002:a05:600c:247:: with SMTP id 7mr9966114wmj.31.1556962946176;
        Sat, 04 May 2019 02:42:26 -0700 (PDT)
Received: from localhost.localdomain (bzq-79-179-250-108.red.bezeqint.net. [79.179.250.108])
        by smtp.gmail.com with ESMTPSA id b10sm8387993wme.25.2019.05.04.02.42.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 04 May 2019 02:42:25 -0700 (PDT)
From:   Carmeli Tamir <carmeli.tamir@gmail.com>
To:     carmeli.tamir@gmail.com, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] Refactor file_systems to use the kernel's list
Date:   Sat,  4 May 2019 05:42:12 -0400
Message-Id: <20190504094212.9945-4-carmeli.tamir@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190504094212.9945-1-carmeli.tamir@gmail.com>
References: <20190504094212.9945-1-carmeli.tamir@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

struct file_system_type defines a next field which is used to link the file_system_type structs registered to the kernel. This patch set replaces the propietry linked list implementation with the kernel's list.h.

This change makes clearer interfaces and code (e.g. the change in register_filesystem and find_filesystem), and eliminates unnecessary usage of * and & operators.

Tested by comparing the lists in /proc/filesystems.

Carmeli Tamir (2):
  Use list.h instead of file_system_type next
  Changed unsigned param type to unsigned int

 fs/filesystems.c   | 69 ++++++++++++++++++++++++----------------------
 include/linux/fs.h |  2 +-
 2 files changed, 37 insertions(+), 34 deletions(-)

-- 
2.19.1

