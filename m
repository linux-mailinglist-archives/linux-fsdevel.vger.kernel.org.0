Return-Path: <linux-fsdevel+bounces-76175-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CMjYM9q/gWm7JAMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76175-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Feb 2026 10:28:58 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 278B8D6C71
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Feb 2026 10:28:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 60361303A93D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Feb 2026 09:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FF42396D0D;
	Tue,  3 Feb 2026 09:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="RWFvJ6in"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B42BC2BF00D
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Feb 2026 09:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770110932; cv=pass; b=nd+L6mPICD29ndtp2mfhrXmH1nbX+B9FkTm7JMtQlr56zaAUxJB3EkCWvhALe2eQ+W3WzcM6HXW2/78YsYgv7aJ6A7CYolaJ9au4G73HkmC6TthKgma9Gy2QFKUBOf78ZSjnzJWcTl4CoS93fkkmZV9Sx7NVtEbAKu6Oth9JsWI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770110932; c=relaxed/simple;
	bh=tZ126BOD/h2B9d/TuOII3g3sj/EiS2e4oowiCerYL1s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uGXXOggU0d6PtWvmCNoKKz5RpXSRj2xOURBwZMwCNxurpdfHlyPEzv+wBbmI6Eta0m0TcvANvLY5ZsbXJ2T2knUev9La8I6Jr2vqKN73f6iAvGcFRGG09Fid8KVBwf53xql55P4uqs2weXgkrnDMiC23lMvapquJVUmsbuicOUE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=RWFvJ6in; arc=pass smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-50143fe869fso61567551cf.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Feb 2026 01:28:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770110930; cv=none;
        d=google.com; s=arc-20240605;
        b=YL/Ozdb/2WaSo95yqDUszOl5xFwd2/l8JYkCZMaqxvK4bLrZwAJp94lkh+SyTdU/Yz
         ZCA3ZraFdSWLDlR7PKyFUJb8AqfXdKUpQNC8PIlKuKo4BhK9kvsF1VzqFgOf/y6qJloJ
         oqjl6DQ8O10e5aDkiCtJRPXxAfGwIiPF8heo7GlWwwCEpUV9XUQYiGJ5j850mtv30YvS
         +RFuq9gLjEV4sWYVVgYZ8YHJ1agGyDpqUL9VHy9k4X1d2UuIVnu6wWjvVxm+8k/nD83k
         OqoP0RqlgnjT6Xz3cezkBCBVTEitw/4hTZVdczCfTsTloKYfOMqOU8rLKSVtJNHeIKWd
         oL+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=tZ126BOD/h2B9d/TuOII3g3sj/EiS2e4oowiCerYL1s=;
        fh=t7SiVtTwWb/ptyVA84Dqhl63nUZUiRA3vaIUpl/jyAU=;
        b=ECXp1EBTmiFoKQ78V/vBmQ8mFZ7m9bJJnBCBy2Cyw4Rd9YshQxlFfqKl59GMbBoH4q
         SdLBS04gLRRhB/E9737Tl5Y87OP5wTw/gr9FhI4nqbyjLKrG9LVwntjpYc0K0VBpGgtL
         A+W5b6+PyQ7CGXQ+M/PPToiZu0iRpBszGJY7a30vk+nZsygjYL33WOiBg+dpkcOjRwPK
         gdeOgZyh3cQy0SD9zYfJVOeaNWy1ZnrK1Opz4bFRa9DeCyy/aLkil0nYxmK/QQeIkk4u
         MZ+83DJvyRWZcTGt/nB/RMiw7GMklnFQRamt/k5wILIW9TNOVF/lzjMIaMvN98stWdCW
         aO7w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1770110930; x=1770715730; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tZ126BOD/h2B9d/TuOII3g3sj/EiS2e4oowiCerYL1s=;
        b=RWFvJ6inXtzrPTF7ixKQB3FGHwqoavzuPyEmYNJ0k6G5w8r3EaWKYiga/ugmQtmO/U
         nI+4kpYhRNeDhEv0Wfbz68s81Lp06MdZhR5SOsqragz6YIQIQGsGOyglNilJef7rmymc
         uzqYUmdTe1hSOaiHqODSRF6gEeJOztAbceCmY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770110930; x=1770715730;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tZ126BOD/h2B9d/TuOII3g3sj/EiS2e4oowiCerYL1s=;
        b=niifgpEikE3tFI3/NqKe1QGeMMK+/4yZhmniRizbQLhw9ki97+YeCoTjIWgY8dxtEY
         fJoloHPqLL2DzhMmOogHfsoPP6nznWSlCDo0eJhiFsXkl5oVhOF2g6XTe2CBUhezEpaH
         smgEX98Fg7gOAd+zLdAduboJvwkz2CsaYQWhrtaI4rZz9H7rHLdlKHi1SI47d0W0WjUW
         AGddWK/Yz/fBlO7DEwAEjV4/HiqLbdeqxDs31rriOPNKw1hbVsH/EOATbNQeygKzKn5/
         FC2/mqBGp5MO+65wfLdxuNJgkL67t/dpgORqnA2ndsfdRUOZHzIr3h9rXkrHK33ujTCy
         Ia8g==
