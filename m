Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DFFF7BFD94
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Oct 2023 15:35:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232226AbjJJNfD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Oct 2023 09:35:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232190AbjJJNfB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Oct 2023 09:35:01 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1E4ED3
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Oct 2023 06:34:58 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-9a9f139cd94so944016166b.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Oct 2023 06:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1696944897; x=1697549697; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YWUC8y8l3yNsmutyYm6vcX2/BBN8tUeuIPKvPzyLwRk=;
        b=oHgX8gFY/7p1cowP3/MkjeksfTpy02cbyXHVaMtjsdS4VWPRRpzZ12ZBt+WIcXPloG
         rlVuU3WLXVYA39JR0tbwEM/dOoQhyagi+1wXhCNeUGNAGJzILElEqgTKsefkD7Wsw4u5
         8FrmM22Rjdwr9NaCJKs4hV5LM1fAHk7hSvFp8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696944897; x=1697549697;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YWUC8y8l3yNsmutyYm6vcX2/BBN8tUeuIPKvPzyLwRk=;
        b=cDfpldVKK4L7xV5SnwTS5rDvy9zqXYzrme9+feKX69mP5mVWas1c/urf71OG74hm+L
         6xOWT2qweoyZ2tYgzLZkEVOE+aW7sRb8AiertDE1RRMqe8Cl4ZiKcT8dgLl49edRZXKv
         3GpxjKrei2S4ro7gnfr7Bfg0sVxHk2dOWOstLtuu8pnUaHBE1jLYkDNKiYbBePeHesA/
         4lGIxzWU19ul1OTArQ3BrBfKgT1F7/axWUgA6IZA4kwV6GzdHJ3s+JuYgYpe232v/5XB
         rGIUbgIIt2ApVWcWaKDV4HPPeFFVc1f5158w+alRsXz7ETAmnV5sRd/Y049RGxQdSsQP
         yn/A==
X-Gm-Message-State: AOJu0Yy12Fuk/K0TZaBKLB/ProCI+oSwM3zq95TFvoE0u1CyuLNyW+fQ
        QACiuQVA+UKx+2SpJfWSUILu9Qf63fMJCrQ/KsyceQ==
X-Google-Smtp-Source: AGHT+IGwMUdcL/W56HSslwNCKmz+C7aJVFJrM4duK0etXFNSbx8bpp8Q7QWmQJHZRD0TzXnKmcbSoWRwvRSilSrZm0Q=
X-Received: by 2002:a17:906:3004:b0:9ad:8aac:362b with SMTP id
 4-20020a170906300400b009ad8aac362bmr13751511ejz.23.1696944896972; Tue, 10 Oct
 2023 06:34:56 -0700 (PDT)
MIME-Version: 1.0
References: <20231009153712.1566422-1-amir73il@gmail.com> <20231009153712.1566422-4-amir73il@gmail.com>
 <CAJfpegtcNOCMp+QBPFD5aUEok6u7AqwrGqAqMCZeeuyq6xfYFw@mail.gmail.com>
 <CAOQ4uxiAHJy6viXBubm0y7x3J3P7N5XijOU8C340fi2Dpc7zXA@mail.gmail.com> <CAOQ4uxipA5oCQXn1-JZ+TbXw2-5O+_++FfNHC6fKqhNXfR7C0w@mail.gmail.com>
In-Reply-To: <CAOQ4uxipA5oCQXn1-JZ+TbXw2-5O+_++FfNHC6fKqhNXfR7C0w@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 10 Oct 2023 15:34:45 +0200
Message-ID: <CAJfpeguEf71ZknP5rGU9YNtJTp1wBGBKyv6M0JZ=5ETuaipDxQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] fs: store real path instead of fake path in
 backing file f_path
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-unionfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 10 Oct 2023 at 15:17, Amir Goldstein <amir73il@gmail.com> wrote:

> Sorry, you asked about ovl mount.
> To me it makes sense that if users observe ovl paths in writable mapped
> memory, that ovl should not be remounted RO.
> Anyway, I don't see a good reason to allow remount RO for ovl in that case.
> Is there?

Agreed.

But is preventing remount RO important enough to warrant special
casing of backing file in generic code?  I'm not convinced either
way...

Thanks,
Miklos
