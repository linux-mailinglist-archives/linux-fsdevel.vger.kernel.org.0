Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98CB865F644
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Jan 2023 22:54:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236062AbjAEVyn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Jan 2023 16:54:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236014AbjAEVyU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Jan 2023 16:54:20 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99B98676DC
        for <linux-fsdevel@vger.kernel.org>; Thu,  5 Jan 2023 13:54:18 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id a16so31190043qtw.10
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Jan 2023 13:54:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AiDogmSekfQ136iq07144KY/Kq2S6U3J1wMNG/6kVak=;
        b=fMVHXBR9f8COfqWuTLGIOdUfjxsWONJHOpmAedSE6QNMQXzIKWtSIeEaIowL951f6a
         v2/YTCyesQk0a+DcPRVmUX9F+EVNzVbxhY0/Wqa9dKGl36gIUUMd60gbkZsuFHkclYV3
         Tw1uzLULJMgrKgxKfeXDnbaa5pFPV+dBFzP0A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AiDogmSekfQ136iq07144KY/Kq2S6U3J1wMNG/6kVak=;
        b=n2lUmL2Jr4SfCsOixDA4cE2UcZw5k9JbbZ2T2jlmR2Y8ddvyZ0J69z7aVhOWaYdOha
         nEb5J/WA+l+3p3a/YcLKMFf9OKcQXrdHj08GOxJh7B3Dl0cHqc4SZUlXFASmQt1m0Z3x
         N57QDzySyKdWFsZbRDunp6m4RCaZS0qy1Nt0LjORheSeUWMfbiBcD0lHZ67QllMJm2nR
         Bdd7QquOn0L/hOIsGozo6dB5TR1MGqJG4KjEVS//l9Y0ZjriTI8wMHjPieK6EFkuemdh
         DIPQ1/N0Nc55PtDyskTK28P6I+dXUoUxTviAqt3oxBvP/8+ykGq/GbZ8etA9xp/oseNs
         HRJQ==
X-Gm-Message-State: AFqh2kr25mo57RO4QSiDY1rZqaW7tk1lhU5zXskqXDhFJg+LDYuuwLpF
        BXQE6NtFkvXWyNXSmbWsFbWe+jCovS7RCJAT
X-Google-Smtp-Source: AMrXdXtppo3vDPg0UJ3gRUD3eXx/emlo5kNn337PEJsCnGPlpsOGkAmtRLZfCzt6bQe1L9mp4dQahg==
X-Received: by 2002:a05:622a:230e:b0:3a7:e14e:9579 with SMTP id ck14-20020a05622a230e00b003a7e14e9579mr81403343qtb.29.1672955656984;
        Thu, 05 Jan 2023 13:54:16 -0800 (PST)
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com. [209.85.222.182])
        by smtp.gmail.com with ESMTPSA id fu22-20020a05622a5d9600b003a611cb2a95sm22303092qtb.9.2023.01.05.13.54.15
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Jan 2023 13:54:15 -0800 (PST)
Received: by mail-qk1-f182.google.com with SMTP id o14so18563067qkk.5
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Jan 2023 13:54:15 -0800 (PST)
X-Received: by 2002:a37:a93:0:b0:6ff:812e:a82f with SMTP id
 141-20020a370a93000000b006ff812ea82fmr2294231qkk.336.1672955655473; Thu, 05
 Jan 2023 13:54:15 -0800 (PST)
MIME-Version: 1.0
References: <000000000000dbce4e05f170f289@google.com> <5f45bb9a-5e00-48dd-82b0-46b19b1b98a3@app.fastmail.com>
 <CAHk-=wi8XyAUF9_z6-oa4Ava6PVZeE-=TVNcFK1puQHpOtqLLw@mail.gmail.com>
 <ab7a9477-ddc7-430f-b4ee-c67251e879b0@app.fastmail.com> <1bd49fc0-d64f-4eb8-841a-4b09e178b5fd@gmail.com>
In-Reply-To: <1bd49fc0-d64f-4eb8-841a-4b09e178b5fd@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 5 Jan 2023 13:53:59 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg3U3Y6eaura=xQzTsktpEOMETYYnue+_KSbQmpg7vZ0Q@mail.gmail.com>
Message-ID: <CAHk-=wg3U3Y6eaura=xQzTsktpEOMETYYnue+_KSbQmpg7vZ0Q@mail.gmail.com>
Subject: Re: [syzbot] [hfs?] WARNING in hfs_write_inode
To:     Michael Schmitz <schmitzmic@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        syzbot <syzbot+7bb7cd3595533513a9e7@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        christian.brauner@ubuntu.com,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        jlayton@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        Matthew Wilcox <willy@infradead.org>,
        ZhangPeng <zhangpeng362@huawei.com>,
        Viacheslav Dubeyko <slava@dubeyko.com>,
        linux-m68k@lists.linux-m68k.org, flar@allandria.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 5, 2023 at 1:35 PM Michael Schmitz <schmitzmic@gmail.com> wrote:
>
> Looking at Linus' patch, I wonder whether the missing fd.entrylength
> size test in the HFS_IS_RSRC(inode) case was due to the fact that a
> file's resource fork may be empty?

But if that is the case, then the subsequent hfs_bnode_read would
return garbage, no? And then writing it back after the update would be
even worse.

So adding that

+               if (fd.entrylength < sizeof(struct hfs_cat_file))
+                       goto out;

would seem to be the right thing anyway. No?

But I really don't know the code, so this is all from just looking at
it and going "that makes no sense". Maybe it _does_ make sense to
people who have more background on it.

             Linus
