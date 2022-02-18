Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3255B4BC04E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Feb 2022 20:33:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237385AbiBRTd5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Feb 2022 14:33:57 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237370AbiBRTd4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Feb 2022 14:33:56 -0500
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C400E488B5;
        Fri, 18 Feb 2022 11:33:39 -0800 (PST)
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <riel@shelob.surriel.com>)
        id 1nL90W-0002bz-3p; Fri, 18 Feb 2022 14:33:32 -0500
Message-ID: <5f442a7770fe4ac06b2837e4f937d559f5d17b8b.camel@surriel.com>
Subject: Re: [PATCH 1/2] vfs: free vfsmount through rcu work from
 kern_unmount
From:   Rik van Riel <riel@surriel.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        linux-fsdevel@vger.kernel.org, paulmck@kernel.org,
        gscrivan@redhat.com, Eric Biederman <ebiederm@xmission.com>,
        Chris Mason <clm@fb.com>
Date:   Fri, 18 Feb 2022 14:33:31 -0500
In-Reply-To: <Yg/y6qv6dZ2fc5z1@zeniv-ca.linux.org.uk>
References: <20220218183114.2867528-1-riel@surriel.com>
         <20220218183114.2867528-2-riel@surriel.com>
         <Yg/y6qv6dZ2fc5z1@zeniv-ca.linux.org.uk>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-Ao7FGBNHr2axvfjFUaOf"
User-Agent: Evolution 3.42.3 (3.42.3-1.fc35) 
MIME-Version: 1.0
Sender: riel@shelob.surriel.com
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--=-Ao7FGBNHr2axvfjFUaOf
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2022-02-18 at 19:26 +0000, Al Viro wrote:
> On Fri, Feb 18, 2022 at 01:31:13PM -0500, Rik van Riel wrote:
> > After kern_unmount returns, callers can no longer access the
> > vfsmount structure. However, the vfsmount structure does need
> > to be kept around until the end of the RCU grace period, to
> > make sure other accesses have all gone away too.
> >=20
> > This can be accomplished by either gating each kern_unmount
> > on synchronize_rcu (the comment in the code says it all), or
> > by deferring the freeing until the next grace period, where
> > it needs to be handled in a workqueue due to the locking in
> > mntput_no_expire().
>=20
> NAK.=C2=A0 There's code that relies upon kern_unmount() being
> synchronous.=C2=A0 That's precisely the reason why MNT_INTERNAL
> is treated that way in mntput_no_expire().

Fair enough. Should I make a kern_unmount_rcu() version
that gets called just from mq_put_mnt()?

--=20
All Rights Reversed.

--=-Ao7FGBNHr2axvfjFUaOf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAmIP9IsACgkQznnekoTE
3oPmxAf+MkEtjsaDtYZLtaUJPlK7ILJICC0WJttdjamuAw9nKTs5lVIl5o83pg1R
mwY0aAhOzpNPeblu5IHvlnGpxikh6SgMIg1csJfHspkHb2NkvNdNz+KjhUtq3aZ2
LF4I6bZIICT4JZFMETEbrCxdhdV5DLwPSG6DkUSElP7cLfL/GUNbFNgeEymajyqn
5Rjct78T8OS+qAYImM8qy0a+whz+eR+hb6w5SD+APCGZhTPdcU4Kdr4LqOe1m5lm
gd49jDn4Uxzb82F4tnVNlgHUquYKbg3tMpPQVHx3hfm/RlSvZomDuUck21dh0u3T
oTPuAsCyEN/2The+nwuh/6Qc6i5hdw==
=/XIM
-----END PGP SIGNATURE-----

--=-Ao7FGBNHr2axvfjFUaOf--
