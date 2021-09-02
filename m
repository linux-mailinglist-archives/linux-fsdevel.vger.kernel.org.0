Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4F113FEA45
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Sep 2021 09:54:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243886AbhIBHy5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Sep 2021 03:54:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243860AbhIBHy4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Sep 2021 03:54:56 -0400
Received: from mail-vk1-xa33.google.com (mail-vk1-xa33.google.com [IPv6:2607:f8b0:4864:20::a33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A4C8C061757
        for <linux-fsdevel@vger.kernel.org>; Thu,  2 Sep 2021 00:53:59 -0700 (PDT)
Received: by mail-vk1-xa33.google.com with SMTP id ay16so337318vkb.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Sep 2021 00:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8cXvSpYZuNaX1iPUSL6z/6TmQH+CSZ/JIxOOTFRXmG0=;
        b=GhRToXsSmVEnK8SWnx6tdamp7V2qkopiOAXwrJcy9ICE97uljjqARi0m/agRHpXYGf
         Yo44ka+hIiaopxrh/rBysUoiak2ymcy2spamIisV1AYmULDrxOOamhasYMd4/M9iW9W1
         M/ptC5UOxqOt0VozcuaCuXp2OA6ECpYsPFspc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8cXvSpYZuNaX1iPUSL6z/6TmQH+CSZ/JIxOOTFRXmG0=;
        b=mwJLYRqAgEXDQsQsCDCSvPkG/wZJVnTcmwEpppqZjOxeVmiQJ6B9Ais0TJZNZdIa8U
         OsbcAPwM2EMeiJ5O0PdpeT4N1ZVYvhaBPWRHltNPbppTVOXsYJQkEBIYusUye4PHBJOJ
         3rIJ/+sb9MXnga3pfILEMuJhP7ZEqttjn0Mpd5vjjcKcjBO2Bd0AiEg5RwX+SPOqGEo5
         cIqgj4AonyhCcVxx2wQGTt+sUBKU9usE00O1Bzt7/LolRcQhNiS/Pcf7t2pPTlJjMYbB
         7w5H1YpUxrjmgFfanDeDefE6LIg8ttEI3EfHEANOaQlqTAirAv72evaHsJItz25WEsD0
         ckmA==
X-Gm-Message-State: AOAM532wfsS90w2EeiB/byVyd2WxVo7O/caSMJ1t43ucEvQDaR96KV3W
        +ZEhi54wxDfdI3UF6d3pmcgsC4U6X9iNvaqz+cz8VA==
X-Google-Smtp-Source: ABdhPJx/6cBqsuLT0zgyPejvHY+ZRV0rJ1oIyfHJRkhzzPerApyuB/wV9f+h89Uows1jpobqqozcA7HN4uqmWTCb9Po=
X-Received: by 2002:a05:6122:8d4:: with SMTP id 20mr783887vkg.19.1630569238162;
 Thu, 02 Sep 2021 00:53:58 -0700 (PDT)
MIME-Version: 1.0
References: <162995209561.7591.4202079352301963089@noble.neil.brown.name>
 <162995778427.7591.11743795294299207756@noble.neil.brown.name>
 <YSkQ31UTVDtBavOO@infradead.org> <163010550851.7591.9342822614202739406@noble.neil.brown.name>
 <YSnhHl0HDOgg07U5@infradead.org> <163038594541.7591.11109978693705593957@noble.neil.brown.name>
 <YS8ppl6SYsCC0cql@infradead.org> <163055561473.24419.12486186372497472066@noble.neil.brown.name>
 <YTB6NacU9bIOz2vf@infradead.org>
In-Reply-To: <YTB6NacU9bIOz2vf@infradead.org>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 2 Sep 2021 09:53:47 +0200
Message-ID: <CAJfpegu7rwoFXdtLusyRhrtFgMPxRShesxnBT2Q6iiC_iSGsfg@mail.gmail.com>
Subject: Re: [PATCH v2] BTRFS/NFSD: provide more unique inode number for btrfs export
To:     Christoph Hellwig <hch@infradead.org>
Cc:     NeilBrown <neilb@suse.de>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Linux NFS list <linux-nfs@vger.kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 2 Sept 2021 at 09:18, Christoph Hellwig <hch@infradead.org> wrote:

> >  Your attitude seems to be that this is a btrfs problem and must be
> >  fixed in btrfs.
>
> Yes.

st_ino space issues affect overlayfs as well.   The two problems are
not the same, but do share some characteristics.  And this limitation
will likely come up again in the future.

I suspect the long term solution would involve introducing new
userspace API (variable length inode numbers) and deprecating st_ino.
E.g. make stat return an error if the inode number doesn't fit into
st_ino and add a statx extension to return the full number.  But this
would be a long process...

Thanks,
Miklos
