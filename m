Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3DD34E7165
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Mar 2022 11:36:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349965AbiCYKiR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Mar 2022 06:38:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358922AbiCYKhw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Mar 2022 06:37:52 -0400
Received: from mail.parknet.co.jp (mail.parknet.co.jp [210.171.160.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CC02EB6D33
        for <linux-fsdevel@vger.kernel.org>; Fri, 25 Mar 2022 03:36:18 -0700 (PDT)
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
        by mail.parknet.co.jp (Postfix) with ESMTPSA id CE3CF15F939;
        Fri, 25 Mar 2022 19:36:17 +0900 (JST)
Received: from devron.myhome.or.jp (foobar@devron.myhome.or.jp [192.168.0.3])
        by ibmpc.myhome.or.jp (8.16.1/8.16.1/Debian-2) with ESMTPS id 22PAaGkh043315
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Fri, 25 Mar 2022 19:36:17 +0900
Received: from devron.myhome.or.jp (foobar@localhost [127.0.0.1])
        by devron.myhome.or.jp (8.16.1/8.16.1/Debian-2) with ESMTPS id 22PAaGB5151513
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Fri, 25 Mar 2022 19:36:16 +0900
Received: (from hirofumi@localhost)
        by devron.myhome.or.jp (8.16.1/8.16.1/Submit) id 22PAaGWQ151512;
        Fri, 25 Mar 2022 19:36:16 +0900
From:   OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To:     Chung-Chiang Cheng <shepjeng@gmail.com>
Cc:     Chung-Chiang Cheng <cccheng@synology.com>,
        linux-fsdevel@vger.kernel.org, kernel@cccheng.net
Subject: Re: [PATCH 2/2] fat: introduce creation time
References: <20220321095814.175891-1-cccheng@synology.com>
        <20220321095814.175891-2-cccheng@synology.com>
        <87lex2e91h.fsf@mail.parknet.co.jp>
        <CAHuHWtkvt4wOdwaoyYv0B4862pSYttMBh6BUz3vHbERv+CEGaw@mail.gmail.com>
        <87sfr917hr.fsf@mail.parknet.co.jp>
        <CAHuHWtk1-AdKoa-SBOb=sJAM=32reVzcUQYjrrxvOPYwFZJqXQ@mail.gmail.com>
        <87o81x0wdv.fsf@mail.parknet.co.jp>
        <CAHuHWtm5qdJm0wmjMbauRERg4hJYv7EWTtA6-0n9Ss9p=OtOqw@mail.gmail.com>
Date:   Fri, 25 Mar 2022 19:36:16 +0900
In-Reply-To: <CAHuHWtm5qdJm0wmjMbauRERg4hJYv7EWTtA6-0n9Ss9p=OtOqw@mail.gmail.com>
        (Chung-Chiang Cheng's message of "Fri, 25 Mar 2022 15:38:29 +0800")
Message-ID: <87cziapbdr.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/29.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Chung-Chiang Cheng <shepjeng@gmail.com> writes:

> On Wed, Mar 23, 2022 at 6:57 PM OGAWA Hirofumi
> <hirofumi@mail.parknet.co.jp> wrote:
>>
>> No, a user can change the ctime to arbitrary time, and after the your
>> patch, the changed ctime only hold on a memory inode. So a user sees
>> ctime jump backward and forward when a memory inode is expired. (Of
>> course, this happens just by "cp -a" in real world use case.)
>>
>> I'm pointing about this introduced new behavior by your patch.
>>
>
> As you mentioned, there are still some cases to consider that ctime
> isn't identical to mtime. If so, ctime won't be consistent after
> inode is expired because it will be filled with the value of on-disk
> mtime, which is weird and confusing.
>
> To solve the issue, I propose to keep ctime and mtime always the same
> in memory. If you agree with this approach, I'll send a v2 patch for
> it.

Yes, exactly.

Although I think it is better, in real world userspace, it may got
actual compatibility issue and reported, then we may have to revert even
if I personally think new is better.

Thanks.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
