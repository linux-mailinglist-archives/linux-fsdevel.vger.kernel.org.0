Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DA405F7AA6
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Oct 2022 17:37:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbiJGPhb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Oct 2022 11:37:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiJGPha (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Oct 2022 11:37:30 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A813B7EC8
        for <linux-fsdevel@vger.kernel.org>; Fri,  7 Oct 2022 08:37:29 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-132e9bc5ff4so5948758fac.7
        for <linux-fsdevel@vger.kernel.org>; Fri, 07 Oct 2022 08:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=T7SBjW2G2ytKmdGlf5aETlIJtNs0u+oSrdZIFHs0Id0=;
        b=EWGo1fJVCxQRjb505aksBJ2okwddGhNV46yWwoXr3CqVIQrHjvHawMtsGOXI4HwI+i
         zCeRP0aiBzcoX5cxoTb9OuzoOxmA5quovOU/FKX9C7NdWSw+jAdM4hzwNlwAzlhAj56m
         TxywUrfXvBsdPrCLRrAzxqfZ8vYST8PReKVCw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T7SBjW2G2ytKmdGlf5aETlIJtNs0u+oSrdZIFHs0Id0=;
        b=z89L+Uq/ig3ATowQ60TLuIzOnEPd+QNpUmk3h//QSEAt58HhUxyed3fH06eyyppAKK
         OYbiSWafD8GmPSQWTFyY5wJ8/g2F1TTHmkyauj2A2yadKQwQ0dYmCfTJNWteYugAEWDC
         sdO6ni523IakBuPKk9em2tEHzH/JNoSbJdk3fkutJ26geX3m88y3OxGKjxQ76CmRmJ2E
         sRgdVPtMKsliM0GBnt+ce/NwLzq/phAvAE7ddQWzPPUTkK3KqKHlXWCTP709tOgJw1Pb
         epz7wbbja9M4HBOAr0frfjwZ/otReEnzAct+H6vkmvKjnbIqL47hXGKBIPyvf5rrRVtD
         Y2Nw==
X-Gm-Message-State: ACrzQf1SlGg1JoLHK6o13HMwJldfbyoSDy2OaUgDLcmuB2456YkOehey
        U43zFUYMss+ikvGRQ9L7H7LJBPSBTXE+vw==
X-Google-Smtp-Source: AMsMyM7b6MNSe8QI+cdMKmv+sLghInVA/b3jjnOCoHEH0N7qZBf+W3/w7ndabUjx3qDDNjT48/fLlg==
X-Received: by 2002:a05:6870:8317:b0:131:a61a:60fe with SMTP id p23-20020a056870831700b00131a61a60femr8418846oae.30.1665157048080;
        Fri, 07 Oct 2022 08:37:28 -0700 (PDT)
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com. [209.85.167.171])
        by smtp.gmail.com with ESMTPSA id v186-20020a4a7cc3000000b004761ac650e1sm1020614ooc.42.2022.10.07.08.37.27
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Oct 2022 08:37:27 -0700 (PDT)
Received: by mail-oi1-f171.google.com with SMTP id r130so806285oie.4
        for <linux-fsdevel@vger.kernel.org>; Fri, 07 Oct 2022 08:37:27 -0700 (PDT)
X-Received: by 2002:aca:b957:0:b0:351:4ecf:477d with SMTP id
 j84-20020acab957000000b003514ecf477dmr2693649oif.126.1665157046993; Fri, 07
 Oct 2022 08:37:26 -0700 (PDT)
MIME-Version: 1.0
References: <20221007124834.4guduq5n5c6argve@quack3>
In-Reply-To: <20221007124834.4guduq5n5c6argve@quack3>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 7 Oct 2022 08:37:10 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh1uSKn+_grsPF+1nhpQ25o4ZsGJO0mEpHQpftD=GvkTA@mail.gmail.com>
Message-ID: <CAHk-=wh1uSKn+_grsPF+1nhpQ25o4ZsGJO0mEpHQpftD=GvkTA@mail.gmail.com>
Subject: Re: [GIT PULL] fsnotify changes for v6.1-rc1
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org
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

On Fri, Oct 7, 2022 at 5:48 AM Jan Kara <jack@suse.cz> wrote:
>
> git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fsnotify-for_v6.1-rc1

Oh, I only now noticed that your recent pull requests have been
tagged, but the tags haven't been signed.

The first time this happened (middle of June), you made me aware of it
("not signed because I'm travelling until Sunday"), but then the
signatures never came back, and I forgot all about it until this one
..

Mind reinstating the signing?

                 Linus