X-Forwarded-Encrypted: i=1; AJvYcCWrbNKj5a28P/nNhxdv/kyr96ocaXBazBhV2SD44mnSWmCHPpbImOljOaMlH+TOR1aur+DIOro95lroBfWH@vger.kernel.org
X-Gm-Message-State: AOJu0Yzp8hj8O54B8REcrzKwfqFcjhdJGIRx+K6XOJ+wV8izFvX3hWAa
	F97bOgD43hNSXa+FvhkC9bqaMZ/MYuUWnx8IWwvN73EV6ZMaGa8oZ7MBXq3OcRx5LyGwnfHWTlx
	+2yPj9frB2Y0WJeI3YpHLRHUQd+Gl4BBQTNFzOJn8ltllAQXL1q6C1eo=
X-Gm-Gg: AZuq6aLOWwKKdvj0FdNEo219wylfl/bb9qQtRoBn6zFt92ZqLa2jr/3dOzH6IrSIfNm
	V5wdwjamvbj6yJP53bUF2atVl1Udck1hWFTX/iAqhfRDN2E62mrDNvePve58/1tSVkemEZUkak3
	vEhagn3qMTelLX/gdu46spIHfELSSRcqf3r+6hxDuahq2qsycNH7idveLdqn55KihazLoJHIGcd
	HH2533ZP9xGgyeciBATqHy5KOQ0A4mZc1mD4FjXMzgqppRcSVk+saAEHNukzeBkWCfaHYg=
X-Received: by 2002:a05:622a:15c8:b0:4f4:d295:1f53 with SMTP id
 d75a77b69052e-505d22c7f1bmr164588751cf.84.1770110929504; Tue, 03 Feb 2026
 01:28:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <32Xtx4IaYj8nhPIXtt0gPimTRQy4RNjzmsqI1vQB1YBpRes0TEgu6zVzWbBEcn2U6ZxB14BD9vakmezNyhdXDt3CVGO8WYGxHSZZ1qtQVy8=@spawn.link>
 <8f5bb04853073dc620b5a6ebc116942a9b0a2b5c.camel@kernel.org>
 <e5-exnk0NS5Bsw0Ir_wplkePzOzCUPSsez9oqF7OVAAq3DASvNJ62B9EuQbvIqHitDgxtVnu74QYDYVEQ8rCCU74p4YupWxaKZNN34EPKUY=@spawn.link>
 <9ceb6cbcef39f8e82ab979b3d617b521aa0fcf83.camel@kernel.org>
 <CA+zj3DKAraQASpyVfkcDyGXu_oaR9SnYY18pDkN+jDgi54kRMQ@mail.gmail.com>
 <998f6d6819c2e0c3745599d61d8452c3bc478765.camel@kernel.org> <3DMb18lL2VzwORom5oMGlQizKpO_Na6Rhmv5GDA9GpN3ELrsA5plqhzezDxDs_UcXaqFQ9qUHb9y4cY4JRy7TjQ108_dVkZH9D2Yj48ABH0=@spawn.link>
