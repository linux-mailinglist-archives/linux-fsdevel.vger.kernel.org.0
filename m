Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54E286EFEC5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Apr 2023 03:07:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242847AbjD0BHY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Apr 2023 21:07:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242796AbjD0BHU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Apr 2023 21:07:20 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AF3740DA;
        Wed, 26 Apr 2023 18:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=GvxnR8MPCmUoOfdv2T2CD0H/aNBye/VKFi19iEtdpXI=; b=OMroB+M3Nw2KHns0+C/KHJlqBO
        6rfNKp45iB/7FtK827V+jj0PbfEqMpJfViU6z0mHwPw+K+1lQE+ZlcHVySvn6t5ld9Okw5P2ci6qs
        gXkCnXFvKZDxWWtrkpjnRVINUIYHRSThyyjipxg6BZw/M+E2MehZKiOiJ7zc1aHc48nKKNqKK9Zzf
        wFtDX2lArpaEpGMObR4eMb3TFzHz8NTZWs4S9LKSAFkMSw9TNfKya26eJzgS2kQ6r7Cq6ij8YsymG
        tv4hFukD1F8xeIu75jg1dCn3PWyhLGSMnoMmEsplUczRSX/2BKPzloVdBobfxODMvfwEhgIDlgeoi
        T4wEfIAw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1prq6N-00D0lJ-32;
        Thu, 27 Apr 2023 01:07:16 +0000
Date:   Thu, 27 Apr 2023 02:07:15 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] pidfd updates
Message-ID: <20230427010715.GX3390869@ZenIV>
References: <20230421-kurstadt-stempeln-3459a64aef0c@brauner>
 <CAHk-=whOE+wXrxykHK0GimbNmxyr4a07kTpG8dzoceowTz1Yxg@mail.gmail.com>
 <20230425060427.GP3390869@ZenIV>
 <20230425-sturheit-jungautor-97d92d7861e2@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230425-sturheit-jungautor-97d92d7861e2@brauner>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 25, 2023 at 02:34:15PM +0200, Christian Brauner wrote:


> struct fd_file {
> 	struct file *file;
> 	int fd;
> 	int __user *fd_user;

Why is it an int?  Because your case has it that way?

We have a bunch of places where we have an ioctl with
a field in some structure filled that way; any primitive
that combines put_user() with descriptor handling is
going to cause trouble as soon as somebody deals with
a structure where such member is unsigned long.  Gets
especially funny on 64bit big-endian...

And that objection is orthogonal to that 3-member structure -
even if you pass int __user * as an explicit argument into
your helper, the same trouble will be there.

Al, still going through that zoo...
