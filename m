Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A6951E4E91
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 May 2020 21:51:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728292AbgE0Tu7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 May 2020 15:50:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728115AbgE0Tu7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 May 2020 15:50:59 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92836C03E97D
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 May 2020 12:50:58 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id x6so11757556wrm.13
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 May 2020 12:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V5UMxzsS/A7fHxpEGv2BAIFrOJ94NXArnFHPmKBj8V0=;
        b=jAk1xYzHrYllHAyb2tJGBpdvqmrlJiIn2R6dQksKVcitqXIN9pEiYjgq46DPtqbIT7
         BrcUXbq2B3aGbr10M+zTw3l8kWi+fpvavDqeE2Jrv4oEmYgnIdw+HIV2mX5lQdBEyVEQ
         BPr0lvAHG5CJfsujOa9Qy54qyczNpRY4DMk38=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V5UMxzsS/A7fHxpEGv2BAIFrOJ94NXArnFHPmKBj8V0=;
        b=t9jw2W4aFwvrF8OnztD1C5O08yqej03oFrW8vqy9HQGW38SYJUA/i/qoNzlMtP4eRv
         b7eICnccHQe12SflXsh0poPuP3MhjQ5a5oHSQt6/ByAWNmtU0Vz4vqYTk98DsWyMs7k9
         oLz2js2RmAD7eLNBhLSIYGJMEGHRoDJT6LVuhI+f8PTTmEkVhW68DfamxphICKrAhQjt
         pyXCua/zXYTiu4qVMAPO5+3mGx5xItzj2+rSTiArZ2j4s0iFiQ6nmXoeeaoREgujFWWi
         lrPQuwY7z2MsGV1RAB8t84/4/h8EScnBNkp5U7Hx9i8WNJmZRW0V5KVLnUFkLW5dKgD7
         SDIA==
X-Gm-Message-State: AOAM531Qx8chWLjipNW3dGbWKCFm3QjeOdPTw9sLR1OacEqH7ZWqvfqa
        0P2Pi0GbgS49cYiWtBAR1WQJUOz88uvOXCOuoOHXSg==
X-Google-Smtp-Source: ABdhPJxQZzHuBd2fNDn1DgqffWs10SXs7xya1obkJmi+uRdPu3hKtz/ByHRxFBjAW1K5Uv8l0DcBmu+cg4njl0FORJQ=
X-Received: by 2002:adf:9c84:: with SMTP id d4mr4295373wre.327.1590609057271;
 Wed, 27 May 2020 12:50:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200527141753.101163-1-kpsingh@chromium.org> <20200527190948.GE23230@ZenIV.linux.org.uk>
In-Reply-To: <20200527190948.GE23230@ZenIV.linux.org.uk>
From:   KP Singh <kpsingh@chromium.org>
Date:   Wed, 27 May 2020 21:50:46 +0200
Message-ID: <CACYkzJ5MkWjVPo1JK68+fVyX7p=8bsi9P-C6nR=LYGJw04f9sw@mail.gmail.com>
Subject: Re: [PATCH] fs: Add an explicit might_sleep() to iput
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     open list <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, bpf <bpf@vger.kernel.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Christoph Hellwig <hch@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 27, 2020 at 9:09 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Wed, May 27, 2020 at 04:17:53PM +0200, KP Singh wrote:
> > From: KP Singh <kpsingh@google.com>
> >
> > It is currently mentioned in the comments to the function that iput
> > might sleep when the inode is destroyed. Have it call might_sleep, as
> > dput already does.
> >
> > Adding an explicity might_sleep() would help in quickly realizing that
> > iput is called from a place where sleeping is not allowed when
> > CONFIG_DEBUG_ATOMIC_SLEEP is enabled as noticed in the dicussion:
>
> You do realize that there are some cases where iput() *is* guaranteed
> to be non-blocking, right?

Yes, but the same could be said about dput too right?

Are there any callers that rely on these cases? (e.g. when the caller is
sure that it's not dropping the last reference to the inode).

- KP
