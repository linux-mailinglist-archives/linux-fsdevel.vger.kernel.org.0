Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29DC81D1AD2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 May 2020 18:16:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389520AbgEMQQZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 May 2020 12:16:25 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:42344 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730063AbgEMQQZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 May 2020 12:16:25 -0400
Received: by mail-pl1-f196.google.com with SMTP id k19so22176pll.9;
        Wed, 13 May 2020 09:16:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MR3hivTTbv7WsNknULGT8vpeXwpVVOP1nEJHvXl4q6Q=;
        b=CGXlki91Z2AbkgMsh7IlOWcTNbnmSz+EJS9v9wrqLzHQJ48nzZ6IMVeeZ30THNgvBo
         +uyhrOfa4h/rA73eunJA29vtgNtIBqZNAzp1fpIEDnBBWPwHTjhUUosvYpu5JS+ZOBRC
         AhYk0Y9uOt4qdQoSPMCChWPRKPPKUV0ip3lTEmPSXX8Yo3EQXlB4EsIu14MRTAsYmUuL
         +ujxDfoP4Y01jEdRwBMpJ9Q9ppkj10i4yywDMbfensA7oJUZ0zGsyQNh1oTy4BFCJBX1
         D2sT++pbbU5y65x0r+H5/VfaOC54oK61WsCr+nqnYNPms1vhoYKWkZi11qggGDJuYRNz
         euDA==
X-Gm-Message-State: AGi0PubaRUfos4UQAprK/z+HuztdMu3AjvgJS+JjrLwbVgUnGOWQ//FL
        RUJpK6OnkpIw9NnazSZR980=
X-Google-Smtp-Source: APiQypKPVhDd5eVJvoALh7b71wk5lXOmnq50MN3QI/KJHyjv/UYQSNnqyFg2fSxJ63d2CJSyRyXsXg==
X-Received: by 2002:a17:902:ba95:: with SMTP id k21mr24684399pls.160.1589386584264;
        Wed, 13 May 2020 09:16:24 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id b15sm21492pfd.139.2020.05.13.09.16.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2020 09:16:23 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 452DA4063E; Wed, 13 May 2020 16:16:22 +0000 (UTC)
Date:   Wed, 13 May 2020 16:16:22 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Josh Triplett <josh@joshtriplett.org>
Cc:     viro@zeniv.linux.org.uk, gregkh@linuxfoundation.org,
        rafael@kernel.org, jeyu@kernel.org, jmorris@namei.org,
        keescook@chromium.org, paul@paul-moore.com,
        stephen.smalley.work@gmail.com, eparis@parisplace.org,
        nayna@linux.ibm.com, zohar@linux.ibm.com,
        scott.branden@broadcom.com, dan.carpenter@oracle.com,
        skhan@linuxfoundation.org, geert@linux-m68k.org,
        tglx@linutronix.de, bauerman@linux.ibm.com, dhowells@redhat.com,
        linux-integrity@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        kexec@lists.infradead.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] security: add symbol namespace for reading file data
Message-ID: <20200513161622.GS11244@42.do-not-panic.com>
References: <20200513152108.25669-1-mcgrof@kernel.org>
 <20200513152108.25669-3-mcgrof@kernel.org>
 <87k11fonbk.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87k11fonbk.fsf@x220.int.ebiederm.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 13, 2020 at 10:40:31AM -0500, Eric W. Biederman wrote:
> Luis Chamberlain <mcgrof@kernel.org> writes:
> 
> > Certain symbols are not meant to be used by everybody, the security
> > helpers for reading files directly is one such case. Use a symbol
> > namespace for them.
> >
> > This will prevent abuse of use of these symbols in places they were
> > not inteded to be used, and provides an easy way to audit where these
> > types of operations happen as a whole.
> 
> Why not just remove the ability for the firmware loader to be a module?
> 
> Is there some important use case that requires the firmware loader
> to be a module?
> 
> We already compile the code in by default.  So it is probably just
> easier to remove the modular support all together.  Which would allow
> the export of the security hooks to be removed as well.

Yeah, that's a better solution. The only constaint I am aware of is
we *cannot* change the name of the module from firmware_class since the
old fallback sysfs loader depends on the module name. So, so long as we
take care with that on built-in and document this very well, I think
we should be good.

I checked the commit logs and this was tristate since the code was added
upstream, so I cannot see any good reason it was enabled as modular.

Speaking with a *backports experience* hat on, we did have a use case
to use a module for it in case a new feature was added upstream which
was not present on older kernels. However I think that using a separate
symbol prefix would help with that.

Would any Android stakeholders / small / embedded folks whave any issue
with this?

  Luis
