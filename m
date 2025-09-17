Return-Path: <linux-fsdevel+bounces-62004-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 792F8B819C1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 21:26:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C7593AA05E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 19:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1956B3054D1;
	Wed, 17 Sep 2025 19:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="APxIxzAu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4792FB0A3
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Sep 2025 19:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758137165; cv=none; b=GezEaH93caDznImuInx+TGnC9BJCDEEb16U4dWLuR54Fx83QDbNBuuN7/5nUUAWCNPGXutoYBfogXkHsukC8g3+U0MiNQJx51Se/IbLNAVT2FEBBW5GVtuze/g0gJId6/67/AZk4WFC/EhgCweFCRQaDcvC5FosbDJlo4AuP96g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758137165; c=relaxed/simple;
	bh=rnRQh1fgG/iBS/92Mk0NI/PnJazDMk7alTWmgTAbA0E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Uymi26DootIG0Y9xzTd9f4V+oZVKgJ1jCC81rZzS49opwMfatVW4k49G/78kTwdY4pU1QJLEeVPRlm4SQ+XPfT9R4mHFL0xPxznFPyrdrAcFdke2Q0iCCvnrnUi3PJjoQHPvzThDEwWam3eFsEp0/KdhmMpzw9SJWqh0dU68V+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=APxIxzAu; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b07883a5feeso31293966b.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Sep 2025 12:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1758137161; x=1758741961; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gM73047ejBdI07SXB7vIlmIGMpwYKQFcM4Zm+pCZ9bo=;
        b=APxIxzAurGpDGUBI9zQAJK7Hevf9cPrI/8seWcloFvTdDqPcFtINSys63QyTqYRytw
         qsQ27bAmXJnNIXnr9p5kxjRLoYQtve/qM1gtGnqTZrk9szQ+XGusBJBKBP3VmVEG8bHz
         KChjYmNLR+gBU+uLUO536WTol8mcBRN14NUY9MA0G7sN8ZSCBuu9uzgCq60eZWCAi68y
         Vv0YqhSvx96V/xy1YRlKrvr+MVOlkkBU6uLsu8HF1+z9u3tjgWFOSA8eT0IIwLpzlVH2
         tBmZJMPPntFbaxFbtRwa6snbS1PYw/yoviHWY+Ph/NsV7YypVtACtSgFxYZ2HI5P3Akk
         iCHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758137161; x=1758741961;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gM73047ejBdI07SXB7vIlmIGMpwYKQFcM4Zm+pCZ9bo=;
        b=rYy1zKxYDWfWhzA1eTJbWW9mXGe89TEENKuYTG9GV6c3XsqayYeV1wBylpfaCTGbNo
         z+hfzksnzsYbx/6SxlEOUbHISZcEp/hcEIkmof0yMTVZGUrajsdjGKbEIW0RmW2fWMNx
         EKQuJn3QMGmPepI5SluRO2koDvrJGC0pGrlATtXyw9I9Hu8l50apJMI5gI4O3ryskI4T
         /lnVO+kC164GnHngXEUYUVu/bfgTll5VzXpTiU2OmZWf7ctTgOlCl0IWFPpcx7kCNjlX
         ztHHn1idjAOH0TvMQs3UWvzGJjIyAnl7aGvk5G6XW292Cf7eSwQoUoGRWjm6OTSqvZTE
         fMRQ==
X-Forwarded-Encrypted: i=1; AJvYcCXXGfbNPbBkVKobQ3an5XgE6UWJkMM4Qxoev9QR/SFqlkLVMuVRxo8wCgSBoVS2OB71pgPPqjeQ9R2k1bXJ@vger.kernel.org
X-Gm-Message-State: AOJu0YxN9jp3jfqjgW/tCHKDn0Lf7/u59ATNhJJBJvb92RHMqUUuxvl/
	zT72E5Zi8OwFp6clB09Kd2ZnKb0Er98SMPJtdF2ZWGVMKWKTeQwh1Lqg9bW+lJ5nlOqw9lvNryq
	rwYzUcBrrQb8sQoEGv7SPxrjUo+vWS3R02Ij/FKZ+Sw==
X-Gm-Gg: ASbGncujKy9Quqng1aT6lSJmZjMtFFIHDznDQ4+1JfFQE1OebWW1rVu9CST7/gkhLem
	zRZigNfjGjJpn0kCoQFUgGkdmGITjgrO21C0Sg4WRJKT9BOBFoefWzEUlQBzvz1cIM4w8HcjieB
	KlXEzMbXl6oWD0qdBF8mnukIhg00QQsn9XzybFMewyN1hdiBVll0Q3AAxO4DF9JM8AXyAHbT40Q
	S0wPZq9yWXySvhs3qI5CoLeuLwvCMtexfAi
X-Google-Smtp-Source: AGHT+IHV+j4kzgnlA17vMPfFNZMuPAmy/0tGoISSJII60cK9xhE9rBFeexcHdz76p+ynPHs9naBObYA9aHQI2oTrR4o=
X-Received: by 2002:a17:907:944f:b0:b04:9468:4a21 with SMTP id
 a640c23a62f3a-b1bb739e7f5mr341249166b.14.1758137161567; Wed, 17 Sep 2025
 12:26:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250917135907.2218073-1-max.kellermann@ionos.com>
 <832b26f3004b404b0c4a4474a26a02a260c71528.camel@ibm.com> <CAKPOu+_xxLjTC6RyChmwn_tR-pATEDLMErkzqFjGwuALgMVK6g@mail.gmail.com>
 <3c36023271ed916f502d03e4e2e76da711c43ebf.camel@ibm.com>
In-Reply-To: <3c36023271ed916f502d03e4e2e76da711c43ebf.camel@ibm.com>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Wed, 17 Sep 2025 21:25:50 +0200
X-Gm-Features: AS18NWDOAnSLj0nw3kPAv4b-NSgo8QkEB21FLGzoG6YC2RFaOsN704wTATLg6Fg
Message-ID: <CAKPOu+8b_xOicarviAw_39b2y5ei9boRFNxxkP19zE5LGZxm=Q@mail.gmail.com>
Subject: Re: [PATCH v2] ceph: fix deadlock bugs by making iput() calls asynchronous
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: Xiubo Li <xiubli@redhat.com>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"netfs@lists.linux.dev" <netfs@lists.linux.dev>, Alex Markuze <amarkuze@redhat.com>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>, "idryomov@gmail.com" <idryomov@gmail.com>, 
	"mjguzik@gmail.com" <mjguzik@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 17, 2025 at 9:20=E2=80=AFPM Viacheslav Dubeyko
<Slava.Dubeyko@ibm.com> wrote:
> > > > +     WARN_ON_ONCE(!queue_work(ceph_inode_to_fs_client(inode)->inod=
e_wq,
> > > > +                              &ceph_inode(inode)->i_work));
> > >
> > > This function looks like ceph_queue_inode_work() [1]. Can we use
> > > ceph_queue_inode_work()?
> >
> > No, we can not, because that function adds an inode reference (instead
> > of donating the existing reference) and there's no way we can safely
> > get rid of it (even if we would accept paying the overhead of two
> > extra atomic operations).
>
> This function can call iput() too. Should we rework it, then? Also, as a =
result,
> we will have two similar functions. And it could be confusing.

No. NOT calling iput() is the whole point of my patch. Did you read
the patch description?

