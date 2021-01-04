Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 492722E96FF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Jan 2021 15:18:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727117AbhADOR2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Jan 2021 09:17:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726396AbhADOR1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Jan 2021 09:17:27 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EC5FC061574;
        Mon,  4 Jan 2021 06:16:47 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id m25so64568952lfc.11;
        Mon, 04 Jan 2021 06:16:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i5CNFkVFgsA9BzNgX/I+jI3gR5jn/LsiIfWVngBWCIo=;
        b=lrB/U4f+X00uogk3MEbesYfb4TzdSeycj7JvT0MRsMg5ipEeIJPTYY0FHeLrcjCKmK
         NEQnEIhA4BnBFtjxZ2FBPaz2Jn7zj1CVD7xmcTjU9L3Y9W8CBrMhPi1Rnp9bzoKbcBQI
         5Ax5RINcChzD9QF0oJzx147Evo+dV2/qx3W36Sz08uqf4aI9DkCKRSxQZtDY86NZRBUM
         2xha5Cxl5mpL3Y8YgkA2GSnQ83nE8tgtGgoyx9W+n/5yYqIBa85ZTrv4wu/VjAo3DdVh
         omkJOCzU4iy814/Ltl6aqvFXaRhWk6l8rLdf+XU9ohcrhL5B7zCS+gyI2BtbeLZCZWIa
         k1tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i5CNFkVFgsA9BzNgX/I+jI3gR5jn/LsiIfWVngBWCIo=;
        b=I8vZdre3ZFo/zcv1djmODHPXx8Ttmqs+HiS0Yc2ppvimg1pri5HYhmmGQJ4eXDHxjn
         yEH3P2eBN8O+UynZRB37mVb2z0FGxSZuCgwtRcV8+ig7250l0YLfG035V8HoH31jdGcE
         NVLEF92ur4uHp7plsoeL9q0DsoG68mFK6hPRVwzTRc0Z4WrD5LyeBTHTfqwGQRMQJSAc
         d8SWkpOPnaG4+PaoIi3hFjy6xAr3eFA1mUqW30/2BPhBDTEF6aScW85I37+PwC80oOpy
         ci5fZRbQgx7BFZUirE+RKgai0Kz6g/eyEVH8qsUnmJ5Uy0SIsSz2dFoPaYWwFLVJ9sgj
         o3bA==
X-Gm-Message-State: AOAM533QbbYZke7zpHPW6IuKnYeDodDEOLWp/OmoXu3Ojb0h3hQEUszD
        5y23H+Nn78uteBKUeWPyuCyVdVPlwSEbHnQ6Smg=
X-Google-Smtp-Source: ABdhPJzV+OL02hsKvA1TOJWU4Gy1IzHRylhUKjGeqk11Tj716Nv+esf0Z5CuhVen+kgAlLcnhWSejv/zrCoo+UlkDWw=
X-Received: by 2002:a05:651c:200a:: with SMTP id s10mr34175031ljo.492.1609769805661;
 Mon, 04 Jan 2021 06:16:45 -0800 (PST)
MIME-Version: 1.0
References: <20201219000616.197585-1-stephen.s.brennan@oracle.com> <20201219000616.197585-2-stephen.s.brennan@oracle.com>
In-Reply-To: <20201219000616.197585-2-stephen.s.brennan@oracle.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Mon, 4 Jan 2021 09:16:34 -0500
Message-ID: <CAEjxPJ4bUxSp3hMV9k5Z5Zpev=ravd6EJheC1Rdg+_72eUiNLA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] proc: ensure security hook is called after exec
To:     Stephen Brennan <stephen.s.brennan@oracle.com>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@parisplace.org>,
        SElinux list <selinux@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Dec 18, 2020 at 7:06 PM Stephen Brennan
<stephen.s.brennan@oracle.com> wrote:
>
> Smack needs its security_task_to_inode() hook to be called when a task
> execs a new executable. Store the self_exec_id of the task and call the
> hook via pid_update_inode() whenever the exec_id changes.
>
> Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>

Sorry to be late in responding, but the proc inode security structure
needs to be updated not only upon a context-changing exec but also
upon a setcon(3) aka write to /proc/self/attr/current just like the
uid/gid needs to be updated not only upon a setuid exec but also upon
a setuid(2).  I'm also unclear as to why you can't call
security_task_to_inode during RCU lookup; it doesn't block/sleep
AFAICT.
All it does is take a spinlock and update a few fields.
