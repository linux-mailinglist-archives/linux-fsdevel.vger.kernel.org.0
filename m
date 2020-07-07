Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5402A21690F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jul 2020 11:31:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbgGGJbe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jul 2020 05:31:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:57622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725825AbgGGJbd (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jul 2020 05:31:33 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 47DBE2065F;
        Tue,  7 Jul 2020 09:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594114293;
        bh=7EJPV5cge5x3+J13JIKyNgux4EwJmANov4vu3RAeYAU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G5b57d5VluIkuQJOC73on6FYdeC3Z9X1U3EH8Y6N35tSs1ybjw+w2UaJMRNvNiI0C
         Ztuon0HGC5mXaRIHbnMgXBEjgnZ8st6X1f0tTkpVWTVYNchlfy/EsoIrbhNasxpjrD
         b4O5dyY2lR6K9uqQZ+lUSMciMwebhkosO8EJSxJE=
Date:   Tue, 7 Jul 2020 11:31:31 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     James Morris <jmorris@namei.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Scott Branden <scott.branden@broadcom.com>,
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
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH 0/4] Fix misused kernel_read_file() enums
Message-ID: <20200707093131.GA2592640@kroah.com>
References: <20200707081926.3688096-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200707081926.3688096-1-keescook@chromium.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 07, 2020 at 01:19:22AM -0700, Kees Cook wrote:
> Hi,
> 
> In looking for closely at the additions that got made to the
> kernel_read_file() enums, I noticed that FIRMWARE_PREALLOC_BUFFER
> and FIRMWARE_EFI_EMBEDDED were added, but they are not appropriate
> *kinds* of files for the LSM to reason about. They are a "how" and
> "where", respectively. Remove these improper aliases and refactor the
> code to adapt to the changes.
> 
> Additionally adds in missing calls to security_kernel_post_read_file()
> in the platform firmware fallback path (to match the sysfs firmware
> fallback path) and in module loading. I considered entirely removing
> security_kernel_post_read_file() hook since it is technically unused,
> but IMA probably wants to be able to measure EFI-stored firmware images,
> so I wired it up and matched it for modules, in case anyone wants to
> move the module signature checks out of the module core and into an LSM
> to avoid the current layering violations.
> 
> This touches several trees, and I suspect it would be best to go through
> James's LSM tree.
> 
> Thanks!
> 
> -Kees
> 
> Kees Cook (4):
>   firmware_loader: EFI firmware loader must handle pre-allocated buffer
>   fs: Remove FIRMWARE_PREALLOC_BUFFER from kernel_read_file() enums
>   fs: Remove FIRMWARE_EFI_EMBEDDED from kernel_read_file() enums
>   module: Add hook for security_kernel_post_read_file()

Looks good to me, thanks for fixing this up:

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
