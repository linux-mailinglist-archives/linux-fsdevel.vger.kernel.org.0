Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9213A3F9933
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Aug 2021 14:50:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245131AbhH0Muj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 Aug 2021 08:50:39 -0400
Received: from mail-ed1-f53.google.com ([209.85.208.53]:39607 "EHLO
        mail-ed1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231271AbhH0Mui (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 Aug 2021 08:50:38 -0400
Received: by mail-ed1-f53.google.com with SMTP id z10so9708414edb.6;
        Fri, 27 Aug 2021 05:49:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6BL24id7m8wPcedNjNI4ZZt0Go13BjZ8iUQt2C7HOss=;
        b=MaBPemzNUUDEKOhzhtzL0KzbdrQMYRJodbbaWmySuLfia+ocwpM+Wekp2DOAwDkdz0
         shnThjlRclnLy8RQTwZl8s0dMNGjfbg/3Q2Mp3uuuLv7XYMnVJ8QacJr7ms10GMh/9kM
         ThS4A8c3k0G7Nv/MO/FNW5tz9mumomfmSULmKISlVnOrU7ngcjywpqEvYrVKvlJoKT43
         mUrJ+lNU+fmHUCSy0qBbpCc7vY4wPmoZ5uFcsvP2HiRuh6V9vNyl93cucpYyLx2ydY06
         vCX99xbRbSl2vKwg4H4Xm+cOCzL1KaIH9EKel5l5fUZM+VHiahx/UvLiL/QMnCKnP/WY
         ll1w==
X-Gm-Message-State: AOAM532j4geRmapEztXd+PbT21utGr0kIb8YZ9u14mHOTNEWU8v9rgd1
        7U4PM+ggrPYNPmMDPdqm+0rl9925UJDZ9zr8
X-Google-Smtp-Source: ABdhPJy370SJ1btGaw0ga5We9U64ToDoPTBFKka6j32kf3xWuyOxS5J+jcxpBzYUVwK9pBMWYamuig==
X-Received: by 2002:a05:6402:5188:: with SMTP id q8mr10048823edd.138.1630068588024;
        Fri, 27 Aug 2021 05:49:48 -0700 (PDT)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com. [209.85.128.46])
        by smtp.gmail.com with ESMTPSA id l19sm3292422edb.86.2021.08.27.05.49.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Aug 2021 05:49:47 -0700 (PDT)
Received: by mail-wm1-f46.google.com with SMTP id 79-20020a1c0452000000b002e6cf79e572so9158652wme.1;
        Fri, 27 Aug 2021 05:49:47 -0700 (PDT)
X-Received: by 2002:a05:600c:35c1:: with SMTP id r1mr8646060wmq.101.1630068587111;
 Fri, 27 Aug 2021 05:49:47 -0700 (PDT)
MIME-Version: 1.0
References: <162431188431.2908479.14031376932042135080.stgit@warthog.procyon.org.uk>
 <162431193544.2908479.17556704572948300790.stgit@warthog.procyon.org.uk> <2512396.1630067489@warthog.procyon.org.uk>
In-Reply-To: <2512396.1630067489@warthog.procyon.org.uk>
From:   Marc Dionne <marc.dionne@auristor.com>
Date:   Fri, 27 Aug 2021 09:49:35 -0300
X-Gmail-Original-Message-ID: <CAB9dFdufkVyqS4NadbqVrtjmciLvpuAZOU8woWWcURcnuaZ=GA@mail.gmail.com>
Message-ID: <CAB9dFdufkVyqS4NadbqVrtjmciLvpuAZOU8woWWcURcnuaZ=GA@mail.gmail.com>
Subject: Re: [Linux-cachefs] [PATCH v2 04/12] fscache: Add a cookie debug ID
 and use that in traces
To:     David Howells <dhowells@redhat.com>
Cc:     linux-cachefs@redhat.com, Steve French <sfrench@samba.org>,
        linux-nfs@vger.kernel.org, linux-afs@lists.infradead.org,
        linux-cifs@vger.kernel.org,
        Dominique Martinet <asmadeus@codewreck.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        linux-fsdevel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net, ceph-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 27, 2021 at 9:31 AM David Howells <dhowells@redhat.com> wrote:
>
>
> Add a cookie debug ID and use that in traces and in procfiles rather than
> displaying the (hashed) pointer to the cookie.  This is easier to correlate
> and we don't lose anything when interpreting oops output since that shows
> unhashed addresses and registers that aren't comparable to the hashed
> values.
>
> Changes:
>
> ver #2:
>  - Fix the fscache_op tracepoint to handle a NULL cookie pointer.
>
> Signed-off-by: David Howells <dhowells@redhat.com>
> Reviewed-by: Jeff Layton <jlayton@redhat.com>
> cc: linux-cachefs@redhat.com
> Link: https://lore.kernel.org/r/158861210988.340223.11688464116498247790.stgit@warthog.procyon.org.uk/ # rfc
> Link: https://lore.kernel.org/r/159465769844.1376105.14119502774019865432.stgit@warthog.procyon.org.uk/
> Link: https://lore.kernel.org/r/160588459097.3465195.1273313637721852165.stgit@warthog.procyon.org.uk/ # rfc
> Link: https://lore.kernel.org/r/162431193544.2908479.17556704572948300790.stgit@warthog.procyon.org.uk/

Reviewed-by: Marc Dionne <marc.dionne@auristor.com>

Marc
