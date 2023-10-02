Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 006D57B5739
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Oct 2023 18:12:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238436AbjJBQKs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Oct 2023 12:10:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238433AbjJBQKq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Oct 2023 12:10:46 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88DEA93
        for <linux-fsdevel@vger.kernel.org>; Mon,  2 Oct 2023 09:10:43 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-9b1ebc80d0aso2026251166b.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Oct 2023 09:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1696263041; x=1696867841; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VEuoUxyWlcCEasHkHQHUWQrWTNQBD3qFkGsi/wvaW7o=;
        b=TWyTai3YQGSf7e6uEVcDvvdf5L/7YwF7YvMIsS/fJN4BPZK+w6DxxsIEoshO5kAm3x
         qdUlBD+qwTzri/oTcoPpT06gr2s4vXGfF2PY0V+KiIsojRRYovRqIGdjyowxJsNPcrmr
         v3LhLPnTOEt12uJ7JvfZWD5UUzZMjthz5PVhA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696263041; x=1696867841;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VEuoUxyWlcCEasHkHQHUWQrWTNQBD3qFkGsi/wvaW7o=;
        b=Z6AeuTEJ+osnYv29aeQU9OyujHnIeQYw7wa4UnguKPLWM8XbX372HSxEd3jybHiH/k
         WHrnf9ZBTTRlt8g3McUvskWex3LwNZ5EpUPqtQpim4bNAupQT4t6jSoSacCB1qTTw6aW
         f5HcKUU6078O0wNg0epBpXIIYCitnGZ4xhfWbFV4M/cvhRtIfUosAyfRRDQx/ZFyZBo0
         9rcqt4HevJHKsxZ8NGrsiN3RECmN5ACUeW8cg6RLLrdf+oK/jVxiABcJmIpJeLgSkxoR
         ftSTs8WTowYPlahW6Xp79NicfRJMIA9bWbi2DG3XGu56UmMn7Ys+jB6U2blgBHCh0bQT
         +e/A==
X-Gm-Message-State: AOJu0YzwLPgxMbQP7Sf1zRBMmLWbHm3t7Q8z/zG75N4lBRlPn8EhDM7N
        e2ISXAF/BNvQ4Sk8FRm824Yp/k/+V2hVWnZoauMZKU/D
X-Google-Smtp-Source: AGHT+IEYWln/1UUnW02QSwHPN2UNAAYov3zPBYScGEx/eoA0n2MOtvmeOAkl6JvF8PSyna9+6WQ0gA==
X-Received: by 2002:a17:906:31d6:b0:9aa:209f:20c3 with SMTP id f22-20020a17090631d600b009aa209f20c3mr9606652ejf.68.1696263041761;
        Mon, 02 Oct 2023 09:10:41 -0700 (PDT)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id sa21-20020a170906edb500b009add084a00csm17143138ejb.36.2023.10.02.09.10.40
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Oct 2023 09:10:40 -0700 (PDT)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5344d996bedso15443583a12.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Oct 2023 09:10:40 -0700 (PDT)
X-Received: by 2002:aa7:da99:0:b0:534:8872:d2cc with SMTP id
 q25-20020aa7da99000000b005348872d2ccmr9684918eds.41.1696263040161; Mon, 02
 Oct 2023 09:10:40 -0700 (PDT)
MIME-Version: 1.0
References: <20231002022815.GQ800259@ZenIV> <20231002022846.GA3389589@ZenIV> <20231002023015.GC3389589@ZenIV>
In-Reply-To: <20231002023015.GC3389589@ZenIV>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 2 Oct 2023 09:10:22 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjDRb4OyO9ARykQWuC7GJmj1N0uKH-CghXgjW5ypdnQ4g@mail.gmail.com>
Message-ID: <CAHk-=wjDRb4OyO9ARykQWuC7GJmj1N0uKH-CghXgjW5ypdnQ4g@mail.gmail.com>
Subject: Re: [PATCH 02/15] exfat: move freeing sbi, upcase table and dropping
 nls into rcu-delayed helper
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Namjae Jeon <linkinjeon@kernel.org>,
        David Sterba <dsterba@suse.com>,
        David Howells <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Amir Goldstein <amir73il@gmail.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Bob Peterson <rpeterso@redhat.com>,
        Steve French <sfrench@samba.org>,
        Luis Chamberlain <mcgrof@kernel.org>
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

On Sun, 1 Oct 2023 at 19:30, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> That stuff can be accessed by ->d_hash()/->d_compare(); as it is, we have
> a hard-to-hit UAF if rcu pathwalk manages to get into ->d_hash() on a filesystem
> that is in process of getting shut down.
>
> Besides, having nls and upcase table cleanup moved from ->put_super() towards
> the place where sbi is freed makes for simpler failure exits.

I don't disagree with moving the freeing,  but the RCU-delay makes me go "hmm".

Is there some reason why we can't try to do this in generic code? The
umount code already does RCU delays for other things, I get the
feeling that we should have a RCu delay between "put_super" and
"kkill_sb".

Could we move the ->kill_sb() call into destroy_super_work(), which is
already RCU-delayed, for example?

It feels wrong to have the filesystems have to deal with the vfs layer
doing RCU-lookups.

             Linus
