Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E1587A56A2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Sep 2023 02:38:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbjISAix (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Sep 2023 20:38:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjISAix (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Sep 2023 20:38:53 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EEDF107;
        Mon, 18 Sep 2023 17:38:47 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-d8162698f0dso4971673276.0;
        Mon, 18 Sep 2023 17:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695083926; x=1695688726; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+BrAIiEZWlqz7+FDnE8u9tarMF/2bVwunjQA4h3kz1Q=;
        b=QddILysf93vSyhJrIEchOtmhoVZJKsxhMBiZ3qV1aJfTgrzmMj4eRpnJWrcGeNc2P8
         rV7jU/DHIU215EUzwjRWKtXDE9d2XHUE3qU00EuAn4WrET8angbWR365z4HLRLR/Amnv
         fFfkDgcrejplWi4ei+4FXHm1wBqzWUhezrWZGnn7JNf87kzOrUs1i9GWK1yGe3okbPbP
         pMpG+3u+2+e4rGJPsnuueX6z1DK+AQBHsox5Ikz0VxEUFpaWNK3P7kILhL0m9lMF+qdz
         4o237Kz3CQiNG+T15ciUlmfAs0r9qTdkDdl+w/8QTdII41t/OvFM2JAfgFDAC0ZJ9wmc
         +yKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695083926; x=1695688726;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+BrAIiEZWlqz7+FDnE8u9tarMF/2bVwunjQA4h3kz1Q=;
        b=gItMRnoCI5W9ldp1c/gXcs9dWPlzD6ZVJUrk+v78mG/5C+ywXcH3bXrJzuDaOjiVbX
         eO54bVuwSVwep17Vx+tY6mr+ILJYkABXWp6WrCGf6IvJtfqZt2DJ3pbyxlIbb08ufVia
         tDplrwSGIjcWNd0IuXlXsEGA96YErDh6dX59MmVBZ5sPz/kccT++hDDmg52A62JMSbPN
         ECdaK366W26yRNACtVqvcEvGqHGvRPLBRAlKPXGarIdAZgOxbc+I56Sa+hmazXrTUEDa
         cqtOOhn/Jdz9+gqZD2j3Tqul5+zROBHY6L7EITCCrVaed/HgIERdQOZKqlOmN2rkWrpL
         Dyeg==
X-Gm-Message-State: AOJu0YzT+Br8y3sShLrspl6HZN4zAaY7BNB8/WBKjGzTVAtAB9iqrft4
        EW+Zhd6/Riv/9pi4gX56O10=
X-Google-Smtp-Source: AGHT+IF3HR+pL2xsoZYsXtpvyi+BXF+Ub8xKeYeQ15PAk4FgZND2gP6wDx5pfhfNl49Gtr505BxuQw==
X-Received: by 2002:a25:25d3:0:b0:d81:8c74:8f88 with SMTP id l202-20020a2525d3000000b00d818c748f88mr9876563ybl.25.1695083926552;
        Mon, 18 Sep 2023 17:38:46 -0700 (PDT)
Received: from firmament.. (h198-137-20-64.xnet.uga.edu. [198.137.20.64])
        by smtp.gmail.com with ESMTPSA id b13-20020a25340d000000b00d81c86f121esm2121537yba.11.2023.09.18.17.38.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 17:38:46 -0700 (PDT)
From:   Matthew House <mattlloydhouse@gmail.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Christian Brauner <brauner@kernel.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-man@vger.kernel.org,
        linux-security-module@vger.kernel.org, Karel Zak <kzak@redhat.com>,
        Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Amir Goldstein <amir73il@gmail.com>
Subject: Re: [RFC PATCH 2/3] add statmnt(2) syscall
Date:   Mon, 18 Sep 2023 20:37:42 -0400
Message-ID: <20230919003800.93141-1-mattlloydhouse@gmail.com>
In-Reply-To: <CAJfpegvTiK=RM+0y07h-2vT6Zk2GCu6F98c=_CNx8B1ytFtO-g@mail.gmail.com>
References: <20230914-salzig-manifest-f6c3adb1b7b4@brauner> <CAJfpegs-sDk0++FjSZ_RuW5m-z3BTBQdu4T9QPtWwmSZ1_4Yvw@mail.gmail.com> <20230914-lockmittel-verknallen-d1a18d76ba44@brauner> <CAJfpegt-VPZP3ou-TMQFs1Xupj_iWA5ttC2UUFKh3E43EyCOQQ@mail.gmail.com> <20230918-grafik-zutreffen-995b321017ae@brauner> <CAOssrKfS79=+F0h=XPzJX2E6taxAPmEJEYPi4VBNQjgRR5ujqw@mail.gmail.com> <20230918-hierbei-erhielten-ba5ef74a5b52@brauner> <CAJfpegtaGXoZkMWLnk3PcibAvp7kv-4Yobo=UJj943L6v3ctJQ@mail.gmail.com> <20230918-stuhl-spannend-9904d4addc93@brauner> <CAJfpegvxNhty2xZW+4MM9Gepotii3CD1p0fyvLDQB82hCYzfLQ@mail.gmail.com> <20230918-bestialisch-brutkasten-1fb34abdc33c@brauner> <CAJfpegvTiK=RM+0y07h-2vT6Zk2GCu6F98c=_CNx8B1ytFtO-g@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 18, 2023 at 11:39 AM Miklos Szeredi <miklos@szeredi.hu> wrote:
> Okay, so there are now (at least) two buffers, and on overflow the
> caller cannot know which one got overflown.  It can resize both, but
> that doesn't make the caller any simpler to implement.
>
> Also the interface is kind of weird in that some struct members are
> out, some are in (the pointers and the lengths).
>
> I'd prefer the single buffer interface, which has none of the above issue=
s.
>
> Thanks,
> Miklos

One natural solution is to set either of the two lengths to the expected
size if the provided buffer are too small. That way, the caller learns both
which of the buffers is too small, and how large they need to be. Replacing
a provided size with an expected size in this way already has precedent in
existing syscalls:

recvmsg(2):
    The msg argument points to an in/out struct msghdr, and msg->msg_name
    points to an optional buffer which receives the source address. If
    msg->msg_namelen is less than the actual size of the source address,
    the function truncates the address to that length before storing it in
    msg->msg_name; otherwise, it stores the full address. In either case,
    it sets msg->msg_namelen to the full size of the source address before
    returning.

(An address buffer size is similarly provided directly as an in/out pointer
in accept(2), accept4(2), getpeername(2), getsockname(2), and recvfrom(2).)

name_to_handle_at(2):
    The handle argument points to an in/out struct file_handle, followed by
    a variable-length char array. If handle->handle_bytes is too small to
    store the opaque handle, the function returns -EOVERFLOW; otherwise,
    it succeeds. In either case, it sets handle->handle_bytes to the size
    of the opaque handle before returning.

perf_event_open(2):
    The attr argument points to an in/out struct perf_event_attr. If
    attr->size is not a valid size for the struct, the function sets it to
    the latest size and returns -E2BIG.

sched_setattr(2):
    The attr argument points to an in/out struct sched_attr. If attr->size
    is not a valid size for the struct, the function sets it to the latest
    size and returns -E2BIG.

The specific pattern of returning the actual size of the strings both on
success and on failure, as with recvmsg(2) and name_to_handle_at(2), is
beneficial for callers that want to copy the strings elsewhere without
having to scan for the null byte. (Also, it would work well if we ever
wanted to return variable-size binary data, such as arrays of structs.)

Indeed, if we returned the actual size of the string, we could even take a
more radical approach of never setting a null byte after the data, leaving
the caller to append its own null byte if it really wants one. But perhaps
that would be taking it a bit too far; I just don't want this API to end up
in an awful situation like strncpy(3) or struct sockaddr_un, where the
buffer is always null-terminated except in one particular edge case. Also,
if we include a null byte in the returned size, it could invite off-by-one
errors in callers that just expect it to be the length of the string.

Meanwhile, if this solution of in/out size fields were adopted, then
there'd still be the question of what to do when a provided size is too
small: should the returned string be truncated (indicating the issue only
by the returned size being greater than the provided size), or should the
entire call fail with an -EOVERFLOW? IMO, the former is strictly more
flexible, since the caller can set a limit on how big a buffer it's willing
to dedicate to any particular string, and it can still retrieve the
remaining data if that buffer isn't quite big enough. But the latter might
be considered a bit more foolproof against callers who don't properly test
for truncation.

Thank you,
Matthew House
