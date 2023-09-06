Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0D5F796DA3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Sep 2023 01:34:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244870AbjIFXe5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Sep 2023 19:34:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244835AbjIFXe4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Sep 2023 19:34:56 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06326132
        for <linux-fsdevel@vger.kernel.org>; Wed,  6 Sep 2023 16:34:53 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-99c93638322so64117666b.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 06 Sep 2023 16:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1694043291; x=1694648091; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qp8O0CMBmeOIHtiFssMdoCJLtqwjaGXGbc+VERwFhw0=;
        b=IK+AguMszVU36JObjXVWChd2sAiYpQ6kXc1qmGDRpaJqJK5roiEw8A3uXjavqGNgti
         nI+g5lTJf28a7/d9YyPSjSnBxbqzL/YPQiqz5ZXACXaQW1TSK17MdS483FP2RRnaT7n0
         3cZ8ouik27CityQgMS5RCXb8AwN2V1usLcISY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694043291; x=1694648091;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qp8O0CMBmeOIHtiFssMdoCJLtqwjaGXGbc+VERwFhw0=;
        b=MHbAQY7Ow3Pq28IIZMRUVC3EEF3qEm3r/i48slCC0LU4Csb9Oz+tCDhob/Y/uKnZl/
         I/Gm/b1VOQQJRjL7joMmEcB+mZUHoiEtFuoRj4GHGJFSiwo9/hcUcXYSBgfuQy9ifqMj
         5YlqzoJ047JwPHbYR1OZZ0R4EiFGgOmsl5CHAvjeCoBwckYB0sDxHtdudtk5qXX8tEvF
         LZnUbJ1l4XwOSBD2G00gxlnc1RuszeX0rW2ITuhXbW09z81kQ7ur0iHu3jvrZndHTLrO
         lP3o3R00w0OuStPGHkJs0lAFxoiwDQLYlgcPxo3NohAj9HgbmrPeQ6i0iUSZs6JoS5AV
         C9tw==
X-Gm-Message-State: AOJu0YxW9eDwR1ZW6u9bgvYCrsLrbN01onOB5/1uaz5w+2j3HIPhE5IO
        lMUVMwwKHUL8PQeOP3voiGkMvSllAZg1mOvACurGytRi
X-Google-Smtp-Source: AGHT+IEnjeUGFmm01KuG5XiftJXEvf0k7H4x6JHvFk+/icLBrxmKjhcPTIZh6vRo1DGC5qGj4sWUpw==
X-Received: by 2002:a17:907:7855:b0:9a5:a543:2744 with SMTP id lb21-20020a170907785500b009a5a5432744mr1394694ejc.33.1694043291478;
        Wed, 06 Sep 2023 16:34:51 -0700 (PDT)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id dk24-20020a170906f0d800b009937dbabbd5sm9575808ejb.220.2023.09.06.16.34.49
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Sep 2023 16:34:50 -0700 (PDT)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-52bcd4db4c0so675184a12.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 06 Sep 2023 16:34:49 -0700 (PDT)
X-Received: by 2002:a05:6402:4405:b0:52e:83d0:203e with SMTP id
 y5-20020a056402440500b0052e83d0203emr1287353eda.10.1694043289719; Wed, 06 Sep
 2023 16:34:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230903032555.np6lu5mouv5tw4ff@moria.home.lan>
 <CAHk-=wjUX287gJCKDXUY02Wpot1n0VkjQk-PmDOmrsrEfwPfPg@mail.gmail.com>
 <CAHk-=whaiVhuO7W1tb8Yb-CuUHWn7bBnJ3bM7bvcQiEQwv_WrQ@mail.gmail.com>
 <CAHk-=wi6EAPRzYttb+qnZJuzinUnH9xXy-a1Y5kvx5Qs=6xDew@mail.gmail.com>
 <ZPj1WuwKKnvVEZnl@kernel.org> <20230906231354.GX14420@twin.jikos.cz>
In-Reply-To: <20230906231354.GX14420@twin.jikos.cz>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 6 Sep 2023 16:34:32 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh+RRhqgmpNN=WMz-4kkkcyNF0-a6NpRvxH9DjSTy9Ccg@mail.gmail.com>
Message-ID: <CAHk-=wh+RRhqgmpNN=WMz-4kkkcyNF0-a6NpRvxH9DjSTy9Ccg@mail.gmail.com>
Subject: Re: [GIT PULL] bcachefs
To:     dsterba@suse.cz
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Kent Overstreet <kent.overstreet@linux.dev>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-bcachefs@vger.kernel.org
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

On Wed, 6 Sept 2023 at 16:20, David Sterba <dsterba@suse.cz> wrote:
>
>     I think I've always seen an int for enums, unless it was
> explicitly narrowed in the structure (:8) or by __packed attribute in
> the enum definition.

'int' is definitely the default (and traditional) behavior.

But exactly because enums can act very differently depending on
compiler options (and some of those may have different defaults on
different architectures), we should never ever have a bare 'enum' as
part of a structure in any UAPI.

In fact, having an enum as a bitfield is much better for that case.

Doing a quick grep shows that sadly people haven't realized that.

Now: using -fshort-enum can break a _lot_ of libraries exactly for
this kind of reason, so the kernel isn't unusual, and I don't know of
anybody who actually uses -fshort-enum. I'm mentioning -fshort-enum
not because it's likely to be used, but mainly because it's an easy
way to show some issues.

You can get very similar issues by just having unusual enum values.  Doing

   enum mynum { val = 0x80000000 };

does something special too.

I leave it to the reader to figure out, but as a hint it's basically
exactly the same issue as I was trying to show with my crazy
-fshort-enum example.

              Linus
