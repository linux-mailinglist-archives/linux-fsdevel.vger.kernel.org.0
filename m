Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5BE7B141FDB
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Jan 2020 20:56:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728709AbgAST44 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 19 Jan 2020 14:56:56 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37186 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728516AbgAST44 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 19 Jan 2020 14:56:56 -0500
Received: by mail-wm1-f67.google.com with SMTP id f129so12623295wmf.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 19 Jan 2020 11:56:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+bqI+HXZLDy3/2zlOr8wqNolH3lkOymLNufyRKitZ8E=;
        b=civbAnkTNBldqP9wmccocUPWAcEg58tjX0np4qCeuC2xhLDm5y89dqcQlJpPzjo0j3
         Yj8L9GHC1vkZQOnVexpSlHg7/b+yklYGWn0WSmOh819AIEDeWXVpVXUGawPpXcej6tS9
         WTw+SFWp2GBBdMrIDRYQZ0IYLySsMpFiubHs9t76c2ap1PnpqcvaCy5kaPuXT4JGwRh2
         ZisVtg+BiDoFSQ09qs/FaRtRCdNshOw6XHZOgtX1yTBKC5zn/dODezB4TZ76LuQRGAOx
         +prnNqSmYqP7X7qOaCtecpR3LyIy7nKGy58V/6owtRbMu2WYKZNtb7iiVkX3R5jFLEVN
         OwJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+bqI+HXZLDy3/2zlOr8wqNolH3lkOymLNufyRKitZ8E=;
        b=BxcMeLl0GhZTsRePCuF2BzEgltUiovTvbWUCIAaX28Xo/2gmqL293mJjCfmr7X1hZ9
         M7m8sigi04WqgIWpDpIhkYvMWWismGBDdC1NO85toQnrCoFSOfFrWOI+QIgBtBuO4rh4
         vJ/lQHvNejMOxjJdhERtpsgf0a8oI+PBNYIbVp5Qx7wO70KLareI6tnE8rDuuDdX7nji
         u3rWIozxhvc8i63f4psAC4RjNFFClOjIZVZq35ujplgNHaP3lYcVMhtDtx4nUpGPw2ss
         dWCb3bOhPaoiuiQycdHOtxXu5sRjFd6l4Ee3hY+6dYjJsV9ZqPBaKlRp2cExqQUTqT3L
         /5pg==
X-Gm-Message-State: APjAAAWCIM/mLf6KKjRxLW9m5Xg9argOfkjE6D3duJ5Ust1wph+HuvFy
        dF8IK1DvDsL4vC8Q/bT6VijVANgOTd3ve43x4S0=
X-Google-Smtp-Source: APXvYqxhRLsE9iQ7PiuoE9YMecEvRVyFkeib7qlPPoXHS5if87dXpmVsbuDyohiDQ3awnPjrmCIuttfCbF3a9WwcB8U=
X-Received: by 2002:a1c:6389:: with SMTP id x131mr15827684wmb.155.1579463813949;
 Sun, 19 Jan 2020 11:56:53 -0800 (PST)
MIME-Version: 1.0
References: <20191106091537.32480-1-s.hauer@pengutronix.de> <20191106091537.32480-3-s.hauer@pengutronix.de>
In-Reply-To: <20191106091537.32480-3-s.hauer@pengutronix.de>
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Sun, 19 Jan 2020 20:56:42 +0100
Message-ID: <CAFLxGvwv=j0C5ZGUGDns5nfxsjFcHifkqJuu2E+HXupyNcq55Q@mail.gmail.com>
Subject: Re: [PATCH 2/7] ubifs: move checks and preparation into setflags()
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org, kernel@pengutronix.de,
        Jan Kara <jack@suse.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 6, 2019 at 10:17 AM Sascha Hauer <s.hauer@pengutronix.de> wrote:
>
> setflags() can be reused for upcoming FS_IOC_FS[SG]ETXATTR ioctl support.
> In preparation for that move the checks and preparation into that
> function so we can reuse them as well.
>
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  fs/ubifs/ioctl.c | 46 +++++++++++++++++++++++++++-------------------
>  1 file changed, 27 insertions(+), 19 deletions(-)

Acked-by: Richard Weinberger <richard@nod.at>

-- 
Thanks,
//richard
