Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC5771F4CE6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jun 2020 07:28:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726123AbgFJF2A (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Jun 2020 01:28:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725270AbgFJF15 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Jun 2020 01:27:57 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EEF9C03E96F
        for <linux-fsdevel@vger.kernel.org>; Tue,  9 Jun 2020 22:27:57 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id r18so464761pgk.11
        for <linux-fsdevel@vger.kernel.org>; Tue, 09 Jun 2020 22:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YuvdGzIyUzej8b6gdTa5D7P2JhC6M3cmDi3clfShF/E=;
        b=PIgAxHYrxUvRr9+6B+Y6rNbCq5cYmCyrWJFoGVB5vsnqF1cxlaBH0TdQtEogAZhAkK
         0IZo+oyIm9PFRRK9u2lfat+U9IAqccCDhsh4QXM2Gz3Qz/v7cJ50lWwTlK+oRjnhtS65
         WPTyN5BUNxT9qFvRvz655OCTZSSLHH3QKWdPg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YuvdGzIyUzej8b6gdTa5D7P2JhC6M3cmDi3clfShF/E=;
        b=deto+joqoiBSYOS9bFP8f115LDLbROzYCiWVvenbn4/oJ/NMvXR3iN6CfpSSrPY/MB
         7pKwXA8M7D6Hc3eDKifvqo8AzVO3Wz6syIwD4TOW7CfvEb6jqDNVCOk5udKxCcuR8Vz+
         wQqkYNZZGeooGWg4mpBUK/cKdBR1bZyWMC2WShUby66+z8eLvbvTdfnZ+yjjTokn4z4v
         FuPERexTL5BMhDrmvWryeeWoJRUFNtEJOehrVqEt555TiPxKvfntck445j8+BUr9NXyn
         722QR5xlz4hGSZCiyRUe29/qVyrxiXFlKzVu05fT3kGMoyTZ/2elRBZtCxmHPxUwTLBK
         K85Q==
X-Gm-Message-State: AOAM530G9K5qormbV/v/sKvsl76VxtVL3iE4erv+tE3ZV0bxCpAUgEwm
        KuT8Ru/Nq3Nj9ETbCag1zADBWQ==
X-Google-Smtp-Source: ABdhPJxlpq2wABOjHadp4pv2ChXznPW+NT4TMS3Cp+fGD3SZI3IGpPc5oHKwOnJ2E6uX2YT9b+mkZA==
X-Received: by 2002:a62:1917:: with SMTP id 23mr1215614pfz.272.1591766876846;
        Tue, 09 Jun 2020 22:27:56 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x3sm11513892pfi.57.2020.06.09.22.27.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 22:27:55 -0700 (PDT)
Date:   Tue, 9 Jun 2020 22:27:54 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     containers@lists.linux-foundation.org,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Robert Sesek <rsesek@google.com>,
        Chris Palmer <palmer@google.com>, Jann Horn <jannh@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Wagner <daniel.wagner@bmw-carit.de>,
        linux-kernel@vger.kernel.org, Matt Denton <mpdenton@google.com>,
        John Fastabend <john.r.fastabend@intel.com>,
        linux-fsdevel@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, cgroups@vger.kernel.org,
        stable@vger.kernel.org, "David S . Miller" <davem@davemloft.net>
Subject: Re: [PATCH v3 1/4] fs, net: Standardize on file_receive helper to
 move fds across processes
Message-ID: <202006092227.D2D0E1F8F@keescook>
References: <20200603011044.7972-1-sargun@sargun.me>
 <20200603011044.7972-2-sargun@sargun.me>
 <20200604012452.vh33nufblowuxfed@wittgenstein>
 <202006031845.F587F85A@keescook>
 <20200604125226.eztfrpvvuji7cbb2@wittgenstein>
 <20200605075435.GA3345@ircssh-2.c.rugged-nimbus-611.internal>
 <202006091235.930519F5B@keescook>
 <20200609200346.3fthqgfyw3bxat6l@wittgenstein>
 <202006091346.66B79E07@keescook>
 <037A305F-B3F8-4CFA-B9F8-CD4C9EF9090B@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <037A305F-B3F8-4CFA-B9F8-CD4C9EF9090B@ubuntu.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 09, 2020 at 11:27:30PM +0200, Christian Brauner wrote:
> On June 9, 2020 10:55:42 PM GMT+02:00, Kees Cook <keescook@chromium.org> wrote:
> >LOL. And while we were debating this, hch just went and cleaned stuff up:
> >
> >2618d530dd8b ("net/scm: cleanup scm_detach_fds")
> >
> >So, um, yeah, now my proposal is actually even closer to what we already
> >have there. We just add the replace_fd() logic to __scm_install_fd() and
> >we're done with it.
> 
> Cool, you have a link? :)

How about this:

https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/commit/?h=devel/seccomp/addfd/v3.1&id=bb94586b9e7cc88e915536c2e9fb991a97b62416

-- 
Kees Cook
