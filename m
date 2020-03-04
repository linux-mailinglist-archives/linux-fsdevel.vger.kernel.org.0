Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83FFC17974E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Mar 2020 18:56:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730081AbgCDR4P (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Mar 2020 12:56:15 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32433 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729923AbgCDR4P (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Mar 2020 12:56:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583344574;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i1Cgn4yp7EaKnNlZymNOD5ifYaNSlnfx75qVUEAj3xM=;
        b=W97TUuPpyA/HiwsRLEmkj7Omy7Cnlam2mFAJGAMmvII4C9/mRcGYqaS4sLeTbq1GrO9K9h
        GlIZASUTdob8fPBuevzTF6twBaZsjqXX+ml1GL1vZqLtJ/g2A+hw630BjM6gHEZtoc4ISZ
        aTFV85wPE5dDbvXEN7ssV6/xf6In0pQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-203-7y7GWO5UPeCY2a9BNTDovA-1; Wed, 04 Mar 2020 12:56:10 -0500
X-MC-Unique: 7y7GWO5UPeCY2a9BNTDovA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D99F9801E76;
        Wed,  4 Mar 2020 17:56:07 +0000 (UTC)
Received: from ws.net.home (ovpn-204-202.brq.redhat.com [10.40.204.202])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 45A915C548;
        Wed,  4 Mar 2020 17:55:59 +0000 (UTC)
Date:   Wed, 4 Mar 2020 18:55:56 +0100
From:   Karel Zak <kzak@redhat.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Ian Kent <raven@themaw.net>, Miklos Szeredi <miklos@szeredi.hu>,
        David Howells <dhowells@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Steven Whitehouse <swhiteho@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Jann Horn <jannh@google.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 00/17] VFS: Filesystem information and notifications [ver
 #17]
Message-ID: <20200304175556.45dsgxumv4ubz7qy@ws.net.home>
References: <CAJfpegu0qHBZ7iK=R4ajmmHC4g=Yz56otpKMy5w-y0UxJ1zO+Q@mail.gmail.com>
 <0403cda7345e34c800eec8e2870a1917a8c07e5c.camel@themaw.net>
 <CAJfpegtu6VqhPdcudu79TX3e=_NZaJ+Md3harBGV7Bg_-+fR8Q@mail.gmail.com>
 <1509948.1583226773@warthog.procyon.org.uk>
 <CAJfpegtOwyaWpNfjomRVOt8NKqT94O5n4-LOHTR7YZT9fadVHA@mail.gmail.com>
 <20200303113814.rsqhljkch6tgorpu@ws.net.home>
 <20200303130347.GA2302029@kroah.com>
 <33d900c8061c40f70ba2b9d1855fd6bd1c2b68bb.camel@themaw.net>
 <20200304152241.iaiulvl5xisnuxp6@ws.net.home>
 <20200304164913.GB1763256@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20200304164913.GB1763256@kroah.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 04, 2020 at 05:49:13PM +0100, Greg Kroah-Hartman wrote:
> On Wed, Mar 04, 2020 at 04:22:41PM +0100, Karel Zak wrote:
> > $ strace -e openat,read,close -c ps aux
> > ...
> > % time     seconds  usecs/call     calls    errors syscall
> > ------ ----------- ----------- --------- --------- ----------------
> >  43.32    0.004190           4       987           read
> >  31.42    0.003039           3       844         4 openat
> >  25.26    0.002443           2       842           close
> > ------ ----------- ----------- --------- --------- ----------------
> > 100.00    0.009672                  2673         4 total
> >=20
> > $ strace -e openat,read,close -c lsns
> > ...
> > % time     seconds  usecs/call     calls    errors syscall
> > ------ ----------- ----------- --------- --------- ----------------
> >  39.95    0.001567           2       593           openat
> >  30.93    0.001213           2       597           close
> >  29.12    0.001142           3       365           read
> > ------ ----------- ----------- --------- --------- ----------------
> > 100.00    0.003922                  1555           total
> >=20
> >=20
> > $ strace -e openat,read,close -c lscpu
> > ...
> > % time     seconds  usecs/call     calls    errors syscall
> > ------ ----------- ----------- --------- --------- ----------------
> >  44.67    0.001480           7       189        52 openat
> >  34.77    0.001152           6       180           read
> >  20.56    0.000681           4       140           close
> > ------ ----------- ----------- --------- --------- ----------------
> > 100.00    0.003313                   509        52 total
>=20
> As a "real-world" test, would you recommend me converting one of the
> above tools to my implementation of readfile to see how/if it actually
> makes sense, or do you have some other tool you would rather see me try=
?

See lib/path.c and lib/sysfs.c in util-linux (https://github.com/karelzak=
/util-linux).=20
For example ul_path_read() and ul_path_scanf().=20

We use it for lsblk, lsmem, lscpu, etc.

=A0$ git grep -c ul_path_read misc-utils/lsblk.c sys-utils/lscpu.c
 misc-utils/lsblk.c:30
 sys-utils/lscpu.c:31

We're probably a little bit off-topic here, no problem to continue on
util-linux@vger.kernel.org or by private mails. Thanks!

    Karel

--=20
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

