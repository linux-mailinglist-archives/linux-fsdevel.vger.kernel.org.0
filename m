Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EA087A51FA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Sep 2023 20:24:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbjIRSYw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Sep 2023 14:24:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjIRSYw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Sep 2023 14:24:52 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77664FD
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Sep 2023 11:24:46 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2bffa8578feso30690501fa.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Sep 2023 11:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1695061484; x=1695666284; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=l4dXk6Q78Nq5eL8rDRkALATs4DmJ8BnONZg2xTC0Jc0=;
        b=T7kVfXd8SZA3Dp2MOkJEQcAtITWqwvKjX6uujRrKUzIgrTUtkJZV5co/Rs6cTHzCrg
         WNEULOmbBHcrfPABQM9UMEWlV9QiDmvbTEj2rKjDJoiTkfCQkEwWWNkdel/ZS/uwxKY0
         QTWzHla5ybEiqCp9oyU9OSOB1dv5OsT9fMj4o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695061484; x=1695666284;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l4dXk6Q78Nq5eL8rDRkALATs4DmJ8BnONZg2xTC0Jc0=;
        b=sNs374berH6w66oxqw1aBAziTjvq9OygiSdwFkx9kTVxX1kvZW8wv2pDAkJCioVpc9
         7Gco9USTJfgjxMH+b1IYEI8fn4z3F0BFqJjERwRx2PTIm3qCAh1voydCEuZg+9wN2fNV
         djyXeg1lkmrYNNXcp484hAhlwTtS0eBTkK3sy7Uh8uJZvGsq6J0m8KxkZLrUdiiKp2QT
         YHybOdiQTS6ln2lOjhOIvm7QFDmQV39S9ygatpE0ZX3wZw4lXFYXvjgYKPsyDerbaK6O
         KckLpbIKbsB1k/XNVObwjFFIlFBASI8prfbKEQTiAF1FKEvcVynh0wepA9qSpEdJpqVq
         Sthw==
X-Gm-Message-State: AOJu0YyQJ96N9Lk02ZC5AaubZQ1uFOGhqYF8lDuP83txzhZltblMDdHy
        czVeBdcNOAL9TY8Pu6iKKGGHerBEb0j4hEuA0Xw+jVNx
X-Google-Smtp-Source: AGHT+IGi95xuIIe+Za80YglOi2UXYmLBBiBjWEAkSvPTWljG4MYstqne6yeIYkgPdMHXzkq1B7H22w==
X-Received: by 2002:a2e:9902:0:b0:2bc:d38e:b500 with SMTP id v2-20020a2e9902000000b002bcd38eb500mr8555103lji.42.1695061484399;
        Mon, 18 Sep 2023 11:24:44 -0700 (PDT)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id x10-20020a2e7c0a000000b002b9b27cf729sm2227974ljc.52.2023.09.18.11.24.43
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Sep 2023 11:24:43 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-50308217223so3192577e87.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Sep 2023 11:24:43 -0700 (PDT)
X-Received: by 2002:a19:ae07:0:b0:500:9524:f733 with SMTP id
 f7-20020a19ae07000000b005009524f733mr7387536lfc.20.1695061483382; Mon, 18 Sep
 2023 11:24:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230918-hirte-neuzugang-4c2324e7bae3@brauner>
In-Reply-To: <20230918-hirte-neuzugang-4c2324e7bae3@brauner>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 18 Sep 2023 11:24:26 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiTNktN1k+D-3uJ-jGOMw8nxf45xSHHf8TzpjKj6HaYqQ@mail.gmail.com>
Message-ID: <CAHk-=wiTNktN1k+D-3uJ-jGOMw8nxf45xSHHf8TzpjKj6HaYqQ@mail.gmail.com>
Subject: Re: [GIT PULL] timestamp fixes
To:     Christian Brauner <brauner@kernel.org>,
        Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.cz>
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

On Mon, 18 Sept 2023 at 04:54, Christian Brauner <brauner@kernel.org> wrote:
>
> * Only update the atime if "now" is later than the current value. This
>   can happen when the atime gets updated with a fine-grained timestamp
>   and then later gets updated using a coarse-grained timestamp.

I pulled this, and then I unpulled it again.

I think this is fundamentally wrong.

If somebody has set the time into the future (for whatever reason -
maybe the clocks were wrong at some point), afaik accessing a file
should reset it, and very much used to do that.

Am I missing something? Because this really seems *horribly* broken garbage.

Any "go from fine-grained back to coarse-grained" situation needs to
explicitly test *that* case.

Not some kind of completely broken "don't update to past value" like this.

               Linus
