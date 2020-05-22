Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F34D91DDB8A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 May 2020 02:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730360AbgEVABI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 May 2020 20:01:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730105AbgEVABI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 May 2020 20:01:08 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 922CAC08C5C0
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 May 2020 17:01:06 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id z22so5544780lfd.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 May 2020 17:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vbo7f9Gr3cg/KLt/kOvWotZglXfgKin96QcbEfg0Yl0=;
        b=TFdXsMqAMyMKk9ye8tn2O/u/rQLmivp7qkkUkjoGIuirsDa5u7y7VK/iAP5npzCGm4
         DrEjofrl+c2jqHiQGxbMu0kLgifgYnjy4EIk0TIi/3hnmC38lqS6wf6XraHA3KxElkdH
         rTo0K9NG6zdBb/ImWn4JBhqPb7/fqXrQNHsYI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vbo7f9Gr3cg/KLt/kOvWotZglXfgKin96QcbEfg0Yl0=;
        b=ZW3BCVQVyCkU2OSfYWXZzLPHk1/1mR7BjsDIaQKt+w+sxNZxi9tXVUOZMmMRQm45r3
         oHyrv87TsiEpNyEqJJ3cjJ7jnIlhzM1zk/c/3x/BGc9bRnukiTDoiVcuQ0boWNDRcL3I
         2ugFHsq6eW9dkITilAaRJRSWi2VmAI6bLb3RlHZRxNgKdJ941WYDw8MWSDjjV6w+vgtT
         vASkNoqAY/UVbAYav5XqmODl8F43bdj/E0tt6P1lfDemp/BvtjvXMPo4RFv8/04zYGb7
         GwtjFhZ9BC4+01SV0SS5H5UsKccwiXF+hAznjP3m8dIcqF9AeEUhUm6lGc/JaiVdlzi9
         jn1g==
X-Gm-Message-State: AOAM533tMNnbOfRPVGwM4lfERzUdhVsRQcFxvbQiloncOs0fxu2GOD0i
        Lo7hHEI7/iygw7pqBs9w8bnU/6hoU8Q=
X-Google-Smtp-Source: ABdhPJygVx8aj55ZpKJDqpsCFZgb/kGGFCz1abuCMiREiz1dkGeqj7o0zQofdnWh0tOUGVnhmLDzlA==
X-Received: by 2002:a19:5f4e:: with SMTP id a14mr6184918lfj.57.1590105663449;
        Thu, 21 May 2020 17:01:03 -0700 (PDT)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id h25sm370847lji.105.2020.05.21.17.01.02
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 May 2020 17:01:02 -0700 (PDT)
Received: by mail-lj1-f170.google.com with SMTP id z6so10440804ljm.13
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 May 2020 17:01:02 -0700 (PDT)
X-Received: by 2002:a2e:9891:: with SMTP id b17mr4329530ljj.312.1590105661602;
 Thu, 21 May 2020 17:01:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200505154324.3226743-1-hch@lst.de> <20200507062419.GA5766@lst.de>
 <20200507144947.GJ404484@mit.edu> <20200519080459.GA26074@lst.de> <20200520032837.GA2744481@mit.edu>
In-Reply-To: <20200520032837.GA2744481@mit.edu>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 21 May 2020 17:00:45 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgUM=bB4Ojz+km9aAtWC9TPtcNXANk32XCPm=yZ-Pi2MA@mail.gmail.com>
Message-ID: <CAHk-=wgUM=bB4Ojz+km9aAtWC9TPtcNXANk32XCPm=yZ-Pi2MA@mail.gmail.com>
Subject: Re: fix fiemap for ext4 bitmap files (+ cleanups) v3
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Christoph Hellwig <hch@lst.de>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        adilger@dilger.ca, Ritesh Harjani <riteshh@linux.ibm.com>,
        Amir Goldstein <amir73il@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-unionfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Ted's pull request got merged today, for anybody wondering..

Christoph, can you verify that everything looks good?

          Linus

On Tue, May 19, 2020 at 8:28 PM Theodore Y. Ts'o <tytso@mit.edu> wrote:
>
> I'll send it to Linus this week; I just need to finish some testing
> and investigate a potential regression (which is probably a flaky
> test, but I just want to be sure).
