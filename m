Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53ED8B0984
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2019 09:32:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726922AbfILHcM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Sep 2019 03:32:12 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:46262 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbfILHcM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Sep 2019 03:32:12 -0400
Received: by mail-io1-f68.google.com with SMTP id d17so30317774ios.13
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Sep 2019 00:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zL9levB8lFuZ1DGW4jo3XGnWPG/tv2565iTsfF4DA7I=;
        b=IscHHB2OAm/uAe4mcsSW58kB7QhJwwHFHuB0Aq8bLR4mPg84nca7xRBeq2oONfkBGz
         2l4J9BXwV86rz/UbsRzjBopdbNertMf7Z0wjaWAaEy5Sgvyg6sYCEjcV1dzNX6Azizw+
         7DUd3jIZJQxjfIm6d9JLdxGrkhA4cwQR/gL/4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zL9levB8lFuZ1DGW4jo3XGnWPG/tv2565iTsfF4DA7I=;
        b=gjvQ+ydob8KikWvDYqlTSBLz1ZtBABNVTXMJp79Jbz3FW5JocHlWzD5TenUuWtJ+/V
         dfRNBsolpubznbUiS2QH45ltotjpUvgzo1HLmDdZ+sXZfRNQ0LZumvNTMlukiu5XaJOT
         VR+jdpGDULZOq3tGS47/B3laD1rHR6yZlBBaIuOhZ5GTEHHcu09bgEkKegQAlKayvDpy
         q8mTVBNv9tO0c+b4zv41kUyaBkk5/ATvghUYOEfW04ILeyfylQdxnYmQQftCMW+25l8c
         kebsX5HMmd+BZKtMvtPYjaIw7R2WRGrc8ifRnEaoSa/NMZQIem7x4J3Zbon1XkReCRJU
         zrDw==
X-Gm-Message-State: APjAAAVKq1zDF1fUgvp/RlWAuv9e5JZW05gN68i+XNJjMovkDHewL+vR
        XhJw56MFZNb/ejwEHmjVp3IKfBMlcrn6rwTAv+UYqA==
X-Google-Smtp-Source: APXvYqwnvHRA+wVFM3ppHtZ/JOGX6430u6JIuJdiOHb3e3CdtB05Vy/IcDbz+i85Aq9Cp7N7vnhffuZWK1V26vvXJI4=
X-Received: by 2002:a6b:bec6:: with SMTP id o189mr2602814iof.62.1568273531464;
 Thu, 12 Sep 2019 00:32:11 -0700 (PDT)
MIME-Version: 1.0
References: <1568196917-25674-1-git-send-email-chakragithub@gmail.com>
 <CAJfpegtDZ2ShAwkJ4hbj=sGM96QumWzzg8WsX42=AY2117p3+w@mail.gmail.com> <CAH7=fot46GSdanJg9P2rRKrxWnpZq7+vW2CVhtZvGzKTzk__nA@mail.gmail.com>
In-Reply-To: <CAH7=fot46GSdanJg9P2rRKrxWnpZq7+vW2CVhtZvGzKTzk__nA@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 12 Sep 2019 09:32:00 +0200
Message-ID: <CAJfpeguLbiJt0L5cZjZTkXcGMHHviSdQV=yEei6FgRi23DBTMQ@mail.gmail.com>
Subject: Re: [PATCH] fuse:send filep uid as part of fuse write req
To:     Chakra Divi <chakragithub@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 12, 2019 at 6:59 AM Chakra Divi <chakragithub@gmail.com> wrote:
>
> Hi Miklos,
>
> On Wed, Sep 11, 2019 at 5:05 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
>>
>> On Wed, Sep 11, 2019 at 12:15 PM Chakra Divi <chakragithub@gmail.com> wrote:
>> >
>> > In current code in fuse write request current_fsuid is sent,
>> > however this creates an issue in sudo execution context.
>> > Changes to consider uid and gid from file struture pointer
>> > that is created as part of open file instead of current_fsuid,gid
>> >
>> > Steps to reproduce the issue:
>> > 1) create user1 and user2
>> > 2) create a file1 with user1 on fusemount
>> > 3) change the file1 permissions to 600
>> > 4) execute the following command
>> > user1@linux# sudo -u user2 whoami >> /fusemnt/file1
>> > Here write fails with permission denied error
>>
>> Not sure what's the issue here.  If filesystem wants to check open
>> creds, it should do so with the creds sent at open.
>>
>> Does that solve your problem?
>>
>
> Are you saying that our filesystem should store the credentials in open call,  ignore the credentials in write request and use open credentials instead

Yes.  And even that would be dubious in case of mmap-ed writes or with
FUSE_WRITEBACK_CACHE because the information about which open file
instance received the modification is lost.

So generally credential checking on writeback is useless.  Not sure
what NFS does, because there's no way to get around those rules.

Thanks,
Miklos
