Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0353F1F603F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jun 2020 05:02:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbgFKDCx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Jun 2020 23:02:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726279AbgFKDCq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Jun 2020 23:02:46 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C84D4C08C5C3
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Jun 2020 20:02:45 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id s10so1911559pgm.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Jun 2020 20:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=j3OsXPGIwi3xsUIwRgQitia7+o3C2dniHB1RcDZH3GE=;
        b=fcp7RrfiW9uA4z+tTFPju9m2g0v7xg/w/6Yv3TKyJpkvVw3AHi9F9bI1FqyDu6Hl9w
         GyfBNHCOgQCZw4f0JowTFQTL7UPNRXy+GlzrF7F/cvWtwqH6sFM7IejbWJFtmM65xNQl
         wwbn9ttjXIWQ8BBcanAOUT3ilxezqyytZ8NSI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=j3OsXPGIwi3xsUIwRgQitia7+o3C2dniHB1RcDZH3GE=;
        b=fmWKo5V+qNi0s4oSmsCK9PiAbTHq15HYI2htUtUjMeohCaXCSn7hKkkRSC+dMuqtV/
         UdVvTfhsgLMJ013AU3LwwHx2q8fRRMb7QZF6HECv2JoMB1neFoB0x5KJPrAqfKa1rQwf
         XVBNr+hkU3jx3F1cKtXwr375oX0gUrsNryAJJqZS0tjCZuLRA8hJ+fRomuJn+gmEf7TG
         Uh73T6mf2dlOAL1t1RPhYpBQ6Vb8fb+irTqJP5GFwupdndDjJe1UiCzcZ/gBdJ2AbDQj
         IHgG4TZoiSZsMMS9FQGCYMqMllpWCnegAzHMaQDuF0hyRa2/N4q93SxWwdu1z8o/lrZd
         9opg==
X-Gm-Message-State: AOAM531Zpl0h0Sc1GucU7Q+0kWwHwUGtM2t9avr/aib8/iMRvzKCRzuf
        6vggEldDOdDr0J5j8f+OZ+/sZA==
X-Google-Smtp-Source: ABdhPJzDdTSTxOnzWK9kQC66Yl7w/5oeeYdWeKvh7Jap0JIbbKbOBkew4C9KEtAnUyMtc31xZqAPJg==
X-Received: by 2002:a65:484c:: with SMTP id i12mr5034279pgs.267.1591844565164;
        Wed, 10 Jun 2020 20:02:45 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id nl8sm1059871pjb.13.2020.06.10.20.02.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2020 20:02:43 -0700 (PDT)
Date:   Wed, 10 Jun 2020 20:02:42 -0700
From:   Kees Cook <keescook@chromium.org>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     'Sargun Dhillon' <sargun@sargun.me>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        "containers@lists.linux-foundation.org" 
        <containers@lists.linux-foundation.org>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Robert Sesek <rsesek@google.com>,
        Chris Palmer <palmer@google.com>, Jann Horn <jannh@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Matt Denton <mpdenton@google.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Tejun Heo <tj@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "David S . Miller" <davem@davemloft.net>
Subject: Re: [PATCH v3 1/4] fs, net: Standardize on file_receive helper to
 move fds across processes
Message-ID: <202006102001.E9779DFA5B@keescook>
References: <202006031845.F587F85A@keescook>
 <20200604125226.eztfrpvvuji7cbb2@wittgenstein>
 <20200605075435.GA3345@ircssh-2.c.rugged-nimbus-611.internal>
 <202006091235.930519F5B@keescook>
 <20200609200346.3fthqgfyw3bxat6l@wittgenstein>
 <202006091346.66B79E07@keescook>
 <037A305F-B3F8-4CFA-B9F8-CD4C9EF9090B@ubuntu.com>
 <202006092227.D2D0E1F8F@keescook>
 <20200610081237.GA23425@ircssh-2.c.rugged-nimbus-611.internal>
 <40d76a9a4525414a8c9809cd29a7ba8e@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40d76a9a4525414a8c9809cd29a7ba8e@AcuMS.aculab.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 10, 2020 at 08:48:45AM +0000, David Laight wrote:
> From: Sargun Dhillon
> > Sent: 10 June 2020 09:13
> In essence the 'copy_to_user' is done by the wrapper code.
> The code filling in the CMSG buffer can be considered to be
> writing a kernel buffer.
> 
> IIRC other kernels (eg NetBSD) do the copies for ioctl() requests
> in the ioctl syscall wrapper.
> The IOW/IOR/IOWR flags have to be right.

Yeah, this seems like it'd make a lot more sense (and would have easily
caught the IOR/IOW issue pointed out later in the thread). I wonder how
insane it would be to try to fix that globally in the kernel...

-- 
Kees Cook
