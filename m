Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AF00636DB1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Nov 2022 23:58:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbiKWW6l (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Nov 2022 17:58:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbiKWW6k (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Nov 2022 17:58:40 -0500
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3360E93CED
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Nov 2022 14:58:39 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id l2so145083qtq.11
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Nov 2022 14:58:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kZnCvaEQ344vGtn47RMsQAQkT919w64rZm3gu+vPQMY=;
        b=ZO8KT8PP+ynCgfpAsn0gLSY6SzCQhijyPIHusMskwtf9T1rrauFK8Ru8L7xDqiT98Q
         whp7Qv/cl82o4vi2+YEdK/JvvoG6oPw59CunYWdS4vec2yu+4W+UTQwMrh5IPxj3UHlB
         r/ebpwM/LCmalYllI981sk89ihQ71VnQhIaAA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kZnCvaEQ344vGtn47RMsQAQkT919w64rZm3gu+vPQMY=;
        b=dFBvdtL7FPM58xcdI2QqaGCCBXkJuVentI1LZ4Lw7rTge42/XNhVN3dqc5p9WWzcTd
         P3Ebf6PIr1aouF5XNoDd30A266uhifUuEw7A4HZeeH8JbNUQe2HaJb+MeiJG3cS+dQG7
         wbtRWgckgN1JZ/SoDIilmKF+VErdOwgzQTtbYrNcNT5FJklWTpzqVb6YsRZxri7AkwvR
         spEh6sP204b0yn4/o7g8emdMbqCEfdC0LdGrixDEEYkb+FI8cuxSnxJKh//byAUSq6tw
         XbfWDoo++CEp/ZrLexE23wRpGsBX7sMA9wCp/WgzkYOssx09EuUsUjoEKqddnS3eXDhX
         ZrKQ==
X-Gm-Message-State: ANoB5pkGUeCDDSUwi8FlimZ6/jxZjUDcP7hCYctRT4MFJJel7gXmJzHA
        uZ3kqapr3wUoAhCyHzJdkEBm+bkovl2PEw==
X-Google-Smtp-Source: AA0mqf7h1hJm55dn69vRYNCT57HySF3u0rW8k/UAkpJ3zavxCNFIRRaf2CcyygZOoUEbKZassP6fSw==
X-Received: by 2002:ac8:7452:0:b0:3a5:7a9c:242d with SMTP id h18-20020ac87452000000b003a57a9c242dmr28107625qtr.361.1669244318035;
        Wed, 23 Nov 2022 14:58:38 -0800 (PST)
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com. [209.85.222.182])
        by smtp.gmail.com with ESMTPSA id r2-20020ae9d602000000b006cebda00630sm12844734qkk.60.2022.11.23.14.58.37
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Nov 2022 14:58:37 -0800 (PST)
Received: by mail-qk1-f182.google.com with SMTP id z17so4666qki.11
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Nov 2022 14:58:37 -0800 (PST)
X-Received: by 2002:ac8:44b9:0:b0:3a5:81ec:c4bf with SMTP id
 a25-20020ac844b9000000b003a581ecc4bfmr16610980qto.180.1669243994092; Wed, 23
 Nov 2022 14:53:14 -0800 (PST)
MIME-Version: 1.0
References: <166924370539.1772793.13730698360771821317.stgit@warthog.procyon.org.uk>
In-Reply-To: <166924370539.1772793.13730698360771821317.stgit@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 23 Nov 2022 14:52:58 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjq7gRdVUrwpQvEN1+um+hTkW8dZZATtfFS-fp9nNssRw@mail.gmail.com>
Message-ID: <CAHk-=wjq7gRdVUrwpQvEN1+um+hTkW8dZZATtfFS-fp9nNssRw@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] mm, netfs, fscache: Stop read optimisation when
 folio removed from pagecache
To:     David Howells <dhowells@redhat.com>
Cc:     Ilya Dryomov <idryomov@gmail.com>,
        Dave Wysochanski <dwysocha@redhat.com>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        Dominique Martinet <asmadeus@codewreck.org>,
        linux-mm@kvack.org, Rohith Surabattula <rohiths.msft@gmail.com>,
        v9fs-developer@lists.sourceforge.net, ceph-devel@vger.kernel.org,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        Matthew Wilcox <willy@infradead.org>,
        Steve French <sfrench@samba.org>,
        linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
        linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
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

On Wed, Nov 23, 2022 at 2:48 PM David Howells <dhowells@redhat.com> wrote:
>
>   I've also got rid of the bit clearances
> from the network filesystem evict_inode functions as they doesn't seem to
> be necessary.

Well, the patches look superficially cleaner to me, at least. That
"doesn't seem to be necessary" makes me a bit worried, and I'd have
liked to see a more clear-cut "clearing it isn't necessary because X",
but I _assume_ it's not necessary simply because the 'struct
address_space" is released and never re-used.

But making the lifetime of that bit explicit might just be a good idea.

             Linus
