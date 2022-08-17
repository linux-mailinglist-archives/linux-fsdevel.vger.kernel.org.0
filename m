Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C3BA5979B5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Aug 2022 00:33:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238519AbiHQWcc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Aug 2022 18:32:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239084AbiHQWc2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Aug 2022 18:32:28 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCFB0AB4D1;
        Wed, 17 Aug 2022 15:32:27 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id s11so19250586edd.13;
        Wed, 17 Aug 2022 15:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=Gv4gm91440ebvebATmvsp5+QkrmOMcql3PcMRw1CSds=;
        b=Pvn+0+y8ZjVKefEP96ynW4izTjZEWhveap9rRu2sMuArVPQxUYXbhX16n434AWb3Ry
         iUMT12EJWUUEMXMdiirv+sfUGlU9w22kYu7U9XqcmA2WFdnJWWTjXeBC+HI7weslobUp
         lVDV/lhZrNu6mPhyN66b54TxCR0e87DlIbrxzhv0PdGEr+iVIgxB3Fp9hFomq/KXPqH5
         FszUTqCZIJpdekYG2GV63h1zBm723beLmgUwkgt+w64GfmHCNVNEa1IJkNQHh5WZcWvq
         XCI9gJbwkr002m/CQ+DZznhVj2t/geIexeauSIQrjimZrgB2khKRT+VvRyOegPlp/v07
         nWGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=Gv4gm91440ebvebATmvsp5+QkrmOMcql3PcMRw1CSds=;
        b=erEfGLprC7hz65aHufd5U2V2ssuaI/PcCHW9udamRjCFjO/3VcB4yVesEF/weEYwgI
         jZKL1jLv1cJEngcxIxuGc00Z84FZF4Cvt9KXDic7B2DGe+LSGGZH5gSKKeurgy/7VFRb
         RzMlC103xGA8t569YMuNv/Mrsj4djYb2Y71gQOk6LSjPOLrmnX5GBHmKgM6sKRfvB5Sc
         Bd2cyREBENKgo1mrp5Ay2KdaEZlD36uJAg5+Esl9HNm7wEhqvpB7iSxoDebPTtbKyDG3
         B3tU7choN/32W2t4v7uAh9VHlaHZIvn/YEDmYIMMndn5oQSX0unttPGGth94VPRSpQdD
         fFig==
X-Gm-Message-State: ACgBeo0CctVGifackoykyTPSRqhoFfzqj+1woIo9Pk+mzmiOA4IniBxA
        U83F+lFNMqESy64wa2jBkDzYSfpnswWiHl1a/g2W6Wow
X-Google-Smtp-Source: AA6agR7lc2bIlRempqenBeZsBXIRGrXTaNgK1Co1ojN1WwxbTiz9z3Kx+sVdNq/z8frPwspuPuge9JmobZSBPGDPX2Q=
X-Received: by 2002:a05:6402:40c2:b0:440:4ecd:f75f with SMTP id
 z2-20020a05640240c200b004404ecdf75fmr134536edb.405.1660775546111; Wed, 17 Aug
 2022 15:32:26 -0700 (PDT)
MIME-Version: 1.0
References: <Yv1jwsHVWI+lguAT@ZenIV>
In-Reply-To: <Yv1jwsHVWI+lguAT@ZenIV>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Wed, 17 Aug 2022 18:32:15 -0400
Message-ID: <CAN-5tyFvV7QOxyAQXu3UM5swQVB2roDpQ5CBRVc64Epp1gj9hg@mail.gmail.com>
Subject: Re: [RFC] problems with alloc_file_pseudo() use in __nfs42_ssc_open()
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>,
        Olga Kornievskaia <kolga@netapp.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 17, 2022 at 6:18 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
>         My apologies for having missed that back when the SSC
> patchset had been done (and missing the problems after it got
> merged, actually).
>
> 1) if this
>         r_ino = nfs_fhget(ss_mnt->mnt_sb, src_fh, fattr);
> in __nfs42_ssc_open() yields a directory inode, we are screwed
> as soon as it's passed to alloc_file_pseudo() - a *lot* of places
> in dcache handling would break if we do that.  It's not too
> nice for a regular file from non-cooperating filesystem, but for
> directory ones it's deadly.

This inode is created to make an appearance of an opened file to do
(an NFS) read, it's never a directory.

> 2) if alloc_file_pseudo() fails there, we get an inode leak.  It
> needs an iput() for that case.  As in
>         if (IS_ERR(filep)) {
>                 res = ERR_CAST(filep);
>                 iput(r_ino);
>                 goto out_free_name;
>         }
>
> But I'd like to point out that alloc_file_pseudo() is not inteded for
> use on normal filesystem's inodes - the use here *mostly* works
> (directories aside), but...  Use it on filesystem with non-trivial
> default dentry_operations and things will get interesting, etc.
