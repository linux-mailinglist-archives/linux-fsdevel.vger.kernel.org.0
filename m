Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C2687A4EC2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Sep 2023 18:26:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbjIRQ03 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Sep 2023 12:26:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjIRP1N (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Sep 2023 11:27:13 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60A771985
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Sep 2023 08:24:21 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-404c023ef5eso28662715e9.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Sep 2023 08:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1695050544; x=1695655344; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3lFpWEQNX0RgOS+vwuIIC94hCwP0MrQhLUc3uHKyySs=;
        b=bZylVWSCryeafaYdrZ8tKUiQmOsxPkiJ9O+i7udz6j+5b55KSX7K1oO3WV+7Mhp9W7
         w4EKlcCjDkiYcsgwA3Uz67DW2IUdFVAZxgeRdDEvSnufi3LLhUkXL+vtYTD2NsaevJDt
         QDiWWKlT6g3Y+FAP0mRj3frkD6SWp54V0l/a0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695050544; x=1695655344;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3lFpWEQNX0RgOS+vwuIIC94hCwP0MrQhLUc3uHKyySs=;
        b=C4+MPxJ38esARrTdzWE2lMM7cUyd3zMa6plAc4/s/s4LNVdBIEo4zEcAIMrF//WW+v
         vChV83RUzzzeI2KgBC+/4Q7XOqWIJJH763pipB42a3CfWhCWO6+DVLUYSd8TfYbc6h4q
         b5Oa1I+kCCt15jmVTs7WDob2V9mUkbhW4K9NE9KYi0DUTP3GoLeVPyOZsdIa5t/egIsz
         iVyO1uH8FVtIjlJh5kOVXRFyi52nkwyGbbBM1ASFopJgaVh+VGW04cxW0dmauJOPNX9m
         DhcEBVo3NWLZZt0cU/38O0rH3Pxh+8jfWwCmG6n1M/ZTQyzVZGt12O0nctAgld0bXZjz
         i/uA==
X-Gm-Message-State: AOJu0YxgOFxHacOsOrpL6RIyQeGwXZQ/SYET/A7j3pm7iI1q23/wIqlB
        0b8Qw3h7YOHvAecRtRwuEo6op4i3W1d2XBWDPHLwlVkvPWclVfQ0
X-Google-Smtp-Source: AGHT+IFnzEkphfcA1k56lMmjABKC+h4WWJYwladyvHeyaRQV3hNEF1Dw61zv3yr9gv0EEochrOGS5dXCs2GS30BWGs0=
X-Received: by 2002:adf:a3c4:0:b0:31f:f664:d87 with SMTP id
 m4-20020adfa3c4000000b0031ff6640d87mr7329776wrb.20.1695048675110; Mon, 18 Sep
 2023 07:51:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230913152238.905247-1-mszeredi@redhat.com> <20230913152238.905247-3-mszeredi@redhat.com>
 <20230914-salzig-manifest-f6c3adb1b7b4@brauner> <CAJfpegs-sDk0++FjSZ_RuW5m-z3BTBQdu4T9QPtWwmSZ1_4Yvw@mail.gmail.com>
 <20230914-lockmittel-verknallen-d1a18d76ba44@brauner> <CAJfpegt-VPZP3ou-TMQFs1Xupj_iWA5ttC2UUFKh3E43EyCOQQ@mail.gmail.com>
 <20230918-grafik-zutreffen-995b321017ae@brauner> <CAOssrKfS79=+F0h=XPzJX2E6taxAPmEJEYPi4VBNQjgRR5ujqw@mail.gmail.com>
 <20230918-hierbei-erhielten-ba5ef74a5b52@brauner> <CAJfpegtaGXoZkMWLnk3PcibAvp7kv-4Yobo=UJj943L6v3ctJQ@mail.gmail.com>
 <20230918-stuhl-spannend-9904d4addc93@brauner>
In-Reply-To: <20230918-stuhl-spannend-9904d4addc93@brauner>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 18 Sep 2023 16:51:03 +0200
Message-ID: <CAJfpegvxNhty2xZW+4MM9Gepotii3CD1p0fyvLDQB82hCYzfLQ@mail.gmail.com>
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

On Mon, 18 Sept 2023 at 16:40, Christian Brauner <brauner@kernel.org> wrote:

> What we're talking about here is a nicely typed struct which returns two
> paths @mnt_root and @mnt_point which can both be represented as u64
> pointers with length parameters like we do in other binary structs such
> as bpf and clone3 and a few others. That is a compromise I can live
> with. I'm really trying to find as much common ground here as we can.

So to be clear about your proposal: .mnt_root and .mountpoint are
initialized by the caller to buffers that the kernel can copy paths
into?

If there's an overflow (one of the buffers was too small) the syscall
returns -EOVERFLOW?

Thanks,
Miklos
