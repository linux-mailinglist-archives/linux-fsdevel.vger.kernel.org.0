Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 775BB68AA51
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 Feb 2023 14:41:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232848AbjBDNlI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 4 Feb 2023 08:41:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231355AbjBDNlI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 4 Feb 2023 08:41:08 -0500
Received: from kylie.crudebyte.com (kylie.crudebyte.com [5.189.157.229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF3FF12040;
        Sat,  4 Feb 2023 05:41:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        Content-ID:Content-Description;
        bh=10v4qs2VYl5bLPi39w3LIpFFCfv3YmEZ+W1sESvpjNk=; b=cem4t6wIDRR2F8GwbUjY8nvuPv
        gjgJ7dsVLDNDO1f3q48o2JE610ll5dmJHffLa1V/OKpK7grOpaSwyLTWdS+Q5GpbOdRFuUTDsf68o
        dqYZ9UQ2ZMwK/+TShD1YtZ85oTV92W1nmqpsWETajnMrnhKmIl084X43kOEavOrsuHD51VrkCbm8D
        yOVPoXZx5d3lCLyj2ESF8cWCj2kVQmBx55ZpxgLlRSMRF/5b7jFWNtDR68s9L4UvFRmAqTZmvbF9j
        a1m1EZYG5bIYp9I/eipLKNpJAtE9DFgsg2f/JYitbHXOffj6mWSaQDoZsT5mRAAzIFWb0EpBtO20d
        RuDKd/2npegh/sy61DTY7gqKsx8moAhmuIR7YAxjkM0QoCpfdhOgE/jqxD5vdYwzIGvuLvw4y+FJe
        /5P6irUxoF5VRFc7ngqVWOAM68zzQabw0SPhVBpIedmnyCvyNIOR9EhB0+7bvVnrACICEmtoAyKWL
        r4Uug+yExBAiywY4j9yrdAX3w+1wpligSgY45cGDl91ISV8Q9wgrRRTnNRB8JE7B+kV10vfTdrKW+
        6AjvBrUrCuzMZJX74+7Cidsl7hhL85KOmKfOuRFyIRL2h/hGs+XAA3mRjcpnFXBCu7cDcjzWIbMDZ
        PJ/jSPtvulaqnyLD2MRggK3v6XEfoO4S+x+yNPxlg=;
From:   Christian Schoenebeck <linux_oss@crudebyte.com>
To:     Eric Van Hensbergen <ericvh@gmail.com>
Cc:     v9fs-developer@lists.sourceforge.net, asmadeus@codewreck.org,
        rminnich@gmail.com, lucho@ionkov.net,
        Eric Van Hensbergen <ericvh@kernel.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 00/11] Performance fixes for 9p filesystem
Date:   Sat, 04 Feb 2023 14:40:42 +0100
Message-ID: <1675519496.NcNzUn7KHO@silver>
In-Reply-To: <CAFkjPTk=OwqKksY5AYzW4UOzKTbhg-GeWvVQtr0d_SU-F2GZQw@mail.gmail.com>
References: <20221218232217.1713283-1-evanhensbergen@icloud.com>
 <2302787.WOG5zRkYfl@silver>
 <CAFkjPTk=OwqKksY5AYzW4UOzKTbhg-GeWvVQtr0d_SU-F2GZQw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Friday, February 3, 2023 8:12:14 PM CET Eric Van Hensbergen wrote:
> Hi Christian, thanks for the feedback -- will dig in and see if I can
> find what's gone south here.  Clearly my approach to writeback without
> writeback_fid didn't cover all the corner cases and thats the cause of
> the fault.  Can I get a better idea of how to reproduce - you booted
> with a root 9p file system, and then tried to build...what?

KDE, which builds numerous packages, multi-threaded by default. In the past we
had 9p issues which triggered only after hours of compiling, however in this
case I don't think that you need to build something fancy. Because it already
fails at the very beginning of any build process, just when detecting a
compiler.

May I ask what kind of scenario you have tested so far? It was not a multi-
threaded context, right? Large chunk or small chunk I/O?

> Performance degradation is interesting, runs counter to the
> unit-testing and benchmarking I did, but I didn't do something as
> logical as a build to check -- need to tease apart whether this is a
> read problem, a write problem...or both.  My intuition is that its on
> the write side, but as part of going through the code I made the cache
> code a lot more pessimistic so its possible I inadvertently killed an
> optimistic optimization.

I have not walked down the road to investigate individual I/O errors or even
their cause yet, but from my feeling it could also be related to fid vs.
writeback_fid. I saw you dropped a fix we made there last year, but haven't
checked yet whether your changes would handle it correctly in another way.

> Finally, just to clarify, the panic you had at the end happened with
> readahead?  Seems interesting because clearly it thought it was
> writing back something that it shouldn't have been writing back (since
> writeback caches weren't enabled).   I'm thinking something was marked
> as dirty even though the underlying system just wrote-through the
> change and so the writeback isn't actually required.  This may also be
> an indicator of the performance issue if we are actually writing
> through the data in addition to an unnecessary write-back (which I
> also worry is writing back bad data in the second case).

It was not a kernel panic. It's a warning that appears right after boot, but
the system continues to run. So that warning is printed before starting the
actual build process. And yes, the warning is printed with "readahead".

> Can you give me an idea of what the other misbehaviors were?

There were really all sorts of misbheaviour on application level, e.g. no
command history being available from shell (arrow up/down), things hanging on
the shell for a long time, error messages. And after the writeahead test the
build directory was screwed, i.e. even after rebooting with a regular kernel
things no longer built correctly, so I had to restore a snapshot.

Best regards,
Christian Schoenebeck


