Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0835B5B6926
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Sep 2022 10:02:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230517AbiIMICl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Sep 2022 04:02:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230254AbiIMICk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Sep 2022 04:02:40 -0400
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 975B756BB4
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Sep 2022 01:02:39 -0700 (PDT)
Received: by mail-vs1-xe34.google.com with SMTP id u189so11538054vsb.4
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Sep 2022 01:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=ZtUx3gTA4W26Pyi/05G45HPqU4EbPoGP8vEbOgz06Z0=;
        b=UWSTjTpwFEYecs+tEgjmZJl4Q17g2lJ0aWFcUVeObHrposQwpHDXPD/CYt6/UD0Eks
         Nwhh4n1mKQNunePBzqqMmSCbt2BfFvtHyCwyLqFDYHM5bxj7VNkgTORp/74hHllO24PU
         AQKB8Ldqww+nsBEmCMmkvIqD7yaw2UIXlZnahc+4HSadgYbr4J5k0NnRcvVSOY7RtrCk
         2UOuywfdoOs56b2BlL45CB9OrWdLOyFJ247BTQH6eRxrq2scETcM2UXp/tWrL6f5cRFD
         yHtDzw4qq4FxmK+8FgcV0g4Mtic3qdpi0jbUV02Yg8KHcNbiotY5dsYyau5R9uUqEMh5
         YdcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=ZtUx3gTA4W26Pyi/05G45HPqU4EbPoGP8vEbOgz06Z0=;
        b=5kDJT6Ln3KCv8PNa4VODtdjDQ70SrEzBZ4UuI7UV36590c0YrZQOYFYezBFgl2Yu+a
         UMnDJqN6YafMo/ieD78I96COQ+5k0SIQ6r4uWoUfHTpDF0Jpye/in6bpXxy+mxmJMOBN
         ZFoSnkp8lrVt5wU5eLe15EOAe2V1JN6UJKrC8Rb/7A+XdQ5MWs+zXBXtwh3sKGLhB0OD
         HAFmLUKowTMN+u3KYwRZDfmOtv0dltg4JyWehGvBSo70Axr15JdhjDPy0VrUtCs2IGwE
         QyYWGHmI3rue9vRIo85AWMzCUqpORNcqGdVCPcgxjGwMlwhi7tPOTg5eGb9/8E+nV0Kl
         fFoA==
X-Gm-Message-State: ACgBeo10PZUaW3uhOVHyRc9KyS4srTD/cGjg6rCBgAUnFuxqc/1/zi1w
        FBFNi9Vg3zm+1AZ3imdkyyT7Vh58hI1aSzw/AY7f5W7upY8=
X-Google-Smtp-Source: AA6agR5HR4z+PDL+n3HXfvByrf7jbsSoq8phGrToLU8oO2jgT/1LQQmS7rmMkn/9jZZqU4ejaQcPxtMP992dcQ+khJY=
X-Received: by 2002:a05:6102:14b:b0:398:2e7c:4780 with SMTP id
 a11-20020a056102014b00b003982e7c4780mr7868479vsr.72.1663056158625; Tue, 13
 Sep 2022 01:02:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220221082002.508392-1-mszeredi@redhat.com> <Yx/lIWoLCWHwM6DO@ZenIV>
 <YyAHDsGiaA/0ksX8@ZenIV>
In-Reply-To: <YyAHDsGiaA/0ksX8@ZenIV>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 13 Sep 2022 11:02:27 +0300
Message-ID: <CAOQ4uxiz32Srdg=c7g_49TFnxT9VN-j_V9u2ZHsxU10gCDXWVA@mail.gmail.com>
Subject: Re: [PATCH v2] vfs: fix link vs. rename race
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        Xavier Roche <xavier.roche@algolia.com>,
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

On Tue, Sep 13, 2022 at 7:38 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Tue, Sep 13, 2022 at 03:04:17AM +0100, Al Viro wrote:
> > On Mon, Feb 21, 2022 at 09:20:02AM +0100, Miklos Szeredi wrote:
> >
> > [digging through the old piles of mail]
> >
> > Eyes-watering control flow in do_linkat() aside (it's bound to rot; too
> > much of it won't get any regression testing and it's convoluted enough
> > to break easily), the main problem I have with that is the DoS potential.
> >
> > You have a system-wide lock, and if it's stuck you'll get every damn
> > rename(2) stuck as well.  Sure, having it taken only upon the race
> > with rename() (or unlink(), for that matter) make it harder to get
> > stuck with lock held, but that'll make the problem harder to reproduce
> > and debug...
>
> FWIW, how much trouble would we have if link(2) would do the following?
>
>         find the parent of source

Well, only if source is not AT_EMPTY_PATH

>         lock it
>         look the child up
>         verify it's a non-directory
>         bump child's i_nlink
>                 all failure exits past that point decrement child's i_nlink

No need to bump i_nlink.
Sufficient to set I_LINKABLE.
and clean it up on failure if i_nlink > 0.

Or we can move cleanup of I_LINKABLE to drop_nlink()/clean_nlink()

>         unlock the parent
>         find the parent of destination
>         lock it
>         look the destination up
>         call vfs_link
>         decrement child's i_nlink - vfs_link has bumped it
>         unlock the parent of destination
>
> I do realize it can lead to leaked link count on a crash, obviously...

No such problem with I_LINKABLE.

Thanks,
Amir.
