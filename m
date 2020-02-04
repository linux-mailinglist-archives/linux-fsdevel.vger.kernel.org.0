Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EDCC515223C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2020 23:11:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727483AbgBDWLW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Feb 2020 17:11:22 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:41420 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727445AbgBDWLW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Feb 2020 17:11:22 -0500
Received: by mail-ed1-f66.google.com with SMTP id c26so183932eds.8
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Feb 2020 14:11:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r1c8Sx/+v2lfjleperyhTLWYQbP5AjrZMIJnYtSmPQU=;
        b=JAsE2pvS4+eX7xyYLMmX23TdtQBQmxYCgHdJ21FAV72iuMv8HzM1+LlI1mpCrxJMIs
         Z1Y8Jctbh8mly6rjWTfp6xJuCiS3i3bw4WSoQ7hc+Nw+j58Wcw0Ed7wph4rQhruGbfKe
         /RRfs9+p3C3rNRcC3Md74U3MqKJidO7e/0Ro4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r1c8Sx/+v2lfjleperyhTLWYQbP5AjrZMIJnYtSmPQU=;
        b=fbqOpVE7lD+V8GUGqWoP9VIdMZryoXqWcrTLQpfn2R2A2Iubg8HR0wF2XltqvO0gra
         Ji7rldyBR//Rv2dz3hnVZowp+V3B0qT4kEOBO/+ySUbNrIJkoVODNdNC0qNl4hIfpxwd
         SZIsxiDbI1zzn6hyTfxyyOPRBMrnXMZxSdx8jiqqq+pRqngqDPI7LRSc/sSjmcYVO/D7
         eliQcqe7yzBh93MRBb0tdAhngg3V/JwOelUxm05aMKSdK/J91TZzdsoNOTbNxKWa45Kt
         a1tcq1BkfXkR8QNawxKfqgz6oJVAQuBoqPx9gYjphL9hLmtsCQv4A+SRZRm2aOzQ5HhB
         Zlzw==
X-Gm-Message-State: APjAAAWExTHfHMS0iE1uk2SKNIOA24xEhm8vMk7yAyDpDSyqjLYduJK5
        nr6v7hzvJZaB98bSLI0Np0HfYK9+s9Q=
X-Google-Smtp-Source: APXvYqygjRsdV6faWmFpGPZzSXR7T4SmJ6z1lTTeZbIWdlYTDDuyeA6YWV8eCGitEg0DfywbXAYyFA==
X-Received: by 2002:a17:907:2165:: with SMTP id rl5mr28350203ejb.193.1580854280211;
        Tue, 04 Feb 2020 14:11:20 -0800 (PST)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id k11sm1103991edr.38.2020.02.04.14.11.18
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Feb 2020 14:11:20 -0800 (PST)
Received: by mail-ed1-f43.google.com with SMTP id p23so199994edr.5
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Feb 2020 14:11:18 -0800 (PST)
X-Received: by 2002:aa7:c241:: with SMTP id y1mr2375799edo.354.1580854277802;
 Tue, 04 Feb 2020 14:11:17 -0800 (PST)
MIME-Version: 1.0
References: <20200204215014.257377-1-zwisler@google.com> <CAHQZ30BgsCodGofui2kLwtpgzmpqcDnaWpS4hYf7Z+mGgwxWQw@mail.gmail.com>
In-Reply-To: <CAHQZ30BgsCodGofui2kLwtpgzmpqcDnaWpS4hYf7Z+mGgwxWQw@mail.gmail.com>
From:   Ross Zwisler <zwisler@chromium.org>
Date:   Tue, 4 Feb 2020 15:11:06 -0700
X-Gmail-Original-Message-ID: <CAGRrVHwQimihNNVs434jNGF3BL5_Qov+1eYqBYKPCecQ0yjxpw@mail.gmail.com>
Message-ID: <CAGRrVHwQimihNNVs434jNGF3BL5_Qov+1eYqBYKPCecQ0yjxpw@mail.gmail.com>
Subject: Re: [PATCH v5] Add a "nosymfollow" mount option.
To:     Raul Rangel <rrangel@google.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Mattias Nissler <mnissler@chromium.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org,
        Benjamin Gordon <bmgordon@google.com>,
        Micah Morton <mortonm@google.com>,
        Dmitry Torokhov <dtor@google.com>, Jan Kara <jack@suse.cz>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 4, 2020 at 2:53 PM Raul Rangel <rrangel@google.com> wrote:
> > --- a/include/uapi/linux/mount.h
> > +++ b/include/uapi/linux/mount.h
> > @@ -34,6 +34,7 @@
> >  #define MS_I_VERSION   (1<<23) /* Update inode I_version field */
> >  #define MS_STRICTATIME (1<<24) /* Always perform atime updates */
> >  #define MS_LAZYTIME    (1<<25) /* Update the on-disk [acm]times lazily */
> > +#define MS_NOSYMFOLLOW (1<<26) /* Do not follow symlinks */
> Doesn't this conflict with MS_SUBMOUNT below?
> >
> >  /* These sb flags are internal to the kernel */
> >  #define MS_SUBMOUNT     (1<<26)

Yep.  Thanks for the catch, v6 on it's way.
