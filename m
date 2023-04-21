Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F6186EB182
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Apr 2023 20:21:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232681AbjDUSVm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Apr 2023 14:21:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232739AbjDUSVf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Apr 2023 14:21:35 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4817D2D51
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Apr 2023 11:21:28 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 33LIKDJ5012294
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Apr 2023 14:20:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1682101217; bh=iEkJZNbbn2+rcQzyVVWhPqOsJjmE4U6M5Uh3JgWMgHM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=OQxiIb5vjQ7L+dJq6P+Y8UrvnG49NnZ7b2UJ11crvw/DX36cgH6S5v0OU4swRrLtI
         oXh96dMteXUJaHkQYMHkiD7gcBdE2yoT53pDj9TzTltUvr8eRqml1piRKEHedSYb74
         eOCrkpZ+RDUqoeG9RPqVATJvRKQfVJDr2BDqoonZA8r2euA1A9XdrpIkvLqNtHxsv5
         DnP8g/oNJPx4PlahRzuosmmDXWvcyJw+WKXd0OwE4rBfrl1eVw9NbJsY4MWIrX7Ajw
         bannYGoP/UZtEdY/gZLuBHw5a6jk6JDVpwhjg0KmNg0k664AuszCdosgl2yehkqaM5
         c6kB2DSVI0JSA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 23FCA15C3448; Fri, 21 Apr 2023 14:20:13 -0400 (EDT)
Date:   Fri, 21 Apr 2023 14:20:13 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Mike Christie <michael.christie@oracle.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+c2de99a72baaa06d31f3@syzkaller.appspotmail.com>,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, llvm@lists.linux.dev, nathan@kernel.org,
        ndesaulniers@google.com, syzkaller-bugs@googlegroups.com,
        trix@redhat.com, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, martin.lau@linux.dev,
        bpf <bpf@vger.kernel.org>, KP Singh <kpsingh@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Christian Brauner <brauner@kernel.org>
Subject: Re: [syzbot] [ext4?] [mm?] KCSAN: data-race in strscpy / strscpy (3)
Message-ID: <20230421182013.GA19035@mit.edu>
References: <000000000000b9915d05f9d98bdd@google.com>
 <CACT4Y+a3J0Z2PThebH6UaUWchKLWec8qApuv1ezYGKjf67Xctg@mail.gmail.com>
 <ZEKko6U2MxfkXgs5@casper.infradead.org>
 <13d484d3-d573-cd82-fff0-a35e27b8451e@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13d484d3-d573-cd82-fff0-a35e27b8451e@oracle.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 21, 2023 at 12:40:45PM -0500, Mike Christie wrote:
> 
> I didn't see the beginning of this thread and I think the part of the
> sysbot report that lists the patches/trees being used got cut off so
> I'm not 100% sure what's in the kernel.

Syzbot reported this on commit 76f598ba7d8e which is upstream after v6.3-rc6.

Cheers,

						- Ted
