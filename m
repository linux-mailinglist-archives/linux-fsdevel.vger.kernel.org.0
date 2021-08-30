Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0C613FBB32
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Aug 2021 19:42:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238044AbhH3RnW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Aug 2021 13:43:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234189AbhH3RnV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Aug 2021 13:43:21 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C775C061575
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Aug 2021 10:42:27 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id y34so32810662lfa.8
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Aug 2021 10:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Eq9gWq/jC1hHa9yf5Uils26OK8doFFXy1AXclzZU12g=;
        b=FYKREKZbqC8UMhMxllhLg2w1tBe0Lc4CTjbaUN3KnbgKJg9RUdU76r9/FODabaTFNO
         NllwIfj8AZUYyXB1oXSWzco2h/AxSHwivNiHoePjSMaQf0d1PxTmMy04s45YfOaj0GPD
         F/wpfx4iEEQie8ZcC9BFYcApln+tTNmInfCEc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Eq9gWq/jC1hHa9yf5Uils26OK8doFFXy1AXclzZU12g=;
        b=AFpojeUrlts4BY2OW0GAkFw9xC3UrTJ9dwNpca/XYt1p42kNBwHKyxGfe39VF8Fkab
         cHn1Vgb4+kj4NwMTZOqyjee+vfmlU+RKRedgl3lXtiuvE7LdAn9qEHrQekHYX4BohVMh
         aDoRK6VQ0jZx/3GZR54+89eMnbFN1WHX96dE3Cx9tHOFtpD1A4Z+zTv1RzGxMiGbkAai
         qSjvMsILT5EpNRr2QLG0O9HjeOkpz11F2JCiqSDHOcLbEL5W5U57LuA24AX383a5kmoV
         iDxf0upryBDKL5LDzzWPdT9rgWbVzB5uOIJIUhHhhIeblMArjIioQvBOtPLTNBCe1v6R
         3gaw==
X-Gm-Message-State: AOAM5321w4/NWecfLzjZMT2+IuTSe7SOg/kv53A/phbek0VFKvpa08Ri
        1+0J1WEOhqulElKLbNLm0R5oQynNJ1UPzWDP
X-Google-Smtp-Source: ABdhPJwaAhKVOsY9jE4eE2COAb+PV6H4+D5e0YoXQJbquG6UqTJtF1Bz39xS0ObHD335Xy7FdTHkqA==
X-Received: by 2002:a05:6512:3e1b:: with SMTP id i27mr7428211lfv.273.1630345345558;
        Mon, 30 Aug 2021 10:42:25 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id k12sm1855138ljm.65.2021.08.30.10.42.25
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Aug 2021 10:42:25 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id c8so20263555lfi.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Aug 2021 10:42:25 -0700 (PDT)
X-Received: by 2002:a05:6512:681:: with SMTP id t1mr17677322lfe.487.1630345344811;
 Mon, 30 Aug 2021 10:42:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210825124920.GF14620@quack2.suse.cz> <20210825125309.GA8508@quack2.suse.cz>
In-Reply-To: <20210825125309.GA8508@quack2.suse.cz>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 30 Aug 2021 10:42:09 -0700
X-Gmail-Original-Message-ID: <CAHk-=whWbj7Xh4ddcgrO6KqQ+edvAsdkmxt-gDw8gMh8VcugXA@mail.gmail.com>
Message-ID: <CAHk-=whWbj7Xh4ddcgrO6KqQ+edvAsdkmxt-gDw8gMh8VcugXA@mail.gmail.com>
Subject: Re: [GIT PULL] FIEMAP cleanups for 5.15-rc1
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 25, 2021 at 5:53 AM Jan Kara <jack@suse.cz> wrote:
>
> Forgot to CC fsdevel so adding it now.

Well, the "Re:" in the subject line (or possibly the quoting in the
body) then meant that pr-tracker-bot didn't react to this even after
adding the mailing list.

So this is a manual version of the pr-tracker-bot "it's been merged"
notification.

             Linus
