Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BE09741823
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jun 2023 20:42:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230219AbjF1SmN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Jun 2023 14:42:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjF1SmL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Jun 2023 14:42:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE5C410F5;
        Wed, 28 Jun 2023 11:42:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 639856142A;
        Wed, 28 Jun 2023 18:42:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41A4BC433C8;
        Wed, 28 Jun 2023 18:42:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687977728;
        bh=s+CFIQ47Nde7laYIREkJnwD6OP0zOQzRI431me7l5hM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r96QzmwlwrrCKx+UBddlEPORTg571sdls578CN138pCbKjYbvVHbeEwBB+YEI/Pi3
         WWYvoqWWWCuimtfQ3WjeWhwNlwhF0KtCIqtOaP+XN9kppPSgPqyU8jfWo84XdQyr5Y
         PqlZT3ZXZgVIDHeStH6VizDAk1Xy0Qovl+03GMwI=
Date:   Wed, 28 Jun 2023 20:42:05 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Tejun Heo <tj@kernel.org>, Christian Brauner <brauner@kernel.org>,
        peterz@infradead.org, lujialin4@huawei.com,
        lizefan.x@bytedance.com, hannes@cmpxchg.org, mingo@redhat.com,
        ebiggers@kernel.org, oleg@redhat.com, akpm@linux-foundation.org,
        viro@zeniv.linux.org.uk, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH 1/2] kernfs: add kernfs_ops.free operation to free
 resources tied to the file
Message-ID: <2023062845-stabilize-boogieman-1925@gregkh>
References: <CAJuCfpG2_trH2DuudX_E0CWfMxyTKfPWqJU14zjVxpTk6kPiWQ@mail.gmail.com>
 <ZJuSzlHfbLj3OjvM@slm.duckdns.org>
 <CAJuCfpGoNbLOLm08LWKPOgn05+FB1GEqeMTUSJUZpRmDYQSjpA@mail.gmail.com>
 <20230628-meisennest-redlich-c09e79fde7f7@brauner>
 <CAJuCfpHqZ=5a_2k==FsdBbwDCF7+s7Ji3aZ37LBqUgyXLMz7gA@mail.gmail.com>
 <20230628-faden-qualvoll-6c33b570f54c@brauner>
 <CAJuCfpF=DjwpWuhugJkVzet2diLkf8eagqxjR8iad39odKdeYQ@mail.gmail.com>
 <20230628-spotten-anzweifeln-e494d16de48a@brauner>
 <ZJx1nkqbQRVCaKgF@slm.duckdns.org>
 <CAJuCfpEFo6WowJ_4XPXH+=D4acFvFqEa4Fuc=+qF8=Jkhn=3pA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpEFo6WowJ_4XPXH+=D4acFvFqEa4Fuc=+qF8=Jkhn=3pA@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 28, 2023 at 11:18:20AM -0700, Suren Baghdasaryan wrote:
> On Wed, Jun 28, 2023 at 11:02 AM Tejun Heo <tj@kernel.org> wrote:
> >
> > On Wed, Jun 28, 2023 at 07:35:20PM +0200, Christian Brauner wrote:
> > > > To summarize my understanding of your proposal, you suggest adding new
> > > > kernfs_ops for the case you marked (1) and change ->release() to do
> > > > only (2). Please correct me if I misunderstood. Greg, Tejun, WDYT?
> > >
> > > Yes. I can't claim to know all the intricate implementation details of
> > > kernfs ofc but this seems sane to me.
> >
> > This is going to be massively confusing for vast majority of kernfs users.
> > The contract kernfs provides is that you can tell kernfs that you want out
> > and then you can do so synchronously in a finite amount of time (you still
> > have to wait for in-flight operations to finish but that's under your
> > control). Adding an operation which outlives that contract as something
> > usual to use is guaranteed to lead to obscure future crnashes. For a
> > temporary fix, it's fine as long as it's marked clearly but please don't
> > make it something seemingly widely useable.
> >
> > We have a long history of modules causing crashes because of this. The
> > severing semantics is not there just for fun.
> 
> I'm sure there are reasons things are working as they do today. Sounds
> like we can't change the ->release() logic from what it is today...
> Then the question is how do we fix this case needing to release a
> resource which can be released only when there are no users of the
> file? My original suggestion was to add a kernfs_ops operation which
> would indicate there are no more users but that seems to be confusing.
> Are there better ways to fix this issue?

Just make sure that you really only remove the file when all users are
done with it?  Do you have control of that from the driver side?

But, why is this kernfs file so "special" that it must have this special
construct?  Why not do what all other files that handle polling do and
just remove and get out of there when done?

thanks,

greg k-h
