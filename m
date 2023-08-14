Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C0C677BF2E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Aug 2023 19:44:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbjHNRn3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Aug 2023 13:43:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbjHNRnN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Aug 2023 13:43:13 -0400
Received: from mail-ej1-x64a.google.com (mail-ej1-x64a.google.com [IPv6:2a00:1450:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74D4B10DD
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Aug 2023 10:43:12 -0700 (PDT)
Received: by mail-ej1-x64a.google.com with SMTP id a640c23a62f3a-94a34e35f57so281645566b.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Aug 2023 10:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692034991; x=1692639791;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u5yoISyQ64yysqfY92+HZOjBkKIpcZsGK9+9LkEvhrw=;
        b=pDDxmnJuJphVE/sJZALK5OGNZ3ZNSMbmOe7luKDdwlPs3yHOnrCeUAjq2sJzM0Tcgo
         c/9tuMb55fNoz4BCziiFo9IwZiRHNksxib2OEEgL2BjNH5MF5mzJpbgygd/ErtejAuka
         VOFQtMep0JuXh1qt2BLamq7kDia6o9xZq+eopkvAg7GiTGVADklvj/zjOxJyVp/wUA1w
         s4n2mVadNgv8Xdak8z3Zsbg/OHZS72X+ud3siE7OnkN8pjZG6npKgt0v3O2yu4OTqRcH
         JgQ57PTEtn463julHPI1+Z7qOirhveKVrNXv3HngbVyYiY2j/rWWBGG+Fz5dr6DbXgxn
         3Jiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692034991; x=1692639791;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=u5yoISyQ64yysqfY92+HZOjBkKIpcZsGK9+9LkEvhrw=;
        b=RfDkto0ect413tsvE1bIqYz5wcpo7bBOtppyTxxnErToj5CUfBKb1PeF3TpLQoCsk9
         DMg2mkPLLUMtscqaTcZwSUVQrP7wzlsHBZQOU5KpdZZEaMZEnV2eQQgTKBEiMaIYO02K
         Z241jt00z5ZmU21X8P9yk06DFgekAYZQB1SY0ZUcfcm8BPBT7ds8rT3Ix9qMKVrBqGgl
         4cemfD8R+Z4tMoLvoEKTF9Z9rN3mMJ9VKcsHbe5vYmMOBbUFMv33226IOw1BeZ0nJJXw
         Xd5+EGra6JQNrNsNZWSwr/aB9m8iEF7X/hJY46twjgvWBhJg8Lk1t9vgTNb1hV2m2763
         LWLw==
X-Gm-Message-State: AOJu0YyyO7COZvtBXCIVasRRStefVkRpXTegBWHGRhH99OtTL5LmCrD/
        nLBgYnNewu4ko2WSAVBcTGbwypVYRx0=
X-Google-Smtp-Source: AGHT+IHOPYwxghdHox4XDWyIW4BUui9QEosU4h7y5pPSzt1awMxCLmFAyPMyZpEs53hZS6we0ZdK3v3+vVQ=
X-Received: from sport.zrh.corp.google.com ([2a00:79e0:9d:4:9ca9:bbb1:765a:e929])
 (user=gnoack job=sendgmr) by 2002:a17:907:8715:b0:990:fb:b91a with SMTP id
 qn21-20020a170907871500b0099000fbb91amr44134ejc.8.1692034991003; Mon, 14 Aug
 2023 10:43:11 -0700 (PDT)
Date:   Mon, 14 Aug 2023 19:43:08 +0200
In-Reply-To: <20230814172816.3907299-2-gnoack@google.com>
Message-Id: <ZNpnrCjYqFoGkwyf@google.com>
Mime-Version: 1.0
References: <20230814172816.3907299-1-gnoack@google.com> <20230814172816.3907299-2-gnoack@google.com>
Subject: Re: [PATCH v3 1/5] landlock: Add ioctl access right
From:   "=?iso-8859-1?Q?G=FCnther?= Noack" <gnoack@google.com>
To:     linux-security-module@vger.kernel.org,
        "=?iso-8859-1?Q?Micka=EBl_Sala=FCn?=" <mic@digikod.net>
Cc:     Jeff Xu <jeffxu@google.com>,
        Jorge Lucangeli Obes <jorgelo@chromium.org>,
        Allen Webb <allenwebb@google.com>,
        Dmitry Torokhov <dtor@google.com>,
        Paul Moore <paul@paul-moore.com>,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        Matt Bobrowski <repnop@google.com>,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi!

On Mon, Aug 14, 2023 at 07:28:12PM +0200, G=C3=BCnther Noack wrote:
> @@ -1207,7 +1209,8 @@ static int hook_file_open(struct file *const file)
>  {
>  	layer_mask_t layer_masks[LANDLOCK_NUM_ACCESS_FS] =3D {};
>  	access_mask_t open_access_request, full_access_request, allowed_access;
> -	const access_mask_t optional_access =3D LANDLOCK_ACCESS_FS_TRUNCATE;
> +	const access_mask_t optional_access =3D LANDLOCK_ACCESS_FS_TRUNCATE |
> +					      LANDLOCK_ACCESS_FS_IOCTL;
>  	const struct landlock_ruleset *const dom =3D
>  		landlock_get_current_domain();
> =20
> @@ -1280,6 +1283,36 @@ static int hook_file_truncate(struct file *const f=
ile)
>  	return -EACCES;
>  }

About the error code:

The ioctl(2) man page documents ENOTTY as "The specified request does not a=
pply
to this kind of object".  It does not document EACCES.  EACCES would be sli=
ghtly
more appropriate semantically, but existing programs might be more well-equ=
ipped
to handle ENOTTY.

Do you think we should return ENOTTY here?

=E2=80=94G=C3=BCnther

--=20
Sent using Mutt =F0=9F=90=95 Woof Woof
