Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D323566522E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jan 2023 04:14:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231437AbjAKDO5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Jan 2023 22:14:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231350AbjAKDOy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Jan 2023 22:14:54 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDED5E038;
        Tue, 10 Jan 2023 19:14:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4oVge3+sCGnCyr9n3sgVnOMeZqCZSCXC9r9hEGN1JLc=; b=hZezXo7GyHHL9cGaR11hdg+HgM
        gaYGo0O3iaw24k6B3bzUPadRj9UJUv3RZs6zLV12XEZMxbwJEs35Sjw3HW8BCJDiHR88sbo7ZmwcL
        hNf8NaiPdV4kfVPRanj3kH4gRiQLnirDMHTjUxLCOa8GaW/NEQvq4mm3oRhb5R2L0ka/Nh27II72/
        qlqNviHX3MkXtDYmm+DLRbIYjV56L0OA9eOGNB+m0OhGpNp5nn5e5SSjEBzYQVsE6rxnfuA6yw0aR
        IHWoOGbBuUTeSMXcCpNAayNv6N3K44/F5AuBosqlp0p7LrGs9KkZtZJDQw2YIrcd8Tw/YJfZThuSJ
        gja9Ps4A==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pFRZe-0016xk-0p;
        Wed, 11 Jan 2023 03:14:46 +0000
Date:   Wed, 11 Jan 2023 03:14:46 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Chengming Zhou <zhouchengming@bytedance.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs/pipe: Delete unused do_pipe_flags()
Message-ID: <Y74pphK09fZ9x8gI@ZenIV>
References: <20230111030547.7730-1-zhouchengming@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230111030547.7730-1-zhouchengming@bytedance.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 11, 2023 at 11:05:47AM +0800, Chengming Zhou wrote:
> It looks like do_pipe_flags() is not used anywhere and not exported
> too, so delete it. No any functional changes.

What do you mean, not used anywhere?

<checks>

; git grep -n -w do_pipe_flags
arch/alpha/kernel/osf_sys.c:1315:       int res = do_pipe_flags(fd, 0);
arch/ia64/kernel/sys_ia64.c:109:        retval = do_pipe_flags(fd, 0);
arch/mips/kernel/syscall.c:54:  int error = do_pipe_flags(fd, 0);
arch/sh/kernel/sys_sh32.c:31:   error = do_pipe_flags(fd, 0);
arch/sparc/kernel/sys_sparc_32.c:81:    error = do_pipe_flags(fd, 0);
arch/sparc/kernel/sys_sparc_64.c:319:   error = do_pipe_flags(fd, 0);
fs/pipe.c:989:int do_pipe_flags(int *fd, int flags)
include/linux/fs.h:3019:extern int do_pipe_flags(int *, int);
;

A bunch of callers, and it's easy to check that they are not
ifdefed out, etc. - normal live code...
