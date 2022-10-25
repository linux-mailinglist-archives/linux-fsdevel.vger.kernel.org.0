Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3951C60D700
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Oct 2022 00:25:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232635AbiJYWZX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Oct 2022 18:25:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232683AbiJYWZO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Oct 2022 18:25:14 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E57FD61B29
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Oct 2022 15:25:10 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id 192so6207691pfx.5
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Oct 2022 15:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N/IHWp5axKcNbS4CK0rdqluH2L9n6cyXddp8mwZdAWk=;
        b=M+QTTQuJYEiA9TQ/SaVp6cRfUf5PJqP7uvCnPdF4C/K5AcaCpZ3dnqjCsBVxZf26u6
         YN9NAK30TVZha17vuUpG9TRFJxK01wJ+Nfnk4rLf5/5/+YaqBOOmkJotmZ4GGZH8u2g1
         5f+OTY0f1+7kwGO9LaWXRPRZ0n8wX7GVMty+0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N/IHWp5axKcNbS4CK0rdqluH2L9n6cyXddp8mwZdAWk=;
        b=5sylsl84CqBhA8X9BJFo3kIoH2IvHVrQ7m5MwLzDpqvoihdQiqrQlGnmxXKllwLXQD
         nsRTqPpl2yTzoo9jmwNeaCb467T4+rRxWPkVQjfoT/ZqFw/gm5r/MSH1pnJBRLDpck+q
         sRMZxpB6pXMUXc9h4Cxa0x8xTq4MtapCSOBB05uNDQeV8Y3CcfO5lCHQOuc0ZHK+sX9A
         C2k3xbo/0lNDbunqTQZ2L9glWdis1SvXmpdFcze1H5di712WtWvlerZ0PoKgTcnH/RU7
         PZxaIrYcO0Kb9l/okF2A3TirwHN3esWrhLmZOICX6R/3o9h4MLGoUue77rPVsBQA4XZg
         fHwg==
X-Gm-Message-State: ACrzQf0wCCYbDlz/JIA2VsYszSHEpH78aPZy5RH5sAXMjy7VpWaqVhOS
        7y2/pbqg9lZHWXlajWxMB4U2oA==
X-Google-Smtp-Source: AMsMyM66lXBBZiCQgf6FJkUodLvLKJHXn2RfG7lIzuw8OWJbBF9QFZXfjigg53YexUkU8JIZdanoxA==
X-Received: by 2002:a63:d314:0:b0:452:598a:cc5a with SMTP id b20-20020a63d314000000b00452598acc5amr35619334pgg.299.1666736710427;
        Tue, 25 Oct 2022 15:25:10 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y17-20020aa79e11000000b0056be4dbd4besm1848936pfq.111.2022.10.25.15.25.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 15:25:09 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Al Viro <viro@zeniv.linux.org.uk>, ebiederm@xmission.com,
        eb@emlix.com
Cc:     Kees Cook <keescook@chromium.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] binfmt_elf: simplify error handling in load_elf_phdrs()
Date:   Tue, 25 Oct 2022 15:24:37 -0700
Message-Id: <166673667324.2128117.9264012790851667013.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <4137126.7Qn9TF0dmF@mobilepool36.emlix.com>
References: <4137126.7Qn9TF0dmF@mobilepool36.emlix.com>
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

On Wed, 19 Oct 2022 09:52:16 +0200, Rolf Eike Beer wrote:
> The err variable was the same like retval, but capped to <= 0. This is the
> same as retval as elf_read() never returns positive values.

Applied to for-next/execve, thanks!

[1/1] binfmt_elf: simplify error handling in load_elf_phdrs()
      https://git.kernel.org/kees/c/ef20c5139c31

-- 
Kees Cook

