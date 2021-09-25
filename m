Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C0C34183FF
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Sep 2021 20:35:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbhIYSh2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 25 Sep 2021 14:37:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbhIYSh1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 25 Sep 2021 14:37:27 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94DC5C061570;
        Sat, 25 Sep 2021 11:35:52 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id n18so13276733pgm.12;
        Sat, 25 Sep 2021 11:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MIOL2DZ31awChihosWu8oRBkY3Cg7xqjslUJhnt/4eU=;
        b=NFyJcty0lELHPak3EDsYJ0A/0gRSFWxPN30xkyQrYgiXKw6nxGJBCIXl0oQtwxXa97
         RMFxnnprNEWJ9eEB0+oUGSyT73cBJpLVk2kQYXB0sMAMYM17I/abWh87bQUmjFzkCIOV
         aHnHUALpdkzPFkGnsRwTFbdN/3oTamXCEgVewzrOliti/uGAH6JUd22eQf80eFo/70gS
         8IVaxU8W0Kb40bL7KMeJ2AISEGx8l+zFFGKmj8n3DoizjUkiPfwBEFUrXPPO1HqO0tiN
         lDLZchwfQ9bZe9zI6JEnHAPBlKK6cYU4oE1W8A5FPdSwDJqaooFPZRm2m+myuJkYNfQf
         LoMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MIOL2DZ31awChihosWu8oRBkY3Cg7xqjslUJhnt/4eU=;
        b=gVJNuufT2kwsCoKLuohKiMnbXMwYB2QtKdtVehrZn0llyg9R2NT72y2eBuKT5dgI+Y
         q7cVyOP5DoAdp0un41efDm9oIMyujmdnPmrXyfoGC1buD5vrTlDvKnMSqaPMqWS8cTKH
         HY29/aBgOpW/sLbtXltBw15+cIJYAm698UoAbtQPeg+7QFeoL+0bVhgT1whGA262RLGQ
         BKUFdPjIxlPJM89ymfVz6B2Q1Xvwb5uGZQzgtWYCNjkZoiMkDVi8RtJAzYFfSNfxOiOU
         TbdbkwRUCQrP2nKeaDpNWdHQPrKjCEkdmvAAm+RRPLNePlXv/nQJ1yfkJRSx6w8ZBmf3
         V0ng==
X-Gm-Message-State: AOAM532wrubi8AicbeqvBo7VA1GnkYJpZANSrMvx+RO/A43WucrQb0Cv
        X/yZJnPxuA3EvGSVeoXf2LE=
X-Google-Smtp-Source: ABdhPJy8mn0NcDitGa65lH16AjlnnmqxmP/T1zyetxFFMStFlB4BXGJH3Z0yXuK65ObbhjlBP4fdPw==
X-Received: by 2002:a63:1352:: with SMTP id 18mr9047429pgt.348.1632594951825;
        Sat, 25 Sep 2021 11:35:51 -0700 (PDT)
Received: from nuc10 (d50-92-229-34.bchsia.telus.net. [50.92.229.34])
        by smtp.gmail.com with ESMTPSA id x8sm12622698pfq.131.2021.09.25.11.35.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Sep 2021 11:35:51 -0700 (PDT)
Date:   Sat, 25 Sep 2021 11:35:49 -0700
From:   Rustam Kovhaev <rkovhaev@gmail.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        binutils@sourceware.org, gdb-patches@sourceware.org
Subject: Re: [RFC][PATCH] coredump: save timestamp in ELF core
Message-ID: <YU9sBdyMrUsLk0XC@nuc10>
References: <20210925171507.1081788-1-rkovhaev@gmail.com>
 <YU9kSgEmojalPybp@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YU9kSgEmojalPybp@zeniv-ca.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Sep 25, 2021 at 06:02:50PM +0000, Al Viro wrote:
> On Sat, Sep 25, 2021 at 10:15:07AM -0700, Rustam Kovhaev wrote:
> > Hello Alexander and linux-fsdevel@,
> > 
> > I would like to propose saving a new note with timestamp in core file.
> > I do not know whether this is a good idea or not, and I would appreciate
> > your feedback.
> > 
> > Sometimes (unfortunately) I have to review windows user-space cores in
> > windbg, and there is one feature I would like to have in gdb.
> > In windbg there is a .time command that prints timestamp when core was
> > taken.
> > 
> > This might sound like a fixed problem, kernel's core_pattern can have
> > %t, and there are user-space daemons that write timestamp in the
> > report/journal file (apport/systemd-coredump), and sometimes it is
> > possible to correctly guess timestamp from btime/mtime file attribute,
> > and all of the above does indeed solve the problem most of the time.
> > 
> > But quite often, especially while researching hangs and not crashes,
> > when dump is written by gdb/gcore, I get only core.PID file and some
> > application log for research and there is no way to figure out when
> > exactly the core was taken.
> > 
> > I have posted a RFC patch to gdb-patches too [1] and I am copying
> > gdb-patches@ and binutils@ on this RFC.
> > Thank you!
> 
> IDGI.  What's wrong with the usual way of finding the creation date of any
> given file, including the coredump one?

Sometimes file attributes get reset/modified when the file changes hands.
Here is what usually happens: 
We ask customer to take a few cores of some hanging process, customer
does so, then copies the files out from his Linux servers/machines, then
creates an archive on his machine (usually windows/mac) and then, emails
or uploads the archive, and, if we are lucky we get correct creation
date of the core in the archive, but most of the time creation date gets
reset/modified somewhere along this process.