In-Reply-To: <3DMb18lL2VzwORom5oMGlQizKpO_Na6Rhmv5GDA9GpN3ELrsA5plqhzezDxDs_UcXaqFQ9qUHb9y4cY4JRy7TjQ108_dVkZH9D2Yj48ABH0=@spawn.link>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 3 Feb 2026 10:28:38 +0100
X-Gm-Features: AZwV_QjhVeHEHXi3zdvcjL-PjqXLob96OlUYSCaFZG20KpExU6ewBALihGVQp9o
Message-ID: <CAJfpegu5tAFr3+sEQGi6YWGHMEVpVByFoVxzCONERGvJJdk5vg@mail.gmail.com>
Subject: Re: NFSv4 + FUSE xattr user namespace regression/change?
To: Antonio SJ Musumeci <trapexit@spawn.link>
Cc: Trond Myklebust <trondmy@kernel.org>, =?UTF-8?Q?Johannes_Sch=C3=BCth?= <j.schueth@jotschi.de>, 
	linux-fsdevel@vger.kernel.org, Bernd Schubert <bernd.schubert@fastmail.fm>, 
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Content-Type: multipart/mixed; boundary="0000000000002b52010649e811e4"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	SUBJECT_ENDS_QUESTION(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[szeredi.hu,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[szeredi.hu:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain,text/x-patch];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:+];
	TAGGED_FROM(0.00)[bounces-76175-lists,linux-fsdevel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	DKIM_TRACE(0.00)[szeredi.hu:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miklos@szeredi.hu,linux-fsdevel@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,jotschi.de,vger.kernel.org,fastmail.fm,linuxfoundation.org];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,szeredi.hu:dkim]
X-Rspamd-Queue-Id: 278B8D6C71
X-Rspamd-Action: no action

--0000000000002b52010649e811e4
Content-Type: text/plain; charset="UTF-8"

On Mon, 2 Feb 2026 at 20:54, Antonio SJ Musumeci <trapexit@spawn.link> wrote:

> So where do we go from here? Bring in NFS server folks? Miklos?

Can you please try the attached patch on the server?

Thanks,
Miklos

--0000000000002b52010649e811e4
Content-Type: text/x-patch; charset="US-ASCII"; name="fuse_user_xattr.patch"
Content-Disposition: attachment; filename="fuse_user_xattr.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_ml6ebpj00>
X-Attachment-Id: f_ml6ebpj00

ZGlmZiAtLWdpdCBhL2ZzL2Z1c2UveGF0dHIuYyBiL2ZzL2Z1c2UveGF0dHIuYwppbmRleCA5M2Rm
YjA2YjZjZWEuLmMxMDRmMWE2NWFmZCAxMDA2NDQKLS0tIGEvZnMvZnVzZS94YXR0ci5jCisrKyBi
L2ZzL2Z1c2UveGF0dHIuYwpAQCAtMjA0LDYgKzIwNCwxMiBAQCBzdGF0aWMgaW50IGZ1c2VfeGF0
dHJfc2V0KGNvbnN0IHN0cnVjdCB4YXR0cl9oYW5kbGVyICpoYW5kbGVyLAogCXJldHVybiBmdXNl
X3NldHhhdHRyKGlub2RlLCBuYW1lLCB2YWx1ZSwgc2l6ZSwgZmxhZ3MsIDApOwogfQogCitzdGF0
aWMgY29uc3Qgc3RydWN0IHhhdHRyX2hhbmRsZXIgZnVzZV94YXR0cl91c2VyX2hhbmRsZXIgPSB7
CisJLnByZWZpeAk9IFhBVFRSX1VTRVJfUFJFRklYLAorCS5nZXQgICAgPSBmdXNlX3hhdHRyX2dl
dCwKKwkuc2V0ICAgID0gZnVzZV94YXR0cl9zZXQsCit9OworCiBzdGF0aWMgY29uc3Qgc3RydWN0
IHhhdHRyX2hhbmRsZXIgZnVzZV94YXR0cl9oYW5kbGVyID0gewogCS5wcmVmaXggPSAiIiwKIAku
Z2V0ICAgID0gZnVzZV94YXR0cl9nZXQsCkBAIC0yMTEsNiArMjE3LDcgQEAgc3RhdGljIGNvbnN0
IHN0cnVjdCB4YXR0cl9oYW5kbGVyIGZ1c2VfeGF0dHJfaGFuZGxlciA9IHsKIH07CiAKIGNvbnN0
IHN0cnVjdCB4YXR0cl9oYW5kbGVyICogY29uc3QgZnVzZV94YXR0cl9oYW5kbGVyc1tdID0gewor
CSZmdXNlX3hhdHRyX3VzZXJfaGFuZGxlciwKIAkmZnVzZV94YXR0cl9oYW5kbGVyLAogCU5VTEwK
IH07Cg==
--0000000000002b52010649e811e4--

