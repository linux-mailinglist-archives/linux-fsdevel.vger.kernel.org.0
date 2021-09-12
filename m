Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AF70407CA2
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 Sep 2021 11:30:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233030AbhILJbZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 12 Sep 2021 05:31:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232845AbhILJbY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 12 Sep 2021 05:31:24 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9730C061574;
        Sun, 12 Sep 2021 02:30:10 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id u15-20020a05600c19cf00b002f6445b8f55so4455113wmq.0;
        Sun, 12 Sep 2021 02:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xgV/sn+/3Ey0N5S68WosMZFPdIOrQlkD0e3kQlwm7fo=;
        b=JiXnFTDpTnCvLksqHy1qlCiFBeOBZRTd7ZzgK97kTCIc723ySIvIknR0ZM//uaajWV
         /gf3897MJnYyhT1pAuTXzEcjTQO5Dfl3Pp6Ilooj2dXUikXzuNgUeLjTBpMENaUji/FZ
         9FHYAqx6EpA19uuRGIXDD/wJYn4jS4rILQiPiBjHD6TgvvUwJVP2mIyvUm/iRusqv+I+
         AfQoXIDh+gVORFUXnbkKYdbP3J8ssFH/De4//QuQzXUlRPu1jqJMZ6fd0L/IMwgW8usf
         huMlU3TBG4O/h+l3/uTxHQ8U3Uh/fjyc2XXQGvALO9afdqUzgudY4KOtmOUXz4fSAa/a
         qtZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xgV/sn+/3Ey0N5S68WosMZFPdIOrQlkD0e3kQlwm7fo=;
        b=baRbzixU6R6Q3STZKlSRTEqkXOHFWyN1U29AQW+9dH0DT8PtufjJmydcjriRRQb7Dj
         ohh7a+8Mkf+balNfIxUaDfLGtvlw8EjHDFXFgBHTjbkyqD2S/yLWik2zja/ZZlDOI0LY
         eJv1ZUw2KF66iurSB78N4ha5CQy533aavHMUGSWaMuSWL7qt+2lfUwCiw39gc/JAGKin
         F9cCzxat+IIBwTYuGhbymHsq6OBb5O15Q5KGZbKUGWCe8hIJvOXQp7dGiInyb79MkFwo
         AUFCEu7XkkekyyOBqjGCauVn/sG5jDtF4ScKVAPx/IQirHHJE0U2fcnzIN+ashLG8wvo
         mEIA==
X-Gm-Message-State: AOAM532oxe7DhbyoHEqOiUFJI/6VmRv2MrhmbgTmg5K9A1d61X0qrYYn
        xAdOKt/dVQdTpvIfXROl8OFcZYePrQ==
X-Google-Smtp-Source: ABdhPJzzJSHXVIlGgZvIyj39aqlTuJ0L7fdisAtkVkZQ+lQ9Gvkno5MKwoGCLqDB/vx8aitngmMyJg==
X-Received: by 2002:a1c:7e8a:: with SMTP id z132mr5860691wmc.75.1631439009364;
        Sun, 12 Sep 2021 02:30:09 -0700 (PDT)
Received: from localhost.localdomain ([46.53.249.181])
        by smtp.gmail.com with ESMTPSA id j20sm4121995wrb.5.2021.09.12.02.30.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Sep 2021 02:30:09 -0700 (PDT)
Date:   Sun, 12 Sep 2021 12:30:07 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Alexei Lozovsky <me@ilammy.net>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Christoph Lameter <cl@linux.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/7] proc/stat: Maintain monotonicity of "intr" and
 "softirq"
Message-ID: <YT3In8SWc2eYZ/09@localhost.localdomain>
References: <06F4B1B0-E4DE-4380-A8E1-A5ACAD285163@ilammy.net>
 <20210911034808.24252-1-me@ilammy.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210911034808.24252-1-me@ilammy.net>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Sep 11, 2021 at 12:48:01PM +0900, Alexei Lozovsky wrote:
> Here's a patch set that makes /proc/stat report total interrupt counts
> as monotonically increasing values, just like individual counters for
> interrupt types and CPUs are.
> 
> This is as if the sum was a shared counter that all CPUs increment
> atomically together with their individual counters, with the sum
> correctly and expectedly wrapping around to zero once it reaches
> UINT_MAX.
> 
> I've also added some documentation bits to codify this behavior and make
> it explicit that wrap-arounds must be expected and handled if userspace
> wants to maintain accurate total interrupt count for whatever reasons.

How about making everything "unsigned long" or even "u64" like NIC
drivers do?
