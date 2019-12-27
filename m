Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A0EB12B440
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Dec 2019 12:37:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727126AbfL0LhC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 Dec 2019 06:37:02 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35213 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727028AbfL0LhB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 Dec 2019 06:37:01 -0500
Received: by mail-wm1-f68.google.com with SMTP id p17so8069092wmb.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Dec 2019 03:36:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vYLFB/uLWChvEa1SjgamsZ5n2OMiY1NO7RNKVGxv64I=;
        b=wA9y8xWm9ulX0jcjr/Q4fMa+CIjLe1WNOnrKOG6FQ86CpFV+mqxMkBOftKML0d6v/J
         rCxUMWOO2JA/WJCAQuwBzCkWnauR8fPiOuXQXFeuR40G4SNS0oPJPgZ1GxcPUloGPyoc
         rTAqTUplNF/TJVhhOC3Qn9Zo61xTe4hukSBt4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vYLFB/uLWChvEa1SjgamsZ5n2OMiY1NO7RNKVGxv64I=;
        b=KPtWuHLgpfW4m429ZFQi5T+pto6lErnvP7aZ/lKweZXwqR6Z8SStJgz+ZGus0VmGp5
         sWZvKssqV6c7xWiUyBsbgii76QQIT/YpCagoHK6LA/SR0gUoHhYS8UX2UFlxtY2wn0VZ
         kH2DSmwLma4dJvxId2Wrnu/Qf7Xnjue2Ok0yY5khxu05IDl6O+1gC/+Eo2WdOkqccfwH
         9S0OJNbhYlcDBBKgvqkMMLIHZKFSUh1jZf7dX6HXI4pcmvBCDHSnu0ftbdypFIbYzj2d
         5i9HRKHOXrih8FGUSc8qp8MpvZe3Eg47B8O7d0YoTh779CSwVQPsID3DjZilCOIbmItT
         IUuw==
X-Gm-Message-State: APjAAAXOFrvZJWxrkibbGW48M59yNBksvTzL/+ePORaph2TvqQXJL9uV
        chdi1pDyvv/qyW24xSiqni9o7Y+hLkQ=
X-Google-Smtp-Source: APXvYqxdWbM0VFPfavkOQ7Syvg3XtT7I6sj7u2hO46ItzR9trEv+MnBpW96YfNZeXSYp+QJnuqLO4A==
X-Received: by 2002:a1c:8095:: with SMTP id b143mr18803322wmd.7.1577446618889;
        Fri, 27 Dec 2019 03:36:58 -0800 (PST)
Received: from localhost (host-92-23-123-10.as13285.net. [92.23.123.10])
        by smtp.gmail.com with ESMTPSA id v83sm11119135wmg.16.2019.12.27.03.36.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Dec 2019 03:36:58 -0800 (PST)
Date:   Fri, 27 Dec 2019 11:36:56 +0000
From:   Chris Down <chris@chrisdown.name>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Jeff Layton <jlayton@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, kernel-team@fb.com,
        "zhengbin (A)" <zhengbin13@huawei.com>
Subject: Re: [PATCH] fs: inode: Recycle inodenum from volatile inode slabs
Message-ID: <20191227113656.GA442424@chrisdown.name>
References: <20191226154808.GA418948@chrisdown.name>
 <CAOQ4uxj8NVwrCTswut+icF2t1-7gtW_cmyuGO7WUWdNZLHOBYA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAOQ4uxj8NVwrCTswut+icF2t1-7gtW_cmyuGO7WUWdNZLHOBYA@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Amir Goldstein writes:
>> - bpffs
>> - configfs
>> - debugfs
>> - efivarfs
>> - hugetlbfs
>> - ramfs
>> - tmpfs
>>
>
>I'm confused about this list.
>I suggested to convert tmpfs and hugetlbfs because they use a private
>inode cache pool, therefore, you can know for sure that a recycled i_ino
>was allocated by get_next_ino().

Oh, right. I mistakenly thought alloc_inode was somehow sb-specific and missed 
that these don't have any super_operations->alloc_inode :-)

I'll reduce it just to those with this explicitly set.

>I'd go even further to say that introducing a generic helper for this sort
>of thing is asking for trouble. It is best to keep the recycle logic well within
>the bounds of the specific filesystem driver, which is the owner of the
>private inode cache and the responsible for allocating ino numbers in
>this pool.

Thanks, considering that alloc_inode isn't sb-dependent like I thought, that 
definitely sounds reasonable. I'll do that and send v3 then.

Thanks,

Chris 
