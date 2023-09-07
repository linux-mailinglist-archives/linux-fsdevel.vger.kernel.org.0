Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD6FE7979EE
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Sep 2023 19:25:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243450AbjIGRZ4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Sep 2023 13:25:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243273AbjIGRZt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Sep 2023 13:25:49 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C06BF1FD8
        for <linux-fsdevel@vger.kernel.org>; Thu,  7 Sep 2023 10:25:24 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2bcc4347d2dso20602411fa.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 07 Sep 2023 10:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1694107471; x=1694712271; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ADxwAtasu+gveWpqZZkTiYMFLculswygOTZbb2QVivM=;
        b=CRhoO8kP7wyegpbdRBHxJrwOhPzx0Bac2g0eqHaaj6nJYu9gIrzkD9MMkh0CB/cA37
         p76sUBkTnpKGjoWT79+EicGQDmEFksWTIrI7jLnWXE/I4Bicfywfs+dZzOt5k/1gmmSZ
         SeHVDrz1WXdn1NLLKFFV1jRL8riuBpiucHmn4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694107471; x=1694712271;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ADxwAtasu+gveWpqZZkTiYMFLculswygOTZbb2QVivM=;
        b=D1se5PuB8TSMgcRrjBnM00Rv52Hji/2VKkECPhZzDG9NqWDRVwNA9nZCkBt8NXg+T7
         8ZNKOqGCg7lx0fMb0dRSnwVoNDM6hE9j+FT8uYPlZiUlovDWO7vazuZCNmp1FYNY+K3Z
         0wTsxrzO1pHFvmV7TVIUEqpqsGva/Ze3bHG/766sw7Im8aDSxE/7XZQvM6BlmdGY5l9B
         OXfWVmkSkk60Gcs5R1EKXkI4Kda2OeNY0KPG2sdxClDijF4dG4oj3CEMauKVNYG/FZvu
         Yrt5xjkv7WPp/gHYbEkuulBPGnC3ZnGiW3dxZKUoN46SfThnG3C3LukZo4xiBskqKnqv
         A+AA==
X-Gm-Message-State: AOJu0YzveVKIyZsmt1Bva9U79q5Th9/M/2hCs/ASmSgMSIl18UL9Pxr4
        5Zv97qOg8nYdZdZ3/C+eiEeGaLEK5pg2UofQBbMBElrt
X-Google-Smtp-Source: AGHT+IElL0MR2AQPJFErzXjrBue9zV1p7+gx7dBX66XljY5+TYuzqWGZ8BX47vsHWlVG5qGsb4L6hA==
X-Received: by 2002:a2e:8544:0:b0:2bc:da3e:3bda with SMTP id u4-20020a2e8544000000b002bcda3e3bdamr5991716ljj.2.1694107471598;
        Thu, 07 Sep 2023 10:24:31 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id p25-20020a2e8059000000b002b6e13fcedcsm4001086ljg.122.2023.09.07.10.24.30
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Sep 2023 10:24:30 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-500d13a8fafso2039827e87.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 07 Sep 2023 10:24:30 -0700 (PDT)
X-Received: by 2002:a05:6512:104b:b0:4f3:9136:9cd0 with SMTP id
 c11-20020a056512104b00b004f391369cd0mr60515lfb.44.1694107470248; Thu, 07 Sep
 2023 10:24:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230907-vfs-ntfs3-kill_sb-v1-1-ef4397dd941d@kernel.org>
In-Reply-To: <20230907-vfs-ntfs3-kill_sb-v1-1-ef4397dd941d@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 7 Sep 2023 10:24:11 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg5NKHNdrzJ-8bwu0go=6n177M2EkwcgnXiyd23go5RPw@mail.gmail.com>
Message-ID: <CAHk-=wg5NKHNdrzJ-8bwu0go=6n177M2EkwcgnXiyd23go5RPw@mail.gmail.com>
Subject: Re: [PATCH] ntfs3: drop inode references in ntfs_put_super()
To:     Christian Brauner <brauner@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, Guenter Roeck <linux@roeck-us.net>,
        Christoph Hellwig <hch@lst.de>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        linux-fsdevel@vger.kernel.org, ntfs3@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 7 Sept 2023 at 09:04, Christian Brauner <brauner@kernel.org> wrote:
>
> Hey Linus,
>
> Would you mind applying this patch directly? It's a simple fix for an
> ntfs3 bug that was introduced by some refactoring we did in mainline
> only.

Done. Thanks,

                 Linus
