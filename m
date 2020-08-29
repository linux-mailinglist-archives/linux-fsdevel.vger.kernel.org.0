Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBF2E256AA8
	for <lists+linux-fsdevel@lfdr.de>; Sun, 30 Aug 2020 00:43:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728564AbgH2Wmx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 29 Aug 2020 18:42:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728555AbgH2Wmv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 29 Aug 2020 18:42:51 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2209FC061573
        for <linux-fsdevel@vger.kernel.org>; Sat, 29 Aug 2020 15:42:50 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id w13so2464194wrk.5
        for <linux-fsdevel@vger.kernel.org>; Sat, 29 Aug 2020 15:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=platform.sh; s=google;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=o6LGzjsM2Kx7EWIT/ZnmgyA5z9nNQFr8nuwU2PjtX78=;
        b=NFLRMtpzctxQqrra1tQNwHIifdCAICA/VWcvhaaLuwuR5Es4wnTFDdDimGg+aMqn2m
         +EXi+kkK02lSw1HHwuV8AP073H7A6gTwUzGPf02GGYRaEzzumi0nO9wTiaJqAUcOwFus
         bVE9hVfCh1vVDBFK1xdtWqLOeSdnnyGMgcsqab2gmLN2d27xidriS5Zfc0SJERVfSqsC
         7VmdlfHdGSLg21add6TCDVLMuyYhqwqjyUzvpF0y+OpnhFZoOkUa2wvjUEDx9fRiQCu9
         7wzBGb6IX8G1PerezYzvDH8JrIQAd9lyvX6eRbBqkuh8eQjVwM2+DyzjWazDZkMQBpM5
         2GAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=o6LGzjsM2Kx7EWIT/ZnmgyA5z9nNQFr8nuwU2PjtX78=;
        b=hd9EnyYABDx1kxGBacuCEAfXWgqj7kn0VYwt+OWMi2mp3dECHjVjpq4LA+l86lJ+x3
         djI8DVFeF4BDw5QfeXjlvsFTOSyoNSvjEoLW+QBpO+Ka5mv4bA4f3ye8ytDYQFcTSCE/
         cvLxCZZ0MOoX8UJFYOwKc29S+5IgZKdyizv5IHkbDTLDokm5ibyQnU+mVHtyAvTi7ion
         tB8N2BZGaTFgBkFcWxJ+29YIHriKGOiFsobdR4qaoi6pXRaUjMfwQ3KDOaN+qPuRl1ji
         Thg8YEFRqZA1cjc20XjKDxWGLdtWYzqjINcnKfg8UrQ0DKK4/Ow0L9aaLkBihNXZelbs
         HiSA==
X-Gm-Message-State: AOAM531w/MY1AMceARcfuV1+blARTByXKZYealGR6eVMLNU4hMHtH/NV
        BmolQr9NvORryjy6/9kIMe3DLw==
X-Google-Smtp-Source: ABdhPJxWlzRiCVA2bN1NrXJ1DA/pd10YLUnRJY6KzCx9g0vdz0TPPJhIVEyI1TPqeZ7lXMXxLcmlyg==
X-Received: by 2002:adf:8405:: with SMTP id 5mr5038094wrf.393.1598740969429;
        Sat, 29 Aug 2020 15:42:49 -0700 (PDT)
Received: from localhost ([2a01:cb1c:111:4a00:dec6:dcf6:5621:172d])
        by smtp.gmail.com with ESMTPSA id b204sm5056016wmd.34.2020.08.29.15.42.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Aug 2020 15:42:48 -0700 (PDT)
From:   Florian Margaine <florian@platform.sh>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs: allow do_renameat2() over bind mounts of the same filesystem.
In-Reply-To: <20200829221204.GV14765@casper.infradead.org>
References: <871rjqh5bw.fsf@platform.sh> <20200828213445.GM1236603@ZenIV.linux.org.uk> <87wo1hf8o9.fsf@platform.sh> <20200829221204.GV14765@casper.infradead.org>
Date:   Sun, 30 Aug 2020 00:42:46 +0200
Message-ID: <87tuwlf509.fsf@platform.sh>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Matthew Wilcox <willy@infradead.org> writes:

> On Sat, Aug 29, 2020 at 11:23:34PM +0200, Florian Margaine wrote:
>> Al Viro <viro@zeniv.linux.org.uk> writes:
>>=20
>> > On Fri, Aug 28, 2020 at 10:40:35PM +0200, Florian Margaine wrote:
>> >> There's currently this seemingly unnecessary limitation that rename()
>> >> cannot work over bind mounts of the same filesystem,
>> >
>> > ... is absolutely deliberate - that's how you set a boundary in the
>> > tree, preventing both links and renames across it.
>>=20
>> Sorry, I'm not not sure I understand what you're saying.
>
> Al's saying this is the way an administrator can intentionally prevent
> renames.

Ah, ok. Thanks!

>
>>     /*
>>      * FICLONE/FICLONERANGE ioctls enforce that src and dest files are on
>>      * the same mount. Practically, they only need to be on the same file
>>      * system.
>>      */
>>     if (file_inode(file_in)->i_sb !=3D file_inode(file_out)->i_sb)
>>         return -EXDEV;
>
> clone doesn't change the contents of a file, merely how they're laid out
> on storage.  There's no particular reason for an administrator to
> prohibit clone across mount points.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEWcDV2nrrM20UJL9WhD9tdT2UlyoFAl9K2eYACgkQhD9tdT2U
lypGfgf/VElsI3XDE1+tOfSPlOivtjeal1u7UDE1z0r2z2wdlsfiFvI7cymiXmZw
dRgcJPHcg8yQaid0MPJA33av5SwOPQCZHNa5lw+lwvEILimwQWmSwz8cwVj5z3Bh
kn3231nTBMwmMlD4Cru/Mzf1tPPj6Qevdn3WJZAZMi9Kl7HzYpChiOYGJsRIuqKa
WiYdiDOMmM+sQ2h7uZuXRxdqfmJrsgQXDOPaguzQH3S6TktG3IP1T714xRLDslsk
StOzENw5FO8+v8zrjXEl/R2dcQPGSZxRZnpU9E2IpTJKXnWFUJmr5YWf7JzydRkS
W0IxTH1xoAaQKJ/2W8ojOi6AGSFTig==
=zWV3
-----END PGP SIGNATURE-----
--=-=-=--
