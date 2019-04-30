Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 22B92F473
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2019 12:47:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbfD3KrK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Apr 2019 06:47:10 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:38616 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726539AbfD3KrK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Apr 2019 06:47:10 -0400
Received: by mail-lf1-f66.google.com with SMTP id v1so10467520lfg.5
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 Apr 2019 03:47:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VmpVtnJXoZD7hpcFvy3KfMWpWjz8E7iIMZMr/p/hx08=;
        b=naXpCQLCNxOZOSHldMJ0+WM6FQx/fQ9yE+Rb8l8d0471HF+gvRe6N8/KaW+0cIyc9n
         PfMJiFMImi8NuPqV7bXtbCRqLm6DmmbshyoOdqW2ja9qduapOSH7dBTgRJaaKQwfpAhx
         bx8TRuw+WTMfBMvJZ+2mPJKu63dhRIYkVp7KqrbzlY4/aYHBszy8F7Xk+iiK/5JkWiiO
         XTdduCZIId8fAi4OnN/BrPtawLFQLbCLBTefCY0uCFTCLhODxi3U7ElNQ5X8kc1vMeLK
         3D2Zumags6+EplHbcnc7M3NsY9AfAeoZGs7R3O8I8ewessAeN9cDsxweoiNW6GBR8Jnr
         freg==
X-Gm-Message-State: APjAAAUBlJ73oaMh8ltcrB0qYSON2fjB5W/a2sTm1CQL1Ke2GCwLRqbY
        EPrFackQ8DtzbRENRa9MT+zunsx5428f5fZBpkrNxn0p
X-Google-Smtp-Source: APXvYqwQw358S3PMpr7zTHIOWFDZ2GZkPL/RkKarMWKmXIh0nGsO6gwvqzyuRx+/utLNMRV4qHESkYTIoNTKFCQ2AY0=
X-Received: by 2002:a19:a417:: with SMTP id q23mr34990275lfc.110.1556621228264;
 Tue, 30 Apr 2019 03:47:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190429222613.13345-1-mcroce@redhat.com>
In-Reply-To: <20190429222613.13345-1-mcroce@redhat.com>
From:   Matteo Croce <mcroce@redhat.com>
Date:   Tue, 30 Apr 2019 12:46:31 +0200
Message-ID: <CAGnkfhzkju6LXwHAVCHxCmMvAa1MLQGRY1czE1Boqz2OcEq39Q@mail.gmail.com>
Subject: Re: [PATCH v4] proc/sysctl: add shared variables for range check
To:     LKML <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 30, 2019 at 12:26 AM Matteo Croce <mcroce@redhat.com> wrote:
>
> Add a const int array containing the most commonly used values,
> some macros to refer more easily to the correct array member,
> and use them instead of creating a local one for every object file.
>

Ok it seems that this simply can't be done, because there are at least
two points where extra1,2 are set to a non const struct:
in ip_vs_control_net_init_sysctl() it's assigned to struct netns_ipvs,
while in mpls_dev_sysctl_register() it's assigned to a struct mpls_dev
and a struct net.

So, sadly making extra1,2 const is a no-go :(

Andrew, I'm thinking to add the "sad and lame" cast in the macro, to
have a single point where hide it


Regards,
--
Matteo Croce
per aspera ad upstream
