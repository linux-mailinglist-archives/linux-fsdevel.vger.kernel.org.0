Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 307EA23B7C9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Aug 2020 11:34:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727092AbgHDJe3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Aug 2020 05:34:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbgHDJe3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Aug 2020 05:34:29 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB0ACC061756
        for <linux-fsdevel@vger.kernel.org>; Tue,  4 Aug 2020 02:34:28 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id di22so22166654edb.12
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Aug 2020 02:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Pv5BPk76i/MoWGs1gw+KWKrHA/vLK3W5JwzOEjOtqbI=;
        b=XO91VMIYWmJJyaLCqDwDI7R+/IhY8Otht/jNSco5h8lhYIS7roedId1R24+PWBV16J
         LGJrXnUSRgNnkCXYNmrxfDAd/fQa45PtQvzrfacRxUq3Htw7n9EcjRgyEZy0FGDPEzsx
         +Kf4QL8FkwyirK30cJnrDCj4Ay+ihET2LbOtc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Pv5BPk76i/MoWGs1gw+KWKrHA/vLK3W5JwzOEjOtqbI=;
        b=SDT0ycs3bezxK+vDGZta3nWt0JoAcg2EF41nLj3vg43pqtIRruBZh9pY4gs30dzfMO
         yjlRt09SZ3XwVoQfhP0OAVCCWemWdR5ahU0FCprAERMTYFN6DUS+5wtLcMB8q4nOiIde
         qTXvs841huT1UM1DJvDcXm1zD+r/fIFOdgJvysq97yIOdPXCJwm4qlxNzY0ooeV2c4NF
         vNzV8NOkIbycXXBUrK2SHsbYW9nGahLWuq52ZVsBTKkmEkLGXkCB/bGNR6RvbLZvkmb+
         EsRV5+q3yLqaR/ztSainr/EqXv+XUxfjSsoG0IRDJhh8zIrroC1U4DUNm/J31qmoCzFy
         ESxQ==
X-Gm-Message-State: AOAM532yJwONrNsqMZsFoZV3PYz5n/peX0fiElgdr7p6Q8/VffcDbDOq
        /UjJd9J7SSm8dVClme0S7INvg8/PvHBBvX6Io6mmhA==
X-Google-Smtp-Source: ABdhPJyCVcW919I6oNh7+VZo4I3h9xZy6Vr4Yw7zYMnMeDWnx5DDKuBcJyX6d89ZTqqueg33E4gXqgxVmtE7jo4mugc=
X-Received: by 2002:aa7:c915:: with SMTP id b21mr20325848edt.17.1596533666430;
 Tue, 04 Aug 2020 02:34:26 -0700 (PDT)
MIME-Version: 1.0
References: <159646178122.1784947.11705396571718464082.stgit@warthog.procyon.org.uk>
 <159646179405.1784947.10794350637774567265.stgit@warthog.procyon.org.uk>
In-Reply-To: <159646179405.1784947.10794350637774567265.stgit@warthog.procyon.org.uk>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 4 Aug 2020 11:34:15 +0200
Message-ID: <CAJfpegvM4K1PhTkDivtzWsE2g8rBUMmzniaW8Op0XY5codvu1w@mail.gmail.com>
Subject: Re: [PATCH 01/18] fsinfo: Introduce a non-repeating system-unique
 superblock ID [ver #21]
To:     David Howells <dhowells@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ian Kent <raven@themaw.net>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Christian Brauner <christian@brauner.io>,
        Jann Horn <jannh@google.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Karel Zak <kzak@redhat.com>, Jeff Layton <jlayton@redhat.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org,
        LSM <linux-security-module@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 3, 2020 at 3:37 PM David Howells <dhowells@redhat.com> wrote:
>
> Introduce an (effectively) non-repeating system-unique superblock ID that
> can be used to determine that two objects are in the same superblock
> without needing to worry about the ID changing in the meantime (as is
> possible with device IDs).
>
> The counter could also be used to tag other features, such as mount
> objects.
>
> Signed-off-by: David Howells <dhowells@redhat.com>

Reviewed-by: Miklos Szeredi <mszeredi@redhat.com>
