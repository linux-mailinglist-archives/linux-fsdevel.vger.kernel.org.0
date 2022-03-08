Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31C944D2345
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Mar 2022 22:25:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350431AbiCHVZ7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Mar 2022 16:25:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350429AbiCHVZ6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Mar 2022 16:25:58 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FDE15004E;
        Tue,  8 Mar 2022 13:25:00 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id 7-20020a05600c228700b00385fd860f49so363200wmf.0;
        Tue, 08 Mar 2022 13:25:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nDOGbN5ER5kyhrbrSeZfaKAJZ4dw3JtTr6jnBgdLbBI=;
        b=kmHrGTMSvm6tF864EuT2q9gVNsYXS3s2uIcUZWHBIrB9Q8oVsXygqnpmpDyJow/rtB
         lldvQxzcy5qU3NO7j9RwlGt7C5cuRxfx5L5x+qoB7R/6PFU+YEtXgbcO06pt+DNxgbRg
         0kIjeFi+TQVc5+qYRitxrs1b2/ekbArAvz+zBucgyNYqI5PyyYZNMzlMSS3P4pF7aTxl
         2zxa7YL1+Vy//v5c8ZaLvqYnfikwRN5rmd6yAm/wttKeNs2HOR4SKL2jEBPLrpWgeBb2
         q2DN0hNxiKsbH8Uw0q7n9hZBcaeHq0Ptst/XDlYJYnZd9lcmkWIeR6bLTTqFO2/h3AW9
         mGgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nDOGbN5ER5kyhrbrSeZfaKAJZ4dw3JtTr6jnBgdLbBI=;
        b=oOK+g3dGp1xBl1FAjuaHaz5hzMPMZnAjEqydMNlMCPBSaVydHGFe1SOQ65QVxWdEpH
         oAExkNisWVkjanIS8KKsZIYVRsdYc+HkpFPBIhvuctrMttrwJUzPlkwn21FlfPui2+gh
         lYkVuAu+DbClc30432okKVk78XK9umHxiNMNKM13m+JRlqrENrsCqEXgU/6IyEh6K1qi
         PX6VxHLEOekiGUB63WqVoXdilD440ey0Psgcc0GncNauBOXaBE62a4ee2c6WIw87Ll4B
         T8nfrSqbuJAOcwWUrutuse/VQxayP2w7vdC/S5lPROuc3erTA7Q1lbTj+GbxfIWPXgbj
         II+Q==
X-Gm-Message-State: AOAM531Zr8SFyb3nfttcM1TCbzST1CHlbWln/p6KGT6evzJHCKaPjiXl
        G/88QgE+PUyNBf2Adb5aww==
X-Google-Smtp-Source: ABdhPJxuYGxepEE8cVVoar6pJEOKukfeg0awhEsWbFqsOc0BU99sBdi+fMLBfybk2ElJ5BBGowTeEQ==
X-Received: by 2002:a05:600c:3b1c:b0:389:8677:6c73 with SMTP id m28-20020a05600c3b1c00b0038986776c73mr934939wms.192.1646774698977;
        Tue, 08 Mar 2022 13:24:58 -0800 (PST)
Received: from localhost.localdomain ([46.53.254.141])
        by smtp.gmail.com with ESMTPSA id b3-20020a5d4d83000000b001f1d72a6f97sm26070wru.50.2022.03.08.13.24.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 13:24:58 -0800 (PST)
Date:   Wed, 9 Mar 2022 00:24:56 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     David Gow <davidgow@google.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Daniel Latypov <dlatypov@google.com>,
        Magnus =?utf-8?B?R3Jvw58=?= <magnus.gross@rwth-aachen.de>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] binfmt_elf: Introduce KUnit test
Message-ID: <YifJqN+5ju4kHQ2y@localhost.localdomain>
References: <20220304044831.962450-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220304044831.962450-1-keescook@chromium.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 03, 2022 at 08:48:31PM -0800, Kees Cook wrote:
> Adds simple KUnit test for some binfmt_elf internals: specifically a
> regression test for the problem fixed by commit 8904d9cd90ee ("ELF:
> fix overflow in total mapping size calculation").

> +	/* No headers, no size. */
> +	KUNIT_EXPECT_EQ(test, total_mapping_size(NULL, 0), 0);

This is meaningless test. This whole function only makes sense
if program headers are read and loading process advances far enough
so that pointer is not NULL.

Are we going to mock every single function in the kernel?
Disgusting.
