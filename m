Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 778D83DB300
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jul 2021 07:54:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237004AbhG3Fyv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Jul 2021 01:54:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236641AbhG3Fyu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Jul 2021 01:54:50 -0400
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98373C0613C1
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Jul 2021 22:54:45 -0700 (PDT)
Received: by mail-vs1-xe33.google.com with SMTP id q68so4832960vsb.9
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Jul 2021 22:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1SNy8LW/E+8+ElZpkoWIFsZBHlsdT3d2OxsKqUy6RHw=;
        b=OrOtfbAtgDjL5oEcpFfXsYf2A0YndCveLq4cDS0W/7gT2XliL6bbv+qCH345i1N/Z0
         Vu15fmugh8dTMc7eP9NuKKMN3cszgAph4kO33C1xM5FOUqV/45zBxEFKWcJW8xgDcXQ0
         lhCxYQLMRB9AfFKz2uBv67omqq2V+OKPAxTBc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1SNy8LW/E+8+ElZpkoWIFsZBHlsdT3d2OxsKqUy6RHw=;
        b=kA7fkYCgvGSjG2q0JiV3QoT0cxOQS90W3LuIwvzGb5UuFBMncaWVqCAZYKa0Zhkkfn
         uyI4C1oZ5pMDrWPuyw9oJik/eHS8z0Gw4xz9IlVsUPqIbc198uRN+glEOprIzugOAYli
         IzujSc5ogNhOqQbNY87FFvD3wYuycN8+FQYeIseH+G4R6xoXxR+AKkS58ezsXpuMFmz6
         Iep/8Zxim7FFYMrBLddQytQQV7JqqHv/F8bQkQ5fxwJ1DCs2tNPuVTB6VlP+JSUWrto2
         PDf+5q3h5anQZszJcjWRk1nxVZHPowtaQ0k/QAEDk7U0SxeDKtJHo8M0WhhrAzr4ykGu
         jStA==
X-Gm-Message-State: AOAM532vTO/vWP8PDLkmjMoPtWiVYaUwm26mcs2lCMlM2vOBKP4monjY
        X/MQfassMdmg26c9AwO6Hr2jfFWyOVx0RPSzml04hHbrxIk=
X-Google-Smtp-Source: ABdhPJwpge6iVGOfoymPDRo8pcPqDXfJ9ZzeVbQulV8CRSYfoKFi7A3vNMX7JgsDY3TDVYtWKA/dQ3zg9u5SHFxdrHE=
X-Received: by 2002:a05:6102:34d9:: with SMTP id a25mr392282vst.0.1627624484737;
 Thu, 29 Jul 2021 22:54:44 -0700 (PDT)
MIME-Version: 1.0
References: <162742539595.32498.13687924366155737575.stgit@noble.brown>
 <162742546548.32498.10889023150565429936.stgit@noble.brown>
 <YQNG+ivSssWNmY9O@zeniv-ca.linux.org.uk> <162762290067.21659.4783063641244045179@noble.neil.brown.name>
In-Reply-To: <162762290067.21659.4783063641244045179@noble.neil.brown.name>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Fri, 30 Jul 2021 07:54:33 +0200
Message-ID: <CAJfpegsR1qvWAKNmdjLfOewUeQy-b6YBK4pcHf7JBExAqqUvvg@mail.gmail.com>
Subject: Re: [PATCH 01/11] VFS: show correct dev num in mountinfo
To:     NeilBrown <neilb@suse.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Josef Bacik <josef@toxicpanda.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>, linux-fsdevel@vger.kernel.org,
        Linux NFS list <linux-nfs@vger.kernel.org>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 30 Jul 2021 at 07:28, NeilBrown <neilb@suse.de> wrote:
>
> On Fri, 30 Jul 2021, Al Viro wrote:
> > On Wed, Jul 28, 2021 at 08:37:45AM +1000, NeilBrown wrote:
> > > /proc/$PID/mountinfo contains a field for the device number of the
> > > filesystem at each mount.
> > >
> > > This is taken from the superblock ->s_dev field, which is correct for
> > > every filesystem except btrfs.  A btrfs filesystem can contain multiple
> > > subvols which each have a different device number.  If (a directory
> > > within) one of these subvols is mounted, the device number reported in
> > > mountinfo will be different from the device number reported by stat().
> > >
> > > This confuses some libraries and tools such as, historically, findmnt.
> > > Current findmnt seems to cope with the strangeness.
> > >
> > > So instead of using ->s_dev, call vfs_getattr_nosec() and use the ->dev
> > > provided.  As there is no STATX flag to ask for the device number, we
> > > pass a request mask for zero, and also ask the filesystem to avoid
> > > syncing with any remote service.
> >
> > Hard NAK.  You are putting IO (potentially - network IO, with no upper
> > limit on the completion time) under namespace_sem.
>
> Why would IO be generated? The inode must already be in cache because it
> is mounted, and STATX_DONT_SYNC is passed.  If a filesystem did IO in
> those circumstances, it would be broken.

STATX_DONT_SYNC is a hint, and while some network fs do honor it, not all do.

Thanks,
Miklos
