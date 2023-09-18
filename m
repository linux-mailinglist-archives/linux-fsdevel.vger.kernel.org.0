Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D07A57A55A1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Sep 2023 00:10:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbjIRWKm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Sep 2023 18:10:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbjIRWKl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Sep 2023 18:10:41 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4761D8F
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Sep 2023 15:10:36 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-501bd6f7d11so8370750e87.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Sep 2023 15:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1695075034; x=1695679834; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cdEF7nCED5R30iyTFsZxBU1Z4z2XSwzZIeAj9BGmVQM=;
        b=Mg/g8nh/E+XPgt1MNj86VHL22Fg+nzdo54jOi9tLzswkrfjIuFOB4+HzO78Ny7UEey
         wC8CmYy3RQIX79LNarFkoujPPitlULEw7jPibtl1N/M9Dn/anidAyxrQodx6aMkuxk9Z
         UxFWCFRcSB9E2tTlmg/ROFHkg+UJDESpOTTD8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695075034; x=1695679834;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cdEF7nCED5R30iyTFsZxBU1Z4z2XSwzZIeAj9BGmVQM=;
        b=QaJSd8H550Qm/CKt2OovkuP7vrk4IqjYHbf0nY46qncsl2O5nlj6J9z50Yyv+k6lyh
         Amx4edvMTfwiob5Rdr+VCOFjEKCBCnVpNHkF6l1dmS/CD3CObm7ioRENhiiwtLgYBLtE
         nJrnX0q4IJljDgbASHIblnJEMFZrd7tW8K6avRYDEwaN0wAiEzeDd9q7uVhqoSwzsUid
         JtXpj8m6yfVxaqQAQSuBeDf0IiwrwokJz2XY3c6j6ZGkLWh3LuIzoR+2JFkoxzBjqoWa
         L9neRUACKTVr3AbyTZ/cfQD0tnwULNeRnZCtDKAUlgwtvzKLZ08ZwAUE5+ud8oivVOpS
         3WOw==
X-Gm-Message-State: AOJu0YzihwpnkvnaGk9sE8m9azYqEqNS1VjW+8stsqljAdCGUr89lDj7
        VjMEHg6mAONsDVc+TbZc6Z41SZq3EFwUxDlp69GwrkZi
X-Google-Smtp-Source: AGHT+IG1lenSw6l7PYg0vFSSVOqUIaF/ZtpEANsE9ueohbY8b/AX5MDvy8ubLhPxiQfrreMZ0M6aRQ==
X-Received: by 2002:a05:6512:33c8:b0:502:a942:d7a8 with SMTP id d8-20020a05651233c800b00502a942d7a8mr10588093lfg.69.1695075034286;
        Mon, 18 Sep 2023 15:10:34 -0700 (PDT)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com. [209.85.221.43])
        by smtp.gmail.com with ESMTPSA id dk13-20020a0564021d8d00b005312b68cb37sm1390572edb.28.2023.09.18.15.10.33
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Sep 2023 15:10:34 -0700 (PDT)
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-32001d16a14so2276294f8f.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Sep 2023 15:10:33 -0700 (PDT)
X-Received: by 2002:a5d:66c3:0:b0:317:c2a9:9b0c with SMTP id
 k3-20020a5d66c3000000b00317c2a99b0cmr8618121wrw.50.1695075033116; Mon, 18 Sep
 2023 15:10:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230918-hirte-neuzugang-4c2324e7bae3@brauner>
 <CAHk-=wiTNktN1k+D-3uJ-jGOMw8nxf45xSHHf8TzpjKj6HaYqQ@mail.gmail.com>
 <e321d3cfaa5facdc8f167d42d9f3cec9246f40e4.camel@kernel.org>
 <CAHk-=wgxpneOTcf_05rXMMc-djV44HD-Sx6RdM9dnfvL3m10EA@mail.gmail.com> <2020b8dfd062afb41cd8b74f1a41e61de0684d3f.camel@kernel.org>
In-Reply-To: <2020b8dfd062afb41cd8b74f1a41e61de0684d3f.camel@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 18 Sep 2023 15:10:16 -0700
X-Gmail-Original-Message-ID: <CAHk-=whACfXMFPP+dPdsJmuF0F6g+YHfUtOxiESM+wxvZ22-GA@mail.gmail.com>
Message-ID: <CAHk-=whACfXMFPP+dPdsJmuF0F6g+YHfUtOxiESM+wxvZ22-GA@mail.gmail.com>
Subject: Re: [GIT PULL] timestamp fixes
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 18 Sept 2023 at 13:56, Jeff Layton <jlayton@kernel.org> wrote:
>
> We may have a problem with the ctime update though, since you pointed it
> out. We have this in inode_set_ctime_current(), in the codepath where
> the QUERIED bit isn't set:
>
>                 /*
>                  * If we've recently updated with a fine-grained timestamp,
>                  * then the coarse-grained one may still be earlier than the
>                  * existing ctime. Just keep the existing value if so.
>                  */
>                 ctime.tv_sec = inode->__i_ctime.tv_sec;
>                 if (timespec64_compare(&ctime, &now) > 0)
>                         return ctime;
>
> The ctime can't be set via utimes(), so that's not an issue here, but we
> could get a realtime clock jump backward that causes this to not be
> updated like it should be.
>
> I think (like you suggest above) that this needs some bounds-checking
> where we make sure that the current coarse grained time isn't more than
> around 1-2 jiffies earlier than the existing ctime. If it is, then we'll
> go ahead and just update it anyway.
>
> Thoughts?

Ack, that sounds about right to me.

Christian - I'm just going to assume that you'll sort this out and
I'll get a new pull request at some point. Holler if you think
something else is needed, ok?

              Linus
