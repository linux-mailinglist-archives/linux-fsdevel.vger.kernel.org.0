Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A1F3733C90
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Jun 2023 00:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233569AbjFPWsS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Jun 2023 18:48:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjFPWsQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Jun 2023 18:48:16 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0765B30FF
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Jun 2023 15:48:16 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-66615629689so1283520b3a.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Jun 2023 15:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20221208.gappssmtp.com; s=20221208; t=1686955695; x=1689547695;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AyiG85gPI5XRvJhA6cz6thHkdKRKGja6twXW56CMOws=;
        b=VFHMEJObH8Br+eGfJRydAKtoCXZYKM7/nToGAjgKtJGYDHwC2TO8i6HhKRYeAJ6N1n
         2OJnixob5ux4TeP9N1gGnkhx4KwWPJ5/2oUJartWPwKUKFwytrdZdVbFoLs6j5ln0e36
         ZInX96Ja+jcFGfGYvl93hIgDsAGgk8EI9cQhYo3q1YLB3bVwceIhEs6NtwZC7LNd9mlf
         77GPF/ZISSoAG36mc0nDx+n0kku+YfmVXXO0VHiQJouQQk/52In/HA3yvwYl+7G8nKCw
         XaeHI5Lgk4UcPI41Wj6NkbEJ4NPYVLf+xqqVN8k4tPgIwcauYwM5iHprv+ftjrtODFDU
         u/Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686955695; x=1689547695;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AyiG85gPI5XRvJhA6cz6thHkdKRKGja6twXW56CMOws=;
        b=FfNenVIuKPHKuAqx/Jp6y+EnSxaI1FVbdTbOK29VvDcYhTRFD3lot8TufKHrp7gz1W
         5AWN4JgVNMRAt8sSoAsmN+CHNV9Hw9oh7YyXc7H3Mq2D97wLg12I/gh+Qx9/VJD7fWtD
         8UvtNB5u3U0cZwwtNE4Mo3PFohiTusQqwAZjn1xOsG5VrMevGbPHvKz1BPsWr8j8n/42
         NIGXWDzLA2jqEabFo1QLuElilTRT1h640JqkP9W5UyP42EFCqhO4onCnBA4jNw/eIxkE
         eezjx80kFynrkfcVob8rYwjFPzSxfvTzTqaH55penKxCcauQJT2fwX6IxjqUwVVCO7c0
         swaA==
X-Gm-Message-State: AC+VfDza6gsIAins7Iqhxr6xghRHNN42JHJJ1ncUK4tqsMwKLR7h9g+z
        d8ImBHpv7syM9Ev8io4tDT3nhA==
X-Google-Smtp-Source: ACHHUZ4ryCMQcenh+rhyzFHQAG7bj5cq1nar9GzZTU9DX72+irZ0MvxrPaB1F9ukjbOuVfqTvH4wlQ==
X-Received: by 2002:a05:6a00:21ce:b0:666:64fb:b129 with SMTP id t14-20020a056a0021ce00b0066664fbb129mr4314239pfj.27.1686955695339;
        Fri, 16 Jun 2023 15:48:15 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-13-202.pa.nsw.optusnet.com.au. [49.180.13.202])
        by smtp.gmail.com with ESMTPSA id i25-20020aa787d9000000b0064f51ee5b90sm3745624pfo.62.2023.06.16.15.48.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jun 2023 15:48:14 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1qAIEl-00Cdkl-1Z;
        Sat, 17 Jun 2023 08:48:11 +1000
Date:   Sat, 17 Jun 2023 08:48:11 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, Ted Tso <tytso@mit.edu>,
        David Howells <dhowells@redhat.com>
Subject: Re: [PATCH] fs: Protect reconfiguration of sb read-write from racing
 writes
Message-ID: <ZIzmq58XYqkV6n/N@dread.disaster.area>
References: <20230615113848.8439-1-jack@suse.cz>
 <ZIuShQWnWEWscTWr@dread.disaster.area>
 <20230616163700.b6yf4rlps7vacuje@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230616163700.b6yf4rlps7vacuje@quack3>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 16, 2023 at 06:37:00PM +0200, Jan Kara wrote:
> On Fri 16-06-23 08:36:53, Dave Chinner wrote:
> > On Thu, Jun 15, 2023 at 01:38:48PM +0200, Jan Kara wrote:
> > > The reconfigure / remount code takes a lot of effort to protect
> > > filesystem's reconfiguration code from racing writes on remounting
> > > read-only. However during remounting read-only filesystem to read-write
> > > mode userspace writes can start immediately once we clear SB_RDONLY
> > > flag. This is inconvenient for example for ext4 because we need to do
> > > some writes to the filesystem (such as preparation of quota files)
> > > before we can take userspace writes so we are clearing SB_RDONLY flag
> > > before we are fully ready to accept userpace writes and syzbot has found
> > > a way to exploit this [1]. Also as far as I'm reading the code
> > > the filesystem remount code was protected from racing writes in the
> > > legacy mount path by the mount's MNT_READONLY flag so this is relatively
> > > new problem. It is actually fairly easy to protect remount read-write
> > > from racing writes using sb->s_readonly_remount flag so let's just do
> > > that instead of having to workaround these races in the filesystem code.
> ...
> > > +	} else if (remount_rw) {
> > > +		/*
> > > +		 * We set s_readonly_remount here to protect filesystem's
> > > +		 * reconfigure code from writes from userspace until
> > > +		 * reconfigure finishes.
> > > +		 */
> > > +		sb->s_readonly_remount = 1;
> > > +		smp_wmb();
> > 
> > What does the magic random memory barrier do? What is it ordering,
> > and what is it paired with?
> > 
> > This sort of thing is much better done with small helpers that
> > encapsulate the necessary memory barriers:
> > 
> > sb_set_readonly_remount()
> > sb_clear_readonly_remount()
> > 
> > alongside the helper that provides the read-side check and memory
> > barrier the write barrier is associated with.
> 
> Fair remark. The new code including barrier just copies what happens a few
> lines above for remount read-only case (and what happens ib several other
> places throughout VFS code).

Yes, I saw that you'd copied that magic memory barrier. Good for
consistency, but it doesn't answer any of the above questions
either, so....

> I agree having helpers for this and actually
> documenting how the barriers are matching there is a good cleanup.
> 
> > I don't often ask for code to be cleaned up before a bug fix can be
> > added, but I think this is one of the important cases where it does
> > actually matter - we should never add undocumented memory barriers
> > in the code like this...
> 
> I've talked to Christian and we'll queue this as a separate cleanup. I'll
> post it shortly.

Thanks!

-Dave.
-- 
Dave Chinner
david@fromorbit.com
