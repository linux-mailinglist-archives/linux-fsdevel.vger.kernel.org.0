Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24D8F736BFB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jun 2023 14:34:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232626AbjFTMeb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Jun 2023 08:34:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231805AbjFTMea (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Jun 2023 08:34:30 -0400
Received: from forward502c.mail.yandex.net (forward502c.mail.yandex.net [178.154.239.210])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0764410DA;
        Tue, 20 Jun 2023 05:34:27 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-63.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-63.sas.yp-c.yandex.net [IPv6:2a02:6b8:c14:6e01:0:640:627f:0])
        by forward502c.mail.yandex.net (Yandex) with ESMTP id 0F98F5E8DC;
        Tue, 20 Jun 2023 15:34:22 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-63.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 5Ygda0tDguQ0-z3EyeGZo;
        Tue, 20 Jun 2023 15:34:21 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1687264461;
        bh=djyFSMQCvvi3PtQek0qog/X/Y7hUR7MnMTmzr3nhW4g=;
        h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
        b=nObO3tXw07UF99ZwPSgfjLyWQ6W5or7uUaW9qg/A9XS4ufoP7v0XmdeIhYXT3Q7jO
         9036yWJW/zNO05uL8vNS0vIIV7gJvV5AESjcLKVqELuqzkDbjjAe1YdUNydqLiIcdQ
         Pn2aHPUXgrgschLMqNT6dzUSgnzMnImKEs2NAOOg=
Authentication-Results: mail-nwsmtp-smtp-production-main-63.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <d70b6831-3443-51d0-f64c-6f6996367a85@yandex.ru>
Date:   Tue, 20 Jun 2023 17:34:00 +0500
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
 <5f644a24-90b5-a02f-b593-49336e8e0f5a@yandex.ru>
 <2eb8566726e95a01536b61a3b8d0343379092b94.camel@kernel.org>
From:   stsp <stsp2@yandex.ru>
In-Reply-To: <2eb8566726e95a01536b61a3b8d0343379092b94.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


20.06.2023 17:02, Jeff Layton пишет:
> Suppose I start a process (call it pid 100), and then spawn a thread
> (101). I then have 101 open a file and set an OFD lock on it (such that
> the resulting fl_pid field in the file_lock is set to 101).

How come?
There are multiple places in locks.c
with this line:
fl->fl_pid = current->tgid;

And I've yet to see the line like:
fl->fl_pid = current->pid;
Its simply not there.

No, we put tgid into l_pid!
tgid will still be 100, no matter how
many threads you spawn or destroy.
Or what am I misseng?


> That's just one example, of course. The underlying problem is that OFD
> locks are not owned by processes in the same way that traditional POSIX
> locks are, so reporting a pid there is unreliable, at best.
But we report tgid.
It doesn't depend on threads.
I don't understand. :)
