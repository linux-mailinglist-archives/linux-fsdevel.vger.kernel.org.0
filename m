Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBCF861A05C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Nov 2022 19:55:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbiKDSz0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Nov 2022 14:55:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiKDSzX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Nov 2022 14:55:23 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13DEC51C3F
        for <linux-fsdevel@vger.kernel.org>; Fri,  4 Nov 2022 11:55:23 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id e15so3802797qvo.4
        for <linux-fsdevel@vger.kernel.org>; Fri, 04 Nov 2022 11:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=l9rtjuYQHEdZGFnPi4RO+GW6VHNzPLGvueZ1wnAoh2k=;
        b=OWDsUW0TRqhugSuTXEHAIWTiEORqtx5V3rm6QXXdvdb/+4LTjk8HA1gynX6RS2YvPr
         YwGT0Vmshp0VTPKxfY0x2OPAMJFWxvc63VjG76cOTNECBxWVbm3bFDDUyd4lObbZV3C/
         15holUc1uUmi0znm1aMGfpgmqvl14sVRYOGAg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l9rtjuYQHEdZGFnPi4RO+GW6VHNzPLGvueZ1wnAoh2k=;
        b=74mXe+I6oU5b8BXngMulHUzWPu3cRDBmuw+KWLxUvxe4ugHx1XTbX9sPkiKt4K+2vX
         NaOPTA0VP2n/Kx7lsKJRqLB7z3DFqw048GG/dHhA/PAvK64emzfjulnJIKR9vFX9Pjjm
         5rox9L5X2lwR8A3PAyKqoPhcyeIAmpLffGlHuU/mR1eoZOfobW3wyjn/uTGufPBjlhUN
         It9sUuVLv2WwQ66qeuADulwiAOoSLjLupGAUHgLxlzx7S8GaMb01kvToS2ufDy1v7SBx
         iGpGqUlq0VATt0AfXnkT/7NCe6F2Msnh7se8zY0ZFVnLUYnUawWHONq9GpATz3Jct7kb
         otcw==
X-Gm-Message-State: ACrzQf0XQNxi0qzfJUbHyaCDFG0axdd+1wM2HTAPxbaa4pIbmngBzx6z
        3I/hrs3RiJjnRvLbuRm+IZBlXxTsIgBpIA==
X-Google-Smtp-Source: AMsMyM5snaRxutsVcaHfBtLR2u9KJdQmSJMu47Fg866Ar50xSYLy/oK48pc2D2XBRVFELXPnynb/wQ==
X-Received: by 2002:ad4:5ba1:0:b0:4af:8920:f9c5 with SMTP id 1-20020ad45ba1000000b004af8920f9c5mr33506158qvq.59.1667588121989;
        Fri, 04 Nov 2022 11:55:21 -0700 (PDT)
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com. [209.85.219.171])
        by smtp.gmail.com with ESMTPSA id s10-20020a05620a254a00b006bb8b5b79efsm3362788qko.129.2022.11.04.11.55.21
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Nov 2022 11:55:21 -0700 (PDT)
Received: by mail-yb1-f171.google.com with SMTP id r3so6842425yba.5
        for <linux-fsdevel@vger.kernel.org>; Fri, 04 Nov 2022 11:55:21 -0700 (PDT)
X-Received: by 2002:a81:8241:0:b0:370:5fad:47f0 with SMTP id
 s62-20020a818241000000b003705fad47f0mr27860255ywf.441.1667587785316; Fri, 04
 Nov 2022 11:49:45 -0700 (PDT)
MIME-Version: 1.0
References: <1010626.1667584040@warthog.procyon.org.uk>
In-Reply-To: <1010626.1667584040@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 4 Nov 2022 11:49:28 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjKwjX-hNV81sDy8J3vi9_x5m7iCEOFTR1ijiPGfQdz9w@mail.gmail.com>
Message-ID: <CAHk-=wjKwjX-hNV81sDy8J3vi9_x5m7iCEOFTR1ijiPGfQdz9w@mail.gmail.com>
Subject: Re: [PATCH] iov_iter: Declare new iterator direction symbols
To:     David Howells <dhowells@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>, willy@infradead.org,
        dchinner@redhat.com, Steve French <smfrench@gmail.com>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Rohith Surabattula <rohiths.msft@gmail.com>,
        Jeff Layton <jlayton@kernel.org>,
        Ira Weiny <ira.weiny@intel.com>, linux-cifs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Fri, Nov 4, 2022 at 10:47 AM David Howells <dhowells@redhat.com> wrote:
>
> If we're going to go with Al's changes to switch to using ITER_SOURCE and
> ITER_DEST instead of READ/WRITE, can we put just the new symbols into mainline
> now, even if we leave the rest for the next merge window?

No, I really don't want to have mixed-used stuff in the kernel.

Continue to use the old names until/if the conversion happens, at
which point it's the conversion code that does it.

No "one branch uses new names, another uses old names" mess.

               Linus
