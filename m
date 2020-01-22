Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ADFEE145DFB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jan 2020 22:29:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729427AbgAVV3g (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Jan 2020 16:29:36 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:35712 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729396AbgAVV3g (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Jan 2020 16:29:36 -0500
Received: by mail-lf1-f68.google.com with SMTP id z18so744699lfe.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Jan 2020 13:29:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T8dyZsx/1G1o4Km+D3AEjaFYjcDXoKwu76FXwqPPMog=;
        b=VJNm7ixVgyAguIeuR1pIXq0hv6ch7qgz5+W7axDIdGlhCNwpeyNJplyxY1npsTRa4q
         3AvFO2bN5r9I/mbrHMKFriPmjMXEUWYzS+PN/eLwCoaJhzX3jbPQJyRrX+O6IifhmS4t
         bAW5ztBvjxYTbpp9vIw4qcfvCMDSpuT8XuKqnlkWEusBikGN7eK6zxIwb+ANo0MusAUH
         y+2kEafA7mRzCvr0s6iDXqOBMqy0gyMtoVIoPF3UpKq+lYrO5MoIoGFloRBeyZfAnJAY
         cqsdx7KP8XS8YRJxgBSf+GmUDq5DSAoNnh1r2nnWw3k0ufdHWJw6q2xH0VYZhZTHi5df
         rQRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T8dyZsx/1G1o4Km+D3AEjaFYjcDXoKwu76FXwqPPMog=;
        b=k5yInQy1hZXR2PzNZy3VZX1k8IsUEF1WaGpU7nvvzCjnvxmDlsAJnJ2JjqFJWTycof
         6XCVup4VCQx/HNR9Os+XV+P9VL7W4y/ABDesdrMnE6k6nzgcSSX61oP17SM21y+HDLKA
         gbmCoNzQPPPd8Ny3CnlbeHect830jdc0XXRrV0pet+dZ9jHmAT17YMhIJv3SBZuIbui4
         1Hjk/91p8XKg1fl/9jdt8wmjcoI9DjHc2F/9ikqd1rxQpxX19JSsfSGjDRojEX+bVE98
         7bF+2fO7yMyNSH8cpKI46kaCawZwRgmlVdli2V+ayDnx5VOeEVjQyDpnkb4YEp0lDsfm
         +cIw==
X-Gm-Message-State: APjAAAXpgD56Exe/46Z8fiAR/z60KgZ5bYnlo9am1P/6oNQybrMzYUFw
        zLJfAc+kSx2A4dXbFBAeIyKfssbbQ8c1XUN8Bl3k
X-Google-Smtp-Source: APXvYqz71TZIg9MpEPSBX37Fh9pYf3NdlS4RNWJNnf5mBSZhvbWQtLxCouQ51G9Z/+VOzq252Xo+mwvfcQY+/hQ0B1U=
X-Received: by 2002:ac2:4422:: with SMTP id w2mr2853088lfl.178.1579728573496;
 Wed, 22 Jan 2020 13:29:33 -0800 (PST)
MIME-Version: 1.0
References: <cover.1577736799.git.rgb@redhat.com> <28cf3e16f8440bcb852767d3ae13e1a56c19569c.1577736799.git.rgb@redhat.com>
In-Reply-To: <28cf3e16f8440bcb852767d3ae13e1a56c19569c.1577736799.git.rgb@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 22 Jan 2020 16:29:22 -0500
Message-ID: <CAHC9VhS5snVdRJ95ymCb0oX7dhM_6A5rdtKSRm4fo1xi0hA4NQ@mail.gmail.com>
Subject: Re: [PATCH ghak90 V8 14/16] audit: check contid depth and add limit
 config param
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     containers@lists.linux-foundation.org, linux-api@vger.kernel.org,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        netdev@vger.kernel.org, netfilter-devel@vger.kernel.org,
        sgrubb@redhat.com, omosnace@redhat.com, dhowells@redhat.com,
        simo@redhat.com, Eric Paris <eparis@parisplace.org>,
        Serge Hallyn <serge@hallyn.com>, ebiederm@xmission.com,
        nhorman@tuxdriver.com, Dan Walsh <dwalsh@redhat.com>,
        mpatel@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 31, 2019 at 2:51 PM Richard Guy Briggs <rgb@redhat.com> wrote:
>
> Clamp the depth of audit container identifier nesting to limit the
> netlink and disk bandwidth used and to prevent losing information from
> record text size overflow in the contid field.
>
> Add a configuration parameter AUDIT_STATUS_CONTID_DEPTH_LIMIT (0x80) to
> set the audit container identifier depth limit.  This can be used to
> prevent overflow of the contid field in CONTAINER_OP and CONTAINER_ID
> messages, losing information, and to limit bandwidth used by these
> messages.
>
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> ---
>  include/uapi/linux/audit.h |  2 ++
>  kernel/audit.c             | 46 ++++++++++++++++++++++++++++++++++++++++++++++
>  kernel/audit.h             |  2 ++
>  3 files changed, 50 insertions(+)

Since setting an audit container ID, and hence acting as an
orchestrator and creating a new nested level of audit container IDs,
is a privileged operation I think we can equate this to the infamous
"shooting oneself in the foot" problem.  Let's leave this limitation
out of the patchset for now, if it becomes a problem in the future we
can consider restricting the nesting depth.

--
paul moore
www.paul-moore.com
