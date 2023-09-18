Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FB2E7A4CB7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Sep 2023 17:39:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbjIRPjf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Sep 2023 11:39:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjIRPjd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Sep 2023 11:39:33 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40E99198C
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Sep 2023 08:36:06 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-52a49a42353so5734531a12.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Sep 2023 08:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1695051206; x=1695656006; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RKiCOByDL96hotvveoALRujHhJ+JRMIfwmxKHnT1o6A=;
        b=lCCp2rQpHmeDqPHd9PBrU/N2aI4HWfxjWGJSBSTaj3+NXywrMPltCrsZoyHHF4LHRK
         nKx6K5y4drZRKI0IdHZ9bwdWO9Ni8wiO73QObtct1rdjiANSAHX3P2ziG/IViE+pt4qU
         u8/TTouck670EAMbWB2yBnteOA3zo1NrhdyOg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695051206; x=1695656006;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RKiCOByDL96hotvveoALRujHhJ+JRMIfwmxKHnT1o6A=;
        b=IDrTve3PeVDXSKEXujE2t0pT2ObjprEK3PYfFLo4mxObmtvQQiADxbtOEjlbEzYaAt
         lY5x0+dSlPQgRkePwujavri0KrStK/kWF24XTNeyLxTBxnDXU/kITWXdqytAC218VhcY
         A0vLHVlPXq1fQqXiWnve6092gBppRvC2EsCrD3gVdUzKV8oFtscTSyTc1qN1k0gapR3H
         igJpkah+pd/NEDPvdXCNAuftda++vKzRsDGQnyuhCts9+F5VP/TOJZP/rFvHt1MQInl6
         BGRIOLSr4m6IIcNBohe75ulRyGzoPkOCOExcO9s62oto2hdbC4iO1npaYR5t+ReoQGbn
         xr1Q==
X-Gm-Message-State: AOJu0YwQbYVNWXYwijiSIUic+jWbxzCBngK8dXksktJkbaMV7uLIJAgT
        MU7JGQBE91dY+GdXBW1K29cnEtGJpGepyXUuuN/JPFAOhOlKYbXA
X-Google-Smtp-Source: AGHT+IFIEvXbEUkU+mxN2F/R/tIeFBRSysj5+zBZP+k60Jl/lHiG5m9DX+A4lurODy2hOWFB3ngj7hncFNBhvH4RRiY=
X-Received: by 2002:a17:906:3102:b0:99c:e38d:e484 with SMTP id
 2-20020a170906310200b0099ce38de484mr8115574ejx.6.1695047562459; Mon, 18 Sep
 2023 07:32:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230913152238.905247-1-mszeredi@redhat.com> <20230913152238.905247-3-mszeredi@redhat.com>
 <20230914-salzig-manifest-f6c3adb1b7b4@brauner> <CAJfpegs-sDk0++FjSZ_RuW5m-z3BTBQdu4T9QPtWwmSZ1_4Yvw@mail.gmail.com>
 <20230914-lockmittel-verknallen-d1a18d76ba44@brauner> <CAJfpegt-VPZP3ou-TMQFs1Xupj_iWA5ttC2UUFKh3E43EyCOQQ@mail.gmail.com>
 <20230918-grafik-zutreffen-995b321017ae@brauner> <CAOssrKfS79=+F0h=XPzJX2E6taxAPmEJEYPi4VBNQjgRR5ujqw@mail.gmail.com>
 <20230918-hierbei-erhielten-ba5ef74a5b52@brauner>
In-Reply-To: <20230918-hierbei-erhielten-ba5ef74a5b52@brauner>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 18 Sep 2023 16:32:30 +0200
Message-ID: <CAJfpegtaGXoZkMWLnk3PcibAvp7kv-4Yobo=UJj943L6v3ctJQ@mail.gmail.com>
Subject: Re: [RFC PATCH 2/3] add statmnt(2) syscall
To:     Christian Brauner <brauner@kernel.org>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-man@vger.kernel.org,
        linux-security-module@vger.kernel.org, Karel Zak <kzak@redhat.com>,
        Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Amir Goldstein <amir73il@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 18 Sept 2023 at 16:25, Christian Brauner <brauner@kernel.org> wrote:

> The system call should please have a proper struct like you had in your
> first proposal. This is what I'm concerned about:
>
> int statmount(u64 mnt_id,
>               struct statmnt __user *st,
>               size_t size,
>               unsigned int flags)
>
> instead of taking an void pointer.

So you are not concerned about having ascii strings returned by the
syscall?   I thought that was the main complaint.

Thanks,
Miklos
