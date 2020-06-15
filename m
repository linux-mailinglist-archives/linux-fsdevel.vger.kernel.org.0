Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F6BC1F9010
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jun 2020 09:38:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728528AbgFOHiB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Jun 2020 03:38:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728492AbgFOHiA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Jun 2020 03:38:00 -0400
Received: from mail-yb1-xb42.google.com (mail-yb1-xb42.google.com [IPv6:2607:f8b0:4864:20::b42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAC40C061A0E
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Jun 2020 00:38:00 -0700 (PDT)
Received: by mail-yb1-xb42.google.com with SMTP id m16so8526310ybf.4
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Jun 2020 00:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OR0mfp69BO369dwMXiG/0IV7r83mKSvkOO+HBHsDV1U=;
        b=T/QAfqa4gFf2yPcnbt8MpH2hlEvC+xI2OD12t7di66bI1nfIJIzk+a+tCDwCLV8YPn
         BccJQNU5tQCdz8kxQHRhSAQmRfOaCS23oCHN8QHk53uiXkmEzU937zEX7hw2JXA13fLh
         H6AvPzEbMLFvJRql+xRU19vf1Ve9o1Z8CbYHM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OR0mfp69BO369dwMXiG/0IV7r83mKSvkOO+HBHsDV1U=;
        b=Qe4LXOzAoq3iNr4Sm/3WdsB7y+knzZbBg+V+zfWejMAONJrOl0TPuNkUwgV41t4xst
         tbdCovbLUs5ZYtzhORJW2C3JvzNLAFsmabwhd1l4CSlj4/G0SaO3Q0DE9vR+NHLvpWV8
         8wWAx5d8GPrzbzB50ZVHXS/ILaYHGxxtJuIMSWOPqvuosLjwa/gK2ABYmwWuLAMoQbIF
         C9m7RC9M4l1CoFBmAoZZWezEJEB3dE/yuGvvzOVedUFsT+Z4p0JvU5me8eyTy0PG7bf2
         pjAf6Ex+r5hrsx+yeJAgWephjoVvO/ZSP1mCcLYHNvEq8rgjvEyyqNiT8zPWAr7lW/VH
         UvDw==
X-Gm-Message-State: AOAM530FqgucWsv813r+CGmgkBPzQ/5N4TPBlrY3p4daiXsBm/H0p4t7
        njJlaIf+OnfwTi6UtKGOgIhh9yP2+a0QUdyTXWhirA==
X-Google-Smtp-Source: ABdhPJyyI2Fd9JGRDW2DjCfgSu7Y51EYv2sGWjoCOWb8tbaxFYxhbnljZkgtyjnD4MYgui6HMB1R8+4Pylx55gLLtpE=
X-Received: by 2002:a25:b8c:: with SMTP id 134mr44867223ybl.428.1592206679759;
 Mon, 15 Jun 2020 00:37:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200601053214.201723-1-chirantan@chromium.org> <20200610092744.140038-1-chirantan@chromium.org>
In-Reply-To: <20200610092744.140038-1-chirantan@chromium.org>
From:   Chirantan Ekbote <chirantan@chromium.org>
Date:   Mon, 15 Jun 2020 16:37:48 +0900
Message-ID: <CAJFHJrq6aeVkKaYL2jcYjxFkcnEp_T6wc1tQ8pZYbwsubKW66A@mail.gmail.com>
Subject: Re: [PATCH v2] RFC: fuse: Call security hooks on new inodes
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Vivek Goyal <vgoyal@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        virtio-fs-list <virtio-fs@redhat.com>,
        Dylan Reid <dgreid@chromium.org>,
        Suleiman Souhlal <suleiman@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Friendly ping.  Are there any concerns with this patch?  I know I
probably need to split it up into 2 patches: one that adds the flag
and one that implements support.  Since v2 adds a new flag to the
init_out struct I'd really like to get this merged upstream as
carrying it locally would effectively mean forking the protocol.

Thanks,
Chirantan
