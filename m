Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81A923239D2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Feb 2021 10:49:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234821AbhBXJsF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Feb 2021 04:48:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234637AbhBXJqL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Feb 2021 04:46:11 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED2D5C061786;
        Wed, 24 Feb 2021 01:45:29 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id v1so1218640wrd.6;
        Wed, 24 Feb 2021 01:45:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/dg/fW+QOf5xcSw93zMmIAfZ9zqtrux4+CIo9C+zlcQ=;
        b=pxppe/V5vHpZrmxxmJGBMVQMK8j/epu0+LnQUa46nD6ObrplEsRJtF1lJLeyYI79Oq
         5W2mP+MO0JPg8rMKoMzaVEwboJBc1jjVBJs7mYcMc7TcBvoQqPBUsN2TpHJEXUcH5Clq
         h2qu3z9sWdJtg7UbXrrSNLAvwHZzP5FR5oW1wRQ/wwM52E/M9hDB/MQGAqIYpzW9jgl8
         VyM3PB8Za1JPgTi831nRNpQfl1XOOXBx6p7A0dCHVkCFaP64MaT/LT1oSs0bODOsNOHt
         rWAKzKDT5Nx/HlnS0UFoCo3JHUAxdnH4ifWeUA6mwSxoBRyBtDix4fAgmbgstXQP0xVH
         iimg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/dg/fW+QOf5xcSw93zMmIAfZ9zqtrux4+CIo9C+zlcQ=;
        b=et6xuIVKGUsgFAFXWi/bUfUQ7Ezodbrko7Wc8FlefYf59Sr0mFUNvYB+tdL08SEojT
         MCOKUZ6gErFCL5JDNjPSMA9Hh6geJKXMcn9QjhtJ2i+HnI8U7ko3KheUJX6JdFvFgJvR
         veXMiOXEb3wSqkpxU4baIWsRs2As75uLVVnrGLyCZNDjqdg9uo34Ln0UGwGw5KDr8xSj
         4OjN30BFTOus32AbtSe18B70SpeU7Y/h81q3vbfrAQq6EW604kp3V9Cu6dAOYwFgmUch
         hMs9kMlYbnqp88g/TIMbAarnF/k0JUscK3sUHzDRcxLpyOSKrvmU60L3xNbzFo/Bm9yV
         4qBA==
X-Gm-Message-State: AOAM533xM7+5Wz92VFv3FmEnoaSlKb8dk1FJRSKtwVe8Ij0bIoyDW9OI
        VCSY/RgDqmtgDbJqcCrX54Q=
X-Google-Smtp-Source: ABdhPJw1v2kmdaxDop4bmrKUhD/BYqxz8HV11tDX+fi/WL7Jl/wSL7R9X/XHTkWttOhUyk0HO6aE7A==
X-Received: by 2002:adf:8104:: with SMTP id 4mr30824649wrm.265.1614159928780;
        Wed, 24 Feb 2021 01:45:28 -0800 (PST)
Received: from localhost.localdomain (bzq-79-179-86-219.red.bezeqint.net. [79.179.86.219])
        by smtp.googlemail.com with ESMTPSA id g15sm2454425wrx.1.2021.02.24.01.45.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Feb 2021 01:45:28 -0800 (PST)
From:   Lior Ribak <liorribak@gmail.com>
To:     viro@zeniv.linux.org.uk
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        liorribak@gmail.com
Subject: Re: [PATCH] binfmt_misc: Fix possible deadlock in bm_register_write
Date:   Wed, 24 Feb 2021 01:45:24 -0800
Message-Id: <20210224094524.123033-1-liorribak@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201224111533.24719-1-liorribak@gmail.com>
References: <20201224111533.24719-1-liorribak@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello, a long period of time passed and I haven't received any response to this patch.
Please take a look at it, it will be much appreciated.
