Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC2CF66DEE2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jan 2023 14:31:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbjAQNa5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Jan 2023 08:30:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbjAQNaq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Jan 2023 08:30:46 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F0CB34C01
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Jan 2023 05:30:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673962199;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fg5kf88GjqS04Xb1aZZOdM/bpUlV1+UcrEUkKV/unbY=;
        b=Pt2eFDCyAn/W+BjvMk4TXUHnSy/aZy97U4tW/D9vxwrEVq6Bzq+BFGaouxKRf9mWVzqj6d
        eVEWQOacMxs0iwzAAE8tEHDu43f7anRNXBI15nxORT83z7r1sqpeCDmQKKlE7ZIjJyEk25
        BW7sK9qo1jhY4Lcr7Uvpk/kCs3bdKGw=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-492-SFC8MMOdNy6qDjTm-gyDiA-1; Tue, 17 Jan 2023 08:29:58 -0500
X-MC-Unique: SFC8MMOdNy6qDjTm-gyDiA-1
Received: by mail-ej1-f71.google.com with SMTP id qw29-20020a1709066a1d00b008725a1034caso1707550ejc.22
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Jan 2023 05:29:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fg5kf88GjqS04Xb1aZZOdM/bpUlV1+UcrEUkKV/unbY=;
        b=z5tKQsQJlszt8Oz7mxJM1dQUo6aV8KwJ+pvgvNmkP1wKqgE/VN+Mj1qfya5swT6ait
         0v780TbPGzec2rx8r8/Kw0SYifV4Of9EHi2mnRlIilj4K2ymkzoZMzxVQiLZxHTBIK7W
         nwfxgI0SlWMK3quQzBvYtnyAMzcrznOEzpva11gyMuqaUnfBWDAFRbwFW5b6vMs4cmwy
         T+qoikQnxwJgOSZl0v3l3TnJD78b30aQvn0hLXMi6/5VrAx7BVogwvpT5pP01e4i1kLr
         +wW4znYRWG3dUwfX3mTPw4e8Vw3P7fp3jIFQ115vv1WXyIE/gcu4qAPOXojYz+qMYU6A
         3cWw==
X-Gm-Message-State: AFqh2kprDBIPRw3c3RcYZPkzEbEJcs/ArpRXWpQWtjIy30+Dmoag7jUo
        tvKeRzIcPKmp5ZL/Dk7HWhdjMzm2+thElKhzAMlssYKcr5gWAIXNhJrKQQX65eNHSuYPXy84DDp
        KjyDK3vFJRfCVRRdhyiGVy0eZ5g==
X-Received: by 2002:a17:906:8c3:b0:84d:2078:1fd6 with SMTP id o3-20020a17090608c300b0084d20781fd6mr15804517eje.34.1673962197357;
        Tue, 17 Jan 2023 05:29:57 -0800 (PST)
X-Google-Smtp-Source: AMrXdXs4ppsVj8TweMfZFp4njVAMcfarVsL1T9Z+OFXOiy9wE7bJvkJqpL+ZIHB9IWVvxpDcrsmI/A==
X-Received: by 2002:a17:906:8c3:b0:84d:2078:1fd6 with SMTP id o3-20020a17090608c300b0084d20781fd6mr15804498eje.34.1673962197134;
        Tue, 17 Jan 2023 05:29:57 -0800 (PST)
Received: from greebo.mooo.com (c-e6a5e255.022-110-73746f36.bbcust.telenor.se. [85.226.165.230])
        by smtp.gmail.com with ESMTPSA id e2-20020a170906314200b007c08439161dsm13100156eje.50.2023.01.17.05.29.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 05:29:56 -0800 (PST)
Message-ID: <00f8557d8164cc695a2d2684fd12a724695ffac1.camel@redhat.com>
Subject: Re: [PATCH v2 4/6] composefs: Add filesystem implementation
From:   Alexander Larsson <alexl@redhat.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        gscrivan@redhat.com
Date:   Tue, 17 Jan 2023 14:29:55 +0100
In-Reply-To: <Y8XKtqfmtulLcuWi@ZenIV>
References: <cover.1673623253.git.alexl@redhat.com>
         <ee96ab52b9d2ab58e7b793e34ce5dc956686ada9.1673623253.git.alexl@redhat.com>
         <Y8XKtqfmtulLcuWi@ZenIV>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.2 (3.46.2-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2023-01-16 at 22:07 +0000, Al Viro wrote:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Several random observatio=
ns:

Thanks, I'll integrate this in the next version.

--=20
=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D=
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
=3D-=3D-=3D
 Alexander Larsson                                            Red Hat,
Inc=20
       alexl@redhat.com            alexander.larsson@gmail.com=20
He's a scrappy ninja firefighter possessed of the uncanny powers of an=20
insect. She's a blind punk former first lady with an evil twin sister.=20
They fight crime!=20

