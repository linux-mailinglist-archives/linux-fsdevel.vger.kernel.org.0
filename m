Return-Path: <linux-fsdevel+bounces-75801-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sGwSOrl5emkC7AEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75801-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 22:03:53 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B34BA8E86
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 22:03:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A76803033FA6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 21:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE726374181;
	Wed, 28 Jan 2026 21:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GGul76YC";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="WDH+xoRS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CDB92F2607
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jan 2026 21:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769634208; cv=pass; b=fVF8spsAys0fWJYKkbODANa66TUi3RAGvathtE7gZG70Rqi+fD8F6P1gTZoGIgStrQfRTlF2SEpEaLnQY9OiUuCKtuW9Vu2248e4pAlzcjCDbedKXNH2Mwn+YxXWlK1kCELn2E7Oz/MQKbfrB9u+k4qKLZ0y7Z/rSVRJyMyHWYs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769634208; c=relaxed/simple;
	bh=efaf3C2hShtFbTdeBwhbV1apj9j+3ZDJPwz0ThYGHbQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eTjpdckrDQ66oVyrhjBF9F7P6RLZOMTRa8IHawaFxCxJpqEXvv/A1b5bTSwCG7k3LAqlb9ZzPUN/VN/ymEj18MDv3oKHv3kabLOnlCc6mTlJEH9El1ccliSCx8ilXgXAsmWRJZMN3pDjGJOeTDP4I/hGL9hZD4FRhVnfQFu3dBI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GGul76YC; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=WDH+xoRS; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769634206;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wuSIWIwcsqjgApkRmTO7tQttR8ukmFwJ5UsZf67dS+0=;
	b=GGul76YCtcXhSsGUjSR9wQ+F4CQh9fqyH0ltU5nZ5QRVG5AKW8lXOgIk2BpoShuKf6/etm
	kv4vYIuJoXmE+BMPMuAWN5W+VlswETy3FP7EA2Zt5QkIXk66vicLucNpOvPNNlBPc6F20l
	hjvYTJU2uMz8r+ZcvNj+Dd+L4Qb+3R8=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-102-OSCLuc68Nr-fMZbVQirvgQ-1; Wed, 28 Jan 2026 16:03:20 -0500
