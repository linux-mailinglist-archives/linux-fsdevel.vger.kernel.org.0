Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5038211A9F8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2019 12:33:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727851AbfLKLdz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Dec 2019 06:33:55 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:34104 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727365AbfLKLdz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Dec 2019 06:33:55 -0500
Received: by mail-io1-f66.google.com with SMTP id z193so22287973iof.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Dec 2019 03:33:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/02DdIhf2NamztxpqCLpvVZws4JCTLEfJPP6/R8Q/R0=;
        b=kRdtUYSdY7p7V2BV4jZJoBF2hlDIVB7T/lKyaP8/SSk3tSnXLukT3ttw4HtCZr1F8J
         Bmb/uJxzfGeBt3Osu469jHMxc4P3s8jjSIlBsgSGBeL2IGXbUcEzv4KMn5Ak4CxU1e0Q
         ld6BdGhzd8J4qNPjMJt0P3Q1AuFvX66e4UdC8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/02DdIhf2NamztxpqCLpvVZws4JCTLEfJPP6/R8Q/R0=;
        b=njWxP5KNR+mKHlp/3DjEY13PGtjwmwbXLptbawtDH6Dv225YM9nw5ODNbY4oyyG6lO
         CvLJmK0bxqVWDB5t087eyHzrNHr/Q2Das5Rp2yulbx+1FUSAFG0P5IjyWBSaJryIBsYA
         kcMjzawHRiGMGiWHECFJDSpnhOhIX3mMn3DRcJodzBZHz7XSSJU5BVd2H9OkTe1QSloz
         ySVWTeklt17YsKvSG2PgK+JWd9EeO1mSJF1KIVRbG8J7AgNZZ17DAfCx/v/qyCDA/FBB
         ESv44M/cfZqu/Rl6nsOiq1AO1xtF0dWtFcG5UHkUdgEU6ZfpA9OSznPs1tcq3lp0wyBB
         eNiA==
X-Gm-Message-State: APjAAAVahjeYvk4SnVUYaR80XcOPC65G0udb7ra2yCzDQa/Nqq+LMZf4
        Wh0vbUyVyHlmxEL+tlj9bCDgrwg5e4J8jHRJKIgilg==
X-Google-Smtp-Source: APXvYqyypNT5tw2ktSS9U0EHeVSqV6pxsBfzf1rmv25fYltb2a5TGFjj2bTKq9jvBrEmsTuG17Te3M6f0dAJqw+ENzI=
X-Received: by 2002:a6b:c9c6:: with SMTP id z189mr2169796iof.285.1576064034424;
 Wed, 11 Dec 2019 03:33:54 -0800 (PST)
MIME-Version: 1.0
References: <20191128154858.GA16668@miu.piliscsaba.redhat.com> <20191208055411.GT4203@ZenIV.linux.org.uk>
In-Reply-To: <20191208055411.GT4203@ZenIV.linux.org.uk>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 11 Dec 2019 12:33:43 +0100
Message-ID: <CAJfpegsy520VMOp_J5Ncr+zuWMw=dL_4VAaZ6ETBKpV14vwLyw@mail.gmail.com>
Subject: Re: [RFC PATCH] vfs: make rename_lock per-sb
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Dec 8, 2019 at 6:54 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Thu, Nov 28, 2019 at 04:48:58PM +0100, Miklos Szeredi wrote:
>
> > Turning rename_lock into a per-sb lock mitigates the above issues.
>
> ... and completely fucks d_lookup(), since false negative can be
> caused by rename of *ANYTHING* you've encountered while walking
> a hash chain.

Drat.

Could we use the bitlock in the hash chain head for verification of a
negative?  Seems like much finer grained than having to rely on a
global seqlock for hash integrity.

Thanks,
Miklos
