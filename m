Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E7CD1CF5A4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 May 2020 15:25:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730051AbgELNZ0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 May 2020 09:25:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727859AbgELNZ0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 May 2020 09:25:26 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29F48C061A0C;
        Tue, 12 May 2020 06:25:26 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id c64so13445982qkf.12;
        Tue, 12 May 2020 06:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PTFxC40Ec7wOMd+ERavExEghGhS6XBq7Wvj2fntglJ8=;
        b=FDNc3WJa0vcrIlXtpcLbJPEaHig6WYKGXLTihc5rLW4Tn+74OO99gK4BHreesy1ChH
         SC++AU7M8QcXLivZnsUyba7/CKQp5QHeH8x8ErzhuMiVTXM+aAxN7tbY2CtOUE+1jXWy
         QU3jhaZOLsHZw1Suudr7VLD+FYipFu/z6+6zO3/Ub5WbDJ5BsRpXTUaLJ8s7H4Nmk2y2
         sNHLjeYp/Z4VcDlAKwu3npXk/EXLKV+UdHeEYXbeaKJQOoblqk1Bz3iVz1W8SaTPJ6dm
         xfvM09tdptP49PnjyL/56fp5zzMY/iAab+1OfbdRzHsoRzoe3uIZkVjVLGoBnh1gWDTn
         BS8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PTFxC40Ec7wOMd+ERavExEghGhS6XBq7Wvj2fntglJ8=;
        b=TKXE5KogGkgb+/RCvyXhJFX8+prQuB2CeJ/0VdgKB/kRH4aLViWKoog2Mq1JbOwvWF
         eYYylj0Trgju/NjQqRZ0E4/CyZ0c325xe54mWOstlMvXySSRfKy6OtvqtwZ0mLqM5o/6
         rfsizxkUxUp7SlDfoTWURMOrF3a2An9/NJ6S5CmbtqBj6MNrmR8cN8ROgTyL1EnFHsVa
         UtnghJE7QLxbW6EDs3gSgG+c/vSeiytv1lfr859mPloWg4cILp/h+qW5/8Lr4KFuEG+g
         Yp+E/XJvramc1AGmGTXH0a9a5VexO74p3D0KRzzbDj2dx9AkKZzqwbf6rW9CMAu3btSK
         Nl0Q==
X-Gm-Message-State: AGi0PuYQpien14tfHFZPQ+mEdiG5tlMu5qlaJJmS3wWkRQwl4iHt3oyB
        L2hbrEQo5MeVmv1mR8dszzQ=
X-Google-Smtp-Source: APiQypI+IJe+b1HpMdplJFp4nSZpTbaseSeCUJP03m5Kbkzx8bpdPe3PliatUtIW59Y6CcU0JB5hmg==
X-Received: by 2002:a37:9ec4:: with SMTP id h187mr20924117qke.72.1589289925201;
        Tue, 12 May 2020 06:25:25 -0700 (PDT)
Received: from dschatzberg-fedora-PC0Y6AEN.dhcp.thefacebook.com ([2620:10d:c091:480::1:4fca])
        by smtp.gmail.com with ESMTPSA id y4sm12033182qti.33.2020.05.12.06.25.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2020 06:25:24 -0700 (PDT)
Date:   Tue, 12 May 2020 09:25:21 -0400
From:   Dan Schatzberg <schatzberg.dan@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>,
        Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>, Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Chris Down <chris@chrisdown.name>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Ingo Molnar <mingo@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:FILESYSTEMS (VFS and infrastructure)" 
        <linux-fsdevel@vger.kernel.org>,
        "open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>,
        "open list:CONTROL GROUP - MEMORY RESOURCE CONTROLLER (MEMCG)" 
        <linux-mm@kvack.org>
Subject: Re: [PATCH v5 0/4] Charge loop device i/o to issuing cgroup
Message-ID: <20200512132521.GA28700@dschatzberg-fedora-PC0Y6AEN.dhcp.thefacebook.com>
References: <20200428161355.6377-1-schatzberg.dan@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200428161355.6377-1-schatzberg.dan@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Seems like discussion on this patch series has died down. There's been
a concern raised that we could generalize infrastructure across loop,
md, etc. This may be possible, in the future, but it isn't clear to me
how this would look like. I'm inclined to fix the existing issue with
loop devices now (this is a problem we hit at FB) and address
consolidation with other cases if and when those are addressed.

Jens, you've expressed interest in seeing this series go through the
block tree so I'm interested in your perspective here. Barring any
concrete implementation bugs, would you be okay merging this version?
