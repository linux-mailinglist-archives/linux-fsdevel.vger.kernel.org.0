Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD5F44EABEE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Mar 2022 13:07:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235546AbiC2LJL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Mar 2022 07:09:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235556AbiC2LJJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Mar 2022 07:09:09 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C617026107;
        Tue, 29 Mar 2022 04:07:24 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id e203so22089219ybc.12;
        Tue, 29 Mar 2022 04:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DKGDPd33h/ATv4J4XO1IkueCMjSvnZm6IMyLd4ES814=;
        b=EQgZe02QCAY+nUAJ0SZq3XSr76Pwa0LWYCsFzPtNPEsdyZWX/YZDQXl0sSHB56c4mu
         UE4kMswtjyAVryNti07QpKbb3R3H2/8+iJpY+zesF1diqwsB1PjtZAlv0X2ogJ/TYtmV
         ncbzf+VY0n2Ik7V5iA+gGXMdr+0bDOenxA6qm5rOoD4iVPtRHkhDFu3m9/Dokcpl7nay
         YqMLpaV6SrB5vRy+/K4RGymo7BN084l34Fvx18N3s4UaVkgdEfnReJKHmtSndr+E8+jl
         /yJqU9LmScIWoOW4/H9bZUKxayurvgnunlQWP2Qwnc1st8SRTHRKwIs2QlejtvFxdopG
         QqnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DKGDPd33h/ATv4J4XO1IkueCMjSvnZm6IMyLd4ES814=;
        b=dyNbvAzCZxwi+eBScWLQj68ZNRI5PbwlcEFR/3TobWN51q8halAgrVXg4R6oz/xpmh
         xWGuZA73/5/LTXlS4xXfpirZneqin8jXuu+la/cNwhRDVTQQpo4/JCsyxRu8RpLpm7xL
         22RLsuq7kiYPowG6//ywHwwUe92ku1RlvGqvOzGtVerUg6Oy8XIVRpPTdS18I+0GuzbT
         fB92snnBViPdUM6GpJKAUKZwrb6uCnp52NJerZqeFFFzdah2+0HgQ/92eNcTDuG2rlog
         wkaFrgz0bPcJQzbVZo0IUM/6ifU/Vs7LhonAckxDsz9Xr4io9nlyleQUa4VicKxmDmWy
         Aydg==
X-Gm-Message-State: AOAM533at5PLXlgy18qwzpyVWEioR48UPhiNkPJWLxd+N8OFtjKOjqpu
        KvQfgKXoXWdILZEvkQM70Y6WZ6TjKzKsMGQ6qbY=
X-Google-Smtp-Source: ABdhPJxugplLaRknO6i+6leR0kQkRWR95XOSCEZHfh0swZ29OBN2fFErEAmzySovfJhahdvuW1vYDGkOOxk6pQa42R4=
X-Received: by 2002:a5b:906:0:b0:633:93a1:32c4 with SMTP id
 a6-20020a5b0906000000b0063393a132c4mr26481002ybq.376.1648552043867; Tue, 29
 Mar 2022 04:07:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220322115148.3870-1-dharamhans87@gmail.com>
In-Reply-To: <20220322115148.3870-1-dharamhans87@gmail.com>
From:   Dharmendra Hans <dharamhans87@gmail.com>
Date:   Tue, 29 Mar 2022 16:37:12 +0530
Message-ID: <CACUYsyG=RmUkX0b_0_1PmC4B_Oute5DnAf-xxFOr6h95ArPZDg@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] FUSE: Implement atomic lookup + open
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-fsdevel@vger.kernel.org,
        fuse-devel <fuse-devel@lists.sourceforge.net>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 22, 2022 at 5:22 PM Dharmendra Singh <dharamhans87@gmail.com> wrote:
>
> In FUSE, as of now, uncached lookups are expensive over the wire.
> E.g additional latencies and stressing (meta data) servers from
> thousands of clients. These lookup calls possibly can be avoided
> in some cases. Incoming two patches addresses this issue.
>
> First patch handles the case where we open first time a file/dir or create
> a file (O_CREAT) but do a lookup first on it. After lookup is performed
> we make another call into libfuse to open the file. Now these two separate
> calls into libfuse can be combined and performed as a single call into
> libfuse.
>
> Second patch handles the case when we are opening an already existing file
> (positive dentry). Before this open call, we re-validate the inode and
> this re-validation does a lookup on the file and verify the inode.
> This separate lookup also can be avoided (for non-dir) and combined
> with open call into libfuse.
>
> Here is the link to the libfuse pull request which implements atomic open
> https://github.com/libfuse/libfuse/pull/644
>
> I am going to post performance results shortly.
>
>
> Dharmendra Singh (2):
>   FUSE: Implement atomic lookup + open
>   FUSE: Avoid lookup in d_revalidate()

A gentle reminder to look into the above patch set.
