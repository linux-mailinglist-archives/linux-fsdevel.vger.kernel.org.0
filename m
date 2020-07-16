Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D34422270F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jul 2020 17:32:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728939AbgGPPbn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Jul 2020 11:31:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728791AbgGPPbh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Jul 2020 11:31:37 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC87AC08C5DD
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Jul 2020 08:31:34 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id q17so4012553pls.9
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Jul 2020 08:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=jGC0Cma9sD+M6C66CXjEVdr4Gdb8mMF8OboSIxxwdH4=;
        b=ZCAVB8nsh1reVbsCtXsNpc9/GpvQQzf253bRke2fSht/9fsA2S0zNy7s7Q7zaYprZf
         XIp3CYeZYUJRxqJWxlw4GYR6Rxfcw9Cy7l7xTQwKslcSPJZlLm/qGcYymwn8C7VPsU+k
         dDBF3EEYw3UhdPnQHkORD5qj1r8KpyjprM3rc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=jGC0Cma9sD+M6C66CXjEVdr4Gdb8mMF8OboSIxxwdH4=;
        b=W1LbOtUvG8oZM78Rs6tNyfVwpRWZUIJHU+DE0x65MbDSpwBUpjhIHs/arXiVnKUSUf
         DLLSWuvST+KPUP+Y6AijL2DUmYNvoXWQC3xU/Tj/f3tD/vnFdOdi7WwJBMYGuWa7hois
         RfnUKGZukCaDjzsHVqhfjYDpFXTdWcGh9QNzUoRF1ip2aLTrAKObYB6NAeApeLWWGiCR
         O8ueZcKNua0E+RXW4B5aAFOTy0cy1+dGsDGm36rXo9cfEeeuYjhOQfrgBJkA41ruQcx1
         Wu7dzjTaBcUrcldCB3wiojtFGUOYSGAsUZr6CbRHtXk4lNHnGYanINusfWUM5hcg8VqD
         uo+g==
X-Gm-Message-State: AOAM533ak3amOphLBiycE7s5TE3/9vVCvf0KtEMZOoYw5CT1M96K3VfA
        //UQAYJSvT2pa7lPT5hHwY6aUw==
X-Google-Smtp-Source: ABdhPJweDZrRnoUX7jCQB/uM+EQPmvMQFRn5PcnR6HDszEBspoWj0c+Kso5Fx/ceySNNzLeNRQX5LA==
X-Received: by 2002:a17:90b:390e:: with SMTP id ob14mr4976168pjb.221.1594913494019;
        Thu, 16 Jul 2020 08:31:34 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id e195sm5218464pfh.218.2020.07.16.08.31.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 08:31:33 -0700 (PDT)
Date:   Thu, 16 Jul 2020 08:31:32 -0700
From:   Kees Cook <keescook@chromium.org>
To:     =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc:     Jan Kara <jack@suse.cz>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Aleksa Sarai <cyphar@cyphar.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christian Heimes <christian@python.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Deven Bowers <deven.desai@linux.microsoft.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Eric Chiang <ericchiang@google.com>,
        Florian Weimer <fweimer@redhat.com>,
        James Morris <jmorris@namei.org>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Matthew Garrett <mjg59@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mickael.salaun@ssi.gouv.fr>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Philippe =?iso-8859-1?Q?Tr=E9buchet?= 
        <philippe.trebuchet@ssi.gouv.fr>,
        Scott Shell <scottsh@microsoft.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Steve Dower <steve.dower@python.org>,
        Steve Grubb <sgrubb@redhat.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>,
        Vincent Strubel <vincent.strubel@ssi.gouv.fr>,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v6 4/7] fs: Introduce O_MAYEXEC flag for openat2(2)
Message-ID: <202007160822.CCDB5478@keescook>
References: <20200714181638.45751-1-mic@digikod.net>
 <20200714181638.45751-5-mic@digikod.net>
 <202007151304.9F48071@keescook>
 <b209ea10-5b7f-c40e-5b6a-3da9028403d5@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b209ea10-5b7f-c40e-5b6a-3da9028403d5@digikod.net>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 16, 2020 at 04:18:27PM +0200, Mickaël Salaün wrote:
> On 15/07/2020 22:06, Kees Cook wrote:
> > On Tue, Jul 14, 2020 at 08:16:35PM +0200, Mickaël Salaün wrote:
> >> The implementation of O_MAYEXEC almost duplicates what execve(2) and
> >> uselib(2) are already doing: setting MAY_OPENEXEC in acc_mode (which can
> >> then be checked as MAY_EXEC, if enforced), and propagating FMODE_EXEC to
> >> _fmode via __FMODE_EXEC flag (which can then trigger a
> >> fanotify/FAN_OPEN_EXEC event).
> >> [...]
> > 
> > Adding __FMODE_EXEC here will immediately change the behaviors of NFS
> > and fsnotify. If that's going to happen, I think it needs to be under
> > the control of the later patches doing the behavioral controls.
> > (specifically, NFS looks like it completely changes its access control
> > test when this is set and ignores the read/write checks entirely, which
> > is not what's wanted).
> 
> __FMODE_EXEC was suggested by Jan Kara and Matthew Bobrowski because of
> fsnotify. However, the NFS handling of SUID binaries [1] indeed leads to
> an unintended behavior. This also means that uselib(2) shouldn't work
> properly with NFS. I can remove the __FMODE_EXEC flag for now.

I kind of wonder if we need to more completely fix __FMODE_EXEC?

> [1] https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?id=f8d9a897d4384b77f13781ea813156568f68b83e

Hmpf, this implies that "fmode" should contain MAY_EXEC? It really looks
like __FMODE_EXEC is a hack for places where only "flags" were passed
around, and this only seems to be an issue for NFS at this point? And it
should be fixable for fsnotify too?

Hmm. (And nothing should use uselib anyway...)

-- 
Kees Cook
