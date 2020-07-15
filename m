Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 549C922101A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jul 2020 17:00:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbgGOPAU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jul 2020 11:00:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725980AbgGOPAT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jul 2020 11:00:19 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AC48C08C5DB
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Jul 2020 08:00:19 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id e8so3203314pgc.5
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Jul 2020 08:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fR6dbzH+dt2SEyGVkXPzqeJIOxjozyDdDFXnWvcFfX8=;
        b=dZ1/RMvVMw39VXexb8tF5pKBAs9eG1auhY0F1a3hrpry2k+MwNS+NfYPBJn4l/OyOl
         MMGxILx7NUe1DtKUCsjo6iqwgNfj8rPmMOE9ImNGsHhvhZ6li/EFGieZMFIn5OpEDXV7
         ut4LgorSf+/UYrIkxLpqE1DSUXjPhJWohxSA0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fR6dbzH+dt2SEyGVkXPzqeJIOxjozyDdDFXnWvcFfX8=;
        b=r8JE3cCJpdYKmtw+Y0am/mI+yGVXZzlM+6ZYXYbW2QdL/lbhvWwV3TIPkQcEv6eTqd
         XLE59fiZGuxHpc5pVRSpXHBrd7FGX2Y9zDhZN7n6882XdaZ4jKxzKfx+Av6jru7GBI/c
         9UnRJcmXeJRD4Ok13PLmTvvbl2qXRx5oMN57JHtV3RREbqg6hJZCkHYFM8ekNh/L5mO1
         DahpcrE0I83RehOFye6JKY5QuG7TLmHDWl6R7LTMTZuiRw8eXcm7bUuCeCT4J57ZeQbD
         UkcxsucCynfEDqwF1jq53qIfcMqt26idRKdiGYt3vzA+zZUS5b0Z0TrAFvjoEV/DAQPo
         8qhQ==
X-Gm-Message-State: AOAM530LPUIPnp7/fcsWCzS/JsQdT7x2wvJpOfc0mH2OLUoVf6I4x4dI
        P+EtDhmguJAS0uyVyemnONr8cw==
X-Google-Smtp-Source: ABdhPJypnXERMxHttwqG67BS2VGWnOLjufZ/tc6bZRGQt5L3sS8EuZ6AokDXU5Pm9inEKXvID0wnEA==
X-Received: by 2002:aa7:9736:: with SMTP id k22mr8906785pfg.62.1594825218717;
        Wed, 15 Jul 2020 08:00:18 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id t1sm2543656pje.55.2020.07.15.08.00.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 08:00:17 -0700 (PDT)
Date:   Wed, 15 Jul 2020 08:00:16 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-fsdevel@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        linux-security-module@vger.kernel.org,
        "Serge E. Hallyn" <serge@hallyn.com>,
        James Morris <jmorris@namei.org>,
        Kentaro Takeda <takedakn@nttdata.co.jp>,
        Casey Schaufler <casey@schaufler-ca.com>,
        John Johansen <john.johansen@canonical.com>
Subject: Re: [PATCH 7/7] exec: Implement kernel_execve
Message-ID: <202007150758.3D1597C6D@keescook>
References: <871rle8bw2.fsf@x220.int.ebiederm.org>
 <87wo365ikj.fsf@x220.int.ebiederm.org>
 <202007141446.A72A4437C@keescook>
 <20200715064248.GH32470@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200715064248.GH32470@infradead.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 15, 2020 at 07:42:48AM +0100, Christoph Hellwig wrote:
> On Tue, Jul 14, 2020 at 02:49:23PM -0700, Kees Cook wrote:
> > On Tue, Jul 14, 2020 at 08:31:40AM -0500, Eric W. Biederman wrote:
> > > +static int count_strings_kernel(const char *const *argv)
> > > +{
> > > +	int i;
> > > +
> > > +	if (!argv)
> > > +		return 0;
> > > +
> > > +	for (i = 0; argv[i]; ++i) {
> > > +		if (i >= MAX_ARG_STRINGS)
> > > +			return -E2BIG;
> > > +		if (fatal_signal_pending(current))
> > > +			return -ERESTARTNOHAND;
> > > +		cond_resched();
> > > +	}
> > > +	return i;
> > > +}
> > 
> > I notice count() is only ever called with MAX_ARG_STRINGS. Perhaps
> > refactor that too? (And maybe rename it to count_strings_user()?)
> 
> Liks this?
> 
> http://git.infradead.org/users/hch/misc.git/commitdiff/35a3129dab5b712b018c30681d15de42d9509731

Heh, yes please. :) (Which branch is this from? Are yours and Eric's
tree going to collide?)

-- 
Kees Cook
