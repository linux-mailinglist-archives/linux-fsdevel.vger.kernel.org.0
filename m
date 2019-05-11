Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80B821A850
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 May 2019 17:49:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728655AbfEKPtl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 11 May 2019 11:49:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:50478 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728618AbfEKPtl (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 11 May 2019 11:49:41 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 12BE4AFF1;
        Sat, 11 May 2019 15:49:38 +0000 (UTC)
Date:   Sun, 12 May 2019 01:49:23 +1000
From:   Aleksa Sarai <asarai@suse.de>
To:     Christian Brauner <christian@brauner.io>
Cc:     Jann Horn <jannh@google.com>, Andy Lutomirski <luto@kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Arnd Bergmann <arnd@arndb.de>,
        David Howells <dhowells@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Tycho Andersen <tycho@tycho.ws>,
        David Drysdale <drysdale@google.com>,
        Chanho Min <chanho.min@lge.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Subject: Re: [PATCH v6 5/6] binfmt_*: scope path resolution of interpreters
Message-ID: <20190511154923.z5woxv4dqperuqty@mikami>
References: <20190506165439.9155-1-cyphar@cyphar.com>
 <20190506165439.9155-6-cyphar@cyphar.com>
 <CAG48ez0-CiODf6UBHWTaog97prx=VAd3HgHvEjdGNz344m1xKw@mail.gmail.com>
 <20190506191735.nmzf7kwfh7b6e2tf@yavin>
 <20190510204141.GB253532@google.com>
 <CALCETrW2nn=omqJb4p+m-BDsCOhg+YZQ3ELd4BdhODV3G44gfA@mail.gmail.com>
 <20190510225527.GA59914@google.com>
 <CAHrFyr5vjTZfgtMsHwr6iwVVFxVsU3UCOiEq=FM-rjr0kPGHUw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="borziu3c5eych3ip"
Content-Disposition: inline
In-Reply-To: <CAHrFyr5vjTZfgtMsHwr6iwVVFxVsU3UCOiEq=FM-rjr0kPGHUw@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--borziu3c5eych3ip
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-05-11, Christian Brauner <christian@brauner.io> wrote:
> > In my opinion, the problems here are:
> >
> >  - Apparently some people run untrusted containers without user
> >    namespaces. It would be really nice if people could not do that.
> >    (Probably the biggest problem here.)
>
> I know I sound like a broken record since I've been going on about this
> forever together with a lot of other people but honestly,
> the fact that people are running untrusted workloads in privileged contai=
ners
> is the real issue here.

I completely agree. It's a shit-show, and it's caused by bad defaults in
Docker and (now) podman. To be fair, they both now support rootless
containers but the default is still privileged containers.

They do support user namespaces (though it should be noted that LXD's
support is much nicer from a security standpoint) but unless it's the
default the support is almost pointless. In the case of Docker it can
lead to some usability issues when you enable it (which I believe is the
main justification for it not being the default).

> Aleksa is a good friend of mine and we have discussed this a lot so I hope
> he doesn't hate me for saying this again: it is crazy that there are cont=
ainer
> runtimes out there that promise (or at least do not state the opposite)
> containers without user namespaces or containers with user namespaces
> that allow to map the host root id to anything can be safe. They cannot.

Yeah, the fact that we (runc) don't scream from the rooftops that this
setup is insecure is definitely a problem. I have mentioned this
whenever I've had a chance, but the fact that the most popular runtimes
(which use runc) don't use user namespaces compounds the issue. I'm
willing to bet that >90% of users of runc-based runtimes don't use user
namespaces at all, and this is all down to bad defaults.

There are also some other misfeatures we have in runc that we're
basically forced to support because some users use them, and we can't
really break entire projects (even though it's the projects' fault they
have an insecure setup).

> It seems to me to be heading in the wrong direction to keep up the
> illusion that with enough effort we can make this all nice and safe.
> Yes, the userspace memfd hack we came up with is as ugly as a security
> patch can be but if you make promises you can't keep you better be
> prepared to pay the price when things start to fall apart.

> So if this part of the patch is just needed to handle this do we really
> want to do all that tricky work or is there more to gain from this that
> makes it worth it.

I dropped this patch in v7, I don't think it's required for the
overarching feature. Looking back on it, it doesn't make much sense
given the context that privileged containers are unsafe in the first
place.

I do think that being able to block introspection might be a useful
hardening feature though. During attachment it would be nice to be sure
that nothing will be able to touch the attaching process's /proc/$pid --
even itself.

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--borziu3c5eych3ip
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEXzbGxhtUYBJKdfWmnhiqJn3bjbQFAlzW7wAACgkQnhiqJn3b
jbR3bxAAnM8LJPMf2Pan3q301DdRUniZUy671tYDuLAvqlkzeM+iitQn3MFlLSwS
/vr4dbITCJIWK8vnSv4W2E1o8MJdiVuKRXQHvFUUGwm4UEyjmr7OXE5ExqD4nGUl
BsaJeOUjmIJ18qnQGC3fcbxki14L7320aswV0bkylxulAJlzoK35Uerc5gp6rzrn
zjXlcmTguykS8HgZrg+F0Dx2SfSH0au28EOTpxe9Go/Y4PcuVc5qWn4A3rZW+mLQ
bGffGaYxpuubJku7mQW+fg8NZjMKCIl72abGAQkEoVQGLDuu9Wpgk8cmBHSrVB9l
OIANqypYyJw8SBlL75aWXAKLDfBhkxmF9TyFBLvUuMNNWqibbx518saj2/jbgke6
medifvB7Fq+RpBdJXhAeFemhZnXf3MlF16o55N7XfEt+J9TBMH8YsbdOv8tlZwFQ
sipQ9+ADbAk7qVRXXmrkrO7Ne359DKZfT7csyXFzwbRBJLyVUdlqsw3hAJIBeaGB
UyLf0JxF0P2qZ0QSptixnjPp9gnvh1XL/NyzhFPDbUHXF1vJ/BdzmcTBi/s6O+gm
pEIWxNjSY1c/wsE7w1ZJUaXwo7ePeGsbyGX+UjDQ4gbYVEnfDoHfNAjWeFeQKEjh
u2n1yLOFsuBZLlwZuUPsTKB02EUGMneVoc4JUPOCB+zSKN9LBRE=
=SjiX
-----END PGP SIGNATURE-----

--borziu3c5eych3ip--
