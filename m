Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68281523F7A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 May 2022 23:33:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348178AbiEKVdm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 May 2022 17:33:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348137AbiEKVdk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 May 2022 17:33:40 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D5E172211
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 May 2022 14:33:38 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id s30so6369199ybi.8
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 May 2022 14:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5RG02r69eZnKTp9Uzlr2A3sSYsmG309qXgqnZxLCnOc=;
        b=ZrW1SBuyknTH0Pvt02TKD642XSK4dDYF44OjGQ0VBMY4sqk8wmxHJjX1Sq/cLJLTEy
         ZRo1N2cbFel7Rt1paK08Ddr/wL4a+R4+RWkVw3ZDGEv6TDV1RcMP3sse78Qo6IOf56cr
         tmGyd+/mxw6P1s0u6L9aQ9Ss0V1HFUr7Oqnrk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5RG02r69eZnKTp9Uzlr2A3sSYsmG309qXgqnZxLCnOc=;
        b=4GN/F1Vm20FUOp40V7HnJ1ClSeRoLCpSj0a5w3c9ktXDVv5gs7TbBByBv31p5Mmtuk
         gWJhA3UaREvWqHoiEqGhQXj5Ace/ZrfA5pFzQ+mnnz8CRlCFYEyNYvBUNh227EiBXmzp
         eeqchml3bnAxiZBF87MfczSCBHqNY50Rtka2ifEr+rfNpTT9MyKukwKlXpSDV6HQUXOe
         pIcbKCmAg0h2uy1QYSc/ASsFiNFJNxXjHCSwUfTcqIqFeWz0uAeGlU1oMd4bGizNEIjb
         72HNOVh/+NUZ0IyRWPJJ1eqYK3pxKHNoyhZAB0Lk/kN2SXmQzpgTH2IAHQyAuFOWXPUI
         Lq2A==
X-Gm-Message-State: AOAM5325MU6Jy/WSlcUaMK2DKeIIrYSaX9dNKsQ7kk9uns6DvncCT52O
        VDHq4INarKBSTVRUIBIdA5QlSr3N6Zq/14hQ/zAgXbsQscNWmw==
X-Google-Smtp-Source: ABdhPJzEB57fAMxgOo9ba2pK7f/rTinG6jPYMk20py7TIAICbHPPVFQCBw04WKIepQxKEdocoDhnMK4io1vjkVbiSgY=
X-Received: by 2002:a25:2a4c:0:b0:648:6a80:9cff with SMTP id
 q73-20020a252a4c000000b006486a809cffmr26542192ybq.507.1652304817908; Wed, 11
 May 2022 14:33:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220511013057.245827-1-dlunev@chromium.org> <20220511113050.1.Ifc059f4eca1cce3e2cc79818467c94f65e3d8dde@changeid>
 <YnvOFt3sC/XLJj05@infradead.org>
In-Reply-To: <YnvOFt3sC/XLJj05@infradead.org>
From:   Daniil Lunev <dlunev@chromium.org>
Date:   Thu, 12 May 2022 07:33:27 +1000
Message-ID: <CAONX=-cW9Or1eEVUg3H669tEDW+1v16zZUGRQCaF3DAuLmgFvw@mail.gmail.com>
Subject: Re: [PATCH 1/2] fs/super: Add a flag to mark super block defunc
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, fuse-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 12, 2022 at 12:54 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Wed, May 11, 2022 at 11:30:56AM +1000, Daniil Lunev wrote:
> > File system can mark a block "defunc" in order to prevent matching
> > against it in a new mount.
>
> Why use a bool instead of using s_iflags?
Oh, I was looking at the flag field, but for some reason got confused
about its values.
Looking again, I totally can use it. However, the other option, that
Miklos proposed in
a thread on the cover letter mail, is to remove the superblock from
"type->fs_supers".
I plan to upload a new version with that option. Which of those two
would you prefer?

> Also I suspect we should never reuse a force mounted superblock,
> but at least for block devices we should also not allow allocating
> a new one for that case but just refuse the mount.
Re-use of a force unmounted superblock "just works" for at least ext4
- in fact, it
continues to work as if nothing happened to it. Changing that may
break existing use
cases. For FUSE that unfortunately unachievable, given the daemon is
disconnected
from the driver and likely killed after force unmount, but ability to
re-mount is essential,
because force unmount is the only way to reliably achieve suspend
while using FUSE,
and if re-mount doesn't work, the connected device/share is missing
after resume.

Thanks,
Daniil
