Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D07A326DD1
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Feb 2021 17:23:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbhB0QW6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 27 Feb 2021 11:22:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbhB0QW4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 27 Feb 2021 11:22:56 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A702C061756
        for <linux-fsdevel@vger.kernel.org>; Sat, 27 Feb 2021 08:22:14 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id u4so14220103ljh.6
        for <linux-fsdevel@vger.kernel.org>; Sat, 27 Feb 2021 08:22:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7rdkQd2nFo/KCgD1LcCFyZvYpZw3T9bvfpxt4ESvC74=;
        b=g83yuITN74+zzKknKk40bwZmybSxrR4J6Dt/SRQIsqRwol3dO6PJp11DL6FG6pjj+e
         V6nsjoYNFg20Au0H7BtkAf75VI6j/R8rS0XYhvcgrdsWxTgxGml880FfPz3PnEgbkCYM
         Lf6BX69TlWhFtZ/4uFjS4epYIuhbfnuuvCFvo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7rdkQd2nFo/KCgD1LcCFyZvYpZw3T9bvfpxt4ESvC74=;
        b=BXiLk/KwoAo4lZ/uZmsyVISNyUHrjOUlvbdy6JPWS1QUWS1cPLNtmkb71ZtcOmskwk
         CnXctcpUO4lDmD/mNfmLZOPs70uki9ff9w4bYbCCElC+oWRfIv6RVZN9+OudpZUTqjtm
         QcFwMSRIQB4GovDA68OXBppickq38BUfNWWjl9ZkuTWJtzwbNIEdDPlB4s8qQE5CMz/r
         2mlb43x8n1kFJW+/7Y40kjAEUwTCUQzLYOV5fh710dAtT/NjZXcD0/KdgWco0kPA8Qo2
         0Ik/KH/GYn/1264KhmTTjLUDEO/ywyYyCSWzyZX+MVaE+isdxMuy/K53SAetAPR1nJls
         lZLA==
X-Gm-Message-State: AOAM531qKYp5jZrOqAPv98YXP2piiiEISLQpHNr1LahYRuSfLyEpP5XD
        bHUiixkoRtcREhFRDTbv5SJteUbMvEmsIg==
X-Google-Smtp-Source: ABdhPJxhhZenSj9IkNlps7I7mmfhqh6kUhxQ2fepKjGn6w+JoOkrJ+oSq9sslSMa0glbvzcUT5EA6g==
X-Received: by 2002:a05:651c:1186:: with SMTP id w6mr4418828ljo.290.1614442932748;
        Sat, 27 Feb 2021 08:22:12 -0800 (PST)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id 3sm904389lfq.1.2021.02.27.08.22.11
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Feb 2021 08:22:12 -0800 (PST)
Received: by mail-lf1-f48.google.com with SMTP id z11so18531987lfb.9
        for <linux-fsdevel@vger.kernel.org>; Sat, 27 Feb 2021 08:22:11 -0800 (PST)
X-Received: by 2002:a19:ed03:: with SMTP id y3mr3977259lfy.377.1614442931514;
 Sat, 27 Feb 2021 08:22:11 -0800 (PST)
MIME-Version: 1.0
References: <YDnf/cY4c0uOIcVd@zeniv-ca.linux.org.uk>
In-Reply-To: <YDnf/cY4c0uOIcVd@zeniv-ca.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 27 Feb 2021 08:21:55 -0800
X-Gmail-Original-Message-ID: <CAHk-=whHCLK=_h27zMi8A=sn-GO=C+JOAX4nb7QjuGRbLebgbQ@mail.gmail.com>
Message-ID: <CAHk-=whHCLK=_h27zMi8A=sn-GO=C+JOAX4nb7QjuGRbLebgbQ@mail.gmail.com>
Subject: Re: [git pull] vfs.git misc stuff
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 26, 2021 at 10:00 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> Al Viro (3):
>       9p: fix misuse of sscanf() in v9fs_stat2inode()

Hmm. Technically this changes some of the rules. It used to check that
i tall fit in 32 bytes. Now there could be arbitrary spaces in there
that pushes it over the limit.

I don't think we care, but..

             Linus
