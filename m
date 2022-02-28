Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32DFC4C7D1E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Feb 2022 23:13:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231221AbiB1WOe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Feb 2022 17:14:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbiB1WOd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Feb 2022 17:14:33 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCE2CE1B70;
        Mon, 28 Feb 2022 14:13:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=G0MtIsznwG9khRdl3ndZkwzW71CEQBHvFDYqrGZuMxM=; b=GGre4MUoXYgIWCQWdJit6ED7HX
        kFJvByGRO2oV67MEgxejN0reGj2/C5LkWufLSncE68M/p3QM+hZbvpWGBwUPkqarG0otk+gBPO3z4
        vaavxlbmyzfdLx8QKV2lcLC5WpYprKeP6Y4Jkqf3cZHVItAZ60wgKjEJinHxqeJGqnEhHT3qB269k
        1lBVgYeLBWydoRd31sTufPtGGFJPK2Mpf0O8413NNmnGlHq2m3bVTbJDUn+cu9ZQgF1ILeaGHD2Pa
        H2cxN9MlExPrjCgVKUkz51oyXUtTvP27HtKouWfIWWOhACEZBpZvveEtW7QaQ4V8ggASEhLffoavN
        GtcQ912A==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nOoH9-00EHLV-Hv; Mon, 28 Feb 2022 22:13:51 +0000
Date:   Mon, 28 Feb 2022 14:13:51 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Steven Whitehouse <swhiteho@redhat.com>
Cc:     lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, Steve French <stfrench@microsoft.com>,
        Samuel Cabrero <scabrero@suse.de>,
        David Teigland <teigland@redhat.com>,
        Namjae Jeon <namjae.jeon@samsung.com>,
        Josef Bacik <josef@toxicpanda.com>, dhowells@redhat.com
Subject: Re: [LSF/MM/BPF TOPIC] are we going to use ioctls forever?
Message-ID: <Yh1JH/KwjrManw0j@bombadil.infradead.org>
References: <20220201013329.ofxhm4qingvddqhu@garbanzo>
 <8eb568cc9a440513e595835a56c78fdd03b5f2a9.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8eb568cc9a440513e595835a56c78fdd03b5f2a9.camel@redhat.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 02, 2022 at 10:39:46AM +0000, Steven Whitehouse wrote:
> I think it depends very much on what the interface is, as to which of
> the available APIs (or even creating a new one) is the most appropriate
> option.
> 
> Netlink was investigated a little while back as a potential interface
> for filesystem notifications. The main reason for this is that it
> solves one of the main issues there, which is the potentially unbounded
> number of notifications that might be issued into a queue of finite
> capacity. Netlink was originally designed for network routing messages
> which have a similar issue. As such a mechanism was built in to allow
> dropping of messages when the queue overflows, but in a way that it is
> known that this has happened, so one can then resync from the kernel's
> information. For things such as mount notifications, which can be
> numerous in various container scenarios, this is an important
> requirement.

Got it, this helps thanks. Curious if it was looked into if there
could be an option where the drops *cannot* happen. Just curious.

> However, it is also clear that netlink has some disadvantages too. The
> first of these is that it is aligned to the network subsystem in terms
> of namespaces. Since the kernel has no concept of a container per se,
> the fact that netlink is in the network namespace rather than the
> filesystem namespace makes using it with filesystems more difficult.

OK thanks for sharing this, so what makes it difficult exactly?
What was not possible, other than this indeed beign really odd?

> Another issue is that netlink has gained a number of additional
> features and layers over the years, leading to some overhead that is
> perhaps not needed in applications on the filesystem side.

Curious if not netlink but generic netlink was evaluated?

> That is why, having carefully considered the options David Howells
> created a new interface for the notifications project. It solves the
> problems mentioned above, while still retaining the advantages or being
> able to deal with producer/consumer problems.

I see.

> I'm not sure from the original posting though exactly which interfaces
> you had in mind when proposing this topic. Depending on what they are
> it is possible that another solution may be more appropriate. I've
> included the above mostly as a way to explain what has already been
> considered in terms of netlink pros/cons for one particular
> application,

Yes thanks this helps a lot! I knew we had beers over this years ago,
and I think we both seemed stunned no alternatives were in sight then.

  Luis
