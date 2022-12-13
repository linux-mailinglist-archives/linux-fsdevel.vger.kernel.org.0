Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC72A64AE5A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Dec 2022 04:40:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234264AbiLMDkv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Dec 2022 22:40:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234254AbiLMDku (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Dec 2022 22:40:50 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 022B2165B0
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Dec 2022 19:40:49 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id s9so10610411qtx.6
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Dec 2022 19:40:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tUAqA2SlkGJGoP8jdNp8BFCeN3i3DSiZETy07vaICDs=;
        b=g9Nl4T/+fTHSkFjHq2JeyH2Z1NmJhIvGaWhttKU1xSkd8QffENkiRwL1EFi8dsGs1n
         zpDjgklpa4gBd1ZEL6VEnRPTQ5RtKrdkKHENJrwDOWxEAnh8oW5CRMFuErOtRa+54qtF
         4HWD5YH8xkBqOV50nhvtn1xHXJhKz74isoqRg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tUAqA2SlkGJGoP8jdNp8BFCeN3i3DSiZETy07vaICDs=;
        b=vWnTpKdHCkDzytp5hevVrUNJ0pLtEK7MH5YjjP86kP1HRrMXmEwKUZ7ixsMGOkPlU2
         4FDoMSp10w3SlBjeJWyIXXrgv/P17GCNchcGTsJ0hhSo9XyvGp4n3GE9ABtKqSWbSEsp
         tRiCGXFJAgU1hdjCoe+wuZZw97ARk/S85QmU2AkQZbGA2ujZIXSoXPqHYW/VEEc5Jd2P
         W1raPmcqlcyw19rDde+QqVfoIdOoKK3P4QspUT7PQAhvqbb2HurzAexkEuf736PB14mv
         A8pa3GYzrcXr7Qh7MLzxP9uKzfh+uevBl+Is6WcCzrNWGsdsAmyEYKvb1/PUm3d71Jc6
         tLrQ==
X-Gm-Message-State: ANoB5pl0u2VWuDwJcgku71QBOirv0Lm2RGz/v3UGkBrZ5WRCJsRX38oT
        0f0NmNWmL3m9giCFqixiZ6K/qB8meEBQRCIf
X-Google-Smtp-Source: AA0mqf4JgJkJZ9Ji7DSiQY18XnaCL7WMdOxMpEVtnYT4q/FZfF4ZF8baDR8LsaWQjBpRSa5G8p1j9Q==
X-Received: by 2002:a05:622a:4017:b0:3a5:8084:9f60 with SMTP id cf23-20020a05622a401700b003a580849f60mr28240475qtb.64.1670902847248;
        Mon, 12 Dec 2022 19:40:47 -0800 (PST)
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com. [209.85.160.174])
        by smtp.gmail.com with ESMTPSA id r12-20020ac8424c000000b003a4f435e381sm6747580qtm.18.2022.12.12.19.40.45
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Dec 2022 19:40:45 -0800 (PST)
Received: by mail-qt1-f174.google.com with SMTP id fu10so10916576qtb.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Dec 2022 19:40:45 -0800 (PST)
X-Received: by 2002:ac8:4988:0:b0:3a7:ef7b:6aa5 with SMTP id
 f8-20020ac84988000000b003a7ef7b6aa5mr7555265qtq.436.1670902844805; Mon, 12
 Dec 2022 19:40:44 -0800 (PST)
MIME-Version: 1.0
References: <20221212131915.176194-1-brauner@kernel.org>
In-Reply-To: <20221212131915.176194-1-brauner@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 12 Dec 2022 19:40:29 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj+tqv2nyUZ5T5EwYWzDAAuhxQ+-DA2nC9yYOTUo5NOPg@mail.gmail.com>
Message-ID: <CAHk-=wj+tqv2nyUZ5T5EwYWzDAAuhxQ+-DA2nC9yYOTUo5NOPg@mail.gmail.com>
Subject: Re: [GIT PULL] fs idmapped updates for v6.2
To:     Christian Brauner <brauner@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Mon, Dec 12, 2022 at 5:19 AM Christian Brauner <brauner@kernel.org> wrote:
>
> Please note the tag contains all other branches for this cycle merged in.

Well, considering that the explanation basically assumed I had already
merged those (and I had), I wish you also had made the diffstat and
the shortlog reflect that.

As it was, now the diffstat and shortlog ends up containing not what
this last pull request brought in, but what they *all* brought in...

I'm also not super-happy with how ugly your history for this branch
was. You had literally merged the acl rework branch three times - at
different points of that branch.

Do we have other ugly history in the tree? Yes. But we've been getting
better. This was _not_ one of those "getting better" moments.

Oh well. I can see what you wanted to do, and I agree with the end
result, I just don't particularly like how this was done.

I've pulled it.

             Linus
