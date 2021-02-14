Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A4DD31B21E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 14 Feb 2021 19:53:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbhBNSxO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 14 Feb 2021 13:53:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbhBNSxM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 14 Feb 2021 13:53:12 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73A33C061574;
        Sun, 14 Feb 2021 10:52:32 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id v7so6222948wrr.12;
        Sun, 14 Feb 2021 10:52:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rNJlO4/q80kk+PEPtW5ue8B+S2Qcu1i/6aKbO8a3aoI=;
        b=bx6N/zlcgRi5zdZ/cjquy23J2U2n1vLRNMidwTOw7hdPk2zRIHlSPvGQpxW/9b7Abj
         2rBATWkzqPYzVdWaig9DVzQZwbCzcNHOuhx3CEhiTiJrlWFKXtXnuNsFSWCT3nBb+FWl
         F6zj5r0HvOT/q4H4vLxJHF7ooXLEIoTUtVDPfatL4dOO3u4KgNvqVe/dlFz4jmb2ElBz
         pqdUtkdzUALbh1/xbPB4Cprf4dO33CSE/UycxsnC/190WtqwHp1Yv1eVJ2ALStS3PhGF
         v3iAqyxJKaId/8BgRLlo6DDqWfbhWOPw5YrMaLoMN/o/8U7wL2iKWBhensyorrXmyuFX
         vYfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rNJlO4/q80kk+PEPtW5ue8B+S2Qcu1i/6aKbO8a3aoI=;
        b=bOcAsCFmRy6I/ptnbxDlfPWwrwOyeo9j+T9aYt5KEMq88tB8Pd+GsBvioKplxzRwUM
         NeHjYMzWenqfhUt1WNgks0FB5mj461k+1iK6kFV58mMN38Wg5kjW/t/KTeH8v5TkQoG6
         GclgjEfJHdbhMqfkm+ZbbkCssXB9VJTgrwm/qXw7MvJ6Xq6h9bZjC3mbeNu1+24VMcdK
         RjqQuvBo3JR3wpphFIwWZU5wIdF/B8X33uWqlzMj3Pp8QBJqpY1JNjHXSqiWMd65FtdS
         zGM8DbWS/QeU1uBSwDWha2sUzxvmU27yIzcHBoo2eLt56y+lr6Dzoopqokn7D+GJLVzw
         9frg==
X-Gm-Message-State: AOAM531xYY/pZbEZS7/p637Yb5bcAV6Mq2LCpzb5Qch5Zgtdw6tEof4V
        cIzoYA7n8J52zOZSfa4sl7Y=
X-Google-Smtp-Source: ABdhPJxLKBVvb1Ntc7rF6UdNd008RcNdXhIcLWjwVtinrhOQ+FmeZFuB/Gf3WVkK44vMd7+iJPvNOQ==
X-Received: by 2002:a5d:66c5:: with SMTP id k5mr15398342wrw.302.1613328751005;
        Sun, 14 Feb 2021 10:52:31 -0800 (PST)
Received: from localhost.localdomain (bzq-79-182-30-18.red.bezeqint.net. [79.182.30.18])
        by smtp.googlemail.com with ESMTPSA id e16sm25785306wrt.36.2021.02.14.10.52.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Feb 2021 10:52:30 -0800 (PST)
From:   Lior Ribak <liorribak@gmail.com>
To:     viro@zeniv.linux.org.uk
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        liorribak@gmail.com
Subject: Re: [PATCH] binfmt_misc: Fix possible deadlock in bm_register_write
Date:   Sun, 14 Feb 2021 10:52:21 -0800
Message-Id: <20210214185221.4793-1-liorribak@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201224111533.24719-1-liorribak@gmail.com>
References: <20201224111533.24719-1-liorribak@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Thank you!
