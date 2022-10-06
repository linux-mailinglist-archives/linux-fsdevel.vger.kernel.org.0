Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF27D5F6730
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Oct 2022 15:03:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbiJFNDj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Oct 2022 09:03:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231500AbiJFNDg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Oct 2022 09:03:36 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B5929D53B
        for <linux-fsdevel@vger.kernel.org>; Thu,  6 Oct 2022 06:03:35 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id o21so4350796ejm.11
        for <linux-fsdevel@vger.kernel.org>; Thu, 06 Oct 2022 06:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=bJE4vQ3mtcOL5hiYWRkbYO1oVGrXpLNRDbNovHGW6kw=;
        b=l6f/A42Fq6jUpz/665ggFaN0o95U6gH0t1HjIiewfaSsZyUXtBfs4tZKvKZ3hpXylH
         jgTgOPGDhCddwgZh53fLmofo/oG+qOeOjKkScieGJ1fY6lA85nkwsRFRZOH1AT9bEbkb
         Yq+XfUSq/N4wAqNnM/C25kNyjg0WgjQXqgN3U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=bJE4vQ3mtcOL5hiYWRkbYO1oVGrXpLNRDbNovHGW6kw=;
        b=W9swoGA/7LmxLScpN96kRdRKtrgKFpIwSKKgkVyvDr685J4qswwnrvWun+D3CMQJ2l
         31hjd1o9BV+gtZCW8ZDVJtW3YjJb0ejX2dClxJUZtKFIzNKJphgxaqjnqmVP1VFYFfsV
         0bOJDX6fdHCm+aovJ5YTOvEScoDxmNP/0+FJTq4jHMn7LhmfqPiPZ7fQxWjnaZQym/JL
         z+XGvgw3LNhnECKPct6+7rcYHb5zL48WkRtLrBq4lTYbH2Pnkha8lIzop5blFwPJMuDj
         vG0AXC0NMknPS8DuNXjyGo4xk3wEWjzusNc1xy+ZBZf8ThJUDOKOATyJb4lJnCDGUHVQ
         Enbw==
X-Gm-Message-State: ACrzQf3V0wBmeKEu/129W0n/1dqLKoiwXyKmqRFkzM0BOXF5QMTf9WnG
        2xxMqF2nmanYeHKzrxManMgcuIx9eXDhBQui9rhL0w==
X-Google-Smtp-Source: AMsMyM6wtdTmULcErYXHSyqyGbj0ebfq7U1sGvuSMxBzEbpnt6UwWuQPcpXpLvcGfTlDwzlH0aaQ+6pFH1Vftw1qs3U=
X-Received: by 2002:a17:907:a0c6:b0:787:8250:f90e with SMTP id
 hw6-20020a170907a0c600b007878250f90emr3910387ejc.8.1665061414138; Thu, 06 Oct
 2022 06:03:34 -0700 (PDT)
MIME-Version: 1.0
References: <20221005151433.898175-1-brauner@kernel.org> <20221005151433.898175-2-brauner@kernel.org>
In-Reply-To: <20221005151433.898175-2-brauner@kernel.org>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 6 Oct 2022 15:03:23 +0200
Message-ID: <CAJfpegss=79W+BXpOH_n7ZOtci1O0njHHxZMnb8ULJBStkq7mg@mail.gmail.com>
Subject: Re: [PATCH 1/3] attr: use consistent sgid stripping checks
To:     Christian Brauner <brauner@kernel.org>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>,
        Seth Forshee <sforshee@kernel.org>,
        Yang Xu <xuyang2018.jy@fujitsu.com>,
        Filipe Manana <fdmanana@kernel.org>,
        linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 5 Oct 2022 at 17:14, Christian Brauner <brauner@kernel.org> wrote:
>
> Currently setgid stripping in file_remove_privs()'s should_remove_suid()
> helper is inconsistent with other parts of the vfs. Specifically, it only
> raises ATTR_KILL_SGID if the inode is S_ISGID and S_IXGRP but not if the
> inode isn't in the caller's groups and the caller isn't privileged over the
> inode although we require this already in setattr_prepare() and
> setattr_copy() and so all filesystem implement this requirement implicitly
> because they have to use setattr_{prepare,copy}() anyway.

Could the actual code (not just the logic) be shared between
should_remove_sgid() and setattr_copy()?

Maybe add another helper, or reformulate should_remove_sgid() so that
it can be used for both purposes.

Thanks,
Miklos
