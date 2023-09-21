Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D07A7A9BE9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Sep 2023 21:05:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbjIUTFM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Sep 2023 15:05:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbjIUTEN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Sep 2023 15:04:13 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75644D37E4
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Sep 2023 11:24:05 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-53fa455cd94so871058a12.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Sep 2023 11:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695320645; x=1695925445; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IzcIbR6ZTtU72k6SCIVUKF64hyLwrfymLfTYubaE3wc=;
        b=j6ZGtkkf+/Ls5SieU4EcUEZRH9t4iHomj3vZRjqLt/WTB6nyXsrKUMk+IEYzalq5Hg
         wRCLwuN4k3rFMB9EmWde2iHru9HmhiPyJQ5XVmZMEWaICmerpEMt3luaKZtKLBWOewAd
         Deuz/TKMJ8U2Y8MXgLM0ckA2RvTKzC23OcQRUfTmZjjAk7DeuNAVk6YeIKDoZY6rz3iP
         C3jgdYWBZmlx/ylFvAPc4SRjyheX5vifTs7rtCVr26NUpfjasQCQnXWPm9E4GhrT9+HJ
         X4BDEtnyKroy/5LA9cikDOLYfRxHm7ng13P9NnHLgEucX2FbHKvhWdyy29ofYh3AyqZj
         FaIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695320645; x=1695925445;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IzcIbR6ZTtU72k6SCIVUKF64hyLwrfymLfTYubaE3wc=;
        b=jo2m74AznMx9zf8zXXTFvy+JN0J4ny9X3HoDAwbukuDMwxLTA6m+QDLyQ+NRdQmioE
         MwnwVR5wM9EPm3qmDGP70QcpFi09GukEu/dAGugGx2EYNO65IPMmFEzgc9hQdnnWGvrc
         DxFtRApj7jcv24bykbnlvTHV7QHACJuxoBompEz6XW67f8XMnm9vG3XwZaXQfHsR+nH1
         JOnWHeXYCCVy8gX7TZ2yZJzVLymxEgoy3FXMu/U7ZTP1lg+R3Ik5a9VSR3hHiuN2XRhE
         Ge8blm79fhAs58aIt+bMUdExIa8CvMshQKHCUN3bzMkFtHEwzpDYfUYwVkhfwGy+3r2t
         o2Mw==
X-Gm-Message-State: AOJu0YzECOYeEstS2KMQsJh5mZJ/iaajlbYATcGG8GW27JTUGwkV1WGl
        M3f8p4W0tQp7xm59ocucyO/sgWR7+NDsbHgMLWgaC/0PN4k=
X-Google-Smtp-Source: AGHT+IGq507Mr8505e3ysTpjl6Zda1ORUscWQb5fOYIL2DrnAkW4/O28sONgufzKiv1vZsfrB04TNLRl3WnSa14DOo0=
X-Received: by 2002:a67:fb02:0:b0:452:81b3:4b06 with SMTP id
 d2-20020a67fb02000000b0045281b34b06mr5299701vsr.4.1695288846993; Thu, 21 Sep
 2023 02:34:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230920173445.3943581-1-bschubert@ddn.com>
In-Reply-To: <20230920173445.3943581-1-bschubert@ddn.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 21 Sep 2023 12:33:56 +0300
Message-ID: <CAOQ4uxi+jk7rv7mtnpH4RXbZJx6N+cWecqd3UyJJHsW8yw_SXg@mail.gmail.com>
Subject: Re: [PATCH v9 0/7] fuse: full atomic open and atomic-open-revalidate
To:     Bernd Schubert <bschubert@ddn.com>
Cc:     linux-fsdevel@vger.kernel.org, bernd.schubert@fastmail.fm,
        miklos@szeredi.hu, dsingh@ddn.com, Vivek Goyal <vgoyal@redhat.com>,
        Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Horst Birthelmer <hbirthelmer@ddn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 21, 2023 at 9:31=E2=80=AFAM Bernd Schubert <bschubert@ddn.com> =
wrote:
>
> In FUSE, as of now, uncached lookups are expensive over the wire.
> E.g additional latencies and stressing (meta data) servers from
> thousands of clients. With atomic-open lookup before open
> can be avoided.
>
> Here is the link to performance numbers
> https://lore.kernel.org/linux-fsdevel/20220322121212.5087-1-dharamhans87@=
gmail.com/
>
> Here is the libfuse pull request
> https://github.com/libfuse/libfuse/pull/813
>
> The patches are passing passthrough_hp xfstests (libfuse part applied),
> although we had to introduce umount retries into xfstests, as recent
> kernels/xfstests fail umount in some tests with
> EBUSY - independent of atomic open. (Although outstanding for v7)

Hi Bernd!

I was using xfstests to test passthrough_hp (for FUSE kernel passthrough).
FYI, I have made some improvements to the mount helper
in libfuse [1] to support remount, which helps pass a few tests.

So far, I have all the tests in group -g quick.rw pass with the baseline
passthrough_hp (over xfs).

Do you have a baseline for the entire quick/auto group to share with me?
Can you share the patch that you are using to avoid the EBUSY errors?

Note that Chritian has suggested a method to use inotify
IN_UNMOUNT event to wait for sb shutdown in fstests [2].

Thanks,
Amir.

[1] https://github.com/amir73il/libfuse/commits/fuse-backing-fd
[2] https://lore.kernel.org/linux-fsdevel/20230908-verflachen-neudefinition=
-4da649d673a9@brauner/
