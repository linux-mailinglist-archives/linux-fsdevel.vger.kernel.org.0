Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A310265F474
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Jan 2023 20:29:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235648AbjAET3e (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Jan 2023 14:29:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235738AbjAET3M (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Jan 2023 14:29:12 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B48F144C5A
        for <linux-fsdevel@vger.kernel.org>; Thu,  5 Jan 2023 11:24:11 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id v14so28003885qtq.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Jan 2023 11:24:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wA6zjUWDla8Wa44c9gkxwgIgEjpo1cF6ddwBY9DXoGc=;
        b=CZwp3E9mQtVpUlgzcXqVrLQJArwxOza1knUi3fk8Fx7pH9tlR8uzb3ZaOEhL7M4BAW
         2YjKJC/mZARNGN+rEQ0+tnHarKrogcGgzBZehS7g9hpbu1MUxXJeZCQPynmwHHG89MXh
         /DBB6Si4biDq3UlnRtrJxmmzHRn40EgNgrbkw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wA6zjUWDla8Wa44c9gkxwgIgEjpo1cF6ddwBY9DXoGc=;
        b=2eFpfMPiX9ENr/+EVU3K62JWPMl3FFCB0gD4NhPuOqJdKsViO7P4MfvE1IATrA5Ok+
         RVlKdcB0PCpweq0lCsCqHvyFtw/JA9pPMpAIlEbCg0mSKxSlpOQjJFztcgM37jvEWg36
         ZP11iWJ1GN67lhYijik6i4WL5eocNIF1jail6hrz1VcM+Qmbu1JRx0wKgIv3prTsuIFV
         tqvvsz//hdLKUvdz37bDuDRA6W/ek6Um3v15UI2K4DheU5I5bt1FsJevmEV2ID5teqKM
         9Z7og5EvX53FjnSRMjCtEEc6zWhicAq2yYvM1CU9DUlusMwcNVCWHvWdPcRj99v0R8J3
         W9fw==
X-Gm-Message-State: AFqh2kqM4dPD/wjf+PGqWiofHxMUmfVgnYsPl7/PHx6cT8bwXJKXau6A
        E5F9R/X0eMG89KSaGumqtf+kTs4bRrAoNPCg
X-Google-Smtp-Source: AMrXdXtsYD+caq1TMfWyFj01f9Imw+f8yuw74wff3KKNjyAfqHFLxCeWraae+glA2brdJ1Ai2xI6CA==
X-Received: by 2002:ac8:71c3:0:b0:3a9:7f7b:b99c with SMTP id i3-20020ac871c3000000b003a97f7bb99cmr65687949qtp.34.1672946616837;
        Thu, 05 Jan 2023 11:23:36 -0800 (PST)
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com. [209.85.222.176])
        by smtp.gmail.com with ESMTPSA id v15-20020a05620a440f00b0070495934152sm26238028qkp.48.2023.01.05.11.23.36
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Jan 2023 11:23:36 -0800 (PST)
Received: by mail-qk1-f176.google.com with SMTP id h8so18375834qkk.8
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Jan 2023 11:23:36 -0800 (PST)
X-Received: by 2002:ae9:ef49:0:b0:6fe:d4a6:dcef with SMTP id
 d70-20020ae9ef49000000b006fed4a6dcefmr2402321qkg.594.1672946615982; Thu, 05
 Jan 2023 11:23:35 -0800 (PST)
MIME-Version: 1.0
References: <20230105142644.ubqxsokgthyfi56h@quack3>
In-Reply-To: <20230105142644.ubqxsokgthyfi56h@quack3>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 5 Jan 2023 11:23:20 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg59MK62LSR-Xs8KsxvmJSnyg1d-aZQ4n5+JKdTOc3RxA@mail.gmail.com>
Message-ID: <CAHk-=wg59MK62LSR-Xs8KsxvmJSnyg1d-aZQ4n5+JKdTOc3RxA@mail.gmail.com>
Subject: Re: [GIT PULL] udf fixes for 6.2-rc3 and ext2 cleanup
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

On Thu, Jan 5, 2023 at 6:26 AM Jan Kara <jack@suse.cz> wrote:
>
> The pull request is somewhat large but given these are all fixes (except
> for ext2 conversion) and we are only at rc3, I hope it is fine.

That

> Jan Kara (30):
>       udf: New directory iteration code

really is entirely new code, I want to get these kinds of things
during the merge window.

This is not some kind of urgent new regression that needs fixing so
urgently that we take new development outside the merge window.

This needs to go in for 6.3, and _if_ the syzbot reports are
considered super-urgent and important enough to be back-ported, then
it would need to be marked for stable and backported, simply because
then old kernels would need it too.

But clearly none of this was considered quite that important. So 6.3 it is.

If parts of this is more urgent, send just that part. Not this whole
"rewrite directory handling from scratch" stuff.

               Linus
