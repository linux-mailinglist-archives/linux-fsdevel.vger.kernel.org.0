Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 199D9736B57
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jun 2023 13:45:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232766AbjFTLpb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Jun 2023 07:45:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232774AbjFTLp2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Jun 2023 07:45:28 -0400
X-Greylist: delayed 2682 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 20 Jun 2023 04:45:23 PDT
Received: from forward502b.mail.yandex.net (forward502b.mail.yandex.net [IPv6:2a02:6b8:c02:900:1:45:d181:d502])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 514B0172E;
        Tue, 20 Jun 2023 04:45:23 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-84.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-84.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:332f:0:640:4ab4:0])
        by forward502b.mail.yandex.net (Yandex) with ESMTP id 4A74C5EED2;
        Tue, 20 Jun 2023 14:45:19 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-84.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id HjfjJSpWl0U0-wUWdqa9A;
        Tue, 20 Jun 2023 14:45:18 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1687261518;
        bh=sy+CJgdIdcZUFxJ4WQL0cSo0CwChT2uhxEUrKoqH9no=;
        h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
        b=O8MxQZgQ7ROlR94lHObblR00iiEZVoP3C9fTG3+2pbFzZWDkmxv/RNXdCB+M63rfi
         8+/tgX3nwDpl/9jxNkwbdt/bTekwykh5Gevd8415wKOC08eVVEi/g0H3muo94nMVpW
         621INpeHqBHt1054zLsOPhSt+L0EtrMEBQfU7lS4=
Authentication-Results: mail-nwsmtp-smtp-production-main-84.iva.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <5f644a24-90b5-a02f-b593-49336e8e0f5a@yandex.ru>
Date:   Tue, 20 Jun 2023 16:45:16 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 2/3] fd/locks: allow get the lock owner by F_OFD_GETLK
Content-Language: en-US
To:     Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org
References: <20230620095507.2677463-1-stsp2@yandex.ru>
 <20230620095507.2677463-3-stsp2@yandex.ru>
 <5728ebda22a723b0eb209ae078e8f132d7b4ac7b.camel@kernel.org>
 <a1e7f5c1-76ef-19e5-91db-a62f7615b28a@yandex.ru>
 <eaccc14ddc6b546e5913eb557fec55f77cb5424d.camel@kernel.org>
From:   stsp <stsp2@yandex.ru>
In-Reply-To: <eaccc14ddc6b546e5913eb557fec55f77cb5424d.camel@kernel.org>
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


20.06.2023 16:12, Jeff Layton пишет:
> Multithreaded processes are also a bit of a gray area here: Suppose I
> open a file and set an OFD lock on it in one task, and then let that
> task exit while the file is still open. What should l_pid say in that
> case?

If by the "task" you mean a process, then
the result should be no lock at all.
If you mean the thread exit, then I would
expect l_pid to contain tgid, in which case
it will still point to the valid pid.
Or do you mean l_pid contains tid?
Checking... no, l_pid contains tgid.
So I don't really see the problem you are
pointing with the above example, could
you please clarify?

