Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFA7C5ED08B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Sep 2022 00:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231218AbiI0W4Y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Sep 2022 18:56:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231854AbiI0W4S (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Sep 2022 18:56:18 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 283B67C193
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Sep 2022 15:56:17 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-13189cd5789so3454645fac.11
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Sep 2022 15:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=wyC+RoEDm1jv0hcPmvajVRxuKFukHJTmHOpngfukKvE=;
        b=41u3I7a/ypmysIlJd8ed6zlUqoSqln1wdcpuT3KnvaYnOFtlFXlKkTKEjLX4IaVDjW
         XsjqFwDAWwi7GITtO2dE1roCTwPqIOyqO7l5iQt/MvskWodZp9KrxjsmPD5vOJE4wA2g
         4jxTSSOqfgAra+c/e91bjsHspW5y11ci8tq5a0Wnpqxi7ZhBOq6bvZBqdwUriS+JGUPx
         2qUOpslpCruV2iFXTcIz+a4M6SC6ecMinCX15bfqoYShdBVR/stkjycZvp2qbOk3vH18
         z1p8hAGdxL8I6UYnXtouZl1jtXqFT1d3PUburozPU4aVwYv4UE6i0h4sfbm019i0xmtN
         STIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=wyC+RoEDm1jv0hcPmvajVRxuKFukHJTmHOpngfukKvE=;
        b=cfIjKTtqLm9lR37fCMdOjUb5daO8/5w6K5qLkS7v88w7lQVRY0aDZh5T0gNJzYaqF+
         F4HL1z7PzKCc5aFZyrpnIpjT1xzCgAVbLhdW9hwpd5iLa9l54W59JIkz1c1t8KHsbEX1
         q26qVryUjdVJJTEzGoFhdFIRh5vo9u6KJ6ap7lLEqLB7La1K0LJt/9zsPjcb2Xm/NWjz
         DTTQ0YGN7bkz6AD86nqYEmEAx/wQ993cCVEcKthORPrNSiJPkw3cwUNR7PFgw5P/Ezzf
         qHm87Ljnm4N4C/LbjlCUKWjG7wFdMxlZsXC9TzFnuih5bW5PNcFNL7yUq0sE1AqezCNr
         elIg==
X-Gm-Message-State: ACrzQf14t24QwLPirgxLMPXcS0B0kfc776VWP99HS2kiKFCSTU2W72Jp
        JD3EJQvMdx/Cmbdy4HmZce98ZHrKC4zyGv3mE9fc
X-Google-Smtp-Source: AMsMyM5+MJ0DaYjRiVk4sJCybKPERtl6DaDmb9wo9Us5sDHNbBw2V7CtM8wkbNIxap8GrpiPE/CuKgfTDDIpQMdG3JA=
X-Received: by 2002:a05:6870:a916:b0:131:9361:116a with SMTP id
 eq22-20020a056870a91600b001319361116amr1942781oab.172.1664319376455; Tue, 27
 Sep 2022 15:56:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220926140827.142806-1-brauner@kernel.org> <20220926140827.142806-13-brauner@kernel.org>
In-Reply-To: <20220926140827.142806-13-brauner@kernel.org>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 27 Sep 2022 18:56:05 -0400
Message-ID: <CAHC9VhSOj4vUXbDPHEvi-8WgE=roGNg2Y9RTAdg=3R2zOk69Aw@mail.gmail.com>
Subject: Re: [PATCH v2 12/30] smack: implement set acl hook
To:     Christian Brauner <brauner@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, Seth Forshee <sforshee@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Casey Schaufler <casey@schaufler-ca.com>,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 26, 2022 at 11:24 AM Christian Brauner <brauner@kernel.org> wrote:
>
> The current way of setting and getting posix acls through the generic
> xattr interface is error prone and type unsafe. The vfs needs to
> interpret and fixup posix acls before storing or reporting it to
> userspace. Various hacks exist to make this work. The code is hard to
> understand and difficult to maintain in it's current form. Instead of
> making this work by hacking posix acls through xattr handlers we are
> building a dedicated posix acl api around the get and set inode
> operations. This removes a lot of hackiness and makes the codepaths
> easier to maintain. A lot of background can be found in [1].
>
> So far posix acls were passed as a void blob to the security and
> integrity modules. Some of them like evm then proceed to interpret the
> void pointer and convert it into the kernel internal struct posix acl
> representation to perform their integrity checking magic. This is
> obviously pretty problematic as that requires knowledge that only the
> vfs is guaranteed to have and has lead to various bugs. Add a proper
> security hook for setting posix acls and pass down the posix acls in
> their appropriate vfs format instead of hacking it through a void
> pointer stored in the uapi format.
>
> I spent considerate time in the security module infrastructure and
> audited all codepaths. Smack has no restrictions based on the posix
> acl values passed through it. The capability hook doesn't need to be
> called either because it only has restrictions on security.* xattrs. So
> this all becomes a very simple hook for smack.
>
> Link: https://lore.kernel.org/all/20220801145520.1532837-1-brauner@kernel.org [1]
> Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
> ---
>
> Notes:
>     /* v2 */
>     unchanged
>
>  security/smack/smack_lsm.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)

Reviewed-by: Paul Moore <paul@paul-moore.com>

--
paul-moore.com
