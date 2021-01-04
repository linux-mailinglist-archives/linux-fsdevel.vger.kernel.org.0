Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3FD02E9723
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Jan 2021 15:23:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727334AbhADOXP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Jan 2021 09:23:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727136AbhADOXP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Jan 2021 09:23:15 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95745C061793;
        Mon,  4 Jan 2021 06:22:34 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id o13so64720527lfr.3;
        Mon, 04 Jan 2021 06:22:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kXTFfeMRZQQpjX/bUjX/VUuqwPxBKyg8TYI+r24zwMc=;
        b=bL9IjbB8aRoM2Bbdkox5AoGHJ7LmMDhG5X87RhacQffOkK4RDKh9GzBDzsLftnPqjg
         sjV80SnDAn9HsjTEPA9YkwRPxUyVdnQBmUdeKBb/07ve4M5yhoiJkpnkolbCB1bB7yLF
         4fIkPhcyWaaJmR3N99kkDhOhqel2j0sPbAgo9zH5cf3zqTnSF3E6HkO8dYrEZDfVrgtX
         gDhvY0tDgHRPyUCGvBLSvEtKVY+nsdJCQTjGbY4qSfCx/Db8rW+TaQoVlZPjyrkfzeSc
         n7HoTrR9GUEHLA+Ged8gOt/vkI8SWGZXUvdoC4ZYDH0yQ+Vph9fZX5iKRbus6nq3x+7I
         EIxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kXTFfeMRZQQpjX/bUjX/VUuqwPxBKyg8TYI+r24zwMc=;
        b=PCljmN9+XRc/74lw5nDuZN9IyJItbYtakmH3+ACqyXdxWOPSk3XxWybE+iUmy+Vhyp
         vKSN7m8KmA/GAbZaS8HpZdA4HM09qjBv6P/8ihpU26oltpHJLyRqiX5UYtzgJGSmB6y8
         +PyL6XyfFWMNfpUXSJi7hdoB+QBmvqNyxx3/+9uTHRVeagjpVljdcF8dYDje4tLC4Arf
         TxWln3AGKP9yCQ9SZtXh36M5KL3FAkPJBHDfFJ02MLRtsAX7txbGBpBR4XTNLHY0lr8x
         lZ9WURDAx2nO/RtS4pY2VA8h2pyPVaG2DKCoT55dmf4dvXeDNTZLkRZ3WgEuBLW2Gzm1
         DxBw==
X-Gm-Message-State: AOAM531vh05Sv1/5stTvVsV5vl8mGRzAQEeDqh5jMCRYPOCVtZ3wV1Kj
        UmFzHnoazsGveylUV45Iwx79dtgaPYd9X4euxZ8=
X-Google-Smtp-Source: ABdhPJytbIseJCFq7LhrJXQnsC4iBKXOUNOS6w9t+SOinAywUYi8J+1uiDqH+aTMStFRoDVoeD38KQIiVG21U4iPnlg=
X-Received: by 2002:a19:c786:: with SMTP id x128mr35713651lff.323.1609770153039;
 Mon, 04 Jan 2021 06:22:33 -0800 (PST)
MIME-Version: 1.0
References: <20201219000616.197585-1-stephen.s.brennan@oracle.com>
 <20201219000616.197585-2-stephen.s.brennan@oracle.com> <CAEjxPJ4bUxSp3hMV9k5Z5Zpev=ravd6EJheC1Rdg+_72eUiNLA@mail.gmail.com>
In-Reply-To: <CAEjxPJ4bUxSp3hMV9k5Z5Zpev=ravd6EJheC1Rdg+_72eUiNLA@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Mon, 4 Jan 2021 09:22:22 -0500
Message-ID: <CAEjxPJ6HBGaPVbWFBTYgDDpDX6duvpJvCinSJP863kM69=qWqg@mail.gmail.com>
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

On Mon, Jan 4, 2021 at 9:16 AM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Fri, Dec 18, 2020 at 7:06 PM Stephen Brennan
> <stephen.s.brennan@oracle.com> wrote:
> >
> > Smack needs its security_task_to_inode() hook to be called when a task
> > execs a new executable. Store the self_exec_id of the task and call the
> > hook via pid_update_inode() whenever the exec_id changes.
> >
> > Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
>
> Sorry to be late in responding, but the proc inode security structure
> needs to be updated not only upon a context-changing exec but also
> upon a setcon(3) aka write to /proc/self/attr/current just like the
> uid/gid needs to be updated not only upon a setuid exec but also upon
> a setuid(2).  I'm also unclear as to why you can't call
> security_task_to_inode during RCU lookup; it doesn't block/sleep
> AFAICT.
> All it does is take a spinlock and update a few fields.

You could also optimize this by comparing the sid similar to how the
uid/gid are compared and only updating it within the hook if it has
not yet been initialized or has changed since it was originally set.
