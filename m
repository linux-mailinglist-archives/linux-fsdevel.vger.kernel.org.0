Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3BDAFAD847
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Sep 2019 13:50:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730888AbfIILuk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Sep 2019 07:50:40 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:34300 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726654AbfIILuj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Sep 2019 07:50:39 -0400
Received: by mail-io1-f66.google.com with SMTP id k13so12639503ioj.1;
        Mon, 09 Sep 2019 04:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RTNpYr6ymqFhD4zr98gAWKjHikkNTFmbfj5AV7oH6d0=;
        b=s76FTppZdt8nReg8wyiDx7MuWv8oCZXYc7JcTwibRAbrhgT10Uap3DTpqSl9tvl06y
         OONKyIvHZijjWZG6cfhMI8J8uMUNkP4q8+r1Y9Y5QTTR7W4QNEdihWrSHSciTbiugqVg
         8a1CwrAmhEigD4EKMHi861IAGHdeYYIIO1D6GoSt6YCa+E13oICbtyzcIZQdF9bfzAZj
         dx9wlrEVpw0GCirCXCu7VuTXsyeMTwj76EqAmbBHzeXsW+c539elfqOAn3IlDoi1rf5C
         m4YuO0Yp1QiL7d/5zJNdX0qfU209o7rwcdqKYjTuIr37Ppo78/0vBqFmHlqT6DZVfqJa
         r58Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RTNpYr6ymqFhD4zr98gAWKjHikkNTFmbfj5AV7oH6d0=;
        b=rjz3uVN6r95cE/emlDB2lmYZ6pxD/WYyfrSheZGjsQ7vP4jWdiXOf4dA4uvpmXQMIu
         9RoOVHmKFR8y5aMEBwuMEkl3jpWBWz2eoUVr0sU8pzra+8yp3GyyLSWNVpybT6dDoKHc
         g7pVUsyTLagBtQbhKtloYbue7QCQZp8EU24f9eD7nhEwCeCgOKwf+4Nfx1/Yl+l9O6b1
         lvSqdoZySRPuqz/ypZOwc0DuunqMCVuubpdAAGQxAott1W7bhzg+0/k5/bUN8bdn5mWY
         TOeZC239tLE3Lw3FXZQSLe2egaQ8ScutzwekHyvYQVxQ1t6cgWSsE0TCs+KDnwAtQzhe
         ePag==
X-Gm-Message-State: APjAAAVvBDUfOiQVVgbhB3IBoDswSnPWX/FpKtQYjUNZ004NrQGBauTV
        314RgK4pH8AEHDcg89BDGpkMJ+oGg6k/BVAln90=
X-Google-Smtp-Source: APXvYqyEBjI7PM715JkHShOCebB0yinLP+BC54gWQCczfVpJ+dW8DO/Uac5evGHHfkj57CwGcGhoBoSKlLso8MkaqR8=
X-Received: by 2002:a5d:9714:: with SMTP id h20mr20337445iol.294.1568029838120;
 Mon, 09 Sep 2019 04:50:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190909102340.8592-1-dima@arista.com> <20190909102340.8592-5-dima@arista.com>
 <20190909111812.GB1508@uranus>
In-Reply-To: <20190909111812.GB1508@uranus>
From:   Dmitry Safonov <0x7f454c46@gmail.com>
Date:   Mon, 9 Sep 2019 12:50:27 +0100
Message-ID: <CAJwJo6YX2qQit9aTbMhg8L5+JE1EsLzKyNt0a3X97zvJ-O9dNQ@mail.gmail.com>
Subject: Re: [PATCH 4/9] select: Micro-optimise __estimate_accuracy()
To:     Cyrill Gorcunov <gorcunov@gmail.com>
Cc:     Dmitry Safonov <dima@arista.com>,
        open list <linux-kernel@vger.kernel.org>,
        Adrian Reber <adrian@lisas.de>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrei Vagin <avagin@openvz.org>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Containers <containers@lists.linux-foundation.org>,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Cyrill,

On Mon, 9 Sep 2019 at 12:18, Cyrill Gorcunov <gorcunov@gmail.com> wrote:
> Compiler precompute constants so it doesn't do division here.
> But I didn't read the series yet so I might be missing
> something obvious.

Heh, like a division is in ktime_divns()?

Thanks,
             Dmitry
