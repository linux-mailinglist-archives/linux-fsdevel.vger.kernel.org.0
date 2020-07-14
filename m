Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4787121F9D6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jul 2020 20:47:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729674AbgGNSrD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Jul 2020 14:47:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729652AbgGNSrC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Jul 2020 14:47:02 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C467C061755
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jul 2020 11:47:02 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id x9so14784258ljc.5
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jul 2020 11:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UVfERwX13P7D/zjdH5ULtGSx06Jqz2dlyfHBwzDUvow=;
        b=cf+kPlwmN5Oye6FRcXNNhAYEJW2qLe3XOLEbJiJ/btJtVholzBZPu9qL2yMrTjZdiK
         BBO5EZyp0QC3iN7Fbp0IJzqRCWMvQyFdnv1Te0JrRgFFGFruNHY0fUyLUDpz5aYRm5V5
         vsqL6aZCjYI/dcwxWKv/09YM6HQLItcvu7zAk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UVfERwX13P7D/zjdH5ULtGSx06Jqz2dlyfHBwzDUvow=;
        b=S9pyFbvrbYqtEPcIw+aeYfnIismxh/l4imIz32DyJ04B1v4cp7EFcWrzgSUmaH5E9L
         nLAkHijPjl4rXfLvwtT1MMZ/tppcbrHYELcBw6akvGkYiaLR8jln4Rl7xXN2Tbbo0T1S
         yjxPgQQc+UcG7c5WT8sgwKySc80NYbpu6KiU+xIH0UyBAQ/VbR+kmM5FeisfPVRXQZUE
         +HuMkkL3u/lwJeTiL1Jn+RRAUZM0jhgCq3i6jjhjWwhBej9WZpRuTphuU/K/n0g5HstH
         CjTfh7buAWf/JRHihgQLe8CK213zZmQ8PX2hXgmwKW+HpB5U1LYhAzGOGVJ/kAb9X7Hx
         7z5w==
X-Gm-Message-State: AOAM5323p6LUhVztGpUhSgf4G6JeQ+gYHGaBOo+xoPBUDjaonX6KjS6v
        oWzOoQL+IpmdwF3+Vy1P02WLOBQVNwI=
X-Google-Smtp-Source: ABdhPJzWNTTspXneCbThQn90h+FZSOmc8Cse3zTWRE4+3Jgnko4U0TMZ1KedxTsURHXxUXZQ57yh8Q==
X-Received: by 2002:a05:651c:307:: with SMTP id a7mr2779226ljp.297.1594752420497;
        Tue, 14 Jul 2020 11:47:00 -0700 (PDT)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id w19sm4798288ljh.106.2020.07.14.11.46.59
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jul 2020 11:46:59 -0700 (PDT)
Received: by mail-lj1-f177.google.com with SMTP id h22so24776741lji.9
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jul 2020 11:46:59 -0700 (PDT)
X-Received: by 2002:a2e:999a:: with SMTP id w26mr2893350lji.371.1594752419129;
 Tue, 14 Jul 2020 11:46:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200623223927.31795-1-fllinden@amazon.com> <20200623223927.31795-3-fllinden@amazon.com>
 <20200625204157.GB10231@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com> <20200714171328.GB24687@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
In-Reply-To: <20200714171328.GB24687@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 14 Jul 2020 11:46:43 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj=gr3F3ZTnz8fnpSqfxivYKaFLvB+8UJOq3nTF9gzzyw@mail.gmail.com>
Message-ID: <CAHk-=wj=gr3F3ZTnz8fnpSqfxivYKaFLvB+8UJOq3nTF9gzzyw@mail.gmail.com>
Subject: Re: [PATCH v3 02/10] xattr: add a function to check if a namespace is supported
To:     Frank van der Linden <fllinden@amazon.com>
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 14, 2020 at 10:13 AM Frank van der Linden
<fllinden@amazon.com> wrote:
>
> Again, Linus - this is a pretty small change, doesn't affect any existing
> codepaths, and it's already in the tree Chuck is setting up for 5.9. Could
> this go in through that directly?

Both ok by me, but I'd like to have Al ack them. Al?

               Linus
