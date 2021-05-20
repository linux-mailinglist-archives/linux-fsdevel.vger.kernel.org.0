Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F0C238B0BE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 May 2021 16:00:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243088AbhETOBV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 May 2021 10:01:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243690AbhETOA7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 May 2021 10:00:59 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86055C061574;
        Thu, 20 May 2021 06:59:35 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id e10so13700610ilu.11;
        Thu, 20 May 2021 06:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9E+YaOa0xt0tpY5/Es8DJviCFAarLiTAnjx0rqctTrM=;
        b=jZSTao8IO6znTllGcJgb9psFp2kPOKSB8ooj7rfNbJ3+zpAG1rQD0sHoHLs5THz2ML
         N8iDZauGy6k6/kmXD2sLPTt8XNiinUCRdm1gc2toAJmQvBX2HpvZTSrafAeXyeF5DLIM
         yt/GbsyytnoWimmM/JR74rBIes+NOF/Zff/h8DQhi+gMw+uSXZ0PKksZ9SWX87aG/Cyu
         NfQl1jT1MeLyvOKVxIAHt5hUoQi827+mhBIf4/Xw+Ux8g31JcGjlSdEHj+iNwd081L52
         F1yuw7dzkRy3aKJp3EbFhEFi7vHi7kIv4ol7pI0bde9+I+rZQZSCE3TRt9lQazwO5nUH
         LfkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9E+YaOa0xt0tpY5/Es8DJviCFAarLiTAnjx0rqctTrM=;
        b=p2yAqiykI8upuIa2U5QWw0GpwUqn0HNRm+3ZDTHoVJyQhHn7VPpqt01L/guaMLFk8X
         qNtAmPqckmlyhWxmVSJz6PCpCj6JD4dn3MDKrPWWRaabxM3WdwsL44HGrR67iK4vaXH6
         dsvZmz/V2m8xWF+NofOSK9M/fqETvXe+SKX4HC9RqBtwIpNLXSiyjeaxAjBQk5pesRR6
         tWTuvVHjhv3g5SdAK0nCWYu4OTGv6UcIuGQtUxpYD5UdoCgagc9MCxLmgQSOOd/ajlM6
         yu0ysnluqv7j2Z2nskc9mPY0uavhVB8GjPbMMyR6J7ge8US/oSzwsSDI78DAUi6PvI/w
         0SkQ==
X-Gm-Message-State: AOAM531I4aDIY9bC9KUd96U6RyEGP56fnIs3IeSGWeiDZfBXxVmZXicY
        lTenEwCc0KEm9xOj4vmtfTVmQjA5/4/b7jdZ80z1OhAHsxI=
X-Google-Smtp-Source: ABdhPJx9/t5mYTEt0sV/H1BbX6mG2pRq+skU0Y2pvHXkOnwrj+el+YiB6YEssIjD2HklKpjMoLZJZMPcDoHuk3qiBbM=
X-Received: by 2002:a92:4446:: with SMTP id a6mr5905338ilm.9.1621519174654;
 Thu, 20 May 2021 06:59:34 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1621473846.git.repnop@google.com> <24c761bd0bd1618c911a392d0c310c24da7d8941.1621473846.git.repnop@google.com>
In-Reply-To: <24c761bd0bd1618c911a392d0c310c24da7d8941.1621473846.git.repnop@google.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 20 May 2021 16:59:23 +0300
Message-ID: <CAOQ4uxjK-0nC5OHGQ5ArDuNq_3pFKfyjBmUfCqv=kAsq5y8KUQ@mail.gmail.com>
Subject: Re: [PATCH 4/5] fanotify/fanotify_user.c: introduce a generic info
 record copying function
To:     Matthew Bobrowski <repnop@google.com>
Cc:     Jan Kara <jack@suse.cz>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 20, 2021 at 5:11 AM Matthew Bobrowski <repnop@google.com> wrote:
>
> The copy_info_to_user() function has been repurposed with the idea to

Sorry I gave comment on patch 5 before I knew you repurposed
copy_info_to_user().
Perhaps it would be better to give a non ambiguous name like
copy_info_records_to_user() or
copy_fid_info_records_to_user() and leave pidfd out of this helper.
If you do wish to keep pidfd copy inside this helper and follow my
suggestion on patch 5 you will have to pass in pidfd as another argument.

Thanks,
Amir.
