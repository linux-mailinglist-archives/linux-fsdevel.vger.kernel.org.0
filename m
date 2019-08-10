Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC31288A7D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Aug 2019 12:05:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725907AbfHJKF2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 10 Aug 2019 06:05:28 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:40609 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725773AbfHJKF1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 10 Aug 2019 06:05:27 -0400
Received: by mail-yb1-f195.google.com with SMTP id j6so6562222ybm.7;
        Sat, 10 Aug 2019 03:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JP7W5WK+7O8UWLHKfnIKNGxUzPugVshGAQQJJ/lIEdQ=;
        b=ARgPw8jBtEOfUUCP0QUMQnUZIb0RZvaQohBqNEQQNwUVaeBY+yr31H4L8tptZkpDP6
         tSr4Ztc3i917jqFGaf12VmIQwsboSP4PutA8I7OVbQWEOQB2CBwajbtc0F1dsuUs11jF
         FP542joD3/D0ce+JmIylQIoC07LR1nuccS3jvpgTWxmCK9nxjNgYASbvqQ4Y7BX5Rp8j
         dLTxsZnBHc567gmAU4iUYvn0QqyF8e9KUygtUy5Iq1Xo/CiF7I/5bMKibrj7W7JXIn8w
         dH7lrdXrkXHxHqaqNqPTU3vLgpRqQD6/TK/VLAcOtNs+es/onSyAEcEk29q0Qjc7mJ2K
         fBlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JP7W5WK+7O8UWLHKfnIKNGxUzPugVshGAQQJJ/lIEdQ=;
        b=tw7ZOQlIi4DwKM7a4b2ZzgpQeGwEfJOvFDJ4j/EF2x6YKce/MRBhP+pb277NG2rPIu
         BMuQVhLWliN4Mdn9G5vddcOZp+39cE7FcxpAOufUIoPqpF5wPzvrAAed14C9YTFjM8aC
         8bdBusgewWuhryyxV1G7XzB7ogCRCeAxiBZBxZYEOcb5hONl5xpyPECaB5ujkAiUZ2Qh
         77aJ7XDaXsB53XMhkwiMJ7Y5H6BrbMZ/rwK61xcnqSypXAhYMuh58LhhhgeRmEWrytZ7
         Rqnopcj39WXzzpRJrIWzuVyCYIv8UjKo6P/OvhpmNrlL1+yALVI5Ev3nCkM+7CmjMI4t
         NEPA==
X-Gm-Message-State: APjAAAW0rx3PI4BmMCs69jPKl3O9aPCOwcIj3+MT503+TaEc8PQBbRKb
        PzwU2by+P+u3XIYSrHsPWTu+s5XOqDPrkGfyLOo=
X-Google-Smtp-Source: APXvYqz1hzOKzpjqep9z6bTqZcppD82BCobutxjBB9Lp0e+pfqMfQOv5Qv6TGKag4Duv4RQprg+ZPH7rclwh6m3xYJQ=
X-Received: by 2002:a25:9203:: with SMTP id b3mr10506054ybo.14.1565431526544;
 Sat, 10 Aug 2019 03:05:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190731153443.4984-1-acgoide@tycho.nsa.gov> <CAHC9VhQUoDwBiLi+BiW=_Px18v3xMhhGYDD2mLdu9YZJDWw1yg@mail.gmail.com>
 <CAOQ4uxigYZunXgq0BubRFNM51Kh_g3wrtyNH77PozUX+3sM=aQ@mail.gmail.com> <CAHC9VhRpTuL2Lj1VFwHW4YLpx0hJVSxMnXefooHqsxpEUg6-0A@mail.gmail.com>
In-Reply-To: <CAHC9VhRpTuL2Lj1VFwHW4YLpx0hJVSxMnXefooHqsxpEUg6-0A@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sat, 10 Aug 2019 13:05:15 +0300
Message-ID: <CAOQ4uxiGNXbZ-DWeXTkNM4ySFbBbo1XOF1=3pjknsf+EjbNuOw@mail.gmail.com>
Subject: Re: [PATCH] fanotify, inotify, dnotify, security: add security hook
 for fs notifications
To:     Paul Moore <paul@paul-moore.com>
Cc:     Aaron Goidel <acgoide@tycho.nsa.gov>, selinux@vger.kernel.org,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>, Jan Kara <jack@suse.cz>,
        James Morris <jmorris@namei.org>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> > > Other than Casey's comments, and ACK, I'm not seeing much commentary
> > > on this patch so FS and LSM folks consider this your last chance - if
> > > I don't hear any objections by the end of this week I'll plan on
> > > merging this into selinux/next next week.
> >
> > Please consider it is summer time so people may be on vacation like I was...
>
> This is one of the reasons why I was speaking to the mailing list and
> not a particular individual :)
>

Jan is fsnotify maintainer, so I think you should wait for an explicit ACK
from Jan or just merge the hook definition and ask Jan to merge to
fsnotify security hooks.

Thanks,
Amir.
