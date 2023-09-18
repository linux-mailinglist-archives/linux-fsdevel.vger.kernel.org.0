Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D936D7A4C82
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Sep 2023 17:35:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbjIRPez (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Sep 2023 11:34:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbjIRPec (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Sep 2023 11:34:32 -0400
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com [IPv6:2607:f8b0:4864:20::92f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4443BBC;
        Mon, 18 Sep 2023 08:32:09 -0700 (PDT)
Received: by mail-ua1-x92f.google.com with SMTP id a1e0cc1a2514c-7a8c41bd59aso523114241.3;
        Mon, 18 Sep 2023 08:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695050940; x=1695655740; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FFquh9MatLutV/AqH2mDcbYDMbyhx/Btn5qvpYa0SGg=;
        b=O8QXOTOCinvtS7RuUha3bcTqDNQ9kuTz4oLq2e32AaATfsWb8D+pSD0y+XeacnXTUs
         KCijXtXawPdRJy/xtiqJr1TWOvd+4CUFEGb72FrzR+6N/7l2CSa+KaAqCRaak6UNVw8L
         CdbA85Iqg42ik8F4nvLNMpn2e65N48rUIesuPBMJCiqFtEtAXXSB/WVpyCQCgqvUmm1d
         KIzq166PaKa8NWsrOXgnqTiA+iT/4YYwvOJU0AqQaQ+/9YiQDTA31CVFY/nnktk1HwiN
         pqPuPAnbbu/WWF7BnX7ZvIFzty6CcwMHERMXKc/B7qeyluaX8ttdrVcmp722DlgF8GOZ
         diUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695050940; x=1695655740;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FFquh9MatLutV/AqH2mDcbYDMbyhx/Btn5qvpYa0SGg=;
        b=PWS+YjMjhG22BjH6pikU7543fnx1evaadx/OdHg9ZjI39Qt+oQ18B26EVhFbBJE8K0
         1o7ZJxBegwy49s62yvhjwXhonU2G9WWzMuKmdV3hVD7mTH8fHYYBPBDeip2kLTzsEKUV
         odFNsjMPduAVv7Oo7CKJkbDaj6RAdU3FuOV4jDgz9rxJJGHO0z/42YP/MWLF1GXCS07B
         DsRhCGzHOGLQ4A1c/9ZKQKqtOE9ZtvVWxxaluS+fiI8YFkdSinePEdV6x+mB3NfX6Fgo
         iH2FgGdzeZaKYEJa2KVWNop2GTZPKFkFD6IdDZvqUfJNgbCP9EVXHgBEWj4W8rtxrHrI
         Rbiw==
X-Gm-Message-State: AOJu0Yz6MNiBaChusH9dY18rruRnRWR3K2uyyv1bmuSR6buH9QMiIVz8
        00qS9DhtwpQYTOFYCxIe0W5+EvPHEmdkht0+bfM=
X-Google-Smtp-Source: AGHT+IG+14BDkv69gEV/ofqK+tV/43zZr0iMgJxlaMWnsiFY8QZ/k81W0VpdvgqTjqlov5xvNWbSKqBBq7GwKvCySXc=
X-Received: by 2002:a05:6102:3184:b0:452:741a:b7ec with SMTP id
 c4-20020a056102318400b00452741ab7ecmr1682905vsh.33.1695050940607; Mon, 18 Sep
 2023 08:29:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230918123217.932179-1-max.kellermann@ionos.com>
 <20230918123217.932179-3-max.kellermann@ionos.com> <20230918124050.hzbgpci42illkcec@quack3>
 <CAKPOu+-Nx_cvBZNox63R1ah76wQp6eH4RLah0O5mDaLo9h60ww@mail.gmail.com> <20230918142319.kvzc3lcpn5n2ty6g@quack3>
In-Reply-To: <20230918142319.kvzc3lcpn5n2ty6g@quack3>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 18 Sep 2023 18:28:49 +0300
Message-ID: <CAOQ4uxic7C5skHv4d+Gek_uokRL8sgUegTusiGkwAY4dSSADYQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] inotify_user: add system call inotify_add_watch_at()
To:     Jan Kara <jack@suse.cz>
Cc:     Max Kellermann <max.kellermann@ionos.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 18, 2023 at 5:23=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Mon 18-09-23 15:57:43, Max Kellermann wrote:
> > On Mon, Sep 18, 2023 at 2:40=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
> > > Note that since kernel 5.13 you
> > > don't need CAP_SYS_ADMIN capability for fanotify functionality that i=
s
> > > more-or-less equivalent to what inotify provides.
> >
> > Oh, I missed that change - I remember fanotify as being inaccessible
> > for unprivileged processes, and fanotify being designed for things
> > like virus scanners. Indeed I should migrate my code to fanotify.
> >
> > If fanotify has now become the designated successor of inotify, that
> > should be hinted in the inotify manpage, and if inotify is effectively
> > feature-frozen, maybe that should be an extra status in the
> > MAINTAINERS file?
>
> The manpage update is a good idea. I'm not sure about the MAINTAINERS
> status - we do have 'Obsolete' but I'm reluctant to mark inotify as
> obsolete as it's perfectly fine for existing users, we fully maintain it
> and support it but we just don't want to extend the API anymore. Amir, wh=
at
> are your thoughts on this?

I think that the mention of inotify vs. fanotify features in fanotify.7 man=
 page
is decent - if anyone wants to improve it I won't mind.
A mention of fanotify as successor in inotify.7 man page is not a bad idea =
-
patches welcome.

As to MAINTAINERS, I think that 'Maintained' feels right.
We may consider 'Odd Fixes' for inotify and certainly for 'dnotify',
but that sounds a bit too harsh for the level of maintenance they get.

I'd like to point out that IMO, man-page is mainly aimed for the UAPI
users and MAINTAINERS is mostly aimed at bug reporters and drive-by
developers who submit small fixes.

When developers wish to add a feature/improvement to a subsystem,
they are advised to send an RFC with their intentions to the subsystem
maintainers/list to get feedback on their design before starting to impleme=
nt.
Otherwise, the feature could be NACKed for several reasons other than
"we would rather invest in the newer API".

Bottom line - I don't see a strong reason to change anything, but I also do
not object to improving man page nor to switching to 'Odd Fixes' status.

Thanks,
Amir.
