Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE57D36CBCF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Apr 2021 21:40:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238804AbhD0TlS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Apr 2021 15:41:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238817AbhD0TlN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Apr 2021 15:41:13 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B45AC06175F
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Apr 2021 12:40:28 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id a36so58710483ljq.8
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Apr 2021 12:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d1qy5wxeRoVOmQDNZKC3zuT1I7B8Wmbsg1PWKuM1gGo=;
        b=KQMj4gOjxXdq3F3sCekOUpnM5wUKPyax2VsvJVD3UzXPCmwhInGgQ3fsNWZv9jhWkS
         qBZ/uIkzoLhC494xEh1cVAGnDJC5c8kGoJZeHTrYfBs91mJHMHPmbcTgI3U2IIDIAWEt
         WCscorxAa8dU8ukT54NW+qyPhOwFaTMq+lo1M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d1qy5wxeRoVOmQDNZKC3zuT1I7B8Wmbsg1PWKuM1gGo=;
        b=uOEnYjSjAI5CJi+X2rlhsxQHBi41SpLHmTvRgZbgTKyHT3jtAzjH4oT9GNnGQDixnj
         CwJ/LjNjEq6RQrOM5zHX/QegLc+0cvsV3qtFqOSjN/kdwtNY2eZfCb+kopBbf6VIrfYE
         xO/kof6Jf6VNgo5MHtrFQCNdNnRk2JfOIzaDvjUP+cqxGYAHPJU/VAkkPYjlhVSqBULW
         oavR3dC7DBpwkenZXAUZl6ZZcf5zoKl7WXaAdszwUWfS4YzjTGo1q8WlpMCRcPEthpAw
         WKeHpc/qZBq+2yokqoU1sKJRKDxg44MQrVfTpNP6xGBXG05B26rHa66wFIKAmwSHvasr
         f45Q==
X-Gm-Message-State: AOAM533Vj8vyCX+EEuL1BtNS+7AxgUXz+F83jwcJDhpi5EOaOsRiQ8Rn
        AAxg0ygpHeNEUgqDTCVu/tda+EF9oW1FASwR
X-Google-Smtp-Source: ABdhPJxNxDOMx0VeNpIr3faaABovxTXCE/pNkArpzc3dbYwGv5MS95sgGh/wfYfI7igehwXdWrI3kQ==
X-Received: by 2002:a2e:b04d:: with SMTP id d13mr18076670ljl.448.1619552426257;
        Tue, 27 Apr 2021 12:40:26 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id p14sm173578lfk.212.2021.04.27.12.40.25
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Apr 2021 12:40:25 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id j4so55982456lfp.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Apr 2021 12:40:25 -0700 (PDT)
X-Received: by 2002:a05:6512:a90:: with SMTP id m16mr17323063lfu.201.1619552425277;
 Tue, 27 Apr 2021 12:40:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210427025805.GD3122264@magnolia>
In-Reply-To: <20210427025805.GD3122264@magnolia>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 27 Apr 2021 12:40:09 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj6XUGJCgsr+hx3rz=4KvBP-kspn3dqG5v-cKMzzMktUw@mail.gmail.com>
Message-ID: <CAHk-=wj6XUGJCgsr+hx3rz=4KvBP-kspn3dqG5v-cKMzzMktUw@mail.gmail.com>
Subject: Re: [GIT PULL] iomap: new code for 5.13-rc1
To:     "Darrick J. Wong" <djwong@kernel.org>, Jia He <justin.he@arm.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Eric Sandeen <sandeen@sandeen.net>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 26, 2021 at 7:58 PM Darrick J. Wong <djwong@kernel.org> wrote:
>
> Please pull this single patch to the iomap code for 5.13-rc1, which
> augments what gets logged when someone tries to swapon an unacceptable
> swap file.  (Yes, this is a continuation of the swapfile drama from last
> season...)

Hmm. I've pulled this, but that "iomap_swapfile_fail()" thing seems a
bit silly to me.

We have '%pD' for printing a filename. It may not be perfect (by
default it only prints one component, you can do "%pD4" to show up to
four components), but it should "JustWork(tm)".

And if it doesn't, we should fix it.

So instead of having a kmalloc/kfree for the path buffer, I think you
should have been able to just do

    pr_err("swapon: file %pD4 %s\n", isi->file, str);

and be done with it.

And no, we don't have a ton of %pD users, so if it's ugly or buggy
when the file is NULL, or has problems with more (of fewer) than four
path components, let's just fix that (added Jia He and Al Viro to
participants, they've been the two people doing %pd and %pD - for
'struct dentry *' and 'struct file *' respectively).

                Linus
