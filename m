Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDBF91B152A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Apr 2020 20:53:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbgDTSxA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Apr 2020 14:53:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726013AbgDTSxA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Apr 2020 14:53:00 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7E3CC061A0C;
        Mon, 20 Apr 2020 11:52:59 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id d17so13480638wrg.11;
        Mon, 20 Apr 2020 11:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YDv7ccUA+77rJK6WcpIOdQAqm/WbduDoaoFBYXn+9nk=;
        b=Sx9OvAhxW+inqKWH1HdiW8xMmPU5RoWqbFum6ToezCGd6UruC6sQ1moOyw7Dgh+oi0
         aIPV3DxAWv4OYkGx/98H80C2CrIMAKQsNHFuvVsGxWgCT/EVZR4fx4LXCLxf4HA5c4aL
         3QQq3pPateWwit2CNa+FadRkEKEn4XUc+yX00UvOTFlm1cYSLCBhxQBnwjcF3hChsPwy
         1ySMhB01J/Na4515hb5sZN7frUOhxPd92PI1+hmFuqCEqBziPydHaP9JiiWFUSYEAJGG
         xKyIK7a1cJDqltaMfofpKSEuvR0lDCcRmd/5Tp+RiHe6fhkLe81h1tFzxafVVOAhP+Qb
         h7uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=YDv7ccUA+77rJK6WcpIOdQAqm/WbduDoaoFBYXn+9nk=;
        b=nAjlJ9JoemyO+BkSLbSRZu2cxq36tNNhWxcreL9osagD0ITA8a0uztP6R9G0GZw8x2
         vswBQLT7DZ8YPxEQMkPZkoLBab2xNRqzlHQWDhpIxrJu+5CyU1sRekYm+N6UR+t3DyiA
         3OkZnhch5JS8F/VAJEPQHql0bY7lB1ONZ+8542QfkpVVV94Qd2uuyW9aOzhdMPzDcv/i
         X1WA9h5rjl/i6CUHz/nZqCBACv8aWVww+ApdEK+x4XiQW2r0QLqOX8Ym63NjUt5Ke8ej
         PElW/z+PxGpPGjA0GLdlU7Dyqls0i1X3N5OiTRPMjVrewSUmsL+Sq1ugDUuJA9Jv4TP7
         bdjg==
X-Gm-Message-State: AGi0PuaBqeBWMytkIM3ikqRerq7dEuSyDnjzUi+Vxr/WvtOxOtUpRH3J
        LlXFl6Q+g6ewI/ibTNXMc0o=
X-Google-Smtp-Source: APiQypK9OLvGCGpyh6W2T2xf9o5uVt/UoFrOnuIUdLKEwU0scYoOoaGCFJq4Z5+fpjamSUP5wBrYaA==
X-Received: by 2002:adf:a15d:: with SMTP id r29mr19010580wrr.134.1587408778508;
        Mon, 20 Apr 2020 11:52:58 -0700 (PDT)
Received: from dumbo (tor-exit-2.zbau.f3netze.de. [2a0b:f4c0:16c:2::1])
        by smtp.gmail.com with ESMTPSA id y70sm370563wmc.36.2020.04.20.11.52.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 11:52:57 -0700 (PDT)
Received: from cavok by dumbo with local (Exim 4.92)
        (envelope-from <cavok@dumbo>)
        id 1jQbXL-0002cQ-Pl; Mon, 20 Apr 2020 20:52:55 +0200
Date:   Mon, 20 Apr 2020 20:52:55 +0200
From:   Domenico Andreoli <domenico.andreoli@linux.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-fsdevel@vger.kernel.org, mkleinsoft@gmail.com,
        Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] hibernate: unlock swap bdev for writing when uswsusp is
 active
Message-ID: <20200420185255.GA20916@dumbo>
References: <20200229170825.GX8045@magnolia>
 <20200229180716.GA31323@dumbo>
 <20200229183820.GA8037@magnolia>
 <20200229200200.GA10970@dumbo>
 <CAJZ5v0iHaZyfuTnqJyM6u=UU=+W6yRuM_Q6iUvB2UudANuwfgA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="NzB8fVQJ5HfG6fxh"
Content-Disposition: inline
In-Reply-To: <CAJZ5v0iHaZyfuTnqJyM6u=UU=+W6yRuM_Q6iUvB2UudANuwfgA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--NzB8fVQJ5HfG6fxh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 01, 2020 at 10:35:36PM +0100, Rafael J. Wysocki wrote:
> On Sat, Feb 29, 2020 at 9:02 PM Domenico Andreoli <domenico.andreoli@linu=
x.com> wrote:
> >
> > Maybe user-space hibernation should be a separate option.
>=20
> That actually is not a bad idea at all in my view.

I prepared a patch for this:
https://lore.kernel.org/linux-pm/20200413190843.044112674@gmail.com/

Regards,
Domenico

--=20
rsa4096: 3B10 0CA1 8674 ACBA B4FE  FCD2 CE5B CF17 9960 DE13
ed25519: FFB4 0CC3 7F2E 091D F7DA  356E CC79 2832 ED38 CB05

--NzB8fVQJ5HfG6fxh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEQ0d58WdvR3VfrFIt+pSrUd21xpcFAl6d73wACgkQ+pSrUd21
xpe+wg//dI1cjQ4YgLAir3TKqx3SMxN3CevJQ6BV1YTeWZx5ItlG5z90hVtUb3Ae
DUmVPHe9ERrjyjFoADDejz2bzdT8LLNtnIQwmRfH3Dc2IeN9Fzmt0EAV1mb3l8jD
yp3RkOMPcuVi6pZV2O1OyFhAS1ptfPnvEIXXuqxfA1ay9yo3x3IS7CR3bzkllI8S
Ei4XhUruz8WqI9EERa8RYYTa1R+XDalHOs0i926sZHzP56YlXncNlCmsL6SA9YrX
zrZ32EtdRLdgROBoSN78WupaubrqoJ5yvSovcwJVdWU4OhzO34/0wY2fCOK7giqh
2btBvabIcGu0QbPRyxJanQNPvnRXyAaoHwnqjKbxcDVgdePFAJJ2g7nWrT4MJNU2
WNQxrWCMo9l9CrtRwavLwcRCrURKi4J52Z8DZXcQ9Qqe+hoZtddgTrHLTPpqEpi8
UFxgLaTRhGGY+LcV7Hbir5XrQGWF7CJDpRRC79fsBTjBbkx40/w8ZeVhxlZ17QLh
krNIzSKBJsatR58BH0rFb5UaRzePTrbsIZ/bjiiCR+ymOkoUp68asncnsxLTPve/
3cdrZz+LKHTdk0r/OzEToQN87A+NyeePXnKNjTpDOzk4k7GWQgyr/dgZerkAeXJr
8GpP4+1xfAJqaIjkcXMrRND+TExDiDqICuAIdVL9PgGBv3s2HG8=
=O3pE
-----END PGP SIGNATURE-----

--NzB8fVQJ5HfG6fxh--
