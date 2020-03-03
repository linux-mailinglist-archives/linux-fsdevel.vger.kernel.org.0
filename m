Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77D9E177888
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Mar 2020 15:15:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729097AbgCCONN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Mar 2020 09:13:13 -0500
Received: from mail-qk1-f175.google.com ([209.85.222.175]:37180 "EHLO
        mail-qk1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbgCCONN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Mar 2020 09:13:13 -0500
Received: by mail-qk1-f175.google.com with SMTP id m9so3492301qke.4
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Mar 2020 06:13:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=KehBbwY8xejXFJnURHhNkCBl//IgAXF4mBmFJJ9y78g=;
        b=I57wy1bZR4jYUlZnVg2GT2efRrhLWQiwWuiYb3xeHtgIW1IFDYWk3Wk79E1Puj0IG3
         BvDLnNhqpNbQTYGj4UM42fa/+ggZEbp9ZnSE0+zoTIEMrOKfBkRaUlMO3EFN6HpalKPO
         h4jZk8ZOiUmp6R+iDROM1JCx3HHcSQDyk6oFqpXLVVsqPF0ScxcBIVGBifzIgaA+u5tW
         GmMofp6lzdgXN1SntQgd2bVOJDm8EhJm2juMnWCZyIUhZB52Z3j4qwecB4JyoB1OHq0P
         GKXZcLayPwECEwkfKKbyPyqmLnmLz2Faf2I7c8NWbW4WZve4WBtHu6MlKqM9dDqQpLnP
         Q+IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=KehBbwY8xejXFJnURHhNkCBl//IgAXF4mBmFJJ9y78g=;
        b=Anz/jr/zVq+9UcXojJNLzUXxkojpb8fFFYt3qGdrVL+3ZbKSUGkDWrDTIApZUw0Gpt
         R8ugCCEFyUglKDF4GdHM4YwvfavcB2HBK5D3vKW9VBEwwI/6lNs4rRwet3taUaai2NGN
         wjDJEsxG86mb43x1Ilqn4dyLqdTCoWeX1GawwuuZ6zsg/m2DjrfQdusj1lvGS9JaysWw
         Bc+jO6JA6R7YW1qgag7mENK+qFJB3xXdzuUCMWSfdDfVJx5BNSry6sCBE47UQB3D4JiQ
         SN0O98NxUNrkNiJCggJeYxdTMschYU2vr7TYCttLGWKfggPnT2RwhVX+xQ9iOzgOwl77
         ZaCQ==
X-Gm-Message-State: ANhLgQ2HvdPpIR/2kV5ZEe6A31CPFeaZY6eagcez4SIqppIts92fYMXu
        TO/3yPpNzNmsV9/36V6V6EM=
X-Google-Smtp-Source: ADFU+vtUO9HsiXNFIE6BWCyk8HbS746XX+UIKswbThDXVPeHj+co9Q88CKTqRIDHNQcWqX6bC4HMTA==
X-Received: by 2002:a05:620a:22cc:: with SMTP id o12mr4364385qki.331.1583244792301;
        Tue, 03 Mar 2020 06:13:12 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::7f70])
        by smtp.gmail.com with ESMTPSA id v6sm3677701qkg.102.2020.03.03.06.13.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2020 06:13:11 -0800 (PST)
Date:   Tue, 3 Mar 2020 09:13:11 -0500
From:   Tejun Heo <tj@kernel.org>
To:     Michael Stapelberg <michael+lkml@stapelberg.ch>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Jack Smith <smith.jack.sidman@gmail.com>,
        fuse-devel <fuse-devel@lists.sourceforge.net>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [fuse-devel] Writing to FUSE via mmap extremely slow (sometimes)
 on some machines?
Message-ID: <20200303141311.GA189690@mtj.thefacebook.com>
References: <CANnVG6kZzN1Ja0EmxG3pVTdMx8Kf8fezGWBtCYUzk888VaFThg@mail.gmail.com>
 <CACQJH27s4HKzPgUkVT+FXWLGqJAAMYEkeKe7cidcesaYdE2Vog@mail.gmail.com>
 <CANnVG6=Ghu5r44mTkr0uXx_ZrrWo2N5C_UEfM59110Zx+HApzw@mail.gmail.com>
 <CAJfpegvzhfO7hg1sb_ttQF=dmBeg80WVkV8srF3VVYHw9ybV0w@mail.gmail.com>
 <CANnVG6kSJJw-+jtjh-ate7CC3CsB2=ugnQpA9ACGFdMex8sftg@mail.gmail.com>
 <CAJfpegtkEU9=3cvy8VNr4SnojErYFOTaCzUZLYvMuQMi050bPQ@mail.gmail.com>
 <20200303130421.GA5186@mtj.thefacebook.com>
 <CANnVG6=i1VmWF0aN1tJo5+NxTv6ycVOQJnpFiqbD7ZRVR6T4=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANnVG6=i1VmWF0aN1tJo5+NxTv6ycVOQJnpFiqbD7ZRVR6T4=Q@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

On Tue, Mar 03, 2020 at 03:03:58PM +0100, Michael Stapelberg wrote:
> Here’s a /proc/<pid>/stack from when the issue is happening:
> 
> [<0>] balance_dirty_pages_ratelimited+0x2ca/0x3b0
> [<0>] __handle_mm_fault+0xe6e/0x1280
> [<0>] handle_mm_fault+0xbe/0x1d0
> [<0>] __do_page_fault+0x249/0x4f0
> [<0>] page_fault+0x1e/0x30
> 
> How can I obtain the numbers for the next step?

Yes, that's dirty throttling alright. Hopefully, the
balance_dirty_pages tracepoint which can be enabled from under
/sys/kernel/debug/tracing/events/writeback/balance_dirty_pages/ should
tell us why bdp thinks it needs throttling and then we can go from
there. Unfortunately, I'm rather preoccupied and afraid I don't have a
lot of bandwidth to work on it myself for the coming weeks.

Thanks.

-- 
tejun
