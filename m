Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 573666A270B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Feb 2023 04:41:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbjBYDlB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Feb 2023 22:41:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjBYDlA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Feb 2023 22:41:00 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42FAA6BF7A
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Feb 2023 19:40:38 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id ee7so5034198edb.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Feb 2023 19:40:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rYlzXS6O2H/qnoN4QpI6Ir8Wr8FOKJQ0LdPDj4qFNbw=;
        b=XgrGHcsjD8lXdt+NU3BdqeLszj1cBLsQmLQ4vnPOiq+KgU/kc+x004DNcSCRsZR35i
         dlF2s1jAJR5lHW+W2aovLxh8pUCZMBZF/FkTxmw2tHlVMxnOTd8VJCTQNAIEE1hJz8M/
         b+lFTBnv03PMId15hHYAnAeoZAYArgGhCmXMc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rYlzXS6O2H/qnoN4QpI6Ir8Wr8FOKJQ0LdPDj4qFNbw=;
        b=pE0EY1I9/plUTeF/CrpbLZtjLxMmhpo0hGRS651ri8Ze5qRUGugeWCDtKm8pxcEFlG
         c0A5/Wt2jf/qp8amZOyxCP0A7QLfPxFNNiiFAOO16/+MTeN1NXdY04JQP+bveEfZQJGB
         WzmzbnqxdgpUgi4R3L8EEEn0vgIMDC1soQmup9usNjinXbkLP7YPk4eK/v60JTxvsot3
         cI6j1+zaO5q3QCNxjcxv5BvETz5mFU6+oHrdL/IkYX/JRXsUat/bUTsJv3bLiuCAhTEq
         YkpnTLfQCf2j27Kq6czNXvuwqzpIztflL6yAFq4NASEDLga16S6BEH7lfq+Y6RY2U6qC
         eX7Q==
X-Gm-Message-State: AO0yUKW2xodDw/vErdqXeSAXS+AqqHUxzlShPhi2se1yS/ZpOhFo8Ypl
        GKDQIfSAInbYTXWlPQHheHS2A6A0ZoIcgSNv4cepyg==
X-Google-Smtp-Source: AK7set8EkiGHFDEe8FtMU6Mz4IX3dDaiB1+8jrcp8nRifUecU2dGW4qL0SX+dW6TtwcGsD6Y8EFspQ==
X-Received: by 2002:a17:906:99c8:b0:8f6:dc49:337f with SMTP id s8-20020a17090699c800b008f6dc49337fmr3598415ejn.43.1677296434421;
        Fri, 24 Feb 2023 19:40:34 -0800 (PST)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id p25-20020a170906141900b008b30e2a450csm339702ejc.144.2023.02.24.19.40.33
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Feb 2023 19:40:34 -0800 (PST)
Received: by mail-ed1-f42.google.com with SMTP id ck15so5192163edb.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Feb 2023 19:40:33 -0800 (PST)
X-Received: by 2002:a50:aa9e:0:b0:4ac:b616:4ba9 with SMTP id
 q30-20020a50aa9e000000b004acb6164ba9mr8460933edc.5.1677296433597; Fri, 24 Feb
 2023 19:40:33 -0800 (PST)
MIME-Version: 1.0
References: <Y/gxyQA+yKJECwyp@ZenIV>
In-Reply-To: <Y/gxyQA+yKJECwyp@ZenIV>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 24 Feb 2023 19:40:16 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgkFyUQFwvFm78h1MXZJO8y+YqvhrDpNt6j4JFaRuGxyQ@mail.gmail.com>
Message-ID: <CAHk-=wgkFyUQFwvFm78h1MXZJO8y+YqvhrDpNt6j4JFaRuGxyQ@mail.gmail.com>
Subject: Re: [git pull] vfs.git misc bits
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 23, 2023 at 7:41 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.misc

Ugh. And I just noticed that you broke my perfect run of "only pull
signed tags" this merge window.

Oh well. It's not like it's a disaster, but it's a bit sad.

My scripting currently reacts to pulling unsigned stuff only when it's
not coming from a kernel.org tree. I think I should just update my
scripts to always alert me.

I should have realized as I pulled those anyway, but I just didn't
think about it.

              Linus
