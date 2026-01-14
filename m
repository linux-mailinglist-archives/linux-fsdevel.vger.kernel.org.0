Return-Path: <linux-fsdevel+bounces-73792-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AAA9D20A3F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 18:50:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5DF783016AED
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 17:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 808E932B997;
	Wed, 14 Jan 2026 17:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QAK2bRz2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f193.google.com (mail-yw1-f193.google.com [209.85.128.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 825672FFDD5
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Jan 2026 17:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768413053; cv=none; b=ktiOWEoEoKu8BD/UhBWshmLYy8k1/qJ/gJCuVF5QJ3ZUe7c0Hw95ugVLVOoCOzJgYjzXCzJQuzRx8mNgeSg/yeVfnfHrdbVWHt6M9+mULzFiolcGmw1u6hSwsXDQGpRirO31RAQPoTvm7Ue1/rhrVFkPcyT3XKbQADucXP4fy4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768413053; c=relaxed/simple;
	bh=4HugxS99JATPZh7UtegD00ahZepCflNCES68LB5SC/4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jNHmNco68iE8WEFSBa5INUBLKFTw1EpzgNU4AfE3Cm6MVg5HWtmRTjneHQfBaStsn8lWM4e6aaNnV8P/0HDBwQPueBx8Gghrc1E6rFpAuCb5piUz6eb4NabEmaLn7GM39RiiwguQPIcPV2r+lLhmkf++fcNMItpi3+on9yHRfAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QAK2bRz2; arc=none smtp.client-ip=209.85.128.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f193.google.com with SMTP id 00721157ae682-792815157f3so17517b3.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Jan 2026 09:50:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768413051; x=1769017851; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=D/yJE0mQv4t06ZIh/iLWxjHHlzd+ByfHco7ny6pUeOw=;
        b=QAK2bRz2Ud4s9PCofHoykgImszSWztLvBzhM92og1yVKpRd0GOKDXA/Vb+U+gP/+LC
         sE0K65eQYQ6lV3UZoP/pPrxT8YSGn9YilfwM+QsRuz74XjnUG1rDYXeQ4gsjNxiWBUYK
         Uv0t47Y9RfMuN5cr5zZgf6Tg+2qrDdbPBYS66zY07v8z/LewZmS621/g84b/r5zwSePG
         jwuyrUQipA2+9zAb0yjJrJhMv6gmUkACAtbSN3JzUVVyq3obLXG5MmyzgyU/ePxivncC
         21RE8LVZTCcsQ4O3vF8JW/ZGWyuRNFtxHhipnX6pFLysXojCsWSb83FFkX2nQvA/kbro
         MwPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768413051; x=1769017851;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D/yJE0mQv4t06ZIh/iLWxjHHlzd+ByfHco7ny6pUeOw=;
        b=bJvzV7X5ruKXYhzf/5I6JInnXY/8S9rjxZYRqmKdVHCKadcaXuyjm1qN/2WmqC5P6f
         4/GRHo0SeTrn1Mb/3eBqd9VGNRC6DWIbTMq1Cy4CoEr5Rx+jeGTgXIV63bqVZLWuNUqV
         oepl2bAPs9WpHLOSwQYc98fcBfmJRfjemD6kjQFeAQEez0k/datOrOLAJiy7FAhBWDox
         EZvoOVKBh+RNtg8xlg64EEV9YRcI9YrMFUCOzoqw90QRQ8YPGQxy3vhAZ7m5QQuGwsFK
         POOzkZmpr3e+WqQ/yeCnaUXmO+fz9OmFkbvnlVH9D3WGo/+gcO4faZa2Tv9aizHp0CCi
         Sa3A==
X-Forwarded-Encrypted: i=1; AJvYcCW2Bp+jJvoAf5d8Vc9BE4qGY4aADJihhnGhkXQ9L0OuKTPh1TLnhbMIjXlCAfbhLyb9XM4byDzzy4wyAiYu@vger.kernel.org
X-Gm-Message-State: AOJu0YzKgRFAZF7dLUIYDGOg0iFMStwfup6+d2AhzKjEX9FQmZTRRJnU
	4ET8PG4rbBjoPy/10QcbPKbohuoNgJF/iDVNbzyBk+puD0eaFMnC4W0C
X-Gm-Gg: AY/fxX5BWGpwVWUFGkGcY71TJBmkrHhAS6NnYLG5/HtngOh5LnFODNOdztO/yHj5S1/
	lqxIuC8QPO1vKxJD+VxgMKPBVE6MSyBtgU4Kq2kRLzrwG//ClYnL2+z+r6qiaHB8NgtyTbnK226
	5z7aOl5xZ1u2HSZjSlJhEfjIASN900GfT49OFl1+twzjOqeRB89mzy5DU1MdTzP2yeZEeyKOQMm
	DKLChNRATuu3ZBZYawsfGNfLvUQpJFPMZxzO4+Oql/J9q5UtTOf7Kfx4brOxpxCYJnmVHVGYQB1
	ipxxzDO8tBPc4d+xh7d9izZ+nkSfM5DytmLsYNbEuMitvSKwB5gRA4/WJk+qfW6l8yeKRpfXCRj
	J5qEQE4Vl24modx9lq/4z07kC7OI/Q7tdhWaJEJi2JCBf2LZ6lXcOdvXCkOs+MxDKLsjm509deo
	YK
X-Received: by 2002:a05:690e:11c4:b0:641:f5bc:694b with SMTP id 956f58d0204a3-64901b11096mr2568941d50.79.1768413051341;
        Wed, 14 Jan 2026 09:50:51 -0800 (PST)
Received: from illithid ([2600:1702:7cd0:e980::48])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-790aa679385sm93186017b3.32.2026.01.14.09.50.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 09:50:50 -0800 (PST)
Date: Wed, 14 Jan 2026 11:50:48 -0600
From: "G. Branden Robinson" <g.branden.robinson@gmail.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: Alejandro Colomar <alx@kernel.org>, linux-man@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH man-pages v2 1/2] man/man2const: document the new
 F_SETDELEG and F_GETDELEG constants
Message-ID: <20260114175048.krre2hmydplaluty@illithid>
References: <20260114-master-v2-0-719f5b47dfe2@kernel.org>
 <20260114-master-v2-1-719f5b47dfe2@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="jkasqkgh4pwlr6xn"
Content-Disposition: inline
In-Reply-To: <20260114-master-v2-1-719f5b47dfe2@kernel.org>


--jkasqkgh4pwlr6xn
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH man-pages v2 1/2] man/man2const: document the new
 F_SETDELEG and F_GETDELEG constants
