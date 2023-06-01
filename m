Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ACD171EF2A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Jun 2023 18:35:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231758AbjFAQe0 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>); Thu, 1 Jun 2023 12:34:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231732AbjFAQeZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Jun 2023 12:34:25 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5E911B7
        for <linux-fsdevel@vger.kernel.org>; Thu,  1 Jun 2023 09:34:05 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-118-HGYaWkwuPHeTz2fi0dWn6Q-1; Thu, 01 Jun 2023 17:34:02 +0100
X-MC-Unique: HGYaWkwuPHeTz2fi0dWn6Q-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 1 Jun
 2023 17:33:58 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Thu, 1 Jun 2023 17:33:58 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Jan Kara' <jack@suse.cz>
CC:     Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Miklos Szeredi" <miklos@szeredi.hu>,
        "Darrick J. Wong" <djwong@kernel.org>, Ted Tso <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH v2 4/6] fs: Establish locking order for unrelated
 directories
Thread-Topic: [PATCH v2 4/6] fs: Establish locking order for unrelated
 directories
Thread-Index: AQHZlJ1FZufsO2GDRE+EhxV9kbhF9692EqgQ///7d4CAABPFwA==
Date:   Thu, 1 Jun 2023 16:33:58 +0000
Message-ID: <eb70760399ae4222904c62c64dc529b6@AcuMS.aculab.com>
References: <20230601104525.27897-1-jack@suse.cz>
 <20230601105830.13168-4-jack@suse.cz>
 <20230601-gebracht-gesehen-c779a56b3bf3@brauner>
 <20230601152449.h4ur5zrfqjqygujd@quack3>
 <c5f209a6263b4f039c5eafcafddf90ca@AcuMS.aculab.com>
 <20230601161353.4o6but7hb7i7qfki@quack3>
In-Reply-To: <20230601161353.4o6but7hb7i7qfki@quack3>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Jan Kara <jack@suse.cz>
> Sent: 01 June 2023 17:14
> 
> On Thu 01-06-23 15:37:32, David Laight wrote:
> > ...
> > > > > + * Lock any non-NULL argument. The caller must make sure that if he is passing
> > > > > + * in two directories, one is not ancestor of the other
> >
> > Not directly relevant to this change but is the 'not an ancestor'
> > check actually robust?
> >
> > I found a condition in which the kernel 'pwd' code (which follows
> > the inode chain) failed to stop at the base of a chroot.
> >
> > I suspect that the ancestor check would fail the same way.
> 
> Honestly, I'm not sure how this could be the case but I'm not a dcache
> expert. d_ancestor() works on dentries and the whole dcache code pretty
> much relies on the fact that there always is at most one dentry for any
> directory. Also in case we call d_ancestor() from this code, we have the
> whole filesystem locked from any other directory moves so the ancestor
> relationship of two dirs cannot change (which is different from pwd code
> AFAIK). So IMHO no failure is possible in our case.

I've found the test program.
This uses readlinkat() to get the full path /proc/self/fd/0.
It should be inside the chroot, but the comparison done
to detect the 'root' fails.

Now maybe any rename that would hit this is invalid
for other reasons.
But something is awry somewhere.

	David

The program below reproduces this when run with stdin
redirected to a file in the current directory.

This sequence is used by 'ip netns exec' so isn't actually
that unusual.

	David

#define _GNU_SOURCE
#include <unistd.h>
#include <stdio.h>
#include <fcntl.h>
#include <sched.h>

static void print_link(const char *where, int fd)
{
        char buf[256];

        printf("%s: %.*s\n", where, (int)readlinkat(fd, "", buf, sizeof buf), buf);
}

int main(int argc, char **argv)
{
        int link_fd = open("/proc/self/fd/0", O_PATH | O_NOFOLLOW);

        print_link("initial", link_fd);
        if (chroot("."))
                return 1;
        print_link("after chroot", link_fd);
        if (unshare(CLONE_NEWNS))
                return 2;
        print_link("after unshare", link_fd);
        return 0;
}

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

