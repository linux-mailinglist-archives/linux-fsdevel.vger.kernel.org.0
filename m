Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DB7167EDAA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Jan 2023 19:38:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234401AbjA0Sik (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 Jan 2023 13:38:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234392AbjA0Sij (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 Jan 2023 13:38:39 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F309975A
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Jan 2023 10:38:21 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id s67so3777617pgs.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Jan 2023 10:38:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rHuDJ9RucUYhCg8ApwjHdMewmia/AXOlZBZXO55pQg4=;
        b=RmE65qt1a1ZbGCMjQzVMq0GhHKeBfxlz+MBM6Eq9URWpP3LIKMz2EazDPJtt1bblme
         LOR/+/i+fVokKlYHfgyshAE+35fwF2mGlbWHaA/xtwjOH123ijopEjAce5uujFmEQ/qT
         1ksiRo6KrNJ4TcjDr7Y7urWHe7xb3ZHghvPoQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rHuDJ9RucUYhCg8ApwjHdMewmia/AXOlZBZXO55pQg4=;
        b=WFiCHw49AoT1Ixd8Exbex/1wJzqgr6TtzqUh2JJjwGbn00k2+tbPnWod2Con8izSFw
         XyZwywv3RCpoM4tZ/A1wIm9HVukYzvnmYrbF5HWhi/cvLRKl5mIvFlmb7qUwzITk8aqB
         GfFg6kwNnPsknxj7nEYBILxPFVsgnSUQHsdkP2v2mLuud2niA2GD/Vkmo9mimLrpyC9Q
         8kSXtJo4xFRsPupeGYphr/Bg4paonSRLzVZt2HMKDMrfDepwQowtdGdswjMN37JrPHzN
         6HNBfRhRYAy7ljNuc0i/ohJnfJAx2cS1eQuPyI1/H00XeS91m1b7zCJ/7S3Q+rvUIg95
         ziig==
X-Gm-Message-State: AO0yUKU531eK8P4TbEGY+hLTIkd/cHthstdrfELLL0eVl0U+7XMz0/C+
        nt14Ik8ciCy6BPL5WsRqNWeefQ==
X-Google-Smtp-Source: AK7set9l3nqdTnXHNILcrLjSSOwU/xz5W5jOEeN3EGtBcJyIYZZUIrUSGbVwsjhJIzj6ZGKzOdxo1g==
X-Received: by 2002:a62:1b14:0:b0:58b:c1a1:4006 with SMTP id b20-20020a621b14000000b0058bc1a14006mr7347583pfb.18.1674844700509;
        Fri, 27 Jan 2023 10:38:20 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id o23-20020aa79797000000b00580978caca7sm2976364pfp.45.2023.01.27.10.38.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 10:38:20 -0800 (PST)
Date:   Fri, 27 Jan 2023 10:38:19 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Jann Horn <jannh@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        kernel-hardening@lists.openwall.com
Subject: Re: [PATCH] fs: Use CHECK_DATA_CORRUPTION() when kernel bugs are
 detected
Message-ID: <202301271038.1E64668B@keescook>
References: <20230116191425.458864-1-jannh@google.com>
 <202301260835.61F1C2CA4D@keescook>
 <20230127105815.adgqe2opfzruxk7e@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230127105815.adgqe2opfzruxk7e@wittgenstein>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 27, 2023 at 11:58:15AM +0100, Christian Brauner wrote:
> On Thu, Jan 26, 2023 at 08:35:49AM -0800, Kees Cook wrote:
> > On Mon, Jan 16, 2023 at 08:14:25PM +0100, Jann Horn wrote:
> > > Currently, filp_close() and generic_shutdown_super() use printk() to log
> > > messages when bugs are detected. This is problematic because infrastructure
> > > like syzkaller has no idea that this message indicates a bug.
> > > In addition, some people explicitly want their kernels to BUG() when kernel
> > > data corruption has been detected (CONFIG_BUG_ON_DATA_CORRUPTION).
> > > And finally, when generic_shutdown_super() detects remaining inodes on a
> > > system without CONFIG_BUG_ON_DATA_CORRUPTION, it would be nice if later
> > > accesses to a busy inode would at least crash somewhat cleanly rather than
> > > walking through freed memory.
> > > 
> > > To address all three, use CHECK_DATA_CORRUPTION() when kernel bugs are
> > > detected.
> > 
> > Seems reasonable to me. I'll carry this unless someone else speaks up.
> 
> I've already picked this into a branch with other fs changes for coming cycle.

Okay, great! I'll drop it from my tree.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
