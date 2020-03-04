Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 424F11792E1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Mar 2020 15:58:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727835AbgCDO60 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Mar 2020 09:58:26 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:44651 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727436AbgCDO60 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Mar 2020 09:58:26 -0500
Received: by mail-io1-f66.google.com with SMTP id u17so2677000iog.11
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Mar 2020 06:58:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MI1PXuWt7Kag0MFTc+PiKW4eyxOQoHf1qp779Es8aXg=;
        b=jlEbGqj0JV8uts4QRzcS6Eajtw0tKvhkbeliNCbF4uNcgjKTS/ufjxuns+h7Dpv6oK
         iRjdlxhkwkZI1FmdhgsHRZm18X+J/tCJza8pnjG/RS/TKmekikpIX0g4Ktub7s/SxPOV
         trmM3oYR2IE7l7X78+F/LxlrLp+ecQgRRpBjY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MI1PXuWt7Kag0MFTc+PiKW4eyxOQoHf1qp779Es8aXg=;
        b=G1LgYNFqw0MmnJ4q1zoelC44S1R2+7TeTgikF5xNc3gaOVnBpJQJXM3x8XFz4OGpWv
         rvuUsMbqRSVz3J6FQyhEIpXSSeVNvQ6vBgSNQKuwWpwVvnWZFkbBjTZoQ/LsJgnVT1LW
         RlwQz5XTY0qCuB8p6ueKGPt/VpPbSx6A2HtiX1PWV/gKw3EyDD1VbD+3DHpS1AcGgQyb
         SjxV9b4HptpflJM2vBvH3244JI5yzc7PzghDY/iUffsXK0KpITqKPet4SgeLyi3Panqg
         Fxr7EAkDmWsqq0DtKVR1Rg+Yfgw+rr0EAkQci9GBsXm3cfl+XPdIrffKYjg7ynnxWGlE
         X5AQ==
X-Gm-Message-State: ANhLgQ3ZQkkldgBUFxQyiTcwgAdcVssx4EqbLGOZEaaYy4dnJgLgzi/K
        5yblaHSrgIIODI7cgx+e8zzmJUj4PLzYLkZz73vRPA==
X-Google-Smtp-Source: ADFU+vt7iszIUbYisTGd86KHNUYtvuTdfoY/g3ldBLGb8T53mnRCU8tRd+55HaV44wyYtBstlDMXhGVD9Q344+TQJSs=
X-Received: by 2002:a02:558a:: with SMTP id e132mr3150631jab.58.1583333905701;
 Wed, 04 Mar 2020 06:58:25 -0800 (PST)
MIME-Version: 1.0
References: <158230810644.2185128.16726948836367716086.stgit@warthog.procyon.org.uk>
 <158230818859.2185128.8921928947340497977.stgit@warthog.procyon.org.uk>
In-Reply-To: <158230818859.2185128.8921928947340497977.stgit@warthog.procyon.org.uk>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 4 Mar 2020 15:58:14 +0100
Message-ID: <CAJfpegtcNorH0uBbmodOj5WZXRjXnbzRXWbX7+A=qf02LDJCtg@mail.gmail.com>
Subject: Re: [PATCH 10/17] fsinfo: Allow mount information to be queried [ver #17]
To:     David Howells <dhowells@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Ian Kent <raven@themaw.net>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Christian Brauner <christian@brauner.io>,
        Jann Horn <jannh@google.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 21, 2020 at 7:03 PM David Howells <dhowells@redhat.com> wrote:

> +/*
> + * Return the path of this mount relative to its parent and clipped to
> + * the current chroot.

And clipped to nothing if outside current root.  The code doesn't
appear to care, which to me seems like a hole.

And btw, what is the point of only showing path relative to parent
mount?  This way it's impossible to get a consistent path from root
due to mount/dentry tree changes between calls to fsinfo().

Thanks,
Miklos
