Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2ADA2217958
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jul 2020 22:27:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728550AbgGGU1n (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jul 2020 16:27:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727908AbgGGU1n (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jul 2020 16:27:43 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1203AC061755;
        Tue,  7 Jul 2020 13:27:43 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id f5so35681547ljj.10;
        Tue, 07 Jul 2020 13:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ajo6nks6IKTytoxbn3OTUiBmVEajkhzk4OYSPYzD8G4=;
        b=nigYhsaCsH+6/MQPusrEuF130iuP2myvwjNmaGkAn7WMAi4mbofaGVTVCrgRO8y/DV
         n/hjaQYF6vJZGfP0pF8TASETS5NGgug63OhYHee2C9hxwllCv833Q9FsOkTBxSPcQDtv
         Bn3xVFYGHI7xMfewZ1n04VKnB1/Kqh1QvRC5jN8XXpYkIl0rpJN/iJ+UCVrtmDiSEnON
         NoRssyHd+0czjJYiY06z4Uhi8iwhoReaC5FGEeeyGtr87qaHvGrxLL6mk0UHQ4CsKhMC
         MXcou7PZSPvmZ/YNCSOmOiEcqc7pV2C14J9HxFVZjQ1FXqUUsIeJJmoAJeoJRAiGrTvt
         /o5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ajo6nks6IKTytoxbn3OTUiBmVEajkhzk4OYSPYzD8G4=;
        b=hOZP1gtWiS9iC3M/tmsyTizDTUVI+s3N3XG5UIYdfNN+LmQ2jqFJFbTxdjdIcOLMcw
         Jo2kkjCoKykd47+nkGbxwXvxypSC1guCzmwxrioJNfe6AVrE5DoximygBGyZONL58Omu
         zNoEQvQXl4EP0L+7RMkcKnP6EYXBMsL0GVlJSUwmKQjZgBAQ0qfbaDqtB/jmiPp8WOyN
         M3o1tW+uAjwRy4Yy1pQALGtMe5vdD9ZlIY9emrbHw+vE77by3DtXTG9iMHbQ+Wm0wnQa
         vV6cW1Ju4kz5VOCFumNzSCZguMGJ8jfcK8y5BGxCLP6yif0QhHbrohtdf7vmigLwsdoM
         XEyQ==
X-Gm-Message-State: AOAM533ePMlc/EktYwYq+9uSWU1Pug5XkNeXGqAjMbVCzK5yCdlB7WKn
        8vrpvLvErJf/BiqY+A28+kY=
X-Google-Smtp-Source: ABdhPJxmtn0X8Oh6d5HKD4O6MlHHfmZzj5T0uXLqzd8LW5AYSwYLEqFlh54/LW8Ch5FVhBOaq6PiLA==
X-Received: by 2002:a2e:9417:: with SMTP id i23mr31866307ljh.237.1594153661452;
        Tue, 07 Jul 2020 13:27:41 -0700 (PDT)
Received: from grain.localdomain ([5.18.102.224])
        by smtp.gmail.com with ESMTPSA id m25sm376950ljj.128.2020.07.07.13.27.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 13:27:40 -0700 (PDT)
Received: by grain.localdomain (Postfix, from userid 1000)
        id 6E7651A007B; Tue,  7 Jul 2020 23:27:39 +0300 (MSK)
Date:   Tue, 7 Jul 2020 23:27:39 +0300
From:   Cyrill Gorcunov <gorcunov@gmail.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Nicolas Viennot <Nicolas.Viennot@twosigma.com>,
        Jann Horn <jannh@google.com>, Paul Moore <paul@paul-moore.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Adrian Reber <areber@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Pavel Emelyanov <ovzxemul@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrei Vagin <avagin@gmail.com>,
        =?utf-8?B?TWljaGHFgiBDxYJhcGnFhHNraQ==?= <mclapinski@google.com>,
        Kamil Yurtsever <kyurtsever@google.com>,
        Dirk Petersen <dipeit@gmail.com>,
        Christine Flood <chf@redhat.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Radostin Stoyanov <rstoyanov1@gmail.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Sargun Dhillon <sargun@sargun.me>,
        Arnd Bergmann <arnd@arndb.de>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "selinux@vger.kernel.org" <selinux@vger.kernel.org>,
        Eric Paris <eparis@parisplace.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v4 3/3] prctl: Allow ptrace capable processes to change
 /proc/self/exe
Message-ID: <20200707202739.GB1999@grain>
References: <20200701064906.323185-1-areber@redhat.com>
 <20200701064906.323185-4-areber@redhat.com>
 <20200702211647.GB3283@mail.hallyn.com>
 <CAHC9VhQZ=cwiOay6OMMdM1UHm69wDaga9HBkyTbx8-1OU=aBvA@mail.gmail.com>
 <a2b4deacfc7541e3adea2f36a6f44262@EXMBDFT11.ad.twosigma.com>
 <20200706174437.zpshxlul7rl3vmmq@wittgenstein>
 <20200707154504.aknxmw6qavpjkr24@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200707154504.aknxmw6qavpjkr24@wittgenstein>
User-Agent: Mutt/1.14.5 (2020-06-23)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 07, 2020 at 05:45:04PM +0200, Christian Brauner wrote:
...
> 
> Ok, so the original patch proposal was presented in [4] in 2014. The
> final version of that patch added the PR_SET_MM_MAP we know today. The
> initial version presented in [4] did not require _any_ privilege.
> 

True. I still think that relyng on /proc/<pid>/exe being immutable (or
guarded by caps) in a sake of security is a bit misleading, this link
only a hint without any guarantees of what code is being executed once
we pass cs:rip to userspace right after exec is completed. Nowadays I rather
think we might need to call audit_log() here or something similar to point
that exe link is changed (by criu or someone else) and simply notify
node's administrator, that's all. But as you pointed tomoyo may be
affected if we simply drops all caps from here. Thus I agree that
the new cap won't make situation worse.

Still I'm not in touch with kernel code for a couple of years already
and might be missing something obvious here.
