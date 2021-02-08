Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A294313AB1
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Feb 2021 18:20:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233998AbhBHRTI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Feb 2021 12:19:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232971AbhBHRST (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Feb 2021 12:18:19 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12A1AC061788;
        Mon,  8 Feb 2021 09:17:39 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id z22so19245589edb.9;
        Mon, 08 Feb 2021 09:17:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=imzUBYqth9MDIjfnTJYC0ftXHC+oAklPoJiZ1t7KsCI=;
        b=Fokl/AccVl6VsEWtolI0Dt31QBO4j/BexGCG+zyDS+0m00MbcuCE/DDV48ESUJeref
         BLmZCXv26D6L4nhoL0uyvymxxI+7dtdP3a/a82WjdPCx+HAxx7vU874IduVszvheNHc4
         IrAVsKY2nZYCSsJRnBGODBTDiAndRF1NL7m4EbaidJ6djYlZiGWc8HIy+0LIh+JZFIDK
         UQk3URbCY1qCRWrsq1r1XZjXhfEXZMBh+ZvYC/mR+ekDyPuz9bmtF8x1gcZYQLuBjale
         QelGK6nDuNPnYFRy77dlnNgtlBXo0SojbJlNmJFcetKnlkj6YzCCBaRUEiGs04eGFZGg
         U0cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=imzUBYqth9MDIjfnTJYC0ftXHC+oAklPoJiZ1t7KsCI=;
        b=jeePl77IzTpvwmvYUet09Evtb8sPdcOJgZBHBu1jvYbDJ3VhKAF5Q3gyl+qtrLIfgg
         TfLnu4+83lKqEzG4e/iXqiXFliHvSYMEPIHoZtysyR7/JoUmwL5w4mq7bChhI9HBwv54
         Fe5lg5bN0XRcWJoCiEtFssoB0j3vGI50GYKvhyc0Wxmrnq+HlyxSnQOLwQYf8lvMvE7C
         2wDT/DEScX9tyWVuB2J4nWxAPa4NbSvFrlQu6NJHxqCGnrGMEjCsIxL1O4IGY622rSsg
         wMLnz/uHOX607l69i/O1ZCYonq4ia1T2Sa8iIs46GRYmTrBfgWsLSazHnO4UEobsS2+7
         kL8Q==
X-Gm-Message-State: AOAM532zdrtLhJKzTelkyGvZ7WNV+ND1mtxmxuNocr7bCxCRsyGYeXMc
        oWYqSItORTiGqR9Ysq19ZA==
X-Google-Smtp-Source: ABdhPJwZ+ImowP0VOFpF7TZyKcgMOWjCCjEgVuL4hoyOgMDOzHeFy7s+Yz1gG28kPin6hdbaAQPCjA==
X-Received: by 2002:a05:6402:54b:: with SMTP id i11mr7271347edx.262.1612804657857;
        Mon, 08 Feb 2021 09:17:37 -0800 (PST)
Received: from localhost.localdomain ([46.53.253.245])
        by smtp.gmail.com with ESMTPSA id o10sm9152068eju.89.2021.02.08.09.17.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 09:17:37 -0800 (PST)
Date:   Mon, 8 Feb 2021 20:17:34 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Kalesh Singh <kaleshsingh@google.com>, jannh@google.com,
        jeffv@google.com, keescook@chromium.org, surenb@google.com,
        minchan@kernel.org, hridya@google.com, rdunlap@infradead.org,
        christian.koenig@amd.com, kernel-team@android.com,
        Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Alexey Gladkov <gladkov.alexey@gmail.com>,
        NeilBrown <neilb@suse.de>, Anand K Mistry <amistry@google.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Michel Lespinasse <walken@google.com>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        Andrei Vagin <avagin@gmail.com>,
        Yafang Shao <laoar.shao@gmail.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v5 2/2] procfs/dmabuf: Add inode number to /proc/*/fdinfo
Message-ID: <20210208171734.GA42740@localhost.localdomain>
References: <20210208151437.1357458-1-kaleshsingh@google.com>
 <20210208151437.1357458-2-kaleshsingh@google.com>
 <20210208152244.GS308988@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210208152244.GS308988@casper.infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 08, 2021 at 03:22:44PM +0000, Matthew Wilcox wrote:
> On Mon, Feb 08, 2021 at 03:14:28PM +0000, Kalesh Singh wrote:
> > -	seq_printf(m, "pos:\t%lli\nflags:\t0%o\nmnt_id:\t%i\n",
> > +	seq_printf(m, "pos:\t%lli\nflags:\t0%o\nmnt_id:\t%i\ninode_no:\t%lu\n",
> 
> You changed it everywhere but here ...

call it "st_ino", because that's how fstat calls it?
