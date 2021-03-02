Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B37432A525
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Mar 2021 17:00:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443432AbhCBLro (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Mar 2021 06:47:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349461AbhCBIZK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Mar 2021 03:25:10 -0500
Received: from mail-vk1-xa2f.google.com (mail-vk1-xa2f.google.com [IPv6:2607:f8b0:4864:20::a2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6D59C06178C
        for <linux-fsdevel@vger.kernel.org>; Tue,  2 Mar 2021 00:24:22 -0800 (PST)
Received: by mail-vk1-xa2f.google.com with SMTP id m25so4232974vkk.6
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 Mar 2021 00:24:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gHK4JnR63Uj2zkrrF0LLWE9CLFkTJjc+hf2aOe/76Qk=;
        b=H/j9/7gFw2DSIIxJWfE2/xBE/Yg6n7P5kS9sLr9CPF4trQJhsqEROta/M/bJ2QXUx1
         TQ6HkVmR1tbSst1LKtM6ER7UutBYwy8dJBQ6TQmywRbBLBARcPDat0b8LD9rVXgdmzb7
         91wMygTfcwxGZgI3YCAuTNY3wTtGet27V8P4Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gHK4JnR63Uj2zkrrF0LLWE9CLFkTJjc+hf2aOe/76Qk=;
        b=jsGlS9zGXMxQQyvNy0pUcmMSK4dxESxVF4zBaziz+9Dsl8VvSoiGbIbqpgxrrn9au2
         duz8fWTqSRncb09K6j6eijPp/zdztRRgvGxIxE+qXNf4SzEw+eeid6MFrhTKhVjR1Rp1
         JKD8wQ4wffF3urhU/TwTWfEBGAn7Y8UDhaGT0jIOEfT0uAdpm9oh2xgq9CKpICEdNcnW
         x2oo0dSES1Tz6Gd1MWDvs4ad6147r2IhP+M49KAfUW0iGVVwyrS2Tew6EyKr4g/4RXfz
         04T0bnxqOrIRlBIRjMKl6lxu5LfSp5gqn8tUfskqSNBRdaPCGiKNUf26A8XxIxnQ39uD
         sx5A==
X-Gm-Message-State: AOAM532isurST/OTxrjv99j4XLJm7dlyQPFQehzVFyvpXGA1MKcMXuus
        CgfLXnoxq7VgocuSfjQWT1PFm41ypIdG3IU9uTFc3g==
X-Google-Smtp-Source: ABdhPJyg9uJQlZeySdGkEzfeIqtfA4o+qgIsYZgchqZTEcO+yLujsqLgEc5JPQT91SzH6AgPgzXtE+ck7+u+S9tYeO8=
X-Received: by 2002:a05:6122:33:: with SMTP id q19mr10246650vkd.23.1614673462060;
 Tue, 02 Mar 2021 00:24:22 -0800 (PST)
MIME-Version: 1.0
References: <20210228002500.11483-1-sir@cmpwn.com> <20210228022440.GN2723601@casper.infradead.org>
 <C9KT3SWXRPPA.257SY2N4MVBZD@taiga> <20210228040345.GO2723601@casper.infradead.org>
 <C9L7SV0Z2GZR.K2C3O186WDJ7@taiga> <20210301190903.GD14881@fieldses.org> <20210301193537.GS2723601@casper.infradead.org>
In-Reply-To: <20210301193537.GS2723601@casper.infradead.org>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 2 Mar 2021 09:24:10 +0100
Message-ID: <CAJfpegtDQ6NG6vZeS9kiRq-VwbS06TD4X=QvtGUHkX_0Tm65nA@mail.gmail.com>
Subject: Re: [RFC PATCH] fs: introduce mkdirat2 syscall for atomic mkdir
To:     Matthew Wilcox <willy@infradead.org>
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        Drew DeVault <sir@cmpwn.com>, linux-fsdevel@vger.kernel.org,
        Linux API <linux-api@vger.kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 1, 2021 at 8:42 PM Matthew Wilcox <willy@infradead.org> wrote:

> (as an aside, i think there's a missing feature in posix -- being able
> to atomically replace one directory with another.

RENAME_EXCHANGE.

Thanks,
Miklos
