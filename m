Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FA0C7B8D30
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Oct 2023 21:21:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245560AbjJDTJW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Oct 2023 15:09:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245529AbjJDTJM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Oct 2023 15:09:12 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E63E1FDF
        for <linux-fsdevel@vger.kernel.org>; Wed,  4 Oct 2023 12:06:38 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-99c136ee106so31202566b.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Oct 2023 12:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1696446396; x=1697051196; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qfvoggpqcNb7yXH4v6Nc/TA+F9vqFgeZKhEC5Gjnb1k=;
        b=cZe8dSQkVHqVFxz5Zxo2wUozDV/DGvv+ZvYyW9SMy22ESxsOdm/ib+XEQCsM3FKCko
         A3dHXRHNcDHy7yX3ch5eQISg/2Tkx3hG6DzqULoI/cLXm/CAFYdPHd+NSpr6AEApuEW7
         T8EZ3XZgwiHSyCkxA828LjbdclPTEsvosI2tk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696446396; x=1697051196;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qfvoggpqcNb7yXH4v6Nc/TA+F9vqFgeZKhEC5Gjnb1k=;
        b=Q9wouXiUUWZm9xGclwzt6AZ3foDlRu4ofuAgbT+zJ1DiIhTHjX/d2+dLT9UkmHgJh6
         /Md4rGG37IvmCxAvqTxrl5x9OvE0xyVK1ZmRmN500DLWLHFcNU+E34rxEjwmkhC0KdaI
         8GAMMi1Oda3DIStYEooSDOW0PAQmUVXQCez3VSTkw77QThspTgfJ++1Ez/u/JzIw/7u9
         RRnD0PJJsfLfXM6YKAsLd7O9S9Xrb5oD01vm1BOJoJZY/P9JvUf6hzRBaeK3JxHgF4dL
         ZJE0dbTnoLs69mk2jIIOgT952AJWStUuTZQ8qYl+cKkJjHGHQI0oTAg8qX0jcEFvyWXv
         1OPw==
X-Gm-Message-State: AOJu0Yy+Uh8EdOpVlOuzvR8iMb4gazBBB9pImHFTqqHKs8QLkwPPOdMO
        KBl21BwMzTTSFoYkP9MtHYyN7/5QwXFPfeZ4Xs/9+w==
X-Google-Smtp-Source: AGHT+IHe0d7mcERK12soi+bSB0CD5eBgeQ2vZMHzNhbQ+fUbtH01l5rFS8y52/3YqEvt2JeRrWKk9Q==
X-Received: by 2002:a17:906:74cc:b0:99b:ead0:2733 with SMTP id z12-20020a17090674cc00b0099bead02733mr3095678ejl.72.1696446396670;
        Wed, 04 Oct 2023 12:06:36 -0700 (PDT)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id cd10-20020a170906b34a00b009ae05f9eab3sm3238298ejb.65.2023.10.04.12.06.35
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Oct 2023 12:06:35 -0700 (PDT)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-532c81b9adbso199711a12.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Oct 2023 12:06:35 -0700 (PDT)
X-Received: by 2002:aa7:d5c8:0:b0:534:78a6:36cb with SMTP id
 d8-20020aa7d5c8000000b0053478a636cbmr2822483eds.39.1696446395357; Wed, 04 Oct
 2023 12:06:35 -0700 (PDT)
MIME-Version: 1.0
References: <20231002022815.GQ800259@ZenIV> <20231002022846.GA3389589@ZenIV>
 <20231002023125.GE3389589@ZenIV> <20231002064912.GA2013@lst.de>
 <20231002071401.GT800259@ZenIV> <20231002072143.GU800259@ZenIV>
 <20231002180925.GZ800259@ZenIV> <CAHk-=whwKZ5V2qb5JgA5UEdJBwDHYzFJ71xj0UZoiCyvBRd9AA@mail.gmail.com>
In-Reply-To: <CAHk-=whwKZ5V2qb5JgA5UEdJBwDHYzFJ71xj0UZoiCyvBRd9AA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 4 Oct 2023 12:06:18 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjn1=0SeJaho17VABvRtEnxJyR9MLz-gi1ysBDbnYNUgw@mail.gmail.com>
Message-ID: <CAHk-=wjn1=0SeJaho17VABvRtEnxJyR9MLz-gi1ysBDbnYNUgw@mail.gmail.com>
Subject: Re: [PATCH 04/15] hfsplus: switch to rcu-delayed unloading of nls and
 freeing ->s_fs_info
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>,
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
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 4 Oct 2023 at 12:04, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Adding one to after ftrace_release_mod() - where we have that
> async_synchronize_full() - would make module unloading match the
> loading error path.
>
> But the synchronize_rcu calls do seem to be a bit randomly sprinkled
> about. Maybe the one in free_module() is already sufficient for nls?

Never mind. You want it before the ->exit(). That makes sense, and
there is no matching code path for the module load failure case (since
that implies no - or failed - init()).

           Linus
