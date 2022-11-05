Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5596B61A784
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Nov 2022 05:39:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbiKEEjM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 5 Nov 2022 00:39:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiKEEjL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 5 Nov 2022 00:39:11 -0400
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E87A4317E6
        for <linux-fsdevel@vger.kernel.org>; Fri,  4 Nov 2022 21:39:09 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-13be3ef361dso7545541fac.12
        for <linux-fsdevel@vger.kernel.org>; Fri, 04 Nov 2022 21:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QVhCjTiXsm0XAmH+YRM1X339ickLF/GL0sKIvePwac0=;
        b=FCSnsB+Ncbn05GHt62BXuzIBr4rsH97IiQeiye272VEDnNBybqlEYM6y/waq3nV71X
         KaiiJRqUZTcnkEtCXHhVXzAmNgTVDOFb0BYeit0BPiJhk79dMcjE/vceD3btbG/nkPML
         Sm3DZk4p55e3hOTDWHNnf21GfDhgAx0bVHpoV0VyYDI1lXMoPQT8hyTC9bHRPciw8JpY
         eZ3sDpBvLCFakfNbS83WC96gEQjxzBIVJj5pWpvD6FPndHyIGhQPp6LOCChKqMqdnq/j
         QMd8VSRtjkvDQKWcnjd0BXbzYUlGxA6LG1Sxr6sSwrBkaa0Rl3aJHijXxEDFqV3gIa+K
         d1Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QVhCjTiXsm0XAmH+YRM1X339ickLF/GL0sKIvePwac0=;
        b=iHBhHpSUKPYpVCOyE7uys2AQPOe36MtQhiobYeWenqYgHfA3QpuKRMo1rERodzffcu
         WhmtSdYi/GRowqDG/dEgFYmSE7WYcMBcbA3nhJpLQxMPxaBD90JdSmMRkU44yILfwiCM
         IgLZZxSdFUhUuyjdzQxMtzJXgJPUZSbkwB5ygVE+BVvJzQ76p0S6d9OTfssXHVeF69WF
         E3dv/+cyglTgl/wTkDzKVziizD/UT16EcgmisUdLX+diJGsphT73qYZ/JN719lgVKk0n
         KWTvSrmRUwNEYc5CqpjmpXF+Gxhq8pDZJ8KcPFgRBkOJix1ocYk5Hs1z+f2f6SQOA5hO
         X9uQ==
X-Gm-Message-State: ACrzQf1N2ypie4PaTpaKYfSPxUrqbPiCWZnrvC832GGnn9gijodbcLjN
        FT7SdtXD0AbrFtWcQR8VmJQDpQdslLou3GFvwWuJ
X-Google-Smtp-Source: AMsMyM4w7eiFkYBhePubE/PyYhcqGdnaotz0NDTczdH13Aq1WqMXxNy3Sb/YZHqSax4NIV/jSYcVfTpPs875XiKcH8E=
X-Received: by 2002:a05:6870:f299:b0:13b:ad21:934d with SMTP id
 u25-20020a056870f29900b0013bad21934dmr23511755oap.172.1667623149267; Fri, 04
 Nov 2022 21:39:09 -0700 (PDT)
MIME-Version: 1.0
References: <20221103151205.702826-1-omosnace@redhat.com>
In-Reply-To: <20221103151205.702826-1-omosnace@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Sat, 5 Nov 2022 00:38:57 -0400
Message-ID: <CAHC9VhS460B4Jpk8kqmhTBZv_dMuysNb9yH=6hB4-+Oc35UkAQ@mail.gmail.com>
Subject: Re: [PATCH v2] fs: don't audit the capability check in simple_xattr_list()
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org, Martin Pitt <mpitt@redhat.com>,
        Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Nov 3, 2022 at 11:13 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> The check being unconditional may lead to unwanted denials reported by
> LSMs when a process has the capability granted by DAC, but denied by an
> LSM. In the case of SELinux such denials are a problem, since they can't
> be effectively filtered out via the policy and when not silenced, they
> produce noise that may hide a true problem or an attack.
>
> Checking for the capability only if any trusted xattr is actually
> present wouldn't really address the issue, since calling listxattr(2) on
> such node on its own doesn't indicate an explicit attempt to see the
> trusted xattrs. Additionally, it could potentially leak the presence of
> trusted xattrs to an unprivileged user if they can check for the denials
> (e.g. through dmesg).
>
> Therefore, it's best (and simplest) to keep the check unconditional and
> instead use ns_capable_noaudit() that will silence any associated LSM
> denials.
>
> Fixes: 38f38657444d ("xattr: extract simple_xattr code from tmpfs")
> Reported-by: Martin Pitt <mpitt@redhat.com>
> Suggested-by: Christian Brauner (Microsoft) <brauner@kernel.org>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>
> v1 -> v2: switch to simpler and better solution as suggested by Christian
>
> v1: https://lore.kernel.org/selinux/CAFqZXNuC7c0Ukx_okYZ7rsKycQY5P1zpMPmmq_T5Qyzbg-x7yQ@mail.gmail.com/T/
>
>  fs/xattr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

VFS folks, this should really go through a vfs tree, but if nobody
wants to pick it up *and* there are no objections to the change, I can
take this via the LSM tree.

Reviewed-by: Paul Moore <paul@paul-moore.com>

-- 
paul-moore.com
