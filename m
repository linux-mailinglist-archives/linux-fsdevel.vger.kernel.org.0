Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D07D218676
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jul 2020 13:55:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728929AbgGHLzW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Jul 2020 07:55:22 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:51891 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728592AbgGHLzV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jul 2020 07:55:21 -0400
Received: by mail-pj1-f66.google.com with SMTP id ls15so434307pjb.1;
        Wed, 08 Jul 2020 04:55:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jTBZMKlUFpNmWtFn4HrVodPcCTzQQGJkYgOfgBAYscY=;
        b=QbWYJMRC1FMBssFToN6lX3FN3Z1KfD1XTPJw9e2bZ+S/oxwWPIW2H4htJ8Vyi3bfMn
         vRlBj/Lh2nbCGBKA32qcbY4yWqjCXk1qgS0TXuDjxWyXAZu/mhPms5NlkSIAKDSesiZD
         akXY8SQexPtwibggcsrhBW7B9pdYe8tExmkX/bzB7r7D09ZSRJF4RIs6AIAw4vx+wxMu
         IyXDAp/8rJsVd9fx/C1XRIACjppI4t8sCCU75AzGoLNsfAEII/M3SNpOgrRKIRo/NmPx
         QFd/c+gTV07e8eh1XyCnxJk6JGE7GtBcu5oYAQIZfCHi98I5vTBWb3Sdm7LuEaajkHPW
         XOpQ==
X-Gm-Message-State: AOAM533OWBpHHWoS1zGcOervFLmOtG4SBM/AJyeQoUKpA8NjIo7nIWYM
        20Yh5hZQZNfpT8b8i5NnS94=
X-Google-Smtp-Source: ABdhPJxdjdl5pXFLkToBY02YEqh8lbtVQNFTH37/2AyToUDE4A78TloW0lF97T9BOE0kCq5Z4IZ50w==
X-Received: by 2002:a17:902:20a:: with SMTP id 10mr22378243plc.127.1594209320371;
        Wed, 08 Jul 2020 04:55:20 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id 17sm23498716pfv.16.2020.07.08.04.55.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 04:55:18 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 07E68401AE; Wed,  8 Jul 2020 11:55:18 +0000 (UTC)
Date:   Wed, 8 Jul 2020 11:55:17 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Kees Cook <keescook@chromium.org>,
        James Morris <jmorris@namei.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Scott Branden <scott.branden@broadcom.com>,
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
        Peter Jones <pjones@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Boyd <stephen.boyd@linaro.org>,
        Paul Moore <paul@paul-moore.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH 0/4] Fix misused kernel_read_file() enums
Message-ID: <20200708115517.GF4332@42.do-not-panic.com>
References: <20200707081926.3688096-1-keescook@chromium.org>
 <3c01073b-c422-dd97-0677-c16fe1158907@redhat.com>
 <f5e65f73-2c94-3614-2479-69b2bfda9775@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f5e65f73-2c94-3614-2479-69b2bfda9775@redhat.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 08, 2020 at 01:37:41PM +0200, Hans de Goede wrote:
> Hi,
> 
> On 7/8/20 1:01 PM, Hans de Goede wrote:
> > Hi,
> > 
> > On 7/7/20 10:19 AM, Kees Cook wrote:
> > > Hi,
> > > 
> > > In looking for closely at the additions that got made to the
> > > kernel_read_file() enums, I noticed that FIRMWARE_PREALLOC_BUFFER
> > > and FIRMWARE_EFI_EMBEDDED were added, but they are not appropriate
> > > *kinds* of files for the LSM to reason about. They are a "how" and
> > > "where", respectively. Remove these improper aliases and refactor the
> > > code to adapt to the changes.
> > > 
> > > Additionally adds in missing calls to security_kernel_post_read_file()
> > > in the platform firmware fallback path (to match the sysfs firmware
> > > fallback path) and in module loading. I considered entirely removing
> > > security_kernel_post_read_file() hook since it is technically unused,
> > > but IMA probably wants to be able to measure EFI-stored firmware images,
> > > so I wired it up and matched it for modules, in case anyone wants to
> > > move the module signature checks out of the module core and into an LSM
> > > to avoid the current layering violations.
> > > 
> > > This touches several trees, and I suspect it would be best to go through
> > > James's LSM tree.
> > > 
> > > Thanks!
> > 
> > 
> > I've done some quick tests on this series to make sure that
> > the efi embedded-firmware support did not regress.
> > That still works fine, so this series is;
> > 
> > Tested-by: Hans de Goede <hdegoede@redhat.com>
> 
> I made a mistake during testing I was not actually running the
> kernel with the patches added.
> 
> After fixing that I did find a problem, patch 4/4:
> "module: Add hook for security_kernel_post_read_file()"
> 
> Breaks module-loading for me. This is with the 4 patches
> on top of 5.8.0-rc4, so this might just be because I'm
> not using the right base.
> 
> With patch 4/4 reverted things work fine for me.
> 
> So, please only add my Tested-by to patches 1-3.

BTW is there any testing covered by the selftests for the firmware
laoder which would have caputured this? If not can you extend
it with something to capture this case you ran into?

  Luis
