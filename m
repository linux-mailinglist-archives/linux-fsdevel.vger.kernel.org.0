Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5BBC84464E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2019 18:50:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730227AbfFMQuq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jun 2019 12:50:46 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:36026 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbfFMEA7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Jun 2019 00:00:59 -0400
Received: by mail-lj1-f194.google.com with SMTP id i21so17087891ljj.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Jun 2019 21:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fbJVJjV4JHgO+lN2CsoiJmjNN9A/OrzWGNbZgYy8/Gk=;
        b=ZuHB+EFIWdmyBI+Bcm6q34WvnNer+ayYdcSCBHw9qKdJL9RuMOUEPVDSrPOV456jEe
         Mu2BtvM6HHM2VC/dxpIL71LNetzBiC2Kp/5bf8wCUjnRs36qyJeTHEY/nu3+T/gkFmV2
         AKNJR7dBb43TR0xZODVPwIEf0f2Q0JzJ6s+UY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fbJVJjV4JHgO+lN2CsoiJmjNN9A/OrzWGNbZgYy8/Gk=;
        b=aPcqEdgI157R+S7KLBTyJBfPeF7NgGwRltnlWb3CDsdnUnyEnzzuqx+PSsn3bUifdp
         Y5TPwtdvxOXIpHPUgMsXxn4Ip6nVGBCwIxvFNTIVoBGsj8ruXuCrLRJTivHGNRxxi2wm
         mH9VBwkLcCDooL8NM0iDCY6lrf3vMwk/pq0qsIys/1GSkH0DKMAS3ALXZyVuDbCFg6QW
         tLtpBpG/gpr7Q88O4rFXFEESHR7DNUdLS8H3dDyCqHKuZr9tVqDSzs6ApkTm0zHJXqFj
         6IjHHOTwFI+TXcJ6rE/VSxl0Xe95SiyYhBIqxUDp7soOKfVYj9IhPF82M2fYSUDaiAlU
         eIEw==
X-Gm-Message-State: APjAAAUweiJjK+0veyd9pL/vMLfO+tG4337RqjdMQul6fJOLoDDlYh+Q
        ZLE/EmLyih6GXFB3sOvGyQJuXVOaOIo=
X-Google-Smtp-Source: APXvYqytGnd7R4qqFRA4jyma10MohjNgPNX6jV0rS2DGXm0+r1eixgLhhhbFDQpPXPBj94Hx0qTIGg==
X-Received: by 2002:a2e:9e58:: with SMTP id g24mr2034142ljk.1.1560398457143;
        Wed, 12 Jun 2019 21:00:57 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id c8sm320167ljk.77.2019.06.12.21.00.55
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Jun 2019 21:00:55 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id a21so17073868ljh.7
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Jun 2019 21:00:55 -0700 (PDT)
X-Received: by 2002:a2e:2c07:: with SMTP id s7mr5616489ljs.44.1560398455064;
 Wed, 12 Jun 2019 21:00:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190612225431.p753mzqynxpsazb7@brauner.io>
In-Reply-To: <20190612225431.p753mzqynxpsazb7@brauner.io>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 12 Jun 2019 18:00:39 -1000
X-Gmail-Original-Message-ID: <CAHk-=wh2Khe1Lj-Pdu3o2cXxumL1hegg_1JZGJXki6cchg_Q2Q@mail.gmail.com>
Message-ID: <CAHk-=wh2Khe1Lj-Pdu3o2cXxumL1hegg_1JZGJXki6cchg_Q2Q@mail.gmail.com>
Subject: Re: Regression for MS_MOVE on kernel v5.1
To:     Christian Brauner <christian@brauner.io>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        David Howells <dhowells@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 12, 2019 at 12:54 PM Christian Brauner <christian@brauner.io> wrote:
>
> The commit changes the internal logic to lock mounts when propagating
> mounts (user+)mount namespaces and - I believe - causes do_mount_move()
> to fail at:

You mean 'do_move_mount()'.

> if (old->mnt.mnt_flags & MNT_LOCKED)
>         goto out;
>
> If that's indeed the case we should either revert this commit (reverts
> cleanly, just tested it) or find a fix.

Hmm.. I'm not entirely sure of the logic here, and just looking at
that commit 3bd045cc9c4b ("separate copying and locking mount tree on
cross-userns copies") doesn't make me go "Ahh" either.

Al? My gut feel is that we need to just revert, since this was in 5.1
and it's getting reasonably late in 5.2 too. But maybe you go "guys,
don't be silly, this is easily fixed with this one-liner".

                      Linus
