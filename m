Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 692364E4CFC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Mar 2022 07:57:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241989AbiCWG65 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Mar 2022 02:58:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234794AbiCWG6z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Mar 2022 02:58:55 -0400
Received: from mail.parknet.co.jp (mail.parknet.co.jp [210.171.160.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C542071EF0
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Mar 2022 23:57:26 -0700 (PDT)
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
        by mail.parknet.co.jp (Postfix) with ESMTPSA id B623915F939;
        Wed, 23 Mar 2022 15:57:25 +0900 (JST)
Received: from devron.myhome.or.jp (foobar@devron.myhome.or.jp [192.168.0.3])
        by ibmpc.myhome.or.jp (8.16.1/8.16.1/Debian-2) with ESMTPS id 22N6vLaG107150
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Wed, 23 Mar 2022 15:57:22 +0900
Received: from devron.myhome.or.jp (foobar@localhost [127.0.0.1])
        by devron.myhome.or.jp (8.16.1/8.16.1/Debian-2) with ESMTPS id 22N6vLW3364540
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Wed, 23 Mar 2022 15:57:21 +0900
Received: (from hirofumi@localhost)
        by devron.myhome.or.jp (8.16.1/8.16.1/Submit) id 22N6vKLB364539;
        Wed, 23 Mar 2022 15:57:20 +0900
From:   OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To:     Chung-Chiang Cheng <shepjeng@gmail.com>
Cc:     Chung-Chiang Cheng <cccheng@synology.com>,
        linux-fsdevel@vger.kernel.org, kernel@cccheng.net
Subject: Re: [PATCH 2/2] fat: introduce creation time
References: <20220321095814.175891-1-cccheng@synology.com>
        <20220321095814.175891-2-cccheng@synology.com>
        <87lex2e91h.fsf@mail.parknet.co.jp>
        <CAHuHWtkvt4wOdwaoyYv0B4862pSYttMBh6BUz3vHbERv+CEGaw@mail.gmail.com>
Date:   Wed, 23 Mar 2022 15:57:20 +0900
In-Reply-To: <CAHuHWtkvt4wOdwaoyYv0B4862pSYttMBh6BUz3vHbERv+CEGaw@mail.gmail.com>
        (Chung-Chiang Cheng's message of "Wed, 23 Mar 2022 10:14:14 +0800")
Message-ID: <87sfr917hr.fsf@mail.parknet.co.jp>
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

>> Yes, ctime is issue (include compatibility issue when changing) from
>> original author of this driver. And there is no perfect solution and
>> subtle issue I think.
>>
>> I'm not against about this change though, this behavior makes utimes(2)
>> behavior strange, e.g. user can change ctime, but FAT forget it anytime,
>> because FAT can't save it.
>>
>> Did you consider about those behavior and choose this?
>
> Yes. I think it's not perfect but a better choice to distinguish between
> change-time and creation-time. While change-time is no longer saved to
> disk, the new behavior maintains the semantic of "creation" and is more
> compatible with non-linux systems.

Ok, right, creation time is good. But what I'm saying is about new ctime
behavior.

Now, you allow to change ctime as old behavior, but it is not saved. Why
this behavior was preferred?

Just for example, I think we can ignore ctime change, and define new
behavior is as ctime==mtime always. This will prevent time wrap/backward
etc.

Thanks.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
