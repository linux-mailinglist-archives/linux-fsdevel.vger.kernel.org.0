Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 789F751BF48
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 May 2022 14:30:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376773AbiEEMeY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 May 2022 08:34:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376729AbiEEMeX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 May 2022 08:34:23 -0400
Received: from us-smtp-delivery-74.mimecast.com (us-smtp-delivery-74.mimecast.com [170.10.129.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C0C4A4B1F0
        for <linux-fsdevel@vger.kernel.org>; Thu,  5 May 2022 05:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651753842;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YlZT13jIA/It2oCfOEpEIe9Baj4YpyTZ8d0J7CEtWsQ=;
        b=GXYJxoTSpQUmj2x9+Vut+gqd5fiTMOYjvcziJsSjA/5dcEhRPYoClZs83Aie7MxMwP6NQ/
        MdaHf6z0MaR16Nc+hE1DhqWeYjFOqVNDe2+LHkj/J/AKQ5eGhMSGzZVWmA+RA79RbtNEqM
        52YJWsH57fe8sZV42EttaiBgcAbjo3A=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-343-0xIDvD5lPEWJE6D9hkjW7Q-1; Thu, 05 May 2022 08:30:39 -0400
X-MC-Unique: 0xIDvD5lPEWJE6D9hkjW7Q-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B60953810D27;
        Thu,  5 May 2022 12:30:38 +0000 (UTC)
Received: from ws.net.home (unknown [10.36.112.12])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 06CB8463E1C;
        Thu,  5 May 2022 12:30:35 +0000 (UTC)
Date:   Thu, 5 May 2022 14:30:33 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-fsdevel@vger.kernel.org, Dave Chinner <david@fromorbit.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Greg KH <gregkh@linuxfoundation.org>,
        Christian Brauner <brauner@kernel.org>,
        linux-kernel@vger.kernel.org,
        Linux API <linux-api@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>,
        LSM <linux-security-module@vger.kernel.org>,
        Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Amir Goldstein <amir73il@gmail.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>
Subject: Re: [RFC PATCH] getting misc stats/attributes via xattr API
Message-ID: <20220505123033.sgcyx7kfl4kcfcds@ws.net.home>
References: <YnEeuw6fd1A8usjj@miu.piliscsaba.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YnEeuw6fd1A8usjj@miu.piliscsaba.redhat.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 03, 2022 at 02:23:23PM +0200, Miklos Szeredi wrote:
> Examples:
> 
> $ getfattr -etext -n ":" .
> # file: .
> :="mnt:\000mntns:"
> 
> $ getfattr -etext -n ":mnt:" .
> # file: .
> :mnt:="info"
> 
> $ getfattr -etext -n ":mnt:info" .
> # file: .
> :mnt:info="21 1 254:0 / / rw,relatime - ext4 /dev/root rw\012"

Is there a way how to get mountinfo-like entry by mount ID for some
sub-tree? Something like:

 getfattr -etext -n ":mnt:info:21" /

The interface has to be consistent with some notification system (I
see your question about fsnotify/fanotify at linux-fsdevel) and mount
ID seems better than paths due to over-mounts, etc.

> $ getfattr -etext -n ":mntns:" .
> # file: .
> :mntns:="21:\00022:\00024:\00025:\00023:\00026:\00027:\00028:\00029:\00030:\00031:"
> 
> $ getfattr -etext -n ":mntns:28:" .
> # file: .
> :mntns:28:="info"

  Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

