Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A7CE686103
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Feb 2023 08:55:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231992AbjBAHzD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Feb 2023 02:55:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231947AbjBAHzB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Feb 2023 02:55:01 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A097974C
        for <linux-fsdevel@vger.kernel.org>; Tue, 31 Jan 2023 23:55:00 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id bp15so27959634lfb.13
        for <linux-fsdevel@vger.kernel.org>; Tue, 31 Jan 2023 23:55:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AhWiO+p9x9WvJVlyCm4UKDXTp9wp+AugKSgLzsEWkSM=;
        b=OdJg2J6Fq6RC82L5qiRdzhcICkRaa401c3XJ2z4UaFlMfxJKql91GEJx7wXFlJVWE9
         0A6Om5ynV19o1g4U4YEgXL3F9N3M2qWRW235OQjFfXjasRJ6/l0jk8NLK0KfiL4rrtdU
         Pf9qXK4GH8MMjaWRpP7xFI2T5uA1Kq4pPdMej6r+Zd6XVOc3U/u4q8H0oVYNnFUAdLJK
         kW8F9YgI5S9MNzkGn0k3dA0kbR/dejUsXZF2EpBwuhpXbp6cp+S0JHdpLllffej2Yxv+
         hrzcJLTbqGW2N53Vy5oy40/ehsFCWUFmVi3Ps7oGUo90bHhBIwfDnTHGH4s0Z3Of5RKH
         XVoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AhWiO+p9x9WvJVlyCm4UKDXTp9wp+AugKSgLzsEWkSM=;
        b=B7ySManqmUqDqrSmOsRx9fhCHaVv3ZrFIzPXuJcFZBPBfDCob9MBub0fF2kyDHRBiF
         JkSqkozCFg44Q9f+ytpmU3aczyV354GSKZD0Zf7ZsPjXErhfSYcKi32Bi0D2qmVHDqgm
         Tl/PJYgNbL/I1CsZ7VhDq6yv0QgTi23PMsMGmIv+pB7Y0rE6uKTQ3D425RgUpnm/bWFX
         NMwVsbKzCqX28sTuPyTi87vYtNaQqrBMiu23xjvHj913H+GgdCmzJJt1cbyk/g4AbWrD
         x166YxzJsXqw/ZMt0ujrF+ha0lOPzMa/iOuOWL0aeJb0GWSiJDDgT33CqZZ+3dIwT8ty
         bMbA==
X-Gm-Message-State: AO0yUKUPwrXB9Zz87jSPMp63zYX5vwh1jMKHE9cfCjjddADF0Y6SPanH
        7xza2EzpIqrFRe39/W4tKzrI96G7PUo4iomkQxZxPw==
X-Google-Smtp-Source: AK7set8NtXvm0jBebiwKSfALgi6I403BGuRww4o1r00RYIWc+fbOyjqqE766o8ePH49oxCqyY/IBFexla9RPfxtC6LA=
X-Received: by 2002:ac2:5336:0:b0:4b5:2aed:39be with SMTP id
 f22-20020ac25336000000b004b52aed39bemr206347lfh.195.1675238098213; Tue, 31
 Jan 2023 23:54:58 -0800 (PST)
MIME-Version: 1.0
References: <000000000000d7eced05f01fa8d0@google.com> <000000000000171a2805f38bf07a@google.com>
In-Reply-To: <000000000000171a2805f38bf07a@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 1 Feb 2023 08:54:46 +0100
Message-ID: <CACT4Y+ZRU8PZVNEyuWr_CMqyGHtV8O9vG_kf7zQK3uhbQ=0pKg@mail.gmail.com>
Subject: Re: [syzbot] KASAN: slab-out-of-bounds Read in mi_find_attr
To:     syzbot <syzbot+8ebb469b64740648f1c3@syzkaller.appspotmail.com>
Cc:     almaz.alexandrovich@paragon-software.com, edward.lo@ambergroup.io,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        ntfs3@lists.linux.dev, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-15.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SORTED_RECIPS,SPF_HELO_NONE,
        SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 31 Jan 2023 at 10:27, syzbot
<syzbot+8ebb469b64740648f1c3@syzkaller.appspotmail.com> wrote:
>
> syzbot suspects this issue was fixed by commit:
>
> commit 4f1dc7d9756e66f3f876839ea174df2e656b7f79
> Author: Edward Lo <edward.lo@ambergroup.io>
> Date:   Fri Sep 9 01:04:00 2022 +0000
>
>     fs/ntfs3: Validate attribute name offset
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12e74535480000
> start commit:   e2ca6ba6ba01 Merge tag 'mm-stable-2022-12-13' of git://git..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=a6133b41a9a0f500
> dashboard link: https://syzkaller.appspot.com/bug?extid=8ebb469b64740648f1c3
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16fb2ad0480000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=164513e0480000
>
> If the result looks correct, please mark the issue as fixed by replying with:
>
> #syz fix: fs/ntfs3: Validate attribute name offset
>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection

Looks reasonable, let's close the bug report:

#syz fix: fs/ntfs3: Validate attribute name offset