X-MC-Unique: OSCLuc68Nr-fMZbVQirvgQ-1
X-Mimecast-MFC-AGG-ID: OSCLuc68Nr-fMZbVQirvgQ_1769634199
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-894709fbae5so9966076d6.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jan 2026 13:03:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769634199; cv=none;
        d=google.com; s=arc-20240605;
        b=JJpfQZOI/tYSPKDE4LQBKqJzGd3EQDV5Jtlpbp+jKbjowQZLwsNaqqTqK8pBuqjKYN
         svBlfKZUUZMbTmqAI59P25RUba+3BuxzgtngHK50xQcsiDSrJYls/7bC5d5l2q56vP0K
         kgrXMivLr9xMi+d0jaCvbySlef0gS26+AGGoOohtdqqqTWGHq2BQ2mODJy63M1W85ckm
         zYV18PTEfBjndXJguGBzJSSpDQq2zfvVXcIO96scDJZU5p01achF1u0YB6H6xlWCwTgl
         5leBcxo077/mEEc1yyEn6l5qC1QmBnOk7pwl9uYSbv3QnVj1KOUevqrrHU2ZqoJSjqMV
         05Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wuSIWIwcsqjgApkRmTO7tQttR8ukmFwJ5UsZf67dS+0=;
        fh=cG/T0ZGmSEpkD+rg+IUxHQ659NDQGlPNi3bsCrVnxUg=;
        b=JWiEH1QcNeXdYBCQYHuJoDkYXImJrWR9rsbU1LBDuLq7aDhC4xOr3Joq6wB3uOux0Q
         jbgrnvv2Z1L+j/frngjsYvj5Qi5BH3CGDwLL+p8hMbnBrmCfp/H4f7pwpbe83u9vgx2n
         xqw9hp8lHbkVq9vhsuBbFHJ5oMKOWnuSdoslgfvulPdsEhtCTQF4JzyYdbL93Ln9iLD2
         5yfVPCWvZq1XhlQVVgEMMeVQnQ0R6FeEOIfgBBhaUnmVOTp4Lr07SW1OrmOhpRXNBdaG
         3v3pZ6esODziqyEtBwcHpz7158HQyJZjO6b6uAFNDr/SDAkAhaU6MeYVLMuMY3gUt7lu
         XhiA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1769634199; x=1770238999; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wuSIWIwcsqjgApkRmTO7tQttR8ukmFwJ5UsZf67dS+0=;
        b=WDH+xoRSXNJabIEUxZNDQgLFxZ8u5vH+Wd1ZP+zVOhkdhhuXb/+xp3B78CkWb4vbRn
         ZHKss+d8whs6thAuqJ8UoX58YTd/vn9NJ0z31Un6wXX9XdYTYAiScdJAtSJA4j6hUh7+
         u4YD3Zl83j34gFW1AbMkFtkuIvUOAAgmZ3Svr4ufhn6zMCFCmwRDZD4idhEAxSY+j3IA
         88WMd5w2PAMuJjFAubUFLM9Cm8ACnN0RNrGkRoINj5SKaCauwd+7vU13IPrm9DSSdXHh
         d2e59vTT6b5ZIfK4IhDSTVTWmpAfglRXTT3GsxaIgy4xNpSjaD1xGGnk7s6R52k2I9px
         AiSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769634199; x=1770238999;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wuSIWIwcsqjgApkRmTO7tQttR8ukmFwJ5UsZf67dS+0=;
        b=rJoXFyfgICyw2TDfOioLKGmumXYrDjJCVERDsNubdQPaEMtfveJ+7IxayDC79A3vPz
         BuJqplzl0CRzeCI2b3yTclcqwnqjulYnfFQgnZPQQUTLebfp0zy3urYK6A/V8ZA/EUdn
         9+bko4vvOUdFWhjbfiD9WsMEOmeNvHdaTkE0Oc0MVuVO/JhWmltYJfKfIh+RBDUzTBNC
         iLGdCr6FBBLt8BNS6BQobf0vARpqLr6ztXCN3+P/NMHnVWG03b5LxpgPaR6dnGpY68Xg
         3N4/0dOu9TevToSdBDn1Wo4CZ8Teus0aF4BskaLc5a377VIuHzP7h4Yu+3bmYGCdd0V0
         nPhg==
X-Forwarded-Encrypted: i=1; AJvYcCWVal4aZ1zWROU6k7Ut/cXcrUEWuNbOJScJThEjZWHBtUe+ky/bP7P/qlf05K7JoClLvypJ4vJ0DjeQqNQN@vger.kernel.org
X-Gm-Message-State: AOJu0YzXDDNfiYNwz9NUig1s4EW2tdcsChOtnY2EXAuJkaRMSG++fkro
	oD0+0Hix8b7PRvvER9TeNy8pK/muXNBD4ppadc1FgXV/FsluKjoeoBiJG3XZqUXJwrjw3RhRULA
	E9F2rYr6HrsH/yqgUskM2ncqQhLOgbC1KgsLVQ1s3z1IO7QJJ6QoqTCfg7WCRqGyZDZ5U+DFSTM
	/mINviETriDsPDNp/pSRzop88HKcZ84w2RmLWmKhF4nw==
X-Gm-Gg: AZuq6aJRUisOd8h9Fo1keRSnXYn+ZPPK6llpZkIQfdU5j7Jl7HKvh4it3qyxkhJtTTE
	DfF9KbcBEjAazU02xLQJ9JWG4smWPPzJjs6w7ZqGanD9bl0qKDy89wchsUf11cebpcgAQWYgqiT
	3yPZ119ag8nGmzc4xgv18RBqA2c91w0gL8+rVnEk176AGdYo77YbTmRg/ziqiFvWX/nafVGaL5L
	l5tnGUsSkXLNT8B3iE/cwa7mA==
X-Received: by 2002:ac8:5fd3:0:b0:501:4e7f:fcfb with SMTP id d75a77b69052e-5032f8d9a43mr77513421cf.42.1769634199412;
        Wed, 28 Jan 2026 13:03:19 -0800 (PST)
