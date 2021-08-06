Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B8483E248C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Aug 2021 09:52:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241108AbhHFHw3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Aug 2021 03:52:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbhHFHw3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Aug 2021 03:52:29 -0400
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86AADC06179C
        for <linux-fsdevel@vger.kernel.org>; Fri,  6 Aug 2021 00:52:13 -0700 (PDT)
Received: by mail-vs1-xe31.google.com with SMTP id b138so4703385vsd.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Aug 2021 00:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B9Mx6FUSysA8MLwLdNNR3QTzovVkEjBB6X0ikf8q3Pc=;
        b=Iu2eSsj9w7Hgnsy81F8tI3U6TyXrFGwKXBDZGvoZTDwZy7ZF8H3ebxcow/3FxtydF5
         9fMGelET7p3YYC9b/u94E6xkz+Z6g5hEXy7Lr5rJsBGP6Vehy370KnrnDS8A9Cktp3aI
         T5buRGtXpZ77Pp/BmRTZlq637tB29CeJUp5KU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B9Mx6FUSysA8MLwLdNNR3QTzovVkEjBB6X0ikf8q3Pc=;
        b=LKa9/dbSBRkp1KwD77pYAl2ubvY80bpHYSTim1N+1w6RJEaq/vlqEIDSGxKKwv0nbZ
         AxIUPjHk133tVMfcsvTsOXw+WhbghR0Quf6QaIpelRt4wCYi/WUbPYhNxSdgQjiAWLUD
         mJmlsuqmZoY0nDDvhh7zZTA+Agqp6t75ovDDKg9aVAaOUqK4FrK2cl2K4yTD02GzmHlT
         6BUFn5JOsRoMSFpstl0q8qtYHStHPNvcn5PAd/6DsjbG3M7+9MfFncRw/d39fVPDO11S
         nXwmOol5F88POrSNiWsDhmXjYcfeOAL/5WMZTDLzECemp4Hbv8fSTysJnbwEJy7jFkf7
         D/ag==
X-Gm-Message-State: AOAM533RkgO8AI1XJnrXwTFcl7Xdd+o8+KLQwS0RJeXHMMGCpuJKvQ1s
        H75xxXEkbMRUs1+wG5VZzRrrudaZQ4/RcgNURq349Q==
X-Google-Smtp-Source: ABdhPJxH7DKI62ekt2JL2r3/Idizp8Tts/YooL7kxDugTvIL0u3sdovZtVR+qvxIcidlqORqkS4VUQPBHWVr5hWGhgM=
X-Received: by 2002:a67:ef96:: with SMTP id r22mr6532458vsp.21.1628236332608;
 Fri, 06 Aug 2021 00:52:12 -0700 (PDT)
MIME-Version: 1.0
References: <162742539595.32498.13687924366155737575.stgit@noble.brown>
 <162742546554.32498.9309110546560807513.stgit@noble.brown>
 <CAOQ4uxjXcVE=4K+3uSYXLsvGgi0o7Nav=DsV=0qG_DanjXB18Q@mail.gmail.com>
 <162751852209.21659.13294658501847453542@noble.neil.brown.name> <CAOQ4uxj9DW2SHqWCMXy4oRdazbODMhtWeyvNsKJm__0fuuspyQ@mail.gmail.com>
In-Reply-To: <CAOQ4uxj9DW2SHqWCMXy4oRdazbODMhtWeyvNsKJm__0fuuspyQ@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Fri, 6 Aug 2021 09:52:01 +0200
Message-ID: <CAJfpeguoMjCvLpKHgtQmNFk4UsHdyLsWK4bvsv6YJ52uZ=+9gg@mail.gmail.com>
Subject: Re: [PATCH 07/11] exportfs: Allow filehandle lookup to cross internal
 mount points.
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     NeilBrown <neilb@suse.de>, Christoph Hellwig <hch@infradead.org>,
        Josef Bacik <josef@toxicpanda.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Linux Btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 29 Jul 2021 at 07:27, Amir Goldstein <amir73il@gmail.com> wrote:

> Given that today, subvolume mounts (or any mounts) on the lower layer
> are not followed by overlayfs, I don't really see the difference
> if mounts are created manually or automatically.
> Miklos?

Never tried overlay on btrfs.  Subvolumes AFAIK do not use submounts
currently, they are a sort of hack where the st_dev changes when
crossing the subvolume boundary, but there's no sign of them in
/proc/mounts (there's no d_automount in btrfs).

Thanks,
Miklos
