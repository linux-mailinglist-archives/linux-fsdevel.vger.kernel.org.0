Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38D8D2AF63A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Nov 2020 17:24:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727297AbgKKQYe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Nov 2020 11:24:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726664AbgKKQYd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Nov 2020 11:24:33 -0500
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB622C0613D1
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Nov 2020 08:24:33 -0800 (PST)
Received: by mail-vs1-xe41.google.com with SMTP id x11so1457159vsx.12
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Nov 2020 08:24:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RRJc+yz86BfTOaKeF6siAyiy/nTmSWhVAaiPZUl0FEs=;
        b=SBjDdyoMpOpgXGpwXzflbHFu2L58gQjNfKxn7GxKcSR1Fx0FaabMvoOZtmUvZfchrD
         m+LHlvMnwdbMiFzQmnsg5YG8+BWT6esRzhRKrkVycUhmjPZrd2jNFLmQcZEbnDqMhkoJ
         5N4fxYYWKLALrYa5Z24YwtWxH3nRJf6d8ZMPw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RRJc+yz86BfTOaKeF6siAyiy/nTmSWhVAaiPZUl0FEs=;
        b=nLBhSUY4Wmf6lOC3U5E0gqzsssMORBDiYh+pc2T/OzcFiZIT8FthEPPWTs1JJjcE2L
         /A1YJHZaBOZ+tIgyPhTO/tklHgJgDdo2W3w3zUqpbziH1uaiKPAdFKZAQZhIWNnrXyhG
         6QpgK7b1KQIhRRFGOyWDyjU2TncNWVOSl90c73KnZXEovbmihatM2yGuWiB7jukcED1I
         1hcTdPOpdF4T++Ro9+X68BHYArGAJ+QlWDWA6ObD/R9xmbyjxzdEUmvLfEMcIiMe988q
         tNrhv16EdqjfkiFYqgiHUq7soYo9/CA3tpn8c4L3CFurltSUvPyQ7cB+etA/vijevw+Y
         D7RA==
X-Gm-Message-State: AOAM530kG9Expl3mmaXj5+xVggHd+D+WpxBta7bfWchX3hCnL1TZOefJ
        z/PfBcQl3l1hCiU9N2SB1MVtBl1T6bXyvOX/neQ/0Q==
X-Google-Smtp-Source: ABdhPJy5eMZCm4SAn9QvrWjweS3u5Ys9kOZ+1LeN537VA7DP8ZOFsC+1wPpZJQHOdM7ayvN6+7ktSClI6iTKRV7YBRs=
X-Received: by 2002:a67:1442:: with SMTP id 63mr15684237vsu.0.1605111873055;
 Wed, 11 Nov 2020 08:24:33 -0800 (PST)
MIME-Version: 1.0
References: <20201009181512.65496-1-vgoyal@redhat.com> <20201009181512.65496-4-vgoyal@redhat.com>
 <CAJfpegu=ooDmc3hT9cOe2WEUHQN=twX01xbV+YfPQPJUHFMs-g@mail.gmail.com>
 <20201106171843.GA1445528@redhat.com> <CAJfpegvvGL=GJX0a+cDUVhX754NibudTvHvtrBrCnk-FEnfQ6A@mail.gmail.com>
In-Reply-To: <CAJfpegvvGL=GJX0a+cDUVhX754NibudTvHvtrBrCnk-FEnfQ6A@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 11 Nov 2020 17:24:22 +0100
Message-ID: <CAJfpegvoqBS-uXnPFkxViYanJUCi_s29bajyn1z7Vcd7owJVpg@mail.gmail.com>
Subject: Re: [PATCH v3 3/6] fuse: setattr should set FATTR_KILL_PRIV upon size change
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org,
        virtio-fs-list <virtio-fs@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 11, 2020 at 2:54 PM Miklos Szeredi <miklos@szeredi.hu> wrote:

> How about FUSE_*KILL_SUIDGID (FUSE_WRITE_KILL_SUIDGID being an alias
> for FUSE_WRITE_KILL_PRIV)?

Series pushed to #for-next with these changes.  Please take a look and test.

Thanks,
Miklos