X-Received: by 2002:ac8:5fd3:0:b0:501:4e7f:fcfb with SMTP id
 d75a77b69052e-5032f8d9a43mr77512961cf.42.1769634199035; Wed, 28 Jan 2026
 13:03:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260114195524.1025067-2-slava@dubeyko.com> <CA+2bHPb66HKDZ2DX7TvzvfjW_Ym1TBeVNcPn9w_tnwytje85Nw@mail.gmail.com>
 <CAOi1vP-G_0vPyMOyx6HvJX7VwN8_9FCe9V4Vg9zvg8gbbJNNHw@mail.gmail.com>
 <CA+2bHPapiqj4xEobqcxmW6b1YChMLBBKaVzxdbEMw+DDZEG1NQ@mail.gmail.com> <408b497e5c20549882dbe34b40adcd13b0a5df11.camel@redhat.com>
In-Reply-To: <408b497e5c20549882dbe34b40adcd13b0a5df11.camel@redhat.com>
From: Patrick Donnelly <pdonnell@redhat.com>
Date: Wed, 28 Jan 2026 16:02:52 -0500
X-Gm-Features: AZwV_Qg3221sHh9KIWXdQ6dd65dyypKxSFKvDdY8AJ_tANL9DjzAX4V1UFOvC9g
Message-ID: <CA+2bHPbRD9gZyH4w18-VshWCGn5MBe1gi0-0fmAnaDMUYjXA5w@mail.gmail.com>
Subject: Re: [PATCH v5] ceph: fix kernel crash in ceph_open()
To: Viacheslav Dubeyko <vdubeyko@redhat.com>
Cc: Ilya Dryomov <idryomov@gmail.com>, Viacheslav Dubeyko <slava@dubeyko.com>, ceph-devel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, amarkuze@redhat.com, khiremat@redhat.com, 
	Pavan.Rallabhandi@ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,dubeyko.com,vger.kernel.org,redhat.com,ibm.com];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	TAGGED_FROM(0.00)[bounces-75801-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pdonnell@redhat.com,linux-fsdevel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 8B34BA8E86
X-Rspamd-Action: no action

On Wed, Jan 28, 2026 at 3:20=E2=80=AFPM Viacheslav Dubeyko <vdubeyko@redhat=
.com> wrote:
>
> On Wed, 2026-01-28 at 12:16 -0500, Patrick Donnelly wrote:
> > On Mon, Jan 26, 2026 at 8:02=E2=80=AFAM Ilya Dryomov <idryomov@gmail.co=
m> wrote:
> > > Hi Patrick,
> > >
> > > Has your
> > >
> > >     > > I think we agreed that the "*" wildcard should have _no_ spec=
ial
> > >     > > meaning as a glob for fsopt->mds_namespace?
> > >     >
> > >     > Frankly speaking, I don't quite follow to your point. What do
> > > you mean here? :)
> > >
> > >     --mds_namespace=3D* is invalid.
> > >
> > >     vs.
> > >
> > >     And mds auth cap: mds 'allow rw fsname=3D*'  IS valid.
> > >
> > > stance [1] changed?  I want to double check because I see your
> > > Reviewed-by, but this patch _does_ apply the special meaning to "*" f=
or
> > > fsopt->mds_namespace by virtue of having namespace_equals() just
> > > forward to ceph_namespace_match() which is used for the MDS auth cap.
> > > As a result, all checks (including the one in ceph_mdsc_handle_fsmap(=
)
> > > which is responsible for filtering filesystems on mount) do the MDS
> > > auth cap thing and "-o mds_namespace=3D*" would mount the filesystem =
that
> > > happens to be first on the list instead of failing with ENOENT.
> > >
> > > [1] https://lore.kernel.org/ceph-devel/CA+2bHPYqT8iMJrSDiO=3Dm-dAvmWd=
3j+co6Sq0gZ+421p8KYMEnQ@mail.gmail.com/
> >
> > Sigh, yes this is still a problem. Slava, `--mds_namespace=3D*` should
> > not be treated as a glob.
>
> OK. So, what's the modification the patch finally requires?

It needs to be restructured so that CEPH_NAMESPACE_WILDCARD is only
treated specially (i.e. not literally) for MDS auth caps.

--=20
Patrick Donnelly, Ph.D.
He / Him / His
Red Hat Partner Engineer
IBM, Inc.
GPG: 19F28A586F808C2402351B93C3301A3E258DD79D


