Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BEC855ECA8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jun 2022 20:35:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232390AbiF1SfD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jun 2022 14:35:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbiF1SfC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jun 2022 14:35:02 -0400
Received: from mail-vk1-xa2c.google.com (mail-vk1-xa2c.google.com [IPv6:2607:f8b0:4864:20::a2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FBC220F44
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jun 2022 11:35:02 -0700 (PDT)
Received: by mail-vk1-xa2c.google.com with SMTP id a15so1343308vkl.10
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jun 2022 11:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GPlVzSPQq8cBuvee+KORp+vDNBxsJOWPOvX8Ae+lqsc=;
        b=AyMw8DcPfGKyU1G+Cva9G8zdUHka/pOGtKMRho/iGGszuXO4N7QMnUGHleoPzJi+86
         ESxBKvyrqn+f3ocv7mvgd/8H27fdIlTC02hwKwyYaek2ze//kSawUMRLmjlZwrQjOcxY
         oDnNf9yw/z27YIrkmFEdFoIl0Y6w/mtlVB7eTXxAhQi+kNhUwWtx2vZLEA9u79BRv1k2
         019N3HJi52465htzt/hRbBKDL9yelPsFaBdgeGpTtEDVdcyif1byTNoMFjmFKx/Cbbbo
         gEgGQ4MHDxXC5hrHgA1cF2kJTonsfcvHIp6NYCBb4nYkUKM/lbqqNCQ2WyKNS6SmcEFZ
         tcUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GPlVzSPQq8cBuvee+KORp+vDNBxsJOWPOvX8Ae+lqsc=;
        b=GW9Q65yRSipM/+L3g3FJoElSiTVph1wUjaR5qnQOSxpchfwNzclOWQ3T0pmufi5+z4
         +97kRlinhsYaKM3b3NITuOG3GOUx9oVSdyXmHw0ly5ghrBGHg1kW+oLgq5Sq1xCG5dNo
         r10RhG1Fu6G+6dqjrPH0lqAoPMhksC4MDLO87f8jJXDXEQwF02T9V8tqlOfErN86Mx/0
         mbwx/FsDhxi5m9VYuyuRZ/XIVaYoOwInqEN+HDpZnwCxoMfpo7siSaqo+BAxx84CxzO5
         TQe2RuCpUxYUUp2pWj5He9l7bfLAhlLvySVDK3TbR1CCUptA4L++7PAVFkh0vGwZACY+
         URKQ==
X-Gm-Message-State: AJIora+Kfu26ZXozOXCjTWw6bkXiQJ/qDm4qiqen7SD1wam+/LzeZLV7
        MQH+2B/QqHrGgS2BB0OF2A2TkHCH8PtHBC4YaSLDspoDRpj3DQ==
X-Google-Smtp-Source: AGRyM1uCrYNnZ1BwgTyacsMc2JfqJDt4Znoad0c0Xx4TOqcp1Psn2zAfuyKo10IJwcIuDL6YjILiPNpEguDnCVZYctY=
X-Received: by 2002:a1f:a094:0:b0:36c:e403:52eb with SMTP id
 j142-20020a1fa094000000b0036ce40352ebmr2359546vke.36.1656441301142; Tue, 28
 Jun 2022 11:35:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220627221107.176495-1-james@openvpn.net> <Yrs7lh6hG44ERoiM@ZenIV>
In-Reply-To: <Yrs7lh6hG44ERoiM@ZenIV>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 28 Jun 2022 21:34:49 +0300
Message-ID: <CAOQ4uxgoZe8UUftRKf=b--YmrKJ4wdDX99y7G8U2WTuuVsyvdA@mail.gmail.com>
Subject: Re: [PATCH] namei: implemented RENAME_NEWER flag for renameat2()
 conditional replace
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     James Yonan <james@openvpn.net>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 28, 2022 at 8:44 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Mon, Jun 27, 2022 at 04:11:07PM -0600, James Yonan wrote:
>
> >           && d_is_positive(new_dentry)
> >           && timespec64_compare(&d_backing_inode(old_dentry)->i_mtime,
> >                                 &d_backing_inode(new_dentry)->i_mtime) <= 0)
> >               goto exit5;
> >
> > It's pretty cool in a way that a new atomic file operation can even be
> > implemented in just 5 lines of code, and it's thanks to the existing
> > locking infrastructure around file rename/move that these operations
> > become almost trivial.  Unfortunately, every fs must approve a new
> > renameat2() flag, so it bloats the patch a bit.
>
> How is it atomic and what's to stabilize ->i_mtime in that test?
> Confused...

Good point.
RENAME_EXCHANGE_WITH_NEWER would have been better
in that regard.

And you'd have to check in vfs_rename() after lock_two_nondirectories()

Thanks,
Amir.
