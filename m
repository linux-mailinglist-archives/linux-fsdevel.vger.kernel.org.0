Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8C3E24C746
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Aug 2020 23:45:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727873AbgHTVpa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Aug 2020 17:45:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726435AbgHTVp3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Aug 2020 17:45:29 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3796C061385;
        Thu, 20 Aug 2020 14:45:28 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id 185so3727541ljj.7;
        Thu, 20 Aug 2020 14:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QZOnv7vWdfjv3SqHEA46nQHDVbKjndfvS9Fptn5c3EE=;
        b=lAHsE1M3z56gY4Q01f/VtsJo8BTVYHuvYw9FurVaiCEvDgjhF2RqBPY9jc6I2xX9hc
         6Y4AuxToEMZioijEfL6AzNbzf1iBjyD3n22+84o3gpj43ECPttL1qTIhSn/tTPfPoRD3
         L91qSWhcnPYSPXOR9ePmDpgj9Taq8gewoiYomUTozjZT4xHjc6YNBgawbN49kZcDhUOU
         Szd0+BD5jRxO8aooUyA6pvkK0ZOoLOBBS4kcwgAWQlYWffi25Mih85FNvAECRpd+fMkm
         BvCF1pVI7K7PuK+0aH8zH8FkL+T7XkSQgjMksGQe7nhnVnTZuGn2uoi+rEs33pN8WAX6
         wxsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QZOnv7vWdfjv3SqHEA46nQHDVbKjndfvS9Fptn5c3EE=;
        b=B9cBRwsT05QplP/5thb1K/wkqO2sqfTxkCOQr5aVaoVpG/9gue/dDQpvTb3v4RP/Rj
         ytXwFNOhp6Noj6EJwiUbpTT4zp1xUSWLr8KDt10KCi2RwS/oQ60keYqFS0TsUO0k3D+a
         aAgSOOGU2XeP1sqzAmbdCw6jwQwQvOOfXJ/FLx7Ge6DkfXF2PipQOfuUhh1aiu0/yN9K
         8Bz4WN+bon0HuiSPPJxecKd6JBjlYdo32wLZt0PyoJnfgQdU+9goaq81Uh4ooROf2Pd7
         U1k/lHP2L9uXJNWrEpFa6Re36VxBhApbZUB3VUrUIfEir+jZkqqPQn5RsN7aKw4aoUs2
         6szQ==
X-Gm-Message-State: AOAM533TOz7iMLofVrMVangapiiPo6ZZR+voXU8Z80NArsvROD3pzHtg
        Uw2WGfrYrYwDsidNeBgWEDY=
X-Google-Smtp-Source: ABdhPJzPoxlP4SPY+LCj/KkElp/gHlvve5jFOm8dtSPmsQQY+NzL90YrPzmVQtcFyAMf8IbB3+gtOw==
X-Received: by 2002:a2e:9003:: with SMTP id h3mr143345ljg.185.1597959926761;
        Thu, 20 Aug 2020 14:45:26 -0700 (PDT)
Received: from grain.localdomain ([5.18.103.226])
        by smtp.gmail.com with ESMTPSA id l24sm675558ljb.43.2020.08.20.14.45.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 14:45:25 -0700 (PDT)
Received: by grain.localdomain (Postfix, from userid 1000)
        id 03ECC1A0078; Fri, 21 Aug 2020 00:45:24 +0300 (MSK)
Date:   Fri, 21 Aug 2020 00:45:24 +0300
From:   Cyrill Gorcunov <gorcunov@gmail.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        criu@openvz.org, bpf@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jann@thejh.net>,
        Kees Cook <keescook@chromium.org>,
        Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
        Jeff Layton <jlayton@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Matthew Wilcox <willy@debian.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Matthew Wilcox <matthew@wil.cx>,
        Trond Myklebust <trond.myklebust@fys.uio.no>,
        Chris Wright <chrisw@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>
Subject: Re: [PATCH 04/17] kcmp: In kcmp_epoll_target use fget_task
Message-ID: <20200820214524.GS2074@grain>
References: <87ft8l6ic3.fsf@x220.int.ebiederm.org>
 <20200817220425.9389-4-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200817220425.9389-4-ebiederm@xmission.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 17, 2020 at 05:04:12PM -0500, Eric W. Biederman wrote:
> Use the helper fget_task and simplify the code.
> 
> As well as simplifying the code this removes one unnecessary increment of
> struct files_struct.  This unnecessary increment of files_struct.count can
> result in exec unnecessarily unsharing files_struct and breaking posix
> locks, and it can result in fget_light having to fallback to fget reducing
> performance.
> 
> Suggested-by: Oleg Nesterov <oleg@redhat.com>
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
Reviewed-by: Cyrill Gorcunov <gorcunov@gmail.com>

I really like this simplification!