MIME-Version: 1.0

Hi Jeff,

The following observation is not a blocker.

At 2026-01-14T12:35:24-0500, Jeff Layton wrote:
[...]
> +.P
> +A file delegation is a mechanism whereby
> +the process holding the delegation (the "delegation holder")
> +is notified (via delivery of a signal)
> +when a process (the "delegation breaker") tries to

I recommend use of typographer's quotes marks in prose (contrast code).

groff_man_style(7):
     \[lq]
     \[rq]  Left and right double quotation marks.  Use these for paired
            directional double quotes, =E2=80=9Clike this=E2=80=9D.

These look better in typeset output (like PDF) and on UTF-8 terminals,
and avoid collisions with `"` when searching man(7) documents in source
and, on the aforemented devices, as rendered too.

Regards,
Branden

--jkasqkgh4pwlr6xn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEh3PWHWjjDgcrENwa0Z6cfXEmbc4FAmln13EACgkQ0Z6cfXEm
bc4PdQ//UVGUE3EDEF5ndu5zEhHXj/hcMFfM+I7PMz8pM0T8VyAW6b5BulvfNTJ6
vwV6/huGJJm0YsC8+nJ/amMBKQCqVgExqfeAZtJhS6U+KPylj2NpCWTwBUSFSXV4
6shjPzlLhoZCvj2pQ09qtryXVHeUhXC/SUDcyB9bBYQH4/ts7a+cmwZIy+cHbtFz
Qo8GSRM2DenWszaXvi/TknAHxZDpi2cIKMd4oPVtPSwbfCRAN/a2max+UBgoAAxZ
F88uVdAVtFdA784Rc79Mop6BxRkC5sRJ3+7zjXo5UpEMqNa9o8coJKL1fEGHScEc
OlCtHCx7n30JzNS6w2P11J32KD1gPnN2WMJuRN2Q75pauyroDyD2mDUQtEl6Qteb
C5HG5VBxdOSdDnJwNBvcmRmSD95pft0MdtC3OCPf0wFu2TO/IMTOBPeq+Foeny7w
bHdI+CruKKT/Jn6T17ai7044yX4UqigF+GDaZPqTwSwCpFnLd77qpeCb/ofsQogM
sAfc9xOpl1xHDHBHPk+gAVlOMdGLsC1G6GfFV1+5GF8RjSDb55N3qydUSnhcdLh6
qpYExh8bzVGmLktw/3XZBkb/CQ8aI9pyAgDoEV3a1v/vmsdW3fadIurKw8a/wZjy
6XSmbGkB3FbhfsDgFMz1YVJGMPP/L/epkqtb5U9BowkRO4gAArA=
=t2j9
-----END PGP SIGNATURE-----

--jkasqkgh4pwlr6xn--

