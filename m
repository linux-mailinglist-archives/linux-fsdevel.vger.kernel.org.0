Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 889A97AEAA0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Sep 2023 12:41:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234431AbjIZKmD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Sep 2023 06:42:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234425AbjIZKmC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Sep 2023 06:42:02 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B2BB101
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Sep 2023 03:41:55 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2b962c226ceso143167561fa.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Sep 2023 03:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1695724914; x=1696329714; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HLu9xemBg1ip5g4bQWEMv6HdoqSuDts/Nrj5Q5I9bIc=;
        b=X1RkhR+flpLmNX7yGkiMU/YuTd73pUS9R6icIt7GFd3+5quATTozvntHsgCdo1ivHY
         nOsEqepNP9YQVM+Wt8e17HwiL4KaJbiTyCyEUxBV1UWUZ33WovgQQfEfdX8lRgS75xcp
         Rd+e4VaSvsB9UwHRIoxp4fSXBCWCFTtLKpc8RkMHAr/rJ47sWXg60uIEtU/1uh/Jswri
         fUJAbEnXY9zxbnhZ/keh0ex8MwS/4WmXb6mL9k5E+h4hZoZ3JWFk5FF4pO/2hRCxBqCn
         K/zOBKagNjMHEXBTRQXX2ngExzmWw4w0utmT+r8PmoZFBRlqGdC9XYm1N2NXcGjy8uAs
         8GEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695724914; x=1696329714;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HLu9xemBg1ip5g4bQWEMv6HdoqSuDts/Nrj5Q5I9bIc=;
        b=SGrnCsVJ79rLLKm/Tx0gAw6bhnxZcArHp2UVJD4NY15WyuKSjdLk6yfrdOUGTh9HHw
         KNWbxAiya57upY/ja7aXn4piqCZ/QKCyAbaH/h4oHCCMyFPK+x6NHzFojXzu/kiVs13/
         oUpWDCK8x+JXA4cVuC/ka1b6lVb52D+WYV7Ow57hW4ul+/LAlxjHjBVbTDrXvNx+GmRB
         DMgxU0f4DVBor699R2fFnDRjnxoudR+rsatB3m3avIWWT6N2b958Ei7EZVUO9gL2rScg
         QUXui/altVMKyvYlxls/0H7WiybRb2XW5go+toLGQc4V8hmcZ2zyh2n82X1bZ1HYoQ+p
         lxgA==
X-Gm-Message-State: AOJu0Yx4mHRKa754FDOwWM064O9KdUwV4cFw5wfXlJEsUjlZ/DQ4V6O5
        P8Bvj8NljVhAvCIxepviWDmxM8gOj8arUhIYZcJpyw==
X-Google-Smtp-Source: AGHT+IHRl4/Au0w+1lIL2m1rSdJLLt3btnu/k6dwdUMotMH/zcSdVs36BhGTKJ4HqLFxfJpzs4cR+r5nP4u08RGQkhY=
X-Received: by 2002:a2e:82d6:0:b0:2bd:1dc0:5ed5 with SMTP id
 n22-20020a2e82d6000000b002bd1dc05ed5mr7300512ljh.23.1695724913799; Tue, 26
 Sep 2023 03:41:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230925-erstklassig-flausen-48e1bc11be30@brauner>
 <20230926063609.2451260-1-max.kellermann@ionos.com> <20230926-achtlos-ungeschehen-ee0e5f2c7666@brauner>
In-Reply-To: <20230926-achtlos-ungeschehen-ee0e5f2c7666@brauner>
From:   Max Kellermann <max.kellermann@ionos.com>
Date:   Tue, 26 Sep 2023 12:41:42 +0200
Message-ID: <CAKPOu+9VYJeZbc6xLJzJY=mtmDm+Of9DEKk0kQwnn0nvVzN_4A@mail.gmail.com>
Subject: Re: [PATCH v2] fs/splice: don't block splice_direct_to_actor() after
 data was read
To:     Christian Brauner <brauner@kernel.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 26, 2023 at 12:21=E2=80=AFPM Christian Brauner <brauner@kernel.=
org> wrote:
> Hm, so the thing that is worrysome about this change is that this may
> cause regressions afaict as this is a pretty significant change from
> current behavior.

Would you prefer a new flag for explicitly selecting "wait until at
least one byte was transferred, but don't wait further"? Because many
applications need this behavior, and some (like nginx) have already
worked around the problem by limiting the maximum transaction size,
which I consider a bad workaround, because it leads to unnecessary
system calls and still doesn't really solve the latency problem.

On the other hand, what exactly would the absence of this flag mean...
the old behavior, without my patch, can lead to partial transfers, and
the absence of the flag doesn't mean it can't happen; my patch tackles
just one corner case, but one that is important for me.

We have been running this patch in production for nearly a year (and
will continue to do so until upstream kernels have a proper solution)
and never observed a problem, and I consider it safe, but I
acknowledge the risk that this may reveal obscure application bugs if
applied globally to all Linux kernels, so I understand your worries.

Max
