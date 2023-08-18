Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60B90780CE5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Aug 2023 15:49:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377418AbjHRNsd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Aug 2023 09:48:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377386AbjHRNsL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Aug 2023 09:48:11 -0400
X-Greylist: delayed 485 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 18 Aug 2023 06:47:31 PDT
Received: from smtp-8fa9.mail.infomaniak.ch (smtp-8fa9.mail.infomaniak.ch [IPv6:2001:1600:3:17::8fa9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B18E49E9
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Aug 2023 06:47:31 -0700 (PDT)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4RS2zJ5fxXzMq65p;
        Fri, 18 Aug 2023 13:39:24 +0000 (UTC)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4RS2zJ1F9Vz3W;
        Fri, 18 Aug 2023 15:39:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1692365964;
        bh=UWIxdFLVfrHT7rkE+syTuIU+IUhfKVPgorQTBQrhIlM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S3fSl59xevy+7I4RkWjXq7KYI+4RATl/xWaB8PHzYgzsa0n49BngWU0UdU2aVY6tg
         VTt1Ne5gyQridX8p5evxsy/ReKN1mXrMt5zT93jBb1/zyomzuYN4m1hkt3gJ5PzIfR
         EEyBHVb+AnR/ORZ7hC65ho7Q1nsH8FvSxNbKsBg8=
Date:   Fri, 18 Aug 2023 15:39:19 +0200
From:   =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To:     =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
Cc:     linux-security-module@vger.kernel.org, Jeff Xu <jeffxu@google.com>,
        Jorge Lucangeli Obes <jorgelo@chromium.org>,
        Allen Webb <allenwebb@google.com>,
        Dmitry Torokhov <dtor@google.com>,
        Paul Moore <paul@paul-moore.com>,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        Matt Bobrowski <repnop@google.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 0/5] Landlock: IOCTL support
Message-ID: <20230818.iechoCh0eew0@digikod.net>
References: <20230814172816.3907299-1-gnoack@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230814172816.3907299-1-gnoack@google.com>
X-Infomaniak-Routing: alpha
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 14, 2023 at 07:28:11PM +0200, Günther Noack wrote:
> Hello!
> 
> These patches add simple ioctl(2) support to Landlock.
> 

[...]

> How we arrived at the list of always-permitted IOCTL commands
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> To decide which IOCTL commands should be blanket-permitted I went through the
> list of IOCTL commands mentioned in fs/ioctl.c and looked at them individually
> to understand what they are about.  The following list is my conclusion from
> that.
> 
> We should always allow the following IOCTL commands:
> 
>  * FIOCLEX, FIONCLEX - these work on the file descriptor and manipulate the
>    close-on-exec flag
>  * FIONBIO, FIOASYNC - these work on the struct file and enable nonblocking-IO
>    and async flags
>  * FIONREAD - get the number of bytes available for reading (the implementation
>    is defined per file type)

I think we should treat FIOQSIZE like FIONREAD, i.e. check for
LANDLOCK_ACCESS_FS_READ_FILE as explain in my previous message.
Tests should then rely on something else.

[...]

> Changes
> ~~~~~~~
> 
> V3:
>  * always permit the IOCTL commands FIOCLEX, FIONCLEX, FIONBIO, FIOASYNC and
>    FIONREAD, independent of LANDLOCK_ACCESS_FS_IOCTL
>  * increment ABI version in the same commit where the feature is introduced
>  * testing changes
>    * use FIOQSIZE instead of TTY IOCTL commands
>      (FIOQSIZE works with regular files, directories and memfds)
>    * run the memfd test with both Landlock enabled and disabled
>    * add a test for the always-permitted IOCTL commands
