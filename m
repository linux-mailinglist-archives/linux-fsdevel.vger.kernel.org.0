Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E245B62E68A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Nov 2022 22:12:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240811AbiKQVMo convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Nov 2022 16:12:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240812AbiKQVMe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Nov 2022 16:12:34 -0500
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2117382229;
        Thu, 17 Nov 2022 13:12:21 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 8CA4761989E3;
        Thu, 17 Nov 2022 22:12:19 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id d-zAxFCwh7Pk; Thu, 17 Nov 2022 22:12:19 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 2887261989E9;
        Thu, 17 Nov 2022 22:12:19 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id hR5BjxVRxsZc; Thu, 17 Nov 2022 22:12:19 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id F18F461989E3;
        Thu, 17 Nov 2022 22:12:18 +0100 (CET)
Date:   Thu, 17 Nov 2022 22:12:18 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        chuck lever <chuck.lever@oracle.com>, anna@kernel.org,
        trond myklebust <trond.myklebust@hammerspace.com>,
        Al Viro <viro@zeniv.linux.org.uk>, raven@themaw.net,
        chris chilvers <chris.chilvers@appsbroker.com>,
        david young <david.young@appsbroker.com>,
        luis turcitu <luis.turcitu@appsbroker.com>,
        david <david@sigma-star.at>
Message-ID: <1805608101.252119.1668719538854.JavaMail.zimbra@nod.at>
In-Reply-To: <f31d4114f363ed9de0eba66ad6a730fe013896a6.camel@kernel.org>
References: <20221117191151.14262-1-richard@nod.at> <20221117191151.14262-3-richard@nod.at> <f31d4114f363ed9de0eba66ad6a730fe013896a6.camel@kernel.org>
Subject: Re: [PATCH 2/3] fs: namei: Allow follow_down() to uncover auto
 mounts
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: namei: Allow follow_down() to uncover auto mounts
Thread-Index: aBlkW2rl/QPMsRC8nFnJYOSn+cSNFg==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

----- Ursprüngliche Mail -----
> Von: "Jeff Layton" <jlayton@kernel.org>
> What happens when CROSSMOUNT isn't enabled and someone tries to stroll
> into an automount point? I'm guessing the automount happens but the
> export is denied? 

Exactly.

On the other hand, why should knfsd not trigger automounts?
Almost any userspace interaction would also do so.

> It seems like LOOKUP_AUTOMOUNT ought to be conditional
> on the parent export having CROSSMOUNT set.
> 
> There's also another caller of follow_down too, the UNIX98 pty code.
> This may be harmless for it, but it'd be best not to perturb that if we
> can help it.
> 
> Maybe follow_down can grow a lookupflags argument?

So, in nfsd_cross_mnt() the follow_down() helper should use LOOKUP_AUTOMOUNT only
if exp->ex_flags & NFSEXP_CROSSMOUNT is true?
Sounds sane, thanks for the pointer.

Thanks,
//richard
