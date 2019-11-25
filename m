Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4B6B1092E7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2019 18:35:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727637AbfKYRfZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Nov 2019 12:35:25 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:36246 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbfKYRfZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Nov 2019 12:35:25 -0500
Received: by mail-yw1-f67.google.com with SMTP id y64so5724265ywe.3;
        Mon, 25 Nov 2019 09:35:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=REnPPHm5jZGnzNLlbfrOQnjR6ZbZNQbd6anV5/rTAAU=;
        b=fYI29aePnlZqOJmQFA+OGrkeIIRZSL5YUOa4ySimAihbzo7BzPxXQAegCfGxNviRTW
         QHJPyD+gnMmdKwQXucCQcQ9l31xmtIbTM2VKquV3rHv9C/SD+XHRqKy6i3qv9g2om/wb
         ppF/qcO/9D4cQDMdEH9KMymInuQ5I0WP37nSpMkbOX5TSAuWSrmoHncSF+mlMVZr0cWj
         SBv74OD2ha5hpnZyVbJbxrhy22QlHbYN9NZxMUL2AmdV7men/+VUzt8do6+1IkIHg3xz
         uk5oj53g88Qq0UK+UO1aQ8C4Sfru1klFS/x2bniSAvrNId2XgFhozWkdTOCz6nAA0HGf
         ap9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=REnPPHm5jZGnzNLlbfrOQnjR6ZbZNQbd6anV5/rTAAU=;
        b=grNwTvAmsiHN7jlUxB1bm8IpKGZn4R89H8mp0zyjOaZHw6+fH8jRWp85u+70EVJAjG
         svzW10QvlnCIB7dRo00VPYUBdzEQ7zGeeKFFcrq/M1m1odA7XudTnfki9kWHuea1tETO
         hbVVPEohstiqoTrMFCob8TjB5S4RW3KrWnV3Nx+DJrPSNwjgEABJILf2/OPEyWrKEwzZ
         5XsQCIgUzyp7bMFrpr9Sh9zyzEoBjUXl86ZzlwvkGumpDYYX/CpSXstvwmcydcx0OISu
         c4PcmOkjgndoXkHAXsz4OJDYT4gpEaFaZjmX6VGgOWcQP9Sm4ZA4Hwkgq5TYuSayxj7l
         Io1g==
X-Gm-Message-State: APjAAAWgs7EzeDm3tzg7GmQR2ty1r5+WKvGI7IKD+1x8I44xAhYE0g78
        WdqgymVCLMvxZDJmhWPWJpuyGtU1RB/s80j/hO4=
X-Google-Smtp-Source: APXvYqzA+jU4aGFJxSFPBv3uXbd1KqyX5nO72aHrawF0mnP9hbqnLtylCOaL9j5irvWA22AtOsQxjM1468y2o6Kg5W8=
X-Received: by 2002:a81:ae07:: with SMTP id m7mr14026428ywh.294.1574703323971;
 Mon, 25 Nov 2019 09:35:23 -0800 (PST)
MIME-Version: 1.0
References: <20191124193145.22945-1-amir73il@gmail.com> <20191125164625.GB28608@fieldses.org>
In-Reply-To: <20191125164625.GB28608@fieldses.org>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 25 Nov 2019 19:35:12 +0200
Message-ID: <CAOQ4uxh3OMmVotx-v9Lnvwcs7zxeBs9Ag9Q0uUK6f2v2Yqto5Q@mail.gmail.com>
Subject: Re: [PATCH] utimes: Clamp the timestamps in notify_change()
To:     "J . Bruce Fields" <bfields@fieldses.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Jeff Layton <jlayton@kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        y2038@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 25, 2019 at 6:46 PM J . Bruce Fields <bfields@fieldses.org> wrote:
>
> On Sun, Nov 24, 2019 at 09:31:45PM +0200, Amir Goldstein wrote:
> > Push clamping timestamps down the call stack into notify_change(), so
> > in-kernel callers like nfsd and overlayfs will get similar timestamp
> > set behavior as utimes.
>
> So, nfsd has always bypassed timestamp_truncate() and we've never
> noticed till now?  What are the symptoms?  (Do timestamps go backwards
> after cache eviction on filesystems with large time granularity?)

Clamping seems to be new behavior since v5.4-rc1.
Before that clamping was done implicitly when hitting the disk IIUC,
so it was observed mostly after cache eviction.

>
> Looks like generic/402 has never run in my tests:
>
>         generic/402     [not run] no kernel support for y2038 sysfs switch
>

The test in its current form is quite recent as well or at the _require
has changed recently.
See acb2ba78 - overlay: support timestamp range check

You'd probably need something similar for nfs (?)

Thanks,
Amir.
