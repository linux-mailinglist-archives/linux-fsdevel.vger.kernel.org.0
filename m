Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31CB5740386
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jun 2023 20:42:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbjF0Smb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jun 2023 14:42:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjF0Sma (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jun 2023 14:42:30 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C55610FE;
        Tue, 27 Jun 2023 11:42:29 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id 5614622812f47-3a0423ea749so3950862b6e.0;
        Tue, 27 Jun 2023 11:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687891349; x=1690483349;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5QW7db0ayiyIii0yaz366+aZQikC9TPomjktNVfLgKA=;
        b=lTr0hPUu+VSVtxwnzjFuIRI9fc2sezvUzFVC3QJLaIUaPBLttHamZsk0+Na3/KhHum
         T1GmICHTIIx7C8O4sKGGK/ME2bplCuDjHc0yJC/t/ECBWLFqR8IOPaDtfAUm6IJWis8p
         E+mZ6PcUkk8PlwmxtxskER3VPhYzmBW8U+9EI0mUotQw7jiwQkev/lxkpGr/n0mGzPQQ
         dodKIJVJGzSXEi0kYRhOFE5eu+uvvEemXy30zh6pKiqN2jepRPZUbd7lU9BwpLLHOjXH
         rRt/Au0fKNeDsWkF1ix2x+SOUPNHd0mIQd1uZwRLaPbUIajqifgjIfOysAm2KmQKl46A
         TXaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687891349; x=1690483349;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5QW7db0ayiyIii0yaz366+aZQikC9TPomjktNVfLgKA=;
        b=eZ9Tn6GRUnMnsGS/ui9+whIkst60SA30EihE9rd3PE0UYK5X5+dSCen1usAeRqQUdz
         y2wqOqkNc7dKt0faMpcO+Bs+1AxpUyKTKjfpYFHuYesUXJrca8BUmZDKzZI+Z4tXP7fD
         OVjNU288hqwztdqwGskB/CEMDSfFIwD1ZaTDH+p8XcRBNtNEw8yVFIDIZyyK6AlaKJRU
         cx3DP0B41VTcLfO8Xq4Bzac+3e7AbhGqhtvjXFeBh1WAdEeZ5ng8LEM2iqjmR8US5HiB
         gss5qUGY167FiIX+65KF9wZ1wSTQwlXq2xyjfNFShP/vEJg5JDMNJAnpTMRyo6Mbbfnr
         jf6w==
X-Gm-Message-State: AC+VfDwI251HV+EzAHW5d0k3aoDrhG/Oi8KMIR73OQfBqc5jrtu4jeMt
        v4rRGAXXVFbYKdP5IBmGXgg=
X-Google-Smtp-Source: ACHHUZ6Nem7zk+ecNK+zPI3edbqWlsf/eKM6nf8cVKttdKKTAVbChIQpM1KyrDscALmG9R98ekyIWg==
X-Received: by 2002:a05:6808:2202:b0:3a1:aa90:d486 with SMTP id bd2-20020a056808220200b003a1aa90d486mr19289571oib.26.1687891348535;
        Tue, 27 Jun 2023 11:42:28 -0700 (PDT)
Received: from localhost (dhcp-72-235-13-41.hawaiiantel.net. [72.235.13.41])
        by smtp.gmail.com with ESMTPSA id 14-20020a630b0e000000b0054fb537ca5dsm5919490pgl.92.2023.06.27.11.42.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 11:42:27 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 27 Jun 2023 08:42:28 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Suren Baghdasaryan <surenb@google.com>, gregkh@linuxfoundation.org,
        peterz@infradead.org, lujialin4@huawei.com,
        lizefan.x@bytedance.com, hannes@cmpxchg.org, mingo@redhat.com,
        ebiggers@kernel.org, oleg@redhat.com, akpm@linux-foundation.org,
        viro@zeniv.linux.org.uk, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH 1/2] kernfs: add kernfs_ops.free operation to free
 resources tied to the file
Message-ID: <ZJstlHU4Y3ZtiWJe@slm.duckdns.org>
References: <20230626201713.1204982-1-surenb@google.com>
 <ZJn1tQDgfmcE7mNG@slm.duckdns.org>
 <20230627-kanon-hievt-bfdb583ddaa6@brauner>
 <CAJuCfpECKqYiekDK6Zw58w10n1T4Q3R+2nymfHX2ZGfQVDC3VQ@mail.gmail.com>
 <20230627-ausgaben-brauhaus-a33e292558d8@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230627-ausgaben-brauhaus-a33e292558d8@brauner>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello, Christian.

On Tue, Jun 27, 2023 at 07:30:26PM +0200, Christian Brauner wrote:
...
> ->release() was added in
> 
>     commit 0e67db2f9fe91937e798e3d7d22c50a8438187e1
>     kernfs: add kernfs_ops->open/release() callbacks
> 
>     Add ->open/release() methods to kernfs_ops.  ->open() is called when
>     the file is opened and ->release() when the file is either released or
>     severed.  These callbacks can be used, for example, to manage
>     persistent caching objects over multiple seq_file iterations.
> 
>     Signed-off-by: Tejun Heo <tj@kernel.org>
>     Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>     Acked-by: Acked-by: Zefan Li <lizefan@huawei.com>
> 
> which mentions "either releases or severed" which imho already points to
> separate methods.

This is because kernfs has revoking operation which doesn't exist for other
filesystems. Other filesystem implemenations can't just say "I'm done. Bye!"
and go away. Even if the underlying filesystem has completely failed, the
code still has to remain attached and keep aborting operations.

However, kernfs serves as the midlayer to a lot of device drivers and other
internal subsystems and it'd be really inconvenient for each of them to have
to implement "I want to go away but I gotta wait out this user who's holding
onto my tuning knob file". So, kernfs exposes a revoke or severing semantics
something that's exposing interface through kernfs wants to stop doing so.

If you look at it from file operation implementation POV, this seems exactly
like ->release. All open files are shutdown and there won't be any future
operations. After all, revoke is forced closing of all fd's. So, for most
users, treating severing just like ->release is the right thing to do.

The PSI file which caused this is a special case because it attaches
something to its kernfs file which outlives the severing operation bypassing
kernfs infra. A more complete way to fix this would be supporting the
required behavior from kernfs side, so that the PSI file operates on kernfs
interface which knows the severing event and detaches properly. That said,
currently, this is very much an one-off.

Suren, if you're interested, it might make sense to pipe poll through kernfs
properly so that it has its kernfs operation and kernfs can sever it. That
said, as this is a fix for something which is currently causing crashes,
it'd be better to merge this simpler fix first no matter what.

Thanks.

-- 
tejun
