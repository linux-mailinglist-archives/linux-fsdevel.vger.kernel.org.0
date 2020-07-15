Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 971892216DF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jul 2020 23:17:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbgGOVRZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jul 2020 17:17:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbgGOVRY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jul 2020 17:17:24 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3AC2C061755;
        Wed, 15 Jul 2020 14:17:23 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id d17so4374873ljl.3;
        Wed, 15 Jul 2020 14:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=878NUfEQKU27cWVYy1Yci/5Wskx41g24sCWsqX1WcsA=;
        b=DuZUqii6RcTw7TzKOfF4FDRU2MJ8JjlSiD8uIicoHfWZsUgHOkbx/rFvJZZwD9+ny1
         OzWE/cYMjU+BlC+sTzUfPGQTteb4LXmLkcD0M0CYSVJVvCuD0TZqiwumHwojiUUysE9U
         5YvbI7paaaGcHHeuW3yosTcWRlevsI6RUJjN0mm2iYF9N0iyAP66fHLba7hN7jzINzLu
         JfRLio2ol7w381TUcfNUgeHKIbzI1sxeIpGec3sda8iw2yR7dQx/Y5lk5UQ2dsYI8eAW
         9ARCMdm4EdqTI1HskZJNJizj0On5zm2fS3uw6B+3mXxC0YG3lnE/uq4oASoJpUn8VmI1
         uJ8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=878NUfEQKU27cWVYy1Yci/5Wskx41g24sCWsqX1WcsA=;
        b=H0PxUmTuFrOBH/S2IjvYUPZQ7xXWSZZJYru7jed4D+cheoX3Hy/DVJTInRQJK53Jvr
         8LFv4uEMEG72NVejDkw6cXzveLWlRt+BOzgtCURXDzOHHuZOWJf153ohresG79ThQucf
         KqYnhIgt1Dc6115zDbI6gQfaSyG2DXcbG5tHV6A45YW/JrC9Nm59wkzeVS5VGVi4XnZI
         Gii6buhkWCydJI8WLl+2lMus/WzxOQ3bBK/AMKL1PWlKaurNS4G5ptiliB5Lq+Vy/SBO
         ODVSoKgH7dzmB7UqNCbh65+J3NukNG+ViSpY9W3bYaOB8hOPYfg5dkes6gxgGa8zZrhM
         t2aA==
X-Gm-Message-State: AOAM531qQbOZ8TKUKfYizaI5zX5vA2o1e4mzAzH52ROMiqMlO1DQpqtn
        kqkdeRIrbHA5pWzgxfu0Oss=
X-Google-Smtp-Source: ABdhPJxNpfXcCUBb99OzwTHWkORKH+eCf2BVhhnOSS/c/yHSPKt+56imxXvMtR1zIUUiYnkOQ6kvlQ==
X-Received: by 2002:a2e:b892:: with SMTP id r18mr480862ljp.319.1594847842018;
        Wed, 15 Jul 2020 14:17:22 -0700 (PDT)
Received: from grain.localdomain ([5.18.102.224])
        by smtp.gmail.com with ESMTPSA id d18sm724603lfb.26.2020.07.15.14.17.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 14:17:20 -0700 (PDT)
Received: by grain.localdomain (Postfix, from userid 1000)
        id 049E81A007A; Thu, 16 Jul 2020 00:17:19 +0300 (MSK)
Date:   Thu, 16 Jul 2020 00:17:19 +0300
From:   Cyrill Gorcunov <gorcunov@gmail.com>
To:     Adrian Reber <areber@redhat.com>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Pavel Emelyanov <ovzxemul@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrei Vagin <avagin@gmail.com>,
        Nicolas Viennot <Nicolas.Viennot@twosigma.com>,
        =?utf-8?B?TWljaGHFgiBDxYJhcGnFhHNraQ==?= <mclapinski@google.com>,
        Kamil Yurtsever <kyurtsever@google.com>,
        Dirk Petersen <dipeit@gmail.com>,
        Christine Flood <chf@redhat.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Radostin Stoyanov <rstoyanov1@gmail.com>,
        Serge Hallyn <serge@hallyn.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Sargun Dhillon <sargun@sargun.me>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, selinux@vger.kernel.org,
        Eric Paris <eparis@parisplace.org>,
        Jann Horn <jannh@google.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v5 4/6] proc: allow access in init userns for map_files
 with CAP_CHECKPOINT_RESTORE
Message-ID: <20200715211719.GH296695@grain>
References: <20200715144954.1387760-1-areber@redhat.com>
 <20200715144954.1387760-5-areber@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200715144954.1387760-5-areber@redhat.com>
User-Agent: Mutt/1.14.5 (2020-06-23)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 15, 2020 at 04:49:52PM +0200, Adrian Reber wrote:
> Opening files in /proc/pid/map_files when the current user is
> CAP_CHECKPOINT_RESTORE capable in the root namespace is useful for
> checkpointing and restoring to recover files that are unreachable via
> the file system such as deleted files, or memfd files.
> 
> Signed-off-by: Adrian Reber <areber@redhat.com>
> Signed-off-by: Nicolas Viennot <Nicolas.Viennot@twosigma.com>

I still have a plan to make this code been usable without
capabilities requirements but due to lack of spare time
for deep investigation this won't happen anytime soon.
Thus the patch looks OK to me, fwiw

Reviewed-by: Cyrill Gorcunov <gorcunov@gmail.com>
