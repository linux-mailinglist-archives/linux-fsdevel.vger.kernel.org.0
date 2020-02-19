Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2105D164942
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2020 16:54:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbgBSPyO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Feb 2020 10:54:14 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:45527 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbgBSPyO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Feb 2020 10:54:14 -0500
Received: by mail-ot1-f65.google.com with SMTP id 59so545294otp.12
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Feb 2020 07:54:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lxARnBor1U+6So+HrMWf9Gk7N+daPrHbJnbZhnhwrnE=;
        b=hCbOktmi3YliRq0ScBXSNUesHyAqvCL12c5uWO6XJNi9n/y2ahYy8f6c/hN9HhkUp6
         NtGyeKNDq17KU1oflZcGFavHZ0yak7eV3txHutBNLTY+fhuz//0QGxRkoWIV07omcEfA
         pV2jnT0owxB53J3tC25KDX6npdI6rpYslOVlEcpoDIMBKSsQQwz65+OTQrTbhk+C91KH
         1egcT0uxQa4IR7ZPjdBFsZarSM4W8MpTmZQCyLXSB+NtwqZcQBCMtj55+3PKd8Ts8PoK
         t5d3X57H5eosvrejeqcBMmaMblxiDL8WOSJRKe0vQsPwInYir9WHgpdZ7zxw5ZYJrLkr
         SE7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lxARnBor1U+6So+HrMWf9Gk7N+daPrHbJnbZhnhwrnE=;
        b=q1za53Qfw0PznqERrrq7fmzJo7A4Jb5heQpM3JsuLhVK3TdlOoEgorhGnKcZbu9K09
         zAANZY6kie1NupyCe5T5nQ3jI5KUiexvO251WcoBNHaZUEN49uoc4QmPRDJBiS1dhtXz
         /mg+nCdnx+oDPSgV7Fw6g7Uw7WuqXUKa1L0IJeZtkSfcCRvkCjhrsqonjIQrKw6TBORP
         wJz+fGloa/ay2SFMTcPtZTZ7Zpsa7aaBoAv+MxfZXlKZP0XCdkoMBKtBkHiU4QtndEfN
         Ijps3dAaarFKNZrB65w39P2ROu5/+X7L7+Cr4hs+Mmwp0bIi6m7oS0hwoq/j8Dm3xw7D
         T+zw==
X-Gm-Message-State: APjAAAXjBmCrjp2PD7ddft7v/Sm963eRsE8/82sHLjvz6z0yJwat4Muf
        WKPfOh3/GbK9IJr1CT52pQ0kjKHWx++URbJqT045bg==
X-Google-Smtp-Source: APXvYqxMNt0Da4orYoVxsQsRxu5xNkMkw0G1x6vghAKafmTT/NokCPoqIr/ZB8PYTJmUP6i//FyBRvrO9SGFwmyS5SI=
X-Received: by 2002:a05:6830:13c3:: with SMTP id e3mr5336055otq.180.1582127653521;
 Wed, 19 Feb 2020 07:54:13 -0800 (PST)
MIME-Version: 1.0
References: <20200218143411.2389182-1-christian.brauner@ubuntu.com> <20200218143411.2389182-20-christian.brauner@ubuntu.com>
In-Reply-To: <20200218143411.2389182-20-christian.brauner@ubuntu.com>
From:   Jann Horn <jannh@google.com>
Date:   Wed, 19 Feb 2020 16:53:47 +0100
Message-ID: <CAG48ez2ikuZQTctjR0RAXYUFrSsJdyn98cKGn5hGEhYjzWfO8g@mail.gmail.com>
Subject: Re: [PATCH v3 19/25] commoncap: handle fsid mappings with vfs caps
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     =?UTF-8?Q?St=C3=A9phane_Graber?= <stgraber@ubuntu.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Stephen Barber <smbarber@chromium.org>,
        Seth Forshee <seth.forshee@canonical.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Serge Hallyn <serge@hallyn.com>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Phil Estes <estesp@gmail.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 18, 2020 at 3:35 PM Christian Brauner
<christian.brauner@ubuntu.com> wrote:
> Switch vfs cap helpers to lookup fsids in the fsid mappings. If no fsid
> mappings are setup the behavior is unchanged, i.e. fsids are looked up in the
> id mappings.
[...]
> diff --git a/security/commoncap.c b/security/commoncap.c
[...]
> @@ -328,7 +328,7 @@ static bool rootid_owns_currentns(kuid_t kroot)
>                 return false;
>
>         for (ns = current_user_ns(); ; ns = ns->parent) {
> -               if (from_kuid(ns, kroot) == 0)
> +               if (from_kfsuid(ns, kroot) == 0)
>                         return true;
>                 if (ns == &init_user_ns)
>                         break;

Nit: Maybe change the name of this function to something that makes it
clear that this operates in the fsuid mapping domain.
