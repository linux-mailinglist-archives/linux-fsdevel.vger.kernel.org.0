Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3109D47B924
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Dec 2021 05:13:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231962AbhLUENF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Dec 2021 23:13:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231712AbhLUENE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Dec 2021 23:13:04 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2E7AC061574
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Dec 2021 20:13:04 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id y9so11182854pgj.5
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Dec 2021 20:13:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wKrfGiJLmo4BFy866IR6WichX7+97mPLbqHHnF9C+U0=;
        b=tXWtVTEdB1vLnxZFgNqvM6eVRbmeCYP+Q1isSNun2AINF3tkOQoPbc5mwZLgYaXm8Y
         k/KmzI1TmIAgdPYmIJR4UPLSck0t7tZqG+RpmSPUIbhqyf1ZAsG1lJWP7Q7fOQzn420V
         e0vfRHW//ZFG8A3MiMAUoxPa8wKqWM2d7MDo6ELULobAAmWxxsgSx1U1Rk9HLKh/kPcq
         FePQuH9EY0XHYGYMwMDciLuloL1ytQNqKV85cypG7RAd5k2pI4BV9C1Cwg+lLO08NMx6
         kaK9Ce2pFU8YyNtdVlJR9iBYno7Fn9unNDzVsMxmvLiDLDohH37mHsJGRfe0qh9pEupD
         5n1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wKrfGiJLmo4BFy866IR6WichX7+97mPLbqHHnF9C+U0=;
        b=MsRXnfNNTi5ZawjGoT2yFLlT1Rhz8iXy9dIp6LG3bjtS9bafYFxvCc2upacgcLBETv
         2+fp5Kn3VrCVkhoNhLs9ok+WeIeUSk3DkegTul3h/idKX44uE8lcyKt+QiT3yWRbRrQU
         Wd9ZOXAR9SZIBzN+HrhTjYSQdu//zFg6tV3pWmD0a/qqp7nd5yk/8k8Zva545Lg3Uu4q
         H4t2cBkAh4Dn6G8tqYFUDdDYSDJ8KVDwUCJAFts7qoM/bRy/PROBj+TJmYFz7y1GnpyM
         4dpNz/y26ApnVboSTdZ5qzlzGhpXcW/aDxcoAivkHY8Prm7aOu3SZlIGJJU/okCCHCCw
         8iBA==
X-Gm-Message-State: AOAM530lWtLtxnYKQ9MU+HOrlzrMxamB1yq3Z/2taGyjcjlv3OVYoadp
        RvGFgq1GyrVNsPgC1EJ8Y65pGLutQ//Eeo+OX2XtpQ==
X-Google-Smtp-Source: ABdhPJxofkcdUiHzaUKIy+2kqqXjOLT/9cQ+sV/siMZg3Y8bfjR1kNm3ScUeEhTDEm/js2o4xLPKaPtXhCOBvTQOClU=
X-Received: by 2002:a63:824a:: with SMTP id w71mr1300001pgd.74.1640059983994;
 Mon, 20 Dec 2021 20:13:03 -0800 (PST)
MIME-Version: 1.0
References: <20211208091203.2927754-1-hch@lst.de> <YcD/WjYXg9LKydhY@casper.infradead.org>
In-Reply-To: <YcD/WjYXg9LKydhY@casper.infradead.org>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 20 Dec 2021 20:12:53 -0800
Message-ID: <CAPcyv4gfGBSWf=+WxkSPbca1BH=OeTmFoSjUBKJV-aos=YwWMA@mail.gmail.com>
Subject: Re: [PATCH] iomap: turn the byte variable in iomap_zero_iter into a ssize_t
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        Dan Carpenter <dan.carpenter@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Dec 20, 2021 at 2:10 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> Dan, why is this erroneous commit still in your tree?
> iomap_write_end() cannot return an errno; if an error occurs, it
> returns zero.  The code in iomap_zero_iter() should be:
>
>                 bytes = iomap_write_end(iter, pos, bytes, bytes, page);
>                 if (WARN_ON_ONCE(bytes == 0))
>                         return -EIO;

Care to send a fixup? I'm away from my key at present, but can get it
pushed out later this week.
