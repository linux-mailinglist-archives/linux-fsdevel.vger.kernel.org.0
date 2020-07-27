Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A891822F5E4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Jul 2020 18:59:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728677AbgG0Q75 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Jul 2020 12:59:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727915AbgG0Q75 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Jul 2020 12:59:57 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB17DC061794;
        Mon, 27 Jul 2020 09:59:56 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id b13so10283572edz.7;
        Mon, 27 Jul 2020 09:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=khppo+jLs5IKVg2WuNWXQuRn+S2GoJzKfqbAxy/nNiY=;
        b=oux8HQ9ZJE0ipaTs9n4SlEY/8I4Cssg4G2BaFvd1iGGaD2ZUJKZJeoirsGmVqN9Q1g
         LggBxRc8tAFSWrS8OC/qjr/52h1mqqRyddm006T3Ue2T0s8IHfVWriH5Hi2LWm4F3rZ5
         FgQHf3Ydv6qwr84pnVnwnGDL01QAqeYwkOF9X3AYCIkUrc8451qzNiOynvuiXIy4Cy7y
         nrWrKc3pkzViTxqOGT7f2KmMAEa5bO2mbMDXiLlig+6IHOXroWXhkPtxB/A6jhp1doPM
         XDVSTvug5Y4B1hiQiRP6T8uNotD9wt2v3QIX88H4G6XpN7O2vrpbVd4rz3VpZlByFuZ2
         GGkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=khppo+jLs5IKVg2WuNWXQuRn+S2GoJzKfqbAxy/nNiY=;
        b=b9UCko7lXQZGqK2zi69nvm4wfgHDDDlGFM3MV9GjN/yYYURxD8zTz5DZtWz7ErwZPV
         +yTu6hyfjwwVLUTUgf+5M1JOoWcIEZP3H7y/2bBZqJtPvXWOaLsHnsDY0BZnWafnY1yL
         +UcKeaOJBTGxS/oIoq5hql2eke4IPAuzMHmtjS3GyH6AeaxB+iRO91W3jsaWOBiVXYoE
         1EimYqkKZ2rWg80KC0+nqEyLCvuruV+IfnfW8eyaxgiTcINGjmOWB3pRV6Mh7ghh3IeR
         iVc38vqbnvvgUzRJ8DRcszDUEXRjmShcsywcmuVJZoHdIp9oMQ7f4qMrAHPicydokddG
         D45w==
X-Gm-Message-State: AOAM5307w617tX8mKpLwZpzCvA0YGF3KyqZr+tJH9OcFqvGG+5d7VVBb
        33J1k23XrBY2AeAEIO1YRzqZ8sKr26RW4TQSxS9nShpz61Y=
X-Google-Smtp-Source: ABdhPJzj9KqvJailzDRZoU9x6wLecksxYDyommYSwhoW67IFRhcO49+bNnI9jr+Ef6EXtzstzWvrmbKKCx8FgVWKRdg=
X-Received: by 2002:aa7:d90f:: with SMTP id a15mr21464035edr.86.1595869195512;
 Mon, 27 Jul 2020 09:59:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200628070152.820311-1-ebiggers@kernel.org> <20200727165000.GH1138@sol.localdomain>
In-Reply-To: <20200727165000.GH1138@sol.localdomain>
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date:   Tue, 28 Jul 2020 01:59:43 +0900
Message-ID: <CAKFNMo=ZMHP2_14f8g6AxT7WR7Y_0qDXcq7hhqQLsxTgKE5vdw@mail.gmail.com>
Subject: Re: [PATCH] nilfs2: only call unlock_new_inode() if I_NEW
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-nilfs <linux-nilfs@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Yeah, I sent this to Andrew a little while ago:

  https://lkml.org/lkml/2020/7/27/976

Thanks,
Ryusuke Konishi

On Tue, Jul 28, 2020 at 1:50 AM Eric Biggers <ebiggers@kernel.org> wrote:
>
> On Sun, Jun 28, 2020 at 12:01:52AM -0700, Eric Biggers wrote:
> > From: Eric Biggers <ebiggers@google.com>
> >
> > unlock_new_inode() is only meant to be called after a new inode has
> > already been inserted into the hash table.  But nilfs_new_inode() can
> > call it even before it has inserted the inode, triggering the WARNING in
> > unlock_new_inode().  Fix this by only calling unlock_new_inode() if the
> > inode has the I_NEW flag set, indicating that it's in the table.
> >
> > Signed-off-by: Eric Biggers <ebiggers@google.com>
>
> Ping.  Ryusuke, any interest in taking this patch?
>
> - Eric
