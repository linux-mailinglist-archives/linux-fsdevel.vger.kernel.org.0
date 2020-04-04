Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB99E19E7B6
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 Apr 2020 23:19:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726393AbgDDVTP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 4 Apr 2020 17:19:15 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:40793 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbgDDVTP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 4 Apr 2020 17:19:15 -0400
Received: by mail-ed1-f65.google.com with SMTP id w26so13898812edu.7
        for <linux-fsdevel@vger.kernel.org>; Sat, 04 Apr 2020 14:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=whlD+FJJxUSsYgQJmOoyKhMr6jBMYuvqobVL83EC0Y8=;
        b=WRre38NwVB2LmEnC98i41YGU/UMX2qymyekgtMqnchU1KqX89ceYbyw3xRKr1XhGy4
         6HgJuVbiSVOqVXwon/QrA0T4sEgUgGPNmPqffIx0/mv+mHKaU0PjbaaEewmpvuro9DfU
         JDnC7tAkfLyumK5mtIm39aTZYSgWEHmXopyGE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=whlD+FJJxUSsYgQJmOoyKhMr6jBMYuvqobVL83EC0Y8=;
        b=dTHMzhftEdD1P78wcdGOukapNlb81s2nRtIjhmLLZlBb2xqAF4ycIvq76GDHsvzMTz
         +T/UsDkJV+Wc5R+54C+k2CrSTx2kpq+5M55Jlg1TPxDeHfDof8VGzuHmkkXc0emPL7nL
         Rl/pt9XhvJvjwdZDe6USSjD18n2fXgu1a3HzLfbGOnm6xGhLMsf61UWlIcRWE+URUKq5
         HLCFQUz/3O1A71x9daNtKfeMxnmWQT3mHRHs3w5R8GJpAPNH8bajWtvSQvQ9+NmM6J/Z
         eFAaH1q/GVoGdyo7PSVUDM9+nmpFueXLEVhN/0L304MkL5COpZJlphq0dwQsEXj9XPGB
         oRQQ==
X-Gm-Message-State: AGi0PuaFHa9SJFYDqjX8qP2vafXlXxBmDBVel+9+p7SBNdOmnZSBEFtL
        8ri0MAa1nykJxDeTFdse+Oj/wfrLqnY=
X-Google-Smtp-Source: APiQypJRxjh+qxrKRIBpBcm/MIPV/6eiTwGtUW4JnesKIDarIy2oK4RmKaLaFPbLbUZEDSoI8fhDcg==
X-Received: by 2002:a17:906:6050:: with SMTP id p16mr15191268ejj.179.1586035151251;
        Sat, 04 Apr 2020 14:19:11 -0700 (PDT)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com. [209.85.221.41])
        by smtp.gmail.com with ESMTPSA id dc25sm2382941ejb.59.2020.04.04.14.19.10
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Apr 2020 14:19:11 -0700 (PDT)
Received: by mail-wr1-f41.google.com with SMTP id h15so12815261wrx.9
        for <linux-fsdevel@vger.kernel.org>; Sat, 04 Apr 2020 14:19:10 -0700 (PDT)
X-Received: by 2002:a2e:9b8e:: with SMTP id z14mr8233548lji.150.1586034799883;
 Sat, 04 Apr 2020 14:13:19 -0700 (PDT)
MIME-Version: 1.0
References: <1445647.1585576702@warthog.procyon.org.uk> <1449543.1585579014@warthog.procyon.org.uk>
In-Reply-To: <1449543.1585579014@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 4 Apr 2020 14:13:03 -0700
X-Gmail-Original-Message-ID: <CAHk-=wghjTM+z_oAATqWOvPa8Lh6BKRtTVMi7hLxo6pbqc+kVg@mail.gmail.com>
Message-ID: <CAHk-=wghjTM+z_oAATqWOvPa8Lh6BKRtTVMi7hLxo6pbqc+kVg@mail.gmail.com>
Subject: Re: [GIT PULL] Mount and superblock notifications
To:     David Howells <dhowells@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, dray@redhat.com,
        Karel Zak <kzak@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Steven Whitehouse <swhiteho@redhat.com>, jlayton@redhat.com,
        Ian Kent <raven@themaw.net>, andres@anarazel.de,
        Christian Brauner <christian.brauner@ubuntu.com>,
        keyrings@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 30, 2020 at 7:37 AM David Howells <dhowells@redhat.com> wrote:
>
> If you could consider pulling this - or would you prefer it to go through
> Al?  It adds a couple of VFS-related event sources for the general
> notification mechanism:

<y issue with these remains the same it was last time, so I'll just
quote what I said back then:

 "So I no longer hate the implementation, but I do want to see the
  actual user space users come out of the woodwork and try this out for
  their use cases.

  I'd hate to see a new event queue interface that people then can't
  really use due to it not fulfilling their needs, or can't use for some
  other reason."

I want to see somebody step up enough to say "yes, I actually use
this, and have the patches for the user space side, and it helps my
load by 3000%, and here are the numbers, and the event overflow case
isn't an issue because Y"

Or whatever. It doesn't have to be performance, but the separate
discussion I've seen has been about that being the reason for it.

I just don't want it to be a _hypothetical_ reason. I want it to be a
tested reason where people said "yeah, this is easy to use and
actually fixes the problems".

Because if what happens is that when the events overflow, and maybe
people fall back on the old model (or whatever) then that probably
just means that you do better up until a point where you start doing
_worse_ than we used to.

Or people find out that they needed more information anyway, and the
event model doesn't work when you restart your special server because
you've lost the original state. Or any other number of "cool feature,
but I can't really use it".

IOW, I really want to know that yes, the design is what people will
then use and it actually fixes real-world issues.

And it needs to be interesting and pressing enough that those people
actually at least do a working prototype on top of a patch-set that
hasn't made it into the kernel yet.

Now, I realize that other projects won't _upstream_ their support
before the kernel has the infrastructure, so I'm not looking for
_that_ kind of "yeah, look, project XYZ already does this and Red Hat
ships it". No, I'm looking for those outside developers who say more
than "this is a pet peeve of mine with the existing interface". I want
to see some actual use - even if it's just in a development
environment - that shows that it's (a) sufficient and (b) actually
fixes problems.

             Linus
