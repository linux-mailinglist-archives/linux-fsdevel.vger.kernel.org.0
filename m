Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2AAB724BAB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Jun 2023 20:46:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239067AbjFFSqG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Jun 2023 14:46:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233789AbjFFSqF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Jun 2023 14:46:05 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83BE810CB;
        Tue,  6 Jun 2023 11:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
        bh=p+0nLSoJG17KKuiydwKjkEWK72qSSTBX227sDUKnkMI=; b=K8PQtgjHzFM8DsR8pdTrGnhVD2
        z/OYfEVC48yKut8wf6Nopa2FNs7aMyMSR1EpbfpI/r54+qbSB2Pw4GxeQxJaNXQClit6dBePXMvbv
        SiWVAkmZuBZcHKLlad7NRqmVtc6k/3LvY2Q0oei4CWLvLZr82F+ikRzih/Z3KirO1b6M7PK87axeR
        8bLPwahj/gRcWyWZHFvv23YgeMUyO7WGZXM6onH+v9iuibrPt52d1Rr4t/nZrIVOCk91CCVtUn5rd
        0588ctSoNdj4cxSLilu1LKMGFtHsF5072LwMPxAm5kh/Ul0folqF4paXyeLdgqTAnQfnd9cqBxR9G
        2Ye0363g==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q6bgf-002nx4-2g;
        Tue, 06 Jun 2023 18:45:45 +0000
Date:   Tue, 6 Jun 2023 11:45:45 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Paul Moore <paul@paul-moore.com>
Cc:     keescook@chromium.org, yzaikin@google.com, dhowells@redhat.com,
        jarkko@kernel.org, jmorris@namei.org, serge@hallyn.com,
        j.granados@samsung.com, brauner@kernel.org, ebiederm@xmission.com,
        patches@lists.linux.dev, linux-fsdevel@vger.kernel.org,
        keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] sysctl: move security keys sysctl registration to
 its own file
Message-ID: <ZH9+2WFsru1VMPqT@bombadil.infradead.org>
References: <20230530232914.3689712-1-mcgrof@kernel.org>
 <20230530232914.3689712-3-mcgrof@kernel.org>
 <CAHC9VhRA_XkkiZpg=d1RiME+VUYe7bsuV6pOpsseDRWfwV+q9A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhRA_XkkiZpg=d1RiME+VUYe7bsuV6pOpsseDRWfwV+q9A@mail.gmail.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 31, 2023 at 05:20:46PM -0400, Paul Moore wrote:
> On Tue, May 30, 2023 at 7:29 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
> >
> > The security keys sysctls are already declared on its own file,
> > just move the sysctl registration to its own file to help avoid
> > merge conflicts on sysctls.c, and help with clearing up sysctl.c
> > further.
> >
> > This creates a small penalty of 23 bytes:
> >
> > ./scripts/bloat-o-meter vmlinux.1 vmlinux.2
> > add/remove: 2/0 grow/shrink: 0/1 up/down: 49/-26 (23)
> > Function                                     old     new   delta
> > init_security_keys_sysctls                     -      33     +33
> > __pfx_init_security_keys_sysctls               -      16     +16
> > sysctl_init_bases                             85      59     -26
> > Total: Before=21256937, After=21256960, chg +0.00%
> >
> > But soon we'll be saving tons of bytes anyway, as we modify the
> > sysctl registrations to use ARRAY_SIZE and so we get rid of all the
> > empty array elements so let's just clean this up now.
> >
> > Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> > ---
> >  include/linux/key.h    | 3 ---
> >  kernel/sysctl.c        | 4 ----
> >  security/keys/sysctl.c | 7 +++++++
> >  3 files changed, 7 insertions(+), 7 deletions(-)
> 
> Ultimately I'll leave the ACK to David or Jarkko, but this looks
> reasonable to me.
> 
> Reviewed-by: Paul Moore <paul@paul-moore.com>

I've queued this onto sysctl-next as I haven't seen any complaints.
I can drop it if there are complaints or regressions reported by
folks on linux-next.

  Luis
