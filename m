Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7221E48B9D0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jan 2022 22:43:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245428AbiAKVnY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Jan 2022 16:43:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244160AbiAKVnX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Jan 2022 16:43:23 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29B00C061748
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Jan 2022 13:43:23 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id z22so1610079edd.12
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Jan 2022 13:43:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xsqhUFSsA1y57pFVxbW2TpGS3GqpQFY9bMvhPWyEkY0=;
        b=ANt4NWqhMTNSYmLTnu/YS5GiESGRsRRTJhSClnpJrH92h3FutHSoJ9XGeQr/F6QYQv
         iOmGgjte+EUw3MqFNz1A/cnjqXkcAIMEsGqBGRI7EIAyWWLmNDM5jPG0dgbSq3P0HATC
         m/sE09dWDeRfOqqMMYaG/DVFkKsb9e+VmtRLE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xsqhUFSsA1y57pFVxbW2TpGS3GqpQFY9bMvhPWyEkY0=;
        b=k7l8uWoBs9CmSDlPjzQK1THPIWpFMdKZ679/0IN0EeNkCcU+C1t3IeKro8XasFC8nJ
         FtagkSScZP0N+nsZNJleYvzGzXCVV8teUBRZlA7s/3WxH+RFbKQuhQHR1jDmKFPbTxHG
         zcY83FClv2pn/H0SVq39guBWflirUhPx/NB8MbJa+TIqoPpVCWEQyA57bjUFe5gb9M9B
         8hpbbWN0MtlZ7q4Ar96CI2z0ejoIXhTfvu65C9ezW+Ev01hX6LMzeR4LXpe7g4mANBKm
         RbxDRTBR9iYn+5OhzbX3wQmKtrB3K90ADezj2Oz15ywGos2iuq9A6205QthlgFdUbwvh
         Mhag==
X-Gm-Message-State: AOAM532r4j5/IBBPMdk8lLarlnoNXdt4L5A+pRo3m4JuXgrdHvgSizUI
        FL6tM0k2uk/nPjTEpIM7D+xoRey6s9+Lsb/9pOQ=
X-Google-Smtp-Source: ABdhPJxCCrToJoLV5mYcljpj/u5VDbP07me13z8xiDGQF8tUp1r9Ng8rAcrBPuJuxjPDhjzVdfrolA==
X-Received: by 2002:a05:6402:1604:: with SMTP id f4mr6225288edv.358.1641937401547;
        Tue, 11 Jan 2022 13:43:21 -0800 (PST)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com. [209.85.221.53])
        by smtp.gmail.com with ESMTPSA id q14sm5364226edv.79.2022.01.11.13.43.21
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jan 2022 13:43:21 -0800 (PST)
Received: by mail-wr1-f53.google.com with SMTP id v6so659892wra.8
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Jan 2022 13:43:21 -0800 (PST)
X-Received: by 2002:adf:f54e:: with SMTP id j14mr5320871wrp.442.1641937400749;
 Tue, 11 Jan 2022 13:43:20 -0800 (PST)
MIME-Version: 1.0
References: <20220110181923.5340-1-jack@suse.cz> <CAHk-=wj39rpqNZX99dJUpErT+yX9aZN-Z1Lyfx8tbUqFUFeEqw@mail.gmail.com>
 <20220111212710.5atbl7zmg7w72a3h@quack3.lan>
In-Reply-To: <20220111212710.5atbl7zmg7w72a3h@quack3.lan>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 11 Jan 2022 13:43:04 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiZwLHzDnsg60Waev=qJKxoBgDRJoeimspvofMRL1sC7A@mail.gmail.com>
Message-ID: <CAHk-=wiZwLHzDnsg60Waev=qJKxoBgDRJoeimspvofMRL1sC7A@mail.gmail.com>
Subject: Re: [PATCH v2] select: Fix indefinitely sleeping task in poll_schedule_timeout()
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 11, 2022 at 1:27 PM Jan Kara <jack@suse.cz> wrote:
>
> That's not quite true. max_select_fd() called from do_select() will bail
> with -EBADF if any set contains a bit that is not in
> current->files->open_fds.

Yeah, that probably does take care of any normal case, since you need
the race with close() to actually cause issues.

Good point.

           Linus
