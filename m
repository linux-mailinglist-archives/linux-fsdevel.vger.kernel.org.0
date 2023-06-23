Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E233973B4AA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jun 2023 12:09:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbjFWKJa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Jun 2023 06:09:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231424AbjFWKJO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Jun 2023 06:09:14 -0400
X-Greylist: delayed 62093 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 23 Jun 2023 03:07:49 PDT
Received: from forward502b.mail.yandex.net (forward502b.mail.yandex.net [IPv6:2a02:6b8:c02:900:1:45:d181:d502])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3791D10F1;
        Fri, 23 Jun 2023 03:07:49 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-36.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-36.sas.yp-c.yandex.net [IPv6:2a02:6b8:c08:a497:0:640:fcbf:0])
        by forward502b.mail.yandex.net (Yandex) with ESMTP id 6CAAA5E6F7;
        Fri, 23 Jun 2023 13:07:46 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-36.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id h7EVnbTDUqM0-ElAawmfA;
        Fri, 23 Jun 2023 13:07:45 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1687514865;
        bh=ypufzCakK8SokYucAEE7VSUnBPAaMt3NHttyycgl8oQ=;
        h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
        b=BcbxT0a4yghZPCJpFPVDIzZh0rtc6FX4SgQteBgtMRRa+lSqA8E6v9++RJqVCpiO0
         2KcAUYG9ijvExnhW1VTNx6S3kgFoE29MJF0SI3xzJ1IuxoPgCuft9Tk1Jqzwa93PAb
         Wa4uosc0RQhGqDoyGO0SvkQwDYg6RV4wZojPdhnI=
Authentication-Results: mail-nwsmtp-smtp-production-main-36.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <12ea42ec-95f3-6213-95e8-77c5ad64da25@yandex.ru>
Date:   Fri, 23 Jun 2023 15:07:43 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] fcntl.2: document F_UNLCK F_OFD_GETLK extension
Content-Language: en-US
To:     Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org, linux-api@vger.kernel.org
References: <20230621152214.2720319-1-stsp2@yandex.ru>
 <20230621152214.2720319-4-stsp2@yandex.ru>
 <3719669bc40890e3a8221593ff8a178411ad749b.camel@kernel.org>
From:   stsp <stsp2@yandex.ru>
In-Reply-To: <3719669bc40890e3a8221593ff8a178411ad749b.camel@kernel.org>
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


22.06.2023 17:03, Jeff Layton пишет:
> We need to be pedantic for manpages. A "file description" is the
> representation of the open file in the kernel (basically, the "struct
> file" in the kernel). A file _descriptor_ is the numeric identifier
> returned by open() and similar functions.

OK.


> The locks are owned by the file description, so that would be the better
> term to use here. I think you want something like:
>
> "When the l_type is set to F_UNLCK, returned locks are limited to ones
> set on the given file description.
This is also inaccurate, because "limited"
implies other operations act widely.
But actually other operations do not
consider the "same fd" at all. So the
reported sets by F_UNLCK and other
ops do not overlap. Which is why I
decided to describe it as a "special
meaning".
