Return-Path: <linux-fsdevel+bounces-33160-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10E219B54DB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Oct 2024 22:18:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A5471F23649
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Oct 2024 21:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D3EC209F4A;
	Tue, 29 Oct 2024 21:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P30V+QNU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B061E207A25;
	Tue, 29 Oct 2024 21:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730236666; cv=none; b=lPRlSS27KAxw83aZbAkSHzuom+oEtJ/+WMLIsTU+vpC+jOuo5AAcUcZIdlCO62ezoiHmfRn8LtwAJOmkh1FK57BDjneuKV4dG9IPx52AK3LT8eXtKnUyYoe/o8K4u2grmmpP4dVdPv4g//0lCVQZq7qfXe0bPKD7Tc3zBl8nkRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730236666; c=relaxed/simple;
	bh=Uy2rhskes1k9g4A72PgKCwm0Xyttbcyas7EVeUXJtB8=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=dTcd+iBcQeOXRGhySiIPCQ3Ndg2p+4GmtEs2t6BPp4z0hqSFcMQoN9q0S+UiKFbIa+fwh9XBmdqhPXPTFdVbTZ7r7T1/+b9jQpJRXRBgS1H5GIqfLcnLMhtr1TkBvGRVhPOrfXslfpAt+kRv5PPjDYtEauoRVZ9Y+E31XHCf6Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P30V+QNU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0E3EC4CEE4;
	Tue, 29 Oct 2024 21:17:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730236666;
	bh=Uy2rhskes1k9g4A72PgKCwm0Xyttbcyas7EVeUXJtB8=;
	h=From:Date:To:cc:Subject:In-Reply-To:References:From;
	b=P30V+QNU86ZCAR3UMWTLe4vw1ZT9euWjguXRN/lQRxjnR4+Kk2ccYyZXcYgGroFpt
	 Og3LgVq9/hBCQozdd3P+G+9GoSXl+U5xeqI2iO7YDPTcp3Z8O21Iv9ve8jEK5ktNsD
	 CCYJk87siEgjM8EtoNFB/Z3rn2j9jKar8NANSjMbb0PVpSANobo0T3WAlZpPhVeQKC
	 YZGVgm4dgjgq2ATqvn47V6L7UFjqMI2e6qaAji3059NZT1AcOsFb18VYgxxhuWo63O
	 1Ia2ZqVuC5kzmAZIq6L3eWlPEOUNoV1Kayz372vlSi+GYO0wZywqxXl60+8JTdADbr
	 UfE4nPhqxdNNw==
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ij@kernel.org>
Date: Tue, 29 Oct 2024 23:17:40 +0200 (EET)
To: Paolo Abeni <pabeni@redhat.com>
cc: chia-yu.chang@nokia-bell-labs.com, netdev@vger.kernel.org, 
    davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
    dsahern@kernel.org, netfilter-devel@vger.kernel.org, kadlec@netfilter.org, 
    coreteam@netfilter.org, pablo@netfilter.org, bpf@vger.kernel.org, 
    joel.granados@kernel.org, linux-fsdevel@vger.kernel.org, kees@kernel.org, 
    mcgrof@kernel.org, ncardwell@google.com, 
    koen.de_schepper@nokia-bell-labs.com, g.white@CableLabs.com, 
    ingemar.s.johansson@ericsson.com, mirja.kuehlewind@ericsson.com, 
    cheshire@apple.com, rs.ietf@gmx.at, Jason_Livingood@comcast.com, 
    vidhi_goel@apple.com
Subject: Re: [PATCH v4 net-next 09/14] gro: prevent ACE field corruption &
 better AccECN handling
In-Reply-To: <eb04ddfd-6e17-464b-a629-09aed99e2e95@redhat.com>
Message-ID: <4b3ede21-27cf-bc17-be71-4c388e670f2c@kernel.org>
References: <20241021215910.59767-1-chia-yu.chang@nokia-bell-labs.com> <20241021215910.59767-10-chia-yu.chang@nokia-bell-labs.com> <eb04ddfd-6e17-464b-a629-09aed99e2e95@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-2002160427-1730236660=:995"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-2002160427-1730236660=:995
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 29 Oct 2024, Paolo Abeni wrote:
> On 10/21/24 23:59, chia-yu.chang@nokia-bell-labs.com wrote:
> > From: Ilpo J=C3=A4rvinen <ij@kernel.org>
> >=20
> > There are important differences in how the CWR field behaves
> > in RFC3168 and AccECN. With AccECN, CWR flag is part of the
> > ACE counter and its changes are important so adjust the flags
> > changed mask accordingly.
> >=20
> > Also, if CWR is there, set the Accurate ECN GSO flag to avoid
> > corrupting CWR flag somewhere.
> >=20
> > Signed-off-by: Ilpo J=C3=A4rvinen <ij@kernel.org>
> > Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> > ---
> >  net/ipv4/tcp_offload.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/net/ipv4/tcp_offload.c b/net/ipv4/tcp_offload.c
> > index 0b05f30e9e5f..f59762d88c38 100644
> > --- a/net/ipv4/tcp_offload.c
> > +++ b/net/ipv4/tcp_offload.c
> > @@ -329,7 +329,7 @@ struct sk_buff *tcp_gro_receive(struct list_head *h=
ead, struct sk_buff *skb,
> >  =09th2 =3D tcp_hdr(p);
> >  =09flush =3D (__force int)(flags & TCP_FLAG_CWR);
> >  =09flush |=3D (__force int)((flags ^ tcp_flag_word(th2)) &
> > -=09=09  ~(TCP_FLAG_CWR | TCP_FLAG_FIN | TCP_FLAG_PSH));
> > +=09=09  ~(TCP_FLAG_FIN | TCP_FLAG_PSH));
>=20
> If I read correctly, if the peer is using RFC3168 and TSO_ECN, GRO will
> now pump into the stack twice the number of packets it was doing prior
> to this patch, am I correct?
>=20
> That is likely causing measurable performance regressions.

