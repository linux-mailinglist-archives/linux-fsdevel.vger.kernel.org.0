Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96B64217AC8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jul 2020 23:55:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729218AbgGGVzi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jul 2020 17:55:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729179AbgGGVzh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jul 2020 17:55:37 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67D53C08C5E1
        for <linux-fsdevel@vger.kernel.org>; Tue,  7 Jul 2020 14:55:37 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id d4so20628748pgk.4
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Jul 2020 14:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PWRFmGx46oXClpA56PfylS5PdHmYWBhMzFkTVevOmLg=;
        b=jy3DeQsaYA+CHIzTF6NLOTOtZmNtV8HrLGBcmDlZ3Q8JLdPM6n+cv3dGCybmrkF+O3
         cE3mbaS8VH89ojXYY8yqpqzXUvM43P7bKTb+fKJhf1zlfkljbi/jmgDAyvzY7jv5LgWt
         YODuttLOikCmMTBjDi2AmI9FdhZxzYzb3L40Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PWRFmGx46oXClpA56PfylS5PdHmYWBhMzFkTVevOmLg=;
        b=oZz64H+d3m+JRgdU5F3dqsGMc44eTgzkZGfyKJSxjRC8ciBG5Camn+F7DBtvmR1Pdo
         rhnxfVpIhclHxfSfF0YI/PTGKYoCE8s23MDzVPgos8uee5YcoZ2YXV3FQcGABNA3cSko
         VDE5RfqKK0T6p2ye7h/NTV8rbscPCrMpnCcqvlJhpkSE0+Yt1D+L/eER1I+N48qFVEIA
         /TwuuJTcCZwnPsD7umTAmDzj5TqvgSfI84cvodgBoadgLou7u/xeussT5VB6o/6dw5pC
         EkVbXdMKrc0Kb/8mCfsGGYxjm46aJhWN1MFK452AdMv/KtlYGnYU/ezQPOfYlUK3pt51
         YYyg==
X-Gm-Message-State: AOAM5339w2V1ca+aZh/BBuuj0hXyT9Dg9+bLAhLXNMKeIVJ1tEbvJqTl
        udhX4NQzgCFq2fCNOo5n0eQcag==
X-Google-Smtp-Source: ABdhPJzW+RdKU6nokbOM5lacyrg+jNVbYm6SkVPThLayDH9UYiuWMqxlml96dZroXmP5i22U7WUVQA==
X-Received: by 2002:a65:43c9:: with SMTP id n9mr45006765pgp.452.1594158936934;
        Tue, 07 Jul 2020 14:55:36 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id g18sm23742949pfk.40.2020.07.07.14.55.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 14:55:36 -0700 (PDT)
Date:   Tue, 7 Jul 2020 14:55:35 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Scott Branden <scott.branden@broadcom.com>
Cc:     James Morris <jmorris@namei.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jessica Yu <jeyu@kernel.org>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Matthew Garrett <matthewgarrett@google.com>,
        David Howells <dhowells@redhat.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        KP Singh <kpsingh@google.com>, Dave Olsthoorn <dave@bewaar.me>,
        Hans de Goede <hdegoede@redhat.com>,
        Peter Jones <pjones@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Boyd <stephen.boyd@linaro.org>,
        Paul Moore <paul@paul-moore.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 2/4] fs: Remove FIRMWARE_PREALLOC_BUFFER from
 kernel_read_file() enums
Message-ID: <202007071447.D96AA42ECE@keescook>
References: <20200707081926.3688096-1-keescook@chromium.org>
 <20200707081926.3688096-3-keescook@chromium.org>
 <0a5e2c2e-507c-9114-5328-5943f63d707e@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0a5e2c2e-507c-9114-5328-5943f63d707e@broadcom.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 07, 2020 at 09:42:02AM -0700, Scott Branden wrote:
> On 2020-07-07 1:19 a.m., Kees Cook wrote:
> > FIRMWARE_PREALLOC_BUFFER is a "how", not a "what", and confuses the LSMs
> > that are interested in filtering between types of things. The "how"
> > should be an internal detail made uninteresting to the LSMs.
> > 
> > Fixes: a098ecd2fa7d ("firmware: support loading into a pre-allocated buffer")
> > Fixes: fd90bc559bfb ("ima: based on policy verify firmware signatures (pre-allocated buffer)")
> > Fixes: 4f0496d8ffa3 ("ima: based on policy warn about loading firmware (pre-allocated buffer)")
> > [...]
> > diff --git a/include/linux/fs.h b/include/linux/fs.h
> > index 3f881a892ea7..95fc775ed937 100644
> > --- a/include/linux/fs.h
> > +++ b/include/linux/fs.h
> > @@ -2993,10 +2993,10 @@ static inline void i_readcount_inc(struct inode *inode)
> >   #endif
> >   extern int do_pipe_flags(int *, int);
> > +/* This is a list of *what* is being read, not *how*. */
> >   #define __kernel_read_file_id(id) \
> >   	id(UNKNOWN, unknown)		\
> >   	id(FIRMWARE, firmware)		\
> With this change, I'm trying to figure out how the partial firmware read is
> going to work on top of this reachitecture.
> Is it going to be ok to add READING_PARTIAL_FIRMWARE here as that is a
> "what"?

No, that's why I said you need to do the implementation within the API
and not expect each LSM to implement their own (as I mentioned both
times):

https://lore.kernel.org/lkml/202005221551.5CA1372@keescook/
https://lore.kernel.org/lkml/202007061950.F6B3D9E6A@keescook/

I will reply in the thread above.

> > -	id(FIRMWARE_PREALLOC_BUFFER, firmware)	\
> My patch series gets rejected any time I make a change to the
> kernel_read_file* region in linux/fs.h.
> The requirement is for this api to move to another header file outside of
> linux/fs.h
> It seems the same should apply to your change.

Well I'm hardly making the same level of changes, but yeah, sure, if
that helps move things along, I can include that here.

> Could you please add the following patch to the start of you patch series to
> move the kernel_read_file* to its own include file?
> https://patchwork.kernel.org/patch/11647063/

https://lore.kernel.org/lkml/20200706232309.12010-2-scott.branden@broadcom.com/

You've included it in include/linux/security.h and that should be pretty
comprehensive, it shouldn't be needed in so many .c files.

-- 
Kees Cook
