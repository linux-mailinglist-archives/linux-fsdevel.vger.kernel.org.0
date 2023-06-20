Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57501736DC2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jun 2023 15:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233119AbjFTNsR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Jun 2023 09:48:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233161AbjFTNsN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Jun 2023 09:48:13 -0400
Received: from forward502b.mail.yandex.net (forward502b.mail.yandex.net [IPv6:2a02:6b8:c02:900:1:45:d181:d502])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 146901B6;
        Tue, 20 Jun 2023 06:47:44 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-90.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-90.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:2505:0:640:a85f:0])
        by forward502b.mail.yandex.net (Yandex) with ESMTP id 9C8C95ECEC;
        Tue, 20 Jun 2023 16:47:34 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-90.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id VlhAhMiWkGk0-SGMglbM2;
        Tue, 20 Jun 2023 16:47:33 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1687268854;
        bh=Rr4hsTfTLT33LbrU7L4vWcoYlqbg8c6p38egzx11+3M=;
        h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
        b=I9j8WBvGiB/0yyKXb68uOQNJ65a3hINN8DfE4EBy/22PbDy7R/nTW63x5F9efc8Gu
         jJFJllEiKiZPhC1yetAf8qT85xHsg3/W/5Xq4KxIHM+r6+0NZCiX58FuiLLW0bJP+1
         g+prqW6cVxGfvb5ojkuC2SHmYSRuME8dBWMs+550=
Authentication-Results: mail-nwsmtp-smtp-production-main-90.myt.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <cb88d464-30d8-810e-f3c4-35432d12a32d@yandex.ru>
Date:   Tue, 20 Jun 2023 18:47:31 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 2/3] fd/locks: allow get the lock owner by F_OFD_GETLK
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org,
        Chuck Lever <chuck.lever@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org
References: <20230620095507.2677463-1-stsp2@yandex.ru>
 <20230620095507.2677463-3-stsp2@yandex.ru>
 <5728ebda22a723b0eb209ae078e8f132d7b4ac7b.camel@kernel.org>
 <a1e7f5c1-76ef-19e5-91db-a62f7615b28a@yandex.ru>
 <eaccc14ddc6b546e5913eb557fec55f77cb5424d.camel@kernel.org>
 <5f644a24-90b5-a02f-b593-49336e8e0f5a@yandex.ru>
 <2eb8566726e95a01536b61a3b8d0343379092b94.camel@kernel.org>
 <d70b6831-3443-51d0-f64c-6f6996367a85@yandex.ru>
 <d0c18369245db91a3b78017fabdc81417418af67.camel@kernel.org>
 <ddb48e05-ab26-ae5d-86d5-01e47f0f0cd2@yandex.ru>
 <ZJGtmrej8LraEsjj@casper.infradead.org>
From:   stsp <stsp2@yandex.ru>
In-Reply-To: <ZJGtmrej8LraEsjj@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


20.06.2023 18:46, Matthew Wilcox пишет:
> On Tue, Jun 20, 2023 at 06:39:07PM +0500, stsp wrote:
>> Though it will, for sure, represent the
>> task that _owns_ the lock.
> No, it *DOESN'T*.  I can open a file, SCM_RIGHTS pass it to another task
> and then exit.  Now the only owner of that lock is the recipient ...
Won't I get the recipient's pid in an
l_pid then?
