Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5181B3765AD
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 May 2021 14:58:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236758AbhEGM7k (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 May 2021 08:59:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34880 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236397AbhEGM7j (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 May 2021 08:59:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620392319;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GLhWfHwcaV8aKPVU7+Ft0vYJAChyhrhw9hcFw4aRmbo=;
        b=irasaOWxzwPAiNVGanYXsDHtcf9sY2z7n1v37Sjs3pfuQ77zfuc10TPb24hlpF8uPkVjGn
        lZPcZFJtF87vGiYgU5j8XIc9KdKev/8gZZFCGNIZQQaLtPl93H9tE1AG9j2gHfnBthk5NY
        kAe7iNPgxHUVlH26LTDMPrc0lxHv6a0=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-559-KZPN2iR8N0GvqNabluLCnA-1; Fri, 07 May 2021 08:58:37 -0400
X-MC-Unique: KZPN2iR8N0GvqNabluLCnA-1
Received: by mail-yb1-f199.google.com with SMTP id o12-20020a5b050c0000b02904f4a117bd74so9926995ybp.17
        for <linux-fsdevel@vger.kernel.org>; Fri, 07 May 2021 05:58:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GLhWfHwcaV8aKPVU7+Ft0vYJAChyhrhw9hcFw4aRmbo=;
        b=i3AWBTG8GrX/EPEU85W9hjB0fyrtmDMIs7fKltjgkgTSybcZq3JIQfRyCupl8UWMIt
         qKMWdh92SEqKtlmX49TOLnvTiFS/rmzeZTKAF+uFGZ9zNFCUqhIXFYa+fVpAl6QhZnds
         8puPMbmEuVrPEiMldc/EuT2/yIUlVUEbHLSu9s/Zs2Pu46Yz/PsxNX3NyZsTT213jald
         /qPWIDRkja0MRNZZDj2AdIDu7uipnANBOoabj3RKu1m7RPpLWQK4j/42gVlFWnRKcae6
         zTVyWNVstTuCzJM0OPLlLaGEXoXlB/FYFiV4G7SY5ST6zChLCEEbGLvjnMUvYgs9bUD2
         lvsg==
X-Gm-Message-State: AOAM5338V+fRlJVDXIl4db7Yzy9hePV9PtNAgSGzscChQPJzrxukMi+9
        gXD7QvlrSvELfGSURpxPEJmjwrSjrqXDXPkIkgxgeacy3QNiOeWLKHYSH11lgKrdRlL0KweM+Sk
        vjEeM5Ydbc9NqaWs+W8MvO4fw/lq/kzYWeePYTpvtYA==
X-Received: by 2002:a25:640f:: with SMTP id y15mr13270237ybb.436.1620392317280;
        Fri, 07 May 2021 05:58:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyCaqVgj5WYApshEXCI32XAMx1PCeGQdEs8AyQjiRY6Qh9gAQzI/YAbyK/y3MYqZ6+seWa1q04tEmUBWR4cF20=
X-Received: by 2002:a25:640f:: with SMTP id y15mr13270200ybb.436.1620392316934;
 Fri, 07 May 2021 05:58:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210507115719.140799-1-omosnace@redhat.com> <YJUyJcNT9RDaJc4P@kroah.com>
In-Reply-To: <YJUyJcNT9RDaJc4P@kroah.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Fri, 7 May 2021 14:58:23 +0200
Message-ID: <CAFqZXNudm1F4pPfhf+tVVikYpY_RPL9z816LS0tKc-4Vs2vjPA@mail.gmail.com>
Subject: Re: [PATCH] serial: core: fix suspicious security_locked_down() call
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org, David Howells <dhowells@redhat.com>,
        Matthew Garrett <mjg59@google.com>,
        Kees Cook <keescook@chromium.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        SElinux list <selinux@vger.kernel.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        James Morris <jmorris@namei.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 7, 2021 at 2:27 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Fri, May 07, 2021 at 01:57:19PM +0200, Ondrej Mosnacek wrote:
> > The commit that added this check did so in a very strange way - first
> > security_locked_down() is called, its value stored into retval, and if
> > it's nonzero, then an additional check is made for (change_irq ||
> > change_port), and if this is true, the function returns. However, if
> > the goto exit branch is not taken, the code keeps the retval value and
> > continues executing the function. Then, depending on whether
> > uport->ops->verify_port is set, the retval value may or may not be reset
> > to zero and eventually the error value from security_locked_down() may
> > abort the function a few lines below.
> >
> > I will go out on a limb and assume that this isn't the intended behavior
> > and that an error value from security_locked_down() was supposed to
> > abort the function only in case (change_irq || change_port) is true.
>
> Are you _sure_ about this?
>
> Verification from the authors and users of this odd feature might be
> good to have, as I am loath to change how this works without them
> weighing in here.

I'm not completely sure and I'm with you on not merging this without
feedback from people involved in the original patch and/or whoever
understands the logic in said function.

-- 
Ondrej Mosnacek
Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

