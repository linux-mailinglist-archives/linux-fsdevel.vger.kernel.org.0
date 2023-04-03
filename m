Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 526246D3D42
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Apr 2023 08:24:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231532AbjDCGYI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Apr 2023 02:24:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231523AbjDCGYG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Apr 2023 02:24:06 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02D0B9746
        for <linux-fsdevel@vger.kernel.org>; Sun,  2 Apr 2023 23:24:01 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id by14so9957421ljb.12
        for <linux-fsdevel@vger.kernel.org>; Sun, 02 Apr 2023 23:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680503039;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=W7w4rGa/weBc1zd5RCUfFwg9my+z3GfiaxEfVPR6qPM=;
        b=XAde3x1gIDwAVlFF6Q2P0euzBv22cdcnPyHN0iV3N2ZxoaWO7DDwOYRLlJRLMS9Hx2
         W6pn7qC0dSgPm3YAY0bsSYuAnUPuL0gQNtPvH9s81sgoMV9t+yTO0XRhExmwp3gH2mqM
         ssyxL1PzI1rgm83o5pzuoL3G9hViHkHKiKcrjsLbd5jgV9uGDO7vVkGz2EYVUgTnBchR
         TndVJ3G6skkMYkpZQzqyFbm6u+v7gNFPtHn/G9MUc+TeqtP5XWPk0MrU+XoHpGU1qz30
         opuNj1qW/l3dwo4ZGpT0uWFZUc7NLNB4dp5i/cbm85wFMlrKVzM6wKRVrWSdiaWoGHwE
         7ung==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680503039;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W7w4rGa/weBc1zd5RCUfFwg9my+z3GfiaxEfVPR6qPM=;
        b=zmVRlRR2vwT0mUIDDMVgfmb66UDSGvdtxLtsChZzLWGdjwEyq4LRvoU/zp0l4gTHcN
         uwZNgMG3cBfg768FnQv4cs2hb8ETEFlRMPGJBr4RRLleTrP5FQcl7QqTIjUjPepC5art
         rS0SuBreyqObLoKvrf1UNUtsKN5NMMQVxOLfpkQ9+JfnNfyDj+n0JPelVD9QSLeVbtyT
         9GTAMzXHU/+oVd/G48iNHFiEZPMvEsmRWKoQEdrr4UlcpqPaHIhqvCq6e0ermcnUinxt
         IrgrpBR/nU4t/Y539mobWYFr+s5B6rbwdvXUqkrETwH9LJdNDrsPEcY2i9zn13uY52xa
         BPQg==
X-Gm-Message-State: AAQBX9cbWl7gFvbgGcuSAPIdpbGuMXZpo2+Lgt0rF6IMdUCCEa/DPIQ9
        7RrmAsIgMQZqtwKbTDDaNdNkkdgf+tnRNXEzbjTPabupEpaJlnt3pFd9gw==
X-Google-Smtp-Source: AKy350bJP8hcMb0K78DAucUuYayCrBxYFM/TvgmfmxSZKvb+iazC1gPiY1hRi8e9bdoSA0h6qpcLdhF83FqJ5pksWI0=
X-Received: by 2002:a05:651c:104d:b0:298:b32c:e4f0 with SMTP id
 x13-20020a05651c104d00b00298b32ce4f0mr10594874ljm.8.1680503038799; Sun, 02
 Apr 2023 23:23:58 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000b9753505eaa93b18@google.com> <00000000000084824b05f7a66a52@google.com>
In-Reply-To: <00000000000084824b05f7a66a52@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 3 Apr 2023 08:23:46 +0200
Message-ID: <CACT4Y+aPAjP_2ay89aqTzZxaGEMX9rNncJOfaw9++gOsADZyzw@mail.gmail.com>
Subject: Re: [syzbot] [cluster?] possible deadlock in freeze_super (2)
To:     syzbot <syzbot+be899d4f10b2a9522dce@syzkaller.appspotmail.com>
Cc:     agruenba@redhat.com, cluster-devel@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        rpeterso@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 24 Mar 2023 at 15:43, syzbot
<syzbot+be899d4f10b2a9522dce@syzkaller.appspotmail.com> wrote:
>
> syzbot suspects this issue was fixed by commit:
>
> commit b66f723bb552ad59c2acb5d45ea45c890f84498b
> Author: Andreas Gruenbacher <agruenba@redhat.com>
> Date:   Tue Jan 31 14:06:53 2023 +0000
>
>     gfs2: Improve gfs2_make_fs_rw error handling
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=117e2e29c80000
> start commit:   4a7d37e824f5 Merge tag 'hardening-v6.3-rc1' of git://git.k..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=8b969c5af147d31c
> dashboard link: https://syzkaller.appspot.com/bug?extid=be899d4f10b2a9522dce
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11484328c80000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=127093a0c80000
>
> If the result looks correct, please mark the issue as fixed by replying with:
>
> #syz fix: gfs2: Improve gfs2_make_fs_rw error handling
>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection

Looks reasonable:

#syz fix: gfs2: Improve gfs2_make_fs_rw error handling
