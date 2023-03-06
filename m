Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A7CE6AC7F9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Mar 2023 17:31:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbjCFQbt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Mar 2023 11:31:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbjCFQbp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Mar 2023 11:31:45 -0500
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECFBB37B74
        for <linux-fsdevel@vger.kernel.org>; Mon,  6 Mar 2023 08:31:10 -0800 (PST)
Received: by mail-ed1-f49.google.com with SMTP id x3so40958495edb.10
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Mar 2023 08:31:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1678120158;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=24/5jEnRxS77JLQYP3KCQkPVfdQcMFrYWM1aG3/d1pI=;
        b=Ch5slAUq6/xAU49zbWLrSHfiQ1nbUwCLMM7MUtYcp7fzzH62f42CWdlCZDS1rqyYY5
         2Ij+Dv+kP13RmaXHWfVqsiZZRdHqlETzjA8CzfKc8K3EryE02OdhhVRCmhX0N00yG2o9
         Fs/oaIqDDBHN/WFjcnGSUh2rY7oe5SeewNi6c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678120158;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=24/5jEnRxS77JLQYP3KCQkPVfdQcMFrYWM1aG3/d1pI=;
        b=JdggxyqrmhdVMEaEd8NcyGAKMhpTdWLKk06Q0F2iVZ/S7gchdJDtiPctsiI3j7VfGg
         UAP2LBZLvAmQYc8OymmDODsiKWQmb8/bsu5JJxOiLEqG3xGAP6ab8Qrrk8+wZNdjUJe0
         LWetEfyIb3j8z7aRbX6/L0MCVwFoa1QIU8WUJ7fQmVwHP9RqqmiKO909doeOIh1OYMtC
         MyTA5Y6uoFOqoufD/IwPkEi6GPm3HMGZj039WVc6zk5350MQjnYQJKWNMw+WXO/zCxWq
         TFqwaEkcS8FSRdSu8wMxq9UrMKIdYhg3vYxscKSqCuNs9/K6txefu07DO7BtZb1hWYJ+
         4Psw==
X-Gm-Message-State: AO0yUKVMSUp/A6j9np0CUqmkVV18QZsVkwE9DEn1ArcxSxuynDntaiFi
        Y19hNw/ZtbJR3dh3ZXiC56CYS4GQoNdIpAlXPuAYrPepRs+suWiQSjo=
X-Google-Smtp-Source: AK7set+qf7SFHAiNCIIe/y2arjCq+xoMRnPLuL+4ZvciprziaazTRftUVKg5erVzTHvqsyeGD4McJbOrI6XpkJdcSM0=
X-Received: by 2002:a17:906:d041:b0:877:747d:4a82 with SMTP id
 bo1-20020a170906d04100b00877747d4a82mr5503308ejb.0.1678119310195; Mon, 06 Mar
 2023 08:15:10 -0800 (PST)
MIME-Version: 1.0
References: <20230220193754.470330-1-aleksandr.mikhalitsyn@canonical.com>
In-Reply-To: <20230220193754.470330-1-aleksandr.mikhalitsyn@canonical.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 6 Mar 2023 17:14:59 +0100
Message-ID: <CAJfpegvQyD-+EL2DdVWmyKF8odYWj4kAONyRf6VH_h4JCTu=vg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/9] fuse: API for Checkpoint/Restore
To:     Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Cc:     mszeredi@redhat.com, Al Viro <viro@zeniv.linux.org.uk>,
        Amir Goldstein <amir73il@gmail.com>,
        =?UTF-8?Q?St=C3=A9phane_Graber?= <stgraber@ubuntu.com>,
        Seth Forshee <sforshee@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Andrei Vagin <avagin@gmail.com>,
        Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        criu@openvz.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 20 Feb 2023 at 20:38, Alexander Mikhalitsyn
<aleksandr.mikhalitsyn@canonical.com> wrote:
>
> Hello everyone,
>
> It would be great to hear your comments regarding this proof-of-concept Checkpoint/Restore API for FUSE.
>
> Support of FUSE C/R is a challenging task for CRIU [1]. Last year I've given a brief talk on LPC 2022
> about how we handle files C/R in CRIU and which blockers we have for FUSE filesystems. [2]
>
> The main problem for CRIU is that we have to restore mount namespaces and memory mappings before the process tree.
> It means that when CRIU is performing mount of fuse filesystem it can't use the original FUSE daemon from the
> restorable process tree, but instead use a "fake daemon".
>
> This leads to many other technical problems:
> * "fake" daemon has to reply to FUSE_INIT request from the kernel and initialize fuse connection somehow.
> This setup can be not consistent with the original daemon (protocol version, daemon capabilities/settings
> like no_open, no_flush, readahead, and so on).
> * each fuse request has a unique ID. It could confuse userspace if this unique ID sequence was reset.
>
> We can workaround some issues and implement fragile and limited support of FUSE in CRIU but it doesn't make any sense, IMHO.
> Btw, I've enumerated only CRIU restore-stage problems there. The dump stage is another story...
>
> My proposal is not only about CRIU. The same interface can be useful for FUSE mounts recovery after daemon crashes.
> LXC project uses LXCFS [3] as a procfs/cgroupfs/sysfs emulation layer for containers. We are using a scheme when
> one LXCFS daemon handles all the work for all the containers and we use bindmounts to overmount particular
> files/directories in procfs/cgroupfs/sysfs. If this single daemon crashes for some reason we are in trouble,
> because we have to restart all the containers (fuse bindmounts become invalid after the crash).
> The solution is fairly easy:
> allow somehow to reinitialize the existing fuse connection and replace the daemon on the fly
> This case is a little bit simpler than CRIU cause we don't need to care about the previously opened files
> and other stuff, we are only interested in mounts.
>
> Current PoC implementation was developed and tested with this "recovery case".
> Right now I only have LXCFS patched and have nothing for CRIU. But I wanted to discuss this idea before going forward with CRIU.

Apparently all of the added mechanisms (REINIT, BM_REVAL, conn_gen)
are crash recovery related, and not useful for C/R.  Why is this being
advertised as a precursor for CRIU support?

BTW here's some earlier attempt at partial recovery, which might be interesting:

  https://lore.kernel.org/all/CAPm50a+j8UL9g3UwpRsye5e+a=M0Hy7Tf1FdfwOrUUBWMyosNg@mail.gmail.com/

Thanks,
Miklos
