Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EADB614F2F6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Jan 2020 20:55:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726102AbgAaTzb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 31 Jan 2020 14:55:31 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:38770 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbgAaTzb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 31 Jan 2020 14:55:31 -0500
Received: by mail-ed1-f66.google.com with SMTP id p23so9075084edr.5
        for <linux-fsdevel@vger.kernel.org>; Fri, 31 Jan 2020 11:55:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cMM4l2AcsKr13k50NYp+NWAp7EWfl4QYfFE3hRDEQAE=;
        b=At7oNeteomf3wB5fyZHm2CWn9mFXRDBhTwh+PUhh5j6de7UIKumKV+jituI0gZxoc8
         byjKzHn3S59DR0+O/1HSZ+TBmFrnpSk8GXxA+Sj0oFQbMvF5+miDEiGaArrwjgbLm8wK
         du2K4KReYZQvBN5lVGwkBxrCTh9zZppkIkkm8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cMM4l2AcsKr13k50NYp+NWAp7EWfl4QYfFE3hRDEQAE=;
        b=PpBFpZwZKpX8rKJLiRRKGN4aSnc3L9iuT2MDV+i5JDbRjvS+R6qvsEPM1jNmyg0Q4L
         QUyS1R1mToR3PHUprsVnnKV6bh6cuy4MZ+mHFTjWgsk3+naOLlRCBQyOkpIGnJOGZbK1
         SFIjpdVUJrkRkvb3vr7ekTwRgA83jdLRxl6C/OB9uvffZHQWsREom9wjdQe90IUaarbk
         3iIglBLJ69bFvu07IspMwhFwrVCASqzuw5C4QZFqbkxAzClmqop3Sc4h+799VSsvOkFT
         vn16Txu/yxPJb8w4n2OgC1wEHGf4LC1GWnbrNtwbh+xm9tNizuOOCBxouF8fLo8w8cJO
         ACbg==
X-Gm-Message-State: APjAAAU+4YGVq9DFwcVhvs8n3wzxyI7Bywi0goXA4CV0HUfhCRo1WAij
        rbgFv4A8BmhDHolzNGltdH4KrQ20Wb0=
X-Google-Smtp-Source: APXvYqzsOkL3hV7Asr66slOQ0whQsgm4lUsYFsgUZJ/22zsVncCOPdJHj2aqiSGx+/dROsOI8XJOaw==
X-Received: by 2002:a17:906:4d90:: with SMTP id s16mr10140040eju.247.1580500529546;
        Fri, 31 Jan 2020 11:55:29 -0800 (PST)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id w3sm537963edt.80.2020.01.31.11.55.28
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Jan 2020 11:55:28 -0800 (PST)
Received: by mail-ed1-f41.google.com with SMTP id e10so9042805edv.9
        for <linux-fsdevel@vger.kernel.org>; Fri, 31 Jan 2020 11:55:28 -0800 (PST)
X-Received: by 2002:a17:906:7d5:: with SMTP id m21mr10793134ejc.356.1580500527743;
 Fri, 31 Jan 2020 11:55:27 -0800 (PST)
MIME-Version: 1.0
References: <20200131002750.257358-1-zwisler@google.com> <20200131004558.GA6699@bombadil.infradead.org>
In-Reply-To: <20200131004558.GA6699@bombadil.infradead.org>
From:   Ross Zwisler <zwisler@chromium.org>
Date:   Fri, 31 Jan 2020 12:55:16 -0700
X-Gmail-Original-Message-ID: <CAGRrVHytokoWWok8uz3vVHuEn3bOkedc5pS1Lk3k4UtUvwPZig@mail.gmail.com>
Message-ID: <CAGRrVHytokoWWok8uz3vVHuEn3bOkedc5pS1Lk3k4UtUvwPZig@mail.gmail.com>
Subject: Re: [PATCH v4] Add a "nosymfollow" mount option.
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Mattias Nissler <mnissler@chromium.org>,
        Benjamin Gordon <bmgordon@google.com>,
        Raul Rangel <rrangel@google.com>,
        Micah Morton <mortonm@google.com>,
        Dmitry Torokhov <dtor@google.com>, Jan Kara <jack@suse.cz>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>,
        David Howells <dhowells@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 30, 2020 at 5:46 PM Matthew Wilcox <willy@infradead.org> wrote:
> On Thu, Jan 30, 2020 at 05:27:50PM -0700, Ross Zwisler wrote:
> > For mounts that have the new "nosymfollow" option, don't follow
> > symlinks when resolving paths. The new option is similar in spirit to
> > the existing "nodev", "noexec", and "nosuid" options. Various BSD
> > variants have been supporting the "nosymfollow" mount option for a
> > long time with equivalent implementations.
> >
> > Note that symlinks may still be created on file systems mounted with
> > the "nosymfollow" option present. readlink() remains functional, so
> > user space code that is aware of symlinks can still choose to follow
> > them explicitly.
> >
> > Setting the "nosymfollow" mount option helps prevent privileged
> > writers from modifying files unintentionally in case there is an
> > unexpected link along the accessed path. The "nosymfollow" option is
> > thus useful as a defensive measure for systems that need to deal with
> > untrusted file systems in privileged contexts.
>
> The openat2 series was just merged yesterday which includes a
> LOOKUP_NO_SYMLINKS option.  Is this enough for your needs, or do you
> need the mount option?
>
> https://lore.kernel.org/linux-fsdevel/20200129142709.GX23230@ZenIV.linux.org.uk/

Thank you for the pointer.  No, I don't think that this really meets
our needs because it requires code to be modified to use the new
openat2 system call.  Our goal is to be able to place restrictions on
untrusted user supplied filesystems so that legacy programs will be
protected from malicious symlinks.
