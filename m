Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D21147A6495
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Sep 2023 15:15:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232020AbjISNP5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Sep 2023 09:15:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbjISNP4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Sep 2023 09:15:56 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34858F0
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Sep 2023 06:15:51 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2bceb02fd2bso90401211fa.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Sep 2023 06:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1695129349; x=1695734149; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/YflXYglgF2ghb+juzkAUfuvNFkVuPP1IFeMvX6P+9A=;
        b=Juzbteth6d6koy19UxP2bY5ZvJCKMa6cxNNBR6PEDuMNxYt1ylxD1daD+NAoXwzJ9l
         lanz4+yS5XU7RmHk+0iZW897MKg5tkPM0cwpUIy/jtRnvWUUr0JF4ylgyz9tRwtjXoUN
         sfLNmQ/TPKQMw9E7//pXkeF/Rw/EB3yznkQdUeg3g8OFUNUODkNDQlpUuWj/Ya2mG0wg
         BL5skGTQk8yoDNku2HiB/px0fh5kZd98V5hFMmSqSJzNZfxBzx7pkhp17qoRHQAN23Dp
         hiUYmKrlmno7gFkEdd36yAkm1qA+WM6e7Spj3kJb8NdkfjxY1dgQmwBVN2b6F515cvDl
         ElbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695129349; x=1695734149;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/YflXYglgF2ghb+juzkAUfuvNFkVuPP1IFeMvX6P+9A=;
        b=gN8OYYtQq9VZ8LDGMiKA8KR5SkOsV7eVXOrhhSQP2NYjihJOvYBSCLwQ93LM/qc5xl
         oEA4vnlkJC5CscGn4cO9Xc8ACXEa9Bp5Ay03AInwB0bJ7YImWfjmCwJplBlOgIl8IJ6D
         F/SuM8x4j6LOjwg9kp/hEpX9zaAhZtloNaXvqpQfNG9nYqyB2SQx2L1IvoGxA/g1/Bm6
         PNx00jQ5xPQFBFa1Pi77RiMttcoqvEpPTIxcr+Ym2zkvFfD+TtA9uUJDj7637BDSCyz5
         /uNab9RE1KFRjoWXzk5c+9CkVg20YEERFUPl7MQ+iCwGeHcvuZ2EMmv+A5jro4tVHE2Q
         wlLQ==
X-Gm-Message-State: AOJu0Yyrmu8GbjXkZivovVCTLtV65dJG89NzYmQ+pmZKCfcYE2m5AZI+
        qJLlifNt3V7AR3WdYc18FKlLCekiSESFn7lwi8BOXciTYiKDJxaERkg=
X-Google-Smtp-Source: AGHT+IE0EuipW9qvFPgLGR9UFGOCTZUcbzOmYvUOgGwWrx+zoDKlqdfvJp7pY8jS/j8A6jnf/le1WKTA2bsfi1/QYUI=
X-Received: by 2002:a05:651c:2106:b0:2c0:a99:68dd with SMTP id
 a6-20020a05651c210600b002c00a9968ddmr6413574ljq.4.1695129349487; Tue, 19 Sep
 2023 06:15:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230919081808.1096542-1-max.kellermann@ionos.com> <20230919-verweben-signieren-5c69a314440c@brauner>
In-Reply-To: <20230919-verweben-signieren-5c69a314440c@brauner>
From:   Max Kellermann <max.kellermann@ionos.com>
Date:   Tue, 19 Sep 2023 15:15:38 +0200
Message-ID: <CAKPOu+-rxm38_sMPv0gasOYvtefd8PJeSWR2Rk_N-mEYDmPqFA@mail.gmail.com>
Subject: Re: [PATCH] fs/posix_acl: apply umask if superblock disables ACL support
To:     Christian Brauner <brauner@kernel.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        "J . Bruce Fields" <bfields@redhat.com>, stable@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 19, 2023 at 3:10=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
> Have you verified that commit ac6800e279a2 ("fs: Add missing umask strip
> in vfs_tmpfile") doesn't already fix this?

No, I havn't - I submitted this patch already several years ago, but
it was never merged, and since then, I've been carrying this patch
around in all kernels I ever used. While doing some other kernel work
this week, I decided to resubmit it, because I thought it's a security
vulnerability to ignore the umask. But thanks, it's a good hint, I'll
check that 2022 commit.