Hi Paolo,

Thanks for taking a look!

While it's true on surface that this might cause some more packets with=20
RFC3168 (by design, as network cannot know if the sender is using RFC3168=
=20
or not), the important question is the scale how many of extra packets=20
will occur in practice.

First of all, RFC3168 requires CWR flag to be sent no more frequently=20
than once per window of data, or in other words, once per RTT. And that
means just one packet, not e.g. all packets of a super-skb (the RFC3168
signalling will lose its integrity if this is violated by the sender).

Secondly, the TCP sender uses CWR flag to indicate it just halved its=20
congestion window which mean it is sending half the amount of packets in=20
this window than in the previous window (analoguous to halving sending=20
rate). 2 RTTs with CWR each means two window reductions (this behavior=20
is spec'ed in RFC3168).

So lets say the sender was using 100 packets congestion window, this=20
change will add one packet to 50 packets on this next RTT. Note those are
raw numbers of packets on wire and do not tell how many packets GRO=20
combined into each super-skb which will wary case-by-case basis.=20
Regardless, I suspect the extra packet added to the half of the packets=20
will be hard/impossible to measure to cause a performance regression.

This change would double the number of packets only if the congestion=20
window is 1 or 2 packets and in that case TSO/GSO/GRO benefits will be=20
pretty small to begin with (or even counterproductive). Also, the=20
traditional TCP congestion control (RFC3168 included) has many issues=20
anyway with that small windows because it doesn't deal with fractional=20
congestion windows well.

> >  =09flush |=3D (__force int)(th->ack_seq ^ th2->ack_seq);
> >  =09for (i =3D sizeof(*th); i < thlen; i +=3D 4)
> >  =09=09flush |=3D *(u32 *)((u8 *)th + i) ^
> > @@ -405,7 +405,7 @@ void tcp_gro_complete(struct sk_buff *skb)
> >  =09shinfo->gso_segs =3D NAPI_GRO_CB(skb)->count;
> > =20
> >  =09if (th->cwr)
> > -=09=09shinfo->gso_type |=3D SKB_GSO_TCP_ECN;
> > +=09=09shinfo->gso_type |=3D SKB_GSO_TCP_ACCECN;
>=20
> If this packet is forwarded, it will not leverage TSO anymore - with
> current H/W.
>=20
> I think we need a way to enable this feature conditionally, but I fear
> another sysctl will be ugly and the additional conditionals will not be
> good for GRO.
>
> Smarter suggestions welcome ;)

Well, it is already very selectively _conditional_, SKB_GSO_TCP_ACCECN is=
=20
only set for the skb when CWR is set. That is, once per RTT (data window)=
=20
when it comes to RFC3168.=20

I don't have any source for this (other than reading many many tcpdumps=20
in the past) but I believe the percentage of packets with CWR set (due to=
=20
RFC3168 signalling) is going to be very small overall.

Do you think that is not good enough?

To answer more generally to your suggestion on making it conditional based=
=20
on some other logic, it would mean you accept network middleboxes are=20
allowed to corrupt AccECN ACE field when forwarding. If RFC3168 TSO/GSO=20
trickery remains in use (without a middlebox explicitly tracking the=20
connection had negotiated RFC3168), a forwarder won't be able to reproduce=
=20
the exactly same stream of TCP packets headers thus corrupting non-RFC3168=
=20
use of CWR flag. It's not something any middlebox should be doing (I hope=
=20
we agree on this as a general principle)!

--=20
 i.
=20
> Cheers,
>=20
> Paolo
>=20
> >  }
> >  EXPORT_SYMBOL(tcp_gro_complete);
> > =20
>=20
>=20
--8323328-2002160427-1730236660=:995--

