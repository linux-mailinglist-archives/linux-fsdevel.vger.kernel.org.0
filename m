Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E4D83D8DBD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jul 2021 14:27:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236293AbhG1M07 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Jul 2021 08:26:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235204AbhG1M0v (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Jul 2021 08:26:51 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BBC6C061798;
        Wed, 28 Jul 2021 05:26:48 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id w17so3545638ybl.11;
        Wed, 28 Jul 2021 05:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=g9LwHxHXC5qDgh7Rw7rbXvgKOrYZgamIabLRMHDDPdE=;
        b=ZdrteGW1nA7xRsM+S5I+KtW+WeCk1f8i+onuIgcTnHADESJYRGWFzT3WNa3EzSpZdY
         eg83oGEjb9tAKShV8EfcMYQxiBOnrxHehB7SwHpTOPF0WtIGqPtgQtd3ifX4YU+Ayra0
         JCObS1GSLlfgfFO0tueehM6US/7hl2GhKRBclk11+2HPW4fvviNY12tX18M6ymvxNRJ0
         AHvB5VtXzXa2rCFqbh7+9qzhuLesskcWY5h/SzAHvdFrp0/VJkp00rX30INx6ZVzMNiG
         RUWOiRWeDm7nhiYhJWgoUn7uOmRAbD6Pbqa0zpx0yH8uxxBw+XxjLqdQRyfJH9aWgxSk
         1UXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=g9LwHxHXC5qDgh7Rw7rbXvgKOrYZgamIabLRMHDDPdE=;
        b=rtwp4PotH6C1rWraPgdImD4l6vMmB7HKDfR/CXXdtO1K93g0wikedpsagfmogUL9IP
         0LDR0CNkh/kWMt60CbPn67XO8HntFYRB2V+NOq5A6OEd6x4QLUVf1Q6ZUj7m3y6s6g5u
         ELMlzC63k8UukZW+59/x1i6GhDmTK4TJaQdbNkJ0uTAkmrdOViak1gNP0fzOIBWUm0RG
         EVntNpRxqzP9O/Jb6jdmARVrgUZwxrsMcxEzHptjWMuhW2r1KMo8tTIxQ8IoC/HbVnAl
         7Hms/KgYLNeRWCt2eDnsY6+14dXtKn1wQX5nPgeXQmt//98buEje25fKVsmvpBzMjCSz
         X8lg==
X-Gm-Message-State: AOAM532SrbrDtJUXwuqeNVxRcH5G/wUx7J21QguQKR8ln/OmpcECexHE
        5+U7t1CN9rvmfXUI/zJp2jj5ZgF3lKxl8W6Il3g=
X-Google-Smtp-Source: ABdhPJxCe2mMDODYGW6OF0fRZyCdRdTP6PQOzo7vDQeJZBgMRIiag+FoEFNd+gI5VHTw83rjEqpeoSW/5unl2Q8tpRE=
X-Received: by 2002:a5b:286:: with SMTP id x6mr2835851ybl.59.1627475208122;
 Wed, 28 Jul 2021 05:26:48 -0700 (PDT)
MIME-Version: 1.0
References: <162742539595.32498.13687924366155737575.stgit@noble.brown>
 <20210728125819.6E52.409509F4@e16-tech.com> <20210728140431.D704.409509F4@e16-tech.com>
 <162745567084.21659.16797059962461187633@noble.neil.brown.name>
In-Reply-To: <162745567084.21659.16797059962461187633@noble.neil.brown.name>
From:   Neal Gompa <ngompa13@gmail.com>
Date:   Wed, 28 Jul 2021 08:26:12 -0400
Message-ID: <CAEg-Je8Pqbw0tTw6NWkAcD=+zGStOJR0J-409mXuZ1vmb6dZsA@mail.gmail.com>
Subject: Re: [PATCH/RFC 00/11] expose btrfs subvols in mount table correctly
To:     NeilBrown <neilb@suse.de>
Cc:     Wang Yugui <wangyugui@e16-tech.com>,
        Christoph Hellwig <hch@infradead.org>,
        Josef Bacik <josef@toxicpanda.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-nfs@vger.kernel.org,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 28, 2021 at 3:02 AM NeilBrown <neilb@suse.de> wrote:
>
> On Wed, 28 Jul 2021, Wang Yugui wrote:
> > Hi,
> >
> > This patchset works well in 5.14-rc3.
>
> Thanks for testing.
>
> >
> > 1, fixed dummy inode(255, BTRFS_FIRST_FREE_OBJECTID - 1 )  is changed t=
o
> > dynamic dummy inode(18446744073709551358, or 18446744073709551359, ...)
>
> The BTRFS_FIRST_FREE_OBJECTID-1 was a just a hack, I never wanted it to
> be permanent.
> The new number is ULONG_MAX - subvol_id (where subvol_id starts at 257 I
> think).
> This is a bit less of a hack.  It is an easily available number that is
> fairly unique.
>
> >
> > 2, btrfs subvol mount info is shown in /proc/mounts, even if nfsd/nfs i=
s
> > not used.
> > /dev/sdc                btrfs   94G  3.5M   93G   1% /mnt/test
> > /dev/sdc                btrfs   94G  3.5M   93G   1% /mnt/test/sub1
> > /dev/sdc                btrfs   94G  3.5M   93G   1% /mnt/test/sub2
> >
> > This is a visiual feature change for btrfs user.
>
> Hopefully it is an improvement.  But it is certainly a change that needs
> to be carefully considered.

I think this is behavior people generally expect, but I wonder what
the consequences of this would be with huge numbers of subvolumes. If
there are hundreds or thousands of them (which is quite possible on
SUSE systems, for example, with its auto-snapshotting regime), this
would be a mess, wouldn't it?

Or can we add a way to mark these things to not show up there or is
there some kind of behavioral change we can make to snapper or other
tools to make them not show up here?



--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!
