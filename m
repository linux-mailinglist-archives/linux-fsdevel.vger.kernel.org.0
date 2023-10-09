Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A767D7BEA27
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Oct 2023 20:53:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378233AbjJISxV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Oct 2023 14:53:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378237AbjJISxT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Oct 2023 14:53:19 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AFE6B4;
        Mon,  9 Oct 2023 11:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=B+aCRv+cYfcjMprkaIjsVznZpDwZanWLGMURzn+VRao=; b=M+xQB3qSAS3zQPFeJiJlUv0jLd
        MAGDkccQTEr3MLwGXKgDPSdN+CHP0fP6ljdlspEf0Scw8HnE77un3TLK8zTvLO1rCCFS7qM8+V8zm
        DcDSC8pjNYvcgw88r8zE03y/QbWK7z3EjzM+dvOgay3df+Bz5Wu4m6BOZQD6xE9OrI4cTKCld9xUU
        bKC3B1YeRijMtciU+WPauzMQfTkeX5WG1/7zuAbu3fnU8IB93EJyq33u5RCzAAE4rMFYrlvEKoMH7
        P7EgWTNC+Jkc3oG4Qt7lpLEvxQnpvF4ya6GgynzNmiFdUMA+nkRkYvIfrk78QtDd582Q8UJopOrTJ
        anU0spQg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qpvNL-00HHRV-2f;
        Mon, 09 Oct 2023 18:53:08 +0000
Date:   Mon, 9 Oct 2023 19:53:07 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-unionfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] fs: store real path instead of fake path in
 backing file f_path
Message-ID: <20231009185307.GI800259@ZenIV>
References: <20231007084433.1417887-1-amir73il@gmail.com>
 <20231007084433.1417887-4-amir73il@gmail.com>
 <20231009074809.GH800259@ZenIV>
 <CAOQ4uxhSEDF8G8_7Zr+OnMq7miNen6O=AXQV1-xAs7ABvXs0Mg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxhSEDF8G8_7Zr+OnMq7miNen6O=AXQV1-xAs7ABvXs0Mg@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 09, 2023 at 11:25:38AM +0300, Amir Goldstein wrote:

> It's not important. I don't mind dropping it.
> 
> If you dislike that name f_path(), I guess you are not a fan of
> d_inode() either...

In case of d_inode() there's an opposition between d_inode() and
d_inode_rcu(), and that bears useful information.  In case of
f_path()...

> FYI, I wanted to do a file_path() accessor to be consistent with
> file_inode() and file_dentry(), alas file_path() is used for something
> completely different.
> 
> I find it confusing that {file,dentry,d}_path() do not return a path
> but a path string, but whatever.

*blink*

How would one possibly produce struct path (i.e. mount/dentry pair)
out of dentry?

Anyway, I admit that struct path hadn't been a great name to start with;
it's basically "location in namespace", and it clashes with the use of
the same word for "string interpreted to get a location in namespace".

Originally it's been just in the pathname resolution internals; TBH,
I don't remember I had specific plans regarding converting such
pairs (a plenty of those in the tree at the time) back then.
<checks the historical tree>
<checks old mail archives>

Probably hopeless to reconstruct the details, I'm afraid - everything
else aside, the timestamps in that patch are in the first half of
the day on Apr 29 2002; (hopefully) tested and sent out at about
6pm.  Followed by sitting down for birthday celebration, of all things,
so the details of rationale for name choice would probably be hard
to recover on the next morning, nevermind 21 years later ;-)

Bringing it out of fs/namei.c (into include/linux/namei.h) had happened
in late 2006 (by Jeff Sipek) and after that it was too late to change
the name; I'm still not sure what name would be good for that, TBH...
