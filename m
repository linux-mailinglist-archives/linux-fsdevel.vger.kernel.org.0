Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A74BC407010
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Sep 2021 18:56:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230440AbhIJQ6F (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Sep 2021 12:58:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbhIJQ6D (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Sep 2021 12:58:03 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC007C061574
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Sep 2021 09:56:51 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id a4so5321924lfg.8
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Sep 2021 09:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RzyeZQUsMmMmvYBQjLaM4EY95lNntxr7uNPPktCtTzo=;
        b=GHDXJE8fX5DD4GMb0tl0wq6/coIMVKOSg37tF97o+ah9HRjsfThGByi03ZSen4AqSr
         zUKQ7jXGjiY0aX37XRIGfaRjciAfGMiUGF1ZnKXANSy7YleplXcjv8yvgheCDNH1nNez
         Qh+vnVbtHHn3zTNm3+GPl1GyQD0cROI9Wn0+c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RzyeZQUsMmMmvYBQjLaM4EY95lNntxr7uNPPktCtTzo=;
        b=rhUxF4+9nikLiWMXCGy47/zAsK15ZSCUx3Mq0EIte/FWPnb0d2Ht1xlbJQ1dd7URfx
         3R/Qf4fvp1RJXjgTtNJ1I4SHd9omKBPrSODRnS9gM8HW3ecsWuuxmFjlOHMjmJmqRlac
         VQIsLRchBfcrQUkQteYH6p39EROTKvTB/gsWuCl/f0iRQgFGOm4XboLtof+/5AJLiaAD
         4zyeeWuR5aO80DpsNy8czGyNvI0osnuwkd4iUe+30QGJ0GiHfPup48wnRYwsW4eDWV8G
         C2QS5ZYgjtqJ+3fpmFuuVoc8QBsijdTmzxcnwZBryWIbyutggyP5yce0PPIdNFq9O7xf
         OJJg==
X-Gm-Message-State: AOAM532ZSUEALBERSM7cLJKlCSlIMNKXejcShDVyaIMWZKGAXP3Qywo2
        iCMOq4U/hqeDfWBP8ScIBvjeAvE01XwwQlezAGM=
X-Google-Smtp-Source: ABdhPJx8/HqBjJISGz8VzUhF2BJH77sFWYm2Kf4ELVNdPGSPsi9x+00Ax+HzogMy3smLIe0Kor4N0w==
X-Received: by 2002:ac2:5d27:: with SMTP id i7mr4755112lfb.488.1631293010015;
        Fri, 10 Sep 2021 09:56:50 -0700 (PDT)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id y6sm603620lfa.122.2021.09.10.09.56.43
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Sep 2021 09:56:44 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id k4so5336960lfj.7
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Sep 2021 09:56:43 -0700 (PDT)
X-Received: by 2002:a05:6512:34c3:: with SMTP id w3mr4533173lfr.173.1631293002850;
 Fri, 10 Sep 2021 09:56:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210825124515.GE14620@quack2.suse.cz> <CAOQ4uxi4S0oMSXTfpNTCqJPoO4=at1_f1cA-3LAUmuOy4CcqKw@mail.gmail.com>
In-Reply-To: <CAOQ4uxi4S0oMSXTfpNTCqJPoO4=at1_f1cA-3LAUmuOy4CcqKw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 10 Sep 2021 09:56:27 -0700
X-Gmail-Original-Message-ID: <CAHk-=whKKxtnHikkDFBtDUKPttRoFeVNLO3L0i6cUj=qHDz83w@mail.gmail.com>
Message-ID: <CAHk-=whKKxtnHikkDFBtDUKPttRoFeVNLO3L0i6cUj=qHDz83w@mail.gmail.com>
Subject: Re: [GIT PULL] Fsnotify changes for v5.15-rc1
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 9, 2021 at 11:57 PM Amir Goldstein <amir73il@gmail.com> wrote:
>
> Linus,
>
> At the risk of being too nagging, please see my patch [1] to fix a
> regression [2] reported after this pull request was merged.

Not too nagging at all, pinging me is absolutely the right thing to do.

During the merge window I end up dealing with a lot of email, and
concentrating on pull requests, and reminding me and making sure I'm
aware of the patch was the right thing to do.

Applied in my tree now.

Thanks,
            Linus
