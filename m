Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F73560D704
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Oct 2022 00:26:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232858AbiJYW0D (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Oct 2022 18:26:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232724AbiJYWZi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Oct 2022 18:25:38 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D05717D785
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Oct 2022 15:25:20 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9so2013069pll.7
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Oct 2022 15:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fVyOXaIPwUu5vIxKTkFwgvGCOhZvoDwYK5zKXQji1rw=;
        b=FXN94XTHI8WO7GeSzT3nSCHe9nGZqe2ZmzGLnUOqPa93icziFIl7n+9AfXwT3f2+y0
         8QSjBta7eXcMJndiixYUZaYrIr/ALR4UMqjUyF0XwH2DvIQU9E69PpcWNPC0sAnOd+X6
         fVZP3RQlmJQyVICheUyWF2dKDm4CAztuMUGoM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fVyOXaIPwUu5vIxKTkFwgvGCOhZvoDwYK5zKXQji1rw=;
        b=dkk4jwn28HaK6JfwWVf1O01ZZ60gjBQHPAF4QWYdJlGP6MUnhtBBa+D2K95OTktmUL
         Ew615Njjg3+YpzZ+wWN+OPGZuQbUcd0p6sJrjRmCz7XhduvC4R3NcC4nzKLwO9tPn0Cm
         3p6AhhDafcxO52gtC3b+S12RAzlAYrLbBhmblt0zJc+/fufToiuDhOPOA3yy/T2ay0cm
         DO6vGsjfAARXXn5bNSsVBUXVP1eRLujSk24pj4vM4YQBfpiJmbKYTEl7opuMIYcIv0Yx
         JQ+10hU0Oui06SG4KF+C/708vjiy3VYhFiTvp4PSIDW3GgEVP/F/8tJJOKoPu8+qg2HP
         0t5g==
X-Gm-Message-State: ACrzQf1wSInOd3aF3lb3TwuaUxm6qTzlPmNigBAisc/5pcIIFU8ZCoxP
        spNNdkzrU234Buq0jZ7EtlosTA==
X-Google-Smtp-Source: AMsMyM4ED1R3VmA5cIJauau3fO0RwdvVSUL/RQb5KUEJx9boipxAayQvCEMLL5iMFYJ0zskyLrXX7g==
X-Received: by 2002:a17:90b:4c52:b0:20d:489b:5607 with SMTP id np18-20020a17090b4c5200b0020d489b5607mr597178pjb.40.1666736719535;
        Tue, 25 Oct 2022 15:25:19 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b78-20020a621b51000000b0056b4c5dde61sm1898977pfb.98.2022.10.25.15.25.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 15:25:18 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Al Viro <viro@zeniv.linux.org.uk>, ebiederm@xmission.com,
        eb@emlix.com
Cc:     Kees Cook <keescook@chromium.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs/exec.c: simplify initial stack size expansion
Date:   Tue, 25 Oct 2022 15:24:39 -0700
Message-Id: <166673667324.2128117.14471012472344174206.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2017429.gqNitNVd0C@mobilepool36.emlix.com>
References: <2017429.gqNitNVd0C@mobilepool36.emlix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 19 Oct 2022 09:32:35 +0200, Rolf Eike Beer wrote:
> I had a hard time trying to understand completely why it is using vm_end in
> one side of the expression and vm_start in the other one, and using
> something in the "if" clause that is not an exact copy of what is used
> below. The whole point is that the stack_size variable that was used in the
> "if" clause is the difference between vm_start and vm_end, which is not far
> away but makes this thing harder to read than it must be.
> 
> [...]

Applied to for-next/execve, thanks!

[1/1] fs/exec.c: simplify initial stack size expansion
      https://git.kernel.org/kees/c/bfb4a2b95875

-- 
Kees Cook

