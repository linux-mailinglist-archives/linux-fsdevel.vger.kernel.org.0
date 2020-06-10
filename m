Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01ECF1F4FD4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jun 2020 09:59:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbgFJH7d (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Jun 2020 03:59:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbgFJH7c (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Jun 2020 03:59:32 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCD06C03E96B;
        Wed, 10 Jun 2020 00:59:32 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id e18so630868pgn.7;
        Wed, 10 Jun 2020 00:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ML9kdv8KWfqd+/DjpnHagHD/lBBhwolauh+PduEJYKE=;
        b=M7NL44k/SIQ/oZqs1+OEQEsGweIwDPcq4JJ2FJOqeXIWrSzyOk/dYcJqEmw1TuNDXV
         yfz4kiFeHX5hs+8bJQNPj225LR3utD6BGJApBERwJxYcIJeGnqf68Duiik2+dvAdSHrh
         r+8990E9lvwOJrDoW5XBMTY3xV0Q7rWDHbqjoRvl8Tz12OjBlw+sjxZmWog9GY+rv878
         YPRa8n9F/U7CcQ6ngGJG5tQ0TWkwdk/xQfsoYQX+B8mhpS7mx+Sr3t+ED1O869xa1b38
         7u7eVoGIg34pj499KV99uxxtPrv8XPLvGqhYfu3LfdGmFakhCaJ8BAKXW/RsNM+VX4IH
         2yTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ML9kdv8KWfqd+/DjpnHagHD/lBBhwolauh+PduEJYKE=;
        b=TNv+ksJuKPdmiNV4vtuHYpV1H7JcPXJSaMdgL5e56L8zKPl0ZeZDmhw72cFqcCLVeT
         4KH9b0l6IPPlB2G5PI9HYOifzuLh1HrWtGLpxIhxUzepkHJ+iwF1YEF0rx9eC6VQFG57
         jedCJFXDxcjDAecUAai6wJoe2+0J1hx93XH7K/9Kr45oESJ5hINQ66HhWw8wlmxA6Ox6
         zCce/QfoAaDJSGVOhdwuaVRfvsLjFHSZLmj+Am6hanKpKUC2LUVYZVpJKCfcAQJdXOkf
         K5l4yur6A3e1/Wqoi8V033kei4i9ky0jrjU7opxms3xHggwLwzzOvBLtwtXPCy4K9DfM
         Qa8w==
X-Gm-Message-State: AOAM530ncSUUHu9+lgj+ROBn49t6FUFU2ytB1Pg5MgpnAlscnFEjlgMr
        uyR7WGHlu2BwG4WLowEJ/2U=
X-Google-Smtp-Source: ABdhPJyC0mPKfbMVkEXw8hn57l4wa7CCnJylhtEQhbYA+gKaae0hYsYdBYscCSrzl9pclZeuQbkLmg==
X-Received: by 2002:a65:66d5:: with SMTP id c21mr1579258pgw.155.1591775971718;
        Wed, 10 Jun 2020 00:59:31 -0700 (PDT)
Received: from gmail.com ([2601:600:817f:a132:df3e:521d:99d5:710d])
        by smtp.gmail.com with ESMTPSA id w24sm11877692pfn.11.2020.06.10.00.59.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2020 00:59:30 -0700 (PDT)
Date:   Wed, 10 Jun 2020 00:59:28 -0700
From:   Andrei Vagin <avagin@gmail.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Adrian Reber <areber@redhat.com>,
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
Message-ID: <20200610075928.GA172301@gmail.com>
References: <20200603162328.854164-1-areber@redhat.com>
 <20200603162328.854164-2-areber@redhat.com>
 <20200609034221.GA150921@gmail.com>
 <20200609074422.burwzfgwgqqysrzh@wittgenstein>
 <20200609160627.GA163855@gmail.com>
 <20200609161427.4eoozs3kkgablmaa@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20200609161427.4eoozs3kkgablmaa@wittgenstein>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 09, 2020 at 06:14:27PM +0200, Christian Brauner wrote:
> On Tue, Jun 09, 2020 at 09:06:27AM -0700, Andrei Vagin wrote:
> > On Tue, Jun 09, 2020 at 09:44:22AM +0200, Christian Brauner wrote:
> > > On Mon, Jun 08, 2020 at 08:42:21PM -0700, Andrei Vagin wrote:
...
> > > > PTRACE_O_SUSPEND_SECCOMP is needed for C/R and it is protected by
> > > > CAP_SYS_ADMIN too.
> > > 
> > > This is currently capable(CAP_SYS_ADMIN) (init_ns capable) why is it
> > > safe to allow unprivileged users to suspend security policies? That
> > > sounds like a bad idea.
> > 
...
> > I don't suggest to remove or
> > downgrade this capability check. The patch allows all c/r related
> > operations if the current has CAP_CHECKPOINT_RESTORE.
> > 
> > So in this case the check:
> >      if (!capable(CAP_SYS_ADMIN))
> >              return -EPERM;
> > 
> > will be converted in:
> >      if (!capable(CAP_SYS_ADMIN) && !capable(CAP_CHECKPOINT_RESTORE))
> >              return -EPERM;
> 
> Yeah, I got that but what's the goal here? Isn't it that you want to
> make it safe to install the criu binary with the CAP_CHECKPOINT_RESTORE
> fscap set so that unprivileged users can restore their own processes
> without creating a new user namespace or am I missing something? The
> use-cases in the cover-letter make it sound like that's what this is
> leading up to:
> > > > > * Checkpoint/Restore in an HPC environment in combination with a resource
> > > > >   manager distributing jobs where users are always running as non-root.
> > > > >   There is a desire to provide a way to checkpoint and restore long running
> > > > >   jobs.
> > > > > * Container migration as non-root
> > > > > * We have been in contact with JVM developers who are integrating
> > > > >   CRIU into a Java VM to decrease the startup time. These checkpoint/restore
> > > > >   applications are not meant to be running with CAP_SYS_ADMIN.
> 
> But maybe I'm just misunderstanding crucial bits (likely (TM)).

I think you understand this right. The goal is to make it possible to
use C/R functionality for unprivileged processes. And for me, here are
two separate tasks. The first one is how to allow unprivileged users to
use C/R from the root user namespace. This is what we discuss here.

And another one is how to allow to use C/R functionality from a non-root
user namespaces. The second task is about downgrading capable to
ns_capable for map_files and PTRACE_O_SUSPEND_SECCOMP.

Thanks,
Andrei
