Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C2821FB9A3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jun 2020 18:05:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733196AbgFPQFg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Jun 2020 12:05:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733007AbgFPQFc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Jun 2020 12:05:32 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96B5FC0613EE
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Jun 2020 09:05:32 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id s135so8754895pgs.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Jun 2020 09:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GsZMacKtpesOxP+a2myMr99YbAG58BqzpuI3p66lyWE=;
        b=U+rVcwzvOxiugEYzwFEOsUTyIYC0zrD9L//KqbY3KLh6kAWaKOVLW6S2PEBZNkUzZB
         Va/ID/Lx0jY7fHPp5zQPHHxv/Ln+/ZqNNagq0jWU0rfjSlk7wKKfPbUbnKanRNPb4MXv
         BPQ+ZtNfKAAI/vlY8WCybDSIj/et0xHDCOIHg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GsZMacKtpesOxP+a2myMr99YbAG58BqzpuI3p66lyWE=;
        b=dQ7pyQpB36OtqsJ/KqH1D6CqYU0YNzd1vJgmvYATkuR+XhAhELBf3X4npkaWA6U/bs
         mMOFpL0tZZjnb5diEpdDHSiOVgkQrHdpMHOsSmWfOHjpMad9gZ8ySPdoGN2vF4/58VhZ
         ssAQiFMbJE7vbiYWKvr9J4CIYQlqCCsK4K+AoXZq9nRNkF3Qg4fmBlAEmC/uoBcMIEs/
         R3a00fHdFE5Vpnnak21wY8578PeZPL+aYpLoSvaK7ga80JuQDRbxzmiHagKVA3ggu+FL
         jtgTTtcbZf1ZKRSri9YCro27vldMksX9K39OzZacZr4b+VbqlkycpOQOeNmT5JxjtTaf
         yVag==
X-Gm-Message-State: AOAM532Fw8YmlY/Mr6+yjr9maOhiAbz/FP+SIVsDSPn3z/xvYzfK7nfy
        31hTolhxfzzfwjXWhA9oEIw97w==
X-Google-Smtp-Source: ABdhPJzdfPhLjN6zvps8V8jiQcD/fOqJIIccHadakXun+WI/1mta+SFES2gZ8pnzJRsPG2WOBzf7GA==
X-Received: by 2002:a63:1b4b:: with SMTP id b11mr2541719pgm.243.1592323531730;
        Tue, 16 Jun 2020 09:05:31 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 140sm17823314pfz.154.2020.06.16.09.05.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 09:05:30 -0700 (PDT)
Date:   Tue, 16 Jun 2020 09:05:29 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Tycho Andersen <tycho@tycho.ws>
Cc:     linux-kernel@vger.kernel.org, Sargun Dhillon <sargun@sargun.me>,
        Christian Brauner <christian@brauner.io>,
        "David S. Miller" <davem@davemloft.net>,
        Christoph Hellwig <hch@lst.de>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Matt Denton <mpdenton@google.com>,
        Jann Horn <jannh@google.com>, Chris Palmer <palmer@google.com>,
        Robert Sesek <rsesek@google.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>, Shuah Khan <shuah@kernel.org>,
        netdev@vger.kernel.org, containers@lists.linux-foundation.org,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v4 10/11] seccomp: Switch addfd to Extensible Argument
 ioctl
Message-ID: <202006160904.A30F2C5B9E@keescook>
References: <20200616032524.460144-1-keescook@chromium.org>
 <20200616032524.460144-11-keescook@chromium.org>
 <20200616145546.GH2893648@cisco>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200616145546.GH2893648@cisco>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 16, 2020 at 08:55:46AM -0600, Tycho Andersen wrote:
> On Mon, Jun 15, 2020 at 08:25:23PM -0700, Kees Cook wrote:
> > This patch is based on discussions[1] with Sargun Dhillon, Christian
> > Brauner, and David Laight. Instead of building size into the addfd
> > structure, make it a function of the ioctl command (which is how sizes are
> > normally passed to ioctls). To support forward and backward compatibility,
> > just mask out the direction and size, and match everything. The size (and
> > any future direction) checks are done along with copy_struct_from_user()
> > logic. Also update the selftests to check size bounds.
> > 
> > [1] https://lore.kernel.org/lkml/20200612104629.GA15814@ircssh-2.c.rugged-nimbus-611.internal
> > 
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> >  include/uapi/linux/seccomp.h                  |  2 -
> >  kernel/seccomp.c                              | 21 ++++++----
> >  tools/testing/selftests/seccomp/seccomp_bpf.c | 40 ++++++++++++++++---
> >  3 files changed, 49 insertions(+), 14 deletions(-)
> > 
> > diff --git a/include/uapi/linux/seccomp.h b/include/uapi/linux/seccomp.h
> > index c347160378e5..473a61695ac3 100644
> > --- a/include/uapi/linux/seccomp.h
> > +++ b/include/uapi/linux/seccomp.h
> > @@ -118,7 +118,6 @@ struct seccomp_notif_resp {
> >  
> >  /**
> >   * struct seccomp_notif_addfd
> > - * @size: The size of the seccomp_notif_addfd structure
> >   * @id: The ID of the seccomp notification
> >   * @flags: SECCOMP_ADDFD_FLAG_*
> >   * @srcfd: The local fd number
> > @@ -126,7 +125,6 @@ struct seccomp_notif_resp {
> >   * @newfd_flags: The O_* flags the remote FD should have applied
> >   */
> >  struct seccomp_notif_addfd {
> > -	__u64 size;
> 
> Huh? Won't this break builds?

Only if they use addfd without this patch? :) Are you saying I should
collapse this patch into the main addfd and test patches?

-- 
Kees Cook
