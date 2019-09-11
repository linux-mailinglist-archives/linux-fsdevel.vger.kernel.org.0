Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6EE6FAFB6D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Sep 2019 13:35:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbfIKLfT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Sep 2019 07:35:19 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:32971 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726198AbfIKLfT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Sep 2019 07:35:19 -0400
Received: by mail-io1-f67.google.com with SMTP id m11so45022636ioo.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Sep 2019 04:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GxmiO76eLb7Yn+I6DMFvuIcRN98HRs7OAvn1LD8HXMo=;
        b=AYF0+hILvGmRNmrXxcKQ/vQmD1gCB2efW9zfk4QT7AvPvJaVSgjiN0yHQLqNknuekT
         hgyEZMOVq06Uu/g9tFeli+khBQ2A1JWlJ8d3cOF/GmFqwe8LrYZdHkyyJlarVOs2QWM1
         v6WCQ0TVKlOb7QI9IOaAoZ2iRDmaZt+dx5oSg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GxmiO76eLb7Yn+I6DMFvuIcRN98HRs7OAvn1LD8HXMo=;
        b=iUgQ9wtgxo3ivacoXZQ+evDTJXOZNkUOVcs/rq8IVkqmT3HEGLUhX4cWku9E5bHWdL
         wQE2CvLpipOUJDAN6Kr8M1FNLtc/m+2vAFJS8Fbmf2n7c5kIPpMfNJiMA1fPj0A1E9nd
         IJEJS06do+PKFZ0AzXOrNG3Eh7IMq6DrtlQwtSL7aPmDwCV9UoV9TNbLWZ4sCKk6citU
         nv49yUBxUKhzaRZSaQUz+2uhL+JKYbcSIAG7EKHbPMNWhB43YAyxydePCuwsuhUmG/ja
         kNRbarksLmghEkN74dBej0rShyPv+VxABNpU5TS2znYTGdHj6iaA7j0S6bHW1rtp9cel
         l2HQ==
X-Gm-Message-State: APjAAAWX6mP+MItOqjmDwfGBYVBvXSIY4DITDm70AwMx10HbIKFrGcYX
        jqCPxKNNc/6srk//qdEL91EU6m4kxNM/RDjdSYatuA==
X-Google-Smtp-Source: APXvYqxMka7ARQZA13k0Sjr7ci08M2LzMR5Bdk1bRotabaYlEltDwATww69a6PymO0xU1v7zWdmGXSvS81fjw5S0E3c=
X-Received: by 2002:a6b:f80f:: with SMTP id o15mr7745428ioh.174.1568201716942;
 Wed, 11 Sep 2019 04:35:16 -0700 (PDT)
MIME-Version: 1.0
References: <1568196917-25674-1-git-send-email-chakragithub@gmail.com>
In-Reply-To: <1568196917-25674-1-git-send-email-chakragithub@gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 11 Sep 2019 13:35:05 +0200
Message-ID: <CAJfpegtDZ2ShAwkJ4hbj=sGM96QumWzzg8WsX42=AY2117p3+w@mail.gmail.com>
Subject: Re: [PATCH] fuse:send filep uid as part of fuse write req
To:     Chakra Divi <chakragithub@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 11, 2019 at 12:15 PM Chakra Divi <chakragithub@gmail.com> wrote:
>
> In current code in fuse write request current_fsuid is sent,
> however this creates an issue in sudo execution context.
> Changes to consider uid and gid from file struture pointer
> that is created as part of open file instead of current_fsuid,gid
>
> Steps to reproduce the issue:
> 1) create user1 and user2
> 2) create a file1 with user1 on fusemount
> 3) change the file1 permissions to 600
> 4) execute the following command
> user1@linux# sudo -u user2 whoami >> /fusemnt/file1
> Here write fails with permission denied error

Not sure what's the issue here.  If filesystem wants to check open
creds, it should do so with the creds sent at open.

Does that solve your problem?

Thanks,
Miklos
