Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56AD475FDE4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jul 2023 19:37:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231309AbjGXRhU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jul 2023 13:37:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230159AbjGXRhT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jul 2023 13:37:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 780E5188
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Jul 2023 10:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690220191;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kNGMSM8bxe1gWl9DKNB8FIofvuGTxcy8H7Yww9mrYIY=;
        b=UFA076dOOnxqxplg042wUUbYzcLFn4JPs8YrBvObruixP7F/ko91YCvOCXngi0gAsrq6NE
        iO0NIPOaQQu5ODl21VJSPMLOaH9+UHkx5uZrsyXqhNzxjUdgs/CYAGIVkS9Lv7Sy+qsunr
        xFJh6vMjlNXFbfz3Ev3CZ1a6ftIfK3s=
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-208-atWIiMgTNBmrjI8mHUdL5w-1; Mon, 24 Jul 2023 13:36:30 -0400
X-MC-Unique: atWIiMgTNBmrjI8mHUdL5w-1
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-4451bae544cso786192137.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Jul 2023 10:36:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690220189; x=1690824989;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kNGMSM8bxe1gWl9DKNB8FIofvuGTxcy8H7Yww9mrYIY=;
        b=BEtt+vlhBII2QU50If53VesgT5kWJpndbmVPPQarZbKunoexV+UzK/MxkIAwIbqv5+
         A9CE9o3+06hnyYJz1iLvzhUEiTSHT1KrzMf4jqv2VEc3978OEPGu3aem08KXPtr46Q2k
         +tVwlLBzkO7hn7M3G1n39A10OHHgYo+Uih4ousrTPlO9iWw+jT6sDUM7SGd4JZB+Tk7Y
         +ttwJalZlL2pwtUb6jFjDTxL4zshNcsoA5Xz1fdVvyfM+SBsIU4zohHbWIYj4TIWkjAv
         G8CftmX3jxMTzF78HOV+IQZ/hmcroXRH/uBWrCShLENIsvrXjwfM92az3ynjQUMNDROD
         fj+w==
X-Gm-Message-State: ABy/qLZEOdpe/W/eINgH0TrC3uldEr5uDw4konaREASSGKXqeP15eF8x
        0B4r2fhUQlFGHmW4o/LcpxOqk9qilFTCek4SJiOyZCXEakBKyJi8/bA7GD+YtiMT4VUR1rKjVB1
        YKd++T1zKwcctFouMVRoqNPQMInJqot5f0nMPQe1KeA==
X-Received: by 2002:a67:f8d1:0:b0:443:6052:43ae with SMTP id c17-20020a67f8d1000000b00443605243aemr3299076vsp.24.1690220189675;
        Mon, 24 Jul 2023 10:36:29 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEPDqGTgQT6TM0EZ/andXcsJaVfqEGx4nspzB3wq5naiCL3fLJVYaemN8sLojXqmdOKsQ5G89TIgjY7tVB3FGk=
X-Received: by 2002:a67:f8d1:0:b0:443:6052:43ae with SMTP id
 c17-20020a67f8d1000000b00443605243aemr3299068vsp.24.1690220189488; Mon, 24
 Jul 2023 10:36:29 -0700 (PDT)
MIME-Version: 1.0
References: <CAASaF6yKxWaW6me0Y+vSEo0qUm_LTyL5CPVka75EPg_yq4MO9g@mail.gmail.com>
 <7854000d2ce5ac32b75782a7c4574f25a11b573d.1689757133.git.jstancek@redhat.com>
 <64434.1690193532@warthog.procyon.org.uk> <10687.1690213447@warthog.procyon.org.uk>
 <20230724100914.38f286a5@kernel.org>
In-Reply-To: <20230724100914.38f286a5@kernel.org>
From:   Jan Stancek <jstancek@redhat.com>
Date:   Mon, 24 Jul 2023 19:37:08 +0200
Message-ID: <CAASaF6z27XJGhn_7uX+KXrTFoi6KtK4Oxp1b_OZ7dW8yEH9X5Q@mail.gmail.com>
Subject: Re: [PATCH] splice, net: Fix splice_to_socket() for O_NONBLOCK socket
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     David Howells <dhowells@redhat.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, brauner@kernel.org,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 24, 2023 at 7:09=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Mon, 24 Jul 2023 16:44:07 +0100 David Howells wrote:
> > Anyway, did you want to post this to netdev too so that the networking =
tree
> > picks it up?  Feel free to add:
>
> +1, no preference which tree this goes thru, but if no one else claims
> it please repost CCing netdev@vger.kernel.org

I'll repost, thanks.

