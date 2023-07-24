Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A98C375FA30
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jul 2023 16:52:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230447AbjGXOwP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jul 2023 10:52:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbjGXOwO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jul 2023 10:52:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA46410C0
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Jul 2023 07:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690210290;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ypOLNcWWYz98bhBvl2u/qys2akcVFXTw8mlGUAqbNFw=;
        b=PC7gE8Qb1Qya/YXbhRIeMaxZhh8MrDh5C16sQ12KRa+a7Qxd3P6NlUEz24U2qJR2ibBiw3
        vKcZylLby3KsHh/QBHVe2lXOP7LOL8edp7vPFgqABuUfUQp9oITQ6zgbVxGaAPnxBeSPM0
        I+/QqH7iVurLmwGcKWwb+i/j8FAFtcM=
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-90-iABDM5JhMaGQu5LCR4LGHQ-1; Mon, 24 Jul 2023 10:51:28 -0400
X-MC-Unique: iABDM5JhMaGQu5LCR4LGHQ-1
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-440c14d6a67so689711137.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Jul 2023 07:51:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690210288; x=1690815088;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ypOLNcWWYz98bhBvl2u/qys2akcVFXTw8mlGUAqbNFw=;
        b=fH1j1U8zkyLcUUgBWul0doNRORryOPXNkwQg+RAirrnxsSt4hCqGnn9ZMq7fINw4L1
         7DQ/0wlFaEhSKAh04NsX/Gq9l+H9IIG18Ync7LNFK8evvDzIh5U7XyVs8QZ9XbXPf9c9
         kU+TpF5d1tVD1nDCFPWfHKdTSogFHm2sDmzw6CgGFMsy7/Lu736lbLbkfivKI0Q0uo0F
         hn2aqvXD5S4WKs+oV50MAy+MDw8hPW+uPMbdvNjTMji7j1VTvZ66ro3CKcp7VHgETxkY
         V07LU4J4oahQA9e6txTzOUO+/0jX7CkyOnCLTUGAPsQAlcGA1ZSsVdAzB4HPaKJizyrL
         AH/w==
X-Gm-Message-State: ABy/qLbG83S7/C2sq9UsdXEMklKTthnM2SafGdE63g7KylW1FY/1H0cp
        dET8a4Yup7O6R56/MpphY24UEZKXqH4N+Ly8ZGGgG/VSg1lp+e12Xx9Zu0eclZAhjyXarIiOY2O
        enWInjmmU9QU8IogSu4bLOCS9/FFJ6QUAvr/4M8IOqQ==
X-Received: by 2002:a05:6102:8c:b0:444:c49c:a95d with SMTP id t12-20020a056102008c00b00444c49ca95dmr2645842vsp.7.1690210288120;
        Mon, 24 Jul 2023 07:51:28 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHb/CRwpXTAxHsDVnAkHvZhSkiPK0IWoHubqPpofuFvhYjCrJ9ECQRscQK7RQ9Hyf8PkEZsqwrTetpc7DSr1U8=
X-Received: by 2002:a05:6102:8c:b0:444:c49c:a95d with SMTP id
 t12-20020a056102008c00b00444c49ca95dmr2645831vsp.7.1690210287901; Mon, 24 Jul
 2023 07:51:27 -0700 (PDT)
MIME-Version: 1.0
References: <7854000d2ce5ac32b75782a7c4574f25a11b573d.1689757133.git.jstancek@redhat.com>
 <64434.1690193532@warthog.procyon.org.uk>
In-Reply-To: <64434.1690193532@warthog.procyon.org.uk>
From:   Jan Stancek <jstancek@redhat.com>
Date:   Mon, 24 Jul 2023 16:51:11 +0200
Message-ID: <CAASaF6yKxWaW6me0Y+vSEo0qUm_LTyL5CPVka75EPg_yq4MO9g@mail.gmail.com>
Subject: Re: [PATCH] splice, net: Fix splice_to_socket() for O_NONBLOCK socket
To:     David Howells <dhowells@redhat.com>
Cc:     kuba@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, brauner@kernel.org,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 24, 2023 at 12:12=E2=80=AFPM David Howells <dhowells@redhat.com=
> wrote:
>
> Jan Stancek <jstancek@redhat.com> wrote:
>
> > LTP sendfile07 [1], which expects sendfile() to return EAGAIN when
> > transferring data from regular file to a "full" O_NONBLOCK socket,
> > started failing after commit 2dc334f1a63a ("splice, net: Use
> > sendmsg(MSG_SPLICE_PAGES) rather than ->sendpage()").
> > sendfile() no longer immediately returns, but now blocks.
> >
> > Removed sock_sendpage() handled this case by setting a MSG_DONTWAIT
> > flag, fix new splice_to_socket() to do the same for O_NONBLOCK sockets.
>
> Does this actually work correctly in all circumstances?
>
> The problem might come if you have a splice from a non-rewindable source
> through a temporary pipe (eg. sendfile() using splice_direct_to_actor()).

I assumed this was safe, since sendfile / splice_direct_to_actor()
requires input to be seekable.

