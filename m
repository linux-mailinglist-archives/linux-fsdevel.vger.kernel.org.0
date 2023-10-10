Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA9507BF56F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Oct 2023 10:15:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379441AbjJJIP5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Oct 2023 04:15:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379437AbjJJIPz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Oct 2023 04:15:55 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06A88A7
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Oct 2023 01:15:52 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-9b27bc8b65eso896357166b.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Oct 2023 01:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1696925750; x=1697530550; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OfW7dpG31FTMRZhBhOibpRxWenmCtO9DVOjvJpZvmEM=;
        b=QJayTTjz7EGsSr2QfDAzPrAvOhah9rXuAd7zodFJca05n7exMSINBwdbrbLm7xqLIy
         ezJI6O44KkqEL1H6VqbXGm+Z7GCuyzCAPQBXDZUEyIj5pzU6o09uGHsPmXOoRX2Dvuut
         vECC3f87PIB24uubQ2SKBjJCdteLgGQFwpw8Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696925750; x=1697530550;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OfW7dpG31FTMRZhBhOibpRxWenmCtO9DVOjvJpZvmEM=;
        b=io6QBYXdBkB7RzeR/78YgihU2ZfgF3d/sFHCqhn9zHV55d6y5UaPAbVW3YMIGQXNsH
         Z1fQ72k9KDaPRdXlupKNv2JE4OAMADreF77/aEMLLRyiBJAGUUtXW6aAnl/mtJRTGV/k
         mrlL1pzy44EPA3S1Dfk79jkpRG9wrExdso+8JQGz6xC9yKhPD4JCS+UV6D/S2zVFcEso
         E6Pj3JHvNpGpQURwsN5YuKx8KMkVljVL1YOkEBMM8uwmPRF3unOQ76p4mXwHvmw1HBiw
         Xl+Kua/ChIW3vr88D2CanXWcFeu0lBYgjzh0j7v7JaamxQ8GdEdVP503wtqFExk7ONdC
         JcWQ==
X-Gm-Message-State: AOJu0YyVNVoMr8dMFzMkZqzS0A/SL9ko3azpBiJlBBEctll4BrAZcllk
        +KFwG6Q9cmvIlNT1aT9LTZkzwf/PSqz5BRzo6IX68w==
X-Google-Smtp-Source: AGHT+IGKB4RSuX7TFAKxE7X/HVqgpWnqYSuU57QXdm8Qu8GMOKArtsdxGj6a0/BB1w5re+A4CRrzcMIT9dKaTWGS0SE=
X-Received: by 2002:a17:907:1dd7:b0:9ae:48df:2235 with SMTP id
 og23-20020a1709071dd700b009ae48df2235mr14985305ejc.55.1696925750403; Tue, 10
 Oct 2023 01:15:50 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1696043833.git.kjlx@templeofstupid.com> <45778432fba32dce1fb1f5fd13272c89c95c3f52.1696043833.git.kjlx@templeofstupid.com>
 <CAJfpegtOdqeK34CYvBTuVwOzcyZG8hnusiYO05JdbATOxfVMOg@mail.gmail.com> <20231010023507.GA1983@templeofstupid.com>
In-Reply-To: <20231010023507.GA1983@templeofstupid.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 10 Oct 2023 10:15:38 +0200
Message-ID: <CAJfpegvr0cHj53jSPyBxVZnMpReq_RFhT-P1jv8eUu4pqxt9HA@mail.gmail.com>
Subject: Re: [resend PATCH v2 2/2] fuse: ensure that submounts lookup their parent
To:     Krister Johansen <kjlx@templeofstupid.com>
Cc:     linux-fsdevel@vger.kernel.org,
        Miklos Szeredi <mszeredi@redhat.com>,
        linux-kernel@vger.kernel.org,
        German Maglione <gmaglione@redhat.com>,
        Greg Kurz <groug@kaod.org>, Max Reitz <mreitz@redhat.com>,
        Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Type: multipart/mixed; boundary="0000000000009054d70607585084"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--0000000000009054d70607585084
Content-Type: text/plain; charset="UTF-8"

On Tue, 10 Oct 2023 at 04:35, Krister Johansen <kjlx@templeofstupid.com> wrote:

> If I manually traverse the path to the submount via something like cd
> and ls from the initial mount namespace, it'll stay referenced until I
> run a umount for the automounted path.  I'm reasonably sure it's the
> container setup that's causing the detaching.

Okay.  Can you please try the attached test patch.  It's not a proper
solution, but I think it's the right direction.

Thanks,
Miklos

--0000000000009054d70607585084
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="fuse-inc-nlookup-on-automount-root.patch"
Content-Disposition: attachment; 
	filename="fuse-inc-nlookup-on-automount-root.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_lnk1r8az0>
X-Attachment-Id: f_lnk1r8az0

ZGlmZiAtLWdpdCBhL2ZzL2Z1c2UvaW5vZGUuYyBiL2ZzL2Z1c2UvaW5vZGUuYwppbmRleCAyZTRl
YjdjZjI2ZmIuLmQ1ZjQ3MjAzZGZiYyAxMDA2NDQKLS0tIGEvZnMvZnVzZS9pbm9kZS5jCisrKyBi
L2ZzL2Z1c2UvaW5vZGUuYwpAQCAtMTUyNCw2ICsxNTI0LDE4IEBAIHN0YXRpYyBpbnQgZnVzZV9n
ZXRfdHJlZV9zdWJtb3VudChzdHJ1Y3QgZnNfY29udGV4dCAqZnNjKQogCQlyZXR1cm4gZXJyOwog
CX0KIAorCXNwaW5fbG9jaygmbXBfZmktPmxvY2spOworCWlmIChtcF9maS0+bmxvb2t1cCkgewor
CQlzdHJ1Y3QgZnVzZV9pbm9kZSAqZmkgPSBnZXRfZnVzZV9pbm9kZShkX2lub2RlKHNiLT5zX3Jv
b3QpKTsKKwkJbXBfZmktPm5sb29rdXAtLTsKKwkJc3Bpbl91bmxvY2soJm1wX2ZpLT5sb2NrKTsK
KwkJc3Bpbl9sb2NrKCZmaS0+bG9jayk7CisJCWZpLT5ubG9va3VwKys7CisJCXNwaW5fdW5sb2Nr
KCZmaS0+bG9jayk7CisJfSBlbHNlIHsKKwkJc3Bpbl91bmxvY2soJm1wX2ZpLT5sb2NrKTsKKwl9
CisKIAlkb3duX3dyaXRlKCZmYy0+a2lsbHNiKTsKIAlsaXN0X2FkZF90YWlsKCZmbS0+ZmNfZW50
cnksICZmYy0+bW91bnRzKTsKIAl1cF93cml0ZSgmZmMtPmtpbGxzYik7Cg==
--0000000000009054d70607585084--
