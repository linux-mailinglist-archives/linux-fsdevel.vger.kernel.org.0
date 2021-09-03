Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DD1740029D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Sep 2021 17:51:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349679AbhICPwA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Sep 2021 11:52:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38107 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235662AbhICPv6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Sep 2021 11:51:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630684256;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MoQLQTqUY5yDM/Q0pchQHfi3iihhP0hcaHsviw39pb8=;
        b=bIzPqff02uJU3F917ZBPWIXiba4iwjlsCmg++d8QAWeg62buxo3KqJC7QZmM2fH5m4/iXH
        nUlID5rNBL4V/3NATYn2MIAAaNK7LUOjKsLredufjDzjnMC4QFCVFgak9sMkFA6Y8BB8w2
        BX+PhEPf0HJCLWwLgPccmVPkuOLrP50=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-227-CbCWX1S2N9-XbWydsQ4rCA-1; Fri, 03 Sep 2021 11:50:55 -0400
X-MC-Unique: CbCWX1S2N9-XbWydsQ4rCA-1
Received: by mail-il1-f198.google.com with SMTP id z14-20020a92d18e0000b029022418b34bc9so3790108ilz.9
        for <linux-fsdevel@vger.kernel.org>; Fri, 03 Sep 2021 08:50:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MoQLQTqUY5yDM/Q0pchQHfi3iihhP0hcaHsviw39pb8=;
        b=VhVI5puurfCiHRndhlvO2hHTE4QM98hVBvZ61F+PFHmLE/lRx+hKCDZqfPgFyOqkA5
         WtmTEsYza0sS19CDupLHa0jDPX+Jhy/c594EpB2DosQqf/WoBteM2JAbnRdX6FK0yVar
         WHjSe1AtdIPMtoNexmtaqNgLYAoQSG1k1uqn/ysz7v6JCM+NdEk2djO5FdTp39Tkxa05
         ZDDgctWy6EPy/yoxGT5xyHbhJV3BQDW+Fc6CllQt/MaUXWCDbeL9oBA+5ZKhteiuTSkJ
         lxQQTdo04giuDXfgbd2/kIT6wkg3bOYptC5dZV/ziueBVhg0bXb+TN7WT9GEkiB/mYwR
         Szfg==
X-Gm-Message-State: AOAM533FbC1Q911hm3CHuDtmgVjUZVFmeXHIwhBLj5B1RvNNsG8q+h3W
        Axsbp2q91+LXy+jFr2+LftYMPkWteMVfeQL7Wojef5nE11ZdAgQQKqmtWFClnd4YfUncHmQ/V3O
        tHpO3jbqWPC6BvnsO19SDyjmt8v2AilmK5u22GpPbew==
X-Received: by 2002:a92:1944:: with SMTP id e4mr3012478ilm.186.1630684254589;
        Fri, 03 Sep 2021 08:50:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxA5hXocfG238Br3Kxfn76guZ5oIlMhSVgOX7QM7jB7Qbl9LikvJuc4o8e5u68QJjhURVNmZgDTJj9VHCBUSvY=
X-Received: by 2002:a92:1944:: with SMTP id e4mr3012456ilm.186.1630684254354;
 Fri, 03 Sep 2021 08:50:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210902152228.665959-1-vgoyal@redhat.com> <YTDyE9wVQQBxS77r@redhat.com>
 <CAHc6FU4ytU5eo4bmJcL6MW+qJZAtYTX0=wTZnv4myhDBv-qZHQ@mail.gmail.com>
 <CAHc6FU5quZWQtZ3fRfM_ZseUsweEbJA0aAkZvQEF5u9MJhrqdQ@mail.gmail.com>
 <CAPL3RVH9MDoDAdiZ-nm3a4BgmRyZJUc_PV_MpsEWiuh6QPi+pA@mail.gmail.com> <YTJCjGH0V5yzMnQB@redhat.com>
In-Reply-To: <YTJCjGH0V5yzMnQB@redhat.com>
From:   Bruce Fields <bfields@redhat.com>
Date:   Fri, 3 Sep 2021 11:50:43 -0400
Message-ID: <CAPL3RVFB67-AqZrjjfxueQF1Jw=LmKWzCk3Ur94EjUotYMw0AA@mail.gmail.com>
Subject: Re: [PATCH 3/1] xfstests: generic/062: Do not run on newer kernels
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        fstests <fstests@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, virtio-fs@redhat.com,
        Daniel Walsh <dwalsh@redhat.com>,
        David Gilbert <dgilbert@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Casey Schaufler <casey.schaufler@intel.com>,
        LSM <linux-security-module@vger.kernel.org>,
        selinux@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        stephen.smalley.work@gmail.com, Dave Chinner <david@fromorbit.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 3, 2021 at 11:43 AM Vivek Goyal <vgoyal@redhat.com> wrote:
> On Fri, Sep 03, 2021 at 10:42:34AM -0400, Bruce Fields wrote:
> > Well, we could also look at supporting trusted.* xattrs over NFS.  I
> > don't know much about them, but it looks like it wouldn't be a lot of
> > work to specify, especially now that we've already got user xattrs?
> > We'd just write a new internet draft that refers to the existing
> > user.* xattr draft for most of the details.
>
> Will be nice if we can support trusted.* xattrs on NFS.

Maybe I should start a separate thread for that.  Who would need to be
on it to be sure we get this right?

--b.

