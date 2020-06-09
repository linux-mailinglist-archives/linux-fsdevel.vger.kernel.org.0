Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40E5F1F32A8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jun 2020 05:42:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbgFIDm0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Jun 2020 23:42:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726915AbgFIDmZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Jun 2020 23:42:25 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A932FC03E969;
        Mon,  8 Jun 2020 20:42:25 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id a127so9457104pfa.12;
        Mon, 08 Jun 2020 20:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Q4fG1A8p1olZ3q4GtpMLtFQ28rvEW4nZgX1+riXZg/c=;
        b=mCGeZ0rTTipdKwd5l0gUb0tQ+2m3kPqjwdDI8hHvYuW0w/kRq8YwG88ztOZp4KHOhI
         f0xaDijiD6EO6HW1cGtbQWPcfITtQ27GWlfZO6+xwO6ZMmCUmSbRt6E8FV1+kPxpxaF9
         tCjm3A24Y93QquT3oDpmnmS0XZCgAyxnsOilaXpFZTt7gYz7dE9VGDIkHMQhqFUKxYnQ
         4yQ9Mk3YRWKY0tR8H3zKYImfQq6ZOZHLCnOleK6hJQSl9nj6faq7KxAkceU4EO4uQMXb
         OmGrUYnnMzDt8EFpmDRwudu94s1PBdJ4WGxqfEvmRI+ZIyB+Hv9uhxD+t8AO8kWBnK22
         OYsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Q4fG1A8p1olZ3q4GtpMLtFQ28rvEW4nZgX1+riXZg/c=;
        b=py/G0H5Ko9PbUjDEss/grOCQIWs/xBBIRyMDuWvaVus8Y9wCel5f7wbfpWA1ExmfF+
         HtgRsc5TcTwqA6PICeYx0L54eR6p5E9Bx2b85eqh4i0vuoEmrBvT5/pB5V0GztZp/bE3
         ZbRZs+Ii1SqGUgMTVM3hQAA8Byys6tTA6vVnZmfdoaa8Sz8leFiAfQEtLnsn13P3clnH
         C9X7CCHA44d5DRMET4e+kSlP07muWrFpQWbRxKmEHcdYbGS/F3V8yDHOmsAwk3RFar4d
         v0g7hIJ7BaQTJfBBafJUHscHnCbZC9+PfT6iOKbwqHKCG/MmHLzo8WqZxDf5BlxLTu0X
         9XNA==
X-Gm-Message-State: AOAM5300IhCF3ljWy7up98Gdr5R3gaJvvI9aD6qxHqunlLXlCuPjCRQG
        x7BQXwZOTQyqJixt6CDR80k=
X-Google-Smtp-Source: ABdhPJxsYjb/lkYFcMBrxR96yYjEB3OAL2WIlULMxD+m5UZjVDmX2sUc8vhZ0XtBk+bQ7tJaqcRNZg==
X-Received: by 2002:aa7:9488:: with SMTP id z8mr24736520pfk.157.1591674144940;
        Mon, 08 Jun 2020 20:42:24 -0700 (PDT)
Received: from gmail.com ([2601:600:817f:a132:df3e:521d:99d5:710d])
        by smtp.gmail.com with ESMTPSA id s197sm8552880pfc.188.2020.06.08.20.42.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2020 20:42:24 -0700 (PDT)
Date:   Mon, 8 Jun 2020 20:42:21 -0700
From:   Andrei Vagin <avagin@gmail.com>
To:     Adrian Reber <areber@redhat.com>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Pavel Emelyanov <ovzxemul@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Nicolas Viennot <Nicolas.Viennot@twosigma.com>,
        =?utf-8?B?TWljaGHFgiBDxYJhcGnFhHNraQ==?= <mclapinski@google.com>,
        Kamil Yurtsever <kyurtsever@google.com>,
        Dirk Petersen <dipeit@gmail.com>,
        Christine Flood <chf@redhat.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Radostin Stoyanov <rstoyanov1@gmail.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        Serge Hallyn <serge@hallyn.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Sargun Dhillon <sargun@sargun.me>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, selinux@vger.kernel.org,
        Eric Paris <eparis@parisplace.org>,
        Jann Horn <jannh@google.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] capabilities: Introduce CAP_CHECKPOINT_RESTORE
Message-ID: <20200609034221.GA150921@gmail.com>
References: <20200603162328.854164-1-areber@redhat.com>
 <20200603162328.854164-2-areber@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20200603162328.854164-2-areber@redhat.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 03, 2020 at 06:23:26PM +0200, Adrian Reber wrote:
> This patch introduces CAP_CHECKPOINT_RESTORE, a new capability facilitating
> checkpoint/restore for non-root users.
> 
> Over the last years, The CRIU (Checkpoint/Restore In Userspace) team has been
> asked numerous times if it is possible to checkpoint/restore a process as
> non-root. The answer usually was: 'almost'.
> 
> The main blocker to restore a process as non-root was to control the PID of the
> restored process. This feature available via the clone3 system call, or via
> /proc/sys/kernel/ns_last_pid is unfortunately guarded by CAP_SYS_ADMIN.
> 
> In the past two years, requests for non-root checkpoint/restore have increased
> due to the following use cases:
> * Checkpoint/Restore in an HPC environment in combination with a resource
>   manager distributing jobs where users are always running as non-root.
>   There is a desire to provide a way to checkpoint and restore long running
>   jobs.
> * Container migration as non-root
> * We have been in contact with JVM developers who are integrating
>   CRIU into a Java VM to decrease the startup time. These checkpoint/restore
>   applications are not meant to be running with CAP_SYS_ADMIN.
> 
...
> 
> The introduced capability allows to:
> * Control PIDs when the current user is CAP_CHECKPOINT_RESTORE capable
>   for the corresponding PID namespace via ns_last_pid/clone3.
> * Open files in /proc/pid/map_files when the current user is
>   CAP_CHECKPOINT_RESTORE capable in the root namespace, useful for recovering
>   files that are unreachable via the file system such as deleted files, or memfd
>   files.

PTRACE_O_SUSPEND_SECCOMP is needed for C/R and it is protected by
CAP_SYS_ADMIN too.

Thanks,
Andrei
