Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B6F081778CA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Mar 2020 15:25:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727909AbgCCOZP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Mar 2020 09:25:15 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:34364 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbgCCOZO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Mar 2020 09:25:14 -0500
Received: by mail-qt1-f194.google.com with SMTP id 59so1712604qtb.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Mar 2020 06:25:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qz8bhnv0I8TXyq1XMurQya8Qmu0LrE3c6IwRtArQcqU=;
        b=W07icVy3fNTM0LqYTX3/r2GpDfvgpWX1kFWwW/kHp/eoQeC7MVE9uLi1RmAF6d8kix
         P8EMRVI2CKrF1rksdOdFwqd9iTKrUK+ro5WSp/xHU0j/DvYkQ4m645UWU9RKRFFJrHvA
         AwH/2jkSgmRXpj2Asprh6lDKSVC0TfIK+rli5kfRICBhI9WYwbMEwwVJsewDI4E9etvt
         7iOWAzF8CTjJB6U+pBd7EkMAAbXp9QeVGJRU+aHQVkyqFUQf5oZHv+stfZAHhWv4o0ox
         Xxf4VRclR19n9S4TgwKY1mCShsOq9VZ7zHaz3UPlDebPZb7GhwnrMw52yvpb8Z1A83Za
         OpeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=qz8bhnv0I8TXyq1XMurQya8Qmu0LrE3c6IwRtArQcqU=;
        b=YHwnBMKog53N8m8CKwOB5Wbbc48YbfSoxYTikIdiJTjnxIkt9qas5/31VPfMepaG0v
         Agp3t9w+bzcz51OORHhX74GOjnF55Cmc+/cS+qNM48qLxgadsX4Dtvov6OYngowv19gs
         moBtnj/E5yzXRk/xO5CvoO1rRIAL68eyyCV7/mTya0LO3gd+poXKtJkaX6dpIP7ca2ec
         q4Elp/wNhpb3CFOYzppFJAQ263p/Pe1BmVF0tzT28RfkAKnKD3WWW00R2adWu4gTDjV9
         GJheXRH7LD7WAxshVTdfVnlwwottW4GmUv55KyVucO5lpYvEa8eSBFurPwVmUXKkMhmm
         0rVQ==
X-Gm-Message-State: ANhLgQ1ovv0SxOQ2OoqJE88aASOzxYL+f3xxbjSN2hKaFLmrD518jZed
        K9ctcxx8ZYwpCo86shAZuFg=
X-Google-Smtp-Source: ADFU+vvUdf/gf6lmbS0a1RQDQG8eIk8sCAy+gJCldsN0M4lFk9ta89/AvaDgb2th4n6W+s3FHhxv9g==
X-Received: by 2002:ac8:1688:: with SMTP id r8mr4681278qtj.144.1583245513690;
        Tue, 03 Mar 2020 06:25:13 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::7f70])
        by smtp.gmail.com with ESMTPSA id f89sm3436621qtb.7.2020.03.03.06.25.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2020 06:25:13 -0800 (PST)
Date:   Tue, 3 Mar 2020 09:25:12 -0500
From:   Tejun Heo <tj@kernel.org>
To:     Michael Stapelberg <michael+lkml@stapelberg.ch>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Jack Smith <smith.jack.sidman@gmail.com>,
        fuse-devel <fuse-devel@lists.sourceforge.net>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [fuse-devel] Writing to FUSE via mmap extremely slow (sometimes)
 on some machines?
Message-ID: <20200303142512.GC189690@mtj.thefacebook.com>
References: <CANnVG6kZzN1Ja0EmxG3pVTdMx8Kf8fezGWBtCYUzk888VaFThg@mail.gmail.com>
 <CACQJH27s4HKzPgUkVT+FXWLGqJAAMYEkeKe7cidcesaYdE2Vog@mail.gmail.com>
 <CANnVG6=Ghu5r44mTkr0uXx_ZrrWo2N5C_UEfM59110Zx+HApzw@mail.gmail.com>
 <CAJfpegvzhfO7hg1sb_ttQF=dmBeg80WVkV8srF3VVYHw9ybV0w@mail.gmail.com>
 <CANnVG6kSJJw-+jtjh-ate7CC3CsB2=ugnQpA9ACGFdMex8sftg@mail.gmail.com>
 <CAJfpegtkEU9=3cvy8VNr4SnojErYFOTaCzUZLYvMuQMi050bPQ@mail.gmail.com>
 <20200303130421.GA5186@mtj.thefacebook.com>
 <CANnVG6=i1VmWF0aN1tJo5+NxTv6ycVOQJnpFiqbD7ZRVR6T4=Q@mail.gmail.com>
 <20200303141311.GA189690@mtj.thefacebook.com>
 <CANnVG6=9mYACk5tR2xD08r_sGWEeZ0rHZAmJ90U-8h3+iSMvbA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANnVG6=9mYACk5tR2xD08r_sGWEeZ0rHZAmJ90U-8h3+iSMvbA@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 03, 2020 at 03:21:47PM +0100, Michael Stapelberg wrote:
> Find attached trace.log (cat /sys/kernel/debug/tracing/trace) and
> fuse-debug.log (FUSE daemon with timestamps).
> 
> Does that tell you something, or do we need more data? (If so, how?)

This is likely the culprit.

 .... 1319822.406198: balance_dirty_pages: ... bdi_dirty=68 dirty_ratelimit=28 ...

For whatever reason, bdp calculated that the dirty throttling
threshold for the fuse device is 28 pages which is extremely low. Need
to track down how that number came to be. I'm afraid from here on it'd
mostly be reading source code and sprinkling printks around but the
debugging really comes down to figuring out how we ended up with 68
and 28.

Thanks.

-- 
tejun
