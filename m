Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14ABC740508
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jun 2023 22:34:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231374AbjF0UeK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jun 2023 16:34:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbjF0UeJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jun 2023 16:34:09 -0400
Received: from tarta.nabijaczleweli.xyz (unknown [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 511B110D2;
        Tue, 27 Jun 2023 13:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202305; t=1687898047;
        bh=vUpdtU2Ao1ydms6+mJ8c4hgKJfdNz9Hua1xyEJqhDBg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G+pfLazKygVutc+pvB/cTfe5o40vg6d7Xm+C0692qqzPFEs3HY+r5aGX2nwMRcBgX
         M/wZ2/T1QzGLtf81d7KL4AXvlGwiI2AoUf0fYALSQOo4qnA7cf71eKdQ+vWOMkCbHx
         YSA7i1mWfm5j1KocYM80RF/LVc2G6dFLt/p0Ah8nIflHw5O3Y8fMq6HIMI2pl4ykam
         FXh/9/EM5udUVPfFzN5dcZPLdgctrJKrd+gTU7n7bUPF/HvcMozWulssilSroyBQ2X
         Aew27uAjxbSk7GhDnzvGPyD1MqvO7K+N51vjlMrUbaRQvOdH/SswcEJQ5kU0demxaK
         gt73ahN04Jfwg==
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 3844514DC;
        Tue, 27 Jun 2023 22:34:07 +0200 (CEST)
Date:   Tue, 27 Jun 2023 22:34:06 +0200
From:   Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= 
        <nabijaczleweli@nabijaczleweli.xyz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>,
        Chung-Chiang Cheng <cccheng@synology.com>, ltp@lists.linux.it
Subject: Re: [PATCH v3 0/3+1] fanotify accounting for fs/splice.c
Message-ID: <t5az5bvpfqd3rrwla43437r5vplmkujdytixcxgm7sc4hojspg@jcc63stk66hz>
References: <CAOQ4uxh7i_s4R9pFJPENALdWGG5-dDhqPLEUXuJqSoHraktFiA@mail.gmail.com>
 <cover.1687884029.git.nabijaczleweli@nabijaczleweli.xyz>
 <CAOQ4uxg38PDSEWARiWpDBvuYC4szj3R3ZkoLkO76Ap6nKjTRTA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="livg7bjd2dg6ub3p"
Content-Disposition: inline
In-Reply-To: <CAOQ4uxg38PDSEWARiWpDBvuYC4szj3R3ZkoLkO76Ap6nKjTRTA@mail.gmail.com>
User-Agent: NeoMutt/20230517
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,PDS_RDNS_DYNAMIC_FP,
        RDNS_DYNAMIC,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--livg7bjd2dg6ub3p
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 27, 2023 at 09:03:17PM +0300, Amir Goldstein wrote:
> On Tue, Jun 27, 2023 at 7:55=E2=80=AFPM Ahelenia Ziemia=C5=84ska
> <nabijaczleweli@nabijaczleweli.xyz> wrote:
> >
> > In 1/3 I've applied if/else if/else tree like you said,
> > and expounded a bit in the message.
> >
> > This is less pretty now, however, since it turns out that
> If my advice turns out to be bad, then please drop it.
The if/else if/else with no goto is better than before;
it was made ugly by the special-casing below.

> > iter_file_splice_write() already marks the out fd as written because it
> > writes to it via vfs_iter_write(), and that sent a double notification.
> >
> > $ git grep -F .splice_write | grep -v iter_file_splice_write
> > drivers/char/mem.c:     .splice_write   =3D splice_write_null,
> > drivers/char/virtio_console.c:  .splice_write =3D port_fops_splice_writ=
e,
> > fs/fuse/dev.c:  .splice_write   =3D fuse_dev_splice_write,
> > fs/gfs2/file.c: .splice_write   =3D gfs2_file_splice_write,
> > fs/gfs2/file.c: .splice_write   =3D gfs2_file_splice_write,
> > fs/overlayfs/file.c:    .splice_write   =3D ovl_splice_write,
> > net/socket.c:   .splice_write =3D generic_splice_sendpage,
> > scripts/coccinelle/api/stream_open.cocci:    .splice_write =3D splice_w=
rite_f,
> >
> > Of these, splice_write_null() doesn't mark out as written
> > (but it's for /dev/null so I think this is expected),
> > and I haven't been able to visually confirm whether
> > port_fops_splice_write() and generic_splice_sendpage() do.
> >
> > All the others delegate to iter_file_splice_write().
> All this is very troubling to me.
> It translates to a mental model that I cannot remember and
> cannot maintain for fixes whose value are still questionable.
>=20
> IIUC, the only thing you need to change in do_splice() for
> making your use case work is to add fsnotify_modify()
> for the splice_pipe_to_pipe() case. Right?
No, all splice/tee/vmsplice cases need to generate modify events for the
output fd. Really, all I/O syscalls do, but those are for today.

> So either make the change that you need, or all the changes
> that are simple to follow without trying to make the world
> consistent
Thus I also originally had all the aforementioned generate access/modify
for in/out.

> - these pipe iterators business is really messy.
> I don't know if avoiding a double event (which is likely not visible)
> is worth the complicated code that is hard to understand.
>=20
> > In 2/3 I fixed the vmsplice notification placement
> > (access from pipe, modify to pipe).
> >
> > I'm following this up with an LTP patch, where only sendfile_file_to_pi=
pe
> > passes on 6.1.27-1 and all tests pass on v6.4 + this patchset.
> Were these tests able to detect the double event?
> Maybe it's not visible because double consequent events get merged.
That's how I discovered it, yes. They aren't merged because we'd generate
  modify out  <- from the VFS callback
  access in   <- from do_splice
  modify out  <- ibid.

I agree this got very ugly very fast for a weird edge case =E2=80=92
maybe I did get a little over-zealous on having a consistent
"one syscall=E2=86=94one event for each affected file" model.

OTOH: I've found that just using
	if (ret > 0) {
		fsnotify_modify(out);
		fsnotify_access(in);
	}
does get the events merged from
  modify out  <- from the VFS callback
  modify out  <- from do_splice
  access in   <- ibid.
into
  modify out
  access in
which solves all issues
(reliable wake-up regardless of backing file, no spurious wake-ups)
at no cost. I would've done this originally, but I hadn't known
inotify events get merged :v

--livg7bjd2dg6ub3p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmSbR7sACgkQvP0LAY0m
WPEhGRAAuyK6/DIeyT8tyzJLMOAJ76oV9CHjvafnUr2c9CWNFLOE4Hsq6JLeIdjH
CCVG0xe683LLSg7Larnl43LHwrWXfipfrOBTMHJaFoV0pPDuMnIfvnjBuMJDoXhU
7nw69olvCG6Kb57K6Ho1fM42ax5HplkxX211cSjWMkiyuz0NgG1xXfR3N7nQjYIp
tax29x71XHdP3BZnW0fmQzRTssSgbZ09KHenPW0AsF34MuSMht79FOBY09J0TjJT
wklwRfscMouMVHRfLmmWACcBALlxKVhXJ7lEo66RPANywUf2ED8+O8OLoAxg2Gbn
3LCMwBtkBCN88iK4I007r96uxUmHew27eU3XY2e0Cd2+0NL9lAfJzg67WlV6d2Vx
0WHPr4nqWXZT+YyfvpEs+ZxF1eT2LNwcx3X02EcNhGhWyNzG9KHmb3/IrvYfW6oz
dLGsH88F2bLq9zJrK3EMg9o86+XXf9JiN3WzkUEJnKEwuiYLRdzafB/dxtyfx2BO
qyFH0sPhvo49kTNvFHadvAmrXUg8268cS+qkmxbntMgF6f44dARbz5JuNvxLRlKe
0LdoTmIlfGDeLJI2Zvea+UfBr+zP99y5AU3bDl9ASN/ce424M+hMv/RFxN3z0As0
kzB3+L+w2jEm3Kq1a+NJ7EHkhrOtG58QfXMpEHDtQsXffmQQ2Yg=
=eA5m
-----END PGP SIGNATURE-----

--livg7bjd2dg6ub3p--
