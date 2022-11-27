Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A376C639CF8
	for <lists+linux-fsdevel@lfdr.de>; Sun, 27 Nov 2022 21:49:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbiK0Utz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 27 Nov 2022 15:49:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbiK0Utu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 27 Nov 2022 15:49:50 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31E7CDEED
        for <linux-fsdevel@vger.kernel.org>; Sun, 27 Nov 2022 12:49:50 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id s4so5566489qtx.6
        for <linux-fsdevel@vger.kernel.org>; Sun, 27 Nov 2022 12:49:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0EcRsn3mpfYpm/vhZ/v7NRpfbut+cY/FRel9FddrnfI=;
        b=KBcUhnkE30+t44sLhT0QIA/TKDoVVcw2IDATdES6KfLCITZM1dINmG7lHKlIAtF5Bv
         XYen05Yj2oFW9mtHJEXYSDUF20MEYEfNCJOIA7Ao4ErgCMxXzNeUrFhRHU4n0UR5efBV
         NPgtVWwXuMjsplabdQq4ltrd1s/IVTuK0fB6M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0EcRsn3mpfYpm/vhZ/v7NRpfbut+cY/FRel9FddrnfI=;
        b=1vLzxUxtkrDXYar5yEzTHGmyof9FMzJcT9a9xyPhj9HBmMtTR6SsAf1/XugwFObWg/
         9msPzPMZwzE/Ufpnf3qkLjMfL8OyIHfNZX9h/R3q1DFIOKC4QGNjIkiI7tQxDRCjxAWT
         aTpmIoJHjZt8y/oaVXCihm3GY4W67hvAKbkVhqnp4DS5VRLSANFjzwLTKm/w5Z8fLi6Q
         nk6jwq9WpsJUtN4gSJBZc2DDCeOS8GHujprEIkqo0wGmhQvCnGom9mtbOdSYbHp2q84Z
         hMvNtnr0rUCl1k3w+wtrrxv4vkPbqDo1xB9vGJjS3/gJWNfFXPvngI1OtOqf4ypgsyYE
         pKZw==
X-Gm-Message-State: ANoB5plYZH1q0DAhEJZxwtrqeWLlfh4iBohBFc5X01sVvNxu1riQCNfD
        0b+ZHWJZJyjieg06FXovMgit9W7T6lshWg==
X-Google-Smtp-Source: AA0mqf7RTyXpS3EYhg81x7Qi5WOVcIFDM3giwuQzsc+QewWBflZ36SeS0ouVvsLfyqmGtJkOH82H+g==
X-Received: by 2002:ac8:4901:0:b0:39c:f31d:5d4c with SMTP id e1-20020ac84901000000b0039cf31d5d4cmr46029986qtq.393.1669582188998;
        Sun, 27 Nov 2022 12:49:48 -0800 (PST)
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com. [209.85.222.179])
        by smtp.gmail.com with ESMTPSA id u12-20020a05620a430c00b006fa4cac54a5sm7065144qko.72.2022.11.27.12.49.46
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Nov 2022 12:49:47 -0800 (PST)
Received: by mail-qk1-f179.google.com with SMTP id g10so6004886qkl.6
        for <linux-fsdevel@vger.kernel.org>; Sun, 27 Nov 2022 12:49:46 -0800 (PST)
X-Received: by 2002:ae9:e00c:0:b0:6f8:1e47:8422 with SMTP id
 m12-20020ae9e00c000000b006f81e478422mr43523021qkk.72.1669582186451; Sun, 27
 Nov 2022 12:49:46 -0800 (PST)
MIME-Version: 1.0
References: <20221117205249.1886336-1-amir73il@gmail.com>
In-Reply-To: <20221117205249.1886336-1-amir73il@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 27 Nov 2022 12:49:30 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgnnhUqO8mv4=0ri=Q8xYd9dpHm+_r61CTMCkQKj9fN=w@mail.gmail.com>
Message-ID: <CAHk-=wgnnhUqO8mv4=0ri=Q8xYd9dpHm+_r61CTMCkQKj9fN=w@mail.gmail.com>
Subject: Re: [PATCH v2] vfs: fix copy_file_range() averts filesystem freeze protection
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Luis Henriques <lhenriques@suse.com>,
        Olga Kornievskaia <olga.kornievskaia@gmail.com>,
        Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org,
        Luis Henriques <lhenriques@suse.de>
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

Ok, this is finally in my tree now. Thanks,

             Linus
