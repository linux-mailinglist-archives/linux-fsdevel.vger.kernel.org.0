Return-Path: <linux-fsdevel+bounces-61986-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C83DBB816CC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 21:06:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FE3A1C26DF1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 19:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 794452C21F9;
	Wed, 17 Sep 2025 19:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="PTHfsjrf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD1925FA2D
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Sep 2025 19:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758135997; cv=none; b=ehk/CikQe3y6HvuyEALk9fiS3ttwzgsNONBMBTs5/dbSwcEXhmuVtbwxhTUPHxuRMNhwXy/kSRxJMh4FhF6fRxWmSeQbHaBQs9cVWr0LREkFCyfOwV8WL/XVDBxB9kqg62/Ovk/YO76JbLpcdGtyOctoUK7u5WAORj/1sNfUpbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758135997; c=relaxed/simple;
	bh=qZtcZTnWxUnymv6cAIxmqQfBFbRdLOm34vdUr0A1Em8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G+TP9VjlDUDLWNmPe7BniVSfQch86uEHFPJzi1Vga3mZmh6+v0XDmkz/YHLV0q4tEdhfkIJzTkZTxdNFgeUoQYQKyb5wEhwIqlg62lSRd2S8ijBc7hoL8JkKxs+8/62rBpds+OHnIJITmP9FepK+LI7+eYuIPnZK0ZJhcVpgx0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=PTHfsjrf; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b07c081660aso27577266b.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Sep 2025 12:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1758135994; x=1758740794; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WjAKk6dDrc+RS53N4L4L2Jhabpo688uVi5jmIwo6nKw=;
        b=PTHfsjrfyhcQnQLsWb5SBhCmL/MwmqOCnlntj1nspqEudKf4VMuQ2S2wks60O/dTm2
         CDN/3ao14fIyx6fTEACZ+Hjo/2wYmSc9oBR8OvBQfIFrpHJh74YJugnpk1T5ZoODEAeH
         C79z1AwtaRJt5j8dE4UIhhm/kzT9AJZer62gdSUAqTaLoNGJON8GRyKNRomKpdq+r9r2
         JT8cAyhn6IAI1GB0jOEbDhV8KR8ZH9RvYdw3xgiqHsANQ8kaLSIFVeJtOfldNcl1URKR
         YWI/WWY8X9/1w0Cxhot9uqbdiJq512soJ7PXQKqQZdeM+pAmepHCy1HaN8ScLTxwbKvf
         CAaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758135994; x=1758740794;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WjAKk6dDrc+RS53N4L4L2Jhabpo688uVi5jmIwo6nKw=;
        b=dVRwBj0kncLk7I2fCYgDndmtUm2/9aRIIwb9+es8B5Z+vqoyVUBJnjaQm+nUedSMqc
         w9efkX7G4HRStDbEN2qvEiSsLW6C+iokQ9ItuXfZDoZ3gKt5TSIJBA4H9vv5Re5taSck
         NDiOESqrXubh6TyYuVc7mVql7FECWj5s/t56jOhQG5rQcd6OwGD8VMJ/pq4vqIYmjSZi
         1nsVlWnJipf0frxNRY3nO7vEWZirKVtHaPb/Ivt3GQF/LNAGme3fKkWzI51bAY5x0E5d
         NU+1PIWcE9AXzURe/KUMyYWqy0I+3hOtb4x+dNRQOepN5shTYSr9IpGTarwwWUQc4M1x
         bIug==
X-Forwarded-Encrypted: i=1; AJvYcCU5Pk5K3Z5kiTlu671Na+cndMZEpnGBgxMq2Nlk3KnZftcpo/ihTuXL4Oz4RBkwkkNjA80cbJjvPNyF0O0X@vger.kernel.org
X-Gm-Message-State: AOJu0YzdcSTJ8OtpT3IKbV2eXGUIMUy5WFMCwkFfA7dibTWVzhCXxdQR
	hdnMQjE1ZKSCvMmxofC7022y+8TP06GjjdtwAdHZUxp79wivAGSvoAPEblvdd76nRviv1ERGoAe
	L7DgYL+MfWScQyY068YfHyCOEEDU5oIQ0o0BN6UZ1YA==
