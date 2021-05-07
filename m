Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71959376518
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 May 2021 14:27:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236178AbhEGM2V (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 May 2021 08:28:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:54554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233468AbhEGM2U (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 May 2021 08:28:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EB0566145D;
        Fri,  7 May 2021 12:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1620390440;
        bh=lHRE9JXgDKU9qUnQDDKQaDp6aEcA34kwR1z9u6Fuyak=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rCOimIwut6DOuOjoh8E37kjHgxSWf3y0Y96ZpFT/zuz9Gie5ehgEPtT87zouAz3HK
         Mu6cprjw+29uhikMWAE59cfqOvvcxdigBWwXaRRL1zlSNCWMiX+SGbUDcESzVkPPgl
         Hs16dL6VNmW3HZHADLbz+ZyG8bu0+UCXyxIkK2/o=
Date:   Fri, 7 May 2021 14:27:17 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     linux-serial@vger.kernel.org, David Howells <dhowells@redhat.com>,
        Matthew Garrett <mjg59@google.com>,
        Kees Cook <keescook@chromium.org>,
        Jiri Slaby <jirislaby@kernel.org>, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        James Morris <jmorris@namei.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] serial: core: fix suspicious security_locked_down() call
Message-ID: <YJUyJcNT9RDaJc4P@kroah.com>
References: <20210507115719.140799-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210507115719.140799-1-omosnace@redhat.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 07, 2021 at 01:57:19PM +0200, Ondrej Mosnacek wrote:
> The commit that added this check did so in a very strange way - first
> security_locked_down() is called, its value stored into retval, and if
> it's nonzero, then an additional check is made for (change_irq ||
> change_port), and if this is true, the function returns. However, if
> the goto exit branch is not taken, the code keeps the retval value and
> continues executing the function. Then, depending on whether
> uport->ops->verify_port is set, the retval value may or may not be reset
> to zero and eventually the error value from security_locked_down() may
> abort the function a few lines below.
> 
> I will go out on a limb and assume that this isn't the intended behavior
> and that an error value from security_locked_down() was supposed to
> abort the function only in case (change_irq || change_port) is true.

Are you _sure_ about this?

Verification from the authors and users of this odd feature might be
good to have, as I am loath to change how this works without them
weighing in here.

thanks,

greg k-h