X-Gm-Gg: ASbGncsiPi76wnc9kLtJXZ5C3l1s1jUmWhgay2wIFphsZxFkR9I7AWOCHq2sEIi8cJZ
	WNgw5BtjMwFP5+IHXg29sleopmRvnlzoFrb/CK/XOWV4hgedGYFU4N/mwMZYuEppQHgf8krtpXW
	/8yjtnw22UhI09uF/Z8JUNsf1qKiqQkXCQ24HYo054coOtlNxrAEBFAWlLYscDfCiza0gF/nFRu
	oCMWrvuC+FaLD+k+Tt6++Ux1rtdyswUF2g7P9Oi2feB5Pk=
X-Google-Smtp-Source: AGHT+IEeoKIGF0DJUkr9LeE+86k79ccZaCCG4KjCllo1uxTbF5z8DSBt0gp58w9mSuOWqhXnNBwuDlyHfOioj70SCBs=
X-Received: by 2002:a17:907:969e:b0:b04:85f2:d26f with SMTP id
 a640c23a62f3a-b1bb73a737bmr455871666b.25.1758135993911; Wed, 17 Sep 2025
 12:06:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250917135907.2218073-1-max.kellermann@ionos.com> <832b26f3004b404b0c4a4474a26a02a260c71528.camel@ibm.com>
In-Reply-To: <832b26f3004b404b0c4a4474a26a02a260c71528.camel@ibm.com>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Wed, 17 Sep 2025 21:06:22 +0200
X-Gm-Features: AS18NWAgiPxioh1hBxBItSQjz6PB8OC4EFRxWlPBDaP02Mv4xKOQfrE0EdtFsAM
Message-ID: <CAKPOu+_xxLjTC6RyChmwn_tR-pATEDLMErkzqFjGwuALgMVK6g@mail.gmail.com>
Subject: Re: [PATCH v2] ceph: fix deadlock bugs by making iput() calls asynchronous
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Xiubo Li <xiubli@redhat.com>, 
	"idryomov@gmail.com" <idryomov@gmail.com>, "netfs@lists.linux.dev" <netfs@lists.linux.dev>, 
	Alex Markuze <amarkuze@redhat.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "mjguzik@gmail.com" <mjguzik@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 17, 2025 at 7:55=E2=80=AFPM Viacheslav Dubeyko
<Slava.Dubeyko@ibm.com> wrote:
> > +     doutc(ceph_inode_to_fs_client(inode)->client, "%p %llx.%llx\n", i=
node, ceph_vinop(inode));
>
> What's about this?
>
> struct ceph_fs_client *fsc =3D ceph_inode_to_fs_client(inode);
>
> doutc(fsc, "%p %llx.%llx\n", inode, ceph_vinop(inode));

That means I have to declare this variable at the beginning of the
function because the kernel unfortunately still doesn't allow C99
rules (declare variables where they are used). And that means paying
the overhead for chasing 3 layers of pointers for all callers, even
those 99.99% who return early. Or declare the variable but initialize
it later in an extra line. Is that the preferred coding style?

> > +     WARN_ON_ONCE(!queue_work(ceph_inode_to_fs_client(inode)->inode_wq=
,
> > +                              &ceph_inode(inode)->i_work));
>
> This function looks like ceph_queue_inode_work() [1]. Can we use
> ceph_queue_inode_work()?

No, we can not, because that function adds an inode reference (instead
of donating the existing reference) and there's no way we can safely
get rid of it (even if we would accept paying the overhead of two
extra atomic operations).

> Do you imply "if i_work were already"?

Yes, it's a typo.

